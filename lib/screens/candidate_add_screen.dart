import 'package:flutter/material.dart';
import 'package:voting_handler/widgets/candidate_form.dart';

class CandidateAddScreen extends StatelessWidget {
  const CandidateAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: SafeArea(
          child: CandidateForm(),
        ),
      ),
    );
  }
}
