import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/model/todo.dart';
import '../../../../data/repository/todo_repository.dart';
import '../../../../main.dart';

class TodoDetailModel {
  Todo todo;

  TodoDetailModel.fromMap(Map<String, dynamic> map) : todo = Todo.fromMap(map);
}

final todoDetailProvider =
    NotifierProvider.family<TodoDetailVM, TodoDetailModel?, int>(() {
  return TodoDetailVM();
});

class TodoDetailVM extends FamilyNotifier<TodoDetailModel?, int> {
  final mContext = navigatorKey.currentContext!;
  TodoRepository todoRepository = const TodoRepository();

  @override
  TodoDetailModel? build(id) {
    init(id);
    return null;
  }

  Future<void> init(int id) async {
    Map<String, dynamic> responseBody = await todoRepository.findById(id);

    if (!responseBody["success"]) {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(
            content: Text("게시글 상세보기 실패 : ${responseBody["errorMessage"]}")),
      );
      return;
    }

    state = TodoDetailModel.fromMap(responseBody["response"]);
  }
//
// Future<void> delete(int id) async {
//   Map<String, dynamic> responseBody = await postRepository.delete(id);
//   if (!responseBody["success"]) {
//     ScaffoldMessenger.of(mContext!).showSnackBar(
//       SnackBar(content: Text("게시글 삭제 실패 : ${responseBody["errorMessage"]}")),
//     );
//     return;
//   }
//
//   // PostlisvVM의 상태를 변경
//   // ref.read(postListProvider.notifier).init(0);
//   ref.read(postListProvider.notifier).init();
//
//   // EventBus Notifier -> 삭제했어!
//
//   // 화면 파괴시 vm이 autoDispose 됨
//   Navigator.pop(mContext);
// }
}
