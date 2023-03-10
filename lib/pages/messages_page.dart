

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:inuny/helpers.dart';
import 'package:inuny/screens/chat_screen.dart';
import 'package:inuny/theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart' as stream;
import 'package:stream_channel/stream_channel.dart';


class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return  CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stories(),
          ),
          SliverList(delegate: SliverChildBuilderDelegate(_delegate))
        ],
      );
   
  }

  Widget _delegate(context, index) {
    final Faker faker = Faker();
    final date = Helpers.randomDate();
            return _MessageTitle(messageData: MessageData(
              senderName: faker.person.name(), message: faker.lorem.sentence(), 
              
              profilePicture: Helpers.randomPictureUrl()));
          }
}






class _MessageTitle extends StatelessWidget {
  const _MessageTitle({super.key, required this.messageData});

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(ChatScreen.route(messageData));
      },

      child: Container(
        height: 100,
        margin:  EdgeInsets.symmetric(horizontal: 8),
         decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 0.5,
              ),
            ),
          ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(url: messageData.profilePicture,),
              ),
    
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(messageData.senderName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    letterSpacing: 0.2,
                    wordSpacing: 1.5,
                    fontWeight: FontWeight.w900
                  ),),
                  SizedBox(
                    height: 20,
                    child: Text(messageData.message))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}


class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 0,
      child: SizedBox(
        height: 134,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Padding(
              padding: const EdgeInsets.only(left:16.0, top: 8, bottom: 16),
              child: Text('Stories',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15,
                color: AppColors.textFaded
              ),),
            ),
         Expanded(
           child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              final faker = Faker();
             return Padding(
               padding: const EdgeInsets.all(8.0),
               child: SizedBox(
                width: 60,
                 child: _StoryCard(storyData: StoryData(
                  name: faker.person.name(),
                  url: Helpers.randomPictureUrl(),
                 ),
                 ),
               ),
             );
           })),
         )
    
          ],
    
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    Key? key,
    required this.storyData,
  }) : super(key: key);

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}



