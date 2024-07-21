import 'dart:io' show Platform;

const REFRESH_TOKEN_KEY = 'refresh_token';
const BACKEND_TOKEN_KEY = 'backend_token';
const GOOGLE_ISSUER = 'https://accounts.google.com';
const GOOGLE_CLIENT_ID_IOS = '<IOS-CLIENT-ID>';
const GOOGLE_REDIRECT_URI_IOS = 'com.googleusercontent.apps.<IOS-CLIENT-ID>:/oauthredirect';
const GOOGLE_CLIENT_ID_ANDROID = '690025534-fvo751paoj78isrcm3tp6h14su4cp6n5.apps.googleusercontent.com';
const GOOGLE_REDIRECT_URI_ANDROID = 'com.googleusercontent.apps.<690025534-fvo751paoj78isrcm3tp6h14su4cp6n5.apps.googleusercontent.com>:/oauthredirect';

String clientID() {
  if(Platform.isAndroid) {
    return GOOGLE_CLIENT_ID_ANDROID;
  } else if (Platform.isIOS) {
    return GOOGLE_CLIENT_ID_IOS;
  }
  return '';
}

String redirectUrl() {
  if(Platform.isAndroid) {
    return GOOGLE_REDIRECT_URI_ANDROID;
  } else if (Platform.isIOS) {
    return GOOGLE_REDIRECT_URI_IOS;
  }
  return '';
}