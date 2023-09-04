import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/api/firebase_api.dart';
import 'package:todoapp/firebase_options.dart';
import 'package:todoapp/pages/home_page.dart';
import 'package:todoapp/pages/notification_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
// FLutter binding
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  // init the hive
  await Hive.initFlutter();
  // open a box
  var box = await Hive.openBox('mybox');
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.lime),
        home: HomePage(),
        navigatorKey: navigatorKey,
        routes: {
          '/notification_screen': (context) => const NotificationPage(),
        });
  }
}
