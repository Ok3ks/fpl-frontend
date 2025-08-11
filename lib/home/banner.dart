import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/individualpage/utils.dart';
import 'package:fpl/themes.dart';
import 'package:gap/gap.dart';

import 'package:go_router/go_router.dart';
import 'package:fpl/types.dart';

class HomeBanner extends ConsumerWidget {
  const HomeBanner({super.key});

  Widget _registerButton(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // Use resolvers for hover and press effects.
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.white.withOpacity(0.2);
            }
            if (states.contains(MaterialState.pressed)) {
              return Colors.white.withOpacity(0.3);
            }
            return null;
          },
        ),
      ),
      onPressed: () {
        context.push("/onboarding");
      },
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.purpleAccent,
              Colors.greenAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Container(
          constraints: const BoxConstraints(minWidth: 88, minHeight: 36),
          alignment: Alignment.center,
          child: const Text(
            "Register",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // Use resolvers for hover and press effects.
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.hovered)) {
              return Colors.white.withOpacity(0.2);
            }
            if (states.contains(MaterialState.pressed)) {
              return Colors.white.withOpacity(0.3);
            }
            return null;
          },
        ),
      ),
      onPressed: () {
        context.push("/login");
      },
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MaterialTheme.darkMediumContrastScheme().primaryContainer,
              MaterialTheme.darkMediumContrastScheme().primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Container(
          constraints: const BoxConstraints(minWidth: 88, minHeight: 36),
          alignment: Alignment.center,
          child: const Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget centerBanner(height) {
    return Container(
      width: double.infinity,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: const EdgeInsets.all(3),
      // Thickness of the border
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            MaterialTheme.darkMediumContrastScheme().primary,
            MaterialTheme.darkMediumContrastScheme().primaryContainer,
            MaterialTheme.darkMediumContrastScheme().primary,
            MaterialTheme.darkMediumContrastScheme().primaryContainer,
            MaterialTheme.darkMediumContrastScheme().primary,
            // Colors.redAccent,
            // Colors.greenAccent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 100, // Adjust the height as needed for your login screen
        decoration: BoxDecoration(
          color: Colors.white, // Keeps the inside empty
          borderRadius: BorderRadius.circular(9),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final bannerHeight = size.height - 200;

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      centerBanner(bannerHeight),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [_registerButton(context), _loginButton(context)],
      )
    ]);
  }
}
