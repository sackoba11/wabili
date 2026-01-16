import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'home.dart';
import 'splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<WebViewController> controller = ValueNotifier(
      WebViewController(),
    );
    final ValueNotifier<bool> isConnected = ValueNotifier(true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFfe7900),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFfe7900)),
      ),
      home: SplashScreen(controller: controller, isConnected: isConnected),
      routes: {
        '/home': (context) =>
            HomePage(controller: controller, isConnected: isConnected),
      },
    );
  }
}
