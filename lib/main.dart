import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:planit/ui/pages/auth/change_password/change_password_page.dart';
import 'package:planit/ui/pages/auth/find_id/find_id_page.dart';
import 'package:planit/ui/pages/auth/find_password/find_password_page.dart';
import 'package:planit/ui/pages/auth/login/login_page.dart';
import 'package:planit/ui/pages/auth/signup/signup_page.dart';
import 'package:planit/ui/pages/calendar/calendar_page.dart';
import 'package:planit/ui/pages/main/main_page.dart';
import 'package:planit/ui/pages/profile/porfile_page.dart';
import 'package:planit/ui/pages/splash/splash_page.dart';
import 'package:planit/ui/pages/temp/dialog_page.dart';
import 'package:planit/ui/pages/todo/category/todo_category_page.dart';
import 'package:planit/ui/pages/todo/complete/complete_page.dart';
import 'package:planit/ui/pages/todo/detail/todo_detail_page.dart';
import 'package:planit/ui/pages/todo/memo/todo_memo_page.dart';

import 'ui/pages/temp/test_page.dart';

// Stack의 가장 위 context를 알고 있다.
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // 한국어로 바꾸는 라이브러리 설정 >> 시작전에 바꾸고 가는 방식인듯
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko_KR', null); // 한국어 날짜 형식 초기화
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      // 한국어로 바꾸기 추가설정
      locale: Locale('ko', 'KR'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ko', 'KR'), // 한국어
      ],
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      // home: TestPage(),
      routes: {
        // TODO 테스트 라우트 삭제 필요
        "/test": (context) => TestPage(),
        "/dialogs": (context) => DialogPage(),

        "/detail": (context) => TodoDetailPage(),
        "/memo": (context) => TodoMemoPage(),
        "/calendar": (context) => CalendarPage(),
        "/profile": (context) => ProfilePage(),
        "/signup": (context) => SignupPage(),
        "/login": (context) => LoginPage(),
        "/find-id": (context) => FindIdPage(),
        "/find-password": (context) => FindPasswordPage(),
        "/join": (context) => SignupPage(),
        "/change-password": (context) => ChangePasswordPage(),
        "/mainpage": (context) => MainPage(),
        "/category": (context) => TodoCategoryPage(),
        "/completed-plan": (context) => CompletePage(),
      },
    );
  }
}
