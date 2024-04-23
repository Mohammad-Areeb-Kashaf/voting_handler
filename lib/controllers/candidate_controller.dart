import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting_handler/models/candidate_model.dart';

class CandidateController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  var candidates = <CandidateModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCandidates();
  }

  Widget getCandidates({bool isEdit = false}) {
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
          return isEdit != true
              ? SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.black)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Candidates',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      onPressed: () {
                                        Get.toNamed("/candidate_edittable");
                                      },
                                      child: const Text('Add / Edit'),
                                    ),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final CandidateModel candidateModel =
                                      CandidateModel.fromJson(
                                          snapshot.data!.docs[index].data());
                                  candidates.add(candidateModel);
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      leading: Image.network(
                                        candidateModel.symbolImageUrl,
                                      ),
                                      title: Text(
                                        candidateModel.name,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: const Text(
                                  'Results',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                color: Colors.indigo.shade900,
                                child: const Text(
                                  'Ballot',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.black)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final CandidateModel candidateModel =
                                      CandidateModel.fromJson(
                                          snapshot.data!.docs[index].data());
                                  if (index == 0) {
                                    candidates.value = [];
                                  }
                                  candidates.add(candidateModel);
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      leading: Image.network(
                                        candidateModel.symbolImageUrl,
                                      ),
                                      title: Text(
                                        candidateModel.name,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      trailing: MaterialButton(
                                        onPressed: () => Get.toNamed(
                                            "/candidate_edit?index=$index"),
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child: const Text(
                                          'Edit',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }
      },
    );
  }

  addCandidate({required CandidateModel candidateModel}) async {
    await _firestore
        .collection('candidates')
        .doc((candidateModel.name).toString())
        .set(candidateModel.toJson());
  }

  updateCandidate({required CandidateModel candidateModel}) async {
    await _firestore
        .collection('candidates')
        .doc(candidateModel.name)
        .set(candidateModel.toJson());
  }

  deleteCandidate({required int index}) async {
    await _firestore
        .collection('candidates')
        .doc(candidates[index].name)
        .delete();
  }
}
