

import 'package:flutter/material.dart';
import 'package:logindemo/HomePage.dart';
import 'package:logindemo/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController NameController = TextEditingController();
  GlobalKey<FormState> _forkey = GlobalKey<FormState>();
  String? pass;
  String? email;
  @override
  void initState() {
    getData();
    super.initState();
  }
  getData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pass = pref.getString('Password');
      email = pref.getString('Email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.black54.withOpacity(0.2),
        centerTitle: true,
      ),
      body:
      Form(
        key: _forkey,
        child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: TextField(
              //     decoration: InputDecoration(
              //         border:
              //         OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              //         isDense: true,
              //       hintText: pass.toString()
              //     ),
              //   ),
              // ),
              // SizedBox(height: 15),
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: TextField(
              //     decoration: InputDecoration(
              //         border:
              //         OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              //         hintText: email.toString()
              //     ),
              //   ),
              // ),
              // SizedBox(height: 15,),
              // // Text(pass.toString(),),
              // // Text(email.toString()),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: NameController,
                  validator:(value){if(value!.isEmpty)return'Please Enter Name';},
                  decoration: InputDecoration(
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText: 'Enter Name',
                  ),
                ),
              ),
              GestureDetector(onTap: () {
                setname();
                if (_forkey.currentState!.validate()) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage(),));
                }
              }),
                child: Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration( color: Colors.black54,borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
      )
              )
            ]
        ),
      ),
    );
  }
  setname() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('name', NameController.text);
  }
}
