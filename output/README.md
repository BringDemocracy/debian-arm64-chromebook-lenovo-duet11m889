# Dossier Output

## 📝 À propos

Ce dossier contient les **résultats des scripts de collecte d'informations** exécutés sur le Chromebook Lenovo Duet 11M889.

## 📂 Structure

Chaque exécution du script `scripts/collect_chromebook_info.sh` crée un sous-dossier horodaté :

```
output/
├── README.md (ce fichier)
├── run_20241113_143022/
│   ├── README.txt
│   ├── 01_uname.txt
│   ├── 02_os_release.txt
│   ├── 10_crossystem.txt
│   ├── 20_lsblk.txt
│   ├── 23_cgpt_show.txt
│   └── ...
├── run_20241114_095530/
│   └── ...
└── .gitignore
```

## 🔒 Confidentialité

⚠️ **ATTENTION** : Les fichiers dans ce dossier peuvent contenir des **informations sensibles** :
- Numéros de série du matériel
- Adresses MAC
- Configurations système
- Identifiants matériels uniques

**Ne pas partager publiquement ces fichiers sans avoir vérifié et anonymisé leur contenu.**

## 📋 Utilisation

1. **Générer les données** : Exécuter `./scripts/collect_chromebook_info.sh` sur le Chromebook
2. **Consulter les résultats** : Ouvrir le dossier `run_XXXXXXXXX_XXXXXX/` le plus récent
3. **Analyser** : Lire chaque fichier `.txt` pour extraire les informations pertinentes
4. **Documenter** : Remplir `docs/hardware.md` avec les informations collectées

## 📊 Fichiers générés

### Système de base (01-05)
- `01_uname.txt` : Architecture et version kernel
- `02_os_release.txt` : Version ChromeOS
- `03_lsb_release.txt` : Informations LSB
- `04_cpuinfo.txt` : Détails CPU/SoC
- `05_memory.txt` : Mémoire RAM

### Firmware et boot (10-13)
- `10_crossystem.txt` : Flags firmware
- `11_crossystem_sudo.txt` : Flags détaillés
- `12_firmware_manifest.txt` : Manifest firmware
- `13_vpd.txt` : VPD (Vital Product Data)

### Stockage (20-25)
- `20_lsblk.txt` : Périphériques de stockage
- `21_df.txt` : Espace disque
- `22_fdisk.txt` : Table de partitions
- `23_cgpt_show.txt` : Partitions ChromeOS (GPT)
- `24_cgpt_show_quick.txt` : Résumé partitions
- `25_storage_type.txt` : Type de stockage

### Périphériques (30-37)
- `30_lspci.txt` : Périphériques PCI
- `31_lsusb.txt` : Périphériques USB
- `32_device_tree_compatible.txt` : SoC identifié
- `33_device_tree_model.txt` : Modèle device tree
- `34_audio_playback.txt` : Audio lecture
- `35_audio_capture.txt` : Audio capture
- `36_glxinfo.txt` : GPU/OpenGL
- `37_drm_device.txt` : Device DRM

### Réseau (40-43)
- `40_ip_addr.txt` : Configuration réseau
- `41_iwconfig.txt` : Configuration WiFi
- `42_rfkill.txt` : État WiFi/BT
- `43_modules_net.txt` : Modules réseau

### Kernel (50-52)
- `50_lsmod.txt` : Modules chargés
- `51_kernel_modules.txt` : Modules disponibles
- `52_dmesg_tail.txt` : Messages kernel

### Sécurité (60-61)
- `60_flashrom_wp.txt` : Write-protect
- `61_verified_boot.txt` : Verified Boot

## 🔍 Points clés à analyser

Après génération des fichiers, vérifier :

1. **SoC exact** (fichier `32_device_tree_compatible.txt`)
2. **Version firmware** (fichiers `10-12`)
3. **Partitions et espace libre** (fichiers `20-24`)
4. **Write-protect** (fichier `60`)
5. **Verified Boot** (fichier `61`)
6. **Périphériques** (fichiers `30-43`)

---

**Note** : Ce dossier est ignoré par git (via .gitignore) pour éviter de commit des données sensibles.
