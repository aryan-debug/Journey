import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:journey/models/user_model.dart';
import 'dart:convert';

class GoogleUserProvider extends ChangeNotifier {
  static const String _userKey = 'user_data';

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

      await _loadUserFromStorage();

      await GoogleSignIn.instance.initialize(
        clientId: clientId,
        serverClientId: serverClientId,
      );

      GoogleSignIn.instance.authenticationEvents.listen(
        _handleAuthenticationEvent,
        onError: _handleAuthenticationError,
      );

      _isInitialized = true;

      if (_user == null) {
        await GoogleSignIn.instance.attemptLightweightAuthentication();
      }
    } catch (error) {
      _setError('Initialization failed: ${error.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _loadUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);

      if (userJson != null) {
        final userMap = json.decode(userJson);
        _user = User.fromJson(userMap);
        notifyListeners();
      }
    } catch (error) {
      print('Failed to load user from storage: $error');
    }
  }

  Future<void> _saveUserToStorage(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = json.encode(user.toJson());
      await prefs.setString(_userKey, userJson);
    } catch (error) {
      print('Failed to save user to storage: $error');
    }
  }

  Future<void> _removeUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
    } catch (error) {
      print('Failed to remove user from storage: $error');
    }
  }

  void _handleAuthenticationEvent(GoogleSignInAuthenticationEvent event) {
    switch (event) {
      case GoogleSignInAuthenticationEventSignIn():
        {
          _user = User.fromGoogleSignInAccount(event.user);
          _saveUserToStorage(_user!);
          notifyListeners();
        }
      case GoogleSignInAuthenticationEventSignOut():
        {
          _user = null;
          _removeUserFromStorage();
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
