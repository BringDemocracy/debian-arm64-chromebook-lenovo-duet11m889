#!/bin/bash

################################################################################
# Script de collecte d'informations Chromebook
# 
# Ce script regroupe des commandes NON DESTRUCTIVES pour collecter
# les informations utiles sur le Chromebook Lenovo Duet 11M889 (ARM64).
#
# ⚠️ IMPORTANT : Ce script NE MODIFIE RIEN sur le système.
#                Il se contente de LIRE et SAUVEGARDER des informations.
#
# Usage : ./collect_chromebook_info.sh
#
# Les résultats seront stockés dans le dossier output/ à la racine du repo.
################################################################################

set -e  # Arrêt en cas d'erreur

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Déterminer le chemin du script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
OUTPUT_DIR="$REPO_ROOT/output"

# Créer le dossier output s'il n'existe pas
mkdir -p "$OUTPUT_DIR"

# Timestamp pour cette exécution
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
RUN_DIR="$OUTPUT_DIR/run_$TIMESTAMP"
mkdir -p "$RUN_DIR"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Script de collecte d'informations${NC}"
echo -e "${BLUE}  Chromebook Lenovo Duet 11M889${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "${GREEN}Dossier de sortie :${NC} $RUN_DIR"
echo ""

################################################################################
# Fonction utilitaire pour exécuter une commande et sauvegarder le résultat
################################################################################
run_and_save() {
    local cmd="$1"
    local output_file="$2"
    local description="$3"
    
    echo -e "${YELLOW}▶${NC} $description"
    echo -e "   Commande: ${BLUE}$cmd${NC}"
    
    # Exécuter la commande et sauvegarder
    if eval "$cmd" > "$RUN_DIR/$output_file" 2>&1; then
        echo -e "   ${GREEN}✓${NC} Résultat sauvegardé dans: $output_file"
    else
        echo -e "   ${RED}✗${NC} Erreur (voir $output_file pour détails)"
    fi
    echo ""
}

################################################################################
# 1. INFORMATIONS SYSTÈME DE BASE
################################################################################
echo -e "${GREEN}=== 1. Informations système de base ===${NC}"
echo ""

run_and_save "uname -a" \
    "01_uname.txt" \
    "Architecture et version du kernel"

run_and_save "cat /etc/os-release" \
    "02_os_release.txt" \
    "Version de ChromeOS"

run_and_save "lsb_release -a" \
    "03_lsb_release.txt" \
    "Informations LSB (si disponible)"

run_and_save "cat /proc/cpuinfo" \
    "04_cpuinfo.txt" \
    "Informations détaillées du CPU"

run_and_save "free -h" \
    "05_memory.txt" \
    "Mémoire RAM disponible"

################################################################################
# 2. FIRMWARE ET BOOTLOADER
################################################################################
echo -e "${GREEN}=== 2. Firmware et bootloader ===${NC}"
echo ""

run_and_save "crossystem" \
    "10_crossystem.txt" \
    "Informations crossystem (firmware, boot, flags)"

run_and_save "sudo crossystem" \
    "11_crossystem_sudo.txt" \
    "Informations crossystem avec sudo (plus de détails)"

# Vérifier le firmware
if command -v chromeos-firmwareupdate &> /dev/null; then
    run_and_save "chromeos-firmwareupdate --manifest" \
        "12_firmware_manifest.txt" \
        "Manifest du firmware ChromeOS"
else
    echo -e "${YELLOW}  chromeos-firmwareupdate non disponible${NC}"
    echo ""
fi

# Informations VPD (Vital Product Data)
run_and_save "sudo vpd -l" \
    "13_vpd.txt" \
    "VPD (Vital Product Data) - infos constructeur"

################################################################################
# 3. PARTITIONS ET STOCKAGE
################################################################################
echo -e "${GREEN}=== 3. Partitions et stockage ===${NC}"
echo ""

run_and_save "lsblk -o NAME,SIZE,TYPE,MOUNTPOINT,FSTYPE" \
    "20_lsblk.txt" \
    "Liste des périphériques de stockage"

run_and_save "df -h" \
    "21_df.txt" \
    "Espace disque utilisé/disponible"

run_and_save "sudo fdisk -l" \
    "22_fdisk.txt" \
    "Table de partitions (fdisk)"

# Identifier le device principal (mmcblk0, nvme0n1, etc.)
MAIN_DEVICE=$(lsblk -ndo NAME,TYPE | grep disk | head -n1 | awk '{print $1}')
if [ -n "$MAIN_DEVICE" ]; then
    echo -e "${YELLOW}  Device principal détecté: /dev/$MAIN_DEVICE${NC}"
    
    # cgpt show (outil ChromeOS pour afficher les partitions GPT)
    if command -v cgpt &> /dev/null; then
        run_and_save "sudo cgpt show /dev/$MAIN_DEVICE" \
            "23_cgpt_show.txt" \
            "Partitions ChromeOS (cgpt) sur /dev/$MAIN_DEVICE"
        
        run_and_save "sudo cgpt show -q /dev/$MAIN_DEVICE" \
            "24_cgpt_show_quick.txt" \
            "Résumé des partitions (cgpt quick)"
    else
        echo -e "${YELLOW}  cgpt non disponible (normal si pas en mode dev)${NC}"
    fi
    echo ""
else
    echo -e "${RED}  Impossible de détecter le device principal${NC}"
    echo ""
fi

# Informations sur le type de stockage
run_and_save "cat /sys/block/*/device/type 2>/dev/null || echo 'N/A'" \
    "25_storage_type.txt" \
    "Type de stockage (eMMC/SSD/etc.)"

################################################################################
# 4. PÉRIPHÉRIQUES MATÉRIELS
################################################################################
echo -e "${GREEN}=== 4. Périphériques matériels ===${NC}"
echo ""

run_and_save "lspci" \
    "30_lspci.txt" \
    "Périphériques PCI (si disponible)"

run_and_save "lsusb" \
    "31_lsusb.txt" \
    "Périphériques USB"

run_and_save "cat /proc/device-tree/compatible" \
    "32_device_tree_compatible.txt" \
    "Device Tree Compatible (identifie le SoC)"

run_and_save "cat /proc/device-tree/model" \
    "33_device_tree_model.txt" \
    "Modèle du device tree"

# Informations audio
run_and_save "aplay -l" \
    "34_audio_playback.txt" \
    "Périphériques audio (lecture)"

run_and_save "arecord -l" \
    "35_audio_capture.txt" \
    "Périphériques audio (capture)"

# GPU / Graphiques
run_and_save "glxinfo 2>/dev/null || echo 'glxinfo non disponible'" \
    "36_glxinfo.txt" \
    "Informations OpenGL/GPU"

run_and_save "cat /sys/kernel/debug/dri/0/name 2>/dev/null || echo 'Non accessible sans root'" \
    "37_drm_device.txt" \
    "Device DRM (GPU)"

################################################################################
# 5. RÉSEAU (WiFi, Bluetooth)
################################################################################
echo -e "${GREEN}=== 5. Réseau ===${NC}"
echo ""

run_and_save "ip addr" \
    "40_ip_addr.txt" \
    "Configuration réseau"

run_and_save "iwconfig 2>&1" \
    "41_iwconfig.txt" \
    "Configuration WiFi"

run_and_save "rfkill list" \
    "42_rfkill.txt" \
    "État WiFi/Bluetooth"

run_and_save "lsmod | grep -E '(wifi|bt|bluetooth|wl)'" \
    "43_modules_net.txt" \
    "Modules kernel réseau chargés"

################################################################################
# 6. KERNEL ET MODULES
################################################################################
echo -e "${GREEN}=== 6. Kernel et modules ===${NC}"
echo ""

run_and_save "lsmod" \
    "50_lsmod.txt" \
    "Liste des modules kernel chargés"

run_and_save "ls -la /lib/modules/\$(uname -r)/" \
    "51_kernel_modules.txt" \
    "Contenu du répertoire modules kernel"

run_and_save "dmesg | tail -n 500" \
    "52_dmesg_tail.txt" \
    "Derniers messages du kernel (dmesg)"

################################################################################
# 7. SÉCURITÉ ET PROTECTIONS
################################################################################
echo -e "${GREEN}=== 7. Sécurité et protections ===${NC}"
echo ""

# Vérifier write-protect via flashrom (nécessite root)
if command -v flashrom &> /dev/null; then
    run_and_save "sudo flashrom -p host --wp-status 2>&1" \
        "60_flashrom_wp.txt" \
        "Statut write-protect (flashrom)"
else
    echo -e "${YELLOW}  flashrom non disponible${NC}"
    echo "flashrom non disponible" > "$RUN_DIR/60_flashrom_wp.txt"
    echo ""
fi

# Informations Verified Boot
run_and_save "crossystem | grep -E '(dev_boot|verified)'" \
    "61_verified_boot.txt" \
    "Informations Verified Boot"

################################################################################
# 8. RÉSUMÉ FINAL
################################################################################
echo -e "${GREEN}=== Collecte terminée ! ===${NC}"
echo ""
echo -e "Tous les résultats sont dans : ${BLUE}$RUN_DIR${NC}"
echo ""
echo -e "${YELLOW}Prochaines étapes :${NC}"
echo "  1. Consulter les fichiers dans output/"
echo "  2. Remplir docs/hardware.md avec les informations collectées"
echo "  3. Analyser les résultats pour identifier :"
echo "     - Le SoC MediaTek exact"
echo "     - L'état des protections (write-protect, verified boot)"
echo "     - Le schéma de partitionnement"
echo "     - Les périphériques et leur compatibilité Linux"
echo ""

# Créer un fichier README dans le dossier de run
cat > "$RUN_DIR/README.txt" << EOF
Collecte d'informations - Chromebook Lenovo Duet 11M889
========================================================

Date : $(date)
Script : collect_chromebook_info.sh

Fichiers générés :
------------------
01-05 : Informations système de base
10-13 : Firmware et bootloader
20-25 : Partitions et stockage
30-37 : Périphériques matériels
40-43 : Réseau (WiFi, Bluetooth)
50-52 : Kernel et modules
60-61 : Sécurité et protections

Utilisation :
-------------
Consulter chaque fichier pour extraire les informations pertinentes.
Remplir le fichier docs/hardware.md avec ces informations.
Analyser les résultats pour décider de la stratégie à suivre (dual-boot, remplacement, Crostini).

⚠️ ATTENTION : Ces informations peuvent contenir des données sensibles
               (numéros de série, MAC addresses, etc.). Ne pas partager
               publiquement sans vérification.
EOF

echo -e "${GREEN}✓${NC} Fichier README créé dans le dossier de run"
echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}  Collecte terminée avec succès ! ✓${NC}"
echo -e "${BLUE}========================================${NC}"
