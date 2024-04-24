import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting_handler/controllers/candidate_controller.dart';
import 'package:voting_handler/models/candidate_model.dart';

class VotingController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final candidateController = Get.find<CandidateController>();
  var isBallotEnabled = false.obs;

  getBallotInfo() {
    return StreamBuilder(
      stream: _firestore.collection('voting').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        } else {
          final doc = snapshot.data!.docs[0].data();
          isBallotEnabled.value = doc['is_ballot_enabled'];
          if (isBallotEnabled.value) {
            return const Scaffold(
              body: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Waiting for vote to be received.'),
                ),
              ),
            );
          } else {
            return Scaffold(
              body:
                  candidateController.getCandidates(onBallotPressed: () async {
                if (candidateController.candidates.isNotEmpty) {
                  await enableBallot();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('No candidates. Please add candidates')));
                }
              }, onResultsPressed: () async {
                if (candidateController.candidates.isNotEmpty) {
                  if (isBallotEnabled.value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Ballot is enabled')));
                  } else {
                    Get.toNamed("/results");
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('No candidates. Please add candidates')));
                }
              }),
            );
          }
        }
      },
    );
  }

  enableBallot() async {
    await _firestore
        .collection('voting')
        .doc('voting_helper')
        .update({'is_ballot_enabled': true});
  }

  getResults() {
    return StreamBuilder(
      stream: _firestore.collection('candidates').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        } else {
          return SafeArea(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data!.docs[index].data();
                final candidateModel = CandidateModel.fromJson(doc);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(8.0)),
                    leading: Image.network(
                      candidateModel.symbolImageUrl,
                    ),
                    title: Text(
                      candidateModel.name,
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: Text(
                      'votes: ${candidateModel.votes}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
