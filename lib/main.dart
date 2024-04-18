import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/auth/AuthGate.dart';
import 'package:mobileapp/auth/login_or_register.dart';
import 'package:mobileapp/pages/main_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB8R87nhBwhgQdFURdDfxZk_9ZAmImv1fU",
          appId: "1:998051273657:android:218ee6cbd8e7ceffbb3468",
          messagingSenderId: "998051273657",
          projectId: "mobileapp-38ff9",
        storageBucket: "mobileapp-38ff9.appspot.com",
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      home: AuthGate(),
    );
  }

}