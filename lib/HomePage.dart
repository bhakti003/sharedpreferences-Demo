import 'package:flutter/material.dart';
import 'package:logindemo/loginpage.dart';
import 'package:logindemo/model_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  Login? login;

  HomePage({Key? key, this.login}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController NameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController AddController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? uname;
  String? unm;
  String? uemail;
  String? uaddress;

  @override
  void initState() {
    getData();
    super.initState();
  }

  // void dispose(){
  //   NameController.dispose();
  //   EmailController.dispose();
  //   AddController.dispose();
  //   super.dispose();
  // }

  clear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  setData() async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('UserName', NameController.text);
    pref.setString('UserEmail', EmailController.text);
    pref.setString('UserAddress', AddController.text);
    pref.setBool('isLogin', false);
  }

  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      uname = pref.getString('name');
      // unm =  pref.getString('UserName');
      // uemail =  pref.getString('UserEmail');
      // uaddress=  pref.getString('UserAddress');
    });
  }

  getvalue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      unm = pref.getString('UserName') ;
      uemail = pref.getString('UserEmail') ;
      uaddress = pref.getString('UserAddress') ;
    });
  }

  // setBool() async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setBool('login', true);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 18.0, bottom: 30.0, top: 35),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          clear();
                          // setBool();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        color: Colors.white.withOpacity(0.2),
                        child: Center(
                          child: Text(
                            'Sign out',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(
                      text: 'Good Morning  ',
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                      children: [
                        TextSpan(
                          text: '$uname',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )
                      ]),
                ),
                SizedBox(height: 10),
               CustemTextFormField(controller: NameController,htext: 'Enter Name',),
                SizedBox(height: 10),
                CustemTextFormField(
                  htext: 'Enter Email',
                  controller: EmailController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter Name";
                    }
                  }
                ),
                SizedBox(height: 10),
                CustemTextFormField(
                  htext: 'Enetr Address',
                  controller: AddController,
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setData();
                      getvalue();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [
                      // SizedBox(width: 50,),
                      // SizedBox(width: 50,),
                      Text(unm.toString()),
                      Text(uemail.toString()),
                      Text(uaddress.toString()),

                    ],),
                      action: SnackBarAction(label: 'Successfully created', onPressed: (){}),
                    )
                    );
                  },
                  child: Container(
                    height: 45,
                    width: 90,
                    color: Colors.black54,
                    child: Center(
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '$unm',
                  style: TextStyle(fontSize: 22, color: Colors.grey),
                ),
                Text(
                  '$uemail',
                  style: TextStyle(fontSize: 22, color: Colors.grey),
                ),
                Text(
                  '$uaddress',
                  style: TextStyle(fontSize: 22, color: Colors.grey),
                ),
                // Text(unm != null ? unm.toString() : "",style: TextStyle(fontSize: 22,color: Colors.red),),
                // Text(uemail != null ? uemail.toString() : "",style: TextStyle(fontSize: 22,color: Colors.red),),
                // Text(uaddress != null ? uaddress.toString() : "",style: TextStyle(fontSize: 22,color: Colors.red),),
                //  Text(unm.toString()),
                // Text(uemail.toString()),
                // Text(uaddress.toString()),
                SizedBox(
                  height: 22,
                ),
              ],
            ),
          ),
        ));
  }
}

TextFormField CustemTextFormField(
    {dynamic? controller, String? htext, double? circular,String? Function(String?)? validator}) {
  return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: htext,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
        ),
      )
  );
}
