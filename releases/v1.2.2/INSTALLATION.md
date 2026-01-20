# Installation Guide - MyPortfolio v1.2.2

## 📱 Android Installation

### Fichiers Disponibles
- **myportfolio-v1.2.2.apk** - Application Android Release (50MB)
- **myportfolio-v1.2.2.apk.sha256** - Checksum pour vérification

### Vérification d'Intégrité

Avant l'installation, vérifiez l'intégrité du fichier APK :

```bash
# Vérifier avec sha256sum
sha256sum -c myportfolio-v1.2.2.apk.sha256

# Résultat attendu:
# myportfolio-v1.2.2.apk: OK
```

**Checksum SHA256:**
```
42af02c80454a1c51bc49715ef84cf437f6ef5d163a7c7d95e888beeb8f9ac2e
```

### Installation sur Android

#### Méthode 1: Installation Directe (Recommandée)
1. Télécharger `myportfolio-v1.2.2.apk` sur votre appareil Android
2. Ouvrir l'explorateur de fichiers
3. Naviguer vers le fichier téléchargé
4. Appuyer sur le fichier `.apk`
5. Autoriser l'installation depuis des sources inconnues (si demandé)
6. Appuyer sur "Installer"

#### Méthode 2: Utiliser ADB (Android Debug Bridge)
```bash
# Connecter votre appareil via USB
adb connect <device_ip>

# Installer l'APK
adb install -r myportfolio-v1.2.2.apk

# Résultat attendu:
# Success
```

#### Méthode 3: Via Explorateur Fichiers
1. Placer le fichier `.apk` sur la carte SD
2. Ouvrir le gestionnaire de fichiers Android
3. Naviguer vers le fichier
4. Appuyer pour installer

### Prérequis
- Android 5.0 (API niveau 21) ou supérieur
- 100MB d'espace libre
- Permissions d'installation depuis sources inconnues (si nécessaire)

### Dépannage

**Erreur "L'installation a échoué"**
- Assurez-vous que la source inconnue est activée
- Vérifiez l'espace libre sur l'appareil
- Essayez de désinstaller l'ancienne version d'abord

**L'application se ferme au démarrage**
- Redémarrez l'appareil
- Vérifiez l'intégrité du fichier APK (SHA256)
- Réinstallez l'application

**Espace insuffisant**
- Libérez de l'espace en supprimant des fichiers inutiles
- L'installation nécessite au moins 100MB

## 🖥️ Autres Plateformes

### Web
```bash
flutter build web
# Fichiers compilés dans: build/web/
```

### iOS
```bash
flutter build ios --release
```

### Windows
```bash
flutter build windows --release
# Exécutable dans: build/windows/runner/Release/
```

### Linux
```bash
flutter build linux --release
# Exécutable dans: build/linux/x64/release/bundle/
```

### macOS
```bash
flutter build macos --release
```

## 📋 Spécifications de l'APK

- **Nom**: myportfolio-v1.2.2.apk
- **Taille**: 50 MB
- **Format**: Android Package (.apk)
- **Architecture**: arm64-v8a, armeabi-v7a
- **SDK Min**: Android 5.0 (API 21)
- **SDK Target**: Android 13+ (API 33+)
- **Signature**: Release signed

## ✨ Nouvelles Fonctionnalités v1.2.2

- ✅ Portfolio mis à jour avec données GitHub actuelles
- ✅ 7 projets avec stars actuels
- ✅ Section expérience améliorée
- ✅ Bio synchronisée avec GitHub
- ✅ Titre professionnel enrichi
- ✅ 43 repositories publics documentés

## 🔒 Sécurité

- L'APK est signé avec la clé de release
- Checksum SHA256 fourni pour vérification
- Code source disponible sur GitHub

## 📞 Support

Pour toute question ou problème :
- GitHub Issues: https://github.com/josoavj/myportfolio/issues
- Email: josoavonjiniaina13@gmail.com

## 📄 Informations Additionnelles

- **Version**: 1.2.2+4
- **Build Number**: 4
- **Date de Release**: 20 Janvier 2026
- **License**: MIT

---

**Merci d'utiliser MyPortfolio!** 🎉
