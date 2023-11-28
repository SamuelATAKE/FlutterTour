import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:tour/awesome_notification_service.dart';
import 'package:tour/home.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await AwesomeNotificationService.initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Slide> slides = [
      Slide(
        title: "Welcome!",
        description: "Tap the button below to continue...",
        styleTitle: const TextStyle(fontSize: 24),
        styleDescription: const TextStyle(fontSize: 16),
        pathImage: "assets/image1.jpg", // Optional: Image path
      ),
      // Add more slides as needed
      Slide(
        title: "This is dark!",
        description: "Tap the button below to get started.",
        styleTitle: const TextStyle(fontSize: 24),
        styleDescription: const TextStyle(fontSize: 16),
        pathImage: "assets/image2.jpg", // Optional: Image path
      ),
    ];
    return MaterialApp(
      title: 'Flutter Tour',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: IntroSlider(
          slides: slides,
          onDonePress: () {
            AwesomeNotificationService.showNotification(
              title: 'Bienvenue',
              body: 'Vous avez installé l\'application avec succès!',
              summary: 'FunkyApp',
            );
            navigatorKey.currentState?.pushReplacement(
                MaterialPageRoute(builder: (context) => const Home()));
          },
          onSkipPress: () {
            navigatorKey.currentState?.pushReplacement(
                MaterialPageRoute(builder: (context) => const Home()));
          },
        ),
      ),
      navigatorKey: navigatorKey,
    );
  }
}
