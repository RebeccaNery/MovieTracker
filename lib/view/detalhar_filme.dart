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
        child: Column(
          children: [
            Image.network("https://br.web.img3.acsta.net/medias/nmedia/18/90/95/96/20122166.jpg", width: 200,),
            SizedBox(height: 20,),
            Text("Clube da Luta", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
            SizedBox(height: 20,),
            Text("Sinopse")
          ],
        ),
      )
    );
  }
}
