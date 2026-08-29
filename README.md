# Portfolio App

Un portfolio  moderne présentant mes compétences et mon parcours en tant que développeur fullstack mobile, développeur backend et les différents postes occupés.

## À propos

Ceci est un projet multiplateforme développé avec **Flutter** et **Dart**, offrant une interface intuitive et responsive pour explorer un portfolio professionnel. L'application est disponible sur plusieurs plateformes : Android, Web, Windows et Linux.

## Stack Technique

- **Framework** : Flutter
- **Langage** : Dart
- **Plateforme de déploiement** : Multi-plateforme (Mobile, Web, Desktop)
- **Langages supplémentaires** : C++, CMake, Shell, Swift, HTML

## Prérequis

Avant de commencer, assurez-vous d'avoir installé :

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.0+)
- [Dart SDK](https://dart.dev/get-dart) (inclus dans Flutter)
- Un éditeur de code : [VS Code](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio)

Pour les plateformes spécifiques :
- **Android** : Android SDK 21+
- **iOS** : macOS 11+ et Xcode 12+
- **Web** : Chrome, Firefox, Safari ou Edge
- **Desktop** : Configuration appropriée pour Windows, macOS ou Linux

## Installation

1. Clonez le repository :
```bash
git clone https://github.com/josoavj/myportfolio.git
cd myportfolio
```

2. Installez les dépendances :
```bash
flutter pub get
```

3. Configurez vos variables d'environnement :
```bash
cp .env.example .env
# Éditez le fichier .env avec vos paramètres
```

## Lancer l'application

### Android
```bash
flutter run -d android
```

### iOS
```bash
flutter run -d ios
```

### Web
```bash
flutter run -d web
```

### Windows/macOS/Linux
```bash
flutter run -d windows
# ou
flutter run -d macos
flutter run -d linux
```

## Structure du projet

Pour une documentation détaillée sur l'architecture du projet, consultez [STRUCTURE.md](STRUCTURE.md).

```
lib/                  # Code source principal
assets/              # Images et ressources
fonts/               # Polices personnalisées
android/             # Configuration Android
ios/                 # Configuration iOS
web/                 # Configuration Web
windows/             # Configuration Windows
macos/               # Configuration macOS
linux/               # Configuration Linux
```

## Releases

Version actuelle : **2.0.0** (Juillet 2026)

Pour accéder aux [versions précédentes](https://github.com/josoavj/myportfolio/releases), consultez la page des releases.

## Configuration supplémentaire

Configurez l'analyse du code Dart selon vos préférences dans `analysis_options.yaml`.


## Contact

Pour toute question ou suggestion, vous pouvez me contacter via le repository.

---

**Développé par [josoavj](https://github.com/josoavj)**
