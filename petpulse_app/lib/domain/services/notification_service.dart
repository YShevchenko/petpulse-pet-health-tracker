import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

import '../../core/constants.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/sqlite_pet_repository.dart';
import '../../presentation/screens/pet_detail_screen.dart';
import '../models/medication.dart';
import '../models/vaccination.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Global navigator key — set this on the MaterialApp to enable
  /// navigation from notification taps.
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    tz_data.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );

    // Create notification channels on Android
    if (Platform.isAndroid) {
      final androidPlugin =
          _plugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (androidPlugin != null) {
        await androidPlugin.createNotificationChannel(
          const AndroidNotificationChannel(
            AppConstants.medicationChannelId,
            AppConstants.medicationChannelName,
            description: AppConstants.medicationChannelDesc,
            importance: Importance.high,
          ),
        );
        await androidPlugin.createNotificationChannel(
          const AndroidNotificationChannel(
            AppConstants.vaccinationChannelId,
            AppConstants.vaccinationChannelName,
            description: AppConstants.vaccinationChannelDesc,
            importance: Importance.high,
          ),
        );
      }
    }

    _initialized = true;
  }

  void _onNotificationResponse(NotificationResponse response) {
    // Payload format: "medication:petId:medicationId" or "vaccination:petId:vaccinationId"
    final payload = response.payload;
    if (payload == null || payload.isEmpty) return;

    final parts = payload.split(':');
    if (parts.length < 2) return;

    final petId = parts[1];

    // Look up the pet and navigate to the detail screen.
    _navigateToPetDetail(petId);
  }

  Future<void> _navigateToPetDetail(String petId) async {
    final navigator = navigatorKey.currentState;
    if (navigator == null) return;

    final repo = SqlitePetRepository(AppDatabase());
    final pet = await repo.getPetById(petId);
    if (pet == null) return;

    navigator.push(
      MaterialPageRoute(
        builder: (_) => PetDetailScreen(pet: pet),
      ),
    );
  }

  Future<bool> requestPermission() async {
    if (Platform.isIOS) {
      final iosPlugin =
          _plugin.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      final granted = await iosPlugin?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }
    if (Platform.isAndroid) {
      final androidPlugin =
          _plugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      final granted = await androidPlugin?.requestNotificationsPermission();
      return granted ?? false;
    }
    return false;
  }

  /// Schedule medication reminder notifications.
  Future<void> scheduleMedicationReminders({
    required Medication medication,
    required String petName,
  }) async {
    // Cancel existing reminders for this medication first
    await cancelMedicationReminders(medication.id);

    if (!medication.isActive) return;

    final notificationId = medication.id.hashCode.abs() % 100000;

    final androidDetails = AndroidNotificationDetails(
      AppConstants.medicationChannelId,
      AppConstants.medicationChannelName,
      channelDescription: AppConstants.medicationChannelDesc,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final title = 'Medication Reminder';
    final body = 'Time to give $petName their ${medication.name}';
    final payload = 'medication:${medication.petId}:${medication.id}';

    final now = tz.TZDateTime.now(tz.local);

    switch (medication.frequency) {
      case 'daily':
        // Schedule daily at 9 AM
        var scheduledDate = tz.TZDateTime(
          tz.local,
          now.year,
          now.month,
          now.day,
          9,
          0,
        );
        if (scheduledDate.isBefore(now)) {
          scheduledDate = scheduledDate.add(const Duration(days: 1));
        }
        await _plugin.zonedSchedule(
          notificationId,
          title,
          body,
          scheduledDate,
          details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time,
          payload: payload,
        );
        break;

      case 'weekly':
        var scheduledDate = tz.TZDateTime(
          tz.local,
          now.year,
          now.month,
          now.day,
          9,
          0,
        );
        // Find next occurrence of the start weekday
        while (scheduledDate.weekday != medication.startDate.weekday) {
          scheduledDate = scheduledDate.add(const Duration(days: 1));
        }
        if (scheduledDate.isBefore(now)) {
          scheduledDate = scheduledDate.add(const Duration(days: 7));
        }
        await _plugin.zonedSchedule(
          notificationId,
          title,
          body,
          scheduledDate,
          details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          payload: payload,
        );
        break;

      case 'monthly':
        var scheduledDate = tz.TZDateTime(
          tz.local,
          now.year,
          now.month,
          medication.startDate.day,
          9,
          0,
        );
        if (scheduledDate.isBefore(now)) {
          scheduledDate = tz.TZDateTime(
            tz.local,
            now.year,
            now.month + 1,
            medication.startDate.day,
            9,
            0,
          );
        }
        await _plugin.zonedSchedule(
          notificationId,
          title,
          body,
          scheduledDate,
          details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
          payload: payload,
        );
        break;
    }
  }

  /// Schedule vaccination expiry alerts (30 days, 7 days, and day-of).
  Future<void> scheduleVaccinationAlerts({
    required Vaccination vaccination,
    required String petName,
  }) async {
    await cancelVaccinationAlerts(vaccination.id);

    if (vaccination.expirationDate == null) return;

    final expiryDate = vaccination.expirationDate!;
    final now = DateTime.now();

    final androidDetails = AndroidNotificationDetails(
      AppConstants.vaccinationChannelId,
      AppConstants.vaccinationChannelName,
      channelDescription: AppConstants.vaccinationChannelDesc,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final payload = 'vaccination:${vaccination.petId}:${vaccination.id}';
    final baseId = vaccination.id.hashCode.abs() % 100000;

    // 30 days before
    final thirtyDaysBefore = expiryDate.subtract(const Duration(days: 30));
    if (thirtyDaysBefore.isAfter(now)) {
      final scheduledDate = tz.TZDateTime(
        tz.local,
        thirtyDaysBefore.year,
        thirtyDaysBefore.month,
        thirtyDaysBefore.day,
        9,
        0,
      );
      await _plugin.zonedSchedule(
        baseId + 1,
        'Vaccination Expiring Soon',
        "$petName's ${vaccination.name} expires in 30 days",
        scheduledDate,
        details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
      );
    }

    // 7 days before
    final sevenDaysBefore = expiryDate.subtract(const Duration(days: 7));
    if (sevenDaysBefore.isAfter(now)) {
      final scheduledDate = tz.TZDateTime(
        tz.local,
        sevenDaysBefore.year,
        sevenDaysBefore.month,
        sevenDaysBefore.day,
        9,
        0,
      );
      await _plugin.zonedSchedule(
        baseId + 2,
        'Vaccination Expiring Soon',
        "$petName's ${vaccination.name} expires in 7 days",
        scheduledDate,
        details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
      );
    }

    // Day of expiry
    if (expiryDate.isAfter(now)) {
      final scheduledDate = tz.TZDateTime(
        tz.local,
        expiryDate.year,
        expiryDate.month,
        expiryDate.day,
        9,
        0,
      );
      await _plugin.zonedSchedule(
        baseId + 3,
        'Vaccination Expired',
        "$petName's ${vaccination.name} has expired!",
        scheduledDate,
        details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
      );
    }
  }

  Future<void> cancelMedicationReminders(String medicationId) async {
    final notificationId = medicationId.hashCode.abs() % 100000;
    await _plugin.cancel(notificationId);
  }

  Future<void> cancelVaccinationAlerts(String vaccinationId) async {
    final baseId = vaccinationId.hashCode.abs() % 100000;
    await _plugin.cancel(baseId + 1);
    await _plugin.cancel(baseId + 2);
    await _plugin.cancel(baseId + 3);
  }

  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }
}
