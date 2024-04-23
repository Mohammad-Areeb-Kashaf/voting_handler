import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting_handler/controllers/candidate_controller.dart';

class CandidateEditScreen extends StatefulWidget {
  const CandidateEditScreen({super.key});

  @override
  State<CandidateEditScreen> createState() => _CandidateEditScreenState();
}

class _CandidateEditScreenState extends State<CandidateEditScreen> {
  final candidateController = Get.find<CandidateController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Candidate Edit Screen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo.shade900,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
