# Portfolio App

Mon portfolio personnel, développé avec **Flutter** et **Dart**. Il présente mon parcours de développeur fullstack mobile et backend, mes compétences, mes projets et mes expériences.

**Lien de la version Web** : [josoavj-portfolio.vercel.app](https://josoavj-portfolio.vercel.app)

## Plateformes

Web, Android, Windows et Linux, à partir d'une seule base de code.

## Stack

Flutter, Dart, Riverpod, API GitHub. Déploiement Web sur Vercel et Netlify.

## Déploiement

Vercel et Netlify publient le build pré-compilé du dossier `releases/current` (voir `vercel.json` et `netlify.toml`), sans étape de build côté hébergeur.

## Structure de `lib/`

| Dossier | Contenu |
| --- | --- |
| `constants/` | Données du portfolio (projets, compétences, expériences, formation) |
| `models/` | Modèles (`Project`, `Skill`, ...) |
| `pages/` | Sections de la page d'accueil et pages de détail |
| `widgets/` | Composants réutilisables |
| `services/` | API GitHub, cache et providers Riverpod |
| `utils/` | Thème, animations, extensions |
