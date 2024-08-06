import 'package:fanitek_test/data/model/auth_model/auth_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthModel', () {
    test('should convert AuthModel to JSON', () {
      // Mock data for AuthModel
      final authModel = AuthModel(
        uid: '123',
        email: 'test@example.com',
        displayName: 'Test User',
        emailVerified: true,
        isAnonymous: false,
        providerIds: ['google.com'],
        phoneNumber: '1234567890',
        creationTime: DateTime(2020, 1, 1),
        lastSignInTime: DateTime(2021, 1, 1),
      );

      // Convert to JSON
      final json = authModel.toJson();

      // Assertions
      expect(json['uid'], '123');
      expect(json['email'], 'test@example.com');
      expect(json['displayName'], 'Test User');
      expect(json['emailVerified'], true);
      expect(json['isAnonymous'], false);
      expect(json['providerIds'], ['google.com']);
      expect(json['phoneNumber'], '1234567890');
      expect(json['creationTime'], '2020-01-01T00:00:00.000');
      expect(json['lastSignInTime'], '2021-01-01T00:00:00.000');
    });
  });
}
