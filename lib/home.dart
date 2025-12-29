import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'widgets/check_network_widget.dart';

class HomePage extends StatelessWidget {
  final ValueNotifier<bool> isConnected;
  final ValueNotifier<WebViewController> controller;

  const HomePage({
    super.key,
    required this.controller,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> canPop = ValueNotifier(false);
    return Scaffold(
      body: ListenableBuilder(
        listenable: canPop,
        builder: (context, _) {
          return PopScope(
            canPop: canPop.value,
            // ignore: deprecated_member_use
            onPopInvoked: (didPop) async {
              if (await controller.value.canGoBack()) {
                controller.value.goBack();
              } else {
                Fluttertoast.showToast(
                  msg: "Cliquer encore pour quitter l'application",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                canPop.value = true;
                Future.delayed(const Duration(seconds: 3), () {
                  canPop.value = false;
                });
              }
            },
            child: ListenableBuilder(
              listenable: controller,
              builder: (context, _) {
                return SafeArea(
                  child: ListenableBuilder(
                    listenable: isConnected,
                    builder:
                        (context, child) =>
                            isConnected.value
                                ? WebViewWidget(controller: controller.value)
                                : CheckNetworkWidget(
                                  isConnected: isConnected,
                                  controller: controller.value,
                                ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
