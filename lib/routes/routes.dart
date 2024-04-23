import 'package:get/get.dart';
import 'package:voting_handler/screens/candidate_edit_screen.dart';
import 'package:voting_handler/screens/home_screen.dart';

class Routes {
  static String home = "/home";
  static String candidateEdit = "/candidate_edit";

  static String getHomeRoute() => home;
  static String getCandidateEditRoute() => candidateEdit;

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(
      name: candidateEdit,
      page: () => const CandidateEditScreen(),
    ),
  ];
}
