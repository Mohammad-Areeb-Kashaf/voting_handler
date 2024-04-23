import 'package:flutter/material.dart';
import 'package:fzregex/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:get/get.dart';
import 'package:voting_handler/controllers/candidate_controller.dart';
import 'package:voting_handler/models/candidate_model.dart';

class CandidateForm extends StatefulWidget {
  final bool isEdit;
  final int index;
  const CandidateForm({super.key, this.isEdit = false, this.index = 0});

  @override
  State<CandidateForm> createState() => _CandidateFormState();
}

class _CandidateFormState extends State<CandidateForm> {
  final candidateController = Get.find<CandidateController>();
  final TextEditingController nameController = TextEditingController(),
      symbolImageUrlController = TextEditingController();

  @override
  void initState() {
    if (widget.isEdit) {
      nameController.text = candidateController.candidates[widget.index].name;
      symbolImageUrlController.text =
          candidateController.candidates[widget.index].symbolImageUrl;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: symbolImageUrlController,
              decoration: InputDecoration(
                labelText: 'Symbol Url',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            MaterialButton(
              onPressed: () async {
                final String name = nameController.text.trim();
                final String symbolImageUrl =
                    symbolImageUrlController.text.trim();
                if (name.isEmpty || symbolImageUrl.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all fields'),
                    ),
                  );
                  return;
                } else {
                  if (Fzregex.hasMatch(symbolImageUrl, FzPattern.url)) {
                    final candidateModel = CandidateModel(
                        name: name, symbolImageUrl: symbolImageUrl, votes: 0);

                    if (widget.isEdit) {
                      candidateController.candidates[widget.index] =
                          candidateModel;
                      await candidateController.updateCandidate(
                          index: widget.index);
                      Get.back();
                    } else {
                      candidateController.addCandidate(
                          candidateModel: candidateModel);
                      Get.back();
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Invalid Symbol Url"),
                      ),
                    );
                  }
                }
              },
              color: Colors.indigo.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                widget.isEdit ? 'Save Candidate' : 'Add Candidate',
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
