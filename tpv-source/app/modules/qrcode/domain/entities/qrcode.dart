class QrCode {
  final String? uuid, userName, information;
  final DateTime? expirationDate;
  final int cheekCount;
  QrCode({
    required this.userName,
    this.uuid,
    required this.information,
    this.expirationDate,
    this.cheekCount = 0,
  });
}
