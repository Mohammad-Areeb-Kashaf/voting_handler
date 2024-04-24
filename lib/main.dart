import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting_handler/binding.dart';
import 'package:voting_handler/firebase_options.dart';
import 'package:voting_handler/screens/home_screen.dart';

import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.getHomeRoute(),
      getPages: Routes.routes,
      title: 'Voting Handler',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(26, 35, 126, 1),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      initialBinding: Binding(),
    );
  }
}
