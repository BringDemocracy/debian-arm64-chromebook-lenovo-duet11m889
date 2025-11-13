# Debian-based Linux sur Chromebook Lenovo Duet 11M889 (ARM64)

## 🎯 Objectif du projet

Mettre en place une distro **Linux Debian-based** sur un **Chromebook Lenovo Duet 11M889 (ARM64, MediaTek)** avec, par ordre de priorité :

1. **Dualboot ChromeOS + Debian-based** (objectif idéal)
2. **Remplacement complet de ChromeOS** par une Debian-based si nécessaire
3. Si les deux sont impossibles ou trop risqués : **setup Crostini / chroot / containers** le plus proche possible d’une "vraie" Debian (performance, propreté, confort d’usage).

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

Ce repo va contenir :

- `docs/`  
  - Notes sur le firmware, bootloader, partitions, sécurité, etc.
  - Résumés de recherches (articles, forums, issues GitHub, wikis…)
- `scripts/`  
  - Scripts pour **collecter les infos système** (firmware, partitions, etc.)
  - Éventuellement scripts d’automatisation (backup, test, etc.)
- `experiments/`  
  - Tentatives (mrchromebox, kernels custom, chroots, etc.)
  - Journaux de tests et résultats
- `crostini-setup/`  
  - Configs et scripts pour un environnement Crostini "quasi Debian" si c’est la meilleure option.

## 🧭 Roadmap (brouillon)

- [ ] Collecter les infos clés du Chromebook (firmware, partitions, protections).
- [ ] Cartographier les options : dualboot, full install, Crostini/chroot/container.
- [ ] Évaluer l’état des outils existants (mrchromebox, anciens scripts, kernels ARM64, etc.).
- [ ] Construire une ou plusieurs stratégies réalistes.
- [ ] Documenter chaque tentative (succès / échecs / risques).

---

> ⚠️ Pour l’instant : phase **organisation & collecte d’infos**.  
> La "deep research" et les tentatives sérieuses viendront plus tard.
