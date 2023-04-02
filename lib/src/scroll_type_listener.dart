import 'package:flutter/material.dart';

part 'scroll_type.dart';

/// A widget to detect if scrollable widget is
/// scrolled manually by user or
/// programatically by code.
class ScrollTypeListener extends StatefulWidget {
  const ScrollTypeListener({
    super.key,
    required this.onScroll,
    required this.child,
    this.onNotification,
    this.controller,
  });

  /// Widget that to be listened.
  /// All widget that is scrollable
  /// could be listened by this widget
  final Widget child;

  /// Callback that will be called when [child] is scrolled.
  /// The callback will be provide type of scrolling.
  final void Function(ScrollType type) onScroll;

  /// Callback that will be called when [child] is scrolled.
  /// The callback will be provide scroll notification.
  ///
  /// This [onNotification] callback is separated from [onScroll]
  /// callback to provide efficiency for user who needs only ScrollType
  /// information
  final void Function(ScrollNotification scrollNotification)? onNotification;

  /// Pass the [ScrollController] of the [child]
  /// if child widget will be programmatically scrolled
  final ScrollController? controller;

  @override
  State<ScrollTypeListener> createState() => _ScrollTypeListenerState();
}

class _ScrollTypeListenerState extends State<ScrollTypeListener> {
  int _scrollDeltaBuffer = 0;
  double _lastScrollDelta = 0;
  bool _isProgrammatic = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleNotification,
      child: widget.child,
    );
  }

  bool _handleNotification(ScrollNotification notification) {
    widget.onNotification?.call(notification);

    if (notification is ScrollStartNotification) {
      /* Reset notification buffer */
      _scrollDeltaBuffer = 0;
      _lastScrollDelta = 0;
      _isProgrammatic = notification.dragDetails == null;

      /* Call onScroll callback */
      widget.onScroll.call(
        notification.dragDetails == null
            ? ScrollType.programmatic
            : ScrollType.user,
      );
    }

    if (widget.controller == null) return false;

    if (notification is ScrollUpdateNotification && !_isProgrammatic) {
      if (_scrollDeltaBuffer < 4) {
        _scrollDeltaBuffer = _scrollDeltaBuffer + 1;
        _lastScrollDelta = notification.scrollDelta ?? 0;
      } else {
        final scrollDelta = notification.scrollDelta ?? 0;
        final difference = (_lastScrollDelta - scrollDelta).abs();
        _lastScrollDelta = notification.scrollDelta ?? 0;

        if (difference < 10) {
          _scrollDeltaBuffer = 0;
          return false;
        }

        if (_checkScrollActivity(widget.controller?.position)) {
          _isProgrammatic = true;
          widget.onScroll.call(ScrollType.programmatic);
        }
      }
    }

    return false;
  }

  bool _checkScrollActivity(ScrollPosition? scrollPosition) =>
      scrollPosition == null
          ? false
          : '$scrollPosition'
                  .split('ScrollActivity')[0]
                  .split(' ')
                  .last
                  .toLowerCase() ==
              'driven';
}
