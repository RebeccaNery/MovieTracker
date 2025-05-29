import 'package:flutter/material.dart';
import '../view/listar_filmes.dart';
import 'theme.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "🎬 MyMovieTracker 🎬",
      debugShowCheckedModeBanner: false,
      theme: temaFilmesDark,
      home: ListarFilmes(),

    );
  }
}
