import 'package:daily_quote/src/components/sharedPrefs.dart';
import 'package:daily_quote/src/models/user.dart';
import 'package:meta/meta.dart';

class UserRepository {
  Future<String> authenticate() async {
    SharedPrefs().saveString('token', 'userToken');
    return 'userToken';
  }

  Future<void> saveUser({@required User user}) async {
    print('entre saveUser');
    await SharedPrefs().saveUser('user', user);
    await SharedPrefs().saveBool('registered', true);
  }

  Future<String> userImage() async {
    return SharedPrefs().readString('avatar');
  }
}
