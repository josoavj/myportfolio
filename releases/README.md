# 📦 Releases - Web Builds

Ce dossier contient les builds web compilés pour chaque version.

## 📁 Structure

```
releases/
├── v1.0.0/          # Version 1.0.0
├── v1.1.0/          # Version 1.1.0
├── v1.2.0/          # Version 1.2.0
├── v1.2.1/          # Version 1.2.1
├── v1.2.2/          # Version 1.2.2
├── v1.3.0/          # Version 1.3.0
├── v1.4.0/          # Version 1.4.0
├── v1.5.0/          # Version 1.5.0
├── v1.6.0/          # Version 1.6.0 (dernière)
├── web-v1.3.0/      # Web build v1.3.0
├── web-v1.3.1/      # Web build v1.3.1
├── web-v1.4.0/      # Web build v1.4.0
├── web-v1.5.0/      # Web build v1.5.0
├── web-v1.6.0/      # Web build v1.6.0 (actuelle - servie par Netlify)
├── web-v2.0.0/      # Web build v2.0.0
├── current/         # Symlink → web-v2.0.0 (servie par Netlify)
└── .gitkeep         # Garde le dossier dans Git
```

## 🚀 Déploiement Netlify

Netlify publie automatiquement le contenu du symlink `current/` qui pointe sur la dernière version web compilée.

## 🔄 Mise à jour d'une nouvelle version

### Étape 1 : Builder localement
```bash
flutter build web --release
```

### Étape 2 : Copier le build
```bash
cp -r build/web releases/web-v1.6.0
```

### Étape 3 : Mettre à jour le symlink
```bash
cd releases
ln -sf web-v1.6.0 current
cd ..
```

### Étape 4 : Committer
```bash
git add releases/
git commit -m "release: v1.6.0 - web build"
git push origin update
```

### Étape 5 : Redéployer Netlify
- Allez sur Netlify
- **Deployments > Trigger deploy**
- ✅ Déployé en 30 secondes !

## 📝 Avantages

✅ **Pas de Flutter requis sur Netlify** - Élimine les erreurs de build
✅ **Build local optimisé** - Vous contrôlez les paramètres
✅ **Historique complet** - Toutes les versions disponibles
✅ **Mise à jour ultra-rapide** - Netlify juste publie, pas de build
✅ **Symlink dynamique** - `current/` toujours la dernière version
