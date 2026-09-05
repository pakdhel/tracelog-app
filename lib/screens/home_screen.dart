import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracelog_app/api/geolocator_service.dart';
import 'package:tracelog_app/providers/auto_track_provider.dart';
import 'package:tracelog_app/providers/list_location_provider.dart';
import 'package:tracelog_app/providers/theme_provider.dart';
import 'package:tracelog_app/screens/widgets/checkbox_tracking_widget.dart';
import 'package:tracelog_app/screens/widgets/listview_listtile.dart';
import 'package:tracelog_app/screens/widgets/search_widget.dart';
import 'package:tracelog_app/static/location_exception.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final geolocatorService = GeolocatorService();
  void _showLocationErrorSnackbar(BuildContext context, AsyncValue next) {
    if (next.hasError && !next.isLoading) {
      final error = next.error;
      if (error is LocationException) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.hideCurrentSnackBar();
        messenger.showSnackBar(
          SnackBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            content: Row(
              children: [
                Expanded(
                  child: Text(
                    error.message,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    minimumSize: Size.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () async {
                    await geolocatorService.openAppSettings();
                  },
                  child: const Text(
                    'Settings',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onResume: () {
        ref.invalidate(listLocationProvider);
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final listLocationAsync = ref.watch(listLocationProvider);
    final theme = ref.watch(themeProvider);
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    ref.listen(
      listLocationProvider,
      (previous, next) => _showLocationErrorSnackbar(context, next),
    );

    ref.listen(
      autoTrackProvider,
      (previous, next) => _showLocationErrorSnackbar(context, next),
    );

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
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),

                GestureDetector(
                  onTap: () => ref.read(themeProvider.notifier).toggleTheme(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainer,
                      shape: BoxShape.circle,
                      border: Border.all(color: colorScheme.outline),
                    ),
                    child: switch (theme.value) {
                      ThemeMode.light => Icon(Icons.dark_mode_outlined),
                      ThemeMode.dark => Icon(Icons.light_mode_outlined),
                      _ =>
                        (brightness == Brightness.light
                            ? Icon(Icons.dark_mode_outlined)
                            : Icon(Icons.light_mode_outlined)),
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            CheckboxTrackingWidget(),

            SizedBox(height: 12),

            SearchWidget(),

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
            : () => ref
                  .read(listLocationProvider.notifier)
                  .addListLocation(false),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(100),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
