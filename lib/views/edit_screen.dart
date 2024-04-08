import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/function/todo_function.dart';
import 'package:flutter_application_1/views/list_screen.dart';
import 'package:flutter_application_1/model/data_model.dart';

import 'package:image_picker/image_picker.dart';

class EditScreen extends StatefulWidget {
  const EditScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.image,
      required this.index});
  final String title;
  final String description;

  final dynamic image;
  final int index;

  @override
  State<EditScreen> createState() => _EditScreen();
}

class _EditScreen extends State<EditScreen> {
  final TextEditingController titlecontrollercontroller =
      TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();

  File? selectedimage;

  @override
  void initState() {
    titlecontrollercontroller.text = widget.title;
    descriptioncontroller.text = widget.description;

    selectedimage = widget.image != null ? File(widget.image) : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 24, 30, 41),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 80, 0, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'N O T E S D E T A I L S',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: 100,
                            backgroundImage: selectedimage != null
                                ? FileImage(selectedimage!)
                                : const AssetImage("assets/images/profile.png")
                                    as ImageProvider),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 24, 30, 41))),
                                onPressed: () {
                                  fromgallery();
                                },
                                child: const Text(
                                  'G A L L E R Y',
                                  style: TextStyle(color: Colors.grey),
                                )),
                            ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 24, 30, 41))),
                                onPressed: () {
                                  fromcam();
                                },
                                child: const Text(
                                  'C A M E R A',
                                  style: TextStyle(color: Colors.grey),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: titlecontrollercontroller,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'title',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: descriptioncontroller,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Description',
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 24, 30, 41))),
                              onPressed: () {
                                update();
                              },
                              child: const Text(
                                'U P D A T E',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  update() async {
    final editedTitle = titlecontrollercontroller.text.trim();
    final editedDescription = descriptioncontroller.text.trim();

    final editedImage = selectedimage?.path;

    if (editedTitle.isEmpty || editedDescription.isEmpty) {
      return;
    }
    final updated = NotesModel(
        title: editedTitle,
        description: editedDescription,
        image: editedImage!);

    editstudent(widget.index, updated);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Updated Successfully'),
      behavior: SnackBarBehavior.floating,
    ));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ListScreen(),
    ));
  }

  fromgallery() async {
    final returnedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      selectedimage = File(returnedimage!.path);
    });
  }

  fromcam() async {
    final returnedimage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      selectedimage = File(returnedimage!.path);
    });
  }
}
