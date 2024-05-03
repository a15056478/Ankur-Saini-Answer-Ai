import 'package:answers_ai/main.dart';
import 'package:answers_ai/model/prams/login/login_user_params.dart';
import 'package:answers_ai/model/prams/signup/create_user_params.dart';
import 'package:answers_ai/model/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_firebase_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('user create', () async {
    bool success = false;
    UserInfo testUser = const UserInfo(
      email: 'ankur.saini34@gmail.com',
      token: 'ankur123',
    );
    final data = await FakeFierbaseConfig()
        .createUser(params: CreateUserParams(userInfo: testUser));
    data.fold((l) {
      success = false;
    }, (r) {
      success = true;
    });

    expect(success, true);
  });

  test('user login', () async {
    bool validUser = false;
    UserInfo testUser = const UserInfo(
      email: 'ankur.saini34@gmail.com',
      token: 'ankur123',
    );
    final data = await FakeFierbaseConfig()
        .loginUser(params: LoginUserParams(userInfo: testUser));
    data.fold((l) {
      dprint(l.message);
      validUser = false;
    }, (r) {
      dprint(r);
      validUser = true;
    });

    expect(validUser, true);
  });
}
