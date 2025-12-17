import 'package:flutter/material.dart';
import 'package:flutter_sec6_backend/model/task.dart';
import 'package:flutter_sec6_backend/services/task.dart';
import 'package:flutter_sec6_backend/views/create_task.dart';
import 'package:provider/provider.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateTask()));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: TaskServices().getAllTask(),
          initialData: [TaskModel()],
          builder: (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.task),
                  title: Text(taskList[index].name.toString()),
                  subtitle: Text(taskList[index].description.toString()),
                  trailing: Icon(Icons.arrow_forward),
                );
              },);
          },
      ),
    );
  }
}
