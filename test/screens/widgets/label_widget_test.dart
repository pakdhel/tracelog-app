import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracelog_app/screens/widgets/label_widget.dart';

void main() {
  testWidgets('Harus menemukan teks Auto-tracked jika isAutoTracked: true', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: LabelWidget(isAutoTracked: true))),
    );

    expect(find.text('Auto-tracked'), findsOneWidget);
  });

  testWidgets('Harus menemukan teks Manual jika isAutoTracked: false', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: LabelWidget(isAutoTracked: false))),
    );

    expect(find.text('Manual'), findsOneWidget);
  });

  testWidgets(
    'Warna container harus colorScheme.secondaryContainer jika isAutoTracked: true',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: LabelWidget(isAutoTracked: true))),
      );

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final colorScheme = Theme.of(
        tester.element(find.byType(LabelWidget)),
      ).colorScheme; // tester.elemen untuk mengambil BuildContext

      final container = tester.widget<Container>(containerFinder);

      final decoration = container.decoration as BoxDecoration;

      expect(decoration.color, colorScheme.secondaryContainer);
    },
  );

  testWidgets(
    'Warna container harus colorScheme.tertiaryContainer jika isAutoTracked: false',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: LabelWidget(isAutoTracked: false))),
      );

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final colorScheme = Theme.of(
        tester.element(find.byType(LabelWidget)),
      ).colorScheme;

      final container = tester.widget<Container>(containerFinder);

      final decoration = container.decoration as BoxDecoration;

      expect(decoration.color, colorScheme.tertiaryContainer);
    },
  );
}
