import 'package:flutter/material.dart';

class ListarFilmes extends StatefulWidget {
  const ListarFilmes({super.key});

  @override
  State<ListarFilmes> createState() => _ListarFilmesState();
}

class _ListarFilmesState extends State<ListarFilmes> {
  List<Filme> _filmes = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Filmes"),
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
    return ListTile(
      leading: Image.network(_filmes[index].urlImagem),
      title: Text(_filmes[index].titulo),
      subtitle: Column(
        children: [
          Text(_filmes[index].genero),
          Text(_filmes[index].ano),
        ],
      ),
      trailing: Icon(Icons.star),
    );
  }
}
