import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting_handler/controllers/candidate_controller.dart';
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
    Get.put(CandidateController());
    return GetMaterialApp(
      initialRoute: Routes.getHomeRoute(),
      getPages: Routes.routes,
      title: 'Voting Handler',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
