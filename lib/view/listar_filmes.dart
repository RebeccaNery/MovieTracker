import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_tracker/controller/filme_api_controller.dart';
import 'package:movie_tracker/controller/filme_controller.dart';
import 'package:movie_tracker/view/detalhar_filme.dart';

import '../model/filme.dart';
import 'cadastrar_filme.dart';

class ListarFilmes extends StatefulWidget {
  const ListarFilmes({super.key});

  @override
  State<ListarFilmes> createState() => _ListarFilmesState();
}

class _ListarFilmesState extends State<ListarFilmes> {
  final _filmeController = FilmeController();

  //List<Filme> _filmes = [];

  /*@override
  void initState(){
    super.initState();
    _filmes = _filmeController.getFilmes();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Filmes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Informações do Desenvolvedor'),
                    content: const Text(
                      'Desenvolvido por: Anita Donato, Rebecca Nery e Ruan Vitor',
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Fecha o AlertDialog
                        },
                        child: const Text('Ok'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: FilmeApiController().findAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final filmes = snapshot.data;
            return ListView.builder(
              itemCount: filmes!.length,
              itemBuilder: (context, index) {
                return buildItemList(filmes[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const CadastrarFilme();
              },
            ),
          ).then((value) {
            setState(() {
              filmes = _filmeController.findAll();
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildItemList(Filme filme) {
    final double numEstrelas = (filme.pontuacao / 10 * 5);

    return GestureDetector(
      onTap: () {
        final Filme filmeClicado = filme;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalheFilme(filme: filmeClicado),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(8.0),
        elevation: 4,
        child: SizedBox(
          height: 200,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(5.0),
                child: Image.network(filme.urlImagem, width: 150),
              ),
              const SizedBox(width: 16),
              Container(
                margin: EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      filme.titulo,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(filme.genero),
                    Text(filme.duracao),

                    const Spacer(),
                    RatingBar.builder(
                      itemBuilder:
                          (context, _) =>
                              const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                      ignoreGestures: true,
                      initialRating: numEstrelas,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
