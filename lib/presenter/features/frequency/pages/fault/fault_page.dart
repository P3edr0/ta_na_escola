import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/components/buttons/rounded_button.dart';
import 'package:ta_na_escola/components/dropdowns/miner_dropdown.dart';
import 'package:ta_na_escola/presenter/auth/login/controller/login_controller.dart';
import 'package:ta_na_escola/presenter/features/frequency/store/controller.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';
import 'package:ta_na_escola/shared/utils/enums/fault_type.dart';

import '../../../../../components/app_bar/app_bar.dart';
import '../../../../../components/avatar/avatar_border.dart';
import '../../../../../components/loadings/loading.dart';
import '../../../../../components/textfields/textfield.dart';
import '../../../../../responsiveness/responsive.dart';
import '../../../../../shared/utils/app_assets.dart';
import '../../../../../shared/utils/formatters/date_formatter.dart';
import '../../../../../theme/colors.dart';
import '../../../home/controller/controller.dart';

class FaultPage extends StatefulWidget {
  const FaultPage({super.key});

  @override
  State<FaultPage> createState() => _FaultPageState();
}

class _FaultPageState extends State<FaultPage> {
  late final LoginController loginController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<FrequencyController>(
          builder: (context, controller, child) {
            if (controller.loading) {
              return TnePageLoading();
            }
            final HomeController homeController = context
                .read<HomeController>();

            final student = homeController.selectedStudent;

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,

                        color: secondaryColor,
                        child: Image.asset(
                          TneAppAssets.backgroundOverall,
                          fit: BoxFit.cover,
                        ),
                      ),
                      TneAppBar(title: 'Informar falta'),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: 100,
                        child: Container(
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: Responsive.getSize(28),
                          ),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Responsive.getSize(70)),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      color: grey,
                                      size: Responsive.getSize(24),
                                    ),
                                    SizedBox(width: Responsive.getSize(10)),

                                    SizedBox(
                                      width: Responsive.getSize(150),
                                      child: TneTextfield(
                                        controller:
                                            controller.startDateController,
                                        formatter: [
                                          TneDateFormat.maskFormatter,
                                        ],
                                        hint: 'Data da falta',
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                SizedBox(height: Responsive.getSize(16)),
                                TneSecondaryDropdown(
                                  selectedItem: controller.faultType.toString(),
                                  onChanged: (value) {
                                    controller.setFaultType(value!);
                                  },
                                  items: FaultType.values
                                      .map((item) => item.toString())
                                      .toList(),
                                  textColor: blueGrey,
                                ),
                                SizedBox(height: Responsive.getSize(16)),
                                if (controller.faultType.isHealth)
                                  TneRoundedButton.solid(
                                    color: lightGrey,
                                    height: Responsive.getSize(40),
                                    radius: Responsive.getSize(8),
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.upload_file,
                                          color: blueGrey,
                                          size: Responsive.getSize(24),
                                        ),
                                        SizedBox(width: Responsive.getSize(10)),

                                        Text(
                                          "Enviar arquivo ou foto",
                                          style: TneFontStyle.bodyBoldSec
                                              .copyWith(color: blueGrey),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (controller.faultType.isAnother)
                                  TneTextfield(
                                    controller:
                                        controller.faultJustifyController,
                                    padding: EdgeInsets.all(
                                      Responsive.getSize(8),
                                    ),
                                    hint: 'Justificativa',
                                    alignment: Alignment.topLeft,
                                    maxLines: 3,
                                  ),

                                SizedBox(height: Responsive.getSize(40)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TneRoundedButton(
                                      height: Responsive.getSize(40),
                                      padding: Responsive.getSize(32),
                                      onTap: () {},
                                      child: Text(
                                        "Concluir",
                                        style: TneFontStyle.bodyBoldSec
                                            .copyWith(color: secondaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: Responsive.getSize(590),
                        left: 0,
                        right: 0,
                        top: -20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Spacer(),

                            Expanded(
                              child: TneAvatarBorder(
                                image: NetworkImage(student!.image ?? ''),
                                radius: 30,
                                hasBottomPadding: true,
                                color: accentColor,
                              ),
                            ),

                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
