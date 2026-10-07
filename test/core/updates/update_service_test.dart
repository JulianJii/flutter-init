import 'package:flutter_test/flutter_test.dart';
import 'package:init/core/updates/update_service.dart';

void main() {
  late UpdateService service;

  setUp(() {
    service = BasicUpdateService(
      androidPackageName: 'com.example.init',
      iOSAppId: '1234567890',
    );
  });

  group('version parsing', () {
    test('a v-prefixed tag keeps its major version', () {
      expect(service.isUpdateNeeded('1.2.0', 'v2.0.0'), isTrue);
      expect(service.isUpdateNeeded('v1.2.0', '2.0.0'), isTrue);
    });

    test('a v-prefixed tag does not trigger a false critical update', () {
      expect(service.isCriticalUpdate('1.2.0', 'v1.0.0'), isFalse);
      expect(service.isCriticalUpdate('v2.0.0', '1.0.0'), isFalse);
    });

    test('equal versions with or without v-prefix report no update', () {
      expect(service.isUpdateNeeded('1.2.0', 'v1.2.0'), isFalse);
    });
  });

  group('minimumRequiredVersion', () {
    test('a non-numeric minimum never forces a critical update', () {
      expect(service.isCriticalUpdate('1.0.0', 'latest'), isFalse);
      expect(service.isCriticalUpdate('0.0.1', 'latest'), isFalse);
    });

    test('a numeric minimum below the current version is not critical', () {
      expect(service.isCriticalUpdate('1.2.3', '1.2.0'), isFalse);
    });

    test('a numeric minimum above the current version is critical', () {
      expect(service.isCriticalUpdate('1.2.0', '2.0.0'), isTrue);
    });
  });
}
