import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:target_manager/features/main/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
      theme: FlexThemeData.light(
        scheme: FlexScheme.ebonyClay,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        appBarOpacity: 0.91,
        tabBarStyle: FlexTabBarStyle.forBackground,
        subThemesData: const FlexSubThemesData(
          thinBorderWidth: 5.0,
          defaultRadius: 15.0,
          textButtonRadius: 5.0,
          outlinedButtonBorderWidth: 1.5,
          outlinedButtonPressedBorderWidth: 2.5,
          sliderValueTinted: true,
          sliderTrackHeight: 8,
          inputDecoratorRadius: 20.0,
          chipRadius: 7.0,
          cardRadius: 19.0,
          popupMenuRadius: 4.0,
          popupMenuElevation: 9.0,
          dialogRadius: 18.0,
          timePickerDialogRadius: 18.0,
          appBarBackgroundSchemeColor: SchemeColor.background,
          bottomSheetRadius: 29.0,
        ),
        keyColors: const FlexKeyColors(),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        // To use the playground font, add GoogleFonts package and uncomment
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
    );
  }
}
