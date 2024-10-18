import 'package:flutter/material.dart';
import 'package:task/models/user_model.dart';
import 'package:task/services/api_service.dart';

class UserProvider with ChangeNotifier {
  final ApiService apiService = ApiService();
  List<User> users = [];
  bool isLoading = false;
  bool hasMore = true;
  String? error;
  int page = 0;
  final int limit = 10;

  Future<void> fetchUsers() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final data = await apiService.fetchUsers(page, limit);
      final List<User> fetchedUsers =
          (data['data'] as List).map((user) => User.fromJson(user)).toList();

      if (fetchedUsers.length < limit) {
        hasMore = false;
      }

      users.addAll(fetchedUsers);
      page++;
    } catch (e) {
      error = 'Failed to fetch the  data. Please try again.';
      hasMore = false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
