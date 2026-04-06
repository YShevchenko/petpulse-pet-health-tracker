// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'PetPulse';

  @override
  String get addPet => 'إضافة حيوان أليف';

  @override
  String get editPet => 'تعديل الحيوان الأليف';

  @override
  String get deletePet => 'حذف الحيوان الأليف';

  @override
  String get petName => 'اسم الحيوان الأليف';

  @override
  String get species => 'النوع';

  @override
  String get breed => 'السلالة';

  @override
  String get birthday => 'تاريخ الميلاد';

  @override
  String get photo => 'صورة';

  @override
  String get notes => 'ملاحظات';

  @override
  String get vaccinations => 'التطعيمات';

  @override
  String get medications => 'الأدوية';

  @override
  String get weight => 'الوزن';

  @override
  String get petPassport => 'جواز سفر الحيوان';

  @override
  String get markAsGiven => 'تم الإعطاء';

  @override
  String get dueToday => 'مستحق اليوم';

  @override
  String get expired => 'منتهي الصلاحية';

  @override
  String expiresIn(int days) {
    return 'ينتهي خلال $days أيام';
  }

  @override
  String expiredDaysAgo(int days) {
    return 'انتهت الصلاحية منذ $days أيام';
  }

  @override
  String get addVaccination => 'إضافة تطعيم';

  @override
  String get editVaccination => 'تعديل التطعيم';

  @override
  String get addMedication => 'إضافة دواء';

  @override
  String get editMedication => 'تعديل الدواء';

  @override
  String get logWeight => 'تسجيل الوزن';

  @override
  String get export => 'تصدير';

  @override
  String get share => 'مشاركة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get confirm => 'تأكيد';

  @override
  String get overview => 'نظرة عامة';

  @override
  String get vaccinationName => 'اسم التطعيم';

  @override
  String get dateAdministered => 'تاريخ الإعطاء';

  @override
  String get expirationDate => 'تاريخ الانتهاء';

  @override
  String get vetName => 'اسم الطبيح البيطري';

  @override
  String get medicationName => 'اسم الدواء';

  @override
  String get dosage => 'الجرعة';

  @override
  String get frequency => 'التكرار';

  @override
  String get startDate => 'تاريخ البدء';

  @override
  String get endDate => 'تاريخ الانتهاء';

  @override
  String get daily => 'يومي';

  @override
  String get weekly => 'أسبوعي';

  @override
  String get monthly => 'شهري';

  @override
  String get weightKg => 'الوزن (كجم)';

  @override
  String get date => 'التاريخ';

  @override
  String get noPets => 'لا حيوانات أليفة بعد. أضف أول حيوان أليف!';

  @override
  String get noVaccinations => 'لا توجد تطعيمات مسجلة.';

  @override
  String get noMedications => 'لا توجد أدوية مسجلة.';

  @override
  String get noWeightEntries => 'لا توجد سجلات وزن بعد.';

  @override
  String deleteConfirmTitle(String name) {
    return 'حذف $name؟';
  }

  @override
  String get deleteConfirmMessage => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get premium => 'مميز';

  @override
  String get upgradeToPremium => 'الترقية إلى المميز';

  @override
  String get premiumDescription =>
      'حيوانات أليفة غير محدودة، تصدير جواز السفر بصيغة PDF، تذكيرات الدواء';

  @override
  String get premiumPrice => '\$14.99 دفعة واحدة';

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String get purchaseSuccess => 'تم الشراء بنجاح!';

  @override
  String get purchaseError => 'فشل الشراء. يرجى المحاولة مرة أخرى.';

  @override
  String get freeTierLimit =>
      'الخطة المجانية تتيح حيواناً أليفاً واحداً. قم بالترقية للحصول على عدد غير محدود.';

  @override
  String get premiumFeature => 'هذه ميزة مميزة.';

  @override
  String get weightTrend => 'اتجاه الوزن';

  @override
  String get generatePassport => 'إنشاء جواز السفر';

  @override
  String get sharePassport => 'مشاركة جواز السفر';

  @override
  String get printPassport => 'طباعة جواز السفر';

  @override
  String get petInformation => 'معلومات الحيوان الأليف';

  @override
  String get currentMedications => 'الأدوية الحالية';

  @override
  String get latestWeight => 'آخر وزن';

  @override
  String get generatedBy => 'تم الإنشاء بواسطة PetPulse';

  @override
  String get dog => 'كلب';

  @override
  String get cat => 'قطة';

  @override
  String get bird => 'طائر';

  @override
  String get rabbit => 'أرنب';

  @override
  String get other => 'أخرى';

  @override
  String get selectSpecies => 'اختر النوع';

  @override
  String get selectDate => 'اختر التاريخ';

  @override
  String get selectFrequency => 'اختر التكرار';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get age => 'العمر';

  @override
  String years(int count) {
    return '$count سنوات';
  }

  @override
  String months(int count) {
    return '$count أشهر';
  }

  @override
  String get weightUnit => 'kg';

  @override
  String get medicationReminder => 'تذكير بالدواء';

  @override
  String medicationReminderBody(String petName, String medicationName) {
    return 'حان وقت إعطاء $petName دواء $medicationName';
  }

  @override
  String get vaccinationExpiring => 'انتهاء صلاحية التطعيم';

  @override
  String vaccinationExpiringBody(
    String petName,
    String vaccinationName,
    int days,
  ) {
    return 'تطعيم $vaccinationName لـ $petName ينتهي خلال $days أيام';
  }

  @override
  String vaccinationExpiredBody(String petName, String vaccinationName) {
    return 'تطعيم $vaccinationName لـ $petName انتهت صلاحيته!';
  }

  @override
  String get markedAsGiven => 'تم التسجيل كمُعطى';

  @override
  String get allPets => 'جميع الحيوانات';

  @override
  String get tapToAdd => 'اضغط + لإضافة أول حيوان أليف';

  @override
  String get choosePhoto => 'اختر صورة';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get removePhoto => 'حذف الصورة';

  @override
  String get aboutApp => 'حول PetPulse';

  @override
  String get aboutDescription =>
      'يساعدك PetPulse في تتبع سجلات صحة حيوانك الأليف والتطعيمات والأدوية في مكان واحد.';

  @override
  String get version => 'الإصدار';

  @override
  String get publisher => 'Heldig Lab';

  @override
  String get microchipId => 'رقم الرقاقة الإلكترونية';

  @override
  String get dueMedications => 'الأدوية المستحقة';

  @override
  String get upcomingVaccinations => 'التطعيمات القادمة';

  @override
  String get freeMedicationLimit =>
      'الخطة المجانية تتيح 3 أدوية. قم بالترقية للحصول على عدد غير محدود.';

  @override
  String get weightLbs => 'الوزن (رطل)';
}
