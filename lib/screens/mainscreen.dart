import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:todo_using_hive/constants/color.dart';
import 'package:todo_using_hive/widgets.dart';

class ToDoMainScreen extends StatefulWidget {
  const ToDoMainScreen({Key? key}) : super(key: key);

  @override
  State<ToDoMainScreen> createState() => _ToDoMainScreenState();
}

class _ToDoMainScreenState extends State<ToDoMainScreen> {
  List<Map<String,dynamic>> tasks=[];

  final TextEditingController title=TextEditingController();
  final TextEditingController task=TextEditingController();
  final bool cheked=false;

  //hive class object
  final myTaskBox=Hive.box('todo_box');
  @override
  initState() {

    super.initState();
    fetchTask();
  }

  Future<void> createTask(Map<String, dynamic> newtask) async {
    await myTaskBox.add(newtask);
    fetchTask();

  }
  Future<void> updateTask(int itemkey, Map<String, String> uptask) async{
    await myTaskBox.put(itemkey, uptask);
    fetchTask();

  }
  Map<String,dynamic> readData(int itemkey) {
    final sdata = myTaskBox.get(itemkey);
    return sdata;
  }


  //Read Data From Hive Box
  void fetchTask(){
    final taskFormHive=myTaskBox.keys.map((key){
      final value=myTaskBox.get(key);
      return {
        'id':key,'title':value['title'],'task':value['task']
      };

    }).toList();
    setState(() {
      tasks=taskFormHive.reversed.toList();
    });
  }
  Future<void> deteteTask(int itemkey) async {
    await myTaskBox.delete(itemkey);
    fetchTask();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully deleted')));

  }

  showTask(BuildContext context, int? itemkey ) {
    if(itemkey != null){
      final existing_task= tasks.firstWhere((element) => element['id']==itemkey);
      title.text=existing_task['title'];
      task.text=existing_task['task'];

    }
    showDialog(context: context, builder: (cxt)=>AlertDialog(
      title:  Center(
        child: Text(itemkey==null ?'Add Task':"Update Task",style: const TextStyle(fontWeight: FontWeight.bold,
        fontSize: 18),),
      ),
      content: Container(
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children:  [
            TextField(
              controller:title ,
              decoration: const InputDecoration(
                hintText: "Title"
              )),
        TextField(
          controller: task,
          decoration: const InputDecoration(
              hintText: "Task"
          ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){
                if(itemkey== null){
                  createTask({
                    'title':title.text.trim(),
                    'task':task.text.trim(),
                  });
                }

                if(itemkey != null){
                  updateTask(itemkey,{
                    'title':title.text,
                    'task':task.text,

                  });
                }
                title.text='';
                task.text='';
                Navigator.of(context).pop();

              },
              style:ElevatedButton.styleFrom(
                backgroundColor: tdBlue
              ), child:  Text(itemkey == null?"Create Task" :"Upadate task"),
              ),
            )
          ],
        ),
      ),
    )

    );

  }

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        backgroundColor: tdBGColor,
        foregroundColor: Colors.black,
        leading: const Icon(Icons.menu),
        actions: const [
          CircleAvatar(backgroundColor: Colors.brown,)
        ],
      ),
      body: tasks.isEmpty?const NoTask(): Container(
        child: Column(
          children: [
            searchBox(),
            const Padding(
              padding: EdgeInsets.only(top: 10,left: 10,right: 10, bottom: 10),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("All Todos",style: TextStyle(fontSize: 30),)),
            ),
            Expanded(
                child:ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context,index){
                      final mytask=tasks[index];
                return  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    title:  Text(mytask['title'],style: TextStyle(fontSize: 16),),
                   subtitle:  Text(mytask['task']),
                   //leading:Checkbox(value: cheked, onChanged:(value)=> checkBoxChanged(value,index)

                  // ),
                    tileColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    trailing:Wrap(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: tdRed,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: IconButton(onPressed: (){

                            deteteTask(mytask['id']);
                          }, icon: const Icon(Icons.delete,
                            color: Colors.white,
                            size: 18,)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: tdBlue,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: IconButton(onPressed: (){

                            showTask(context,mytask['id']);
                          }, icon: const Icon(Icons.edit,
                            color: Colors.white,
                            size: 18,)),
                        ),
                      ],
                    )
                  ),
                );

            })),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()=> showTask(context,null),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: tdBlue,
        child: const Icon(Icons.add, size: 18,color: Colors.white,)
      ),

    );
  }


}
