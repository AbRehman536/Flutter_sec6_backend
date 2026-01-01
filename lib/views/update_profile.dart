import 'package:flutter/material.dart';
import 'package:flutter_sec6_backend/model/user.dart';
import 'package:flutter_sec6_backend/services/user.dart';
import 'package:provider/provider.dart';

import '../provider/user.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isLoading = false;
  @override
  void initState(){
    var userProvider = Provider.of<UserProvider>(context);
    nameController = TextEditingController(
      text: userProvider.getUser().name.toString()
    );
    phoneController = TextEditingController(
      text: userProvider.getUser().phone.toString()
    );
    addressController = TextEditingController(
      text: userProvider.getUser().address.toString()
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      body: Column(children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            label: Text("Name")
        ),),
        TextField(
          controller: phoneController,
          decoration: InputDecoration(
            label: Text("Phone")
        ),),
        TextField(
          controller: addressController,
          decoration: InputDecoration(
            label: Text("Address")
        ),),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                isLoading = true;
                setState(() {});
                await UserServices().updateUser(
                  UserModel(
                    docId: userProvider.getUser().docId.toString(),
                    name: nameController.text.toString(),
                    phone: phoneController.text.toString(),
                    address: addressController.text.toString(),
                    createdAt: DateTime.now().millisecondsSinceEpoch
                  )
                ).then((val)async{
                  UserModel userModel = await UserServices().getUserByID(
                    userProvider.getUser().docId.toString()
                  );
                  userProvider.setUser(userModel);
                }).then((value){
                  isLoading = false;
                  setState(() {});
                  showDialog(context: context,
                      builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text("Update Successfully"),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Okay"))
                      ],
                    );
                      }
                    );
                });
              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));

              }
        }, child: Text("Update Profile"))
      ],),
    );
  }
}
