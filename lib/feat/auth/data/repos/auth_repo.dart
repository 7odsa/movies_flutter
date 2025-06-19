import 'package:movies_flutter/_resources/data_state.dart';
import 'package:movies_flutter/feat/auth/data/data_sources/auth_remote_ds.dart';
import 'package:movies_flutter/feat/auth/data/models/user.dart';

class AuthRepo {
  AuthRepo({required this.authRemoteDS});

  final AuthRemoteDS authRemoteDS;

  Future<DataState<UserDm>> register(UserDm user) async {
    try {
      final result = await authRemoteDS.register(user);
      return result;
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<String>> login(String email, String password) async {
    try {
      final result = await authRemoteDS.login(email, password);
      return result;
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
