/*
import 'package:flutter_app/services/auth/auth_exceptions.dart';
import 'package:flutter_app/services/auth/auth_provider.dart';
import 'package:flutter_app/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main(){
  group('MockAuthProvider Tests', () {
    late MockAuthProvider authProvider;

    setUp(() {
      authProvider = MockAuthProvider();
    });

    test('should initialize the provider', () async {
      await authProvider.initialize();
      expect(authProvider.isInitialized, isTrue);
    });

    test('should throw NotInitializedException when creating user without initialization', () {
      expect(
            () => authProvider.createUser(email: 'test@example.com',
                password: 'password'),
        throwsA(isA<NotInitializedException>()),
      );
    });

    test('should create user after initialization', () async {
      await authProvider.initialize();
      final user = await authProvider.createUser(email: 'test@example.com',
          password: 'password');
      expect(user, isA<AuthUser>());
      expect(authProvider.currentUser, isNotNull);
    });

    test('should log in user after initialization', () async {
      await authProvider.initialize();
      final user = await authProvider.logIn(email: 'test@example.com',
          password: 'password');
      expect(user.isEmailVerified, isFalse);
    });

    test('should throw NotInitializedException when logging out without initialization', () {
      expect(
            () => authProvider.logOut(),
        throwsA(isA<NotInitializedException>()),
      );
    });

    test('should log out user after initialization', () async {
      await authProvider.initialize();
      await authProvider.logIn(email: 'test@example.com', password: 'password');
      await authProvider.logOut();
      expect(authProvider.currentUser, isNull);
    });

    test('should throw UserNotFoundAuthException when logging out with no current user',
            () async {
      await authProvider.initialize();
      expect(
            () => authProvider.logOut(),
        throwsA(isA<UserNotFoundAuthException>()),
      );
    });

    test('should throw NotInitializedException when sending email verification without initialization', () {
      expect(
            () => authProvider.sendEmailVerification(),
        throwsA(isA<NotInitializedException>()),
      );
    });

    test('should send email verification after initialization', () async {
      await authProvider.initialize();
      await authProvider.logIn(email: 'test@example.com', password: 'password');
      await authProvider.sendEmailVerification();
      expect(authProvider.currentUser?.isEmailVerified, isTrue);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider{
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if(!isInitialized) throw NotInitializedException;
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
        email: email,
        password: password,);
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if(!isInitialized) throw NotInitializedException();
    const user = AuthUser(isEmailVerified: false, uid: );
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if(!isInitialized) throw NotInitializedException();
    if(_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user == null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if(!isInitialized) throw NotInitializedException();
    final user = _user;
    if(user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }
}
 */
