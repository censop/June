import 'package:flutter/material.dart';
import 'package:june/Models/subtask.dart';
import 'package:june/Services/subtask_service.dart';
import 'package:june/Services/task_service.dart';
import 'package:june/Widgets/Schedule/impact_level.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

Future<bool?> showEditTaskDialog(
  BuildContext context, {
  required String taskId,
  required DateTime selectedDate,
  required String title,
  required String timeRange,
  required List<Subtask> subtasks,
  required ImpactLevel impact,
}) {
  return showDialog<bool>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    builder: (_) => _EditTaskDialog(
      taskId: taskId,
      selectedDate: selectedDate,
      title: title,
      timeRange: timeRange,
      subtasks: subtasks,
      impact: impact,
    ),
  );
}

TimeOfDay _parseTime(String s) {
  final parts = s.trim().split(' ');
  final timeParts = parts[0].split(':');
  var hour = int.parse(timeParts[0]);
  final minute = int.parse(timeParts[1]);
  final isPm = parts[1].toUpperCase() == 'PM';
  if (isPm && hour != 12) hour += 12;
  if (!isPm && hour == 12) hour = 0;
  return TimeOfDay(hour: hour, minute: minute);
}

(TimeOfDay, TimeOfDay) _parseTimeRange(String range) {
  final parts = range.split('–');
  if (parts.length == 2) {
    return (_parseTime(parts[0]), _parseTime(parts[1]));
  }
  return (const TimeOfDay(hour: 9, minute: 0), const TimeOfDay(hour: 10, minute: 0));
}

class _SubtaskEditEntry {
  final TextEditingController controller;
  bool done;
  _SubtaskEditEntry({required this.controller, this.done = false});
}

class _EditTaskDialog extends StatefulWidget {
  final String taskId;
  final DateTime selectedDate;
  final String title;
  final String timeRange;
  final List<Subtask> subtasks;
  final ImpactLevel impact;

  const _EditTaskDialog({
    required this.taskId,
    required this.selectedDate,
    required this.title,
    required this.timeRange,
    required this.subtasks,
    required this.impact,
  });

  @override
  State<_EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<_EditTaskDialog> {
  late final TextEditingController _titleController;
  late List<_SubtaskEditEntry> _subtaskEntries;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late String _impact;
  bool _saving = false;

  static const _impacts = ['Low Impact', 'High Impact'];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _subtaskEntries = widget.subtasks.isEmpty
        ? [_SubtaskEditEntry(controller: TextEditingController())]
        : widget.subtasks
            .map((s) => _SubtaskEditEntry(
                  controller: TextEditingController(text: s.title),
                  done: s.done,
                ))
            .toList();
    final (start, end) = _parseTimeRange(widget.timeRange);
    _startTime = start;
    _endTime = end;
    _impact = widget.impact == ImpactLevel.high ? 'High Impact' : 'Low Impact';
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (final e in _subtaskEntries) {
      e.controller.dispose();
    }
    super.dispose();
  }

  String _fmt(TimeOfDay t) {
    final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m ${t.period == DayPeriod.am ? 'AM' : 'PM'}';
  }

  Future<void> _pickTime(bool start) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: start ? _startTime : _endTime,
    );
    if (picked == null || !mounted) return;
    setState(() => start ? _startTime = picked : _endTime = picked);
  }

  DateTime _toDateTime(TimeOfDay t) => DateTime(
        widget.selectedDate.year,
        widget.selectedDate.month,
        widget.selectedDate.day,
        t.hour,
        t.minute,
      );

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;
    setState(() => _saving = true);
    try {
      await TaskService.update(
        id: widget.taskId,
        title: title,
        startsAt: _toDateTime(_startTime),
        endsAt: _toDateTime(_endTime),
      );
      await SubtaskService.deleteAllForTask(widget.taskId);
      for (final entry in _subtaskEntries) {
        final t = entry.controller.text.trim();
        if (t.isNotEmpty) {
          await SubtaskService.insert(
            taskId: widget.taskId,
            title: t,
            done: entry.done,
          );
        }
      }
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      debugPrint('Save task error: $e');
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    setState(() => _saving = true);
    try {
      await TaskService.delete(widget.taskId);
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      debugPrint('Delete task error: $e');
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MyTheme.radiusXl),
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: MyTheme.spaceLg,
        vertical: MyTheme.spaceXl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _EditHeader(onClose: () => Navigator.of(context).pop()),
          const Divider(height: 1, thickness: 1, color: MyTheme.surfaceDimColor),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(MyTheme.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel(theme, 'TASK TITLE'),
                  const SizedBox(height: MyTheme.spaceSm),
                  _EditOutlinedField(
                    controller: _titleController,
                    hint: 'What needs to be done?',
                  ),
                  const SizedBox(height: MyTheme.spaceLg),
                  _sectionLabel(theme, 'SUBTASKS'),
                  const SizedBox(height: MyTheme.spaceSm),
                  for (var i = 0; i < _subtaskEntries.length; i++) ...[
                    if (i > 0) const SizedBox(height: MyTheme.spaceXs),
                    _EditSubtaskRow(
                      key: ValueKey(i),
                      controller: _subtaskEntries[i].controller,
                      initialDone: _subtaskEntries[i].done,
                      onDoneChanged: (v) => _subtaskEntries[i].done = v,
                    ),
                  ],
                  const SizedBox(height: MyTheme.spaceSm),
                  GestureDetector(
                    onTap: () => setState(
                      () => _subtaskEntries.add(
                        _SubtaskEditEntry(controller: TextEditingController()),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.add, size: 18, color: MyTheme.primaryColor),
                        const SizedBox(width: MyTheme.spaceXs),
                        Text(
                          'Add another item',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: MyTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: MyTheme.spaceLg),
                  _sectionLabel(theme, 'TIME WINDOW'),
                  const SizedBox(height: MyTheme.spaceSm),
                  Row(
                    children: [
                      Expanded(
                        child: _EditTimeButton(
                          time: _fmt(_startTime),
                          onTap: () => _pickTime(true),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: MyTheme.spaceSm,
                        ),
                        child: Text(
                          '—',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: MyTheme.outlineColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _EditTimeButton(
                          time: _fmt(_endTime),
                          onTap: () => _pickTime(false),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: MyTheme.spaceLg),
                  _sectionLabel(theme, 'IMPACT LEVEL'),
                  const SizedBox(height: MyTheme.spaceSm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: MyTheme.spaceMd,
                      vertical: MyTheme.spaceXs,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(MyTheme.radiusLg),
                      border: Border.all(color: MyTheme.outlineVariantColor),
                    ),
                    child: DropdownButton<String>(
                      value: _impact,
                      onChanged: (v) => setState(() => _impact = v!),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: MyTheme.onSurfaceColor,
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: MyTheme.onSurfaceVariantColor,
                      ),
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      items: _impacts
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              MyTheme.spaceLg,
              0,
              MyTheme.spaceLg,
              MyTheme.spaceLg,
            ),
            child: Column(
              children: [
                _SaveButton(onPressed: _saving ? null : _save, saving: _saving),
                const SizedBox(height: MyTheme.spaceSm),
                GestureDetector(
                  onTap: _saving ? null : _delete,
                  child: Text(
                    'DELETE TASK',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: _saving ? Colors.redAccent.withValues(alpha: 0.4) : Colors.redAccent,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(ThemeData theme, String text) => Text(
    text,
    style: theme.textTheme.labelLarge?.copyWith(
      color: MyTheme.onSurfaceVariantColor,
      letterSpacing: 1.0,
    ),
  );
}

class _EditHeader extends StatelessWidget {
  final VoidCallback onClose;
  const _EditHeader({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        MyTheme.spaceLg,
        MyTheme.spaceLg,
        MyTheme.spaceSm,
        MyTheme.spaceMd,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Edit Task',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 20),
            color: MyTheme.onSurfaceVariantColor,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

class _EditOutlinedField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const _EditOutlinedField({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      style: theme.textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(color: MyTheme.outlineColor),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: MyTheme.spaceMd,
          vertical: MyTheme.spaceSm + MyTheme.spaceXs,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyTheme.radiusLg),
          borderSide: const BorderSide(color: MyTheme.outlineVariantColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyTheme.radiusLg),
          borderSide: const BorderSide(color: MyTheme.primaryColor),
        ),
      ),
    );
  }
}

class _EditSubtaskRow extends StatefulWidget {
  final TextEditingController controller;
  final bool initialDone;
  final void Function(bool) onDoneChanged;

  const _EditSubtaskRow({
    super.key,
    required this.controller,
    this.initialDone = false,
    required this.onDoneChanged,
  });

  @override
  State<_EditSubtaskRow> createState() => _EditSubtaskRowState();
}

class _EditSubtaskRowState extends State<_EditSubtaskRow> {
  late bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.initialDone;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() => _checked = !_checked);
            widget.onDoneChanged(_checked);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(MyTheme.radiusSm),
              color: _checked ? MyTheme.primaryColor : Colors.transparent,
                border: Border.all(
                  color: _checked ? MyTheme.primaryColor : MyTheme.outlineVariantColor,
                  width: 1.5,
                ),
              ),
              child: _checked
                  ? const Icon(Icons.check, size: 11, color: Colors.white)
                  : null,
          ),
        ),
        const SizedBox(width: MyTheme.spaceSm),
        Expanded(
          child: TextField(
            controller: widget.controller,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: 'Add a subtask step...',
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: MyTheme.outlineColor,
              ),
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}

class _EditTimeButton extends StatelessWidget {
  final String time;
  final VoidCallback onTap;
  const _EditTimeButton({required this.time, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: MyTheme.spaceMd,
          vertical: MyTheme.spaceSm + MyTheme.spaceXs,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MyTheme.radiusLg),
          border: Border.all(color: MyTheme.outlineVariantColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(time, style: Theme.of(context).textTheme.bodyMedium),
            ),
            const Icon(
              Icons.access_time_rounded,
              size: 18,
              color: MyTheme.onSurfaceVariantColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool saving;
  const _SaveButton({required this.onPressed, required this.saving});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              saving
                  ? MyTheme.primaryColor.withValues(alpha: 0.5)
                  : MyTheme.primaryColor,
              saving
                  ? MyTheme.secondaryContainerColor.withValues(alpha: 0.5)
                  : MyTheme.secondaryContainerColor,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(MyTheme.radiusLg),
        ),
        alignment: Alignment.center,
        child: saving
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Text(
                'Save Changes',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
