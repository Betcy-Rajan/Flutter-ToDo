import 'package:flutter/material.dart';
import 'package:todo/Domain/todo/todo_model.dart';

class ScreenTodo extends StatefulWidget {
  const ScreenTodo({super.key});

  @override
  State<ScreenTodo> createState() => _ScreenTodoState();
}

class _ScreenTodoState extends State<ScreenTodo> {
  List<TodoModel> todoList = [];
  final todoController = TextEditingController();
  int id=0;
  int editFlag = 0;
  String ? editTaskID ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('TODO APP',
        style: TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.bold
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*.1,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: todoController,
                        decoration: const InputDecoration(
                              hintText: 'Task',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)))),
                      ),
                    ),
                  ),
                  Padding(
                     padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){
                       editFlag == 0 ? addTask() : editTask(editTaskID !, todoController.text);
                      
                    }, 
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.pink)),
                      child: Text(
                         editFlag == 0 ?'Add':'Save',
                        style: const TextStyle(color: Colors.white),
                      ),
                     ),
                      
                  )
                ],
              ),
            ),
            const Divider(),
           SizedBox(
             height: MediaQuery.of(context).size.height*.9,
             child: ListView.builder(itemBuilder: (context,index) {
              return  ListTile(
                onTap: (){
                  changeStatus(todoList[index].taskId);
                },
                leading: Text({index+1}.toString()),
                title: Text(todoList[index].taskName),
                subtitle: Row(
                  children: [
                    Text(todoList[index].taskStatus=='0'?'Not Completed': 'Completed',
                    style: TextStyle(
                      color: todoList[index].taskStatus=='0'? Colors.red : Colors.green
                    ),
                    ),
                    const Spacer(),
                    IconButton(onPressed: () {
                  deleteTask(todoList[index].taskId);
                }, 
                icon: const Icon(Icons.delete)),

                  IconButton(onPressed: () {
                     setState(() {
            todoController.text=todoList[index].taskName;
            editTaskID = todoList[index].taskId;
            editFlag=1;
    });
            
                }, 
                icon: const Icon(Icons.edit)),
                  ],
                ),
              
              );
             },
             itemCount: todoList.length,),
           )
          ],
        ),
      ),
    );
  }
  void addTask() {
        TodoModel t =TodoModel(taskId: id.toString(), taskName: todoController.text, taskStatus: '0');
                     id=id+1;
                     setState(() {
                       todoList.add(t);
                       todoController.text='';
                     });
  }
  void changeStatus(String id) {
   setState(() {
     for(var doc in todoList) {
      if(doc.taskId == id) {
        doc.taskStatus== '0' ? doc.taskStatus = '1' : doc.taskStatus = '0';
      }
     }
   });
  }
  void deleteTask(String id) {
    setState(() {
      todoList.removeWhere((todo)=> todo.taskId == id);
    });

  }
  void editTask(String id,String taskName) {
    setState(() {
      for(var doc in todoList) {
      if(doc.taskId == id) {
        doc.taskName = taskName;
        editFlag=0;
      }
      }
    });
  }
}