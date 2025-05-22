import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';  // Google OAuth Provider
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';

import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'theme_controller.dart';
import 'login_screen.dart';
import 'home_screen.dart';

// Run Point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    GoogleProvider(
      clientId:
          '425200153710-obl2jb1ouv2t6arr090a4t79uai68dr8.apps.googleusercontent.com',
    ),
  ]);

  // Инициализация Hive по платформе
  await Hive.initFlutter();
  await Hive.openBox('tasks');
  await initializeDateFormatting('fr_FR', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Instantiate the ThemeController using Get.put to make it globally available
  final ThemeController themeController = Get.put(ThemeController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        title: 'Daily Planner',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode:
            themeController.isDarkTheme.value ? ThemeMode.dark : ThemeMode.light,
        home: const AuthenticationWrapper(),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Загружаем тему сразу после входа
      final themeController = Get.find<ThemeController>();
      themeController.loadThemeFromFirestore(); // Загрузка настроек темы

      return const HomeScreen(isGuest: false);
    } else {
      // Пользователь не залогинен — показываем выбор: логин или гостевой режим
      return Scaffold(
        appBar: AppBar(title: const Text('Welcome')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Переход к экрану логина
                  Get.to(() => const LoginScreen());
                },
                child: const Text('Login / Register'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Переход в гостевой режим
                  Get.to(() => const HomeScreen(isGuest: true));
                },
                child: const Text('Continue as Guest'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
