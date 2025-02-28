import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final baseUrl = "http://192.168.55.229:8080";

//로그인 되면, dio에 jwt 추가하기
//dio.options.headers['Authorization'] = 'Bearer $_accessToken';
final dio = Dio(
  BaseOptions(
    baseUrl: baseUrl, // 내 IP 입력
    contentType: "application/json; charset=utf-8",
    validateStatus: (status) => true, // 200 이 아니어도 예외 발생안하게 설정
    headers: {
      "Authorization":
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpbWdVcmwiOiIvaW1hZ2VzLzEucG5nIiwic3ViIjoibWV0YWNvZGluZyIsImlkIjoxLCJleHAiOjE3MzYzMDAzNTEsInVzZXJuYW1lIjoic3NhciJ9.ShECVw5U9YADlr0eq3doJu37PaxJolgFcPULW9ZlgcJfYLyeE3la4VLVjRbP_XR653hEzHEzGzTJ4JPP04pXgg",
      // TODO : 테스트 후 삭제 필요
    },
  ),
);

const secureStorage = FlutterSecureStorage();
