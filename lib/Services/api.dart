import 'dart:convert';

import 'package:http/http.dart' as http;

const String endpoint = 'https://flutr.fundy.cf';
const Map<String, String> headers = <String, String>{
  "Content-Type": "application/json"
};

Future<http.Response> signup(String email, String password) {
  final String body = jsonEncode(<String, Map<String, String>>{
    'data': <String, String>{
      'email': email,
      'password': password,
    }
  });

  return http.post(
    Uri.parse("$endpoint/auth/signin"),
    headers: headers,
    body: body,
  );
}

Future<http.Response> signin(
  String email,
  String password,
  String firstname,
  String lastname,
) {
  final String body = jsonEncode(<String, Map<String, String>>{
    'data': <String, String>{
      'email': email,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
    }
  });

  return http.post(
    Uri.parse("$endpoint/auth/signup"),
    headers: headers,
    body: body,
  );
}

Future<http.Response> signout() {
  return http.delete(Uri.parse("$endpoint/auth/signout"), headers: headers);
}

// Future<http.Response> forgotPassword() {
//   return http.get(
// Uri.parse("$endpoint/"),
// headers: headers,
// );
// }

Future<http.Response> getUser() {
  return http.get(Uri.parse("$endpoint/users/me"), headers: headers);
}

// Future<http.Response> editUser() {
//   return http.get(
// Uri.parse("$endpoint/users/me"),
// headers: headers,
// );
// }

Future<http.Response> newConversation(String userId) {
  final String body = jsonEncode(<String, Map<String, List<String>>>{
    'data': <String, List<String>>{
      'Users': <String>[userId]
    }
  });

  return http.post(
    Uri.parse("$endpoint/conversations"),
    headers: headers,
    body: body,
  );
}

Future<http.Response> getAllConversations() {
  return http.get(Uri.parse("$endpoint/conversations"), headers: headers);
}

Future<http.Response> getOneConversation(String id) {
  return http.get(Uri.parse("$endpoint/conversations/$id"), headers: headers);
}

Future<http.Response> handleMember(String id, String userId) {
  final String body = jsonEncode(<String, Map<String, String>>{
    'data': <String, String>{
      'userId': userId,
    }
  });

  return http.patch(
    Uri.parse("$endpoint/conversations/$id"),
    headers: headers,
    body: body,
  );
}

Future<http.Response> newMessage(String conversationId, String content) {
  final String body = jsonEncode(<String, Map<String, String>>{
    'data': <String, String>{
      'content': content,
      'conversationId': conversationId
    }
  });
  return http.post(
    Uri.parse("$endpoint/messages"),
    headers: headers,
    body: body,
  );
}

Future<http.Response> deleteMessage(String id) {
  return http.delete(Uri.parse("$endpoint/messages/$id"), headers: headers);
}
