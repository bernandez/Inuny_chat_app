

import 'package:flutter/material.dart';
import 'package:inuny/app.dart';
// import 'package:inuny/screens/Chat_screen.dart';
import 'package:inuny/screens/Signup_screen.dart';
import 'package:inuny/screens/home_screen.dart';
import 'package:inuny/screens/login_screen.dart';
import 'package:inuny/screens/select_user.dart';
import 'package:inuny/theme.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inuny/theme.dart';


import 'auth.dart';




void main() {
  final client = StreamChatClient(streamKey);

  runApp(
    MyApp(
      client: client,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.client,
  }) : super(key: key);

  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      themeMode: ThemeMode.dark,
      title: 'Chatter',
      builder: (context, child) {
        return StreamChatCore(
          client: client,
          child: ChannelsBloc(
            child: UsersBloc(
              child: child!,
            ),
          ),
        );
      },
      home: const SelectUserScreen(),
    );
  }
}



// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
 
//   final client = StreamChatClient(
//     streamKey,
//     logLevel: Level.INFO,
//   );


//   runApp(
//    Inuny(client: client,),
//   );
// }



// class Inuny extends StatelessWidget {
//   const Inuny({super.key, required this.client});

//   final StreamChatClient client;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark(),
//       builder: (context, child) {
//         return StreamChatCore(
//           client: client,
//           child:child!);
        
//       },
      
//       home:   StreamBuilder(
//       stream: Auth().authStateChanges,
//       builder: (context, snapshot) {

//         if (snapshot.hasData){
//           return const HomeScreen();
//         } else{
//           return const HomeScreen();
//         }
//       },
//       )
//     );
//   }
// }


// class ChannelPage extends StatelessWidget {
//   const ChannelPage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const stream.StreamChannelHeader(),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: stream.StreamMessageListView(
//               messageBuilder: _messageBuilder,
//             ),
//           ),
//           const stream.StreamMessageInput(),
//         ],
//       ),
//     );
//   }

//   Widget _messageBuilder(
//     BuildContext context,
//     stream.MessageDetails details,
//     List<stream.Message> messages,
//     stream.StreamMessageWidget defaultMessageWidget,
//   ) {
//     final message = details.message;
//     final isCurrentUser = stream.StreamChat.of(context).currentUser!.id == message.user!.id;
//     final textAlign = isCurrentUser ? TextAlign.right : TextAlign.left;
//     final color = isCurrentUser ? Colors.blueGrey : Colors.blue;

//     return Padding(
//       padding: const EdgeInsets.all(5),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Color(0xff33c283),
//           border: Border.all(
//             color: color,
//           ),
//           borderRadius: const BorderRadius.all(
//             Radius.circular(15),
//           ),
//         ),
//         child: ListTile(
//           title: Text(
//             message.text!,
//             textAlign: textAlign,
            
//           ),
//           subtitle: Text(
            
//             message.user!.name,
//             textAlign: textAlign,
//           ),
//         ),
//       ),
//     );
//   }
// }







