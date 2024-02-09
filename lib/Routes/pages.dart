import 'package:get/get.dart';
import 'package:kbcquiz/View/Auth/signInView.dart';
import 'package:kbcquiz/View/homeView.dart';

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
        page: () => const HomeView(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 200))
  ];
}
