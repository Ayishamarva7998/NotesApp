import 'dart:io';

import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:flutter_application_1/controller/list_clr.dart';
import 'package:flutter_application_1/function/todo_function.dart';
import 'package:flutter_application_1/views/list_screen.dart';
import 'package:flutter_application_1/model/data_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddStudentWidget extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const AddStudentWidget({Key? key});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  // Color currentColor = Colors.transparent;

  final ImagePicker imagePicker = ImagePicker();
  File? pickedimage;

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Welcome!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 24, 30, 41),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  // getimage(ImageSource.camera);
                },
                child: Consumer<ColorProvider>(
                  builder: (context, value1, child) => CircleAvatar(
                    radius: 50,
                    backgroundColor: value1.design.elementAt(value1.theme),
                    child: TextButton(
                        onPressed: () {
                          value1.change();
                        },
                        child: const Text('click')),

                    // backgroundColor: const Color.fromARGB(255, 24, 30, 41),
                    //   child: pickedimage == null
                    //       ? const Icon(Icons.camera)
                    //       : ClipOval(
                    //           child: Image.file(
                    //             pickedimage!,
                    //             fit: BoxFit.cover,
                    //             height: 120,
                    //             width: 120,
                    //           ),
                    //         )
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                  labelText: 'Title',
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.list_alt_outlined),
                ),
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 15),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    onAddStudentButtonClicked(context);
                  });
                },
                child: const Icon(
                  Icons.save_rounded,
                  color: Colors.black,
                ),
              ),
            ]),
          ),
        ),
        backgroundColor: Colors.grey,
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(BuildContext context) async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      return;
    }

    final _student = NotesModel(
      title: title,
      description: description,
      image: pickedimage?.path ?? '',
    );
    addStudent(_student);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListScreen()),
    );
  }

  getimage(ImageSource source) async {
    var img = await imagePicker.pickImage(source: source);
    setState(() {
      pickedimage = File(img!.path);
    });
  }
}
