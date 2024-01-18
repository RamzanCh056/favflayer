// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'package:ffadvertisement/login/login.dart';
import 'package:ffadvertisement/utils/storage_service.dart';
import 'package:ffadvertisement/signup/signup.dart';
import 'package:ffadvertisement/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding/consts.dart';
import 'onboarding/screen/start_screen.dart';
import 'onboarding/screen/welcome_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Handle the message when the app is in the foreground
    print("Message data: ${message.data}");
    print("Notification title: ${message.notification?.title}");
    print("Notification body: ${message.notification?.body}");
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Handle the message when the app is in the background or terminated
    print("Message data: ${message.data}");
  });
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

// Request notification permissions
  NotificationSettings settings = await _firebaseMessaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission for notifications');
  } else {
    print('User declined permission for notifications');
  }

  // Get the APNs token
  String? apnsToken = await _firebaseMessaging.getAPNSToken();
  print('APNs Token: $apnsToken');

  String? fcmToken;

  _firebaseMessaging.getToken().then((token) {
    fcmToken = token;
    print('FCM Token: $fcmToken');
    StaticInfo.fcmToken = fcmToken;

    // You can use the 'fcmToken' as needed (e.g., send it to your server)
  });
FirebaseMessaging messaging = FirebaseMessaging.instance;
await messaging.subscribeToTopic('Broadcast');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(RestartApp(child: const MyApp()));
}

class RestartApp extends StatefulWidget {
  const RestartApp({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  static void restart(BuildContext context) {
    context.findAncestorStateOfType<_RestartAppState>()!.restartApp();
  }

  @override
  State<RestartApp> createState() => _RestartAppState();
}

class _RestartAppState extends State<RestartApp> {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite Flyer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF1D1C2E),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(Colors.white),
        ),
        primarySwatch: MaterialColor(
          0xFF1D1C2E,
          {
            50: Color(0xFF1D1C2E),
            100: Color(0xFF1D1C2E),
            200: Color(0xFF1D1C2E),
            300: Color(0xFF1D1C2E),
            400: Color(0xFF1D1C2E),
            500: Color(0xFF1D1C2E),
            600: Color(0xFF1D1C2E),
            700: Color(0xFF1D1C2E),
            800: Color(0xFF1D1C2E),
            900: Color(0xFF1D1C2E),
          },
        ),
      ),
      home:FutureBuilder<bool>(
        future: checkUserInfoCompletion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Or a loading screen
          } else {
            if (snapshot.data == true) {
              return SplashScreen();
            } else {
              return WelcomeScreen();
            }
          }
        },
      ),
      //SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/home': (context) => App(),
      },
    );
  }

Future<bool> checkUserInfoCompletion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if all required user info fields are not empty
    return prefs.getString('name') != null &&
        prefs.getString('zipCode') != null &&
        prefs.getString('age') != null &&
        prefs.getString('country') != null &&
        prefs.getString('gender') != null;
  }


}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () async => await StorageService().readSecureData("user_id") != null
          ? Navigator.of(context).pushReplacementNamed('/home')
          : Navigator.of(context).pushReplacementNamed('/home'),
    );
  }
    //  : Navigator.of(context).pushReplacementNamed('/login'),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png", height: 100, width: 300),
              CircularProgressIndicator(
                backgroundColor: Color(0xFF6AA71A),
              )
            ],
          ),
        ),
      ),
    );
  }


}
