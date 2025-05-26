import 'package:flutter/material.dart';
import '../controller/filme_controller.dart';

class CadastrarFilme extends StatefulWidget {
  const CadastrarFilme({super.key});

  @override
  State<CadastrarFilme> createState() => _CadastrarFilmeState();
}

class _CadastrarFilmeState extends State<CadastrarFilme> {
  final _key = GlobalKey<FormState>();
  final _edtTitulo = TextEditingController();
  final _edtUrlImagem = TextEditingController();
  final _edtGenero = TextEditingController();
  final _edtFaixaEtaria = TextEditingController();
  final _edtDuracao = TextEditingController();
  final _edtPontuacao = TextEditingController();
  final _edtDescricao = TextEditingController();
  final _edtAno = TextEditingController();
  final _filmeController = FilmeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadstrar novo filme 🎬"),
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
                    labelText: "URL para a capa do filme"
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Campo Obrigatório";
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
                    return "Campo Obrigatório";
                  }
                  return null;
                } ,
              ),
              TextFormField(
                controller: _edtGenero,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Gênero"
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Campo Obrigatório";
                  }
                  return null;
                } ,
              ),
              TextFormField(
                controller: _edtDuracao,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Duração"
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Campo Obrigatório";
                  }
                  return null;
                } ,
              ),
              TextFormField(
                controller: _edtAno,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Ano"
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Campo Obrigatório";
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
                    return "Campo Obrigatório";
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
          final valid = _key.currentState!.validate();
          if(!valid){
            return;
          }
          _filmeController.adicionar(_edtTitulo.text, _edtUrlImagem.text, _edtGenero.text, _edtFaixaEtaria.text, _edtDuracao.text, double.parse(_edtPontuacao.text), _edtDescricao.text, _edtAno.text);

          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Cadastrado com Sucesso"))
          );

          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),

    );
  }
}
