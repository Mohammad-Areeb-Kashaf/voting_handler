class CandidateModel {
  final String name;
  final String symbolImageUrl;
  final int votes;

  CandidateModel({
    required this.name,
    required this.symbolImageUrl,
    required this.votes,
  });

  factory CandidateModel.fromJson(Map<String, dynamic> json) => CandidateModel(
      name: json['name'],
      symbolImageUrl: json["symbol_image_url"],
      votes: json["votes"]);

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "symbol_image_url": symbolImageUrl,
      "votes": votes,
    };
  }
}
