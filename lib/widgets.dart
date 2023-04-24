import 'package:flutter/material.dart';
import 'package:todo_using_hive/constants/color.dart';

Widget searchBox() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    ),
  );
}

class NoTask extends StatelessWidget {
  const NoTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Image.asset("assets/image/empty.jpg",height: 200,width: 200,),
            const Text("No Task",style: TextStyle(fontSize: 40,color: Color.fromARGB(255, 1, 33, 59)),),
          ],
        ),
      ),
    );
  }
}

class SingleTask extends StatelessWidget {
  final String title, task;
  const SingleTask( this.title,this.task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tdBGColor,
        foregroundColor: Colors.black,
        leading: const Icon(Icons.menu),
        actions:  [
          IconButton(onPressed: (){}, icon: Icon(Icons.edit))
        ],
      ),
      body:Container(
        child: Column(
          children: [
            Text(''),
          Text('')
          ],
        ),
      ),

    );
  }
}
