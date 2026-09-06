import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tracelog_app/providers/date_filter_provider.dart';
import 'package:tracelog_app/utils/date_helper.dart';

class FilterChipWidget extends ConsumerWidget {
  const FilterChipWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<DateTime> listDate = List.generate(7, (index) {
      return DateTime.now().subtract(Duration(days: index));
    });

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final filter = ref.watch(dateFilterProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
        children: [
          SizedBox(width: 12),
          FilterChip(
            backgroundColor: colorScheme.surfaceContainer,
            selectedColor: colorScheme.primary,
            selected: filter == null,
            showCheckmark: false,
            padding: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: colorScheme.outline),
            ),
            label: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'All',
                  style: textTheme.bodyLarge?.copyWith(
                    color: filter == null
                        ? colorScheme.outline
                        : colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  'Days',
                  style: textTheme.titleMedium?.copyWith(
                    color: filter == null
                        ? colorScheme.onPrimary
                        : colorScheme.primary,
                  ),
                ),
              ],
            ),
            onSelected: (value) {
              ref.read(dateFilterProvider.notifier).selectDate(null);
            },
          ),
          ...List.generate(listDate.length, (index) {
            String formattedDay = DateFormat('d').format(listDate[index]);
            String formattedDate = DateFormat('EEE').format(listDate[index]);
            final isSelected = filter?.isSameDate(listDate[index]) ?? false;
            return FilterChip(
              padding: EdgeInsets.all(5),
              backgroundColor: colorScheme.surfaceContainer,
              selectedColor: colorScheme.primary,
              showCheckmark: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: colorScheme.outline),
              ),
              // padding: EdgeInsets.all(3),
              label: Column(
                children: [
                  Text(
                    formattedDate,
                    style: textTheme.bodyLarge?.copyWith(
                      color: isSelected
                          ? colorScheme.outline
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    formattedDay,
                    style: textTheme.titleMedium?.copyWith(
                      color: isSelected
                          ? colorScheme.onPrimary
                          : colorScheme.primary,
                    ),
                  ),
                ],
              ),
              selected: isSelected,
              onSelected: (bool selected) {
                if (selected) {
                  ref
                      .read(dateFilterProvider.notifier)
                      .selectDate(listDate[index]);
                }
              },
            );
          }),

          SizedBox(width: 12),
        ],
      ),
    );
  }
}
