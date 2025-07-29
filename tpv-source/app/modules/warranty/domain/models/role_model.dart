import '/app/core/services/local_storage.dart';
import '/app/core/services/manager_authorization_service.dart';
import '/globlal_constants.dart';

class RoleModel {
  static final RoleModel instance = RoleModel._internal();

  Roles? role;
  RoleModel._internal() {
    final service = ManagerAuthorizationService().get(defaultIdpKey);
    final value = service != null ? service.get("role", "cliente") : "cliente";
    switch (value) {
      case "transportista":
        role = Roles.transportista;
        break;
      case "cliente":
        role = Roles.cliente;
        break;
      case "dependiente":
        role = Roles.dependiente;
        break;
      case "administrador":
        role = Roles.administrador;
        break;
      default:
    }
  }

  get getRole => role;
  set setRole(Roles newRole) {
    role = newRole;
  }

  asAdministrador() {
    role = Roles.administrador;
    LocalSecureStorage.storage
        .write("role", role.toString().replaceAll("Roles.", ""));
  }

  asCliente() {
    role = Roles.cliente;
    LocalSecureStorage.storage
        .write("role", role.toString().replaceAll("Roles.", ""));
  }

  asDependiente() {
    role = Roles.dependiente;
    LocalSecureStorage.storage
        .write("role", role.toString().replaceAll("Roles.", ""));
  }

  asTransportista() {
    role = Roles.transportista;
    LocalSecureStorage.storage
        .write("role", role.toString().replaceAll("Roles.", ""));
  }

  bool isAdministrador() {
    return role == Roles.administrador;
  }

  bool isCliente() {
    return role == Roles.cliente;
  }

  bool isDependiente() {
    return role == Roles.dependiente;
  }

  bool isTransportista() {
    return role == Roles.transportista;
  }
}

enum Roles { transportista, cliente, dependiente, administrador }
