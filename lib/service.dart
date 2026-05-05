import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model.dart';



// class ApiService
// {
//   Future<List<dynamic>> fetchData() async
//   {
//
//     final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"),
//     headers: {
//       "Accept":"Application/json",
//     });
//     print("STATUS CODE: ${response.statusCode}");
//     print("BODY: ${response.body}");
//     if(response.statusCode == 200)
//       {
//          return jsonDecode(response.body);
//       }
//     else{
//       throw Exception('Failed to load data');
//     }
// }
// }



class ApiService {
  Future<List<DataModel>> fetchData() async {
    final result = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"), headers: {
      "Accept": "Application/json"
    });
    if (result.statusCode == 200) {
      List res = jsonDecode(result.body);

     return res.map((e) {
        return DataModel.fromJson(e);
        //return res.map((e) => DataModel.fromJson(e)).toList();


      }).toList();
    }

    else {
      throw Exception("Failed to load data");
    }
  }
}








