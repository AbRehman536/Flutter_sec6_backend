import 'package:flutter/material.dart';
import 'package:flutter_sec6_backend/model/priority.dart';
import 'package:flutter_sec6_backend/model/task.dart';
import 'package:flutter_sec6_backend/services/priority.dart';
import 'package:flutter_sec6_backend/services/task.dart';

class CreatePriority extends StatefulWidget {
  final PriorityModel model;
  final bool isUpdatedMode;
  const CreatePriority({super.key, required this.model, required this.isUpdatedMode});

  @override
  State<CreatePriority> createState() => _CreatePriorityState();
}

class _CreatePriorityState extends State<CreatePriority> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
    super.initState();
    if(widget.isUpdatedMode == true){
      nameController = TextEditingController(
          text: widget.model.name.toString()
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdatedMode ? "Update Priority" : "Create Priority"),
        backgroundColor: widget.isUpdatedMode ? Colors.blue : Colors.black,
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
            if(widget.isUpdatedMode == true){
              await PriorityServices().updatePriority(PriorityModel(
                  docId: widget.model.docId.toString(),
                  name: nameController.text.toString(),
                  createdAt: DateTime.now().millisecondsSinceEpoch
              )).then((value){
                isLoading = false;
                setState(() {});
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text("Update Successfully"),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Okay"))
                      ],
                    );
                  }, );
              });
            }
            else{
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
            }
          }catch(e){
            isLoading = false;
            setState(() {});
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }, child: Text(widget.isUpdatedMode == true ?
        "Update Priority ": "Create Priority"))
      ],),
    );
  }
}
