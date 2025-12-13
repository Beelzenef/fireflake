import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/author_settings.dart';

class AuthorCubit extends Cubit<AuthorSettings> {
  static const String _storageKey = 'author_settings';

  AuthorCubit() : super(const AuthorSettings()) {
    loadSettings();
  }

  // Cargar configuración desde SharedPreferences
  Future<void> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);

      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        emit(AuthorSettings.fromJson(json));
      }
    } catch (e) {
      // Si hay error, mantener valores por defecto
      print('Error loading author settings: $e');
    }
  }

  // Guardar configuración en SharedPreferences
  Future<void> saveSettings(AuthorSettings settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(settings.toJson());
      await prefs.setString(_storageKey, jsonString);
      emit(settings);
    } catch (e) {
      print('Error saving author settings: $e');
    }
  }

  // Actualizar nombre
  Future<void> updateName(String name) async {
    final updated = state.copyWith(name: name);
    await saveSettings(updated);
  }

  // Actualizar biografía
  Future<void> updateBio(String bio) async {
    final updated = state.copyWith(bio: bio);
    await saveSettings(updated);
  }

  // Actualizar email
  Future<void> updateEmail(String email) async {
    final updated = state.copyWith(email: email);
    await saveSettings(updated);
  }

  // Actualizar todo a la vez
  Future<void> updateAll({
    String? name,
    String? bio,
    String? email,
  }) async {
    final updated = state.copyWith(
      name: name,
      bio: bio,
      email: email,
    );
    await saveSettings(updated);
  }
}
