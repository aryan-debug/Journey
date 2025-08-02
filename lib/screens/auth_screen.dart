import 'package:flutter/material.dart';
import 'package:journey/providers/google_user_provider.dart';
import 'package:journey/screens/home_screen.dart';
import 'package:journey/screens/signup_login_screen.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GoogleUserProvider>().initialize(
        serverClientId:
            "750337622291-fftdqbpg45n3ip16oent3d1l2qfhum3o.apps.googleusercontent.com",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GoogleUserProvider>(
      builder: (context, authProvider, child) {
        if (!authProvider.isInitialized || authProvider.isLoading) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Logging In...'),
                ],
              ),
            ),
          );
        }

        if (authProvider.isSignedIn) {
          return HomeScreen();
        } else {
          return SignupLoginScreen();
        }
      },
    );
  }
}
