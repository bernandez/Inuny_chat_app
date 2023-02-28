

import 'package:flutter/material.dart';
import 'package:inuny/screens/Chat_screen.dart';
import 'package:inuny/screens/Signup_screen.dart';
import 'package:inuny/screens/login_screen.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as stream;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth.dart';

final client = stream.StreamChatClient(
    'b67pax5b2wdq',
    logLevel: stream.Level.INFO,
  );

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  

  await Firebase.initializeApp();

  await client.connectUser(
    stream.User(id: 'tutorial-flutter'),
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidHV0b3JpYWwtZmx1dHRlciJ9.S-MJpoSwDiqyXpUURgO5wVqJ4vKlIVFLSEyrFYCOE1c',
  );

  runApp(
    Montero(),
  );
}

class ChatPage extends StatelessWidget {
   ChatPage({
    Key? key,
    required this.client,
  }) : super(key: key);
   final User? user = Auth().currentUser;
   
  Future<void> signOut() async{
    await Auth().signOut();
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User Email');
  }

  Widget _signOutButton(){
    return ElevatedButton(onPressed: signOut , child: Text('Sign Out'));
  }




  final stream.StreamChatClient client;


  @override
  Widget build(BuildContext context) {
    return ChatScreen(
      client: client,
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
    required this.client,
  }) : super(key: key);

  final stream.StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => stream.StreamChat(
        client: client,
        child: child,
      ),
      home: const ChannelListPage(),
    );
  }
}

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChannelListPage> createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  late final _listController = stream.StreamChannelListController(
    client: stream.StreamChat.of(context).client,
    filter: stream.Filter.in_(
      'members',
      [stream.StreamChat.of(context).currentUser!.id],
    ),
    sort: const [stream.SortOption('last_message_at')],
    limit: 20,
  );

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: stream.StreamChannelListView(
        controller: _listController,
        onChannelTap: (channel) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return stream.StreamChannel(
                  channel: channel,
                  child: const ChannelPage(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const stream.StreamChannelHeader(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: stream.StreamMessageListView(
              messageBuilder: _messageBuilder,
            ),
          ),
          const stream.StreamMessageInput(),
        ],
      ),
    );
  }

  Widget _messageBuilder(
    BuildContext context,
    stream.MessageDetails details,
    List<stream.Message> messages,
    stream.StreamMessageWidget defaultMessageWidget,
  ) {
    final message = details.message;
    final isCurrentUser = stream.StreamChat.of(context).currentUser!.id == message.user!.id;
    final textAlign = isCurrentUser ? TextAlign.right : TextAlign.left;
    final color = isCurrentUser ? Colors.blueGrey : Colors.blue;

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff33c283),
          border: Border.all(
            color: color,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: ListTile(
          title: Text(
            message.text!,
            textAlign: textAlign,
            
          ),
          subtitle: Text(
            
            message.user!.name,
            textAlign: textAlign,
          ),
        ),
      ),
    );
  }
}


class Inuny extends StatefulWidget {
  const Inuny({super.key});

  @override
  State<Inuny> createState() => _InunyState();
}

class _InunyState extends State<Inuny> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {

        if (snapshot.hasData){
          return ChatPage(client: client,);
        } else{
          return const LoginPage();
        }
      },
      );
  }
}


class Montero extends StatelessWidget {
  const Montero({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Inuny(),
    );
  }
}