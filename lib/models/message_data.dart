

import 'package:flutter/foundation.dart';

@immutable
class  MessageData{

  const MessageData({
    required this.senderName,
    required this.message,
    // required this.messageDate,
    // required this.datemessage,
    required this.profilePicture,
  });
  final String senderName;
  final String message;
  // final String messageDate;
  // final String datemessage;
  final String profilePicture;
 
}