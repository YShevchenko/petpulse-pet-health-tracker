// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'PetPulse';

  @override
  String get addPet => '반려동물 추가';

  @override
  String get editPet => '반려동물 편집';

  @override
  String get deletePet => '반려동물 삭제';

  @override
  String get petName => '반려동물 이름';

  @override
  String get species => '종';

  @override
  String get breed => '품종';

  @override
  String get birthday => '생일';

  @override
  String get photo => '사진';

  @override
  String get notes => '메모';

  @override
  String get vaccinations => '예방접종';

  @override
  String get medications => '약물';

  @override
  String get weight => '체중';

  @override
  String get petPassport => '반려동물 여권';

  @override
  String get markAsGiven => '투여 완료';

  @override
  String get dueToday => '오늘 예정';

  @override
  String get expired => '만료됨';

  @override
  String expiresIn(int days) {
    return '$days일 후 만료';
  }

  @override
  String expiredDaysAgo(int days) {
    return '$days일 전 만료됨';
  }

  @override
  String get addVaccination => '예방접종 추가';

  @override
  String get editVaccination => '예방접종 수정';

  @override
  String get addMedication => '약 추가';

  @override
  String get editMedication => '약 수정';

  @override
  String get logWeight => '체중 기록';

  @override
  String get export => '내보내기';

  @override
  String get share => '공유';

  @override
  String get settings => '설정';

  @override
  String get save => '저장';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get confirm => '확인';

  @override
  String get overview => '개요';

  @override
  String get vaccinationName => '예방접종 이름';

  @override
  String get dateAdministered => '투여 날짜';

  @override
  String get expirationDate => '만료일';

  @override
  String get vetName => '수의사 이름';

  @override
  String get medicationName => '약 이름';

  @override
  String get dosage => '용량';

  @override
  String get frequency => '빈도';

  @override
  String get startDate => '시작일';

  @override
  String get endDate => '종료일';

  @override
  String get daily => '매일';

  @override
  String get weekly => '매주';

  @override
  String get monthly => '매월';

  @override
  String get weightKg => '체중 (kg)';

  @override
  String get date => '날짜';

  @override
  String get noPets => '아직 반려동물이 없습니다. 첫 반려동물을 추가하세요!';

  @override
  String get noVaccinations => '기록된 예방접종이 없습니다.';

  @override
  String get noMedications => '기록된 약이 없습니다.';

  @override
  String get noWeightEntries => '아직 체중 기록이 없습니다.';

  @override
  String deleteConfirmTitle(String name) {
    return '$name을(를) 삭제할까요?';
  }

  @override
  String get deleteConfirmMessage => '이 작업은 되돌릴 수 없습니다.';

  @override
  String get premium => '프리미엄';

  @override
  String get upgradeToPremium => '프리미엄으로 업그레이드';

  @override
  String get premiumDescription =>
      '반려동물 무제한, PDF 여권 내보내기, 약 복용 알림';

  @override
  String get premiumPrice => '\$14.99 (1회 결제)';

  @override
  String get restorePurchases => '구매 복원';

  @override
  String get purchaseSuccess => '구매 성공!';

  @override
  String get purchaseError => '구매에 실패했습니다. 다시 시도하세요.';

  @override
  String get freeTierLimit =>
      '무료 플랜은 반려동물 1마리까지. 프리미엄으로 업그레이드하면 무제한.';

  @override
  String get premiumFeature => '프리미엄 기능입니다.';

  @override
  String get weightTrend => '체중 추이';

  @override
  String get generatePassport => '여권 생성';

  @override
  String get sharePassport => '여권 공유';

  @override
  String get printPassport => '여권 인쇄';

  @override
  String get petInformation => '반려동물 정보';

  @override
  String get currentMedications => '현재 복용 약';

  @override
  String get latestWeight => '최근 체중';

  @override
  String get generatedBy => 'PetPulse에서 생성';

  @override
  String get dog => '강아지';

  @override
  String get cat => '고양이';

  @override
  String get bird => '새';

  @override
  String get rabbit => '토끼';

  @override
  String get other => '기타';

  @override
  String get selectSpecies => '종 선택';

  @override
  String get selectDate => '날짜 선택';

  @override
  String get selectFrequency => '빈도 선택';

  @override
  String get fieldRequired => '이 항목은 필수입니다';

  @override
  String get age => '나이';

  @override
  String years(int count) {
    return '$count세';
  }

  @override
  String months(int count) {
    return '$count개월';
  }

  @override
  String get weightUnit => 'kg';

  @override
  String get medicationReminder => '약 복용 알림';

  @override
  String medicationReminderBody(String petName, String medicationName) {
    return '$petName에게 $medicationName을(를) 줄 시간입니다';
  }

  @override
  String get vaccinationExpiring => '예방접종 만료 임박';

  @override
  String vaccinationExpiringBody(
    String petName,
    String vaccinationName,
    int days,
  ) {
    return '$petName의 $vaccinationName이(가) $days일 후 만료됩니다';
  }

  @override
  String vaccinationExpiredBody(String petName, String vaccinationName) {
    return '$petName의 $vaccinationName이(가) 만료되었습니다!';
  }

  @override
  String get markedAsGiven => '투여 완료로 표시';

  @override
  String get allPets => '모든 반려동물';

  @override
  String get tapToAdd => '+를 눌러 첫 반려동물을 추가하세요';

  @override
  String get choosePhoto => '사진 선택';

  @override
  String get takePhoto => '사진 촬영';

  @override
  String get removePhoto => '사진 삭제';

  @override
  String get aboutApp => 'PetPulse 소개';

  @override
  String get aboutDescription =>
      'PetPulse는 반려동물의 건강 기록, 예방접종, 약을 한 곳에서 관리할 수 있는 앱입니다.';

  @override
  String get version => '버전';

  @override
  String get publisher => 'Heldig Lab';

  @override
  String get microchipId => '마이크로칩 ID';

  @override
  String get dueMedications => '예정된 약';

  @override
  String get upcomingVaccinations => '예정된 예방접종';

  @override
  String get freeMedicationLimit =>
      '무료 플랜은 약 3개까지. 프리미엄으로 업그레이드하면 무제한.';

  @override
  String get weightLbs => '체중 (lbs)';
}
