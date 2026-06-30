# Design system — Pujit Portfolio

This file documents the design conventions for the **Pujit Portfolio** design system. Consult it before changing UI code.

---

## Theme overview

- **Preset:** `material3`
- **Material 3:** Primary app chrome uses Material 3 theming in `lib/src/theme/theme.dart`.
- **Dark mode:** Dark mode by default — anchored in a deep, organic warm-neutral dark foundation to minimize eye strain and maximize technical content contrast.
- **Customization:** Global `ThemeData` lives in `lib/src/theme/theme.dart` — avoid one-off `ThemeData` overrides in feature widgets.
- **Seed color:** `#fab5b9` (used to derive `ColorScheme` via `ColorScheme.fromSeed` where applicable).

---

## Color system

Use `context.colors` (`ColorScheme`) for standard Material roles:

| Color Role | Hex Value | Usage |
|---|---|---|
| `primary` | `#fab5b9` | Muted rose for core branding, active navigation states, border glows |
| `onPrimary` | `#4f2327` | Dark contrast text on top of primary colors |
| `secondary` | `#e2bebf` | Taupe/rose accent for secondary actions or CTA backgrounds |
| `tertiary` | `#b0cada` | Cool accent tone |
| `tertiaryContainer` | `#001b27` | Deep near-black teal container for deep containment and high contrast layering |
| `background` | `#171212` | Deep warm-neutral dark foundation base |
| `surface` | `#171212` | Dark foundation base for scaffold backgrounds |
| `surfaceContainer` | `#241e1e` | Glassmorphic containment base |
| `outline` | `#9e8c8d` | Standard borders |
| `outlineVariant` | `#514344` | Edge highlights / divider lines |

### Rules
- **Do not** hardcode hex colors in widgets — use theme roles (`context.colors`) or `appColors`.
- **Glass Surfaces**: Translucent elements (cards, nav bars) use translucent containers (e.g. `surfaceContainer` with opacity) with a `20px` backdrop-blur for a layered, multi-dimensional feel.

---

## Typography

This design system leverages **Plus Jakarta Sans** for primary layout and **Geist** for technical elements.

| Font Family | Style / Weight | Roles | Usage |
|---|---|---|---|
| **Plus Jakarta Sans** | Extra Bold (`800`) | `displayLarge` (48sp, height 1.1) | Large hero titles (desktop) |
| **Plus Jakarta Sans** | Extra Bold (`800`) | `displayMedium` (32sp, height 1.2) | Hero titles (mobile) |
| **Plus Jakarta Sans** | Bold (`700`) | `headlineMedium` (24sp, height 1.3) | Section headings / titles |
| **Plus Jakarta Sans** | Regular (`400`) | `bodyLarge` (18sp, height 1.6) | Primary descriptions & content |
| **Plus Jakarta Sans** | Regular (`400`) | `bodyMedium` (16sp, height 1.6) | Standard body copy & descriptions |
| **Geist** (Monospace) | Medium (`500`) | `labelSmall` / `chipText` (14sp) | Tech stack badges, dates, code-style labels |

### Rules
- Use `AppTextStyles` or `context.textTheme` for all typography.
- **Do not** instantiate inline `TextStyle` with a custom `fontFamily` in widgets.

---

## Spacing, borders, motion

Layout dimensions follow a strict **4px grid system** for mathematical harmony.

| Token class | Baseline | Purpose |
|-------------|----------|---------|
| `AppSpacing` | `unit: 4px` | Standard spacing offsets (`xs: 4px`, `sm: 8px`, `md: 16px`, `lg: 24px`, `xl: 32px`, `xxl: 64px`) |
| `AppBorders` | `sm: 8px` | Standard elements: buttons, inputs (`8px`), cards/containers (`24px` to `32px`), full: stadium/pill |
| `AppShadows` | Ambient Glows | Optical elevation, subtle glows (e.g., hover outer glow uses `primary` at 20% opacity) |
| `AppDurations` | Fast-tactile | Core interactive feedback timing |

### Rules
- **Grid Layout**: 12-column fluid grid for desktop with 24px gutters. Mobile layouts transition to a single-column layout with 16px side margins.
- **Rhythm**: Spacing between major sections should be aggressive (`64px` to `128px`) to allow glassmorphic layers room to breathe.
- **Content Margins**: Standard content inside cards uses `24px` (`lg`) internal padding.

---

## Components

### 1. Buttons
- **Primary**: Solid Primary Rose Accent (`#fab5b9`) with dark text (`#4f2327`).
- **Secondary**: Glass background with a 1px primary border.
- **CTA**: High-contrast variant using the Secondary Accent (`#e2bebf` / `#8e7071`) for maximum pop.
- **Corners**: Rounded corners using `8px` (`AppBorders.sm`) or fully circular `AppBorders.full`.

### 2. Cards (The "Work" Cards)
- **Base**: Glassmorphic background, 24px internal padding, 32px corner radius.
- **Hover**: Edge border transitions from a subtle neutral border to a gradient of Primary to Secondary (glowing edge).
- **Shadow**: On hover, apply a subtle outer glow using the Primary Accent at 20% opacity and scale by `scale(1.02)`.

### 3. Chips & Tags
- **Style**: Small monospaced Geist text inside a subtle glass pill (`AppBorders.full`).
- **Visuals**: A small colored category dot (Secondary or Neutral) next to the tag label (e.g. Swift, Kotlin).

### 4. Input Fields
- **Base**: Darker than scaffold background with 1px glass border and `8px` rounding.
- **Focus**: Border glows with the Primary Accent, and backdrop blur intensity increases.

### 5. Navigation Bar
- **Style**: Fixed top web header with ultra-blurred glass (`backdrop-blur-lg`) and 1px bottom border. On mobile viewports, transitions to a floating dock styled header.

---

## Responsive Scaling (ScreenUtil)

- Design size baseline: **390×844** (iPhone 14 class).
- Use `isMobile = context.width < 900` responsive breakpoints to prevent scaling sizes from blowing up on desktop/web window widths.
- Use `.w`, `.h`, `.sp`, and `.r` properties exclusively for mobile layout scaling.

---

## Localization

- User-visible strings use `easy_localization` — files in `assets/translations/`.
- **Do not** hardcode user-visible display strings in widgets.
