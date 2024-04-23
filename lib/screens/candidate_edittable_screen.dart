import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting_handler/controllers/candidate_controller.dart';

class CandidateEdittableScreen extends StatefulWidget {
  const CandidateEdittableScreen({super.key});

  @override
  State<CandidateEdittableScreen> createState() =>
      _CandidateEdittableScreenState();
}

class _CandidateEdittableScreenState extends State<CandidateEdittableScreen> {
  final candidateController = Get.find<CandidateController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed("/candidate_add"),
        backgroundColor: Colors.indigo.shade900,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: candidateController.getCandidates(isEdit: true),
    );
  }
}
