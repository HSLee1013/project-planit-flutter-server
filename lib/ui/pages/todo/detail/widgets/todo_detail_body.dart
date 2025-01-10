import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:planit/ui/pages/todo/detail/todo_detail_vm.dart';
import 'package:planit/ui/pages/todo/memo/todo_memo_page.dart';
import 'package:planit/ui/widgets/dialogs/calendar_dialog.dart';
import 'package:planit/ui/widgets/dialogs/repeat_todo_dialog.dart';

List<String> list = ['카테고리 없음', "카테고리1", "카테고리2", "카테고리3", "카테고리4", "카테고리5"];

class TodoDetailBody extends StatefulWidget {
  @override
  State<TodoDetailBody> createState() => _TodoDetailBodyState();
}

class _TodoDetailBodyState extends State<TodoDetailBody> {
  String dropdownValue = list.first;
  int todoId = 1;

  @override
  Widget build(BuildContext context) {
    final TextEditingController title = TextEditingController();
    return Consumer(
      builder: (context, ref, child) {
        TodoDetailModel? model = ref.watch(todoDetailProvider(todoId));
        if (model == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          title.text = model.todo.title;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Row(
                  children: [
                    Container(
                      width: 130,
                      height: 35,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValue,
                          style: TextStyle(fontSize: 13),
                          items: list
                              .map((String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: title,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "제목없음",
                  ),
                ),
                Divider(height: 10),
                Row(
                  children: [
                    Container(
                      width: 40,
                      alignment: Alignment.centerLeft,
                      child: Icon(CupertinoIcons.calendar),
                    ),
                    Text("마감일"),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        DateTime? _selectedDate;
                        final DateTime pickedDate = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CalendarDialog();
                          },
                        );

                        if (pickedDate != null && pickedDate != _selectedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                            print(_selectedDate);
                          });
                        }
                      },
                      child: Text(
                          "${DateFormat('yy-MM-dd').format(model.todo.dueDate)}"),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(height: 10),
                Row(
                  children: [
                    Container(
                      width: 40,
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.repeat),
                    ),
                    Text("반복"),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                RepeatTodoDialog());
                      },
                      child: Text("${model.todo.repeat}"),
                    ),
                  ],
                ),
                Divider(height: 10),
                Row(
                  children: [
                    Container(
                      width: 40,
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.event_note),
                    ),
                    Text("메모"),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TodoMemoPage(model.todo.memo)));
                        Navigator.pushNamed(context, "/memo");
                      },
                      child: Text("추가"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 42, height: 10),
                    Text(
                      "${model.todo.memo}",
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                )
              ],
            ),
          );
        }
      },
    );
  }
}
