part of 'pages.dart';

abstract class Routes {
  static const root = _Paths.root;
  static const signInView = _Paths.signInView;
  static const homeView = _Paths.homeView;
  static const profileView = _Paths.profileView;
  static const quizIntroView = _Paths.quizIntroView;
  static const questionView = _Paths.questionView;
  static const winView = _Paths.winView;
  static const looserView = _Paths.looserView;
}

abstract class _Paths {
  static const root = "/root";
  static const signInView = "/signInView";
  static const homeView = "/homeView";
  static const profileView = "/profileView";
  static const quizIntroView = "/quizIntroView";
  static const questionView = "/questionView";
  static const winView = "/winView";
  static const looserView = "/looserView";
}
