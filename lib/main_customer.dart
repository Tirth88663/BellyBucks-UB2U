import 'package:bellybucks/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app_config.dart';

void main() async {
  var configuredApp = const AppConfig(
    appTitle: "BellyBucks",
    buildFlavor: "Customer",
    child: MyApp(),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC5buMB0nxik2iu4WhiWdXeWxm9NtpLCRQ", // Your apiKey
      appId: "XXX", // Your appId
      messagingSenderId: "XXX", // Your messagingSenderId
      projectId: "bellybucks-f5be8", // Your projectId
    ),
  );
  return runApp(configuredApp);
}
