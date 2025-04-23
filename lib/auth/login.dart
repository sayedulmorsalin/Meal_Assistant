import 'package:flutter/material.dart';
import 'package:mess_management/admin/admin_home.dart';
import 'package:mess_management/user/user_home.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Login ",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),),
          Text("form",
            style: TextStyle(
                color: Colors.orange[400],
                fontSize: 30.0,
                fontWeight: FontWeight.bold),)

        ],),),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login.jpeg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.matrix([
              1, 0, 0, 0, 0,    // Red channel
              0, 1, 0, 0, 0,    // Green channel
              0, 0, 1, 0, 0,    // Blue channel
              0, 0, 0, 0.5, 0,  // Alpha (0.5 = 50% opacity)
            ]),
          ),
        ),

          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 100,),
              Text("  Name",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                ),),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                decoration: getTextFieldDecoration(),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),

                ),
              ),
              SizedBox(height: 30.0,),
              Text("  Password",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                ),),

              Container(
                padding: EdgeInsets.only(left: 20.0),
                decoration: getTextFieldDecoration(),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),

                ),
              ),


              SizedBox(height: 30.0),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserHome()),
                    );
                  },
                      child: Text("Submit",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),)
                  ),
                ),
              )
            ],
          ),
        ),


    );
  }
  BoxDecoration getTextFieldDecoration() {
    return BoxDecoration(
      color: Colors.transparent,
      border: Border.all(
        width: 4, // Border width
        color: Colors.orange, // Border color
      ),
      borderRadius: BorderRadius.circular(30),
    );
  }
}

