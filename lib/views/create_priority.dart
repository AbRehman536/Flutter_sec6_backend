import 'package:flutter/material.dart';
import 'package:flutter_sec6_backend/model/priority.dart';
import 'package:flutter_sec6_backend/model/task.dart';
import 'package:flutter_sec6_backend/services/priority.dart';
import 'package:flutter_sec6_backend/services/task.dart';

class CreatePriority extends StatefulWidget {
  const CreatePriority({super.key});

  @override
  State<CreatePriority> createState() => _CreatePriorityState();
}

class _CreatePriorityState extends State<CreatePriority> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Priority"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        TextField(controller: nameController,decoration: InputDecoration(
            label: Text("Name")
        ),),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
          try{
            isLoading = true;
            setState(() {});
            await PriorityServices().createPriority(PriorityModel(
                name: nameController.text.toString(),
                createdAt: DateTime.now().millisecondsSinceEpoch
            )).then((value){
              isLoading = false;
              setState(() {});
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Create Successfully"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("Okay"))
                    ],
                  );
                }, );
            });
          }catch(e){
            isLoading = false;
            setState(() {});
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }, child: Text("Create Priority"))
      ],),
    );
  }
}
