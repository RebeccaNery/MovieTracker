import 'package:flutter/material.dart';
import '../model/filme.dart';

class DetalheFilme extends StatefulWidget {
  final Filme filme;
  const DetalheFilme({super.key, required this.filme});

  @override
  State<DetalheFilme> createState() => _DetalheFilmeState();
}

class _DetalheFilmeState extends State<DetalheFilme> {
  late Filme _filme;

  @override
  void initState(){
    super.initState();
    _filme = widget.filme;
  }

  @override
  Widget build(BuildContext context) {
    final double numEstrelas = (_filme.pontuacao/10 * 5);
    return Scaffold(
      appBar: AppBar(
        title: Text(_filme.titulo),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(_filme.urlImagem, width: 200,),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
              SizedBox(height: 20,),
              Text(_filme.titulo, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
              SizedBox(height: 20,),
              Text(_filme.genero),
              SizedBox(height: 20,),
              Text(_filme.descricao)
            ],)

            ),
          ],
        ),
      )
    );
  }
}
