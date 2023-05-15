class User {
  final int id;
  final String token;
  User({required this.token, required this.id});

  Map<String, dynamic> toMap() {
    return <String,dynamic>{
      'id': id,
      'token': token,
    };
  }

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     id: json['id'],
  //     token: json['token'],

  //   );
  // }

  // @override
  // String toString() {
  //   return token;
  // }
}
