

import 'package:flutter/material.dart';
import 'package:inuny/app.dart';
// import 'package:inuny/screens/Chat_screen.dart';
import 'package:inuny/screens/Signup_screen.dart';
import 'package:inuny/screens/home_screen.dart';
import 'package:inuny/screens/login_screen.dart';
import 'package:inuny/theme.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inuny/theme.dart';

import 'auth.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 
  final client = StreamChatClient(
    streamKey,
    logLevel: Level.INFO,
  );


  runApp(
   Inuny(client: client,),
  );
}


class Inuny extends StatelessWidget {
  const Inuny({super.key, required this.client});

  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      builder: (context, child) {
        return StreamChatCore(child:child!,
        client: client);
        
      },
      
      home:   StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {

        if (snapshot.hasData){
          return HomeScreen();
        } else{
          return const LoginPage();
        }
      },
      )
    );
  }
}




