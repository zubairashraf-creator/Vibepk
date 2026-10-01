import 'package:flutter/foundation.dart';

class VibeNotification {
  final String type;
  final String title;
  final String message;
  final DateTime createdAt;
  bool isRead;

  VibeNotification({
    required this.type,
    required this.title,
    required this.message,
    DateTime? createdAt,
    this.isRead = false,
  }) : createdAt = createdAt ?? DateTime.now();
}

class VibeNotificationStore extends ChangeNotifier {
  static final VibeNotificationStore instance =
      VibeNotificationStore._();

  VibeNotificationStore._();

  final List<VibeNotification> notifications = [];

  int get unreadCount =>
      notifications.where((notification) => !notification.isRead).length;

  void add({
    required String type,
    required String title,
    required String message,
  }) {
    notifications.insert(
      0,
      VibeNotification(
        type: type,
        title: title,
        message: message,
      ),
    );
    notifyListeners();
  }

  void markAsRead(VibeNotification notification) {
    if (!notification.isRead) {
      notification.isRead = true;
      notifyListeners();
    }
  }

  void markAllAsRead() {
    bool changed = false;

    for (final notification in notifications) {
      if (!notification.isRead) {
        notification.isRead = true;
        changed = true;
      }
    }

    if (changed) {
      notifyListeners();
    }
  }

  void clearAll() {
    if (notifications.isEmpty) return;
    notifications.clear();
    notifyListeners();
  }
}
