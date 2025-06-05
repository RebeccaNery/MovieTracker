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

  Future<Filme?> update(Filme filme) async {
    if (filme.id == null) {
      // Assumindo que filme.id é String? para o ID da API
      print(
        "[API UPDATE] Erro: ID do filme é nulo ou vazio. Impossível atualizar.",
      );
      return null;
    }

    final Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      ...(FilmeApiConfig.headers), // Usa os headers da config
      'Content-Type': 'application/json; charset=UTF-8', // Garante Content-Type
    };

    try {
      String corpoJson = jsonEncode(
        filme.toJson(),
      ); // toJson() não deve incluir o id se ele já está na URL
      print(
        "[API UPDATE] Enviando JSON para API (filme ID: ${filme.id}): $corpoJson",
      );

      final response = await http.put(
        Uri.parse("${FilmeApiConfig.url}/filmes/${filme.id}"),
        // Envia o ID na URL
        headers: requestHeaders,
        body: corpoJson,
      );

      if (response.statusCode == 200) {
        // 200 OK para PUT bem-sucedido
        print("[API UPDATE] Filme atualizado na API: ${response.body}");
        return Filme.fromJson(jsonDecode(response.body));
      } else {
        print(
          "[API UPDATE] Erro ao atualizar filme na API: ${response.statusCode} - ${response.body}",
        );
        return null;
      }
    } catch (e) {
      print("[API UPDATE] Exceção ao tentar atualizar filme na API: $e");
      return null;
    }
  }

  Future<bool> delete(int? id) async {
    final response = await http.delete(
      Uri.parse("${FilmeApiConfig.url}/filmes/$id"),
      headers: FilmeApiConfig.headers,
    );
    if (response.statusCode == 200) {
      print("[API DELETE] Filme deletado com sucesso na API: $id");
      return true;
    } else {
      print(
        "[API DELETE] Erro ao deletar filme na API: ${response.statusCode} - ${response.body}",
      );
      return false;
    }
  }
}
