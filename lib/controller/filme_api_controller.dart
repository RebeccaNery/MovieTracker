import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movie_tracker/config/filme_api_config.dart';

import '../model/filme.dart';

class FilmeApiController {
  Future<List<Filme>> findAll() async {
    final response = await http.get(
      Uri.parse("${FilmeApiConfig.url}/filmes"),
      headers: FilmeApiConfig.headers,
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      List<Filme> filmes = [];
      for (var map in jsonData) {
        filmes.add(Filme.fromJson(map));
      }
      return filmes;
    } else {
      throw HttpException("Erro ao consultar filmes: ${response.statusCode}");
    }
  }
}
