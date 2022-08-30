import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  FirebaseAuthentication(this._firebaseAuth);

  Future<String> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "OK";
    }
    on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> createUserWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "OK";
    }
    on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<void> signOut() async =>  await _firebaseAuth.signOut();

  Stream<User?> get idTokenChanges => _firebaseAuth.idTokenChanges();

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  final FirebaseAuth _firebaseAuth;
}
