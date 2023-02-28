

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inuny/auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:inuny/main.dart';
import 'package:inuny/screens/Signup_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void>signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(email: _controllerEmail.text, password: _controllerPassword.text);
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

  Widget _errorMessage(){
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

 

  Widget _loginOrRegisterButton(){
    return TextButton(onPressed: () {
      setState(() {
        isLogin = !isLogin;
      });
    }, child: Text(isLogin ? 'Registered': 'Login '));
  }

 Widget _logInButton(){
    return SizedBox(
      height: 48,
      width: 327,
      child: ElevatedButton(
        
        onPressed: signInWithEmailAndPassword,
       child: Text('Login'),
       style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff33c283),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        )
        
       ),),
    );
  }

   Widget _SignUpButton(){
    return TextButton(onPressed: () {
      setState(() {
        isLogin = !isLogin;
      });
    }, child: Text(isLogin ? 'SignUp': 'Login ', style: TextStyle(
      color: Color(0xff33c283),
      
    ),));
  }

Widget _signupnavigation(){
  return TextButton(onPressed: () {
     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SignUpPage()));
  }, child: Text('SignUp', style: TextStyle(
      color: Color(0xff33c283),
      
    ),));
}




  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
         color: Color(0xffF3F3F3),
        ),
        child: Column(
          
        
          children: [
           
            const SizedBox(
              height: 30,
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
                    child: _entryfield('Password', _controllerPassword),
                    ),

                      ],
                    ),
              ),
            ),

            SizedBox(
              height: 42,
            ),

            Text("Forgot your Password?", style: TextStyle(
              fontWeight: FontWeight.w500,
                   color: Color(0xff8C8C8C),
                  fontSize: 15,
            ),),

            SizedBox(
              height: 118,
            ),

            _logInButton(),

            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont Have an account?', style: TextStyle(
                  fontWeight: FontWeight.w500,
                   color: Color(0xff8C8C8C),
                  fontSize: 15,
                ),),

                _signupnavigation()

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

