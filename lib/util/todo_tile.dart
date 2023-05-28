import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? editTapped;
  final Function(BuildContext)? deleteTapped;

  const ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.editTapped,
    required this.deleteTapped,
    required void Function(dynamic context) deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            // settings option
            SlidableAction(
              onPressed: editTapped,
              backgroundColor: Colors.teal.shade400,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(12),
            ),

            // delete option
            SlidableAction(
              onPressed: deleteTapped,
              backgroundColor: Colors.red.shade400,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // checkbox
              Theme(
                data: Theme.of(context).copyWith(
                  checkboxTheme: CheckboxThemeData(
                    fillColor: MaterialStateProperty.all(
                      Colors.indigoAccent, // Replace with your desired color
                    ),
                  ),
                ),
                child: Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.indigoAccent,
                ),
              ),

              // habit name
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontWeight:
                          taskCompleted ? FontWeight.bold : FontWeight.normal,
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: "Itim"),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.swipe_left_sharp,
                  color: Colors.cyanAccent[100],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
