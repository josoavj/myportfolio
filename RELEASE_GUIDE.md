# 📱 Guide de Release - MyPortfolio

## 🚀 Utilisation du script de release

Le script `release.sh` automatise tout le processus de génération, compilation et publication de l'APK.

### Syntaxe basique
```bash
./release.sh [version] [message]
```

### Exemples

**Release simple avec version par défaut (1.0.0):**
```bash
./release.sh
```

**Release avec version personnalisée:**
```bash
./release.sh 1.0.1
```

**Release avec version et message personnalisés:**
```bash
./release.sh 1.0.1 "Corrections de bugs et améliorations de performance"
```

**Release avec message multi-ligne:**
```bash
./release.sh 2.0.0 "Nouvelle interface
- Refactoring complet du code
- Performance améliorée de 30%
- 5 nouveaux bugs corrigés"
```

## 📋 Ce que fait le script

Le script automatise ces 10 étapes :

1. ✅ **Nettoyage** - Supprime les anciens builds
2. ✅ **Dépendances** - Installe les packages Flutter
3. ✅ **Build APK** - Compile en mode release avec obfuscation
4. ✅ **Préparation** - Crée le dossier `releases/`
5. ✅ **Copie** - Place l'APK dans le dossier releases
6. ✅ **Info** - Génère un fichier README pour la release
7. ✅ **Staging Git** - Prépare les fichiers à committer
8. ✅ **Commit** - Crée un commit avec tous les détails
9. ✅ **Tag Git** - Crée un tag pour la version
10. ✅ **Push** - Envoie tout vers GitHub

## 📂 Structure des releases

Après l'exécution, tu auras :
```
releases/
├── myportfolio-v1.0.0.apk      # L'APK release
├── myportfolio-v1.0.1.apk      # Versions suivantes
├── RELEASE-1.0.0.md            # Infos de la release
├── RELEASE-1.0.1.md            # Infos des versions
└── ...
```

## 🔗 Sur GitHub

Après avoir exécuté le script, tes releases seront visibles sur GitHub:
1. Va sur `github.com/josoavj/myportfolio`
2. Clique sur **Releases**
3. Tu verras les tags créés avec les APK attachés

## 💡 Astuces

### Corriger un commit avant de pousser
```bash
# Si tu as fait une erreur avant le push
git reset HEAD~1          # Annule le commit
git reset                 # Unstage les fichiers
```

### Supprimer un tag local
```bash
git tag -d v1.0.0
```

### Supprimer un tag sur GitHub
```bash
git push origin --delete v1.0.0
```

### Voir l'historique des releases
```bash
git tag -l              # Liste tous les tags
git log --oneline       # Historique des commits
```

## 🔐 Avant la première utilisation

Assure-toi que:
1. ✅ Git est configuré avec ton pseudo GitHub
2. ✅ Tu as les permissions push sur le repo
3. ✅ Tu es sur la branche correcte (`git branch`)
4. ✅ Ton code est committé et pushé

## 📦 Distribuer l'APK

L'APK peut être distribué via:
- **GitHub Releases** - Directement accessible depuis le repo
- **Email/WhatsApp** - Partage le fichier `releases/myportfolio-vX.X.X.apk`
- **Firebase Distribution** - Pour les testeurs beta
- **Google Play Store** - Pour la publication officielle

## ❓ Troubleshooting

**Erreur: "pubspec.yaml not found"**
- Assure-toi d'exécuter le script depuis la racine du projet

**Erreur: "APK not generated"**
- Vérifie que Flutter est installé: `flutter --version`
- Essaye de build manuellement: `flutter build apk --release`

**Erreur: "Permission denied"**
- Rends le script exécutable: `chmod +x release.sh`

**Erreur Git: "No commits yet"**
- Effectue au moins un commit dans le repo

## 📞 Support

Pour toute question, consulte:
- [Flutter Documentation](https://flutter.dev/docs)
- [Git Documentation](https://git-scm.com/doc)
- [GitHub Releases Guide](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases)

---

**Bon courage avec tes releases! 🎉**
