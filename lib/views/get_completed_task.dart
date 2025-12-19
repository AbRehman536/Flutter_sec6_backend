import 'package:flutter/material.dart';
import 'package:flutter_sec6_backend/model/task.dart';
import 'package:flutter_sec6_backend/services/task.dart';
import 'package:flutter_sec6_backend/views/create_task.dart';
import 'package:flutter_sec6_backend/views/update_task.dart';
import 'package:provider/provider.dart';

class GetCompletedTask extends StatelessWidget {
  const GetCompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Completed Task"),
      ),
      body: StreamProvider.value(
        value: TaskServices().getCompletedTask(),
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
                trailing: Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>
                              UpdateTask(model: taskList[index])));
                    }, icon: Icon(Icons.edit)),
                    IconButton(onPressed: ()async{
                      try{
                        await TaskServices().deleteTask(
                            taskList[index].docId.toString()
                        );
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete)),
                  ],
                ),
              );
            },);
        },
      ),
    );
  }
}
