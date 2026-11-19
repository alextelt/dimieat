# DimiEat 🥄

Suivi visuel des aliments goûtés pendant la diversification alimentaire, synchronisé entre deux téléphones.
Page statique (GitHub Pages) + Supabase (base, connexion, temps réel). Catégories et conseils repris de l'affiche
Santé publique France « La diversification alimentaire de votre enfant jusqu'à 3 ans ».

## Mise en place

1. **Supabase** : créer un projet (ou réutiliser un existant), puis dans *SQL Editor* exécuter `supabase.sql`.
2. **Comptes** : *Authentication > Users > Add user* — créer un compte (partagé) ou un par parent, avec « Auto confirm ».
   Puis *Authentication > Sign In / Providers* : désactiver **Allow new users to sign up**, pour que personne d'autre ne puisse s'inscrire.
3. **Config** : dans *Settings > API*, copier l'URL du projet et la clé `anon` dans `config.js`.
4. **GitHub Pages** : *Settings > Pages* → Deploy from branch `main`, dossier `/ (root)`. Le fichier `CNAME` contient `dimieat.roche.pw`.
5. **DNS OVH** : zone `roche.pw` → ajouter un enregistrement `CNAME` : sous-domaine `dimieat` → `alextelt.github.io.`
   Une fois le certificat émis, cocher *Enforce HTTPS* dans GitHub Pages.
6. **Supabase > Authentication > URL Configuration** : mettre `https://dimieat.roche.pw` en *Site URL*.

## Sur les téléphones

Ouvrir https://dimieat.roche.pw dans Chrome → se connecter → menu ⋮ → **Ajouter à l'écran d'accueil**.
La session reste ouverte ; le prénom demandé au premier lancement sert à savoir qui a noté quoi (bouton 👤 pour le changer).

## Mises à jour

Un simple push sur `main` : l'appli se met à jour à la prochaine ouverture (rien à réinstaller).
