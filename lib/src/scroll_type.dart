part of 'scroll_type_listener.dart';

enum ScrollType {
  user,
  programmatic;

  bool get isUserScroll => this == ScrollType.user;
  bool get isProgrammaticScroll => this == ScrollType.programmatic;

  @override
  String toString() {
    switch (this) {
      case ScrollType.user:
        return 'User Scroll';
      case ScrollType.programmatic:
        return 'Programmatic Scroll';
    }
  }
}
