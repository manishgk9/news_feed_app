import 'package:get_storage/get_storage.dart';

class OnboardingService {
  static const String _keyOnboarded = "isOnboarded";
  final GetStorage _storage = GetStorage();

  /// Check if user has completed onboarding
  bool isOnboarded() {
    return _storage.read(_keyOnboarded) ?? false;
  }

  /// Mark onboarding as completed
  void completeOnboarding() {
    _storage.write(_keyOnboarded, true);
  }

  /// Reset onboarding (optional, for testing)
  void resetOnboarding() {
    _storage.write(_keyOnboarded, false);
  }
}
