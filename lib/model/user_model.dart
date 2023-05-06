class UserModel {
  String? uid;
  String? name;
  String? email;
  String? weight;
  String? height;
  int? dob;
  String? gender;
  String? profileImage;
  DateTime timestamp;
  DateTime? subscriptionData;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.weight,
    this.height,
    this.dob,
    this.gender,
    this.profileImage,
    required this.timestamp,
    this.subscriptionData,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'weight': weight,
      'height': height,
      'dob': dob,
      'gender': gender,
      'profileImage': profileImage,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'subscriptionData': subscriptionData!.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      weight: map['weight'] != null ? map['weight'] as String : null,
      height: map['height'] != null ? map['height'] as String : null,
      dob: map['dob'] != null ? map['dob'] as int : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      profileImage:
          map['profileImage'] != null ? map['profileImage'] as String : null,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      subscriptionData: map['subscriptionData'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['subscriptionData'] as int)
          : null,
    );
  }
}
