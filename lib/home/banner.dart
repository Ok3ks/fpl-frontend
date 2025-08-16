import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/themes.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomeBanner extends ConsumerStatefulWidget {
  const HomeBanner({super.key});

  @override
  ConsumerState<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends ConsumerState<HomeBanner> {
  bool _isHovered = false;

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
          gradient: ref.watch(funkyGradientProvider),
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
          child: Text(
            "Register",
            style: GoogleFonts.poppins(
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
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primary,
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
          child: Text(
            "Login",
            style: GoogleFonts.poppins(
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

  Widget centerBanner(double height) {
    final transform =
        _isHovered ? (Matrix4.identity()..scale(1.03)) : Matrix4.identity();
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: transform,
        transformAlignment: Alignment.center,
        width: double.infinity,
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        padding: const EdgeInsets.all(3),
        // Thickness of the border
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(51),
              blurRadius: 15,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Container(
          height: 100, // Adjust the height as needed for your login screen
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerLow, // Keeps the inside empty
            borderRadius: BorderRadius.circular(9),
          ),
          child: OrientationBuilder(
            builder: (context, orientation) {
              final headline = ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) =>
                    ref.watch(funkyGradientProvider).createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'Discover',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' fun stats about your '),
                      TextSpan(
                          text: 'FPL',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' mini-league'),
                    ],
                  ),
                ),
              );

              final tagline = Text(
                "Bragging Rights, Backed by Data.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  decoration: TextDecoration.none,
                ),
              );

              if (orientation == Orientation.portrait) {
                return Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Lottie.network(
                        'https://lottie.host/26387b06-41a3-445a-a1e2-52557330bbe8/282wuWxDwX.json',
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              headline,
                              const SizedBox(height: 8),
                              tagline,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Row(children: [
                  Expanded(
                    flex: 2,
                    child: Lottie.network(
                      'https://lottie.host/26387b06-41a3-445a-a1e2-52557330bbe8/282wuWxDwX.json',
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            headline,
                            const SizedBox(height: 12),
                            tagline,
                          ],
                        ),
                      ),
                    ),
                  )
                ]);
              }
            },
          ),
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
