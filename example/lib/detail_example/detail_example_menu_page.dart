import 'package:example/detail_example/detail_example_list_tile.dart';
import 'package:example/detail_example/detail_example_pages.dart';
import 'package:flutter/material.dart';

class DetailExampleMenuPage extends StatelessWidget {
  const DetailExampleMenuPage({super.key});

  static const examplePageTitles = [
    'SingleChildScrollView',
    'ListView',
    'ListView.builder',
    'CustomScrollView',
    'ListWheelScrollView',
    'ListWheelScrollViewBuilder',
    'GridView',
    'GridViewBuilder',
    'PageView',
    'PageViewBuilder',
  ];

  static const examplePageWidgets = [
    SingleChildScrollViewPage(),
    ListViewPage(),
    ListViewBuilderPage(),
    CustomScrollViewPage(),
    ListWheelScrollViewPage(),
    ListWheelScrollViewBuilderPage(),
    GridViewPage(),
    GridViewBuilderPage(),
    PageViewPage(),
    PageViewBuilderPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scroll Type Listener')),
      body: ListView(
        children: List.generate(
          examplePageWidgets.length,
          (index) => DetailExampleListTile(
            title: examplePageTitles[index],
            page: examplePageWidgets[index],
          ),
        ),
      ),
    );
  }
}
