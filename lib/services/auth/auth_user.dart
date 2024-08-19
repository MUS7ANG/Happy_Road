import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase;

class AuthUser {
  final String uid;
  final String email;
  final bool isEmailVerified;

  AuthUser({
    required this.uid,
    required this.email,
    required this.isEmailVerified,
  });

  factory AuthUser.fromFirebase(firebase.User user) {
    return AuthUser(
      uid: user.uid,
      email: user.email ?? '', // Если email может быть null, используем пустую строку
      isEmailVerified: user.emailVerified,
    );
  }
}