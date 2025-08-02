import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey/providers/google_user_provider.dart';
import 'package:journey/widgets/long_button.dart';
import 'package:provider/provider.dart';

class SignupLoginScreen extends StatefulWidget {
  const SignupLoginScreen({super.key});

  @override
  State<SignupLoginScreen> createState() => _SignupLoginScreenState();
}

class _SignupLoginScreenState extends State<SignupLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GoogleUserProvider>(
        builder: (context, userProvider, _) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/logo.svg",
                        semanticsLabel: "Journey Logo",
                        height: 400,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 50),
                      Text(
                        "JOURNEY",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 30,
                            letterSpacing: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: LongButton(
                  text: "Sign Up",
                  onPressed: () async {
                    await userProvider.signInWithGoogle();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
