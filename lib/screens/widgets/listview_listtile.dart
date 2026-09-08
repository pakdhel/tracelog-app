import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tracelog_app/models/location_entry.dart';
import 'package:tracelog_app/providers/active_delete_item_provider.dart';
import 'package:tracelog_app/providers/list_location_provider.dart';
import 'package:tracelog_app/screens/widgets/listtile_location_widget.dart';
import 'package:tracelog_app/utils/date_helper.dart';

class ListviewListtile extends ConsumerWidget {
  final List<LocationEntry> locations;
  const ListviewListtile({super.key, required this.locations});

  Future<void> dialogBuilder(
    BuildContext context,
    LocationEntry location,
    WidgetRef ref,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return showDialog(
      context: context,
      barrierColor: colorScheme.primary.withAlpha(100),
      builder: (BuildContext context) {
        String formattedTime = DateFormat('HH:mm').format(location.dateTime);
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.redAccent.withAlpha(50),
                ),
                child: Icon(
                  Icons.delete_outline,
                  size: 30,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(height: 12),
              Text('Delete this location?', style: textTheme.headlineMedium),
            ],
          ),

          content: Text(
            'Are you sure you want to remove the log at $formattedTime - ${location.placemark?.street}',
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // icon:
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: colorScheme.outline),
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: textTheme.bodyLarge),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: colorScheme.outline),
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () {
                ref
                    .read(listLocationProvider.notifier)
                    .removeLocationById(location.id!);

                Navigator.pop(context);
              },
              child: Text(
                'Delete',
                style: textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

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
                          onPressed: () {
                            ref
                                .read(activeDeleteItemProvider.notifier)
                                .setActiveItem(null);
                            dialogBuilder(context, locations[index], ref);
                          },
                          child: Row(
                            spacing: 5,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.delete_outlined),
                              Text(
                                'Delete',
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
