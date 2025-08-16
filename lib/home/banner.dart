import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/theme_provider.dart';
import 'package:fpl/themes.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class HomeBanner extends ConsumerStatefulWidget {
  const HomeBanner({super.key});

  @override
  ConsumerState<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends ConsumerState<HomeBanner> {
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
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.hovered)) {
              return Colors.white.withAlpha(51);
            }
            if (states.contains(WidgetState.pressed)) {
              return Colors.white.withAlpha(77);
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
              color: Colors.black.withAlpha(77),
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
              return Colors.white.withAlpha(51);
            }
            if (states.contains(WidgetState.pressed)) {
              return Colors.white.withAlpha(77);
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
              color: Colors.black.withAlpha(77),
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
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Lottie.network(
                        'https://lottie.host/26387b06-41a3-445a-a1e2-52557330bbe8/282wuWxDwX.json',
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Find Statistics about your FPL Mini League",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Lottie.network(
                      'https://lottie.host/26387b06-41a3-445a-a1e2-52557330bbe8/282wuWxDwX.json',
                    ),
                  ), Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child:
                      Center(
                        child: Text(
                          "Find Fun Stats about your FPL Mini League",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )]);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
