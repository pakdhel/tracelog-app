import 'package:flutter/material.dart';

class ListtileLocationWidget extends StatelessWidget {
  const ListtileLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('07:42', style: textTheme.bodyMedium),
                  SizedBox(width: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.withAlpha(50),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      'Auto-tracked',
                      style: textTheme.labelSmall?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 2),

              Text(
                'Jl. Sudirman No. 45, Jakarta Pusat',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                ),
              ),

              SizedBox(height: 2),

              Text(
                '-6.2088° S, 106.8456° E · ±12 m',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
