import '../models/finish_combination.dart';
import '../models/user_profile.dart';
import 'darts_calculator.dart';
import 'storage_service.dart';

class UserService {
  static UserProfile? _currentUser;
  static List<UserProfile> _users = [];

  static Future<void> initialize() async {
    _users = await StorageService.getUserProfiles();
    _currentUser = await StorageService.getCurrentUser();

    // デフォルトユーザーを作成（存在しない場合）
    if (_users.isEmpty) {
      await createDefaultUser();
    }
  }

  static Future<UserProfile> createDefaultUser() async {
    final defaultUser = UserProfile(
      id: 'default_user',
      name: 'デフォルトユーザー',
      finishBoard: DartsCalculator.getDefaultFinishes(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await StorageService.saveUserProfile(defaultUser);
    _users.add(defaultUser);

    if (_currentUser == null) {
      await setCurrentUser(defaultUser);
    }

    return defaultUser;
  }

  static Future<UserProfile> createUser(String name) async {
    final user = UserProfile(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      finishBoard: DartsCalculator.getDefaultFinishes(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await StorageService.saveUserProfile(user);
    _users.add(user);

    return user;
  }

  static Future<void> updateUser(UserProfile user) async {
    final updatedUser = user.copyWith(updatedAt: DateTime.now());
    await StorageService.saveUserProfile(updatedUser);

    final index = _users.indexWhere((u) => u.id == user.id);
    if (index >= 0) {
      _users[index] = updatedUser;
    }

    if (_currentUser?.id == user.id) {
      _currentUser = updatedUser;
    }
  }

  static Future<void> deleteUser(String userId) async {
    await StorageService.deleteUserProfile(userId);
    _users.removeWhere((user) => user.id == userId);

    if (_currentUser?.id == userId) {
      _currentUser = null;
      await StorageService.clearCurrentUser();
    }
  }

  static Future<void> setCurrentUser(UserProfile user) async {
    _currentUser = user;
    await StorageService.setCurrentUser(user.id);
  }

  static UserProfile? getCurrentUser() {
    return _currentUser;
  }

  static List<UserProfile> getAllUsers() {
    return List.from(_users);
  }

  static UserProfile? getUserById(String id) {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  static Future<void> updateFinishCombination(
    String userId,
    int score,
    FinishCombination combination,
  ) async {
    final user = getUserById(userId);
    if (user == null) return;

    final updatedFinishBoard = Map<int, FinishCombination>.from(
      user.finishBoard,
    );
    updatedFinishBoard[score] = combination;

    final updatedUser = user.copyWith(
      finishBoard: updatedFinishBoard,
      updatedAt: DateTime.now(),
    );

    await updateUser(updatedUser);
  }

  static Future<void> removeFinishCombination(String userId, int score) async {
    final user = getUserById(userId);
    if (user == null) return;

    final updatedFinishBoard = Map<int, FinishCombination>.from(
      user.finishBoard,
    );
    updatedFinishBoard.remove(score);

    final updatedUser = user.copyWith(
      finishBoard: updatedFinishBoard,
      updatedAt: DateTime.now(),
    );

    await updateUser(updatedUser);
  }

  static List<FinishCombination> getUserFinishes(String userId) {
    final user = getUserById(userId);
    if (user == null) return [];

    return user.finishBoard.values.toList()
      ..sort((a, b) => a.score.compareTo(b.score));
  }

  static FinishCombination? getFinishCombination(String userId, int score) {
    final user = getUserById(userId);
    if (user == null) return null;

    return user.finishBoard[score];
  }

  static Future<void> resetUserFinishBoard(String userId) async {
    final user = getUserById(userId);
    if (user == null) return;

    final updatedUser = user.copyWith(
      finishBoard: DartsCalculator.getDefaultFinishes(),
      updatedAt: DateTime.now(),
    );

    await updateUser(updatedUser);
  }

  // ゲーム記録関連メソッド
  static Future<void> addGameRecord(
    String userId,
    GameRecord gameRecord,
  ) async {
    final user = getUserById(userId);
    if (user == null) return;

    final updatedGameRecords = List<GameRecord>.from(user.gameRecords);
    updatedGameRecords.add(gameRecord);

    final updatedUser = user.copyWith(
      gameRecords: updatedGameRecords,
      updatedAt: DateTime.now(),
    );

    await updateUser(updatedUser);
  }

  static Future<void> removeGameRecord(
    String userId,
    String gameRecordId,
  ) async {
    final user = getUserById(userId);
    if (user == null) return;

    final updatedGameRecords = user.gameRecords
        .where((record) => record.id != gameRecordId)
        .toList();

    final updatedUser = user.copyWith(
      gameRecords: updatedGameRecords,
      updatedAt: DateTime.now(),
    );

    await updateUser(updatedUser);
  }

  static List<GameRecord> getUserGameRecords(String userId) {
    final user = getUserById(userId);
    if (user == null) return [];

    final sorted = List<GameRecord>.from(user.gameRecords);
    sorted.sort((a, b) => b.playedAt.compareTo(a.playedAt));
    return sorted;
  }

  // 練習セッション関連メソッド
  static Future<void> addPracticeSession(
    String userId,
    PracticeSession session,
  ) async {
    final user = getUserById(userId);
    if (user == null) return;

    final updatedSessions = List<PracticeSession>.from(user.practiceSessions);
    updatedSessions.add(session);

    final updatedUser = user.copyWith(
      practiceSessions: updatedSessions,
      updatedAt: DateTime.now(),
    );

    await updateUser(updatedUser);
  }

  static Future<void> updatePracticeSession(
    String userId,
    PracticeSession session,
  ) async {
    final user = getUserById(userId);
    if (user == null) return;

    final updatedSessions = user.practiceSessions.map((s) {
      if (s.id == session.id) {
        return session;
      }
      return s;
    }).toList();

    final updatedUser = user.copyWith(
      practiceSessions: updatedSessions,
      updatedAt: DateTime.now(),
    );

    await updateUser(updatedUser);
  }

  static Future<void> removePracticeSession(
    String userId,
    String sessionId,
  ) async {
    final user = getUserById(userId);
    if (user == null) return;

    final updatedSessions = user.practiceSessions
        .where((session) => session.id != sessionId)
        .toList();

    final updatedUser = user.copyWith(
      practiceSessions: updatedSessions,
      updatedAt: DateTime.now(),
    );

    await updateUser(updatedUser);
  }

  static List<PracticeSession> getUserPracticeSessions(String userId) {
    final user = getUserById(userId);
    if (user == null) return [];

    final sorted = List<PracticeSession>.from(user.practiceSessions);
    sorted.sort((a, b) => b.startedAt.compareTo(a.startedAt));
    return sorted;
  }

  // 統計関連メソッド
  static Map<String, dynamic> getUserStatistics(String userId) {
    final user = getUserById(userId);
    if (user == null) return {};

    return {
      'totalGamesPlayed': user.totalGamesPlayed,
      'totalPracticeSessions': user.totalPracticeSessions,
      'totalDartsThrown': user.totalDartsThrown,
      'averageScore': user.averageScore,
      'finishCombinationsCount': user.finishCombinationsCount,
      'recentGames': user.recentGames,
      'recentPracticeSessions': user.recentPracticeSessions,
    };
  }

  static Future<void> clearAllData() async {
    await StorageService.clearAll();
    _users.clear();
    _currentUser = null;
  }
}
