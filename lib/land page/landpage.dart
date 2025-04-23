import 'package:flutter/material.dart';
import 'package:mess_management/admin/create_mess.dart';
import 'package:mess_management/auth/register.dart';
import 'package:mess_management/user/join.dart';

class Landpage extends StatefulWidget {
  const Landpage({super.key});

  @override
  State<Landpage> createState() => _LandpageState();
}
class _LandpageState extends State<Landpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Welcome to Meal Assistant",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/landpage.jpeg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.matrix([
              1, 0, 0, 0, 0,    // Red channel
              0, 1, 0, 0, 0,    // Green channel
              0, 0, 1, 0, 0,    // Blue channel
              0, 0, 0, 1, 0,  // Alpha (0.5 = 50% opacity)
            ]),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Your buttons here
              _buildButton("Create new meal +", () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateMess()))),
              const SizedBox(height: 30),
              _buildButton("Join in a meal   +", () => Navigator.push(context, MaterialPageRoute(builder: (context) => Join()))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange[400],
          foregroundColor: Colors.white,
          shadowColor: Colors.black,
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 50,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}