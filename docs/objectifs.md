# Objectifs du Projet

## 🎯 Vue d'ensemble

Ce document structure les trois objectifs principaux du projet, par ordre de priorité décroissante.

---

## 🥇 Objectif #1 : Dualboot ChromeOS + Debian-based

### Description
Mettre en place un **dual-boot** permettant de démarrer au choix :
- ChromeOS (système d'origine)
- Distribution Linux Debian-based (Debian, Ubuntu, ou dérivée ARM64)

### Avantages
- ✅ Garde ChromeOS fonctionnel (sécurité, mises à jour Google)
- ✅ Accès complet à un environnement Linux natif
- ✅ Possibilité de revenir en arrière facilement
- ✅ Meilleur des deux mondes

### Défis techniques
- Architecture **ARM64** : moins de documentation que x86_64
- Bootloader ChromeOS (depthcharge) non conçu pour le dual-boot
- Verified Boot peut compliquer la modification du boot
- Nécessite possiblement un firmware modifié (ex: mrchromebox)
  - ⚠️ **Vérifier si mrchromebox supporte ce modèle ARM64 spécifique**

### Pistes à explorer
- [ ] **mrchromebox firmware** : vérifier compatibilité ARM64 pour ce modèle
- [ ] **Depthcharge payload custom** : boot Linux via depthcharge modifié
- [ ] **Partition dédiée** : créer une partition Linux et modifier le boot
- [ ] **Kexec** : chaînage de kernels depuis ChromeOS
- [ ] **U-Boot** : remplacement du bootloader par U-Boot (si possible)

### Risques
- 🔴 **Brick potentiel** si flash firmware raté
- 🟡 Perte de données lors du repartitionnement
- 🟡 Perte de la garantie (mode développeur + modifications)
- 🟡 Mises à jour ChromeOS pourraient casser le dual-boot

### Niveau de difficulté
**Élevé** - Requiert :
- Connaissance du firmware et bootloader ChromeOS
- Manipulation de partitions
- Compilation de kernels ARM64 potentiellement
- Beaucoup de bidouille

### Statut
🔍 **Phase de recherche** - Collecte d'informations en cours

---

## 🥈 Objectif #2 : Remplacement complet de ChromeOS

### Description
Remplacer **complètement ChromeOS** par une distribution Linux Debian-based (Debian ARM64, Ubuntu pour ARM, ou autre).

### Avantages
- ✅ Linux natif à 100%
- ✅ Pas de compromis avec ChromeOS
- ✅ Utilisation complète du matériel
- ✅ Gestion système standard Linux

### Défis techniques
- Nécessite un firmware compatible (UEFI ou U-Boot)
- Drivers ARM64 pour tous les périphériques (WiFi, audio, tactile, etc.)
- Bootloader fonctionnel
- Pas de retour arrière facile

### Pistes à explorer
- [ ] **mrchromebox UEFI firmware** : remplacer firmware ChromeOS par UEFI
  - ⚠️ Vérifier support ARM64 pour ce modèle (souvent x86 uniquement)
- [ ] **U-Boot + Linux ARM64** : bootloader open-source + distro ARM64
- [ ] **PostmarketOS** : distro Linux pour appareils ARM (surtout mobiles)
- [ ] **Debian ARM64** : installation manuelle avec kernel custom
- [ ] **Armbian** : distro optimisée pour ARM (si support disponible)

### Risques
- 🔴 **Brick définitif** si firmware incompatible ou flash raté
- 🔴 **Perte complète de ChromeOS** (pas de retour arrière facile)
- 🔴 **Périphériques non fonctionnels** (WiFi, audio, tactile) si drivers manquants
- 🔴 Garantie annulée
- 🟡 Complexité de trouver/compiler les bons kernels et drivers ARM64

### Niveau de difficulté
**Très élevé** - Requiert :
- Expertise en firmware et bootloaders
- Maîtrise de la compilation de kernels ARM64
- Identification et intégration de drivers spécifiques
- Risque de brick à gérer

### Statut
⏸️ **En attente** - Priorité à l'objectif #1 d'abord

---

## 🥉 Objectif #3 : Setup Crostini / Chroot / Containers optimisé

### Description
Si les objectifs #1 et #2 sont **impossibles ou trop risqués**, créer un environnement Linux **le plus proche possible** d'une "vraie" Debian via :
- **Crostini** (conteneur LXC officiel ChromeOS)
- **Chroot** (ex: crouton, ou manuel)
- **Autres containers** (Docker, Podman, etc.)

L'objectif est d'avoir une expérience Debian **propre, performante et productive**.

### Avantages
- ✅ **Zéro risque** de brick
- ✅ ChromeOS reste intact et fonctionnel
- ✅ Mises à jour ChromeOS fonctionnent normalement
- ✅ Facile à mettre en place
- ✅ Garantie préservée

### Défis techniques
- Isolation container = limitations (accès hardware, permissions, performances)
- Expérience pas 100% native
- Partage de ressources avec ChromeOS

### Pistes à explorer

#### 3.1 Crostini (LXC officiel)
- [ ] Configurer Crostini avec Debian Sid ou Testing
- [ ] Optimiser les ressources (RAM, CPU, GPU si possible)
- [ ] Accès aux périphériques (USB, GPU)
- [ ] Setup développement Python/JS/Go complet
- [ ] Interface graphique (déjà incluse via Wayland)

#### 3.2 Crouton (chroot)
- [ ] Vérifier si crouton supporte toujours ChromeOS récents
- [ ] Installation en chroot pour accès direct au hardware
- [ ] Choix de l'environnement (XFCE, LXDE, CLI-only)
- [ ] Performance vs Crostini

#### 3.3 Container Docker/Podman
- [ ] Installer Docker/Podman dans Crostini
- [ ] Image Debian ARM64 custom
- [ ] Montage de volumes pour persistance
- [ ] Accès réseau et périphériques

### Optimisations visées
- **Performance** :
  - Configuration RAM/swap optimale
  - GPU passthrough si possible (via virgl, sommelier)
  - Compilation native ARM64 (pas d'émulation)
  
- **Productivité** :
  - Environnement de dev complet (VS Code, outils CLI, etc.)
  - Accès aux fichiers ChromeOS
  - Clipboard partagé
  - Support multi-fenêtres
  
- **Propreté** :
  - Installation packages via APT standard
  - Configuration dotfiles propre
  - Scripts d'automatisation et backup

### Risques
- 🟢 **Aucun risque** de brick ou perte de ChromeOS
- 🟡 Limitations inhérentes aux containers (isolation, perf)

### Niveau de difficulté
**Faible à Moyen** - Requiert :
- Connaissance de Linux et containers
- Configuration système basique
- Pas de bidouille firmware

### Statut
🟢 **Option de fallback** - Toujours réalisable

---

## 📊 Comparaison des objectifs

| Critère | Dual-boot (#1) | Remplacement (#2) | Crostini (#3) |
|---------|----------------|-------------------|---------------|
| **Difficulté** | Élevée | Très élevée | Faible-Moyenne |
| **Risque de brick** | Moyen | Élevé | Nul |
| **Expérience Linux** | Native 100% | Native 100% | 80-90% native |
| **Garde ChromeOS** | Oui | Non | Oui |
| **Accès hardware** | Complet | Complet | Limité |
| **Réversible** | Oui | Difficile | Oui |
| **Temps estimé** | Plusieurs jours/semaines | Plusieurs semaines | Quelques heures/jours |

---

## 🚀 Stratégie recommandée

1. **Phase 1 : Collecte d'informations**
   - Exécuter `scripts/collect_chromebook_info.sh`
   - Analyser firmware, bootloader, partitions
   - Rechercher compatibilité mrchromebox / U-Boot

2. **Phase 2 : Tests non destructifs**
   - Setup Crostini optimisé (objectif #3) en parallèle
   - Cela donne un environnement de travail immédiatement
   - Et permet d'évaluer si ça suffit

3. **Phase 3 : Décision informée**
   - Si les infos montrent que dual-boot est faisable → objectif #1
   - Si dual-boot impossible mais remplacement OK → objectif #2
   - Si trop risqué → peaufiner objectif #3

---

**Prochaine étape** : Exécuter le script de collecte d'infos et remplir `docs/hardware.md`
