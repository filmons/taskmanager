import 'package:flutter/material.dart';
import 'package:taskmanager/constants/constants.dart';
import 'package:taskmanager/controllers/firestore_controller.dart';
import 'package:taskmanager/model/task.dart';

class EditScreen extends StatefulWidget {
  Task _task;
  EditScreen(this._task, {super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController? title;
  TextEditingController? subtitle;
  TextEditingController? imageUrlController;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget._task.titre);
    subtitle = TextEditingController(text: widget._task.description);
    imageUrlController = TextEditingController(text: widget._task.image);
    imageUrl = widget._task.image;
    imageUrlController!.addListener(updateImageUrl);
  }

  @override
  void dispose() {
    imageUrlController!.removeListener(updateImageUrl);
    super.dispose();
  }

  void updateImageUrl() {
    setState(() {
      imageUrl = imageUrlController!.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titreWidget(),
            SizedBox(height: 20),
            descriptionWidget(),
            SizedBox(height: 20),
            imageWidget(),
            SizedBox(height: 20),
            button()
          ],
        ),
      ),
    );
  }

  Widget button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: customGreen,
            minimumSize: Size(170, 48),
          ),
          onPressed: () {
            FirestoreController().updateTask(
              widget._task.id,
              title!.text,
              subtitle!.text,
              imageUrlController!.text,
            );
            Navigator.pop(context);
          },
          child: Text('Modifier'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: Size(170, 48),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Annuler'),
        ),
      ],
    );
  }

  Widget imageWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Text(
            'Image', 
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(
              height: 10), 
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: imageUrlController,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                hintText: 'Image URL',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color(0xffc5c5c5),
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: customGreen,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          if (imageUrl != null && imageUrl!.isNotEmpty)
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget titreWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Text(
            'Titre', 
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(
              height: 10), // Espacement entre le titre et le champ de texte
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: title,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  hintText: 'Titre',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffc5c5c5),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: customGreen,
                      width: 2.0,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget descriptionWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Text(
            'Description', 
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(
              height: 10), 
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              maxLines: 3,
              controller: subtitle,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                hintText: 'Description',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color(0xffc5c5c5),
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: customGreen,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
