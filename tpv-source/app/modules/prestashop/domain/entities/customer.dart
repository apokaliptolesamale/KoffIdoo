class Customer {
  final dynamic id;
  final String firstName, lastName, email, userName, dni;

  Customer({
    this.id,
    required this.dni,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
  });
}
