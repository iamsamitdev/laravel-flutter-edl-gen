import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../logic/report_providers.dart';

/// Date range picker: ช่วงด่วน (7/30 วัน, เดือนนี้) + From/To + ปุ่ม Apply
class DateRangePage extends ConsumerStatefulWidget {
  const DateRangePage({super.key});

  @override
  ConsumerState<DateRangePage> createState() => _DateRangePageState();
}

class _DateRangePageState extends ConsumerState<DateRangePage> {
  DateTime _from = DateTime.now().subtract(const Duration(days: 7));
  DateTime _to = DateTime.now();

  static final _fmt = DateFormat('yyyy-MM-dd');

  void _setQuick(int days) => setState(() {
        _to = DateTime.now();
        _from = _to.subtract(Duration(days: days));
      });

  void _setThisMonth() => setState(() {
        final now = DateTime.now();
        _from = DateTime(now.year, now.month, 1);
        _to = now;
      });

  Future<void> _pick(bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isFrom ? _from : _to,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => isFrom ? _from = picked : _to = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.tr('dr_title'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.tr('dr_quick'),
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 13)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ActionChip(
                    label: Text(context.tr('dr_7')),
                    onPressed: () => _setQuick(7)),
                ActionChip(
                    label: Text(context.tr('dr_30')),
                    onPressed: () => _setQuick(30)),
                ActionChip(
                    label: Text(context.tr('dr_month')),
                    onPressed: _setThisMonth),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _DateField(
                    label: context.tr('dr_from'),
                    value: _fmt.format(_from),
                    onTap: () => _pick(true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DateField(
                    label: context.tr('dr_to'),
                    value: _fmt.format(_to),
                    onTap: () => _pick(false),
                  ),
                ),
              ],
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {
                ref.read(reportFilterStateProvider.notifier).setDateRange(
                      _fmt.format(_from),
                      _fmt.format(_to),
                    );
                context.pop();
              },
              child: Text(context.tr('dr_apply')),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField(
      {required this.label, required this.value, required this.onTap});

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5)),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: InputDecorator(
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Text(value, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
