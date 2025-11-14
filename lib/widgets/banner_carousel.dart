// lib/widgets/banner_carousel.dart
import 'package:flutter/material.dart';

class BannerCarousel extends StatefulWidget{
  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _controller = PageController();
  int _page = 0;

  final List<String> images = [
    // Substitua por suas imagens locais em assets/ ou URLs de teste
    'assets/banner1.png',
    'assets/banner2.png',
    'assets/banner3.png',
  ];

  @override
  void initState(){
    super.initState();
    _controller.addListener(() {
      final p = _controller.page?.round() ?? 0;
      if(p != _page){
        setState(() { _page = p; });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemCount: images.length,
            itemBuilder: (context, index){
              final img = images[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) {
                      // Se não existir localmente, tenta carregar pela web (exemplo)
                      return Image.network(
                        'https://via.placeholder.com/600x300.png?text=Banner+${index+1}',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8),
        // Indicadores (bolinhas)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (i) {
            final active = i == _page;
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: active ? 10 : 8,
              height: active ? 10 : 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? Colors.blue : Colors.grey[400],
              ),
            );
          }),
        ),
      ],
    );
  }
}
