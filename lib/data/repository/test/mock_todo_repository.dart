import 'package:logger/logger.dart';
import 'package:planit/data/repository/todo_repository.dart';

import '../../../_core/utils/my_http.dart';

class MockTodoRepository implements TodoRepository {
  String jsonString = '''
  {
    "success" : true,
    "response" : {
      "categories" : [ {
        "id" : 1,
        "name" : "작업"
      },{
        "id" : 2,
        "name" : "생일"
      },{
        "id" : 3,
        "name" : "공부"
      } ],
      "todos" : [ {
        "id" : 1,
        "title" : "영어공부",
        "category" : {
          "id" : 3,
          "name" : "공부"
        },
        "memo" : "문장 1개 말하기",
        "dueDate" : "2025-01-09",
        "createdAt" : "2025-01-08T19:20:11",
        "repeat" : "매일",
        "isCompleted" : false,
        "isDeleted" : false
      },{
        "id" : 2,
        "title" : "무현 생일",
        "category" : {
          "id" : 2,
          "name" : "생일"
        },
        "memo" : "생일빵 때리기",
        "dueDate" : "2025-01-08",
        "createdAt" : "2024-12-09T09:20:11",
        "repeat" : "매년",
        "isCompleted" : false,
        "isDeleted" : false
      }, 
      {
        "id" : 3,
        "title" : "무현 생일",
        "category" : {
          "id" : 2,
          "name" : "생일"
        },
        "memo" : "생일빵 때리기",
        "dueDate" : "2025-01-09",
        "createdAt" : "2024-12-09T09:20:11",
        "repeat" : "매년",
        "isCompleted" : true,
        "isDeleted" : false
      }, 
      {
        "id" : 4,
        "title" : "무현 생일",
        "category" : {
          "id" : 2,
          "name" : "생일"
        },
        "memo" : "생일빵 때리기",
        "dueDate" : "2025-01-10",
        "createdAt" : "2024-12-09T09:20:11",
        "repeat" : "매년",
        "isCompleted" : true,
        "isDeleted" : false
      }
      ]
    },
    "status" : 200,
    "errorMessage" : null
  }
  ''';

  // @override
  // Future<Map<String, dynamic>> findAll() async {
  //   Map<String, dynamic> body = await Future.delayed(Duration(seconds: 1), () {
  //     return jsonDecode(jsonString) as Map<String, dynamic>;
  //   });
  //   return body;
  // }

  @override
  Future<Map<String, dynamic>> findAll() async {
    try {
      dio.options.headers["Authorization"] = "Bearer";
      final response = await dio.get("/api/todo-category");
      return response.data;
    } catch (e) {
      Logger().e(e);
      return {};
    }
  }

  @override
  Future<Map<String, dynamic>> findById(int id) {
    // TODO: implement findById
    throw UnimplementedError();
  }
}
