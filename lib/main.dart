import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lab 1: Interactive Input',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Interactive Counter with Input'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    required this.title,
    super.key,
  }); // Використовуємо 'required' та 'super.key' на початку

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  // Створення контролера для TextField
  final TextEditingController _inputController = TextEditingController();
  String _message = 'Enter a number or "Avada Kedavra" to interact.';

  // Головний метод обробки введення
  void _processInput() {
    // 1. Отримати та очистити текст
    final String inputText = _inputController.text.trim();

    // Перевірка 1: Магічне слово (без урахування регістру)
    if (inputText.toLowerCase() == 'avada kedavra') {
      setState(() {
        _counter = 0;
        _message = '💀 Spell Activated! Counter reset.';
      });
    } else {
      // Перевірка 2: Спроба конвертувати в число
      final int? number = int.tryParse(inputText);

      if (number != null) {
        // Якщо число, додаємо його до лічильника
        setState(() {
          _counter += number;
          _message = '✨ Added $number to the counter.';
        });
      } else {
        // Якщо не число і не магічне слово
        setState(() {
          _message = '❌ Invalid input. Please enter a number or the correct spell.';
        });
      }
    }

    // Очищення поля вводу
    _inputController.clear();
  }

  // Обов'язково очищаємо контролер, щоб уникнути витоку пам'яті
  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Повідомлення для користувача
              Text(
                _message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              // Відображення лічильника
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 30),
              // >>> Інтерактивне поле вводу <<<
              TextField(
                controller: _inputController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Enter Value',
                  hintText: 'Number or Spell',
                  border: const OutlineInputBorder(),
                  // Кнопка для відправки даних
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _processInput,
                  ),
                ),
                // Обробка натискання Enter
                onSubmitted: (_) => _processInput(),
              ),
            ],
          ),
        ),
      ),
      // Кнопка FloatingActionButton тепер також викликає _processInput
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _processInput,
        tooltip: 'Process Input',
        label: const Text('Process'),
        icon: const Icon(Icons.flash_on),
      ),
    );
  }
}