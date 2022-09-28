import 'dart:async';
import 'dart:ui';

import 'package:bellybucks/bottombar_navigation.dart';
import 'package:bellybucks/provider/dark_theme_provider.dart';
import 'package:bellybucks/screens/login%20screen/login_screen.dart';
import 'package:bellybucks/screens/splash_screen.dart';
import 'package:bellybucks/screens/varify_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey: "AIzaSyC5buMB0nxik2iu4WhiWdXeWxm9NtpLCRQ", // Your apiKey
//       appId: "XXX", // Your appId
//       messagingSenderId: "XXX", // Your messagingSenderId
//       projectId: "bellybucks-f5be8", // Your projectId
//     ),
//   );
//   runApp(
//     const MyApp(),
//   );
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          themeChangeProvider.getDarkTheme;
          return MaterialApp(
            title: 'BellyBucks',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            scrollBehavior: MyCustomScrollBehavior(),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late StreamSubscription<User?> user;

  @override
  void initState() {
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        const snackBar =
            SnackBar(content: Text('User is currently signed out!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        const snackBar = SnackBar(content: Text('User is signed in!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return const VerifyEmailScreen();
            } else {
              return FirebaseAuth.instance.currentUser == null
                  ? const LoginScreen()
                  : const BottomBarNavigation();
            }
          }),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
