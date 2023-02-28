

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inuny/auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:inuny/main.dart';
import 'package:inuny/screens/login_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerRepeatPassword = TextEditingController();

  Future<void>signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

   Future<void>createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(email: _controllerEmail.text, password: _controllerRepeatPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  

  Widget _entryfield(
    String title,
    TextEditingController controller,

  ){
    return TextField(
      maxLines: 2,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email,color: Color(0xff33c283),),
        
        
        labelText: title,
         labelStyle: TextStyle(

          color: Colors.grey),
          border: InputBorder.none,
          
      ),
    );
  }



Widget _passwordfield(
    String title,
    TextEditingController controller,

  ){
    return TextField(
      maxLines: 2,
      controller: controller,
      
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key,color: Color(0xff33c283),),
        
        
        labelText: title,
         labelStyle: TextStyle(

          color: Colors.grey),
          border: InputBorder.none,
          
      ),
    );
  }








  

  Widget _errorMessage(){
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton(){
    return ElevatedButton(onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
     child: Text(isLogin ? 'Login' : 'SignUp'));
  }

  Widget _loginOrRegisterButton(){
    return TextButton(onPressed: () {
      setState(() {
        isLogin = !isLogin;
      });
    }, child: Text(isLogin ? 'Registered': 'Login '));
  }

   Widget _signupnavigationbutton(){
    return TextButton(onPressed: () {
      setState(() {
        isLogin = !isLogin;
      });
    }, child: Text(isLogin ? 'Registered': 'Login '));
  }

  Widget _loginnavigation(){
  return TextButton(onPressed: () {
     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginPage()));
  }, child: Text('LogIn', style: TextStyle(
      color: Color(0xff33c283),
      
    ),));
}



 Widget _signupButton(){
    return Padding(
      padding: const EdgeInsets.only(left:24.0,right: 24),
      child: SizedBox(
        height: 48,
        width: 327,
        child: ElevatedButton(
          
          onPressed: createUserWithEmailAndPassword,
         child: Text('SignUp'),
         style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff33c283),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          )
          
         ),),
      ),
    );
  }






  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
         color: Color(0xffF3F3F3),
        ),
        child: ListView(
          
        
          children: [
           
            const SizedBox(
              height: 10.0,
            ),
            Center(child: Image.asset("assets/images/inuny.png")),
            
            Padding(
              padding: const EdgeInsets.only(left:24.0, right: 24),
              child: Container(
                  margin: const EdgeInsets.all(10.0),
                
                  
                decoration:
                    BoxDecoration(color: Color(0xffFAFAFA), borderRadius: BorderRadius.circular(5.0)),

                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20.0),
                        child: _entryfield('Email', _controllerEmail,),
                        ),
                         Container(
                      margin: const EdgeInsets.only(left: 0),
                      height: 0.2,
                      color: Colors.grey,
                    ),
                    Padding(padding: EdgeInsets.only(left: 20.0),
                    child: _passwordfield('Password', _controllerPassword),
                    ),
                     Container(
                      margin: const EdgeInsets.only(left: 0),
                      height: 0.2,
                      color: Colors.grey,
                    ),
                     Padding(padding: EdgeInsets.only(left: 20.0),
                    child: _passwordfield('RepeatPassword', _controllerRepeatPassword),)

                      ],
                    ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            

            // SizedBox(
            //   height: 118,
            // ),

            _signupButton(),

            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have and account?', style: TextStyle(
                  fontWeight: FontWeight.w500,
                   color: Color(0xff8C8C8C),
                  fontSize: 15,
                ),),
                _loginnavigation(),

              



                

              ],
            ),
           
        // _entryfield('email', _controllerEmail),
        // _entryfield('Password', _controllerPassword),
        // _errorMessage(),
        // _submitButton(),
        // _loginOrRegisterButton(),    
          ],
        ),
      ),
    );
  }



}

