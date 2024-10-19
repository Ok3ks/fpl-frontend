import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

class MaterialTheme {
  //final textTheme = GoogleFonts.lektonTextTheme();
  // final secondaryTextTheme = GoogleFonts.montserratTextTheme();
  // final textTheme = primaryTextTheme.copyWith(
  //   displaySmall: secondaryTextTheme.displaySmall);

  //final TextTheme textTheme ;

  //MaterialTheme();

  static ColorScheme lightScheme() {
    return const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF017AFF),
        surfaceTint: Color(0xFF017AFF),
        onPrimary: Color(0xFFFFFFFF),
        primaryContainer: Color(0xFF007DFF),
        onPrimaryContainer: Color(0xFF000048),
        secondary: Color(0xFF1E90FF),
        onSecondary: Color(0xFFFFFFFF),
        secondaryContainer: Color(0xFF005AC4),
        onSecondaryContainer: Color(0xFF000036),
        tertiary: Color(0xFF3B00DD),
        onTertiary: Color(0xFFFFFFFF),
        tertiaryContainer: Color(0xFF00D0FF),
        onTertiaryContainer: Color(0xFF000000),
        error: Color(0xFFFFB4A9),
        onError: Color(0xFFFFFFFF),
        errorContainer: Color(0xFFFFB1A3),
        onErrorContainer: Color(0xFF212121),
        surface: Color(0xFFFFFBFA),
        onSurface: Color(0xFF262626),
        onSurfaceVariant: Color(0xFF9C9C9C),
        outline: Color(0xFF797979),
        outlineVariant: Color(0xFFFFF0FF),
        shadow: Color(0xFF000000),
        scrim: Color(0xFF000000),
        inverseSurface: Color(0xFF4C4C4C),
        inversePrimary: Color(0xFF00BCFF),
        primaryFixed: Color(0xFF007DFF),
        onPrimaryFixed: Color(0xFF000048),
        primaryFixedDim: Color(0xFF00BCFF),
        onPrimaryFixedVariant: Color(0xFF0000BA),
        secondaryFixed: Color(0xFF005AC4),
        onSecondaryFixed: Color(0xFF000036),
        secondaryFixedDim: Color(0xFF0089FF),
        onSecondaryFixedVariant: Color(0xFF001A6D),
        tertiaryFixed: Color(0xFF00D0FF),
        onTertiaryFixed: Color(0xFF000000),
        tertiaryFixedDim: Color(0xFF8A00FF),
        onTertiaryFixedVariant: Color(0xFF0E00B3),
        surfaceDim: Color(0xFFFFF8E1),
        surfaceBright: Color(0xFFFFFBFA),
        surfaceContainerLowest: Color(0xFFFFFFFF),
        surfaceContainerLow: Color(0xFFFFE4E0),
        surfaceContainer: Color(0xFFFFDDC1),
        surfaceContainerHigh: Color(0xFFFFD4B4),
        surfaceContainerHighest: Color(0xFFFFCBA6));
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4281420306),
      surfaceTint: Color(4283196971),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4284579135),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282140207),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285429854),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4279913031),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283399545),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294572783),
      onSurface: Color(4279901206),
      onSurfaceVariant: Color(4282401849),
      outline: Color(4284309845),
      outlineVariant: Color(4286086256),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282858),
      inversePrimary: Color(4289843594),
      primaryFixed: Color(4284579135),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4282999849),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285429854),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283785031),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283399545),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281754720),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292533200),
      surfaceBright: Color(4294572783),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294178025),
      surfaceContainer: Color(4293849059),
      surfaceContainerHigh: Color(4293454302),
      surfaceContainerHighest: Color(4293059544),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4279510784),
      surfaceTint: Color(4283196971),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4281420306),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280034577),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282140207),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278200101),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4279913031),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294572783),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280362268),
      outline: Color(4282401849),
      outlineVariant: Color(4282401849),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282858),
      inversePrimary: Color(4292278188),
      primaryFixed: Color(4281420306),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4280038144),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282140207),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280692763),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4279913031),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278203185),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292533200),
      surfaceBright: Color(4294572783),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294178025),
      surfaceContainer: Color(4293849059),
      surfaceContainerHigh: Color(4293454302),
      surfaceContainerHighest: Color(4293059544),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289843594),
      surfaceTint: Color(4289843594),
      onPrimary: Color(4280235777),
      primaryContainer: Color(4281683478),
      onPrimaryContainer: Color(4291685795),
      secondary: Color(4290759597),
      onSecondary: Color(4280955678),
      secondaryContainer: Color(4282403379),
      onSecondaryContainer: Color(4292667336),
      tertiary: Color(4288729291),
      onTertiary: Color(4278204213),
      tertiaryContainer: Color(4280241739),
      onTertiaryContainer: Color(4290571495),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279374862),
      onSurface: Color(4293059544),
      onSurfaceVariant: Color(4291152058),
      outline: Color(4287599237),
      outlineVariant: Color(4282665021),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059544),
      inversePrimary: Color(4283196971),
      primaryFixed: Color(4291685795),
      onPrimaryFixed: Color(4279246848),
      primaryFixedDim: Color(4289843594),
      onPrimaryFixedVariant: Color(4281683478),
      secondaryFixed: Color(4292667336),
      onSecondaryFixed: Color(4279574027),
      secondaryFixedDim: Color(4290759597),
      onSecondaryFixedVariant: Color(4282403379),
      tertiaryFixed: Color(4290571495),
      onTertiaryFixed: Color(4278198302),
      tertiaryFixedDim: Color(4288729291),
      onTertiaryFixedVariant: Color(4280241739),
      surfaceDim: Color(4279374862),
      surfaceBright: Color(4281874994),
      surfaceContainerLowest: Color(4278980361),
      surfaceContainerLow: Color(4279901206),
      surfaceContainer: Color(4280164378),
      surfaceContainerHigh: Color(4280822564),
      surfaceContainerHighest: Color(4281546286),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFFC107),
      surfaceTint: Color(0xFFFF9800),
      onPrimary: Color(0xFF00796B),
      primaryContainer: Colors.black,//Color.fromRGBO(0, 0, 0, 100),//Colors.black,//Color(0xFF263238),
      onPrimaryContainer: Color(0xFF000000),
      secondary: Color(0xFFFF5722),
      onSecondary: Color(0xFF009688),
      secondaryContainer: Color(0xFF37474F),
      onSecondaryContainer: Color(0xFF000000),
      tertiary: Color(0xFF795548),
      onTertiary: Color(0xFF00796B),
      tertiaryContainer: Color(0xFF455A64),
      onTertiaryContainer: Color(0xFF000000),
      error: Color(0xFFD32F2F),
      onError: Color(0xFFD32F2F),
      errorContainer: Color(0xFFC62828),
      onErrorContainer: Color(0xFF000000),
      surface: Color(0xFF303030),
      onSurface: Color(0xFFBDBDBD),
      onSurfaceVariant: Color(0xFF8D6E63),
      outline: Color(0xFF607D8B),
      outlineVariant: Color(0xFF546E7A),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFFFCDD2),
      inversePrimary: Color(0xFFBBDEFB),
      primaryFixed: Color(0xFF007DFF),
      onPrimaryFixed: Color(0xFF0097A7),
      primaryFixedDim: Color(0xFF00BCFF),
      onPrimaryFixedVariant: Color(0xFF00796B),
      secondaryFixed: Color(0xFF005AC4),
      onSecondaryFixed: Color(0xFF00796B),
      secondaryFixedDim: Color(0xFF0089FF),
      onSecondaryFixedVariant: Color(0xFF004C8C),
      tertiaryFixed: Color(0xFF00D0FF),
      onTertiaryFixed: Color(0xFF00796B),
      tertiaryFixedDim: Color(0xFF8A00FF),
      onTertiaryFixedVariant: Color(0xFF1A237E),
      surfaceDim: Color(0xFF303030),
      surfaceBright: Color(0xFF448AFF),
      surfaceContainerLowest: Color(0xFF009688),
      surfaceContainerLow: Color(0xFF00796B),
      surfaceContainer: Color(0xFF00695C),
      surfaceContainerHigh: Color(0xFF004D40),
      surfaceContainerHighest: Color(0xFF00251A),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
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

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294246367),
      surfaceTint: Color(4289843594),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4290106766),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294246367),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4291088305),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293591036),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4288992464),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279374862),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294573293),
      outline: Color(4291415230),
      outlineVariant: Color(4291415230),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059544),
      inversePrimary: Color(4279906304),
      primaryFixed: Color(4291949223),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4290106766),
      onPrimaryFixedVariant: Color(4278983168),
      secondaryFixed: Color(4292930508),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4291088305),
      onSecondaryFixedVariant: Color(4279245063),
      tertiaryFixed: Color(4290834668),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4288992464),
      onTertiaryFixedVariant: Color(4278196761),
      surfaceDim: Color(4279374862),
      surfaceBright: Color(4281874994),
      surfaceContainerLowest: Color(4278980361),
      surfaceContainerLow: Color(4279901206),
      surfaceContainer: Color(4280164378),
      surfaceContainerHigh: Color(4280822564),
      surfaceContainerHighest: Color(4281546286),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) {
    final primaryTextTheme = GoogleFonts.lektonTextTheme();
    final secondaryTextTheme = GoogleFonts.montserratTextTheme();
    final textTheme = primaryTextTheme.copyWith(
        displaySmall: secondaryTextTheme.displaySmall);

    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: colorScheme.background,
      canvasColor: colorScheme.surface,
    );
  }

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

@immutable
class FplTheme extends ThemeExtension<FplTheme> {
  //mode = dark or light
  const FplTheme(
      {this.primaryColor = const Color(0xFF356859),
      this.tertiaryColor = const Color(0xFFFF5722),
      this.neutralColor = const Color(0xFFFFFF)});

  final Color primaryColor, tertiaryColor, neutralColor;

  @override
  ThemeExtension<FplTheme> copyWith({
    Color? primaryColor,
    Color? tertiaryColor,
    Color? neutralColor,
  }) =>
      FplTheme(
          primaryColor: primaryColor ?? this.primaryColor,
          tertiaryColor: tertiaryColor ?? this.tertiaryColor,
          neutralColor: neutralColor ?? this.neutralColor);

  @override
  FplTheme lerp(covariant ThemeExtension<FplTheme>? other, double t) {
    if (other is! FplTheme) return this;
    return FplTheme(
        primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
        tertiaryColor: Color.lerp(tertiaryColor, other.tertiaryColor, t)!,
        neutralColor: Color.lerp(neutralColor, other.neutralColor, t)!);
  }

  ThemeData _base(ColorScheme colorScheme) {
    final primaryTextTheme = GoogleFonts.lektonTextTheme();
    final secondaryTextTheme = GoogleFonts.montserratTextTheme();
    final textTheme = primaryTextTheme.copyWith(
        displaySmall: secondaryTextTheme.displaySmall);
    final isLight = colorScheme.brightness == Brightness.light;

    return ThemeData(
      useMaterial3: true,
      extensions: [this],
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: isLight ? neutralColor : colorScheme.surface,
    );
  }

  // Scheme _scheme() {
  //   final base = CorePalette.of(primaryColor.value);
  //   final primary = base.primary;
  //   final tertiary = CorePalette.of(tertiaryColor.value).primary;
  //   final neutral = CorePalette.of(neutralColor.value).neutral;

  //   return Scheme(
  //     primary: primary.get(40), onPrimary: primary.get(100),
  //     primaryContainer: primary.get(90),onPrimaryContainer: primary.get(10),
  //   secondary: , onSecondary: ,
  //   secondaryContainer:, onSecondaryContainer:,
  //   tertiary: , onTertiary: ,
  //   tertiaryContainer: , onTertiaryContainer: ,
  //   error: base.error.get(40), onError:,
  // errorContainer: , onErrorContainer: ,
  // background: , onBackground: ,
  // surface: neutral.get(), onSurface: neutral.get(),
  // outline: , outlineVariant: ,
  // surfaceVariant: base.neutralVariant.get(90),
  // onSurfaceVariant: ,
  // shadow: neutral.get(), scrim:,
  // inverseSurface: neutral.get(20), inverseOnSurface: neutral.get(95),
  // inversePrimary: primary.get(80)
  //   );
  // }

  //allows scheme to switch based on brightness
  // extension on _scheme() {
  //   ColorScheme toColorScheme(Brightness brightness) {
  //     return ColorScheme(
  //       //primary: Color(primaryColor),
  //       brightness: brightness;

  //     );
  //}
  //}

//Additionally colors can be pulled from images

  ThemeData toThemeData() {
    //final colorScheme = _scheme().toColorScheme(Brightness.light);
    //return _base(colorScheme).copyWith(brightness: colorScheme.brightness);

    //customise elements from root
    return ThemeData(
        useMaterial3: true,
        // appBarTheme: AppBarTheme(
        //   backgroundColor: isLight ? neutralColor : colorScheme.surface
        // ),
        chipTheme: ChipThemeData(backgroundColor: Colors.greenAccent),
        cardTheme: CardTheme(
          color: MaterialTheme.darkMediumContrastScheme().secondaryContainer,
        ));
  }
}

//Blend Color from Image
// class ImageTheme extends StatelessWidget {
//   const ImageTheme({
//     super.key,
//     required this.path,
//     required this.child,
//   });

//   final String path;
//   final Widget child;

// Future<List<Int>?> imageToPixels(String path) async {
//   try {
//     final data = await rootBundle.load(path);
//     final image = img.PngDecoder().decodeImage(data.buffer.asUint8List);
//     if (image == null) return null;
//     final bytes = image.getBytes(format: img.Format.rgb);
//     final pixels = <int>[];
//     for(var i = 0; i < bytes.length; i +=3) {
//       pixels.add(img.getColor(bytes[i], bytes[i+1], bytes[i+2]));
//     }
//     return pixels;
//   }
// }

// @override
// Widget build(BuildContext context ) {
//   final theme = Theme.of(context);
//   return FutureBuilder(
//     future: colorSchemeFromImage(theme.colorScheme, path),
//     builder: (context, snapshot) {
//       final scheme = snapshot.data ?? theme.colorScheme;
//       return Theme(
//         data: theme.copyWith(colorScheme: scheme),
//         child: child,
//         );
//     },);
//   }
// }
