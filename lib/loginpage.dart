import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:logindemo/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController PasswordController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var email = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  bool validatePassword(String pass){
    String _password = pass.trim();

    if(pass_valid.hasMatch(_password)){
      return true;
    }else{
      return false;
    }
  }

  bool? isLogin;
  String? username;
  String? password;
  bool ps = true;
  bool? newuser;

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    getBool();
  }

  getBool() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
   newuser =  pref.getBool('login')?? true;
    if(newuser==false)
      {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
      }
  }
  setBool() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool('login',false);
    }
  void dispose() {
    PasswordController.dispose();
    EmailController.dispose();
    super.dispose();
  }

  setData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("Password", PasswordController.text);
    pref.setString('Email', EmailController.text);
   // pref.setBool('login', true);
  }

  // getBool() async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   isLogin = pref.getBool('login') ?? true;
  //   print(isLogin);
  //   if(isLogin == false){
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstPage(),));
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
        backgroundColor: Colors.black54.withOpacity(0.2),
      ),

      body: Form(
        key: _formkey,
        child: Column(
          children: [
             Icon(
              Icons.account_circle,
              size: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: EmailController,
                validator: (email){
                  if(email!.isEmpty){
                    return 'Please Enter EmailId';
                  }
                },
                decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  icon: Icon(Icons.email),
                  hintText: 'Email',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: PasswordController,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please Enter Password';
                  }
                },
                obscureText: true,
                decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                  hintText: 'Password',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  if(_formkey.currentState!.validate()){
                    Navigator.push
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ));
                  }

                  setData();
                  setBool();

                  setState(() {

                  });
                },
                child: Container(
                  height: 40,
                  width: 80,

                  decoration: BoxDecoration( color: Colors.black54,borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
