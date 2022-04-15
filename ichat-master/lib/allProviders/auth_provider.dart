import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ichat_app/allConstants/firestore_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status{
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateCanceled,}

class AuthProvider extends ChangeNotifier {
  final GoogleSignIn googleSignIn ;
  final FirebaseAuth firebaseAuth ;
  final FirebaseFirestore firebaseFirestore ;
  final SharedPreferences preferences ;

  Status get status => _status;
  AuthProvider({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.preferences,
    required this. firebaseFirestore,

  });
  String? getUserFirebaseId(){
    return preferences.getString(FirestoreConstants.id);

  }
  Future<bool> isLoggedIn()async{
    bool isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn && preferences.getString(FirestoreConstants.id)?.isNotEmpty == true){
      return true;

    }else{
      return false;
    }
  }
  Future<bool> handleSignIn() async{
    _status = Statustatus.authenticating;
    notifyListeners();


    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser !=null){
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,

      }