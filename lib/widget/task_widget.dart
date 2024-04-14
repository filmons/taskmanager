import 'package:flutter/material.dart';
import 'package:taskmanager/constants/constants.dart';
import 'package:taskmanager/controllers/firestore_controller.dart';
import 'package:taskmanager/model/task.dart';
import 'package:taskmanager/view/edit_task.dart';
// import 'package:taskmanager/material.dart';


// ignore: must_be_immutable
class TaskWidget extends StatefulWidget {
  Task _task;
  TaskWidget(this._task, {super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDone = widget._task.isDone;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              image(),
              SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget._task.titre,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Checkbox(
                          activeColor: customGreen,
                          value: isDone,
                          onChanged: (value) {
                            setState(() {
                              isDone = !isDone;
                            });
                            FirestoreController()
                                .isDone(widget._task.id, isDone);
                          },
                        )
                      ],
                    ),
                    Text(
                      widget._task.description,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade400),
                    ),
                    Spacer(),
                    edit()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget edit() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditScreen(widget._task),
          ));
        },
        child: Container(
          width: 110, // Augmentation de la largeur du conteneur
          height: 28,
          decoration: BoxDecoration(
            color: Color(0xffE2F6F1),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              'Modification',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget image() {
    return Container(
      height: 130,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage(widget._task.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
