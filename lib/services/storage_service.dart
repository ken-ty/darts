import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_profile.dart';

class StorageService {
  static const String _userProfilesKey = 'user_profiles';
  static const String _currentUserKey = 'current_user';
  static const String _outshotTablesKey = 'outshot_tables';
  static const String _languageKey = 'language';
  static const String _themeKey = 'theme';

  static Future<List<UserProfile>> getUserProfiles() async {
    final prefs = await SharedPreferences.getInstance();
    final String? profilesJson = prefs.getString(_userProfilesKey);

    if (profilesJson == null) {
      return [];
    }

    final List<dynamic> profilesList = json.decode(profilesJson);
    return profilesList
        .map((profileJson) => UserProfile.fromJson(profileJson))
        .toList();
  }

  static Future<void> saveUserProfiles(List<UserProfile> profiles) async {
    final prefs = await SharedPreferences.getInstance();
    final String profilesJson = json.encode(
      profiles.map((profile) => profile.toJson()).toList(),
    );
    await prefs.setString(_userProfilesKey, profilesJson);
  }

  static Future<void> saveUserProfile(UserProfile profile) async {
    final profiles = await getUserProfiles();
    final existingIndex = profiles.indexWhere((p) => p.id == profile.id);

    if (existingIndex >= 0) {
      profiles[existingIndex] = profile;
    } else {
      profiles.add(profile);
    }

    await saveUserProfiles(profiles);
  }

  static Future<void> deleteUserProfile(String profileId) async {
    final profiles = await getUserProfiles();
    profiles.removeWhere((profile) => profile.id == profileId);
    await saveUserProfiles(profiles);
  }

  static Future<UserProfile?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? currentUserId = prefs.getString(_currentUserKey);

    if (currentUserId == null) {
      return null;
    }

    final profiles = await getUserProfiles();
    return profiles.firstWhere((profile) => profile.id == currentUserId);
  }

  static Future<void> setCurrentUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, userId);
  }

  static Future<void> clearCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userProfilesKey);
    await prefs.remove(_currentUserKey);
  }

  /// アプリの全データを削除（初期化）
  static Future<void> clearAllAppData() async {
    final prefs = await SharedPreferences.getInstance();

    // ユーザー関連データ
    await prefs.remove(_userProfilesKey);
    await prefs.remove(_currentUserKey);

    // アウトショットテーブル
    await prefs.remove(_outshotTablesKey);

    // 設定関連データ
    await prefs.remove(_languageKey);
    await prefs.remove(_themeKey);

    // その他のアプリデータ（キーが分からないものも含めて全削除）
    await prefs.clear();
  }
}
