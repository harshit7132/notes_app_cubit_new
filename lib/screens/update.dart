import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit_provider/list_cubit.dart';

var ID;
var NAME;
var DESC;


class Update extends StatefulWidget {
  var name;
  var desc;
  var id;
   Update({super.key,required var id, required var name, required var desc}){
    ID = id;
    NAME = name;
    DESC = desc;
   }

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
    TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    titleController.text =  NAME;
    descController.text = DESC;  
  
    return Scaffold(
      appBar: AppBar(
        title: Text("update taks"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(fontSize:20, fontWeight: FontWeight.bold),
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: descController,
              maxLines: 10,
              decoration: InputDecoration(
                  hintText: "Desc",
                  // hintStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<List_Cubit>(context).updateData(ID, titleController.text , descController.text);

          Navigator.pop(context);
        },
        child: Icon(Icons.save),
      ),
    );
  
  }
}