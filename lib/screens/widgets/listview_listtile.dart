import 'package:flutter/material.dart';
import 'package:tracelog_app/models/location_entry.dart';
import 'package:tracelog_app/screens/widgets/listtile_location_widget.dart';

class ListviewListtile extends StatelessWidget {
  final List<LocationEntry> locations;
  const ListviewListtile({super.key, required this.locations});

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) {
      return const Center(child: Text('Belum ada lokasi tercatat.'));
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: locations.length,
      itemBuilder: (context, index) {
        return ListtileLocationWidget(location: locations[index]);
      },
    );
  }
}
