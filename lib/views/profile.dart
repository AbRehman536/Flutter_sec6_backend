import 'package:flutter/material.dart';
import 'package:flutter_sec6_backend/provider/user.dart';
import 'package:flutter_sec6_backend/views/update_profile.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(
        children: [
          Text("Name: ${userProvider.getUser().name}"),
          Text("Email: ${userProvider.getUser().email}"),
          Text("phone: ${userProvider.getUser().phone}"),
          Text("address: ${userProvider.getUser().address}"),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfile()));
          }, child: Text("Update Profile"))
        ],
      ),
    );
  }
}
