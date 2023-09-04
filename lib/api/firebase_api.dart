import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:todoapp/main.dart';

class FirebaseApi {
  // create instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initalize the notifications
  Future<void> initNotifications() async {
    // request permission from the user (will prompt user)
    await _firebaseMessaging.requestPermission();

    // fetch the FCM token from the device
    final fCMToken = await _firebaseMessaging.getToken();

    // print the token
    print("FCM Token: $fCMToken");

    // initialize further settings for notification
    initPushNotification();
  }

  // function to handle recieved
  void handleMessage(RemoteMessage? message) {
    // if message is null , do nothing
    if (message == null) return;

    // if it has value, navigate to the notification_screen and user taps notification
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  // function to initialize the foreground and background settings
  Future initPushNotification() async {
    // handle notification if app terminate and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // attach event listeners when app opens notification
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
