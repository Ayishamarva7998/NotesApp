import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/list_clr.dart';
import 'package:flutter_application_1/model/data_model.dart';
import 'package:flutter_application_1/views/add_screen.dart';
import 'package:flutter_application_1/views/edit_screen.dart';
import 'package:flutter_application_1/function/todo_function.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListStudentState createState() => _ListStudentState();
}

class _ListStudentState extends State<ListScreen> {
  TextEditingController searchController = TextEditingController();
  List<NotesModel> studentList = [];
  List<NotesModel> filteredStudentList = [];

  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    // Initialize your studentList here, e.g., calling getAllStud()
    getAllStudents();
  }

  void filterStudents(String search) {
    if (search.isEmpty) {
      // If the search query is empty, show all students.
      setState(() {
        filteredStudentList = List.from(studentList);
      });
    } else {
      setState(() {
        filteredStudentList = studentList
            .where((student) =>
                student.title.toLowerCase().contains(search.toLowerCase()))
            .toList();
      });
    }
  }

  // Function to sort the studentList
  void sortStudents() {
    setState(() {
      studentList.sort((a, b) => a.title.compareTo(b.description));
      // After sorting, set filteredStudentList to the sorted list.
      filteredStudentList = List.from(studentList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 24, 30, 41),
          title: isSearching
              ? buildSearchField()
              : const Text(
                  "TodoApp",
                  style: TextStyle(color: Colors.white),
                ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    // Clear the search query and show all students.
                    searchController.clear();
                    filteredStudentList = List.from(studentList);
                  }
                });
              },
              icon: Icon(isSearching ? Icons.cancel : Icons.search),
            ),
          ],
        ),
        body: Center(
          child: isSearching
              ? filteredStudentList.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (ctx, index) {
                        final data = filteredStudentList[index];
                        return buildStudentCard(data, index);
                      },
                      separatorBuilder: (ctx, index) {
                        return const Divider();
                      },
                      itemCount: filteredStudentList.length,
                    )
                  : const Center(
                      child: Text("No results found."),
                    )
              : buildStudentList(),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color.fromARGB(255, 24, 30, 41),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddStudentWidget(),
              ),
            );
          },
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          label: const Text(
            "Add Notes",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 39, 46, 58),
      ),
    );
  }

  Widget buildSearchField() {
    return TextField(
      controller: searchController,
      onChanged: (query) {
        filterStudents(query);
      },
      autofocus: true,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: "Search notes...",
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.7),
        ),
        border: InputBorder.none,
      ),
    );
  }

  Widget buildStudentCard(NotesModel data, int index) {
    final pro = Provider.of<ColorProvider>(context);
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(pro.theme),
          backgroundImage: FileImage(File(data.image)),
        ),
        title: Text(
          data.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          data.description,
        ),
        trailing: SingleChildScrollView(
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditScreen(
                        index: index,
                        title: data.title,
                        description: data.description,
                        image: data.image,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  deleteStudent(index);
                },
                icon: const Icon(Icons.delete_rounded),
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStudentList() {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (BuildContext ctx, List<NotesModel> studentlist, Widget? child) {
        studentList = studentlist;
        filteredStudentList = List.from(studentList);

        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            return buildStudentCard(data, index);
          },
          separatorBuilder: (ctx, index) {
            return const Divider();
          },
          itemCount: studentList.length,
        );
      },
    );
  }
}
