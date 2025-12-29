import 'package:flutter/material.dart';
import 'package:flutter_sec6_backend/model/task.dart';
import 'package:flutter_sec6_backend/services/task.dart';
import 'package:provider/provider.dart';

class GetFavorite extends StatelessWidget {
  const GetFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Favorite"),
      ),
      body: StreamProvider.value(
          value: TaskServices().getAllFavorite("1"),
          initialData: [TaskModel()],
        builder: (context,child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.favorite_border),
                  title: Text(taskList[index].name.toString()),
                  subtitle: Text(taskList[index].description.toString()),
                );
              },);
        },

      ),
    );
  }
}
