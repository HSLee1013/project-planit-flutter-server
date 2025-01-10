import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planit/data/model/todo.dart';
import 'package:planit/ui/pages/todo/list/widgets/todo_list_checkbox.dart';

class TodoListExpansion extends StatefulWidget {
  final String title;
  final List<Todo>? list;

  TodoListExpansion({required this.title, this.list});

  @override
  _TodoListExpansionState createState() => _TodoListExpansionState();
}

class _TodoListExpansionState extends State<TodoListExpansion> {
  bool _isExpanded = true; // 컬럼의 확장 상태를 관리하는 변수

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded; // 버튼 클릭 시 확장 상태를 토글
    });
  }

  @override
  Widget build(BuildContext context) {
    // // 샘플 데이터
    // List<Map<String, String>> tasks = [
    //   {"title": "영어 단어 10개 외우기", "date": "01-05"},
    //   {"title": "프로그래밍 과제 하기", "date": "01-06"},
    //   {"title": "독서 30분 하기", "date": "01-07"},
    // ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text(widget.title), // 여기서 widget.title을 사용하여 부모 위젯의 속성에 접근합니다.
              IconButton(
                icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: _toggleExpand,
              ),
            ],
          ),
        ),
        Visibility(
          visible: _isExpanded,
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.list?.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/detail");
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100], // 배경색을 회색으로 설정
                      borderRadius: BorderRadius.circular(12.0), // 모서리를 둥글게 설정
                    ),
                    child: ListTile(
                      leading: TodoListCheckbox(),
                      title: Text(
                        widget.list![index].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: [
                          Text(DateFormat('yy-MM-dd')
                              .format(widget.list![index].dueDate)),
                          Icon(Icons.alarm),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
