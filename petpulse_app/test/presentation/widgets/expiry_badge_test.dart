import 'package:flutter_test/flutter_test.dart';
import 'package:petpulse_app/presentation/widgets/expiry_badge.dart';
import 'package:petpulse_app/core/theme/app_colors.dart';

void main() {
  group('ExpiryBadge static utilities', () {
    // FR-012: Yellow = within 30 days (not yet expired), Red = already expired

    test('colorForDays returns green for > 30 days', () {
      expect(ExpiryBadge.colorForDays(60), AppColors.expiryGreen);
      expect(ExpiryBadge.colorForDays(31), AppColors.expiryGreen);
    });

    test('colorForDays returns yellow for 1-30 days (expiring soon but not yet expired)', () {
      expect(ExpiryBadge.colorForDays(30), AppColors.expiryYellow);
      expect(ExpiryBadge.colorForDays(15), AppColors.expiryYellow);
      expect(ExpiryBadge.colorForDays(7), AppColors.expiryYellow);
      expect(ExpiryBadge.colorForDays(1), AppColors.expiryYellow);
    });

    test('colorForDays returns red for expired (0 or negative days)', () {
      expect(ExpiryBadge.colorForDays(0), AppColors.expiryRed);
      expect(ExpiryBadge.colorForDays(-5), AppColors.expiryRed);
    });

    test('statusForDays returns correct status strings', () {
      expect(ExpiryBadge.statusForDays(60), 'green');
      expect(ExpiryBadge.statusForDays(31), 'green');
      expect(ExpiryBadge.statusForDays(30), 'yellow');
      expect(ExpiryBadge.statusForDays(15), 'yellow');
      expect(ExpiryBadge.statusForDays(7), 'yellow');
      expect(ExpiryBadge.statusForDays(1), 'yellow');
      expect(ExpiryBadge.statusForDays(0), 'red');
      expect(ExpiryBadge.statusForDays(-10), 'red');
    });
  });
}
