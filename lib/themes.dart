import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RobinSystem extends StatelessWidget {
  //mode = dark or light
  const RobinSystem({super.key});

  ColorScheme get light {
    return const ColorScheme.light(
      brightness: Brightness.light,
      primary: Color(0xAA006877),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xAA006874),
      onSecondary: Color(0xFFFFFFFF),
      error: Color(0xFFB81F1D),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF3B0907),
      surface: Color(0xFFF5FAFC),
      onSurface: Color(0xFF191C1D),
      onSurfaceVariant: Color(0xFF3F484B),
      outline: Color(0xFF6F797B),
      outlineVariant: Color(0xFFBFC8CB),
      inverseSurface: Color(0xFF2B3133),
      onInverseSurface: Color(0xFFECF2F3),
      inversePrimary: Color(0xFF83D2E4),
    );
  }

  ColorScheme get dark {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xAAA4EEFF),
      onPrimary: Color(0xFFFFFFFF),

      //primaryContainer: Color(),
      //onPrimaryContainer: Color(),
      //primaryFixed: Color(),
      //primaryFixedDim: Color(),
      //onPrimaryFixed: Color(),
      //onPrimaryFixedVariant: Color(),

      secondary: Color(0xAA4FD8EB),
      secondaryContainer: Color(0xFF004F58),
      onSecondary: Color(0xFFFFFFFF),
      onSecondaryContainer: Color(0xFF9EEFFD),
      //secondaryFixed: Color(),
      //secondaryFixedDim: Color(),
      //onSecondaryFixed: Color(),
      //onSecondaryFixedVariant: Color(),

      tertiary: Color(0xFF9EEFFD),
      tertiaryContainer: Color(0xFF004F58),
      onTertiary: Color(0xFFFFFFFF),
      onTertiaryContainer: Color(0xFF9EEFFD),
      //tertiaryFixed: Color(),
      //tertiaryFixedDim: Color(),
      //onTertiaryFixed: Color(),
      //onTertiaryFixedVariant: Color(),

      error: Color(0xAA904A43),
      onError: Color(0xAAAAAAAA),
      errorContainer: Color(0xFF93000A),
      //onErrorContainer: ,

      surface: Color(0xFF0E1416),
      onSurface: Color(0xFFECF2F3),
      onSurfaceVariant: Color(0xFFBFC8CB),

      //surfaceDim: Color(),
      //surfaceBright: Color(),
      //surfaceContainerLowest: Color(0xAAAAAAAA),
      //surfaceContainerLow:
      //surfaceContainerHigh:
      //surfaceContainerHighest: Color(0xFF232627)
      //surfaceContainer:,

      surfaceTint: Color(0xFF004F58),
      scrim: Color(0xFFFFFFFF),
      shadow: Color(0xFFFFFFFF),
      outline: Color(0xFF899295),
      outlineVariant: Color(0xFF70797C),

      inverseSurface: Color(0xFFE1E3E4),
      onInverseSurface: Color(0xFF2E3132),
      inversePrimary: Color(0xFF006877),
    );
  }

  TextTheme get textTheme {
    return TextTheme(
      bodySmall: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          letterSpacing: 0.4,
          height: 16),
      bodyMedium: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: 0.25,
          height: 20),
      bodyLarge: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          letterSpacing: 0.5,
          height: 24),
      labelSmall: GoogleFonts.roboto(
          fontWeight: FontWeight.w500,
          fontSize: 11,
          letterSpacing: 0.5,
          height: 16),
      labelMedium: GoogleFonts.roboto(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          letterSpacing: 0.5,
          height: 16),
      labelLarge: GoogleFonts.roboto(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: 0.1,
          height: 20),
      titleSmall: GoogleFonts.roboto(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: 0.1,
          height: 20),
      titleMedium: GoogleFonts.roboto(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          letterSpacing: 0.15,
          height: 24),
      titleLarge: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 22,
          letterSpacing: 0,
          height: 28),
      headlineSmall: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 24,
          letterSpacing: 0,
          height: 32),
      headlineMedium: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 28,
          letterSpacing: 0,
          height: 36),
      headlineLarge: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 32,
          letterSpacing: 0,
          height: 40),
      displaySmall: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 36,
          letterSpacing: 0,
          height: 44),
      displayMedium: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 45,
          letterSpacing: 0,
          height: 52),
      displayLarge: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 57,
          letterSpacing: -0.25,
          height: 64),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true, textTheme: textTheme, colorScheme: dark),
      home: const Card(),
    );
    //Add light/dark mode switch with ColorScheme
  }
}
