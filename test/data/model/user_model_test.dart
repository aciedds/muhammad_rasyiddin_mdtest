import 'package:fanitek_test/data/model/user_model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel', () {
    test('should create a UserModel from JSON', () {
      // Mock JSON data
      final json = {
        'id': '123',
        'firstName': 'John',
        'lastName': 'Doe',
        'email': 'john.doe@example.com',
        'isEmailVerified': true,
      };

      // Create UserModel from JSON
      final userModel = UserModel.fromJson(json);

      // Assertions
      expect(userModel.id, '123');
      expect(userModel.firstName, 'John');
      expect(userModel.lastName, 'Doe');
      expect(userModel.email, 'john.doe@example.com');
      expect(userModel.isEmailVerified, true);
    });

    test('should convert UserModel to JSON', () {
      // Mock data for UserModel
      final userModel = UserModel(
        id: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        isEmailVerified: true,
      );

      // Convert to JSON
      final json = userModel.toJson();

      // Assertions
      expect(json['id'], '123');
      expect(json['firstName'], 'John');
      expect(json['lastName'], 'Doe');
      expect(json['email'], 'john.doe@example.com');
      expect(json['isEmailVerified'], true);
    });
  });
}
