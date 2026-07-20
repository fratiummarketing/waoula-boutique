WAOULA MINI CMS — VERSION PRÊTE À PUBLIER

FICHIERS À ENVOYER SUR GITHUB (À LA RACINE DU DÉPÔT)
- index.html
- admin.html
- config.js

NE PAS ENVOYER LE ZIP TEL QUEL : il faut l'extraire puis téléverser les 3 fichiers ci-dessus.

MISE EN LIGNE
1. GitHub > dépôt waoula-boutique > Add file > Upload files.
2. Téléverser index.html, admin.html et config.js.
3. Commit changes.
4. Settings > Pages > Deploy from a branch > main > /(root) > Save.
5. Site public : https://fratiummarketing.github.io/waoula-boutique/
6. Administration : https://fratiummarketing.github.io/waoula-boutique/admin.html

COMPTE ADMIN
Supabase > Authentication > Users > Add user.
Créer l'utilisateur avec l'e-mail du client et un mot de passe temporaire.
Le client n'a pas besoin de vos accès GitHub ou Supabase.

FONCTIONS DU PANNEAU ADMIN
- connexion Supabase par e-mail/mot de passe
- ajout, modification, suppression et masquage des produits
- image principale et galerie
- tailles, couleurs et variantes
- prix normal, prix promotionnel, stock, SKU et catégorie
- ordre d'affichage et produit vedette
- logo, média d'accueil, titres, coordonnées et liens de paiement

SÉCURITÉ
- La clé présente dans config.js est une clé publique Publishable : c'est normal pour un site navigateur.
- Ne jamais ajouter une clé sb_secret ou service_role dans GitHub.
- Les règles RLS ont été installées dans Supabase.
