# SMARTDEBUFF – Root & Snare

Liste des sorts permettant de supprimer ou de contrer les effets de type Root et Snare dans WoW Retail (Midnight 12.x).

- `SMARTDEBUFF_ROOT` : immobilisation complète.
- `SMARTDEBUFF_SNARE` : réduction de la vitesse de déplacement.

Les talents sont associés au sort de base via `Improved_Talent`.

**Attention :** liste de travail à vérifier en jeu. Les interactions peuvent varier selon les spécialisations et les mises à jour.

---

## 1. Sorts sans talent supplémentaire

| Classe / Race | Sort                | SpellID | Root | Snare | Wowhead |
| ------------- | ------------------- | ------- | ---- | ----- | ------- |
| Paladin       | Blessing of Freedom | 1044    | ✓    | ✓     | 1044    |
| Hunter        | Master's Call       | 53271   | ✓    | ✓     | 53271   |
| Monk          | Tiger's Lust        | 116841  | ✓    | ✓     | 116841  |
| Gnome         | Escape Artist       | 20589   | ✓    | ✓     | 20589   |
| Shaman        | Spirit Walk         | 58875   | ✓    | ✓     | 58875   |
| Mage          | Blink               | 1953    | ✓    |       | 1953    |
| Mage          | Ice Block           | 45438   | ✓    | ✓     | 45438   |
| Demon Hunter  | Vengeful Retreat    | 198793  |      | ✓     | 198793  |
| Rogue         | Vanish              | 1856    |      | ✓     | 1856    |

### Druid – Shapeshifting

| Form        | SpellID | Root | Snare | Wowhead |
| ----------- | ------- | ---- | ----- | ------- |
| Cat Form    | 768     | ✓    | ✓     | 768     |
| Bear Form   | 5487    | ✓    | ✓     | 5487    |
| Travel Form | 783     | ✓    | ✓     | 783     |

Note: Shapeshifting has specific mechanics and should be handled separately if necessary.

---

## 2. Sorts améliorés par un talent

### Shaman – Thunderous Paws

- Sort de base : Ghost Wolf
- SpellID : `2645`
- Talent : Thunderous Paws
- Talent ID : `378075`
- Effet : Snare uniquement.

lua

```
{ -- Ghost Wolf + Thunderous Paws
  Spell_ID = 2645,
  Spell_List = {SMARTDEBUFF_SNARE},
  Improved_Talent = 378075,
  Improved_Spell_List = {SMARTDEBUFF_SNARE},
}
```

Ghost Wolf · Thunderous Paws

### Priest – Phantasm

- Sort de base : Fade
- SpellID : `586`
- Talent : Phantasm
- Talent ID : `108942`
- Effet : Snare uniquement.

lua

```
{ -- Fade + Phantasm
  Spell_ID = 586,
  Spell_List = {},
  Improved_Talent = 108942,
  Improved_Spell_List = {SMARTDEBUFF_SNARE},
}
```

Fade · Phantasm

### Mage – Energized Barriers

- Talent : Energized Barriers
- Talent ID : `386828`
- Effet : Snare uniquement.

Sorts concernés :

| Sort              | SpellID |
| ----------------- | ------- |
| Blazing Barrier   | 235313  |
| Ice Barrier       | 11426   |
| Prismatic Barrier | 235450  |

lua

```
{ -- Blazing Barrier + Energized Barriers
  Spell_ID = 235313,
  Spell_List = {},
  Improved_Talent = 386828,
  Improved_Spell_List = {SMARTDEBUFF_SNARE},
},
{ -- Ice Barrier + Energized Barriers
  Spell_ID = 11426,
  Spell_List = {},
  Improved_Talent = 386828,
  Improved_Spell_List = {SMARTDEBUFF_SNARE},
},
{ -- Prismatic Barrier + Energized Barriers
  Spell_ID = 235450,
  Spell_List = {},
  Improved_Talent = 386828,
  Improved_Spell_List = {SMARTDEBUFF_SNARE},
},
```

Blazing Barrier · Ice Barrier · Prismatic Barrier · Energized Barriers

### Hunter – Posthaste

- Sort de base : Disengage
- SpellID : `781`
- Talent : Posthaste
- Talent ID : `109215`
- Effet : Root + Snare.

lua

```
{ -- Disengage + Posthaste
  Spell_ID = 781,
  Spell_List = {},
  Improved_Talent = 109215,
  Improved_Spell_List = {SMARTDEBUFF_ROOT, SMARTDEBUFF_SNARE},
}
```

Disengage · Posthaste

### Warrior – Fearless

- Sort de base : Berserker Rage
- SpellID : `18499`
- Talent : Fearless
- Talent ID : `1271925`
- Effet : Snare uniquement.

lua

```
{ -- Berserker Rage + Fearless
  Spell_ID = 18499,
  Spell_List = {},
  Improved_Talent = 1271925,
  Improved_Spell_List = {SMARTDEBUFF_SNARE},
}
```

Berserker Rage · Fearless

### Warlock – Soul-Etched Circles

- Sort de base : Demonic Circle: Teleport
- SpellID : `48020`
- Talent : Soul-Etched Circles
- Talent ID : `428911`
- Effet : Root + Snare.

lua

```
{ -- Demonic Circle: Teleport + Soul-Etched Circles
  Spell_ID = 48020,
  Spell_List = {},
  Improved_Talent = 428911,
  Improved_Spell_List = {SMARTDEBUFF_ROOT, SMARTDEBUFF_SNARE},
}
```

Demonic Circle: Teleport · Soul-Etched Circles

---

## 3. Récapitulatif des talents

| Classe  | Sort de base             | Spell_ID | Talent              | Improved_Talent | Catégorie    |
| ------- | ------------------------ | -------- | ------------------- | --------------- | ------------ |
| Shaman  | Ghost Wolf               | 2645     | Thunderous Paws     | 378075          | SNARE        |
| Priest  | Fade                     | 586      | Phantasm            | 108942          | SNARE        |
| Mage    | Blazing Barrier          | 235313   | Energized Barriers  | 386828          | SNARE        |
| Mage    | Ice Barrier              | 11426    | Energized Barriers  | 386828          | SNARE        |
| Mage    | Prismatic Barrier        | 235450   | Energized Barriers  | 386828          | SNARE        |
| Hunter  | Disengage                | 781      | Posthaste           | 109215          | ROOT + SNARE |
| Warrior | Berserker Rage           | 18499    | Fearless            | 1271925         | SNARE        |
| Warlock | Demonic Circle: Teleport | 48020    | Soul-Etched Circles | 428911          | ROOT + SNARE |

---

## 4. À vérifier / Tests en jeu

- [ ] Vérifier les valeurs `locType` de `C_LossOfControl`.
- [ ] Vérifier Frost Nova (Root).
- [ ] Vérifier Frostbolt (Snare).
- [ ] Vérifier Hamstring (Snare).
- [ ] Vérifier Chains of Ice (Snare).
- [ ] Vérifier les effets de suppression de chaque sort listé.
- [ ] Vérifier les changements de talents en Midnight 12.x.
- [ ] Vérifier les capacités raciales et les changements de forme du Druide.

## 5. Constantes SMARTDEBUFF

lua

```
SMARTDEBUFF_ROOT
SMARTDEBUFF_SNARE
```

Objectif : détecter séparément les immobilisations et les ralentissements afin de proposer uniquement les capacités adaptées dans les Mouse Keys.

**Dernière mise à jour :** 2026-11-06

**Statut :** liste de travail, non exhaustive et à valider en jeu.
