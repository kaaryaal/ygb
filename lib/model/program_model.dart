import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Program {
  String? id;
  String? name;
  int? createdAt;
  int? updatedAt;
  String? programLevel;
  String? image;

  Program({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.programLevel,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'programLevel': programLevel,
      'image': image,
    };
  }

  factory Program.fromMap(Map<String, dynamic> map) {
    return Program(
      name: map['name'] != null ? map['name'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as int : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as int : null,
      programLevel:
          map['programLevel'] != null ? map['programLevel'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Program.fromJson(String source) =>
      Program.fromMap(json.decode(source) as Map<String, dynamic>);
}
