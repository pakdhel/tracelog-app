import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracelog_app/models/location_entry.dart';
import 'package:tracelog_app/screens/widgets/label_widget.dart';
import 'package:tracelog_app/screens/widgets/map_preview_widget.dart';
import 'package:tracelog_app/utils/coordinates_convertion.dart';

class LocationDetailSheet extends StatelessWidget {
  final LocationEntry location;
  const LocationDetailSheet({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    String formattedDate = DateFormat('HH:mm').format(location.dateTime);
    String formattedCoordinate = CoordinatesConvertion.formattedCoordinates(
      location.position.latitude,
      location.position.longitude,
    );
    return Container(
      height: 400,
      padding: EdgeInsets.only(right: 20, left: 20, top: 16),
      child: Column(
        children: [
          Container(
            height: 6,
            width: 42,
            decoration: BoxDecoration(
              color: colorScheme.outline,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(formattedDate, style: textTheme.bodyLarge),
                        SizedBox(width: 8),
                        LabelWidget(isAutoTracked: location.isAutoTracked),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      location.placemark?.street ?? 'Tidak ditemukan',
                      style: textTheme.titleMedium,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 40,
                width: 40,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close_rounded),
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$formattedCoordinate · Accuracy ±${location.position.accuracy.round()} m ',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),

          SizedBox(height: 8),

          SizedBox(
            height: 240,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: MapPreviewWidget(
                latitude: location.position.latitude,
                longitude: location.position.longitude,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
