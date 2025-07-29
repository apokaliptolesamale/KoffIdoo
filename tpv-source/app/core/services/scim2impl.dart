// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_field
import 'dart:convert';

import 'package:http/http.dart' as http;

import '/app/core/interfaces/get_provider.dart';
import '/app/core/services/paths_service.dart';
import '../../../globlal_constants.dart';
import '../interfaces/header_request.dart';

abstract class Scim2ApiService {}

class Scim2GroupService extends Scim2Impl {
  final String _baseUrl; // = 'https://example.com/scim/v2/Groups';
  Scim2GroupService({
    required String path,
    Map<String, String>? headers,
  })  : _baseUrl = path,
        super(
          path: path,
          headers: headers,
        );

  /// Crea un nuevo grupo.
  Future<Map<String, dynamic>> createGroup(Map<String, dynamic> group) async {
    final headers = getHeaders;

    final response = await http.post(Uri.parse(_baseUrl),
        headers: headers, body: jsonEncode(group));
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return responseBody;
    } else {
      throw Exception('Error al crear el grupo.');
    }
  }

  /// Elimina un grupo por ID.
  Future<void> deleteGroup(String groupId) async {
    final headers = getHeaders;

    final response =
        await http.delete(Uri.parse('$_baseUrl/$groupId'), headers: headers);

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar el grupo.');
    }
  }

  /// Obtiene un grupo por ID.
  Future<Map<String, dynamic>> getGroup(String groupId) async {
    final headers = getHeaders;

    final response =
        await http.get(Uri.parse('$_baseUrl/$groupId'), headers: headers);
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('Error al obtener el grupo.');
    }
  }

  /// Obtiene la lista de grupos.
  Future<List<Map<String, dynamic>>> listGroups() async {
    final headers = getHeaders;

    final response = await http.get(Uri.parse(_baseUrl), headers: headers);
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final groups = responseBody['Resources'] as List<dynamic>;
      return groups
          .map<Map<String, dynamic>>((group) => group as Map<String, dynamic>)
          .toList();
    } else {
      throw Exception('Error al obtener la lista de grupos.');
    }
  }

  /// Actualiza parcialmente un grupo por ID.
  Future<void> patchGroup(
      String groupId, List<Map<String, dynamic>> patches) async {
    final headers = getHeaders;

    final response = await http.patch(Uri.parse('$_baseUrl/$groupId'),
        headers: headers, body: jsonEncode(patches));

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el grupo.');
    }
  }

  /// Actualiza un grupo por ID.
  Future<void> updateGroup(String groupId, Map<String, dynamic> updates) async {
    final headers = getHeaders;

    final response = await http.put(Uri.parse('$_baseUrl/$groupId'),
        headers: headers, body: jsonEncode(updates));

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el grupo.');
    }
  }
}

class Scim2Impl extends GetDefautlProviderImpl implements Scim2ApiService {
  final String path;
  late GetProviderImpl provider;
  Map<String, String>? _headers;
  //
  Scim2Impl({
    required this.path,
    Map<String, String>? headers,
  }) : super(
          allowAutoSignedCert: true,
          followRedirects: true,
          maxAuthRetries: 3,
          maxRedirects: 3,
          sendUserAgent: true,
          timeout: const Duration(seconds: 5),
          userAgent: 'getx-client',
          withCredentials: false,
          baseUrl: path,
          headers: headers,
        ) {
    _headers = headers ??
        {
          "accept": "application/scim+json",
        };
  }

  Map<String, String> get getHeaders => _headers ?? {};

  set setHeaders(Map<String, String> newHeaders) {
    _headers = newHeaders;
  }

  /*getRoles(String clientId, String clientSecret) {}

  //
  Future<Either<Exception, Map?>> me(
      String clientId, String clientSecret) async {
    String url = "/Me";
    final sysStore = StoreService().getStore("system");
    Map<String, String> headers = await HeaderRequestImpl(
      headers: _headers!,
      idpKey: sysStore.get("defaultIdpKey", "identity"),
    ).getHeaders();

    info("Url SCIM2=> $baseUrl$url");
    final resp = await processResponse(
      get(
        url,
        headers: headers,
        decoder: (map) {
          log(map);
        },
      ),
      provider: this,
    );
    return resp.fold((l) => Left(l), (resp) {
      return Right(resp.body); 
    });
  }*/
}

class Scim2ManagerService {
  static final Scim2ManagerService _singleton = Scim2ManagerService._internal(
    path: PathsService.identityHost,
  );

  String path;
  late List<Scim2ApiService> _scim2Services;
  late Scim2GroupService _groupService;
  late Scim2MeService _meService;
  late Scim2UserService _userService;
  late Scim2RoleService _roleService;
  late Scim2PermissionService _permissionService;
  //
  factory Scim2ManagerService() {
    return _singleton;
  }

  Scim2ManagerService._internal({
    required this.path,
  }) {
    initServices({});
  }
  Scim2ManagerService initServices(
    Map<String, String>? headers,
  ) {
    final himpl = HeaderRequestImpl(
      idpKey: defaultIdpKey,
    );
    himpl
        .getHeaders(
          forceAuthorization: true,
        )
        .then((value) => _initSync);
    _initSync(headers);
    return this;
  }

  _initSync(Map<String, String>? headers) {
    _groupService = Scim2GroupService(
      path: path,
      headers: headers,
    );
    _meService = Scim2MeService(
      path: path,
      headers: headers,
    );
    _userService = Scim2UserService(
      path: path,
      headers: headers,
    );
    _roleService = Scim2RoleService(
      path: path,
      headers: headers,
    );
    _permissionService = Scim2PermissionService(
      path: path,
      headers: headers,
    );
    _scim2Services = List.from([
      _groupService,
      _meService,
      _userService,
      _roleService,
      _permissionService,
    ]);
  }
}

class Scim2MeService extends Scim2UserService {
  @override
  final String _baseUrl; // = 'https://example.com/scim/v2/Me';

  Scim2MeService({
    required String path,
    Map<String, String>? headers,
  })  : _baseUrl = path,
        super(
          path: path,
          headers: headers,
        );

  /// Elimina el usuario autenticado actualmente.
  Future<void> deleteMe() async {
    final headers = getHeaders;

    final response = await http.delete(Uri.parse(_baseUrl), headers: headers);

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar el usuario.');
    }
  }

  /// Obtiene la información del usuario autenticado actualmente.
  Future<Map<String, dynamic>> getMe() async {
    final headers = getHeaders;

    final response = await http.get(Uri.parse(_baseUrl), headers: headers);
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('Error al obtener información del usuario.');
    }
  }

  /// Actualiza parcialmente la información del usuario autenticado actualmente.
  Future<void> patchMe(List<Map<String, dynamic>> patches) async {
    final headers = getHeaders;

    final response = await http.patch(Uri.parse(_baseUrl),
        headers: headers, body: jsonEncode(patches));

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar información del usuario.');
    }
  }

  /// Actualiza la información del usuario autenticado actualmente.
  Future<void> updateMe(Map<String, dynamic> updates) async {
    final headers = getHeaders;

    final response = await http.put(Uri.parse(_baseUrl),
        headers: headers, body: jsonEncode(updates));

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar información del usuario.');
    }
  }
}

class Scim2PermissionService extends Scim2Impl {
  final String _baseUrl; // = 'https://example.com/scim/v2';
  Scim2PermissionService({
    required String path,
    Map<String, String>? headers,
  })  : _baseUrl = path,
        super(
          path: path,
          headers: headers,
        );

  /// Agrega un permiso a un atributo específico.
  Future<void> addPermissionToAttribute(String resourceType, String schemaId,
      String attributeId, String permissionValue,
      {String? description}) async {
    final headers = getHeaders;

    final patch = [
      {
        'op': 'add',
        'value': {'value': permissionValue, 'description': description}
      }
    ];

    final response = await http.patch(
        Uri.parse(
            '$_baseUrl/ResourceTypes/$resourceType/schemas/$schemaId/attributes/$attributeId/permissions'),
        headers: headers,
        body: jsonEncode(patch));

    if (response.statusCode != 204) {
      throw Exception('Error al agregar el permiso al atributo.');
    }
  }

  /// Agrega un permiso a un recurso específico.
  Future<void> addPermissionToResource(
      String resourceType, String resourceId, String permissionValue,
      {String? description}) async {
    final headers = getHeaders;

    final patch = [
      {
        'op': 'add',
        'value': {'value': permissionValue, 'description': description}
      }
    ];

    final response = await http.patch(
        Uri.parse('$_baseUrl/$resourceType/$resourceId'),
        headers: headers,
        body: jsonEncode(patch));

    if (response.statusCode != 200) {
      throw Exception('Error al agregar el permiso al recurso.');
    }
  }

  /// Obtiene los permisos para un atributo específico.
  Future<List<Map<String, dynamic>>?> getPermissionsForAttribute(
      String resourceType, String schemaId, String attributeId) async {
    final headers = getHeaders;

    final response = await http.get(
        Uri.parse(
            '$_baseUrl/ResourceTypes/$resourceType/schemas/$schemaId/attributes/$attributeId/permissions'),
        headers: headers);

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(parsed['permissions']);
    } else {
      throw Exception('Error al obtener los permisos para el atributo.');
    }
  }

  /// Obtiene los permisos para un recurso específico.
  Future<List<Map<String, dynamic>>>? getPermissionsForResource(
      String resourceType, String resourceId) async {
    final headers = getHeaders;

    final response = await http.get(
        Uri.parse('$_baseUrl/$resourceType/$resourceId'),
        headers: headers);

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(parsed['permissions']);
    } else {
      throw Exception('Error al obtener los permisos para el recurso.');
    }
  }

  /// Elimina un permiso de un atributo específico.
  Future<void> removePermissionFromAttribute(String resourceType,
      String schemaId, String attributeId, String permissionValue) async {
    final headers = getHeaders;

    final patch = [
      {'op': 'remove', 'path': '/permissions[value="$permissionValue"]'}
    ];

    final response = await http.patch(
        Uri.parse(
            '$_baseUrl/ResourceTypes/$resourceType/schemas/$schemaId/attributes/$attributeId/permissions'),
        headers: headers,
        body: jsonEncode(patch));

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar el permiso del atributo.');
    }
  }

  /// Elimina un permiso de un recurso específico.
  Future<void> removePermissionFromResource(
      String resourceType, String resourceId, String permissionValue) async {
    final headers = getHeaders;

    final patch = [
      {'op': 'remove', 'path': '/permissions[value="$permissionValue"]'}
    ];

    final response = await http.patch(
        Uri.parse('$_baseUrl/$resourceType/$resourceId'),
        headers: headers,
        body: jsonEncode(patch));

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el permiso del recurso.');
    }
  }
}

class Scim2RoleService extends Scim2Impl {
  final String _baseUrl; // = 'https://example.com/scim/v2/Roles';

  Scim2RoleService({
    required String path,
    Map<String, String>? headers,
  })  : _baseUrl = path,
        super(
          path: path,
          headers: headers,
        );

  /// Agrega un permiso a un rol.
  Future<void> addPermissionToRole(String roleId, String permissionId) async {
    final headers = getHeaders;

    final patch = [
      {
        'op': 'add',
        'path': '/permissions/-',
        'value': {'value': permissionId}
      }
    ];

    final response = await http.patch(Uri.parse('$_baseUrl/$roleId'),
        headers: headers, body: jsonEncode(patch));

    if (response.statusCode != 200) {
      throw Exception('Error al agregar el permiso al rol.');
    }
  }

  /// Agrega un usuario a un rol.
  Future<void> addUserToRole(String roleId, String userId) async {
    final headers = getHeaders;

    final patch = [
      {
        'op': 'add',
        'path': '/members/-',
        'value': {'value': userId}
      }
    ];

    final response = await http.patch(Uri.parse('$_baseUrl/$roleId'),
        headers: headers, body: jsonEncode(patch));

    if (response.statusCode != 200) {
      throw Exception('Error al agregar el usuario al rol.');
    }
  }

  /// Crea un nuevo rol.
  Future<Map<String, dynamic>> createRole(Map<String, dynamic> role) async {
    final headers = getHeaders;

    final response = await http.post(Uri.parse(_baseUrl),
        headers: headers, body: jsonEncode(role));
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return responseBody;
    } else {
      throw Exception('Error al crear el rol.');
    }
  }

  /// Elimina un rol por ID.
  Future<void> deleteRole(String roleId) async {
    final headers = getHeaders;

    final response =
        await http.delete(Uri.parse('$_baseUrl/$roleId'), headers: headers);

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar el rol.');
    }
  }

  /// Obtiene un rol por ID.
  Future<Map<String, dynamic>> getRole(String roleId) async {
    final headers = getHeaders;

    final response =
        await http.get(Uri.parse('$_baseUrl/$roleId'), headers: headers);
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('Error al obtener el rol.');
    }
  }

  /// Obtiene la lista de roles.
  Future<List<Map<String, dynamic>>> listRoles() async {
    final headers = getHeaders;

    final response = await http.get(Uri.parse(_baseUrl), headers: headers);
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final roles = responseBody['Resources'] as List<dynamic>;
      return roles
          .map<Map<String, dynamic>>((role) => role as Map<String, dynamic>)
          .toList();
    } else {
      throw Exception('Error al obtener la lista de roles.');
    }
  }

  /// Actualiza parcialmente un rol por ID.
  Future<void> patchRole(
      String roleId, List<Map<String, dynamic>> patches) async {
    final headers = getHeaders;

    final response = await http.patch(Uri.parse('$_baseUrl/$roleId'),
        headers: headers, body: jsonEncode(patches));

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el rol.');
    }
  }

  /// Actualiza un rol por ID.
  Future<void> updateRole(String roleId, Map<String, dynamic> updates) async {
    final headers = getHeaders;

    final response = await http.put(Uri.parse('$_baseUrl/$roleId'),
        headers: headers, body: jsonEncode(updates));

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el rol.');
    }
  }
}

class Scim2UserService extends Scim2Impl {
  final String _baseUrl; // = 'https://example.com/scim/v2/Users';
  //
  Scim2UserService({
    required String path,
    Map<String, String>? headers,
  })  : _baseUrl = path,
        super(
          path: path,
          headers: headers,
        );

  /// Crea un nuevo usuario.
  Future<Map<String, dynamic>> createUser(Map<String, dynamic> user) async {
    final headers = getHeaders;

    final response = await http.post(Uri.parse(_baseUrl),
        headers: headers, body: jsonEncode(user));
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return responseBody;
    } else {
      throw Exception('Error al crear el usuario.');
    }
  }

  /// Elimina un usuario por ID.
  Future<void> deleteUser(String userId) async {
    final headers = getHeaders;

    final response =
        await http.delete(Uri.parse('$_baseUrl/$userId'), headers: headers);

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar el usuario.');
    }
  }

  /// Obtiene un usuario por ID.
  Future<Map<String, dynamic>> getUser(String userId) async {
    final headers = getHeaders;

    final response =
        await http.get(Uri.parse('$_baseUrl/$userId'), headers: headers);
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('Error al obtener el usuario.');
    }
  }

  /// Obtiene la lista de usuarios.
  Future<List<Map<String, dynamic>>> listUsers() async {
    final headers = getHeaders;

    final response = await http.get(Uri.parse(_baseUrl), headers: headers);
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final users = responseBody['Resources'] as List<dynamic>;
      return users
          .map<Map<String, dynamic>>((user) => user as Map<String, dynamic>)
          .toList();
    } else {
      throw Exception('Error al obtener la lista de usuarios.');
    }
  }

  /// Actualiza parcialmente un usuario por ID.
  Future<void> patchUser(
      String userId, List<Map<String, dynamic>> patches) async {
    final headers = getHeaders;

    final response = await http.patch(Uri.parse('$_baseUrl/$userId'),
        headers: headers, body: jsonEncode(patches));

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el usuario.');
    }
  }

  /// Actualiza un usuario por ID.
  Future<void> updateUser(String userId, Map<String, dynamic> updates) async {
    final headers = getHeaders;

    final response = await http.put(Uri.parse('$_baseUrl/$userId'),
        headers: headers, body: jsonEncode(updates));

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el usuario.');
    }
  }
}
