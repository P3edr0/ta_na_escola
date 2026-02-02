import 'package:flutter/material.dart';
import 'package:ta_na_escola/components/dialogs/info_dialog.dart';
import 'package:ta_na_escola/domain/entities/home_card_item_entity.dart';
import 'package:ta_na_escola/shared/utils/routes/app_routes.dart';

import '../../../../components/cards/home_card.dart';
import '../../../../responsiveness/responsive.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/routes/app_navigator.dart';

class HomeCardCollection extends StatefulWidget {
  const HomeCardCollection({super.key});

  @override
  State<HomeCardCollection> createState() => _HomeCardCollectionState();
}

class _HomeCardCollectionState extends State<HomeCardCollection> {
  final AppNavigator _navigator = AppNavigator();

  List<HomeCardItemEntity> items = [];

  @override
  void initState() {
    super.initState();

    items = [
      HomeCardItemEntity(
        title: 'Entrada/Saída',
        image: TneAppAssets.frequency,
        onTap: () {
          _navigator.goto(TneRoutes.frequency);
        },
      ),
      HomeCardItemEntity(
        title: 'Notificações',
        image: TneAppAssets.notify,

        onTap: () {
          _navigator.goto(TneRoutes.notification);
        },
      ),
      HomeCardItemEntity(
        title: 'Calendário',
        image: TneAppAssets.calendar,
        isNextFlag: true,
        onTap: () {
          _navigator.goto(TneRoutes.calendar);
        },
      ),

      HomeCardItemEntity(
        title: 'Atividades',
        image: TneAppAssets.activity,
        isNextFlag: true,
        onTap: () {
          InfoDialog.closeAuto(
            'Em breve...',
            'Estamos construindo essa funcionalidade!',
            context,
          );
        },
      ),
      HomeCardItemEntity(
        title: 'Boletins',
        image: TneAppAssets.report,
        isNextFlag: true,
        onTap: () {
          InfoDialog.closeAuto(
            'Em breve...',
            'Estamos construindo essa funcionalidade!',
            context,
          );
        },
      ),

      HomeCardItemEntity(
        title: 'Enquetes',
        image: TneAppAssets.poll,
        isNextFlag: true,
        onTap: () {
          InfoDialog.closeAuto(
            'Em breve...',
            'Estamos construindo essa funcionalidade!',
            context,
          );
        },
      ),
      HomeCardItemEntity(
        title: 'Configurações',
        image: TneAppAssets.configs,
        isNextFlag: true,
        onTap: () {
          InfoDialog.closeAuto(
            'Em breve...',
            'Estamos construindo essa funcionalidade!',
            context,
          );
        },
      ),
    ];
  }

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

          return HomeCard(
            title: item.title,
            image: item.image,
            onTap: item.onTap,
            isNextFlag: false,
          );
        },
      ),
    );
  }
}
