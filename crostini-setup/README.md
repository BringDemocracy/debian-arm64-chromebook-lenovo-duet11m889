# Crostini Setup - Configuration optimisée

## 📝 À propos

Ce dossier contient la **documentation et les scripts** pour mettre en place un environnement **Crostini optimisé** sur le Chromebook Lenovo Duet 11M889.

Crostini est la solution officielle de Google pour exécuter des applications Linux sur ChromeOS via un conteneur LXC. Si le dual-boot ou le remplacement complet de ChromeOS s'avèrent impossibles ou trop risqués, cette approche offre un **excellent compromis** :

✅ **Zéro risque de brick**  
✅ **ChromeOS reste intact**  
✅ **Environnement Linux fonctionnel**  
✅ **Performance correcte**  
✅ **Interface graphique native**

L'objectif est de créer un environnement **le plus proche possible d'une vraie Debian**, avec :
- Performance optimale (RAM, CPU, GPU si possible)
- Installation complète de packages de développement
- Configuration propre et reproductible
- Scripts d'automatisation

---

## 🎯 Objectifs

1. **Environnement de développement complet**
   - Python 3.x + pip + virtualenv
   - Node.js + npm/yarn
   - Git, vim/neovim, tmux
   - VS Code ou alternative (Codium, nvim avec LSP, etc.)
   - Outils de build (gcc, make, cmake, etc.)

2. **Performance optimisée**
   - Allocation RAM maximale pour le conteneur
   - Configuration swap si nécessaire
   - GPU acceleration (via virgl/sommelier si possible)
   - Tuning I/O et réseau

3. **Expérience utilisateur proche de Debian native**
   - Gestionnaire de paquets APT standard
   - Accès aux fichiers ChromeOS
   - Clipboard partagé
   - Support audio
   - Fenêtres multi-app

4. **Reproductibilité**
   - Scripts d'installation automatisés
   - Configuration dotfiles versionnée
   - Backup/restore facile

---

## 📂 Structure du dossier

```
crostini-setup/
├── README.md                  # Ce fichier
├── setup-crostini.sh          # Script principal d'installation (TODO)
├── config/
│   ├── .bashrc               # Configuration bash (TODO)
│   ├── .vimrc                # Configuration vim (TODO)
│   ├── .tmux.conf            # Configuration tmux (TODO)
│   └── .gitconfig            # Configuration git (TODO)
├── scripts/
│   ├── install-dev-tools.sh  # Installe outils de dev (TODO)
│   ├── optimize-resources.sh # Optimise RAM/swap/GPU (TODO)
│   └── backup-container.sh   # Backup du conteneur (TODO)
├── docs/
│   ├── activation.md         # Guide activation Crostini (TODO)
│   ├── optimization.md       # Guide optimisation (TODO)
│   └── troubleshooting.md    # Guide dépannage (TODO)
└── benchmarks/
    └── README.md             # Tests de performance (TODO)
```

---

## 🚀 Guide rapide

### Étape 1 : Activer Crostini

1. Ouvrir **Paramètres ChromeOS**
2. Aller dans **Développeurs** (ou **Avancé** > **Développeurs**)
3. Activer **Environnement de développement Linux (Beta)**
4. Attendre l'installation (peut prendre 5-10 minutes)
5. Une fois terminé, un terminal Linux s'ouvre

Par défaut, Crostini installe **Debian 11 (Bullseye)**.

### Étape 2 : Première configuration

```bash
# Mettre à jour le système
sudo apt update && sudo apt upgrade -y

# Installer quelques outils de base
sudo apt install -y \
    git \
    curl \
    wget \
    vim \
    tmux \
    htop \
    build-essential

# Vérifier l'architecture (doit être aarch64)
uname -m
```

### Étape 3 : Cloner ce repo et lancer le setup

```bash
# Cloner le repo (adapter l'URL)
cd ~
git clone https://github.com/[USER]/debian-arm64-chromebook-lenovo-duet11m889.git
cd debian-arm64-chromebook-lenovo-duet11m889/crostini-setup

# Lancer le script de setup (quand il sera créé)
# ./setup-crostini.sh
```

---

## ⚙️ Optimisations possibles

### 1. Augmenter la RAM allouée au conteneur

Par défaut, Crostini alloue une portion limitée de la RAM totale.

**Méthode via crosh** :
```bash
# Ouvrir crosh (Ctrl+Alt+T dans ChromeOS)
crosh> vmc container termina penguin --privileged true

# Dans le container :
# Éditer /etc/default/crosvm (si accessible)
# Ou utiliser les flags de lancement
```

⚠️ Cette fonctionnalité peut nécessiter le mode développeur et des bidouilles.

### 2. Activer le GPU acceleration

ChromeOS utilise **sommelier** et **virgl** pour le GPU passthrough vers Crostini.

```bash
# Vérifier si virgl est actif
glxinfo | grep -i virgl

# Si non, peut nécessiter des flags Chrome
# chrome://flags/#crostini-gpu-support
```

### 3. Configurer le swap

Si le conteneur manque de RAM, configurer un swap :

```bash
# Créer un fichier swap de 2Go
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Rendre permanent
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

### 4. Accès aux fichiers ChromeOS

Les fichiers ChromeOS sont montés dans `/mnt/chromeos/` :
- `/mnt/chromeos/MyFiles/` → Dossier "Mes fichiers"
- `/mnt/chromeos/GoogleDrive/` → Google Drive
- `/mnt/chromeos/removable/` → Clés USB, SD cards

### 5. Support audio

L'audio devrait fonctionner par défaut via **cras** (ChromeOS audio server).

Tester :
```bash
# Vérifier la sortie audio
pactl info

# Jouer un son de test
speaker-test -t wav -c 2
```

---

## 🧰 Stack de développement recommandée

### Python
```bash
sudo apt install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev

# Virtualenv
pip3 install --user virtualenv
```

### Node.js
```bash
# Via NodeSource (version récente)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Vérifier
node --version
npm --version
```

### Éditeur de code

**Option 1 : VS Code (ARM64)**
```bash
# Télécharger le .deb ARM64 depuis le site officiel
# Ou utiliser le script d'installation
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=arm64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code
```

**Option 2 : VSCodium (alternative open-source)**
```bash
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
echo 'deb [signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update
sudo apt install codium
```

**Option 3 : Neovim avec LSP**
```bash
sudo apt install neovim
# Puis configurer avec nvim-lspconfig, etc.
```

### Outils divers
```bash
sudo apt install -y \
    curl \
    wget \
    git \
    vim \
    neovim \
    tmux \
    htop \
    tree \
    jq \
    ripgrep \
    fd-find \
    bat \
    ncdu \
    tldr
```

---

## 📊 Benchmarks et tests de performance

### CPU
```bash
# Sysbench CPU
sudo apt install sysbench
sysbench cpu --threads=4 run
```

### RAM
```bash
# Tester la RAM
free -h
sudo apt install stress
stress --vm 2 --vm-bytes 1G --timeout 60s
```

### I/O disque
```bash
# Test écriture/lecture
dd if=/dev/zero of=/tmp/testfile bs=1M count=1024
dd if=/tmp/testfile of=/dev/null bs=1M
```

### GPU
```bash
# Si glxinfo fonctionne
sudo apt install mesa-utils
glxgears  # FPS test basique
glxinfo | grep -i "opengl\|renderer"
```

---

## 🐛 Dépannage

### Problème : Le conteneur ne démarre pas
- Redémarrer ChromeOS
- Désactiver puis réactiver Crostini dans les paramètres
- Vérifier les logs : `chrome://linux-container-internals/`

### Problème : Manque de RAM
- Fermer des onglets Chrome
- Configurer un swap (voir optimisations)
- Augmenter la RAM allouée (si possible)

### Problème : Pas de son
- Vérifier que ChromeOS a du son
- Redémarrer le conteneur
- Vérifier `pactl info`

### Problème : GPU ne fonctionne pas
- Activer `chrome://flags/#crostini-gpu-support`
- Redémarrer ChromeOS
- Vérifier avec `glxinfo`

---

## 📚 Ressources

### Documentation officielle
- [Chrome OS Linux (Crostini) Documentation](https://chromium.googlesource.com/chromiumos/docs/+/main/containers_and_vms.md)
- [Crostini on Reddit](https://www.reddit.com/r/Crostini/)

### Communauté
- [r/crostini](https://www.reddit.com/r/Crostini/)
- [Crostini GitHub issues](https://bugs.chromium.org/p/chromium/issues/list?q=component:OS%3ESystems%3EContainers)

### Alternatives
- [crouton](https://github.com/dnschneid/crouton) - Chroot sur ChromeOS (moins sécurisé mais plus de contrôle)

---

## ✅ Checklist de configuration

- [ ] Crostini activé
- [ ] Debian à jour (`apt update && apt upgrade`)
- [ ] Outils de base installés (git, vim, tmux, etc.)
- [ ] Python configuré avec pip et virtualenv
- [ ] Node.js installé
- [ ] Éditeur de code installé (VS Code, Neovim, etc.)
- [ ] Configuration dotfiles (bashrc, vimrc, gitconfig)
- [ ] RAM optimisée (si possible)
- [ ] GPU activé (si possible)
- [ ] Audio testé
- [ ] Accès fichiers ChromeOS vérifié
- [ ] Benchmark de performance effectué
- [ ] Backup du conteneur configuré

---

**Dernière mise à jour** : Date de création  
**Statut** : 🚧 Documentation en cours
