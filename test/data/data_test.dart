import './source/auth_remote/auth_remote_test.dart' as auth_remote;
import './source/user_remote/user_remote_test.dart' as user_remote;
import './model/auth_model_test.dart' as auth_model;
import './model/user_model_test.dart' as user_model;

void main() {
  auth_model.main();
  user_model.main();
  auth_remote.main();
  user_remote.main();
}
