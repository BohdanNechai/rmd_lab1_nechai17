import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab1_rmd/main.dart'; // Змініть на ім'я вашого проекту

void main() {
  // ignore: lines_longer_than_80_chars
  testWidgets('Input handles number addition and Avada Kedavra reset', (WidgetTester tester) async {
    // Збірка нашого віджету (MyHomePage)
    await tester.pumpWidget(const MyApp());

    // 1. ПЕРЕВІРКА: Лічильник починається з 0
    expect(find.text('0'), findsOneWidget);

    // 2. Дія: Введення числа (наприклад, 10)
    // Шукаємо поле вводу за його 'labelText' або 'hintText'
    final inputFinder = find.byType(TextField);
    expect(inputFinder, findsOneWidget);
    
    // Вводимо 10
    await tester.enterText(inputFinder, '10');
    
    // Знаходимо кнопку 'Process' або іконку 'Send'
    final processButtonFinder = find.byIcon(Icons.flash_on); 
    
    // Натискаємо кнопку для обробки вводу
    await tester.tap(processButtonFinder);
    await tester.pump(); // Перемальовуємо віджет

    // 3. ПЕРЕВІРКА: Лічильник збільшився до 10
    expect(find.text('0'), findsNothing);
    expect(find.text('10'), findsOneWidget);
    
    // 4. Дія: Введення "Avada Kedavra"
    await tester.enterText(inputFinder, 'Avada Kedavra');
    await tester.tap(processButtonFinder);
    await tester.pump(); 

    // 5. ПЕРЕВІРКА: Лічильник скинувся до 0
    expect(find.text('10'), findsNothing);
    expect(find.text('0'), findsOneWidget);
  });

}
