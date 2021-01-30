import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker/services/auth.dart';

class SignInBloc {
  final AuthBase auth;
  SignInBloc({@required this.auth});

  final StreamController<bool> _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingtream => _isLoadingController.stream;

  void dispose() {
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<AppUser> _signIn(Future<AppUser> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (error) {
      _setIsLoading(false);
      rethrow;
    }

    // finally {
    //   _setIsLoading(false);
    // }
  }

  Future<AppUser> signInAmounmously() async =>
      await _signIn(auth.signInAnounmously);

  Future<AppUser> signInWithGoogle() async =>
      await _signIn(auth.signInWithGoogle);

  Future<AppUser> signInWithFacebook() async =>
      await _signIn(auth.signInWithFacebook);
}

// Future<AppUser> signInAnounmously() async {
//   try {
//     setIsLoading(true);
//     return await auth.signInAnounmously();
//   } catch (error) {
//     rethrow;
//   } finally {
//     setIsLoading(false);
//   }
// }

//   Future<AppUser> signInWithGoogle() async {
//     try {
//       setIsLoading(true);
//       return await auth.signInWithGoogle();
//     } catch (error) {
//       rethrow;
//     } finally {
//       setIsLoading(false);
//     }
//   }

//   Future<AppUser> signInWithFacebook() async {
//     try {
//       setIsLoading(true);
//       return await auth.signInWithFacebook();
//     } catch (error) {
//       rethrow;
//     } finally {
//       setIsLoading(false);
//     }
//   }
// }
