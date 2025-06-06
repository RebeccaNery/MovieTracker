import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../controller/filme_api_controller.dart';
import '../model/filme.dart';

class CadastrarFilme extends StatefulWidget {
  final Filme? filmeParaEditar;

  const CadastrarFilme({super.key, this.filmeParaEditar});

  @override
  State<CadastrarFilme> createState() => _CadastrarFilmeState();
}

class _CadastrarFilmeState extends State<CadastrarFilme> {
  final _key = GlobalKey<FormState>();
  final _edtTitulo = TextEditingController();
  final _edtUrlImagem = TextEditingController();
  final _edtDuracao = TextEditingController();
  final _edtDescricao = TextEditingController();
  final _edtAno = TextEditingController();
  final _filmeApiController = FilmeApiController();
  String? _generoSelecionado;
  final List<String> _opcoesDeGenero = [
    'Ação',
    'Aventura',
    'Comédia',
    'Drama',
    'Ficção Científica',
    'Romance',
    'Terror',
  ];
  String? _faixaEtariaSelecionada;
  final List<String> _opcoesDeFaixaEtaria = [
    'Livre',
    '10 anos',
    '12 anos',
    '14 anos',
    '16 anos',
    '18 anos',
  ];
  double _numEstrelas = 0.0;
  bool _modoEdicao = false;

  @override
  void initState() {
    super.initState();
    if (widget.filmeParaEditar != null) {
      _modoEdicao = true;
      // Preenche os campos com os dados do filme para edição
      _edtTitulo.text = widget.filmeParaEditar!.titulo;
      _edtUrlImagem.text = widget.filmeParaEditar!.urlImagem;
      _generoSelecionado = widget.filmeParaEditar!.genero;
      _faixaEtariaSelecionada = widget.filmeParaEditar!.faixaEtaria;
      _edtDuracao.text = widget.filmeParaEditar!.duracao;
      // A pontuação no filmeParaEditar está em 0-10, RatingBar é 0-5
      _numEstrelas = widget.filmeParaEditar!.pontuacao / 2;
      _edtDescricao.text = widget.filmeParaEditar!.descricao;
      _edtAno.text = widget.filmeParaEditar!.ano;
    }
  }

  @override
  void dispose() {
    // Limpa os controllers quando o widget for descartado
    _edtTitulo.dispose();
    _edtUrlImagem.dispose();
    _edtDuracao.dispose();
    _edtDescricao.dispose();
    _edtAno.dispose();
    super.dispose();
  }

  Future<void> _salvarOuAtualizarFilme() async {
    // Método refatorado
    try {
      if (!_key.currentState!.validate()) {
        print("[CADASTRO/EDIÇÃO] Formulário inválido.");
        return;
      }

      final double pontuacaoParaApi =
          _numEstrelas * 2; // Converte 0-5 para 0-10

      // Cria o objeto Filme com os dados atuais do formulário
      // Se estiver editando, o ID da API precisa ser mantido
      Filme filmeParaSalvar = Filme(
        id: _modoEdicao ? widget.filmeParaEditar!.id : null,
        // Mantém o ID da API se estiver editando
        titulo: _edtTitulo.text,
        urlImagem: _edtUrlImagem.text,
        genero: _generoSelecionado ?? "",
        faixaEtaria: _faixaEtariaSelecionada ?? "",
        duracao: _edtDuracao.text,
        pontuacao: pontuacaoParaApi,
        descricao: _edtDescricao.text,
        ano: _edtAno.text,
      );

      Filme? filmeProcessado;
      String mensagemSucesso;

      if (_modoEdicao) {
        print(
          "[EDIÇÃO] Tentando atualizar filme na API: ${filmeParaSalvar.titulo}",
        );
        filmeProcessado = await _filmeApiController.update(filmeParaSalvar);
        mensagemSucesso =
            "Filme '${filmeParaSalvar.titulo}' atualizado com sucesso na API!";
      } else {
        print(
          "[CADASTRO] Tentando salvar novo filme na API: ${filmeParaSalvar.titulo}",
        );
        filmeProcessado = await _filmeApiController.save(filmeParaSalvar);
        mensagemSucesso =
            "Filme '${filmeParaSalvar.titulo}' cadastrado com sucesso na API!";
      }

      if (filmeProcessado != null) {
        print(
          "[CADASTRO/EDIÇÃO] Operação na API bem-sucedida: ${filmeProcessado.titulo} (ID API: ${filmeProcessado.id})",
        );
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(mensagemSucesso)));
          Navigator.pop(
            context,
            true,
          ); // Passa true para indicar que houve modificação
        }
      } else {
        print("[CADASTRO/EDIÇÃO] Falha na operação com a API.");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Erro ao ${_modoEdicao ? 'atualizar' : 'cadastrar'} o filme na API.",
              ),
            ),
          );
        }
      }
    } catch (e) {
      print("[CADASTRO/EDIÇÃO] Ocorreu um erro: $e");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erro inesperado: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _modoEdicao ? "Editar Filme 📝" : "Cadastrar novo filme 🎬",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: _edtUrlImagem,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "URL para a imagem de capa",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo Obrigatório!";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _edtTitulo,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: "Título"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo Obrigatório!";
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                hint: Text("Gênero"),
                value: _generoSelecionado,
                onChanged: (String? novoValor) {
                  setState(() {
                    _generoSelecionado = novoValor ?? '';
                  });
                },
                items:
                    _opcoesDeGenero.map((String genero) {
                      return DropdownMenuItem<String>(
                        value: genero,
                        child: Text(genero),
                      );
                    }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo Obrigatório!";
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                hint: Text("Faixa Etária"),
                value: _faixaEtariaSelecionada,
                onChanged: (String? novoValor) {
                  setState(() {
                    _faixaEtariaSelecionada = novoValor ?? '';
                  });
                },
                items:
                    _opcoesDeFaixaEtaria.map((String faixaEtaria) {
                      return DropdownMenuItem<String>(
                        value: faixaEtaria,
                        child: Text(faixaEtaria),
                      );
                    }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo Obrigatório!";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _edtDuracao,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: "Duração"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo Obrigatório!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("Nota:", style: TextStyle(fontSize: 18)),
                  SizedBox(width: 8.0),
                  RatingBar.builder(
                    itemBuilder:
                        (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _numEstrelas = rating;
                      });
                      print(_numEstrelas);
                    },
                    initialRating: _numEstrelas,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30,
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _edtAno,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(labelText: "Ano"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo Obrigatório!";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _edtDescricao,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: "Descrição"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo Obrigatório!";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _salvarOuAtualizarFilme();
        },

        child: Icon(_modoEdicao ? Icons.check : Icons.save),
        tooltip: _modoEdicao ? "Atualizar" : "Cadastrar",
      ),
    );
  }
}
