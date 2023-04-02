import 'package:example/detail_example/detail_example_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:scroll_type_listener/scroll_type_listener.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scroll Type Listener',
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scroll Type Listener')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Simple Example'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<Widget>(
                builder: (_) => const SimpleExamplePage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SimpleExamplePage extends StatefulWidget {
  const SimpleExamplePage({super.key});

  @override
  State<SimpleExamplePage> createState() => _SimpleExamplePageState();
}

class _SimpleExamplePageState extends State<SimpleExamplePage> {
  final scrollCtrl = ScrollController();
  ScrollType? scrollType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scroll Type Listener')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_upward),
        onPressed: () {
          scrollCtrl.animateTo(
            0,
            duration: const Duration(milliseconds: 5000),
            curve: Curves.easeOutCirc,
          );
        },
      ),
      body: ScrollTypeListener(
        controller: scrollCtrl,
        onScroll: (type) {
          if (type != scrollType) {
            setState(() => scrollType = type);
          }
        },
        child: ListView(
          controller: scrollCtrl,
          children: List.generate(
            100,
            (index) => ListTile(
              title: Text('$index'),
              trailing: Text(scrollType?.toString() ?? 'Not Scrolled'),
              tileColor: index.isEven ? Colors.grey[200] : Colors.grey[300],
            ),
          ),
        ),
      ),
    );
  }
}
