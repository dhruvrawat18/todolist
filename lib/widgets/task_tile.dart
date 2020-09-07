import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkboxCallBack;
  final Function longPressCallBack;

  TaskTile(
      {this.isChecked,
      this.taskTitle,
      this.checkboxCallBack,
      this.longPressCallBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: isChecked ? 0 : 10,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            title: Text(
              taskTitle,
              style: TextStyle(
                  color: isChecked ? Colors.grey : Colors.black,
                  decoration: isChecked ? TextDecoration.lineThrough : null),
            ),
            leading: Checkbox(
              activeColor: Colors.lightBlueAccent,
              value: isChecked,
              onChanged: checkboxCallBack,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: longPressCallBack,
              color: Colors.red,
            )),
      ),
    );
  }
}
