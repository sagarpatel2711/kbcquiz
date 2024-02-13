import 'package:get/get.dart';
import 'package:kbcquiz/View/Auth/signInView.dart';
import 'package:kbcquiz/View/fifty50View.dart';
import 'package:kbcquiz/View/homeView.dart';
import 'package:kbcquiz/View/looserView.dart';
import 'package:kbcquiz/View/profileView.dart';
import 'package:kbcquiz/View/questionView.dart';
import 'package:kbcquiz/View/quizIntroView.dart';
import 'package:kbcquiz/View/winView.dart';

import '../View/audiencePollView.dart';

part 'routes.dart';

class Pages {
  static List<GetPage> routses = [
    GetPage(
        name: _Paths.signInView,
        page: () => SignInView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: _Paths.homeView,
        page: () => HomeView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: _Paths.profileView,
        page: () => ProfileView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: _Paths.quizIntroView,
        page: () => QuizIntroView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: _Paths.questionView,
        page: () => QuestionView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: _Paths.winView,
        page: () => WinView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: _Paths.looserView,
        page: () => LooserView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: _Paths.audiencePollView,
        page: () => AudiencePollView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
        name: _Paths.fifty50View,
        page: () => Fifty50View(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200))
  ];
}
