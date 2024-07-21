import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import '../../../helpers/snackbar_helper.dart';
import '../../../resources/colors_manager.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  String? lastUrl;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is onProgress loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started onPageStarted loading: $url');
          },
          onPageFinished: (String url) async {
            debugPrint('Page finished onPageFinished loading: $url');
            lastUrl = url;
            await handleUrlChange(url);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
                  Page resource error:
                    code: ${error.errorCode}
                    description: ${error.description}
                    errorType: ${error.errorType}
                    isForMainFrame: ${error.isForMainFrame}
                            ''');
          },
          onNavigationRequest: (NavigationRequest request) async {
            log('request onNavigationRequest url ${request.url}');
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            lastUrl = request.url;
            await handleUrlChange(request.url);
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) async {
            debugPrint('url change onUrlChange to ${change.url}');
            lastUrl = change.url;
            await handleUrlChange(change.url!);
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  Future<void> handleUrlChange(String url) async {
    debugPrint('Handling URL change handleUrlChange: $url');
    if (url
        .contains("https://stage.helmyeg.com/api/kashier-payment-redirect")) {
      Dio dio = Dio();

      try {
        final response = await dio.get(url);
        if (response.data is Map<String, dynamic>) {
          if (response.data['message'] == "Payment Successful") {
            Get.back();
            SnackBarHelper.showSuccessSnackBar(
                'Payment', 'Payment was successful.');
          } else {
            SnackBarHelper.showErrorSnackBar('Error', "Payment failed.");
          }
        }
      } catch (e) {
        debugPrint('Error while fetching URL data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryLightPurple,
      body: WebViewWidget(controller: _controller),
    );
  }
}
