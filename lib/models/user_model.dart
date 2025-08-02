import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String id;
  final String email;
  final String displayName;
  final String? photoUrl;

  User({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoUrl,
  });

  factory User.fromGoogleSignInAccount(GoogleSignInAccount account) {
    return User(
      id: account.id,
      email: account.email,
      displayName: account.displayName ?? '',
      photoUrl: account.photoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
    );
  }
}
