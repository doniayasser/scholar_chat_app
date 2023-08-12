import 'package:scholar_chat/shared/components/constants.dart';

class MessageModel
{
  final String mess;
  final String messageId;
  MessageModel(this.mess, this.messageId);
  factory MessageModel.fromJson(jsonData)
  {
    return MessageModel(jsonData[kMessage],jsonData[kMessageId]);
  }
}