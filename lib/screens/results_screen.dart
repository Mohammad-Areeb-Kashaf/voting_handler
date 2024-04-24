import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting_handler/controllers/voting_controller.dart';

class ResultsScreen extends StatelessWidget {
  ResultsScreen({super.key});
  final votingController = Get.find<VotingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: votingController.getResults());
  }
}
