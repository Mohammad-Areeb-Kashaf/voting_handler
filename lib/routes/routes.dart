import 'package:get/get.dart';
import 'package:voting_handler/screens/candidate_add_screen.dart';
import 'package:voting_handler/screens/candidate_edit_screen.dart';
import 'package:voting_handler/screens/candidate_edittable_screen.dart';
import 'package:voting_handler/screens/home_screen.dart';

class Routes {
  static String home = "/home";
  static String candidateEdittable = "/candidate_edittable";
  static String candidateAdd = "/candidate_add";
  static String candidateEdit = "/candidate_edit";

  static String getHomeRoute() => home;
  static String getCandidateEdittableRoute() => candidateEdittable;
  static String getCandidateAddRoute() => candidateAdd;
  static String getCandidateEditRoute() => candidateEdit;

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(
        name: candidateEdittable, page: () => const CandidateEdittableScreen()),
    GetPage(name: candidateAdd, page: () => const CandidateAddScreen()),
    GetPage(name: candidateEdit, page: () => CandidateEditScreen()),
  ];
}
