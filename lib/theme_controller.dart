import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ThemeController extends GetxController {
  final GetStorage _box = GetStorage();
  final String _keyTheme = 'isDarkTheme';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isDarkTheme = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadThemeFromFirestore();
  }

  // Очистить локальные настройки темы
  void clearThemeSettings() {
    _box.remove(_keyTheme);  // Удаляем данные темы из GetStorage
    isDarkTheme.value = false;  // Сбрасываем на светлую тему
  }

  // Загружаем тему из Firestore
  Future<void> loadThemeFromFirestore() async {
  final user = _auth.currentUser;

  if (user != null) {
    print('[ThemeController] Пользователь найден: ${user.uid}');
    
    final userDoc = await _firestore.collection('users').doc(user.uid).get();

    if (userDoc.exists) {
      final data = userDoc.data();
      print('[ThemeController] Документ найден: $data');

      final themeData = data?['theme'];
      if (themeData != null) {
        isDarkTheme.value = themeData;
        print('[ThemeController] Загружена тема из Firestore: ${isDarkTheme.value ? 'Темная' : 'Светлая'}');
      } else {
        isDarkTheme.value = false;
        print('[ThemeController] Поле theme отсутствует. Используем светлую тему по умолчанию.');
      }
    } else {
      isDarkTheme.value = false;
      print('[ThemeController] Документ пользователя не найден. Используем светлую тему по умолчанию.');
    }

  } else {
    isDarkTheme.value = false;
    print('[ThemeController] Пользователь не авторизован. Используем светлую тему по умолчанию.');
  }
}

  // Переключение темы
  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    _saveThemeToBox(isDarkTheme.value);
    _saveThemeToFirestore(isDarkTheme.value);
  }

  // Сохранение темы в GetStorage (локальное хранилище)
  void _saveThemeToBox(bool isDarkTheme) {
    _box.write(_keyTheme, isDarkTheme);
  }

  // Сохранение темы в Firestore
  Future<void> _saveThemeToFirestore(bool isDarkTheme) async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDocRef = _firestore.collection('users').doc(user.uid);
      await userDocRef.set(
        {'theme': isDarkTheme}, // Сохраняем тему
        SetOptions(merge: true), // Объединяем, чтобы не перезаписать другие данные
      );
    }
  }
}