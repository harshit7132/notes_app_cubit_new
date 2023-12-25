// ignore_for_file: camel_case_types

import 'package:flutter_bloc/flutter_bloc.dart';

import '../database_provider/mydb_helper.dart';
import 'state_cubit.dart';

class List_Cubit extends Cubit<State_Cubit> {
  List_Cubit() : super(State_Cubit(arrdata: []));

  /// function add ///
  void addDataCubit(String title, String desc) async {
    bool chack = await MyDBHelper().addNote(title, desc);
    if (chack) {


     // var data = MyDBHelper().fetchAllNotes();
      emit(State_Cubit(arrdata: await MyDBHelper().fetchAllNotes()));
    } else {
      print("Data Not Added");
    }
  }

  Future<void> getInitialData()async{
    emit(State_Cubit(arrdata: await MyDBHelper().fetchAllNotes()));
  }

Future<void> updateData(int id, String title, String desc)async{
    bool check = await MyDBHelper().updateNotes(id, title, desc);
    if(check){
      emit(State_Cubit(arrdata: await MyDBHelper().fetchAllNotes()));
    }else{
      print("Data Not update");
    }
  }

  Future<void> deletData(int id)async{
    bool check = await MyDBHelper().deletNotes(id);
    if(check){
      emit(State_Cubit(arrdata: await MyDBHelper().fetchAllNotes()));
    }else{
      print("Remove items");
    }
    
  }

}
