import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting_handler/controllers/candidate_controller.dart';
import 'package:voting_handler/widgets/candidate_form.dart';

class CandidateEditScreen extends StatelessWidget {
  CandidateEditScreen({super.key});
  final candidateController = Get.find<CandidateController>();

  @override
  Widget build(BuildContext context) {
    final int index = int.parse(Get.parameters['index'].toString());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              candidateController.deleteCandidate(index: index);
              Get.back();
            },
            icon: const Icon(Icons.delete),
            color: Colors.red,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: CandidateForm(isEdit: true, index: index),
        ),
      ),
    );
  }
}
