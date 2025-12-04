import 'package:ager_waffer/Base/Helper/passwordwidget.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [Text('AJAR WAFAR', style: TextStyle(color: Colors.white))],
          backgroundColor: Color(0xff00334E),
        ),
        body: Column(
          children: [
            PasswordWidget(),
            Container(child: TextButton(onPressed: (){}, child: Text('هل نسيت كلمة المرور؟',style: TextStyle(color: Colors.blue[900]),)))
          ],
        ),
      ),
    );
  }
}



