import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SplashScreen extends StatefulWidget {
  final ValueNotifier<WebViewController> controller;
  final ValueNotifier<bool> isConnected;
  const SplashScreen({
    super.key,
    required this.controller,
    required this.isConnected,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ValueNotifier<bool> isLoading = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    widget.controller.value =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (url) {
                isLoading.value = false;
              },
              onWebResourceError: (error) {
                if (error.errorType == WebResourceErrorType.connect ||
                    error.errorType == WebResourceErrorType.timeout ||
                    error.errorType == WebResourceErrorType.hostLookup) {
                  widget.isConnected.value = false;
                  isLoading.value = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    customSnackbar(message: "Aucune connexion internet"),
                  );

                  return;
                }
                isLoading.value = false;
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackbar(message: "Erreur: ${error.description}"),
                );
              },
            ),
          )
          ..loadRequest(Uri.parse('https://wabili.com'));
  }

  SnackBar customSnackbar({required String message}) {
    return SnackBar(
      showCloseIcon: true,
      closeIconColor: Colors.black,
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      backgroundColor: Colors.red.shade100,
      content: Text(message, style: TextStyle(color: Colors.black)),
      behavior: SnackBarBehavior.floating,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isLoading.addListener(() {
      if (!isLoading.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'assets/splash.png',
                height: 100,
                width: MediaQuery.sizeOf(context).width / 1.5,
              ),
            ),

            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Text(
                    "Wabili.com",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  CircularProgressIndicator(color: Color(0xFFfe7900)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
