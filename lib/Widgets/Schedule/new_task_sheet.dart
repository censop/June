import 'package:flutter/material.dart';
import 'package:june/Services/subtask_service.dart';
import 'package:june/Services/task_service.dart';
import 'package:june/Widgets/Theme/my_theme.dart';

Future<bool?> showNewTaskDialog(
  BuildContext context, {
  required DateTime selectedDate,
}) {
  return showDialog<bool>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    builder: (_) => _NewTaskDialog(selectedDate: selectedDate),
  );
}

class _NewTaskDialog extends StatefulWidget {
  final DateTime selectedDate;

  const _NewTaskDialog({required this.selectedDate});

  @override
  State<_NewTaskDialog> createState() => _NewTaskDialogState();
}

class _NewTaskDialogState extends State<_NewTaskDialog> {
  final _titleController = TextEditingController();
  final List<TextEditingController> _subtaskControllers = [TextEditingController()];
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 30);
  String _impact = 'Medium Impact';
  bool _saving = false;

  static const _impacts = ['Low Impact', 'Medium Impact', 'High Impact'];

  @override
  void dispose() {
    _titleController.dispose();
    for (final c in _subtaskControllers) {
      c.dispose();
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
      final taskId = await TaskService.insert(
        title: title,
        startsAt: _toDateTime(_startTime),
        endsAt: _toDateTime(_endTime),
      );
      final subtaskTitles = _subtaskControllers
          .map((c) => c.text.trim())
          .where((t) => t.isNotEmpty)
          .toList();
      for (final t in subtaskTitles) {
        await SubtaskService.insert(taskId: taskId, title: t);
      }
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      debugPrint('Save task error: $e');
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
          _Header(onClose: () => Navigator.of(context).pop()),
          const Divider(height: 1, thickness: 1, color: MyTheme.surfaceDimColor),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(MyTheme.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel(theme, 'TASK TITLE'),
                  const SizedBox(height: MyTheme.spaceSm),
                  _OutlinedField(
                    controller: _titleController,
                    hint: 'What needs to be done?',
                  ),
                  const SizedBox(height: MyTheme.spaceLg),
                  _sectionLabel(theme, 'SUBTASKS'),
                  const SizedBox(height: MyTheme.spaceSm),
                  for (var i = 0; i < _subtaskControllers.length; i++) ...[
                    if (i > 0) const SizedBox(height: MyTheme.spaceXs),
                    _SubtaskRow(
                      key: ValueKey(i),
                      controller: _subtaskControllers[i],
                    ),
                  ],
                  const SizedBox(height: MyTheme.spaceSm),
                  GestureDetector(
                    onTap: () => setState(
                      () => _subtaskControllers.add(TextEditingController()),
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
                        child: _TimeButton(
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
                        child: _TimeButton(
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
                _GradientButton(onPressed: _saving ? null : _save, saving: _saving),
                const SizedBox(height: MyTheme.spaceSm),
                Text(
                  'ESC TO CANCEL  •  ENTER TO SAVE',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: MyTheme.outlineColor,
                    letterSpacing: 1.2,
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

class _Header extends StatelessWidget {
  final VoidCallback onClose;
  const _Header({required this.onClose});

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
              'New Task',
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

class _OutlinedField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const _OutlinedField({required this.controller, required this.hint});

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

class _SubtaskRow extends StatefulWidget {
  final TextEditingController controller;
  const _SubtaskRow({super.key, required this.controller});

  @override
  State<_SubtaskRow> createState() => _SubtaskRowState();
}

class _SubtaskRowState extends State<_SubtaskRow> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() => _checked = !_checked),
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

class _TimeButton extends StatelessWidget {
  final String time;
  final VoidCallback onTap;
  const _TimeButton({required this.time, required this.onTap});

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

class _GradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool saving;
  const _GradientButton({required this.onPressed, required this.saving});

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
                'Create Task',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
