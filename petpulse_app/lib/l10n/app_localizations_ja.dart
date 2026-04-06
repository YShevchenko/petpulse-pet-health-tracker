// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'PetPulse';

  @override
  String get addPet => 'ペットを追加';

  @override
  String get editPet => 'ペットを編集';

  @override
  String get deletePet => 'ペットを削除';

  @override
  String get petName => 'ペットの名前';

  @override
  String get species => '種類';

  @override
  String get breed => '品種';

  @override
  String get birthday => '誕生日';

  @override
  String get photo => '写真';

  @override
  String get notes => 'メモ';

  @override
  String get vaccinations => '予防接種';

  @override
  String get medications => '薬';

  @override
  String get weight => '体重';

  @override
  String get petPassport => 'ペットパスポート';

  @override
  String get markAsGiven => '投与済みにする';

  @override
  String get dueToday => '本日期限';

  @override
  String get expired => '期限切れ';

  @override
  String expiresIn(int days) {
    return '$days日後に期限切れ';
  }

  @override
  String expiredDaysAgo(int days) {
    return '$days日前に期限切れ';
  }

  @override
  String get addVaccination => '予防接種を追加';

  @override
  String get editVaccination => '予防接種を編集';

  @override
  String get addMedication => 'お薬を追加';

  @override
  String get editMedication => 'お薬を編集';

  @override
  String get logWeight => '体重を記録';

  @override
  String get export => 'エクスポート';

  @override
  String get share => '共有';

  @override
  String get settings => '設定';

  @override
  String get save => '保存';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get confirm => '確認';

  @override
  String get overview => '概要';

  @override
  String get vaccinationName => '予防接種名';

  @override
  String get dateAdministered => '投与日';

  @override
  String get expirationDate => '有効期限';

  @override
  String get vetName => '獣医師名';

  @override
  String get medicationName => 'お薬の名前';

  @override
  String get dosage => '用量';

  @override
  String get frequency => '頻度';

  @override
  String get startDate => '開始日';

  @override
  String get endDate => '終了日';

  @override
  String get daily => '毎日';

  @override
  String get weekly => '毎週';

  @override
  String get monthly => '毎月';

  @override
  String get weightKg => '体重 (kg)';

  @override
  String get date => '日付';

  @override
  String get noPets => 'まだペットがいません。最初のペットを追加しましょう！';

  @override
  String get noVaccinations => '予防接種の記録がありません。';

  @override
  String get noMedications => 'お薬の記録がありません。';

  @override
  String get noWeightEntries => 'まだ体重の記録がありません。';

  @override
  String deleteConfirmTitle(String name) {
    return '$nameを削除しますか？';
  }

  @override
  String get deleteConfirmMessage => 'この操作は取り消せません。';

  @override
  String get premium => 'プレミアム';

  @override
  String get upgradeToPremium => 'プレミアムにアップグレード';

  @override
  String get premiumDescription =>
      'ペット無制限、PDFパスポートエクスポート、お薬リマインダー';

  @override
  String get premiumPrice => '\$14.99（1回限り）';

  @override
  String get restorePurchases => '購入を復元';

  @override
  String get purchaseSuccess => '購入成功！';

  @override
  String get purchaseError => '購入に失敗しました。もう一度お試しください。';

  @override
  String get freeTierLimit =>
      '無料プランはペット1匹まで。プレミアムにアップグレードで無制限に。';

  @override
  String get premiumFeature => 'これはプレミアム機能です。';

  @override
  String get weightTrend => '体重の推移';

  @override
  String get generatePassport => 'パスポートを生成';

  @override
  String get sharePassport => 'パスポートを共有';

  @override
  String get printPassport => 'パスポートを印刷';

  @override
  String get petInformation => 'ペット情報';

  @override
  String get currentMedications => '現在のお薬';

  @override
  String get latestWeight => '最新の体重';

  @override
  String get generatedBy => 'PetPulseで生成';

  @override
  String get dog => '犬';

  @override
  String get cat => '猫';

  @override
  String get bird => '鳥';

  @override
  String get rabbit => 'うさぎ';

  @override
  String get other => 'その他';

  @override
  String get selectSpecies => '種類を選択';

  @override
  String get selectDate => '日付を選択';

  @override
  String get selectFrequency => '頻度を選択';

  @override
  String get fieldRequired => 'この項目は必須です';

  @override
  String get age => '年齢';

  @override
  String years(int count) {
    return '$count歳';
  }

  @override
  String months(int count) {
    return '$countヶ月';
  }

  @override
  String get weightUnit => 'kg';

  @override
  String get medicationReminder => 'お薬リマインダー';

  @override
  String medicationReminderBody(String petName, String medicationName) {
    return '$petNameに$medicationNameを与える時間です';
  }

  @override
  String get vaccinationExpiring => 'ワクチン期限切れ間近';

  @override
  String vaccinationExpiringBody(
    String petName,
    String vaccinationName,
    int days,
  ) {
    return '$petNameの$vaccinationNameは$days日後に期限切れになります';
  }

  @override
  String vaccinationExpiredBody(String petName, String vaccinationName) {
    return '$petNameの$vaccinationNameの期限が切れました！';
  }

  @override
  String get markedAsGiven => '投与済みとして記録';

  @override
  String get allPets => 'すべてのペット';

  @override
  String get tapToAdd => '+をタップして最初のペットを追加';

  @override
  String get choosePhoto => '写真を選ぶ';

  @override
  String get takePhoto => '写真を撮る';

  @override
  String get removePhoto => '写真を削除';

  @override
  String get aboutApp => 'PetPulseについて';

  @override
  String get aboutDescription =>
      'PetPulseはペットの健康記録、予防接種、お薬をすべて一か所で管理できるアプリです。';

  @override
  String get version => 'バージョン';

  @override
  String get publisher => 'Heldig Lab';

  @override
  String get microchipId => 'マイクロチップID';

  @override
  String get dueMedications => '投与予定のお薬';

  @override
  String get upcomingVaccinations => '今後の予防接種';

  @override
  String get freeMedicationLimit =>
      '無料プランはお薬3つまで。プレミアムにアップグレードで無制限に。';

  @override
  String get weightLbs => '体重 (lbs)';
}
