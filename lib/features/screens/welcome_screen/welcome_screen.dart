import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:story_land/features/screens/welcome_screen/desktop_tablet_welcome_screen.dart';
import 'package:story_land/features/screens/welcome_screen/mobile_welcome_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => MobileWelcomeScreen(),
      tablet: (BuildContext context) => DesktopTabletWelcomeScreen(),
    );
  }
}
