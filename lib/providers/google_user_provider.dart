import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:journey/models/user_model.dart';

class GoogleUserProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;
  bool _isInitialized = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isSignedIn => _user != null;
  bool get isInitialized => _isInitialized;

  Future<void> initialize({
    String? clientId,
    required String serverClientId,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      await GoogleSignIn.instance.initialize(
        clientId: clientId,
        serverClientId: serverClientId,
      );

      GoogleSignIn.instance.authenticationEvents.listen(
        _handleAuthenticationEvent,
        onError: _handleAuthenticationError,
      );

      _isInitialized = true;

      await GoogleSignIn.instance.attemptLightweightAuthentication();
    } catch (error) {
      _setError('Initialization failed: ${error.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  void _handleAuthenticationEvent(GoogleSignInAuthenticationEvent event) {
    switch (event) {
      case GoogleSignInAuthenticationEventSignIn():
        {
          _user = User.fromGoogleSignInAccount(event.user);
          notifyListeners();
        }
      case GoogleSignInAuthenticationEventSignOut():
        {
          _user = null;
          notifyListeners();
        }
    }
  }

  void _handleAuthenticationError(Object error) {
    _setError('Authentication error: ${error.toString()}');
  }

  Future<void> signInWithGoogle() async {
    if (!_isInitialized) {
      _setError('Google Sign-In not initialized');
      return;
    }

    try {
      _setLoading(true);
      _setError(null);

      if (GoogleSignIn.instance.supportsAuthenticate()) {
        await GoogleSignIn.instance.authenticate();
      } else {
        _setError(
          'Sign-in not supported on this platform. Please use web-specific implementation.',
        );
      }
    } catch (error) {
      _setError('Sign in failed: ${error.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    try {
      _setLoading(true);
      await GoogleSignIn.instance.signOut();
    } catch (error) {
      _setError('Sign out failed: ${error.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
