# Roadmap du Projet

## 📍 État actuel : Phase de structuration et collecte d'infos

---

## Phase 1 : Organisation et collecte d'informations

### 1.1 Structure du projet
- [x] Créer l'arborescence du repo (docs/, scripts/, experiments/, crostini-setup/)
- [x] Créer les fichiers de documentation de base
- [x] Créer le script de collecte d'informations
- [ ] Ajouter un `.gitignore` approprié

### 1.2 Collecte d'informations matérielles
- [ ] Exécuter `scripts/collect_chromebook_info.sh` sur le Chromebook
- [ ] Analyser les résultats dans `output/`
- [ ] Compléter `docs/hardware.md` avec les informations collectées
- [ ] Identifier le SoC MediaTek exact
- [ ] Vérifier la version du firmware
- [ ] Analyser le schéma de partitionnement

### 1.3 Analyse des protections et bootloader
- [ ] Vérifier l'état du Verified Boot
- [ ] Identifier les write protections (hardware/software)
- [ ] Documenter le type de bootloader (depthcharge, version, etc.)
- [ ] Vérifier si des vis de write-protect sont accessibles

---

## Phase 2 : Recherche et évaluation des options

### 2.1 Recherche sur les firmwares alternatifs
- [ ] Vérifier compatibilité **mrchromebox** avec ce modèle ARM64
  - [ ] Consulter la liste des appareils supportés
  - [ ] Chercher des rapports d'utilisateurs sur des MediaTek similaires
  - [ ] Contacter la communauté si nécessaire
- [ ] Rechercher alternatives à mrchromebox pour ARM64
  - [ ] U-Boot
  - [ ] Depthcharge modifié
  - [ ] Autres bootloaders ARM

### 2.2 Recherche sur les distributions Linux ARM64
- [ ] Identifier les distros Debian-based compatibles ARM64
  - [ ] Debian ARM64 officiel
  - [ ] Ubuntu pour ARM
  - [ ] Armbian
  - [ ] PostmarketOS
- [ ] Vérifier la disponibilité de kernels pour MediaTek
- [ ] Rechercher des projets similaires (autres Chromebooks MediaTek)

### 2.3 Drivers et périphériques
- [ ] Identifier les chipsets WiFi/BT
- [ ] Vérifier disponibilité drivers Linux
- [ ] Identifier le chipset audio (UCM profiles?)
- [ ] Vérifier support GPU (Mali + panfrost?)
- [ ] Tester support tactile sous Linux
- [ ] Documenter dans `docs/hardware.md`

### 2.4 Documentation communautaire
- [ ] Chercher sur Reddit (r/chromeos, r/chrultrabook)
- [ ] Consulter les issues GitHub (crouton, chrultrabook, etc.)
- [ ] Vérifier les wikis et forums spécialisés
- [ ] Contacter des utilisateurs ayant le même modèle
- [ ] Créer un fichier `docs/ressources.md` avec les liens utiles

---

## Phase 3 : Tests non destructifs

### 3.1 Setup Crostini optimisé (Objectif #3)
- [ ] Activer Crostini dans ChromeOS
- [ ] Configurer une Debian Testing/Sid
- [ ] Installer environnement de développement
  - [ ] Python + pip
  - [ ] Node.js + npm
  - [ ] Git, tmux, vim/neovim
  - [ ] VS Code ou alternative
- [ ] Optimiser les ressources
  - [ ] Augmenter RAM allouée au container
  - [ ] Configurer swap si nécessaire
  - [ ] Tester performances GPU
- [ ] Documenter la config dans `crostini-setup/`
- [ ] Créer scripts d'installation automatisée

### 3.2 Tests de compatibilité (si applicable)
- [ ] Tester kernel Linux en chroot (crouton)
- [ ] Vérifier quels drivers fonctionnent
- [ ] Tester le WiFi sous Linux
- [ ] Tester l'audio sous Linux
- [ ] Documenter les résultats dans `experiments/`

---

## Phase 4 : Décision et stratégie

### 4.1 Évaluation des options
- [ ] Compiler les informations des phases 1-3
- [ ] Évaluer la faisabilité de chaque objectif :
  - [ ] Dual-boot (objectif #1)
  - [ ] Remplacement complet (objectif #2)
  - [ ] Crostini optimisé (objectif #3)
- [ ] Documenter les risques de chaque approche
- [ ] Créer une matrice décision (faisabilité / risque / bénéfice)

### 4.2 Choix de la stratégie
- [ ] Décider quelle approche poursuivre
- [ ] Documenter le choix et les raisons
- [ ] Créer un plan d'action détaillé
- [ ] Identifier les points de non-retour
- [ ] Prévoir une stratégie de backup/récupération

---

## Phase 5 : Implémentation (selon stratégie choisie)

### Option A : Si dual-boot est choisi

#### 5.1 Préparation
- [ ] Créer une sauvegarde complète du système
- [ ] Documenter l'état initial
- [ ] Préparer une clé USB de récupération ChromeOS
- [ ] Télécharger tous les outils nécessaires

#### 5.2 Modification du firmware (si nécessaire)
- [ ] Désactiver write-protect (vis ou logiciel)
- [ ] Backup du firmware original
- [ ] Flash du firmware alternatif
- [ ] Vérifier que le système boot encore
- [ ] Documenter dans `experiments/`

#### 5.3 Repartitionnement
- [ ] Réduire la partition STATE de ChromeOS
- [ ] Créer partition(s) pour Linux
- [ ] Documenter le nouveau schéma
- [ ] Vérifier que ChromeOS boot toujours

#### 5.4 Installation Linux
- [ ] Installer le bootloader (GRUB, U-Boot, ou autre)
- [ ] Installer la distro Linux choisie
- [ ] Configurer le dual-boot
- [ ] Installer les drivers nécessaires
- [ ] Tester le boot des deux systèmes

#### 5.5 Post-installation
- [ ] Vérifier tous les périphériques
- [ ] Optimiser les performances
- [ ] Documenter la procédure complète
- [ ] Créer un guide de maintenance

---

### Option B : Si remplacement complet est choisi

#### 5.1 Préparation
- [ ] Créer une sauvegarde complète
- [ ] Accepter la perte de ChromeOS
- [ ] Préparer média d'installation Linux
- [ ] Télécharger firmware + outils

#### 5.2 Remplacement firmware
- [ ] Désactiver write-protect
- [ ] Backup firmware original
- [ ] Flash firmware UEFI/U-Boot
- [ ] Vérifier le boot du nouveau firmware

#### 5.3 Installation complète
- [ ] Formater complètement le disque
- [ ] Installer la distro Linux
- [ ] Configurer le bootloader
- [ ] Installer tous les drivers

#### 5.4 Configuration et tests
- [ ] Vérifier tous les périphériques
- [ ] Optimiser le système
- [ ] Documenter la procédure

---

### Option C : Si Crostini optimisé est choisi

#### 5.1 Configuration avancée
- [ ] Suivre le plan détaillé dans `crostini-setup/`
- [ ] Maximiser les performances
- [ ] Configurer environnement complet
- [ ] Automatiser le setup avec scripts

#### 5.2 Optimisations
- [ ] GPU acceleration si possible
- [ ] Accès périphériques USB
- [ ] Configuration réseau avancée
- [ ] Backup/restore automatique

---

## Phase 6 : Documentation finale

- [ ] Rédiger un guide complet de la solution retenue
- [ ] Documenter tous les problèmes rencontrés et solutions
- [ ] Créer des scripts d'installation automatisés
- [ ] Partager avec la communauté (si pertinent)
- [ ] Maintenir la documentation à jour

---

## 📊 Métriques de suivi

### Temps estimé par phase
- Phase 1 : 1-2 jours
- Phase 2 : 3-7 jours (recherche intensive)
- Phase 3 : 2-4 jours
- Phase 4 : 1 jour
- Phase 5 : Variable (1-15 jours selon complexité)
- Phase 6 : 2-3 jours

### Checkpoints
- ✅ **Checkpoint 1** : Informations matérielles collectées
- 🔲 **Checkpoint 2** : Évaluation des options terminée
- 🔲 **Checkpoint 3** : Environnement Crostini fonctionnel (fallback)
- 🔲 **Checkpoint 4** : Décision finale prise
- 🔲 **Checkpoint 5** : Solution implémentée et testée

---

## ⚠️ Points d'attention

### Risques à surveiller
- Mises à jour ChromeOS qui pourraient casser des modifications
- Incompatibilité firmware avec le matériel
- Drivers manquants pour périphériques critiques
- Write-protect non désactivable

### Critères d'arrêt (abandon d'une voie)
- Brick du système sans récupération possible
- Impossibilité technique confirmée (après recherche approfondie)
- Ratio risque/bénéfice trop élevé
- Coût en temps/complexité déraisonnable

### Fallback permanent
Si tout échoue ou est trop risqué : **Crostini optimisé** reste toujours une solution viable et sûre.

---

**Dernière mise à jour** : Date de création du fichier  
**Statut global** : 🟡 Phase 1 en cours
