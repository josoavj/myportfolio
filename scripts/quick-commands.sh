#!/bin/bash

# 📱 Commandes rapides pour les releases MyPortfolio

# =================================================================
# 🚀 RELEASE RAPIDE - EXÉCUTE TOUT AUTOMATIQUEMENT
# =================================================================

# Release avec version par défaut (1.0.0)
alias release-quick="./release.sh"

# Release avec version spécifique
# Exemple: release-version 1.0.1
release-version() {
    ./release.sh "$1"
}

# Release avec version et message
# Exemple: release-full 1.0.1 "Corrections de bugs"
release-full() {
    ./release.sh "$1" "$2"
}

# =================================================================
# 📊 INFORMATIONS - VER LES STATUS ET VERSIONS
# =================================================================

# Voir toutes les versions/tags
show-releases() {
    echo "📦 Releases disponibles:"
    git tag -l | sort -V
}

# Voir le dernier commit
show-latest-commit() {
    echo "📝 Dernier commit:"
    git log -1 --oneline
}

# Voir le status du repo
repo-status() {
    echo "📊 Status du repository:"
    git status
}

# =================================================================
# 🔧 UTILITAIRES - OUTILS DE MAINTENANCE
# =================================================================

# Nettoyer les builds locaux
clean-build() {
    echo "🧹 Nettoyage des builds..."
    flutter clean
    rm -rf build/
    echo "✓ Build nettoyé"
}

# Générer juste l'APK sans commit
build-apk-only() {
    echo "📦 Construction de l'APK..."
    flutter clean
    flutter pub get
    flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/symbols
    ls -lh build/app/outputs/flutter-apk/app-release.apk
}

# Voir la taille de l'APK
apk-size() {
    APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
    if [ -f "$APK_PATH" ]; then
        du -h "$APK_PATH"
    else
        echo "❌ APK non trouvé. Génère d'abord avec: build-apk-only"
    fi
}

# =================================================================
# 🔄 GIT - COMMANDES GIT COURANTES
# =================================================================

# Push rapide sur la branche actuelle
git-push() {
    git push origin HEAD
}

# Voir l'historique formaté
git-log() {
    git log --oneline -20
}

# Annuler le dernier commit (avant push)
git-undo-last() {
    git reset HEAD~1
    echo "✓ Dernier commit annulé"
}

# Voir les branches
git-branches() {
    git branch -a
}

# =================================================================
# 📱 APK - GESTION DES APK
# =================================================================

# Copier l'APK vers le dossier releases avec version
copy-apk() {
    VERSION=${1:-"1.0.0"}
    mkdir -p releases
    cp build/app/outputs/flutter-apk/app-release.apk "releases/myportfolio-v${VERSION}.apk"
    echo "✓ APK copié vers releases/myportfolio-v${VERSION}.apk"
}

# Lister les APK disponibles
list-apks() {
    echo "📦 APK générés:"
    ls -lh releases/myportfolio-*.apk 2>/dev/null || echo "Aucun APK trouvé"
    echo ""
    echo "📦 APK courant:"
    ls -lh build/app/outputs/flutter-apk/app-release.apk 2>/dev/null || echo "Aucun APK courant"
}

# Installer l'APK sur le device/émulateur
install-apk() {
    APK="${1:-build/app/outputs/flutter-apk/app-release.apk}"
    if [ -f "$APK" ]; then
        echo "📱 Installation de $APK..."
        adb install -r "$APK"
    else
        echo "❌ APK non trouvé: $APK"
    fi
}

# =================================================================
# 🎯 WORKFLOW COMPLET - TOUTES LES ÉTAPES
# =================================================================

# Workflow simple: build → test → release
workflow() {
    VERSION=${1:-"1.0.0"}
    echo "🔄 Workflow complet pour version $VERSION"
    echo ""
    echo "1️⃣  Nettoyage..."
    flutter clean
    echo ""
    echo "2️⃣  Installation des dépendances..."
    flutter pub get
    echo ""
    echo "3️⃣  Tests d'analyse..."
    flutter analyze
    echo ""
    echo "4️⃣  Construction APK..."
    flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/symbols
    echo ""
    echo "5️⃣  Release..."
    ./release.sh "$VERSION"
}

# =================================================================
# 📋 AIDE ET INFO
# =================================================================

show-help() {
    cat << 'EOF'

🚀 COMMANDES DE RELEASE - MyPortfolio
────────────────────────────────────────────────────────────────

📱 RELEASE RAPIDE
  release-quick              → Release avec version par défaut (1.0.0)
  release-version 1.0.1      → Release avec version spécifique
  release-full 1.0.1 "Msg"   → Release avec version et message

📊 INFORMATIONS
  show-releases              → Lister toutes les versions
  show-latest-commit         → Voir le dernier commit
  repo-status                → Voir le status du repo

🔧 UTILITAIRES
  clean-build                → Nettoyer les builds locaux
  build-apk-only             → Générer juste l'APK
  apk-size                   → Voir la taille de l'APK

🔄 GIT
  git-push                   → Push rapide
  git-log                    → Voir l'historique
  git-undo-last              → Annuler le dernier commit
  git-branches               → Voir les branches

📱 APK
  copy-apk 1.0.1             → Copier APK vers releases/
  list-apks                  → Lister les APK disponibles
  install-apk                → Installer l'APK sur device

🎯 WORKFLOW
  workflow 1.0.1             → Workflow complet: build → test → release

📋 AIDE
  show-help                  → Affiche cette aide

────────────────────────────────────────────────────────────────

EXEMPLES:
  ./release.sh                       # Release simple
  ./release.sh 1.0.1                 # Release v1.0.1
  ./release.sh 1.0.1 "Bug fixes"     # Release avec message
  workflow 1.0.1                     # Workflow complet

EOF
}

# Afficher l'aide au chargement du script
show-help
