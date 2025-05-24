import 'package:flutter/material.dart';

class DetalheFilme extends StatefulWidget {
  const DetalheFilme({super.key});

  @override
  State<DetalheFilme> createState() => _DetalheFilmeState();
}

class _DetalheFilmeState extends State<DetalheFilme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
      )
    );
  }
}
