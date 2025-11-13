# Informations Matérielles - Chromebook Lenovo Duet 11M889

## 📋 Résumé du matériel

- **Modèle exact** : Lenovo Duet 11M889
- **Architecture** : ARM64
- **SoC (System on Chip)** : MediaTek (modèle exact à déterminer)
- **RAM** : 8 Go
- **Stockage** : 128 Go (type à vérifier : eMMC / UFS)
- **Mode développeur** : Activé ✅

## 🔧 Firmware

### Version du firmware
<!-- TODO: Récupérer via `crossystem` ou `chromeos-firmwareupdate --manifest` -->

```
À remplir après exécution du script de collecte d'infos
```

### Type de firmware
- [ ] Firmware stock Google
- [ ] Firmware modifié (ex: mrchromebox)
- [ ] Autre

### Informations complémentaires
<!-- Détails sur le BIOS/UEFI, compatibilité avec des firmwares alternatifs -->

```
TODO
```

## 🚀 Bootloader

### Configuration actuelle
<!-- Info sur le bootloader Chrome OS (depthcharge, etc.) -->

```
À remplir après analyse
```

### Options de modification
<!-- Possibilités de remplacer/modifier le bootloader -->

- [ ] mrchromebox script supporté ?
- [ ] Depthcharge modifiable ?
- [ ] U-Boot possible ?
- [ ] Autre solution ?

```
TODO: Vérifier la compatibilité ARM64 de chaque option
```

## 💾 Partitions

### Schéma de partitionnement actuel
<!-- Résultat de `sudo cgpt show /dev/mmcblk0` ou équivalent -->

```
À remplir après exécution du script de collecte
```

### Table de partitions ChromeOS
<!-- Détails sur les partitions ChromeOS (kernel A/B, ROOT A/B, STATE, etc.) -->

```
TODO
```

### Espace disponible
<!-- Analyse de l'espace libre pour un éventuel dual-boot -->

```
TODO
```

## 🔒 Sécurité et protections

### Verified Boot
- **État** : À déterminer
- **Version** : À déterminer
- **Impact sur l'installation Linux** : À évaluer

### Write Protect
- **Screw (vis physique)** : À vérifier
- **Logiciel** : À vérifier via `flashrom`
- **Désactivable** : À tester

### Secure Boot / Autres protections
<!-- Autres mécanismes de sécurité ChromeOS -->

```
TODO
```

## 📡 Périphériques et compatibilité

### WiFi
- **Chipset** : À identifier
- **Driver Linux** : À vérifier

### Bluetooth
- **Chipset** : À identifier
- **Driver Linux** : À vérifier

### Audio
- **Chipset** : À identifier
- **Driver Linux** : À vérifier

### Écran tactile
- **Support Linux** : À vérifier

### Clavier détachable
- **Support Linux** : À vérifier

### GPU
- **Chipset** : À identifier (Mali probable pour MediaTek)
- **Driver Linux** : À vérifier (panfrost, blob propriétaire?)

### USB-C / Ports
- **Fonctionnalité** : À tester sous Linux

## 🔍 Commandes de collecte d'infos

Les informations ci-dessus seront remplies après exécution de :
```bash
./scripts/collect_chromebook_info.sh
```

Les résultats seront stockés dans le dossier `output/`.

## 📚 Ressources

### Documentation officielle
- [Lenovo Duet 11 specifications](https://www.lenovo.com/us/en/p/laptops/lenovo/lenovo-edu-chromebooks/ideapad-duet-11-inch-m-(11%E2%80%9D-mediatek)/len101i0052)
- [ChromeOS Developer Guide](https://chromium.googlesource.com/chromiumos/docs/+/main/developer_guide.md)

### Ressources communautaires
- [r/chromeos](https://www.reddit.com/r/chromeos/)
- [r/chrultrabook](https://www.reddit.com/r/chrultrabook/)
- [ChromeOS ARM64 discussions](https://github.com/dnschneid/crouton/issues)

---

**Dernière mise à jour** : TODO
