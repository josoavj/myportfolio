#!/usr/bin/env python3
"""Restaure les glyphes Font Awesome après `flutter build web --tree-shake-icons`.

Pourquoi : avec font_awesome_flutter 11, le tree-shaker de Flutter retire du build
certains glyphes réellement utilisés (icônes de catégorie des projets). Ce script :
  1. liste les `FontAwesomeIcons.xxx` utilisés dans lib/,
  2. retrouve leur code Unicode dans le package font_awesome_flutter,
  3. regénère les polices Font Awesome du build avec exactement ces glyphes.

Les polices Material et Cupertino restent gérées par le tree-shaking de Flutter.

Usage (depuis la racine du projet, après le build) :
    python3 scripts/restore_fa_glyphs.py build/web
Prérequis : pip install fonttools
"""
import argparse
import json
import re
import sys
from pathlib import Path
from urllib.parse import unquote, urlparse

from fontTools import subset

# Fragment du nom de fichier propre à chaque famille
# (« Brands-Regular » contient aussi « Regular », d'où « Free-Regular »).
FAMILY_TO_FILE_HINT = {
    "FontAwesomeSolid": "Free-Solid",
    "FontAwesomeRegular": "Free-Regular",
    "FontAwesomeBrands": "Brands",
}


def find_package_root(project: Path) -> Path:
    cfg = project / ".dart_tool" / "package_config.json"
    data = json.loads(cfg.read_text(encoding="utf-8"))
    for pkg in data["packages"]:
        if pkg["name"] == "font_awesome_flutter":
            uri = pkg["rootUri"]
            if uri.startswith("file:"):
                return Path(unquote(urlparse(uri).path))
            return (cfg.parent / uri).resolve()
    sys.exit("font_awesome_flutter introuvable dans package_config.json")


def used_icon_names(lib: Path) -> set:
    names = set()
    for f in lib.rglob("*.dart"):
        names |= set(re.findall(r"FontAwesomeIcons\.(\w+)", f.read_text(encoding="utf-8")))
    return names


def parse_icons(fa_source: Path):
    text = fa_source.read_text(encoding="utf-8")
    direct = {
        m.group(1): (int(m.group(2), 16), m.group(3))
        for m in re.finditer(
            r"static const FaIconData (\w+) = FaIconData\(\s*IconData\(\s*0x([0-9a-fA-F]+),\s*"
            r"fontFamily: '(\w+)'",
            text,
        )
    }
    aliases = dict(re.findall(r"static const FaIconData (\w+) = (\w+);", text))
    return direct, aliases


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("build_dir", help="dossier du build Web (ex. build/web)")
    ap.add_argument("--project", default=".", help="racine du projet Flutter")
    ap.add_argument("--package-root", help="racine du package font_awesome_flutter (auto sinon)")
    args = ap.parse_args()

    project = Path(args.project).resolve()
    build = Path(args.build_dir).resolve()
    pkg_root = Path(args.package_root) if args.package_root else find_package_root(project)
    direct, aliases = parse_icons(pkg_root / "lib" / "font_awesome_flutter.dart")

    wanted = {fam: {0x20} for fam in FAMILY_TO_FILE_HINT}
    missing = []
    for name in sorted(used_icon_names(project / "lib")):
        target = name
        while target not in direct and target in aliases:
            target = aliases[target]
        if target not in direct:
            missing.append(name)
            continue
        code, family = direct[target]
        wanted[family].add(code)

    if missing:
        print("Icônes ignorées (non trouvées dans le package) :", ", ".join(missing))

    src_dir = pkg_root / "lib" / "fonts"
    out_dir = build / "assets" / "packages" / "font_awesome_flutter" / "lib" / "fonts"
    if not out_dir.is_dir():
        sys.exit(f"Dossier de polices introuvable : {out_dir}")

    for family, hint in FAMILY_TO_FILE_HINT.items():
        srcs = [p for p in src_dir.glob("*.otf") if hint in p.name]
        dsts = [p for p in out_dir.glob("*.otf") if hint in p.name]
        if not srcs or not dsts:
            continue
        opts = subset.Options()
        opts.layout_features = ["*"]
        opts.notdef_outline = True
        font = subset.load_font(str(srcs[0]), opts)
        subsetter = subset.Subsetter(opts)
        subsetter.populate(unicodes=sorted(wanted[family]))
        subsetter.subset(font)
        subset.save_font(font, str(dsts[0]), opts)
        print(f"{dsts[0].name}: {len(wanted[family]) - 1} glyphes, {dsts[0].stat().st_size} octets")


if __name__ == "__main__":
    main()
