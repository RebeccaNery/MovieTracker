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

  Future<Filme> findById(int id) async {
    final response = await http.get(
      Uri.parse("${FilmeApiConfig.url}/filmes/$id"),
      headers: FilmeApiConfig.headers,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Filme.fromJson(jsonData);
    } else {
      throw HttpException("Erro ao consultar filme: ${response.statusCode}");
    }
  }

  Future<Filme?> save(Filme filme) async {
    // Retornar Filme? é uma boa prática
    // Os headers são diretamente da sua FilmeApiConfig.
    // FilmeApiConfig.headers já define "Content-Type": "application/json".
    final Map<String, String> requestHeaders = FilmeApiConfig.headers;

    try {
      // filme.toJson() deve retornar um Map<String, dynamic>
      // para ser enviado à API (sem o 'id' se for um novo filme e a API gerar o ID).
      String corpoJson = jsonEncode(filme.toJson());
      print("[API Controller - SAVE] Enviando JSON: $corpoJson");

      final response = await http.post(
        // Usa FilmeApiConfig.url e adiciona o endpoint /filmes
        Uri.parse("${FilmeApiConfig.url}/filmes"),
        headers: requestHeaders, // Usa os headers da FilmeApiConfig
        body: corpoJson,
      );

      if (response.statusCode == 201) {
        // 201 Created é o status para POST bem-sucedido
        print(
          "[API Controller - SAVE] Filme salvo com sucesso na API: ${response.body}",
        );
        final jsonData = jsonDecode(response.body);
        // A API mockapi.io geralmente retorna o objeto criado, incluindo o 'id' gerado por ela.
        return Filme.fromJson(jsonData);
      } else {
        print(
          "[API Controller - SAVE] Erro ao salvar filme na API: ${response.statusCode} - ${response.body}",
        );
        return null; // Ou lançar uma exceção, dependendo da sua estratégia de erro
      }
    } catch (e) {
      print(
        "[API Controller - SAVE] Exceção ao tentar salvar filme na API: $e",
      );
      return null; // Ou lançar uma exceção
    }
  }
}
