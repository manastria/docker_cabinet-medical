## 1. L'arborescence du projet

```text
cabinet-medical/
├── docker-compose.yml      # L'orchestrateur
├── .env                    # Les variables d'environnement (mots de passe)
├── .gitignore              # Pour ne pas commiter les données brutes
├── www/                    # Votre code PHP (index.php, etc.)
├── database/
│   ├── Dockerfile          # (Optionnel, si besoin de config DB spécifique)
│   ├── data/               # Stockage persistant de la BDD (généré automatiquement)
│   └── init/               # Les scripts SQL à lancer au démarrage
│       └── 01_schema.sql   # Votre script SQL (tables + jeu d'essai)
└── web/
    └── Dockerfile          # Configuration du serveur Web (Apache+PHP+Extensions)
```

## Modèle Relationnel (MLD) - Version 1 (Optimisé)

```text
Adresse (id_adresse, numero_voie, libelle_voie, complement, code_postal, ville, pays)
Infirmiere (id_infirmiere, matricule, nom, prenom, tel_portable, tel_domicile, #id_adresse) 
Patient (id_patient, nom, prenom, date_naissance, num_ss, #id_adresse, #id_infirmiere)
```


- Réutilisabilité : L'entité `Adresse` est devenue une "table de référence". On peut y lier n'importe quel acteur du système (patient, infirmière, fournisseur, etc.) sans dupliquer les colonnes `ville` ou `code_postal`.
- Intégrité V1 : La contrainte métier "Un patient est toujours visité par la même infirmière"  est implémentée physiquement par la clé étrangère `id_infirmiere` directement dans la table `Patient`. Il est ainsi impossible techniquement d'affecter deux infirmières à un seul patient dans cette structure.

## Reset factory

La réinitialisation de la base de données se fait avec le script `reset.sh`.
