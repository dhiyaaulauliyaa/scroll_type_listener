import 'package:flutter/material.dart';
import 'package:scroll_type_listener/scroll_type_listener.dart';

class BaseScrollViewPage extends StatefulWidget {
  const BaseScrollViewPage({
    super.key,
    required this.title,
    required this.builder,
    this.controller,
    this.returnIcon = Icons.arrow_upward,
  });

  final String title;
  final ScrollController? controller;
  final IconData returnIcon;
  final Widget Function(
    ScrollController controller,
    List<Widget> children,
  ) builder;

  @override
  State<BaseScrollViewPage> createState() => _BaseScrollViewPageState();
}

class _BaseScrollViewPageState extends State<BaseScrollViewPage> {
  late final ScrollController scrollController;

  ScrollType? scrollType;
  ScrollNotification? scrollNotification;

  @override
  void initState() {
    super.initState();
    scrollController = widget.controller ?? ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: FloatingActionButton(
        child: Icon(widget.returnIcon),
        onPressed: () {
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCirc,
          );
        },
      ),
      body: Stack(
        children: [
          /// Implement ScrollTypeListener on ScrollView
          ScrollTypeListener(
            /// Send child's ScrollController to the ScrollTypeListener
            /// if programmatic scroll will be triggered
            controller: scrollController,

            /// OnScroll will provide scroll type
            /// (user scroll/programmatic scroll)
            onScroll: (type) => type != scrollType
                ? setState(
                    () => scrollType = type,
                  )
                : null,

            /// OnNotification will provide scroll notification
            onNotification: (notification) => notification != scrollNotification
                ? setState(
                    () => scrollNotification = notification,
                  )
                : null,

            /// ScrollTypeListener child must be a ScrollView
            child: widget.builder(
              scrollController,
              List.generate(
                100,
                (index) => ListTile(
                  title: Text('$index'),
                  tileColor: index.isEven ? Colors.grey[200] : Colors.grey[300],
                ),
              ),
            ),
          ),

          _NotifierTitle(
            topOffset: 20,
            title: scrollType?.toString(),
          ),
          _NotifierTitle(
            topOffset: 75,
            title: '${scrollNotification?.runtimeType ?? 'Not Scrolled'}',
          ),
        ],
      ),
    );
  }
}

class _NotifierTitle extends StatelessWidget {
  const _NotifierTitle({
    required this.topOffset,
    required this.title,
  });

  final double topOffset;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      top: topOffset,
      child: Text(
        title ?? 'Not Scrolled',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
