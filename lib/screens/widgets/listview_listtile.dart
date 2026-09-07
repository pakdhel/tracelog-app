import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracelog_app/models/location_entry.dart';
import 'package:tracelog_app/providers/active_delete_item_provider.dart';
import 'package:tracelog_app/screens/widgets/listtile_location_widget.dart';
import 'package:tracelog_app/utils/date_helper.dart';

class ListviewListtile extends ConsumerWidget {
  final List<LocationEntry> locations;
  const ListviewListtile({super.key, required this.locations});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // final locationId = ref.watch(activeDeleteItemProvider);

    if (locations.isEmpty) {
      return const Center(child: Text('Belum ada lokasi tercatat.'));
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: locations.length,
      itemBuilder: (context, index) {
        bool isSameDate = true;
        final date = locations[index].dateTime;
        final item = locations[index];
        if (index == 0) {
          isSameDate = false;
        } else {
          final prevDate = locations[index - 1].dateTime;
          isSameDate = date.isSameDate(prevDate);
        }

        Widget itemTileWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListtileLocationWidget(
              location: item,
              valueChanged: (value) {
                ref
                    .read(activeDeleteItemProvider.notifier)
                    .setActiveItem(value);
              },
            ),

            Consumer(
              builder: (context, ref, child) {
                final locationId = ref.watch(activeDeleteItemProvider);
                return locationId == locations[index].id
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {},
                          child: Row(
                            spacing: 5,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.delete_outlined),
                              Text(
                                'Delete',
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(height: 10);
              },
            ),
          ],
        );

        if (index == 0 || (!isSameDate)) {
          final stops = locations
              .where((location) => location.dateTime.isSameDate(date))
              .length;
          return Column(
            children: [
              Row(
                children: [
                  Text(
                    date.formatDate(),
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$stops stops',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),
              itemTileWidget,
            ],
          );
        } else {
          return itemTileWidget;
        }
      },
    );
  }
}
