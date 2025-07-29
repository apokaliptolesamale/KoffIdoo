import '../../../../../app/modules/home/domain/entities/user_notification.dart';

class Notify {
  String id;
  String idNotification;
  DateTime fecha;
  List<UserNotification> userNotification;
  String evento;
  String typeNotification;
  List<String> channel;
  String title;
  String body;

  Notify({
    required this.id,
    required this.idNotification,
    required this.fecha,
    required this.userNotification,
    required this.evento,
    required this.typeNotification,
    required this.channel,
    required this.title,
    required this.body,
  });
}
