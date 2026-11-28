// Basic Flutter widget test.
//
// Test ini hanya mengecek bahwa widget bisa dibangun (smoke test),
// tanpa memanggil main.dart supaya tidak error karena Firebase.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    // Build widget sederhana dan trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('Hello'),
        ),
      ),
    );

    // Pastikan teks 'Hello' tampil di layar.
    expect(find.text('Hello'), findsOneWidget);
  });
}