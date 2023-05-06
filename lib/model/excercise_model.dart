import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Excercise {
  String? id;
  String? excerciseName;
  String? image;
  int? createdAt;
  int? updatedAt;
  String? instructions;
  String? programId;
  bool? paid;
  String? videoLink;
  int? minutes;
  String? shortDescription;
  int? day;
  int? positionOfTheExcercise;

  Excercise({
    this.id,
    this.excerciseName,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.instructions,
    this.programId,
    this.paid,
    this.videoLink,
    this.minutes,
    this.shortDescription,
    this.positionOfTheExcercise,
    this.day,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'excerciseName': excerciseName,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'instructions': instructions,
      'programId': programId,
      'paid': paid,
      'videoLink': videoLink,
      'minutes': minutes,
      'shortDescription': shortDescription,
      'day': day,
      "positionOfTheExcercise": positionOfTheExcercise,
    };
  }

  factory Excercise.fromMap(Map<String, dynamic> map) {
    return Excercise(
      excerciseName:
          map['excerciseName'] != null ? map['excerciseName'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as int : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as int : null,
      instructions:
          map['instructions'] != null ? map['instructions'] as String : null,
      programId: map['programId'] != null ? map['programId'] as String : null,
      paid: map['paid'] != null ? map['paid'] as bool : null,
      videoLink: map['videoLink'] != null ? map['videoLink'] as String : null,
      minutes: map['minutes'] != null ? map['minutes'] as int : null,
      day: map['day'] != null ? map['day'] as int : null,
      positionOfTheExcercise: map['positionOfTheExcercise'] != null
          ? map['positionOfTheExcercise'] as int
          : null,
      shortDescription: map['shortDescription'] != null
          ? map['shortDescription'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Excercise.fromJson(String source) =>
      Excercise.fromMap(json.decode(source) as Map<String, dynamic>);
}
