import 'package:flutter/material.dart';
import '../controller/filme_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CadastrarFilme extends StatefulWidget {
  const CadastrarFilme({super.key});

  @override
  State<CadastrarFilme> createState() => _CadastrarFilmeState();
}

class _CadastrarFilmeState extends State<CadastrarFilme> {
  final _key = GlobalKey<FormState>();
  final _edtTitulo = TextEditingController();
  final _edtUrlImagem = TextEditingController();
  //final _edtGenero = TextEditingController();
  //final _edtFaixaEtaria = TextEditingController();
  final _edtDuracao = TextEditingController();
  //final _edtPontuacao = TextEditingController();
  final _edtDescricao = TextEditingController();
  final _edtAno = TextEditingController();
  final _filmeController = FilmeController();
  String? _generoSelecionado;
  final List<String> _opcoesDeGenero = ['Ação', 'Aventura', 'Comédia', 'Drama', 'Ficção Científica', 'Romance', 'Terror'];
  String? _faixaEtariaSelecionada;
  final List<String> _opcoesDeFaixaEtaria = ['Livre', '10 anos', '12 anos', '14 anos', '16 anos', '18 anos'];
  double _numEstrelas = 0.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar novo filme 🎬"),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: _edtUrlImagem,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "URL para a imagem de capa"
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Campo Obrigatório!";
                  }
                  return null;
                } ,
              ),
              TextFormField(
                controller: _edtTitulo,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Título"
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Campo Obrigatório!";
                  }
                  return null;
                } ,
              ),
              DropdownButtonFormField<String>(
                  hint: Text("Gênero"),
                  value: _generoSelecionado,
                  onChanged: (String? novoValor){
                    setState(() {
                      _generoSelecionado = novoValor ?? '';
                    });
                  },
                  items: _opcoesDeGenero.map((String genero){
                    return DropdownMenuItem<String>(
                      value: genero,
                      child: Text(genero),
                    );
                  }).toList(),
                validator: (value){
                    if (value == null || value.isEmpty){
                      return "Campo Obrigatório!";
                    }
                    return null;
                },
              ),
              DropdownButtonFormField<String>(
                hint: Text("Faixa Etária"),
                value: _faixaEtariaSelecionada,
                onChanged: (String? novoValor){
                  setState(() {
                    _faixaEtariaSelecionada = novoValor ?? '';
                  });
                },
                items: _opcoesDeFaixaEtaria.map((String faixaEtaria){
                  return DropdownMenuItem<String>(
                    value: faixaEtaria,
                    child: Text(faixaEtaria),
                  );
                }).toList(),
                validator: (value){
                  if (value == null || value.isEmpty){
                    return "Campo Obrigatório!";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _edtDuracao,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Duração"
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Campo Obrigatório!";
                  }
                  return null;
                } ,
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("Nota:", style: TextStyle(fontSize: 18),),
                  SizedBox(width: 8.0),
                  RatingBar.builder(itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber), onRatingUpdate: (rating){
                    setState(() {
                      _numEstrelas = rating;
                    });
                    print(_numEstrelas);
                  },
                    initialRating: 0.0, minRating: 0, direction: Axis.horizontal, allowHalfRating: true, itemCount: 5, itemSize: 30,),
                ],
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _edtAno,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                    labelText: "Ano"
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Campo Obrigatório!";
                  }
                  return null;
                } ,
              ),
              TextFormField(
                controller: _edtDescricao,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Descrição"
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Campo Obrigatório!";
                  }
                  return null;
                } ,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          try{
            print("Botão pressionado!");
            final valid = _key.currentState!.validate();
            print("Formulário válido: $valid");
            if(!valid){
              return;
            }

            //final pontuacao = double.tryParse(_edtPontuacao.text) ?? 0.0;
            final pontuacao = _numEstrelas*10/5;

            _filmeController.adicionar(_edtTitulo.text, _edtUrlImagem.text, _generoSelecionado!, _faixaEtariaSelecionada!, _edtDuracao.text, pontuacao, _edtDescricao.text, _edtAno.text);

            print("Filme adicionado, exibindo SnackBar.");
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Cadastrado com Sucesso"))
            );

            Navigator.pop(context);
            print("Navegação concluída.");
          }catch(e){
            print("Ocorreu um erro: $e");
          }
        },
        child: const Icon(Icons.save),
      ),

    );
  }
}
