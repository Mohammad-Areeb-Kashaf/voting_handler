import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting_handler/widgets/candidate_form.dart';

class CandidateEditScreen extends StatelessWidget {
  const CandidateEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int index = int.parse(Get.parameters['index'].toString());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: CandidateForm(isEdit: true, index: index),
        ),
      ),
    );
  }
}
