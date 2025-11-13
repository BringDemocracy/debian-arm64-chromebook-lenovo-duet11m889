# Dossier Experiments

## 📝 À propos

Ce dossier sert à **documenter chaque tentative, expérimentation et test** effectué dans le cadre du projet d'installation Linux sur le Chromebook Lenovo Duet 11M889.

L'objectif est de garder une trace de :
- Ce qui a été testé
- Comment ça a été fait
- Quels ont été les résultats
- Quels sont les risques identifiés
- Les leçons apprises

## 📋 Structure recommandée

Pour chaque expérimentation, créer un fichier ou dossier avec :

### Exemple de structure :

```
experiments/
├── README.md (ce fichier)
├── 001-test-crouton/
│   ├── README.md
│   ├── logs/
│   ├── screenshots/
│   └── notes.md
├── 002-firmware-analysis/
│   ├── README.md
│   ├── firmware-backup.bin
│   └── analysis.md
├── 003-crostini-optimization/
│   ├── README.md
│   ├── config/
│   └── benchmarks.md
└── ...
```

## 📄 Template pour documenter une expérimentation

Copier ce template dans chaque nouveau dossier d'expérimentation :

```markdown
# Expérimentation : [Titre]

## 📅 Date
YYYY-MM-DD

## 🎯 Objectif
Brève description de ce qui est testé et pourquoi.

## 🔧 Outil/Méthode utilisé(e)
- Nom de l'outil ou de la méthode
- Version
- Lien vers la documentation : [URL]

## ⚠️ Risques identifiés
- [ ] Risque 1 (ex: brick potentiel)
- [ ] Risque 2 (ex: perte de données)
- [ ] Risque 3 (ex:...)

## 🛡️ Mesures de sécurité prises
- [ ] Backup complet fait
- [ ] Documentation de l'état initial
- [ ] Clé USB de récupération préparée
- [ ] Autre mesure...

## 📝 Procédure suivie

### Étape 1
Description détaillée...

### Étape 2
Description détaillée...

### Étape 3
...

## 📊 Résultats

### Ce qui a fonctionné
- Point positif 1
- Point positif 2
- ...

### Ce qui n'a pas fonctionné
- Problème 1
- Problème 2
- ...

### Observations
- Observation 1
- Observation 2
- ...

## 🧪 Tests effectués
- [ ] Test 1 : [résultat]
- [ ] Test 2 : [résultat]
- [ ] Test 3 : [résultat]

## 📷 Captures d'écran / Logs
(Voir dossiers screenshots/ et logs/)

## 💡 Leçons apprises
- Leçon 1
- Leçon 2
- ...

## 🔄 Suite à donner
- [ ] Action 1
- [ ] Action 2
- [ ] Ou : Expérimentation abandonnée (raison)

## 📚 Ressources consultées
- [Lien 1](URL)
- [Lien 2](URL)
- ...

## 🏷️ Tags
#tag1 #tag2 #tag3 (ex: #firmware #dual-boot #ARM64)

---

**Statut final** : ✅ Succès / ⚠️ Partiel / ❌ Échec / 🔄 En cours
```

## 🎯 Domaines d'expérimentation possibles

### Catégorie 1 : Firmware et bootloader
- Test de compatibilité mrchromebox
- Analyse du firmware stock
- Test de U-Boot
- Modification de depthcharge

### Catégorie 2 : Dual-boot
- Repartitionnement
- Installation d'un bootloader alternatif
- Test de GRUB sur ARM64
- Kexec depuis ChromeOS

### Catégorie 3 : Remplacement complet
- Flash de firmware UEFI (si disponible)
- Installation de distro ARM64
- Drivers et périphériques
- Kernel custom

### Catégorie 4 : Crostini / Containers
- Optimisation de Crostini
- Test de crouton
- Docker/Podman dans Crostini
- Performance benchmarks

### Catégorie 5 : Drivers et matériel
- Test de drivers WiFi sous Linux
- Test de drivers audio sous Linux
- Support GPU (panfrost)
- Support tactile et clavier

## ⚠️ Règles importantes

1. **Toujours documenter AVANT de faire une manipulation risquée**
2. **Prendre des backups avant toute modification du système**
3. **Noter les versions exactes** de tous les outils utilisés
4. **Sauvegarder les logs et messages d'erreur** complets
5. **Être honnête sur les résultats** (succès comme échecs)
6. **Partager les leçons apprises** même en cas d'échec

## 📊 Suivi global

| # | Nom | Date | Statut | Risque | Résultat |
|---|-----|------|--------|--------|----------|
| 001 | TBD | - | 🔄 | - | - |
| 002 | TBD | - | 🔄 | - | - |
| ... | | | | | |

## 🔗 Liens utiles

- [ChromeOS Developer Guide](https://chromium.googlesource.com/chromiumos/docs/+/main/developer_guide.md)
- [r/chrultrabook Wiki](https://www.reddit.com/r/chrultrabook/wiki/)
- [Crouton GitHub](https://github.com/dnschneid/crouton)
- [mrchromebox.tech](https://mrchromebox.tech/)

---

**Note** : Ce dossier est un journal de bord technique. Il peut contenir des informations sensibles (configurations, backups, logs système). Ne pas le partager publiquement sans vérification.
