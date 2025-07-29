class ProfileEntity {
  String? atHash;
    DateTime? birthday;
    String? sub;
    dynamic address;
    String? gender;
    List<String>? amr;
    String? secondFactor;
    String? iss;
    String? tomo;
    String? givenName;
    String? personVerified;
    String? aud;
    String? cHash;
    String? nbf;
    String? identification;
    String? zone;
    String? azp;
    String? folio;
    String? phoneNumber;
    String? state;
    String? exp;
    String? iat;
    String? familyName;
    String? email;

    ProfileEntity({
       this.atHash,
       this.birthday,
       this.sub,
       this.address,
       this.gender,
       this.amr,
       this.secondFactor,
       this.iss,
       this.tomo,
       this.givenName,
       this.personVerified,
       this.aud,
       this.cHash,
       this.nbf,
       this.identification,
       this.zone,
       this.azp,
       this.folio,
       this.phoneNumber,
       this.state,
       this.exp,
       this.iat,
       this.familyName,
       this.email,
    });
}