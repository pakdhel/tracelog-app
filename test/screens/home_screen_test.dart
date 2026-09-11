import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:tracelog_app/main.dart';
import 'package:tracelog_app/screens/home_screen.dart';

void main() {
  testWidgets('Menemukan FAB pada home screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(child: MaterialApp(home: HomeScreen())),
    );

    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Menemukan teks TRACELOG dan Location History di home screen', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: MaterialApp(home: HomeScreen())),
    );

    expect(find.text('TRACELOG'), findsOneWidget);
    expect(find.text('Location History'), findsOneWidget);
  });
}
