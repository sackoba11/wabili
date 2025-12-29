import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckNetworkWidget extends StatelessWidget {
  const CheckNetworkWidget({
    super.key,
    required this.isConnected,
    required this.controller,
  });

  final ValueNotifier<bool> isConnected;
  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.signal_wifi_off, size: 100, color: Colors.grey),
          const SizedBox(height: 20),

          const Text(
            "Aucune connexion internet",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Veuillez vérifier votre connexion et réessayer.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              isConnected.value = true;
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              controller.reload();
            },
            child: const Text("Réessayer"),
          ),
        ],
      ),
    );
  }
}
