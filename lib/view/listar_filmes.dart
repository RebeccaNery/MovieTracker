import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_tracker/controller/filme_api_controller.dart';
import 'package:movie_tracker/view/detalhar_filme.dart';

import '../model/filme.dart';
import 'cadastrar_filme.dart';

class ListarFilmes extends StatefulWidget {
  const ListarFilmes({super.key});

  @override
  State<ListarFilmes> createState() => _ListarFilmesState();
}

class _ListarFilmesState extends State<ListarFilmes> {
  final _filmeApiController = FilmeApiController();
  Future<List<Filme>>? _listaDeFilmesFuture;

  @override
  void initState() {
    super.initState();
    _carregarFilmesDaApi();
  }

  void _carregarFilmesDaApi() {
    setState(() {
      _listaDeFilmesFuture = _filmeApiController.findAll();
    });
  }

  // Método para navegar para a tela de "Alterar" (Edição)
  void _navegarParaAlterarFilme(BuildContext parentContext, Filme filme) {
    Navigator.push(
      parentContext, // Usa o contexto que tem o Navigator correto
      MaterialPageRoute(
        // Você precisará adaptar CadastrarFilme para aceitar um filme para edição
        builder: (context) => CadastrarFilme(filmeParaEditar: filme),
      ),
    ).then((foiModificado) {
      // Se CadastrarFilme retornar true (ou qualquer valor que indique modificação), atualiza a lista
      if (foiModificado == true) {
        _carregarFilmesDaApi();
      }
    });
  }

  // Método para mostrar o menu de opções na parte inferior
  void _mostrarOpcoesDoFilme(BuildContext parentContext, Filme filme) {
    showModalBottomSheet(
      context: parentContext, // Contexto do ListarFilmes para o BottomSheet
      builder: (BuildContext sheetContext) {
        // Contexto interno do BottomSheet
        return SafeArea(
          // Garante que não fique sob elementos da UI do sistema
          child: Wrap(
            // Faz o BottomSheet se ajustar à altura do conteúdo
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.visibility),
                // Ícone para "Exibir Dados"
                title: const Text('Exibir Dados'),
                onTap: () {
                  Navigator.pop(sheetContext); // Fecha o BottomSheet
                  Navigator.push(
                    parentContext,
                    // Usa o contexto do ListarFilmes para navegar
                    MaterialPageRoute(
                      builder: (context) => DetalheFilme(filme: filme),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit), // Ícone para "Alterar"
                title: const Text('Alterar'),
                onTap: () {
                  Navigator.pop(sheetContext); // Fecha o BottomSheet
                  _navegarParaAlterarFilme(parentContext, filme);
                },
              ),
            ],
          ),
        );
      },
    );
  }

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
        future: _listaDeFilmesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final filmes = snapshot.data;
            return ListView.builder(
              itemCount: filmes!.length,
              itemBuilder: (itemBuilderContext, index) {
                return buildItemList(itemBuilderContext, filmes[index]);
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
          ).then((foiAdicionado) {
            if (foiAdicionado == true) {
              _carregarFilmesDaApi();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildItemList(BuildContext context, Filme filme) {
    final double numEstrelas = (filme.pontuacao / 10 * 5);

    return GestureDetector(
      onTap: () {
        _mostrarOpcoesDoFilme(context, filme);
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
                child: Image.network(
                  filme.urlImagem,
                  width: 150,
                  errorBuilder: (
                    BuildContext context,
                    Object exception,
                    StackTrace? stackTrace,
                  ) {
                    // Esta função é chamada se houver um erro ao carregar a imagem da rede
                    print(
                      "Erro ao carregar imagem da rede: ${filme.urlImagem}, Erro: $exception",
                    );
                    return Image.asset(
                      'assets/images/placeholder_filme.jpg',
                      // <<-- CAMINHO PARA SUA IMAGEM PADRÃO
                      width: 150,
                      fit:
                          BoxFit
                              .cover, // Para o placeholder também cobrir o espaço
                    );
                  },
                ),
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
