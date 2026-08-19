import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/session_history.dart';

class SessionService extends ChangeNotifier {
  int completedSessions = 0;
  int streak = 1;
  String? todayMood;
  List<SessionHistory> history = [];

  SessionService() {
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    completedSessions = prefs.getInt('completedSessions') ?? 0;
    streak = prefs.getInt('streak') ?? 1;
    todayMood = prefs.getString('todayMood');
    final historyString = prefs.getString('history');

    if (historyString != null) {
      final decoded = jsonDecode(historyString) as List;

      history = decoded.map((e) => SessionHistory.fromJson(e)).toList();
    }

    notifyListeners();
  }

  Future<void> completeSession(int minutes) async {
    completedSessions++;
    history.insert(
      0,
      SessionHistory(
        date: DateTime.now().toIso8601String(),
        minutes: minutes, // We'll make this dynamic next
      ),
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('completedSessions', completedSessions);
    await prefs.setString(
      'history',
      jsonEncode(history.map((e) => e.toJson()).toList()),
    );
    notifyListeners();
  }

  Future<void> saveMood(String mood) async {
    todayMood = mood;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('todayMood', mood);

    notifyListeners();
  }

  Future<void> increaseStreak() async {
    streak++;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('streak', streak);

    notifyListeners();
  }
}
