import 'package:app/models/notificationModel.dart';
class Faqs {
  int faq_id;

  String question;
  String answer;

  Faqs();

  Faqs.fromJson(Map<String, dynamic> json) {
    try {
      faq_id = json['id'] != null ? int.parse('${json['id']}') : null;

      question = json['title'] != null ? json['title'] : null;
      answer = json['description'] != null ? Notifications.stripHtmlIfNeeded(json['description']) : null;
    } catch (e) {
      print("Exception - faqsModel.dart - Faqs.fromJson():" + e.toString());
    }
  }

}
