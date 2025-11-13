# Debian-based Linux sur Chromebook Lenovo Duet 11M889 (ARM64)

## 🎯 Objectif du projet

Mettre en place une distro **Linux Debian-based** sur un **Chromebook Lenovo Duet 11M889 (ARM64, MediaTek)** avec, par ordre de priorité :

1. **Dualboot ChromeOS + Debian-based** (objectif idéal)
2. **Remplacement complet de ChromeOS** par une Debian-based si nécessaire
3. Si les deux sont impossibles ou trop risqués : **setup Crostini / chroot / containers** le plus proche possible d'une "vraie" Debian (performance, propreté, confort d'usage).

## 💻 Contexte matériel

- Modèle : **Lenovo Duet 11M889**
- Architecture : **ARM64 (MediaTek)**
- RAM : **8 Go**
- Stockage : **128 Go**
- Mode développeur : **activé**
- Utilisateur prêt à :
  - bidouiller,
  - perdre les données si besoin,
  - accepter les risques raisonnables (mais éviter le brick définitif).

## 📚 Organisation du repo

```
debian-arm64-chromebook-lenovo-duet11m889/
├── docs/                    # Documentation détaillée
│   ├── hardware.md         # Spécifications matérielles et firmware
│   ├── objectifs.md        # Détail des 3 objectifs prioritaires
│   └── roadmap.md          # Roadmap complète avec checklist
├── scripts/                 # Scripts utilitaires
│   └── collect_chromebook_info.sh  # Collecte d'infos système (NON destructif)
├── experiments/             # Documentation des tentatives et tests
│   └── README.md           # Template et guide pour documenter
├── crostini-setup/          # Configuration Crostini optimisée
│   └── README.md           # Guide complet setup Crostini
├── output/                  # Résultats des scripts (ignoré par git)
│   └── README.md           # Guide des fichiers générés
└── README.md               # Ce fichier
```

### Contenu des dossiers

- **`docs/`** : Documentation technique complète
  - Informations matérielles (SoC, firmware, partitions, périphériques)
  - Description détaillée des objectifs et stratégies
  - Roadmap avec phases et checkpoints
  
- **`scripts/`** : Scripts d'automatisation
  - Script de collecte d'informations système (NON destructif)
  - Futurs scripts de backup, installation, etc.
  
- **`experiments/`** : Journal de bord technique
  - Documentation de chaque test/tentative
  - Résultats, logs, leçons apprises
  - Template pour documenter proprement
  
- **`crostini-setup/`** : Solution Crostini (fallback sûr)
  - Guide d'installation et optimisation
  - Scripts de configuration
  - Benchmarks et troubleshooting
  
- **`output/`** : Résultats des collectes d'infos
  - Données système collectées (firmware, partitions, etc.)
  - ⚠️ Peut contenir données sensibles - ignoré par git

## 🚀 Démarrage rapide

### Étape 1 : Collecte d'informations

Sur le Chromebook (en mode développeur), exécuter :

```bash
# Cloner le repo (adapter l'URL si nécessaire)
git clone https://github.com/BringDemocracy/debian-arm64-chromebook-lenovo-duet11m889.git
cd debian-arm64-chromebook-lenovo-duet11m889

# Rendre le script exécutable (si nécessaire)
chmod +x scripts/collect_chromebook_info.sh

# Exécuter la collecte d'infos (NON destructif, lecture seule)
./scripts/collect_chromebook_info.sh
```

Les résultats seront dans `output/run_XXXXXXXXX_XXXXXX/`.

### Étape 2 : Analyse

Consulter les fichiers générés et remplir `docs/hardware.md` avec les informations collectées.

### Étape 3 : Décision

Lire `docs/objectifs.md` et `docs/roadmap.md` pour comprendre les options et choisir une stratégie.

## 🧭 Roadmap (résumé)

Voir [`docs/roadmap.md`](docs/roadmap.md) pour la roadmap complète et détaillée.

**Phases principales :**

- [x] **Phase 1** : Organisation et structure du projet
- [ ] **Phase 2** : Collecte d'informations matérielles
- [ ] **Phase 3** : Recherche et évaluation des options (firmware, distros, drivers)
- [ ] **Phase 4** : Tests non destructifs (Crostini, compatibilité)
- [ ] **Phase 5** : Décision et choix de stratégie
- [ ] **Phase 6** : Implémentation (selon choix : dual-boot / remplacement / Crostini)
- [ ] **Phase 7** : Documentation finale et partage

---

> ⚠️ **État actuel** : Phase 1 terminée - Organisation et structure du projet  
> La prochaine étape est l'exécution du script de collecte d'informations sur le Chromebook.
