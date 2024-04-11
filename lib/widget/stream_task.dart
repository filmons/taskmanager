import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/widget/task_widget.dart';

import '../controllers/firestore_controller.dart';

// ignore: must_be_immutable
class StreamTask extends StatelessWidget {
  bool done;
  StreamTask(this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreController().stream(done),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final taskslist = FirestoreController().getTasks(snapshot);
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final task = taskslist[index];
              return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    FirestoreController().deleteNote(task.id);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: TaskWidget(task));
            },
            itemCount: taskslist.length,
          );
        });
  }
}
