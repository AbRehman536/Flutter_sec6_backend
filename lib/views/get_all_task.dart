import 'package:flutter/material.dart';
import 'package:flutter_sec6_backend/model/task.dart';
import 'package:flutter_sec6_backend/services/task.dart';
import 'package:flutter_sec6_backend/views/create_task.dart';
import 'package:flutter_sec6_backend/views/get_all_priority.dart';
import 'package:flutter_sec6_backend/views/get_completed_task.dart';
import 'package:flutter_sec6_backend/views/get_favorite.dart';
import 'package:flutter_sec6_backend/views/get_incompleted_task.dart';
import 'package:flutter_sec6_backend/views/profile.dart';
import 'package:flutter_sec6_backend/views/update_task.dart';
import 'package:provider/provider.dart';

import '../provider/user.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=>GetCompletedTask()));
          }, icon: Icon(Icons.circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=>GetInCompletedTask()));
          }, icon: Icon(Icons.circle_outlined)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=>GetAllPriority()));
          }, icon: Icon(Icons.category)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=>GetFavorite()));
          }, icon: Icon(Icons.favorite)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=>Profile()));
          }, icon: Icon(Icons.person)),
        ],
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
                  trailing: Row(
                    children: [
                      Checkbox(
                          value: taskList[index].isCompleted,
                          onChanged: (val)async{
                          await TaskServices().markAsCompletedTask(
                              taskID: taskList[index].docId.toString(),
                              isCompleted: val!);
                          }),
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
                      IconButton(onPressed: ()async{
                        if(taskList[index].favorite!.contains(userProvider.getUser().docId)){
                          await TaskServices().removeFromFavorite(
                              userID: userProvider.getUser().docId.toString(),
                              taskID: taskList[index].docId.toString());
                        }
                        else{
                          TaskServices().addToFavorite(
                              userID: userProvider.getUser().docId.toString(),
                              taskID: taskList[index].docId.toString());
                        }
                      }, icon: Icon(taskList[index].favorite!.contains(userProvider.getUser().docId) ? Icons.favorite : Icons.favorite_border)
                      )]
                  ),
                );
              },);
          },
      ),
    );
  }
}
