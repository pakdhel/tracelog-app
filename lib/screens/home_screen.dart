import 'package:flutter/material.dart';
import 'package:tracelog_app/screens/widgets/checkbox_tracking_widget.dart';
import 'package:tracelog_app/screens/widgets/listtile_location_widget.dart';
import 'package:tracelog_app/screens/widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 36),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TRACELOG',
                      style: textTheme.labelMedium?.copyWith(
                        letterSpacing: 1.1,
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text('Location History', style: textTheme.headlineMedium),
                  ],
                ),

                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer,
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.outline),
                  ),
                  child: Icon(Icons.dark_mode_outlined),
                ),
              ],
            ),

            SizedBox(height: 12),

            CheckboxTrackingWidget(),

            SizedBox(height: 12),

            SearchWidget(),

            SizedBox(height: 12),

            Row(
              children: [
                Text('Monday, 24 Aug 2026', style: textTheme.titleMedium),
                const Spacer(),
                Text(
                  '3 stops',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),

            ListtileLocationWidget(),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(100),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
