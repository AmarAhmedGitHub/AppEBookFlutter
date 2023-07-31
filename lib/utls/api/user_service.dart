import 'dart:convert';
import 'dart:io';
import 'package:library/Model/BookModle/BookModle.dart';
import 'package:library/Model/EBookModel/EBookModel.dart';
import 'package:library/Model/Order.dart';
import 'package:library/Model/ProjectModel/CategoryProject.dart';
import 'package:library/Model/user.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_response.dart';
import 'constant.dart';

// login
Future<ApiResponse> login(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(loginURL),
        headers: {'Accept': 'application/json'},
        body: {'username': email, 'password': password});

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        print(response.body);
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

// Register
Future<ApiResponse> register(String name, String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(registerURL), headers: {
      'Accept': 'application/json'
    }, body: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// User
Future<ApiResponse> getUserDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(userURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// Update user
Future<ApiResponse> updateUser(String name, String OldPass, String NewPass,
    String conNewpass, String? image) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();

    final response = await http.post(Uri.parse(editprofile),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: image == null
            ? {
                'username': name,
                'old_password': OldPass,
                'new_password': NewPass,
                'confirm_password': conNewpass,
              }
            : {
                'username': name,
                'old_password': OldPass,
                'new_password': NewPass,
                'confirm_password': conNewpass,
                'image': image
              });
    // user can update his/her name or name and image

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        print(apiResponse.data);
        break;
      case 401:
        apiResponse.error = 'unauthorized';
//        print('unauthorized');
        break;
      default:
        //      print(response.body);
        apiResponse.error = jsonDecode(response.body)['errors'];
        //    print('somethingWentWrong');
        break;
    }
  } catch (e) {
    apiResponse.error = 'serverError';
    print(e);
  }
  return apiResponse;
}

String? getStringImage(File? file) {
  if (file == null) return null;
  return base64Encode(file.readAsBytesSync());
}

// get token
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

Future<String> getUsername() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('username') ?? '';
}

Future<String> getImage() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('image') ?? '';
}

// get user id
Future<int> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userId') ?? 0;
}

// logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove('token');
}

Future<ApiResponse> showCatog() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(categorieURl),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['category']
            .map((p) => BookCategory.fromJson(p))
            .toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> showCatogProject() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(categorieProjectURl),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['category']
            .map((p) => ProjectCategory.fromJson(p))
            .toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> showCatogEbook() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(categorieEbookURl),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['category']
            .map((p) => CategoryEBook.fromJson(p))
            .toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data as List<dynamic>;
        //print(response.body);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        //print(response.body);

        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
    //print(e);
  }
  return apiResponse;
}

// Future<ApiResponse> getBooks() async {
//   ApiResponse apiResponse = ApiResponse();
//   try {
//     String token = await getToken();
//     final response = await http.get(Uri.parse(categorieURl), headers: {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token'
//     });
//     switch (response.statusCode) {
//       case 200:
//         apiResponse.data = jsonDecode(response.body)['category']
//             .map((p) => BookCategory.fromJson(p))
//             .toList();
//         // we get list of posts, so we need to map each item to post model
//         apiResponse.data as List<dynamic>;
//         break;
//       case 401:
//         apiResponse.error = unauthorized;
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//         break;
//     }
//   } catch (e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }
Future<ApiResponse> downloadBooks(String path, String name) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(downlodURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'path': path
    });

    switch (response.statusCode) {
      case 200:
        print('sssss');
        //print(response.bodyBytes);
        String dir = '';
        if (Platform.isAndroid) {
          dir = '/sdcard/download/';
          print('object');
        } else {
          dir = (await getApplicationDocumentsDirectory()).path;
        }
        File file = new File(dir + '/' + name + '.pdf');
        if (!await file.exists()) {
          await file.create();
        }
        await file.writeAsBytes(response.bodyBytes);

        break;
      case 401:
        apiResponse.error = unauthorized;
        print('xxxx');
        break;
      default:
        apiResponse.error = somethingWentWrong;
        //      print(response.body);
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
    print('x');
  }
  return apiResponse;
  //  print(e);
}

Future searchBook(String query) async {
  var apiResponse;
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(searchURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'query': query
    });

    switch (response.statusCode) {
      case 200:
        apiResponse =
            jsonDecode(response.body).map((p) => Book.fromJson(p)).toList();

        // we get list of posts, so we need to map each item to post model
        //apiResponse.data as List<dynamic>;
        print('object 2');
        break;
      case 401:
        apiResponse = 'unauthorized';
        print('unauthorized 2');
        break;
      default:
        apiResponse = 'somethingWentWrong';
        //  print('somethingWentWrong 2');
//        print(response.body);

        break;
    }
  } catch (e) {
    apiResponse = 'serverError';
    print("------------------------------------------------");
    print(e);

    print("-------------------------------");

    print("arkan");
  }
  return apiResponse;
}

Future searchEBook(String query) async {
  var apiResponse;
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(searchEbookURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'query': query
    });

    switch (response.statusCode) {
      case 200:
        apiResponse =
            jsonDecode(response.body).map((p) => EBook.fromJson(p)).toList();

        // we get list of posts, so we need to map each item to post model
        //apiResponse.data as List<dynamic>;
        print('object 2');
        break;
      case 401:
        apiResponse = 'unauthorized';
        print('unauthorized 2');
        break;
      default:
        apiResponse = 'somethingWentWrong';
        //  print('somethingWentWrong 2');
//        print(response.body);

        break;
    }
  } catch (e) {
    apiResponse = 'serverError';
    print(e);
    print("arkan");
  }
  return apiResponse;
}

Future searchProject(String query) async {
  var apiResponse;
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(searchProjectURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'query': query
    });

    switch (response.statusCode) {
      case 200:
        apiResponse =
            jsonDecode(response.body).map((p) => Project.fromJson(p)).toList();

        // we get list of posts, so we need to map each item to post model
        //apiResponse.data as List<dynamic>;
        print('object 2');
        break;
      case 401:
        apiResponse = 'unauthorized';
        print('unauthorized 2');
        break;
      default:
        apiResponse = 'somethingWentWrong';
        //  print('somethingWentWrong 2');
//        print(response.body);

        break;
    }
  } catch (e) {
    apiResponse = 'serverError';
    print(e);
    print("arkan");
  }
  return apiResponse;
}

Future<ApiResponse> getAllProject() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(getallProjectURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        // we get list of posts, so we need to map each item to post model
        //apiResponse.data as List<dynamic>;
        print('object');
        break;
      case 401:
        apiResponse.error = 'unauthorized';
        print('unauthorized');
        break;
      default:
        apiResponse.error = 'somethingWentWrong';
        print('somethingWentWrong');
        print(response.body);
        break;
    }
  } catch (e) {
    apiResponse.error = 'serverError';
    print(e);
  }
  return apiResponse;
}

Future<ApiResponse> getAllEBook() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(getallEBookURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        // we get list of posts, so we need to map each item to post model
        //apiResponse.data as List<dynamic>;
        print('object');
        break;
      case 401:
        apiResponse.error = 'unauthorized';
        print('unauthorized');
        break;
      default:
        apiResponse.error = 'somethingWentWrong';
        print('somethingWentWrong');
        print(response.body);
        break;
    }
  } catch (e) {
    apiResponse.error = 'serverError';
    print(e);
  }
  return apiResponse;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Future<ApiResponse> getAllBook() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(getallBookURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        // we get list of posts, so we need to map each item to post model
        //apiResponse.data as List<dynamic>;
        print('object');
        break;
      case 401:
        apiResponse.error = 'unauthorized';
        print('unauthorized');
        break;
      default:
        apiResponse.error = 'somethingWentWrong';
        print('somethingWentWrong');
        // print(response.body);
        break;
    }
  } catch (e) {
    apiResponse.error = 'serverError';
    //print(e);
  }
  return apiResponse;
}

Future<ApiResponse> getOrders() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();

    final response = await http.get(Uri.parse(getorder), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['order']
            .map((p) => Order.fromJson(p))
            .toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data as List<dynamic>;
        print('success');
        break;
      case 401:
        apiResponse.error = 'unauthorized';
        break;
      default:
        apiResponse.error = 'somethingWentWrong';
        //print(response.body);
        break;
    }
  } catch (e) {
    apiResponse.error = 'serverError';
    print('error');
  }
  return apiResponse;
}

Future<ApiResponse> getNotifications() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();

    final response = await http.get(
      Uri.parse(getnotifications),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        // we get list of posts, so we need to map each item to post model
        apiResponse.data as List<dynamic>;
        print('aaa');
        //print(response.body);
        break;
      case 401:
        apiResponse.error = 'unauthorized';
        print('unauthorized');
        break;
      default:
        apiResponse.error = 'somethingWentWrong';
        print('somethingWentWrong  getNotifications is Empty');
        //  print(response.body);
        break;
    }
  } catch (e) {
    apiResponse.error = 'serverError';
    print(e);
  }
  return apiResponse;
}

Future<ApiResponse> makeAsReadNotifications() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();

    final response = await http.get(
      Uri.parse(makereadnotifications),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        print('Make');
        //print(response.body);
        break;
      case 401:
        apiResponse.error = 'unauthorized';
        print('unauthorized');
        break;
      default:
        apiResponse.error = 'somethingWentWrong';
        print('somethingWentWrong');
        break;
    }
  } catch (e) {
    apiResponse.error = 'serverError';
    print(e);
  }
  return apiResponse;
}
