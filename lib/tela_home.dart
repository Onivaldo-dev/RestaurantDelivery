// lib/tela_home.dart
import 'package:aula1/banco/usuarioDAO.dart';
import 'package:aula1/restaurante.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'banco/resturanteDAO.dart';

import 'widgets/banner_carousel.dart';
import 'widgets/filtros_culinaria.dart';
import 'widgets/restaurante_card.dart';

class telaHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => telaHomeState();
}

class telaHomeState extends State<telaHome>{
  final nome = UsuarioDAO.usuarioLogado.nome ?? 'Usuário';

  List<Restaurante>  restaurantes = [];

  Future<void> carregarRestaurantes() async{
    final lista = await RestauranteDAO.listarTodos();
    setState(() {
      restaurantes = lista;
    });
  }

  @override
  void initState(){
    super.initState();
    carregarRestaurantes();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, $nome!'),
        actions: [
          Icon(Icons.account_circle)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Banner carousel (altura fixa)
            SizedBox(
                width: double.infinity,
                height: 160,
                child: BannerCarousel()
            ),
            SizedBox(height: 12),

            // Filtros com bandeiras (horizontal)
            SizedBox(
              height: 84,
              child: FiltrosCulinaria(),
            ),

            SizedBox(height: 12),

            // Lista de cards de restaurantes (vertical, scroll)
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index){
                  final r = restaurantes[index];
                  return RestauranteCard(restaurante: r);
                },
                separatorBuilder: (_,__)=>SizedBox(height: 8),
                itemCount: restaurantes.length,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
        BottomNavigationBarItem(icon: Icon(Icons.savings_rounded), label: 'Descontos'),
        BottomNavigationBarItem(icon: Icon(Icons.delivery_dining), label: 'Pedidos'),
      ]),
    );
  }
}
