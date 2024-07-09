import 'dart:async';
import 'dart:convert' show json;
// import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helmy_project/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:helmy_project/modules/auth/models/user_model.dart';
import 'package:helmy_project/resources/assets_manager.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: scopes,
);

class SignInDemo extends StatefulWidget {
  const SignInDemo({super.key});

  @override
  State createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      bool isAuthorized = account != null;
      if (kIsWeb && account != null) {
        isAuthorized = await googleSignIn.canAccessScopes(scopes);
      }
      setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });
      if (isAuthorized) {
        unawaited(_handleGetContact(account!));
      }
    });
    googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse(
          'https://people.googleapis.com/v1/people/me/connections?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText =
            'People API gave a ${response.statusCode} response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
        (dynamic name) =>
            (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await googleSignIn.signIn().then((user) {
        print(
            'user data is ${user!.email}, ${user.displayName}, ${user.photoUrl} , ');

        context.read<AuthBloc>().add(RegisterWithSocialAccount(
            context: context,
            user: UserData(
              name: user.displayName,
              email: user.email,
              avatar: user.photoUrl,
            )));
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleAuthorizeScopes() async {
    final bool isAuthorized = await googleSignIn.requestScopes(scopes);
    setState(() {
      _isAuthorized = isAuthorized;
    });
    if (isAuthorized) {
      unawaited(_handleGetContact(_currentUser!));
    }
  }

  Future<void> _handleSignOut() => googleSignIn.disconnect();

  Widget _buildBody() {
    // final GoogleSignInAccount? user = _currentUser;
    // if (user != null) {
    //   return Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: <Widget>[
    //       ListTile(
    //         leading: GoogleUserCircleAvatar(
    //           identity: user,
    //         ),
    //         title: Text(user.displayName ?? ''),
    //         subtitle: Text(user.email),
    //       ),
    //       const Text('Signed in successfully.'),
    //       if (_isAuthorized) ...<Widget>[
    //         Text(_contactText),
    //         ElevatedButton(
    //           child: const Text('REFRESH'),
    //           onPressed: () => _handleGetContact(user),
    //         ),
    //       ],
    //       if (!_isAuthorized) ...<Widget>[
    //         const Text('Additional permissions needed to read your contacts.'),
    //         ElevatedButton(
    //           onPressed: _handleAuthorizeScopes,
    //           child: const Text('REQUEST PERMISSIONS'),
    //         ),
    //       ],
    //       ElevatedButton(
    //         onPressed: _handleSignOut,
    //         child: const Text('SIGN OUT'),
    //       ),
    //     ],
    //   );
    // } else {
    //   return Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: <Widget>[
    //       const Text('You are not currently signed in.'),
    return Row(
      children: [
        buildGoogleSignInButton(
            onPressed: _handleSignIn, imagePath: AssetsManager.google),
        SizedBox(
          width: 20.w,
        ),
        buildGoogleSignInButton(
            onPressed: () async {
              final credential = await SignInWithApple.getAppleIDCredential(
                scopes: [
                  AppleIDAuthorizationScopes.email,
                  AppleIDAuthorizationScopes.fullName,
                ],
                webAuthenticationOptions: WebAuthenticationOptions(
                  // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
                  clientId: 'de.lunaone.flutter.signinwithappleexample.service',
                  redirectUri:
                      // For web your redirect URI needs to be the host of the "current page",
                      // while for Android you will be using the API server that redirects back into your app via a deep link
                      // NOTE(tp): For package local development use (as described in `Development.md`)
                      // Uri.parse('https://siwa-flutter-plugin.dev/')
                      kIsWeb
                          ? Uri.parse(''
                              // 'https://${window.location.host}/'
                              '')
                          : Uri.parse(
                              'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
                            ),
                ),
                // TODO: Remove these if you have no need for them
                nonce: 'example-nonce',
                state: 'example-state',
              );

              // ignore: avoid_print
              print(credential);

              // This is the endpoint that will convert an authorization code obtained
              // via Sign in with Apple into a session in your system
              final signInWithAppleEndpoint = Uri(
                scheme: 'https',
                host: 'flutter-sign-in-with-apple-example.glitch.me',
                path: '/sign_in_with_apple',
                queryParameters: <String, String>{
                  'code': credential.authorizationCode,
                  if (credential.givenName != null)
                    'firstName': credential.givenName!,
                  if (credential.familyName != null)
                    'lastName': credential.familyName!,
                  'useBundleId': 'true',
                  // !kIsWeb && (Platform.isIOS || Platform.isMacOS)
                  //     ? 'true'
                  //     : 'false',
                  if (credential.state != null) 'state': credential.state!,
                },
              );

              final session = await http.Client().post(
                signInWithAppleEndpoint,
              );

              // If we got this far, a session based on the Apple ID credential has been created in your system,
              // and you can now set this as the app's session
              // ignore: avoid_print
              print(session);
            },
            imagePath: AssetsManager.apple),
      ],
    );
    // ]
    //   );
    // }
  }

  Widget buildGoogleSignInButton(
      {required dynamic onPressed, required String imagePath}) {
    return InkWell(
        onTap: onPressed,
        child: Container(
            width: 54,
            height: 54,
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: SvgPicture.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
