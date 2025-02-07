import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/Model/MovieModel.dart';

class ApiServices{
  Future<MovieModel> MoviesData()async{
 final response = await http.get(Uri.parse('https://www.omdbapi.com/?i=tt3896198&apikey=9c69f4e2'));
 if(response.statusCode==200){
   return MovieModel.fromJson(jsonDecode(response.body));
 }else{
    throw Exception(' Something is else');
 }
  }

}