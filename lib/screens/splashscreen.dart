import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import "package:todo_using_hive/screens/mainscreen.dart";
void main() async{
  await Hive.initFlutter();
  await Hive.openBox('todo_box');
  //await Hive.deleteBoxFromDisk('todo_box'); delete the hivebox from phone storage
  runApp(MaterialApp(home: SplashScreen() ));
}



class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ToDoMainScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height:double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage("https://images.unsplash.com/photo-1557683304-673a23048d34?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=282&q=80"))
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Lottie.asset("assets/animation/list-animation.json"),
              const Text("List Your TO DOs",style: TextStyle(fontSize: 40,color: Colors.white,),)
            ],
          ),
        ),
      ),
    );
  }
}