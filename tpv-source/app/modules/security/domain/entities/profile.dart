class Profile {
  final String atHash;
  final DateTime? birthday;
  final String sub;
  final String gender;
  //final String secretkey;
  final List<String> amr;
  final String iss;
  final String sid;
  final String personVerified;
  final String identification;
  final String zone;
  final String azp;
  final String state;
  final int exp;
  final int iat;
  final String email;
  final List<String> address;
  String? secondFactor;
  final String tomo;
  final String givenName;
  final String userName;
  final List<dynamic> aud;
  final String cHash;
  final int nbf;
  final String folio;
  final String phoneNumber;
  final String familyName;

  Profile({
    required this.atHash,
    required this.birthday,
    required this.sub,
    required this.gender,
    //required this.secretkey,
    required this.address,
    required this.amr,
    required this.iss,
    required this.sid,
    required this.personVerified,
    required this.identification,
    required this.zone,
    required this.azp,
    required this.state,
    required this.exp,
    required this.iat,
    required this.email,
    this.secondFactor,
    required this.tomo,
    required this.givenName,
    required this.userName,
    required this.aud,
    required this.cHash,
    required this.nbf,
    required this.folio,
    required this.phoneNumber,
    required this.familyName,
  });
}
