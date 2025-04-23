import 'package:flutter/material.dart';
import 'package:mess_management/auth/register.dart';
import 'package:mess_management/manager/manager_home.dart';
import 'package:mess_management/user/user_home.dart';
class Join extends StatefulWidget {
  const Join({super.key});

  @override
  State<Join> createState() => _JoinState();
}

class _JoinState extends State<Join> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Join Meal System",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/join meal.jpeg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.matrix([
              1, 0, 0, 0, 0,    // Red channel
              0, 1, 0, 0, 0,    // Green channel
              0, 0, 1, 0, 0,    // Blue channel
              0, 0, 0, 1, 0,  // Alpha (0.5 = 50% opacity)
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
                  color: Colors.white,
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
            Text("  Join key",
              style: TextStyle(
                  color: Colors.white,
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
                    MaterialPageRoute(builder: (context) => Register()),

                  );
                },
                    child: Text("Join",
                      style: TextStyle(
                          color: Colors.purple[700],
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
        width: 6, // Border width
        color: Colors.white, // Border color
      ),
      borderRadius: BorderRadius.circular(30),
    );
  }
}
