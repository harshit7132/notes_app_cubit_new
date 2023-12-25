
import 'package:demo/screens/update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit_provider/list_cubit.dart';
import '../cubit_provider/state_cubit.dart';
import 'edit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<List_Cubit>(context).getInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cubit Todo List"),
      ),
      body: BlocBuilder<List_Cubit, State_Cubit>(builder: (context, state) {
        notes = state.arrdata;
        return
          ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            var currNote = state.arrdata[index];
            return 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Update(id: currNote["note_id"], name: currNote["title"],desc: currNote["desc"],)));
                  },
                  child: ListTile(
                    leading: Text("${index + 1}"),
                    title: Text("${currNote["title"]}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    subtitle: Text("${currNote['desc']}"),
                    trailing: InkWell(
                        onTap: () {
                          BlocProvider.of<List_Cubit>(context)
                              .deletData(currNote["note_id"]);
                        },
                        child: Icon(Icons.delete)),
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Edit_Screen(),
              ));

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
