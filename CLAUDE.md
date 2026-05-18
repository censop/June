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

**june** is a Flutter daily planner app. `AppShell` hosts the 4-tab `BottomNavigationBar` (Dashboard · Tasks · Schedule · AI). State management not yet added — each page manages its own state with `setState`.

Backend: **Supabase**. The global client lives in `lib/main.dart` and is accessed directly by service classes.

### Data Models

**`Task`** (`lib/Models/task.dart`) — fields: `id`, `title`, `startsAt`, `endsAt`, `status` (`'pending'` | `'completed'`), `userId`. Helpers: `isCompleted` getter, `timeRange` getter (12-hour format), `fromJson`, `copyWith`.

**`Day`** (`lib/Models/day.dart`) — wraps a `DateTime` with a `List<Task>`. Helpers: `dayNumber`, `shortName` (MON–SUN), `longName`, `copyWith`.

### Services

**`TaskService`** (`lib/Services/task_service.dart`) — static Supabase-backed service:
- `fetchForDate(DateTime)` — queries `tasks` table filtered by `user_id` and `starts_at` day range, ordered by `starts_at`
- `insert({title, startsAt, endsAt})` — inserts a new task with `status: 'pending'`
- `updateStatus(id, status)` — patches `status` on a single task

Supabase `tasks` table columns: `id`, `title`, `starts_at`, `ends_at`, `status`, `user_id`.

### Schedule page

`ScheduleBody` (`lib/Widgets/Schedule/schedule_body.dart`) is the live, Supabase-connected schedule view. It generates a 60-day window (14 days back, 46 forward), loads tasks for the selected day via `TaskService.fetchForDate`, and handles completion toggling via `TaskService.updateStatus`.

- **`ScheduleHeader`** (`lib/Widgets/Schedule/schedule_header.dart`) — shows "Schedule" title + two icon buttons: Google Calendar (stubbed) and add-task (opens `showNewTaskDialog`). Accepts `selectedDate` and `onTaskCreated` callback.
- **`showNewTaskDialog`** (`lib/Widgets/Schedule/new_task_sheet.dart`) — modal dialog to create a task. Fields: title, subtasks (UI-only, not persisted to Supabase), time window (start/end `TimeOfDay`), impact level dropdown (not persisted). Saves via `TaskService.insert`.
- **`ScheduleTaskCard`** (`lib/Widgets/Schedule/schedule_task_card.dart`) — card with left accent bar (teal = completed, primary = pending), title + time range, completion circle toggle, subtask list with per-item checkboxes, impact level badge (`ImpactLevel.high` / `.low`) with `PopupMenuButton`. Tap opens `showEditTaskDialog`.

### Other widgets

**`TaskCard`** (`lib/Widgets/Cards/task_card.dart`) — simpler card used on the Dashboard; accepts a `Task` and renders title + time range with a circular checkbox. Has an `isCurrentTask()` helper.

**`old_home_page.dart`** (`lib/Widgets/Pages/NavigationBar/old_home_page.dart`) — legacy `HomePage` kept for reference; uses an empty in-memory task list and is not connected to Supabase.

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
