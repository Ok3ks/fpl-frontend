import 'package:flutter/material.dart';

class MaterialTheme {
  // final textTheme = GoogleFonts.lektonTextTheme();
  // final secondaryTextTheme = GoogleFonts.montserratTextTheme();
  // final textTheme = primaryTextTheme.copyWith(
  // displaySmall: secondaryTextTheme.displaySmall);

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
      primary: Color(0xff314a12),
      surfaceTint: Color(0xff4c662b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff617d3f),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3c462f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6e785e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1a4a47),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4f7d79),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9faef),
      onSurface: Color(0xff1a1c16),
      onSurfaceVariant: Color(0xff404439),
      outline: Color(0xff5d6155),
      outlineVariant: Color(0xff787c70),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f312a),
      inversePrimary: Color(0xffb1d18a),
      primaryFixed: Color(0xff617d3f),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff496429),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6e785e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff555f47),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4f7d79),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff366460),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdadbd0),
      surfaceBright: Color(0xfff9faef),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f4e9),
      surfaceContainer: Color(0xffeeefe3),
      surfaceContainerHigh: Color(0xffe8e9de),
      surfaceContainerHighest: Color(0xffe2e3d8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff142700),
      surfaceTint: Color(0xff4c662b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff314a12),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1c2511),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3c462f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002725),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1a4a47),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9faef),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff21251c),
      outline: Color(0xff404439),
      outlineVariant: Color(0xff404439),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f312a),
      inversePrimary: Color(0xffd6f7ac),
      primaryFixed: Color(0xff314a12),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff1c3300),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff3c462f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff26301b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff1a4a47),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003331),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdadbd0),
      surfaceBright: Color(0xfff9faef),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f4e9),
      surfaceContainer: Color(0xffeeefe3),
      surfaceContainerHigh: Color(0xffe8e9de),
      surfaceContainerHighest: Color(0xffe2e3d8),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb1d18a),
      surfaceTint: Color(0xffb1d18a),
      onPrimary: Color(0xff1f3701),
      primaryContainer: Color(0xff354e16),
      onPrimaryContainer: Color(0xffcdeda3),
      secondary: Color(0xffbfcbad),
      onSecondary: Color(0xff2a331e),
      secondaryContainer: Color(0xff404a33),
      onSecondaryContainer: Color(0xffdce7c8),
      tertiary: Color(0xffa0d0cb),
      onTertiary: Color(0xff003735),
      tertiaryContainer: Color(0xff1f4e4b),
      onTertiaryContainer: Color(0xffbcece7),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff12140e),
      onSurface: Color(0xffe2e3d8),
      onSurfaceVariant: Color(0xffc5c8ba),
      outline: Color(0xff8f9285),
      outlineVariant: Color(0xff44483d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e3d8),
      inversePrimary: Color(0xff4c662b),
      primaryFixed: Color(0xffcdeda3),
      onPrimaryFixed: Color(0xff102000),
      primaryFixedDim: Color(0xffb1d18a),
      onPrimaryFixedVariant: Color(0xff354e16),
      secondaryFixed: Color(0xffdce7c8),
      onSecondaryFixed: Color(0xff151e0b),
      secondaryFixedDim: Color(0xffbfcbad),
      onSecondaryFixedVariant: Color(0xff404a33),
      tertiaryFixed: Color(0xffbcece7),
      onTertiaryFixed: Color(0xff00201e),
      tertiaryFixedDim: Color(0xffa0d0cb),
      onTertiaryFixedVariant: Color(0xff1f4e4b),
      surfaceDim: Color(0xff12140e),
      surfaceBright: Color(0xff383a32),
      surfaceContainerLowest: Color(0xff0c0f09),
      surfaceContainerLow: Color(0xff1a1c16),
      surfaceContainer: Color(0xff1e201a),
      surfaceContainerHigh: Color(0xff282b24),
      surfaceContainerHighest: Color(0xff33362e),
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
      primaryContainer: Colors
          .black, //Color.fromRGBO(0, 0, 0, 100),//Colors.black,//Color(0xFF263238),
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
        displayLarge: const TextStyle(color: Colors.black, fontSize: 10),
    displayMedium: TextStyle(color: Colors.black, fontSize: 10),
    displaySmall: TextStyle(color: Colors.black, fontSize: 10),
    headlineLarge: TextStyle(color: Colors.black, fontSize: 10),
    headlineMedium: TextStyle(color: Colors.black, fontSize: 10),
    headlineSmall: TextStyle(color: Colors.black, fontSize: 10),
    titleLarge: TextStyle(color: Colors.black, fontSize: 10),
    titleMedium: TextStyle(color: Colors.black, fontSize: 10),
    titleSmall: TextStyle(color: Colors.black, fontSize: 10),
    bodyLarge: TextStyle(color: Colors.black, fontSize: 10),
    bodyMedium: TextStyle(color: Colors.black, fontSize: 10),
    bodySmall: TextStyle(color: Colors.black, fontSize: 10),
    labelLarge : TextStyle(color: Colors.black, fontSize: 10),
    labelMedium : TextStyle(color: Colors.black, fontSize: 10),
    labelSmall : TextStyle(color: Colors.black, fontSize: 10)
    );}

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff4ffdf),
      surfaceTint: Color(0xffb1d18a),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffb5d58e),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff4ffdf),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc4cfb1),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffeafffc),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa4d4d0),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff12140e),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff9fced),
      outline: Color(0xffc9ccbe),
      outlineVariant: Color(0xffc9ccbe),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e3d8),
      inversePrimary: Color(0xff1a3000),
      primaryFixed: Color(0xffd1f2a7),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffb5d58e),
      onPrimaryFixedVariant: Color(0xff0c1a00),
      secondaryFixed: Color(0xffe0ebcc),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc4cfb1),
      onSecondaryFixedVariant: Color(0xff101907),
      tertiaryFixed: Color(0xffc0f0ec),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa4d4d0),
      onTertiaryFixedVariant: Color(0xff001a19),
      surfaceDim: Color(0xff12140e),
      surfaceBright: Color(0xff383a32),
      surfaceContainerLowest: Color(0xff0c0f09),
      surfaceContainerLow: Color(0xff1a1c16),
      surfaceContainer: Color(0xff1e201a),
      surfaceContainerHigh: Color(0xff282b24),
      surfaceContainerHighest: Color(0xff33362e),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) {
    final primaryTextTheme  = TextTheme(
      displayLarge: const TextStyle(color: Colors.black, fontSize: 10),
      displayMedium: TextStyle(color: Colors.black, fontSize: 10),
      displaySmall: TextStyle(color: Colors.black, fontSize: 10),
      headlineLarge: TextStyle(color: Colors.black, fontSize: 10),
      headlineMedium: TextStyle(color: Colors.black, fontSize: 10),
      headlineSmall: TextStyle(color: Colors.black, fontSize: 10),
      titleLarge: TextStyle(color: Colors.black, fontSize: 10),
      titleMedium: TextStyle(color: Colors.black, fontSize: 10),
      titleSmall: TextStyle(color: Colors.black, fontSize: 10),
      bodyLarge: TextStyle(color: Colors.black, fontSize: 10),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 10),
      bodySmall: TextStyle(color: Colors.black, fontSize: 10),
      labelLarge : TextStyle(color: Colors.black, fontSize: 10),
      labelMedium : TextStyle(color: Colors.black, fontSize: 10),
      labelSmall : TextStyle(color: Colors.black, fontSize: 10)
    );

    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: primaryTextTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: colorScheme.surface,
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
      this.neutralColor = const Color(0x00ffffff)});

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
        chipTheme: const ChipThemeData(backgroundColor: Colors.greenAccent),
        cardTheme: CardThemeData(
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
