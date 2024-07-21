// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helmy_project/app/components.dart';
import 'package:helmy_project/helpers/snackbar_helper.dart';
import 'package:helmy_project/modules/favourite/cubit/cubit/home_cubit/cubit/home_cubit.dart';
import 'package:helmy_project/modules/start/cubits/bottom_nav_bar_cubit.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import 'package:helmy_project/resources/routes_manager.dart';
import 'package:helmy_project/resources/strings_manager.dart';
import 'package:helmy_project/resources/styles_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

const String kLocalExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string example</title>
</head>
<body>

<h1>Local demo page</h1>
<p>
  This is an example page used to demonstrate how to load a local file or HTML
  string using the <a href="https://pub.dev/packages/webview_flutter">Flutter
  webview</a> plugin.
</p>

</body>
</html>
''';

// NOTE: This is used by the transparency test in `example/ios/RunnerUITests/FLTWebViewUITests.m`.
const String kTransparentBackgroundPage = '''
<!DOCTYPE html>
<html>
<head>
  <title>Transparent background test</title>
</head>
<style type="text/css">
  body { background: transparent; margin: 0; padding: 0; }
  #container { position: relative; margin: 0; padding: 0; width: 100vw; height: 100vh; }
  #shape { background: #FF0000; width: 200px; height: 100%; margin: 0; padding: 0; position: absolute; top: 0; bottom: 0; left: calc(50% - 100px); }
  p { text-align: center; }
</style>
<body>
  <div id="container">
    <p>Transparent background test</p>
    <div id="shape"></div>
  </div>
</body>
</html>
''';

const String kLogExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string example</title>
</head>
<body onload="console.log('Logging that the page is loading.')">

<h1>Local demo page</h1>
<p>
  This page is used to test the forwarding of console logs to Dart.
</p>

<style>
    .btn-group button {
      padding: 24px; 24px;
      display: block;
      width: 25%;
      margin: 5px 0px 0px 0px;
    }
</style>

<div class="btn-group">
    <button onclick="console.error('This is an error message.')">Error</button>
    <button onclick="console.warn('This is a warning message.')">Warning</button>
    <button onclick="console.info('This is a info message.')">Info</button>
    <button onclick="console.debug('This is a debug message.')">Debug</button>
    <button onclick="console.log('This is a log message.')">Log</button>
</div>

</body>
</html>
''';

const String kAlertTestPage = '''
<!DOCTYPE html>
<html>  
   <head>     
      <script type = "text/javascript">  
            function showAlert(text) {	          
	            alert(text);      
            }  
            
            function showConfirm(text) {
              var result = confirm(text);
              alert(result);
            }
            
            function showPrompt(text, defaultText) {
              var inputString = prompt('Enter input', 'Default text');
	            alert(inputString);            
            }            
      </script>       
   </head>  
     
   <body>  
      <p> Click the following button to see the effect </p>        
      <form>  
        <input type = "button" value = "Alert" onclick = "showAlert('Test Alert');" />
        <input type = "button" value = "Confirm" onclick = "showConfirm('Test Confirm');" />  
        <input type = "button" value = "Prompt" onclick = "showPrompt('Test Prompt', 'Default Value');" />    
      </form>       
   </body>  
</html>  
''';
class WebViewExample extends StatefulWidget {
  const WebViewExample({super.key, this.cookieManager, required this.url});

  final PlatformWebViewCookieManager? cookieManager;
  final String url;

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final PlatformWebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = PlatformWebViewController(
      WebKitWebViewControllerCreationParams(allowsInlineMediaPlayback: true),
    )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x80000000))
      ..setPlatformNavigationDelegate(
        PlatformNavigationDelegate(
          const PlatformNavigationDelegateCreationParams(),
        )
          ..setOnProgress((int progress) {
            debugPrint('WebView is setOnProgress loading (progress : $progress%)');
          })
          ..setOnPageStarted((String url) {
            debugPrint('Page started setOnPageStarted loading: $url');
            setState(() {
              isLoading = true;
            });
          })
          ..setOnPageFinished((String url) {
            debugPrint('Page finished setOnPageFinished loading: $url');
            setState(() {
              isLoading = false;
            });
          })
          ..setOnHttpError((HttpResponseError error) {
            debugPrint('Error occurred setOnHttpError on page: ${error.response?.statusCode}');
          })
          ..setOnWebResourceError((WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
  url: ${error.url}
          ''');
          })
          ..setOnNavigationRequest((NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation setOnNavigationRequest to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation setOnNavigationRequest to ${request.url}');
            return NavigationDecision.navigate;
          })
          ..setOnUrlChange((UrlChange change) {
            debugPrint('url change setOnUrlChange to ${change.url}');
            handleUrlChange(change.url!);
          })
          ..setOnHttpAuthRequest((HttpAuthRequest request) {
            openDialog(request);
          }),
      )
      ..addJavaScriptChannel(JavaScriptChannelParams(
        name: 'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      ))
      ..setOnPlatformPermissionRequest((PlatformWebViewPermissionRequest request) {
        debugPrint('requesting permissions for ${request.types.map((WebViewPermissionResourceType type) => type.name)}');
        request.grant();
      })
      ..loadRequest(LoadRequestParams(
        uri: Uri.parse(widget.url),
      ))
      ..setOnScrollPositionChange((ScrollPositionChange scrollPositionChange) {
        debugPrint('Scroll position change to x = ${scrollPositionChange.x}, y = ${scrollPositionChange.y}');
      });
  }

  Future<void> handleUrlChange(String url) async {
    if (url.contains("kashier-payment-redirect?paymentStatus=SUCCESS")) {
      debugPrint('Handling URL change handleUrlChange: $url');

      Get.back();

      Get.offAllNamed(HelmyRoutes.userStartRoute);

      BlocProvider.of<HomeCubit>(context).page = 1;
      BlocProvider.of<HomeCubit>(context).getAllDreams(isFromInterpreter: false);
      SnackBarHelper.showSuccessSnackBar('الدفع', 'تم الدفع بنجاح');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const SizedBox(),
        title: Text(
          tr(StringsManager.payment),
          style: getRegularStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          PlatformWebViewWidget(
              PlatformWebViewWidgetCreationParams(controller: _controller),
            ).build(context),
        
          if (isLoading)
           Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child:  Center(child: Loading())),
        ],
      ),
    );
  }

  Future<void> openDialog(HttpAuthRequest httpRequest) async {
    final TextEditingController usernameTextController = TextEditingController();
    final TextEditingController passwordTextController = TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${httpRequest.host}: ${httpRequest.realm ?? '-'}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  autofocus: true,
                  controller: usernameTextController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  controller: passwordTextController,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                httpRequest.onCancel();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                httpRequest.onProceed(
                  WebViewCredential(
                    user: usernameTextController.text,
                    password: passwordTextController.text,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Authenticate'),
            ),
          ],
        );
      },
    );
  }
}
