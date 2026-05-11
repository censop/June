# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
flutter run                          # Run on connected device/emulator
flutter run -d windows               # Run on Windows desktop
flutter build apk                    # Build Android APK
flutter analyze                      # Lint (uses flutter_lints)
flutter test                         # Run all tests
flutter test test/some_test.dart     # Run a single test file
flutter pub get                      # Install dependencies
flutter clean                        # Clean build artifacts
```

## Architecture

**june** is a Flutter daily planner app. The project is early-stage — `HomePage` currently uses dummy data and state management has not been added yet.

### Directory layout

```
lib/
  main.dart          # Entry point; MaterialApp with routeObserver and lightTheme
  routes.dart        # Routes class with static string constants
  Models/
    task.dart        # Task (taskName, description, startTime/endTime as TimeOfDay, isCompleted)
    day.dart         # Day (date, List<Task>); exposes dayNumber/shortName/longName getters
  Utils/
    format_utils.dart  # FormatUtils: TimeOfDay <-> "HH:mm" string conversion
  Widgets/
    Theme/
      my_theme.dart  # MyTheme: all colors, text styles, and lightTheme in one place
    Cards/
      task_card.dart # TaskCard: name + time range + circular checkbox
      day_card.dart  # DayCard: short day name, day number, long name, task count
    Screens/
      home_page.dart # HomePage (StatefulWidget, currently shows dummy Task and Day)
```

### Theme system

All colors and text styles are defined in `MyTheme` (`lib/Widgets/Theme/my_theme.dart`). Reference them via `Theme.of(context)` — never hardcode colors or fonts in widgets.

| Token | Value | Semantic use |
|---|---|---|
| `primaryColor` | `#1D8EF5` | Interactive / accent |
| `secondaryColor` | `#F8FAFC` | Light backgrounds |
| `tertiaryColor` | `#E2E8F0` | Borders / dividers |
| `neutralColor` | `#1E293B` | Default text |

Text style slots (from `TextTheme`):
- `headlineMedium` — major page headers
- `titleLarge` — app bar titles / important names
- `titleMedium` — list items / task names
- `bodyMedium` — standard body text
- `labelLarge` — section headers (UPPERCASE in widget via `.toUpperCase()`)
- `labelMedium` — time blocks, nav items
- `labelSmall` — tiny tags, badges (e.g. "FRI")

### Data models

Both `Task` and `Day` are immutable value objects with `copyWith`, `toMap`, and `fromMap`. `TimeOfDay` is serialized as `"HH:mm"` strings via `FormatUtils`.

### Navigation

Routes are string constants in `Routes`. A `RouteObserver<PageRoute>` (`routeObserver`) is wired into `MaterialApp.navigatorObservers` for future use.

### Card widget pattern

Cards use `Colors.white` background, `elevation: 0.7`, `primaryColor.withAlpha(100)` shadow, and `BorderRadius.circular(16)`. Follow this pattern for new card widgets.
