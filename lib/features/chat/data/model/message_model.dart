import 'package:agora_chat_sdk/agora_chat_sdk.dart';



class MessageModel {
  String id;
  String message;
  String audio;
  String? imagePath;
  String? filePath;
  String? fileName;
  bool isImage;
  bool isFile;
  bool isSender;

  bool isDelivery;
  bool isRead;

  String createTime;
  MessageType messageType;

  MessageModel({
    required this.id,
    required this.message,
    required this.isSender,
    required this.createTime,
    this.audio = "",
    this.messageType = MessageType.TXT,
    this.imagePath,
    this.filePath,
    this.fileName,
    this.isImage = false,
    this.isFile = false,
    this.isDelivery = false,
    this.isRead = false,
  });

  String convertArabicIndicToArabicNumerals(String input) {
    const arabicIndicDigits = '٠١٢٣٤٥٦٧٨٩';
    const arabicDigits = '0123456789';
    for (int i = 0; i < arabicIndicDigits.length; i++) {
      input = input.replaceAll(arabicIndicDigits[i], arabicDigits[i]);
    }
    return input;
  }

  DateTime get timestamp {
    String convertedCreateTime = convertArabicIndicToArabicNumerals(createTime);
    return DateTime.parse(convertedCreateTime);
  }
}
