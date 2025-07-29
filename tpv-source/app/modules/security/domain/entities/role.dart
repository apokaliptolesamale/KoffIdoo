import 'permission.dart';

class Role {
  final String id;
  final String name;
  final List<Permission> permissions;

  Role({
    required this.id,
    required this.name,
    required this.permissions,
  });
}
