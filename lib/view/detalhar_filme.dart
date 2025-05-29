import 'package:flutter/material.dart';
import '../model/filme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,                children: [
                  Text(_filme.titulo, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                  Text(_filme.ano)
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_filme.genero), Text(_filme.faixaEtaria)
                ],
              ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_filme.duracao),
                      RatingBar.builder(itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber), onRatingUpdate: (rating){
                        print(rating);
                      }, ignoreGestures: true,
                        initialRating: numEstrelas, minRating: 0, direction: Axis.horizontal, allowHalfRating: true, itemCount: 5, itemSize: 20,),
                    ],
                  ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Expanded(child: Text(_filme.descricao)),
                ],
              )
            ],)

            ),
          ],
        ),
      )
    );
  }
}
