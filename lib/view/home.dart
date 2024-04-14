import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:taskmanager/constants/constants.dart';
import 'package:taskmanager/view/add_task.dart';
import 'package:taskmanager/widget/stream_task.dart';


class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

bool show = true;

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(

              builder: (context) => AddScreen(),
            ));
          },
          backgroundColor: customGreen,
          child: Icon(Icons.add, size: 15),

        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: Column(
            children: [

              StreamTask(false),

              Text(
                'isDone',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.bold),

              StreamTask(true),
            ],
          ),
        ),
      ),
    );
  }
}
