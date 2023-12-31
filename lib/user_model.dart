class UserModel {
  String? uid;
  String? email;
  String? firstName;

  UserModel({this.uid, this.email, this.firstName});

  //receiving data from server
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
    );
  }

  //sending data the the server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
    };
  }

  UserModel fromMap(Map<String, dynamic>? data) {
    if (data != null) {
      uid = data['uid'];
      email = data['email'];
      firstName = data['firstName'];
    }
    return this;
  }
}
