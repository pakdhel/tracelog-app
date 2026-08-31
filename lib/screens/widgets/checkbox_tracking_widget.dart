import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracelog_app/providers/auto_track_provider.dart';

class CheckboxTrackingWidget extends ConsumerWidget {
  const CheckboxTrackingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final autoTrack = ref.watch(autoTrackProvider);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surfaceContainer,
            ),
            child: Icon(Icons.my_location, size: 16),
          ),

          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Background Auto-Tracking',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),

              Text(
                '1× daily minimum',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),

          const Spacer(),

          Switch(
            value: switch (autoTrack.value) {
              true => true,
              false => false,
              _ => false 
            },
            onChanged: (value) =>
                ref.read(autoTrackProvider.notifier).toggleAutoTracking(value),
          ),
        ],
      ),
    );
  }
}
