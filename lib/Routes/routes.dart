part of 'pages.dart';

abstract class Routes {
  static const root = _Paths.root;
  static const signInView = _Paths.signInView;
  static const homeView = _Paths.homeView;
  static const profileView = _Paths.profileView;
}

abstract class _Paths {
  static const root = "/root";
  static const signInView = "/signInView";
  static const homeView = "/homeView";
  static const profileView = "/profileView";
}
