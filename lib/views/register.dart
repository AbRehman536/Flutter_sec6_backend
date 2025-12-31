import 'package:flutter/material.dart';
import 'package:flutter_sec6_backend/model/user.dart';
import 'package:flutter_sec6_backend/services/auth.dart';
import 'package:flutter_sec6_backend/services/user.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Column(children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(label: Text("Name")),),
        TextField(
          controller: emailController,
          decoration: InputDecoration(label: Text("Email")),),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(label: Text("Password")),),
        TextField(
          controller: cpasswordController,
          decoration: InputDecoration(label: Text("Confirm Password")),),
        TextField(
          controller: phoneController,
          decoration: InputDecoration(label: Text("Phone")),),
        TextField(
          controller: addressController,
          decoration: InputDecoration(label: Text("Address")),),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                isLoading = true;
                setState(() {});
                await AuthService().registerUser(
                    email: emailController.text,
                    password: passwordController.text)
                    .then((value){
                      UserServices().createUser(
                        UserModel(
                          name: nameController.text.toString(),
                          email: emailController.text.toString(),
                          phone: phoneController.text.toString(),
                          address: addressController.text.toString(),
                          createdAt: DateTime.now().millisecondsSinceEpoch))
                          .then((val){
                        isLoading = false;
                        setState(() {});
                            showDialog(context: context, builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text("Register Successsfully"),
                                actions: [
                                  TextButton(onPressed: (){
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }, child: Text("Okay"))
                                ],
                              );
                            }, );
                      });
                });
              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
              }
        }, child: Text("Register"))
      ],),
    );
  }
}
