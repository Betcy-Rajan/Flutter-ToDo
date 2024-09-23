import 'package:flutter/material.dart';
import 'package:todo/persentation/todohome.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    // TODO: implement initState
    navigator(context);
    
    super.initState();
  
  }
  @override
 

  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.red,

          ),
          Text('Loading')
        ],
      ),
    );
  }
  Future navigator (BuildContext context)async
   
  {
   await Future.delayed(const Duration(seconds: 3));
   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ScreenTodo()));
    
  }
}