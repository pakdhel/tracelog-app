import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracelog_app/providers/list_location_provider.dart';
import 'package:tracelog_app/screens/widgets/checkbox_tracking_widget.dart';
import 'package:tracelog_app/screens/widgets/listview_listtile.dart';
import 'package:tracelog_app/screens/widgets/search_widget.dart';
import 'package:tracelog_app/static/location_permission_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final listLocationAsync = ref.watch(listLocationProvider);

    ref.listen(listLocationProvider, (previous, next) {
      if (next.hasError) {
        final error = next.error;
        if (error is LocationException) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 2),
              content: Text(error.message),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          right: 20.0,
          left: 20,
          top: 48,
          // bottom: 24,
        ),
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

                    Text(
                      'Location History',
                      style: textTheme.headlineMedium?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
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

            SizedBox(height: 12),

            Expanded(
              child: listLocationAsync.when(
                skipLoadingOnReload: true,
                error: (err, stack) => listLocationAsync.value != null
                    ? ListviewListtile(locations: listLocationAsync.value!)
                    : Text('Error $err'),
                loading: () => listLocationAsync.value != null
                    ? ListviewListtile(locations: listLocationAsync.value!)
                    : Center(child: CircularProgressIndicator()),
                data: (locations) => ListviewListtile(locations: locations),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: listLocationAsync.isLoading
            ? colorScheme.primary.withAlpha(200)
            : colorScheme.primary,
        elevation: 1,
        onPressed: listLocationAsync.isLoading
            ? null
            : () => ref.read(listLocationProvider.notifier).addListLocation(),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(100),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
