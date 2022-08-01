import 'package:insta_clone/import.dart';
import 'package:insta_clone/model/user_model.dart' as model;

class UserProvider with ChangeNotifier {
  model.User? _user;
  final AuthMethods _authMethods = AuthMethods();
  model.User get getUser => _user!;

  Future<void> refreshUser() async {
    model.User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
