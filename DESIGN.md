# DESIGN.md - Cyber-Operator HUD Design System

---
name: Cyber-Operator HUD
colors:
  surface: '#131313'
  surface-dim: '#131313'
  surface-bright: '#3a3939'
  surface-container-lowest: '#0e0e0e'
  surface-container-low: '#1c1b1b'
  surface-container: '#201f1f'
  surface-container-high: '#2a2a2a'
  surface-container-highest: '#353534'
  on-surface: '#e5e2e1'
  on-surface-variant: '#cbc3d7'
  inverse-surface: '#e5e2e1'
  inverse-on-surface: '#313030'
  outline: '#958ea0'
  outline-variant: '#494454'
  surface-tint: '#d0bcff'
  primary: '#d0bcff'
  on-primary: '#3c0091'
  primary-container: '#a078ff'
  on-primary-container: '#340080'
  inverse-primary: '#6d3bd7'
  secondary: '#4edea3'
  on-secondary: '#003824'
  secondary-container: '#00a572'
  on-secondary-container: '#00311f'
  tertiary: '#ffb875'
  on-tertiary: '#4b2800'
  tertiary-container: '#d57a00'
  on-tertiary-container: '#412200'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#e9ddff'
  primary-fixed-dim: '#d0bcff'
  on-primary-fixed: '#23005c'
  on-primary-fixed-variant: '#5516be'
  secondary-fixed: '#6ffbbe'
  secondary-fixed-dim: '#4edea3'
  on-secondary-fixed: '#002113'
  on-secondary-fixed-variant: '#005236'
  tertiary-fixed: '#ffdcc0'
  tertiary-fixed-dim: '#ffb875'
  on-tertiary-fixed: '#2d1600'
  on-tertiary-fixed-variant: '#6b3b00'
  background: '#131313'
  on-background: '#e5e2e1'
  surface-variant: '#353534'
  neon-purple: '#8B5CF6'
  cyber-green: '#10B981'
  warning-orange: '#F7931E'
  void-black: '#050505'
  surface-gray: '#161616'
  text-dim: '#888888'
typography:
  display-hero:
    fontFamily: Plus Jakarta Sans
    fontSize: 64px
    fontWeight: '800'
    lineHeight: '1.1'
    letterSpacing: -0.04em
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '700'
    lineHeight: '1.2'
  headline-lg-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '700'
    lineHeight: '1.2'
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 20px
    fontWeight: '600'
    lineHeight: '1.4'
  body-base:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.6'
  data-mono:
    fontFamily: JetBrains Mono
    fontSize: 14px
    fontWeight: '500'
    lineHeight: '1.5'
    letterSpacing: 0.02em
  label-caps:
    fontFamily: JetBrains Mono
    fontSize: 12px
    fontWeight: '700'
    lineHeight: '1'
    letterSpacing: 0.1em
  status-sm:
    fontFamily: JetBrains Mono
    fontSize: 10px
    fontWeight: '700'
    lineHeight: '1'
    letterSpacing: 0.05em
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  unit: 4px
  gutter: 24px
  margin-safe: 32px
  container-max: 1280px
---

## Brand & Style

This design system is built for the "High-Performance Operator"—a developer whose portfolio functions less like a static resume and more like a tactical command center. The personality is precise, technical, and elite. It draws heavily from **Cyberpunk-Minimalism**, stripping away decorative fluff in favor of functional data density and high-tech utility.

The visual language balances the raw, "unrefined" edge of a terminal with the sleek sophistication of a futuristic HUD. Key characteristics include:
- **Technological Utility:** Everything is framed as a metric, a status, or a module.
- **Atmospheric Depth:** A void-black foundation allows neon accents and glowing glass layers to pop with maximum vibrance.
- **Data Maximalism:** Performance metrics and system statuses are treated as core aesthetic elements, signaling transparency and expertise.
- **Tactical Precision:** Uses rigid grid alignment, monospaced data readouts, and "scanline" textures to evoke a high-fidelity digital interface.

## Colors

The palette is strictly dark-mode-first, utilizing a high-contrast relationship between a deep charcoal base and vibrant neon accents.

- **Primary (Neon Purple):** Used for "System Critical" interactions, active navigation states, and primary branding. It should frequently carry a subtle glow or "bloom" effect.
- **Secondary (Cyber Green):** Reserved exclusively for "Success" metrics, active status indicators (e.g., "ACTIVE"), and performance uptime.
- **Tertiary (Warning Orange):** Used for highlighted "Tips," experimental tags, or system alerts.
- **Neutral (Void Black/Surface Gray):** The foundation of the system. Surfaces are built using varying levels of charcoal to create depth without relying on traditional shadows.
- **Text:** Primary content is pure white (#FFFFFF) for maximum legibility against the dark void, while metadata uses a muted gray (#888888).

## Typography

This system uses a dual-font strategy to distinguish between "Human Narrative" and "System Data."

- **Sleek Sans-Serif (Plus Jakarta Sans):** Used for major headings and body descriptions. It provides a modern, clean contrast to the more rigid monospaced elements, ensuring the portfolio feels premium rather than purely "retro."
- **Monospace (JetBrains Mono):** The workhorse for all technical data, labels, tags, and timestamps. This font reinforces the developer identity and terminal aesthetic. 

**Formatting Rules:**
- All labels and status indicators should be `uppercase`.
- Use double slashes `//` or dashes `—` as stylistic prefixes for section headers (e.g., `01 // EXPERIENCE`).
- Large display text should use tight letter spacing for a "blocky," architectural feel.

## Layout & Spacing

The layout follows a **Fixed-Fluid Hybrid** model. Content is contained within a max-width grid to maintain a dashboard feel on ultra-wide monitors, while smaller elements utilize a rigid 4px/8px baseline grid to maintain technical density.

- **Grid Strategy:** A 12-column grid is used for desktop. Components like "Player Stats" and "Project Cards" should snap to specific column spans (e.g., 4 columns for stats, 6 for project summaries).
- **HUD Elements:** Fixed status bars or "Core Web Vitals" tickers should be pinned to the viewport edges (top/bottom) to simulate a persistent HUD.
- **Density:** High. Vertical spacing between related data points is tight, while "Mission Blocks" (sections) are separated by significant whitespace to denote clear phase shifts in the portfolio narrative.
- **Breakpoints:**
  - **Mobile (<768px):** Single column stack. Horizontal margins reduce to 16px. Typography scales down.
  - **Tablet (768px - 1024px):** 6-column grid logic.
  - **Desktop (>1024px):** Full 12-column dashboard layout.

## Elevation & Depth

Hierarchy is established through **Tonal Layering** and **Glassmorphism** rather than traditional soft shadows.

- **Surface Tiers:**
  - **Level 0 (Background):** Void Black (#050505). Use a subtle grid-line pattern or scanline overlay at 2% opacity.
  - **Level 1 (Card/Container):** Surface Gray (#161616) with a 1px border. 
  - **Level 2 (Active/Floating):** High-blur glassmorphism (Backdrop blur: 20px) with a semi-transparent primary color border.
- **Glow Effects:** Critical interactive elements (Buttons, Active Dots) use a "Neon Bloom" — a layered shadow with the primary color at low opacity to simulate light emission.
- **Borders:** Use 1px solid borders for all containers. Interactive states should trigger a change in border color to Neon Purple or Cyber Green.

## Shapes

The shape language is "Hard-Technical." 

- **Corner Radius:** Most containers use a minimal 4px (`0.25rem`) radius to keep the design feeling precise and industrial. Avoid fully rounded "pill" shapes except for very specific status tags.
- **Clipped Corners:** For a more aggressive cyberpunk feel, consider "dog-ear" or chamfered corners on primary buttons and hero cards.
- **Dividers:** Use geometric lines and ASCII-inspired characters (`+`, `[ ]`, `//`) to frame content blocks.

## Components

- **Buttons:** Hard-edged or 4px radius. Primary buttons feature a "Neon Purple" border and a subtle glow. Text is always uppercase JetBrains Mono.
- **Project Cards:** Glassmorphic containers with a 1px border. They include a "Performance Meter" at the bottom using a thin progress bar in "Cyber Green."
- **Status Tags:** Small rectangular tags with background colors. (e.g., `[ ACTIVE ]` in green, `[ EXPERIMENTAL ]` in orange).
- **Inputs:** Terminal-style inputs with a trailing underscore `_` cursor animation. Borders are muted until focused, then glow Neon Purple.
- **Progress Bars:** Thin, 4px height lines. Background is a dark gray; the fill is a gradient from Neon Purple to Cyber Green.
- **Skill Radar:** A geometric SVG chart using primary/secondary color lines to visualize technical proficiency.
- **Copy Trigger:** A monospace text element with a "Click to Copy" hover state and a simple ASCII icon (`⎘`).
