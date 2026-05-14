# CLAUDE.md

## Commands

```bash
flutter run                    # Run on connected device/emulator
flutter run -d windows         # Run on Windows desktop
flutter build apk              # Build Android APK
flutter analyze                # Lint (uses flutter_lints)
flutter test                   # Run all tests
flutter pub get                # Install dependencies
flutter clean                  # Clean build artifacts
```

## Architecture

**june** is a Flutter daily planner app. `AppShell` hosts the 4-tab `BottomNavigationBar` (Dashboard · Tasks · Schedule · AI). State management not yet added.

### Theme

Design system: **Lumina Focus** — Hyper-Minimal Glassmorphism. Font: **Geist** (variable TTF).

All colors, text styles, and spacing live in `MyTheme` (`lib/Widgets/Theme/my_theme.dart`). Never hardcode colors or fonts in widgets.

Spacing tokens (dp): `spaceXs` 4 · `spaceSm` 8 · `spaceMd` 16 · `spaceLg` 24 · `spaceXl` 40 · `space2xl` 64

Border-radius tokens (dp): `radiusSm` 4 · `radiusMd` 8 · `radiusLg` 16 · `radiusXl` 24

### Card pattern

`Colors.white` background · `elevation: 0.7` · `primaryColor.withAlpha(100)` shadow · `BorderRadius.circular(MyTheme.radiusLg)`

## Layout rules

- **Spacing between siblings** — `SizedBox(width/height: x)` in Row/Column; never pad individual children to create gaps
- **Padding** — outer and internal component padding only; never for inter-sibling spacing
- **Container** — only when decoration, constraints, or background styling is needed; use a `Padding` wrapper instead of `Container(margin: ...)`
- **Magic numbers** — avoid; prefer `MyTheme` spacing and radius tokens
- **Expanded / Spacer** — use intentionally, not as a default space-filler
