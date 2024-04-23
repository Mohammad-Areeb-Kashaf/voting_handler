import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting_handler/controllers/candidate_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final candidateController = Get.find<CandidateController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: candidateController.getCandidates(),
    );
  }
}
