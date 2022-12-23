import 'dart:convert';
import 'package:http/http.dart' as http;

const String endpoint = 'https://flutr.fundy.cf';

Future<http.Response> signup(
  String email,
  String password,
  Map<String, String> headers,
) async {
  final String body = jsonEncode(<String, Map<String, String>>{
    'data': <String, String>{
      'email': email,
      'password': password,
    }
  });

  final http.Response response = await http.post(
    Uri.parse("$endpoint/auth/signin"),
    headers: headers,
    body: body,
  );
  return response;
}

Future<http.Response> signin(
  String email,
  String password,
  String firstname,
  String lastname,
  Map<String, String> headers,
) async {
  final String body = jsonEncode(<String, Map<String, String>>{
    'data': <String, String>{
      'email': email,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
    }
  });

  final http.Response response = await http.post(
    Uri.parse("$endpoint/auth/signup"),
    headers: headers,
    body: body,
  );
  return response;
}

Future<http.Response> signout(
  Map<String, String> headers,
) async {
  final http.Response response =
      await http.delete(Uri.parse("$endpoint/auth/signout"), headers: headers);
  return response;
}

// Future<http.Response> forgotPassword() {
// Uri.parse("$endpoint/"),
// headers: headers,
// );
// }

Future<http.Response> getUser(
  String firstname,
  String lastname,
  Map<String, String> headers,
) async {
  final http.Response response = await http.get(
    Uri.parse("$endpoint/users/$firstname:$lastname"),
    headers: headers,
  );
  return response;
}

Future<http.Response> getMe(
  Map<String, String> headers,
) async {
  final http.Response response =
      await http.get(Uri.parse("$endpoint/users/me"), headers: headers);
  return response;
}

Future<http.Response> getAllUsers(
  Map<String, String> headers,
) async {
  final http.Response response =
      await http.get(Uri.parse("$endpoint/users/"), headers: headers);
  return response;
}

// Future<http.Response> editUser() {
//   http.Response response = await http.get(
// Uri.parse("$endpoint/users/me"),
// headers: headers,
// );
// }

Future<http.Response> newConversation(
  String userId,
  Map<String, String> headers,
) async {
  final String body = jsonEncode(<String, Map<String, List<String>>>{
    'data': <String, List<String>>{
      'Users': <String>[userId]
    }
  });

  final http.Response response = await http.post(
    Uri.parse("$endpoint/conversations"),
    headers: headers,
    body: body,
  );
  return response;
}

Future<http.Response> getAllConversations(
  Map<String, String> headers,
) async {
  final http.Response response =
      await http.get(Uri.parse("$endpoint/conversations"), headers: headers);
  return response;
}

Future<http.Response> getOneConversation(
  String id,
  Map<String, String> headers,
) async {
  final http.Response response = await http
      .get(Uri.parse("$endpoint/conversations/$id"), headers: headers);
  return response;
}

Future<http.Response> handleMember(
  String id,
  String userId,
  Map<String, String> headers,
) async {
  final String body = jsonEncode(<String, Map<String, String>>{
    'data': <String, String>{
      'userId': userId,
    }
  });

  final http.Response response = await http.patch(
    Uri.parse("$endpoint/conversations/$id"),
    headers: headers,
    body: body,
  );
  return response;
}

Future<http.Response> newMessage(
  String conversationId,
  String content,
  Map<String, String> headers,
) async {
  final String body = jsonEncode(<String, Map<String, String>>{
    'data': <String, String>{
      'content': content,
      'conversationId': conversationId
    }
  });
  final http.Response response = await http.post(
    Uri.parse("$endpoint/messages"),
    headers: headers,
    body: body,
  );

  return response;
}

Future<http.Response> deleteMessage(
  String id,
  Map<String, String> headers,
) async {
  final http.Response response =
      await http.delete(Uri.parse("$endpoint/messages/$id"), headers: headers);
  return response;
}
