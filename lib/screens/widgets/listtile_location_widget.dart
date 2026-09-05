import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracelog_app/models/location_entry.dart';
import 'package:tracelog_app/screens/widgets/label_widget.dart';
import 'package:tracelog_app/screens/widgets/location_detail_sheet.dart';
import 'package:tracelog_app/utils/coordinates_convertion.dart';

class ListtileLocationWidget extends StatelessWidget {
  final LocationEntry location;
  const ListtileLocationWidget({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    String formattedDate = DateFormat('HH:mm').format(location.dateTime);
    String formattedCoordinate = CoordinatesConvertion.formattedCoordinates(
      location.position.latitude,
      location.position.longitude,
    );

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          builder: (BuildContext context) {
            return LocationDetailSheet(location: location);
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(color: colorScheme.outline),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorScheme.primary.withAlpha(30),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.location_on_outlined),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(formattedDate, style: textTheme.bodyMedium),
                      SizedBox(width: 4),
                      LabelWidget(isAutoTracked: location.isAutoTracked),
                    ],
                  ),

                  SizedBox(height: 2),

                  Text(
                    location.placemark?.street ?? 'Tidak ditemukan',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),

                  SizedBox(height: 2),

                  Text(
                    formattedCoordinate,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
