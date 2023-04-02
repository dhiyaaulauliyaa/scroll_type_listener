import 'package:example/detail_example/detail_example_base_page.dart';
import 'package:flutter/material.dart';

class SingleChildScrollViewPage extends StatelessWidget {
  const SingleChildScrollViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScrollViewPage(
      title: 'SingleChildScrollView',
      builder: (controller, children) => SingleChildScrollView(
        controller: controller,
        child: Column(children: children),
      ),
    );
  }
}

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScrollViewPage(
      title: 'ListView',
      builder: (controller, children) => ListView(
        controller: controller,
        children: children,
      ),
    );
  }
}

class ListViewBuilderPage extends StatelessWidget {
  const ListViewBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScrollViewPage(
      title: 'ListView.builder',
      builder: (controller, children) => ListView.builder(
        controller: controller,
        itemBuilder: (context, index) => children[index % 100],
      ),
    );
  }
}

class CustomScrollViewPage extends StatelessWidget {
  const CustomScrollViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScrollViewPage(
      title: 'CustomScrollView',
      builder: (controller, children) => CustomScrollView(
        controller: controller,
        slivers: children.map((e) => SliverToBoxAdapter(child: e)).toList(),
      ),
    );
  }
}

class ListWheelScrollViewPage extends StatelessWidget {
  const ListWheelScrollViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScrollViewPage(
      title: 'ListWheelScrollView',
      builder: (controller, children) => ListWheelScrollView(
        controller: controller,
        itemExtent: 50,
        children: List.generate(
          100,
          (index) => Container(
            width: double.infinity,
            color: index.isEven ? Colors.grey[200] : Colors.grey[300],
            alignment: Alignment.center,
            child: Text('$index'),
          ),
        ),
      ),
    );
  }
}

class ListWheelScrollViewBuilderPage extends StatelessWidget {
  const ListWheelScrollViewBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScrollViewPage(
      title: 'ListWheelScrollViewBuilder',
      builder: (controller, children) => ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 50,
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            return Container(
              width: double.infinity,
              color: index.isEven ? Colors.grey[200] : Colors.grey[300],
              alignment: Alignment.center,
              child: Text('$index'),
            );
          },
        ),
      ),
    );
  }
}

class GridViewPage extends StatelessWidget {
  const GridViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScrollViewPage(
      title: 'GridView',
      builder: (controller, children) => GridView(
        controller: controller,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: children,
      ),
    );
  }
}

class GridViewBuilderPage extends StatelessWidget {
  const GridViewBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScrollViewPage(
      title: 'GridViewBuilder',
      builder: (controller, children) => GridView.builder(
        controller: controller,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => children[index % 100],
      ),
    );
  }
}

class PageViewPage extends StatelessWidget {
  const PageViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScrollViewPage(
      title: 'PageView',
      returnIcon: Icons.arrow_back,
      controller: PageController(),
      builder: (controller, children) => PageView(
        controller: controller as PageController,
        children: children,
      ),
    );
  }
}

class PageViewBuilderPage extends StatelessWidget {
  const PageViewBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScrollViewPage(
      title: 'PageViewBuilder',
      returnIcon: Icons.arrow_back,
      controller: PageController(
        initialPage: 100,
      ),
      builder: (controller, children) => PageView.builder(
        controller: controller as PageController,
        itemBuilder: (context, index) => children[index % 100],
      ),
    );
  }
}
