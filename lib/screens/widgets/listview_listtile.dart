import 'package:flutter/material.dart';
import 'package:tracelog_app/models/location_entry.dart';
import 'package:tracelog_app/screens/widgets/listtile_location_widget.dart';
import 'package:tracelog_app/utils/date_helper.dart';

class ListviewListtile extends StatelessWidget {
  final List<LocationEntry> locations;
  const ListviewListtile({super.key, required this.locations});

  @override
  Widget build(BuildContext context) {
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

              ListtileLocationWidget(location: item),
            ],
          );
        } else {
          return ListtileLocationWidget(location: item);
        }
      },
    );
  }
}
