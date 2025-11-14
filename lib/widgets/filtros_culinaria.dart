// lib/widgets/filtros_culinaria.dart
import 'package:flutter/material.dart';

class FiltrosCulinaria extends StatelessWidget{
  // lista de pares: nome e path da imagem (pode ser local ou url)
  final List<Map<String,String>> filtros = [
    {'nome':'Mexicana', 'img':'assets/flags/mexico.png'},
    {'nome':'Árabe',     'img':'assets/flags/arabia.png'},
    {'nome':'Francesa',  'img':'assets/flags/france.png'},
    {'nome':'Portuguesa','img':'assets/flags/portugal.png'},
    {'nome':'Italiana',  'img':'assets/flags/italy.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: filtros.length,
      itemBuilder: (context, index){
        final f = filtros[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  // ação de filtro: por enquanto apenas print
                  print('Filtro selecionado: ${f['nome']}');
                },
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.asset(
                      f['img']!,
                      fit: BoxFit.cover,
                      width: 44,
                      height: 44,
                      errorBuilder: (context, error, stack){
                        // fallback para network placeholder (se não existir local)
                        return Image.network(
                          'https://via.placeholder.com/44.png?text=${Uri.encodeComponent(f['nome']![0])}',
                          width: 44,
                          height: 44,
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6),
              Text(f['nome']!, style: TextStyle(fontSize: 12)),
            ],
          ),
        );
      },
    );
  }
}
