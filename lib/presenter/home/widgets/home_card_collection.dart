import 'package:flutter/material.dart';
import 'package:ta_na_escola/domain/entities/home_card_item_entity.dart';

import '../../../components/cards/home_card.dart';
import '../../../responsiveness/responsive.dart';
import '../../../shared/utils/app_assets.dart';

class HomeCardCollection extends StatelessWidget {
  HomeCardCollection({super.key});

  final List<HomeCardItemEntity> items = [
    HomeCardItemEntity(title: 'Entrada/Saída', image: TneAppAssets.frequency),
    HomeCardItemEntity(title: 'Notificações', image: TneAppAssets.notify),
    HomeCardItemEntity(title: 'Boletins', image: TneAppAssets.report),
    HomeCardItemEntity(title: 'Atividades', image: TneAppAssets.activity),
    HomeCardItemEntity(title: 'Calendário', image: TneAppAssets.calendar),
    HomeCardItemEntity(title: 'Enquetes', image: TneAppAssets.poll),
    HomeCardItemEntity(title: 'Configurações', image: TneAppAssets.configs),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.getSize(500),
      child: GridView.builder(
        padding: EdgeInsets.only(bottom: Responsive.getSize(20)),
        shrinkWrap: true,
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: Responsive.getSize(14),
          mainAxisSpacing: Responsive.getSize(14),
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          final item = items[index];

          return HomeCard(title: item.title, image: item.image);
        },
      ),
    );
  }
}
