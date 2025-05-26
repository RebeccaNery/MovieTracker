import 'package:flutter/material.dart';
import '../view/detalhar_filme.dart';
import '../view/listar_filmes.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListarFilmes(),

    );
  }
}
