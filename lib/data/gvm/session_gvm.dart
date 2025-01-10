import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../_core/utils/my_http.dart';
import '../../main.dart';
import '../repository/user_repository.dart';

class SessionUser {
  int? id;
  String? username;
  String? accessToken;
  bool? isLogin;

  SessionUser({this.id, this.username, this.accessToken, this.isLogin});
}

class SessionGVM extends Notifier<SessionUser> {
  final mContext = navigatorKey.currentContext!;

  UserRepository userRepository = const UserRepository();

  @override
  SessionUser build() {
    return SessionUser(
        id: null, username: null, accessToken: null, isLogin: false);
  }

  Future<void> login(String username, String password) async {
    final requestBody = {
      "username": username,
      "password": password,
    };

    // 구조 분해 할당으로 return
    // final (Map<String, dynamic> responseBody, String accessToken) =
    final (responseBody, accessToken) =
        await userRepository.findByUsernameAndPassword(requestBody);

    if (!responseBody["success"]) {
      // 로그인 실패
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(content: Text("로그인 실패 : ${responseBody["errorMessage"]}")),
      );
      return;
    }
    // 1. 토큰을 Storage 저장 -> Storage는 휴대폰 껏다 켜도 데이터 보존 -> flutter_secure_storage 라이브러리 필요
    await secureStorage.write(
        key: "accessToken", value: accessToken); // I/O -> 오래 걸린다.

    // 2. SessionUser 갱신
    Map<String, dynamic> data = responseBody["response"];
    state = SessionUser(
        id: data["id"],
        username: data["username"],
        accessToken: accessToken,
        isLogin: true);

    // 3. Dio 토큰 세팅, dio는 메모리에 저장이라 await 필요 없음 -> 껐다 키면 없어지는 데이터
    dio.options.headers["Authorization"] = accessToken;

    // Logger().d(accessToken);
    // 트랜잭션 끝
    Navigator.popAndPushNamed(mContext, "/mainpage");
  }

  Future<void> logout() async {
    Navigator.popAndPushNamed(mContext, "/login");
  }

  Future<void> autoLogin() async {
    Future.delayed(
      Duration(seconds: 1),
      () {
        Navigator.popAndPushNamed(mContext, "/login");
      },
    );
  }
}

final sessionProvider = NotifierProvider<SessionGVM, SessionUser>(() {
  return SessionGVM();
});
