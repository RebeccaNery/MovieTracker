import 'package:flutter/material.dart';
import 'package:movie_tracker/view/detalhar_filme.dart';
import '../model/filme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListarFilmes extends StatefulWidget {
  const ListarFilmes({super.key});

  @override
  State<ListarFilmes> createState() => _ListarFilmesState();
}

class _ListarFilmesState extends State<ListarFilmes> {
  final List<Filme> _filmes = [Filme(
    id: 1,
    titulo: 'A Origem',
    urlImagem: 'https://upload.wikimedia.org/wikipedia/pt/8/84/AOrigemPoster.jpg',
    genero: 'Ficção Científica',
    faixaEtaria: '12 anos',
    duracao: '2h 28min',
    pontuacao: 9,
    descricao: 'Um ladrão que rouba segredos corporativos por meio da tecnologia de compartilhamento de sonhos é encarregado de plantar uma ideia na mente de um C.E.O.',
    ano: '2010',
  ),
    Filme(
      id: 2,
      titulo: 'Interestelar',
      urlImagem: 'https://m.media-amazon.com/images/M/MV5BMmUwMmFlMzktYWVlNy00N2I0LWFhMTYtZWI2ZTM4N2I3ZTk0XkEyXkFqcGc@._V1_.jpg',
      genero: 'Ficção Científica',
      faixaEtaria: '10 anos',
      duracao: '2h 49min',
      pontuacao: 8,
      descricao: 'Uma equipe de exploradores viaja através de um buraco de minhoca no espaço na tentativa de garantir a sobrevivência da humanidade.',
      ano: '2014',
    ),
    Filme(
      id: 3,
      titulo: 'Clube da Luta',
      urlImagem: 'https://br.web.img3.acsta.net/medias/nmedia/18/90/95/96/20122166.jpg',
      genero: 'Drama',
      faixaEtaria: '18 anos',
      duracao: '2h 19min',
      pontuacao: 3,
      descricao: 'Um homem insatisfeito com a vida e com seu trabalho encontra um novo sentido ao participar de um clube de luta underground.',
      ano: '1999',
    )];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filmes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Informações do Desenvolvedor'),
                    content: const Text('Desenvolvido por: Anita Donato, Rebecca Nery e Ruan Vitor'),
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
            }
          )]
      ),
      body: ListView.builder(itemCount: _filmes.length,itemBuilder: (context, index){
        return buildItemList(index);
      }),
      /*floatingActionButton: FloatingActionButton(
          onPressed: (

          )),*/
    );
  }

  Widget buildItemList(int index){

    final double numEstrelas = (_filmes[index].pontuacao/10 * 5);

    return GestureDetector(
      onTap: (){
        final Filme filmeClicado = _filmes[index];
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetalheFilme(filme: filmeClicado),),);},
      child: Card(
        margin: EdgeInsets.all(8.0),
        elevation: 4,
        child: SizedBox(
          height: 200,
          child: Row(
            children: [
              Container(margin: EdgeInsets.all(5.0), child: Image.network(_filmes[index].urlImagem, width: 150,)),
              const SizedBox(width: 16),
              Container(margin: EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_filmes[index].titulo, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(_filmes[index].genero),
                    Text(_filmes[index].duracao),
                    const SizedBox(width: 8),
                    const Spacer(),
                    RatingBar.builder(itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber), onRatingUpdate: (rating){
                      print(rating);
                    }, ignoreGestures: true,
                      initialRating: numEstrelas, minRating: 0, direction: Axis.horizontal, allowHalfRating: true, itemCount: 5, itemSize: 20,),

                  ],
                ),
              )
              ]
          ),
        ),
      ),
    );
  }
}
