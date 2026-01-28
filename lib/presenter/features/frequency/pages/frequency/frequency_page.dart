import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/components/buttons/rounded_button.dart';
import 'package:ta_na_escola/components/cards/frequency_card.dart';
import 'package:ta_na_escola/components/loadings/loading_button.dart';
import 'package:ta_na_escola/components/textfields/textfield.dart';
import 'package:ta_na_escola/domain/entities/data_frequency_entity.dart';
import 'package:ta_na_escola/presenter/auth/login/controller/login_controller.dart';
import 'package:ta_na_escola/presenter/features/frequency/store/controller.dart';
import 'package:ta_na_escola/presenter/features/frequency/widgets/frequency_chart.dart';
import 'package:ta_na_escola/presenter/features/frequency/widgets/frequency_list.dart';
import 'package:ta_na_escola/shared/utils/formatters/date_formatter.dart';

import '../../../../../components/app_bar/app_bar.dart';
import '../../../../../components/avatar/avatar_border.dart';
import '../../../../../components/badges/badge.dart';
import '../../../../../components/cards/frequency_types_card.dart';
import '../../../../../components/dialogs/error_dialog.dart';
import '../../../../../components/dialogs/info_dialog.dart';
import '../../../../../components/loadings/loading.dart';
import '../../../../../components/texts/time_register.dart';
import '../../../../../responsiveness/leg_font_style.dart';
import '../../../../../responsiveness/responsive.dart';
import '../../../../../shared/utils/app_assets.dart';
import '../../../../../shared/utils/handler/name_handler.dart';
import '../../../../../theme/colors.dart';
import '../../../home/controller/controller.dart';
import '../../widgets/frequency_small_card.dart';

class FrequencyPage extends StatefulWidget {
  const FrequencyPage({super.key});

  @override
  State<FrequencyPage> createState() => _FrequencyPageState();
}

class _FrequencyPageState extends State<FrequencyPage> {
  late final HomeController homeController;
  late final LoginController loginController;
  @override
  void initState() {
    super.initState();
    final controller = context.read<FrequencyController>();
    homeController = context.read<HomeController>();
    loginController = context.read<LoginController>();
    final student = homeController.selectedStudent!;
    final user = loginController.user!;
    final data = DataFrequencyEntity(
      studentId: student.guardianId,
      schoolId: student.schoolId!,
      token: user.token,
      pages: [1],
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.startPage();

      await controller.getFrequency(data: data);
    });
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
                      TneAppBar(title: 'Entrada/Saída'),

                      Positioned(
                        //FUNDO BRANCO
                        top: Responsive.getSize(250),
                        left: 0,
                        right: 0,
                        bottom: 0,
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
                                SizedBox(height: Responsive.getSize(80)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TneRoundedButton.solid(
                                      height: Responsive.getSize(40),
                                      color: alertColor,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Responsive.getSize(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              TneAppAssets.userWarningIcon,
                                            ),
                                            SizedBox(
                                              width: Responsive.getSize(8),
                                            ),
                                            Text(
                                              'Informar falta',
                                              style: TneFontStyle.bodyBoldSec
                                                  .copyWith(
                                                    color: secondaryColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        InfoDialog.closeAuto(
                                          'Em breve...',
                                          'Estamos construindo essa funcionalidade!',
                                          context,
                                        );

                                        // final AppNavigator navigator =
                                        //     AppNavigator();
                                        // navigator.goto(TneRoutes.fault);
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: Responsive.getSize(20)),
                                Container(
                                  padding: EdgeInsets.all(
                                    Responsive.getSize(16),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: Responsive.getSize(2),
                                  ),

                                  decoration: BoxDecoration(
                                    color: secondaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: lightGrey.withValues(
                                          alpha: 0.03,
                                        ),
                                        blurRadius: 0.9,
                                        spreadRadius: 0.9,
                                        offset: Offset(1, 1),
                                      ),
                                      BoxShadow(
                                        blurRadius: 0.9,
                                        spreadRadius: 0.9,
                                        color: lightGrey.withValues(
                                          alpha: 0.03,
                                        ),
                                        offset: Offset(-1, -1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TneBadge(label: 'Presença hoje'),

                                          TneRoundedButton(
                                            padding: 10,
                                            height: 20,
                                            child: Text(
                                              TneDateFormat.frequencyFormat(
                                                DateTime.now(),
                                              ),
                                              style: TneFontStyle.smallSec
                                                  .copyWith(
                                                    color: secondaryColor,
                                                  ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Responsive.getSize(16)),
                                      contentManager(controller),

                                      SizedBox(height: Responsive.getSize(8)),
                                    ],
                                  ),
                                ),

                                SizedBox(height: Responsive.getSize(32)),

                                InkWell(
                                  onTap: controller.setFrequencyMenuType,

                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: blueGrey,
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.frequencyMenuType.isLatest
                                              ? 'Últimos registros'
                                              : 'Intervalo personalizado',
                                          style: TneFontStyle.bodyBoldSec
                                              .copyWith(color: blueGrey),
                                        ),
                                        Icon(
                                          controller.frequencyMenuType.isLatest
                                              ? Icons
                                                    .keyboard_double_arrow_down_sharp
                                              : Icons
                                                    .keyboard_double_arrow_up_sharp,
                                          color: blueGrey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: Responsive.getSize(32)),
                                if (controller.frequencyMenuType.isCustom) ...[
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        color: grey,
                                        size: Responsive.getSize(24),
                                      ),
                                      SizedBox(width: Responsive.getSize(10)),

                                      Expanded(
                                        child: TneTextfield(
                                          controller:
                                              controller.startDateController,
                                          inputType: TextInputType.number,

                                          formatter: [
                                            TneDateFormat.maskFormatter,
                                          ],
                                          hint: 'Data inicial',
                                        ),
                                      ),
                                      SizedBox(width: Responsive.getSize(10)),

                                      Icon(Icons.chevron_right, color: grey),
                                      SizedBox(width: Responsive.getSize(10)),

                                      Expanded(
                                        child: TneTextfield(
                                          controller:
                                              controller.finalDateController,
                                          hint: 'Data final',
                                          inputType: TextInputType.number,
                                          formatter: [
                                            TneDateFormat.maskFormatter,
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Responsive.getSize(32)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Consumer<FrequencyController>(
                                        builder:
                                            (
                                              context,
                                              frequencyComponentController,
                                              child,
                                            ) {
                                              return TneRoundedButton(
                                                padding: 40,
                                                child:
                                                    frequencyComponentController
                                                        .filterLoading
                                                    ? TneLoadingButton()
                                                    : Text(
                                                        'Pesquisar',
                                                        style: TneFontStyle
                                                            .bodyLargeSec
                                                            .copyWith(
                                                              color:
                                                                  secondaryColor,
                                                            ),
                                                      ),
                                                onTap: () async {
                                                  if (controller.hasError) {
                                                    WidgetsBinding.instance
                                                        .addPostFrameCallback((
                                                          _,
                                                        ) async {
                                                          if (context.mounted) {
                                                            await ErrorDialog.show(
                                                              'Atenção',
                                                              controller
                                                                  .exception!,
                                                              context,
                                                            );
                                                            return;
                                                          }
                                                        });
                                                    return;
                                                  }

                                                  final student = homeController
                                                      .selectedStudent!;
                                                  final user =
                                                      loginController.user!;
                                                  final data =
                                                      DataFrequencyEntity(
                                                        studentId:
                                                            student.guardianId,
                                                        schoolId:
                                                            student.schoolId!,
                                                        token: user.token,
                                                        pages: [1],
                                                      );
                                                  await frequencyComponentController
                                                      .getFilteredFrequency(
                                                        data: data,
                                                      );
                                                },
                                              );
                                            },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Responsive.getSize(10)),

                                  TneFrequencyList(
                                    items: controller.filteredFrequencies,
                                  ),
                                ],
                                if (controller.frequencyMenuType.isLatest) ...[
                                  TneFrequencyList(
                                    items: controller.latestFrequencies,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        //CARD FRONTAL
                        top: Responsive.getSize(130),
                        left: 0,
                        right: 0,
                        // top: Responsive.getSize(96),
                        child: Container(
                          padding: EdgeInsets.all(Responsive.getSize(16)),
                          margin: EdgeInsets.symmetric(
                            horizontal: Responsive.getSize(30),
                          ),

                          decoration: BoxDecoration(
                            color: secondaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: lightGrey.withValues(alpha: 0.05),
                                blurRadius: 0.9,
                                spreadRadius: 0.9,
                                offset: Offset(1, 1),
                              ),
                              BoxShadow(
                                blurRadius: 0.9,
                                spreadRadius: 0.9,
                                color: lightGrey.withValues(alpha: 0.05),
                                offset: Offset(-1, -1),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TneBadge(label: 'Frequência'),
                                  Text(
                                    NameHandler.surname(student!.name),
                                    style: TneFontStyle.smallBold.copyWith(
                                      color: accentColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Responsive.getSize(12)),
                              SizedBox(
                                height: Responsive.getSize(80),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    FrequencySmallCard(
                                      content:
                                          controller.frequencyStats.presences,
                                      contentColor: accentColor,
                                      title: 'Presenças',
                                    ),
                                    FrequencySmallCard(
                                      content:
                                          controller.frequencyStats.absences,
                                      contentColor: alertColor,
                                      title: 'Faltas',
                                    ),
                                    FrequencySmallCard(
                                      content: controller.frequencyStats.total,
                                      contentColor: blueGrey,
                                      title: 'Aulas',
                                    ),

                                    SizedBox(width: Responsive.getSize(10)),
                                    SizedBox(
                                      width: Responsive.getSize(54),
                                      height: Responsive.getSize(54),
                                      child: TneFrequencyChart(
                                        absencesPercentage: controller
                                            .frequencyStats
                                            .absencesPercentage,
                                        presencesPercentage: controller
                                            .frequencyStats
                                            .presencesPercentage,
                                      ),
                                    ),
                                    SizedBox(width: Responsive.getSize(6)),
                                  ],
                                ),
                              ),
                              SizedBox(height: Responsive.getSize(8)),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    padding: EdgeInsets.all(
                                      Responsive.getSize(4),
                                    ),

                                    decoration: BoxDecoration(
                                      color: lightGrey.withValues(alpha: 0.025),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'informações do ano letivo até 28/10',
                                      style: TneFontStyle.verySmall.copyWith(
                                        color: blueGrey,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        //MENINA
                        top: Responsive.getSize(90),
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Spacer(),

                            Expanded(
                              child: TneAvatarBorder(
                                image: NetworkImage(student.image ?? ''),
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

  Widget contentManager(FrequencyController controller) {
    String? label;
    IconData? icon;
    Color? color;

    if (controller.todayFrequency == null) {
      label = 'Hoje não tem aula';
      icon = Icons.sentiment_very_satisfied_outlined;
      color = mediumGrey;
      return TneFrequencyTypesCard(label: label, color: color, icon: icon);
    }

    if (controller.todayFrequency!.entryTime != null) {
      return TodayPresenceContent(
        entryTime: controller.todayFrequency?.entryTime,
        exitTime: controller.todayFrequency?.exitTime,
      );
    }

    if (!controller.todayFrequency!.didHaveClass) {
      label = 'Aguardando o horário da aula';
      icon = Icons.timer_outlined;
      color = warning.shade600;
    }

    if (controller.todayFrequency!.didHaveClass &&
        controller.todayFrequency!.entryTime == null) {
      label = 'Você faltou hoje';
      icon = Icons.warning_rounded;
      color = alertColor;
    }
    if (label == null || icon == null || color == null) {
      label = 'Estamos preparando seus dados';
      icon = Icons.settings;
      color = mediumGrey;
    }

    return TneFrequencyTypesCard(label: label, color: color, icon: icon);
  }
}

class TodayPresenceContent extends StatelessWidget {
  const TodayPresenceContent({
    super.key,
    required this.entryTime,
    required this.exitTime,
  });
  final String? entryTime;
  final String? exitTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //HORARIOS
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TneTimeRegister(color: accentColor, time: entryTime ?? '--:--'),
            SizedBox(height: Responsive.getSize(42)),
            TneTimeRegister(color: blueGrey, time: exitTime ?? '--:--'),
          ],
        ),
        SizedBox(width: Responsive.getSize(5)),
        //LINHAS E STEPS
        Column(
          children: [
            SizedBox(height: Responsive.getSize(5)),
            TneAvatarBorder.withColor(radius: 4, color: accentColor),
            Container(
              color: accentColor,
              width: Responsive.getSize(2),

              height: Responsive.getSize(58),
            ),

            TneAvatarBorder.withColor(radius: 4, color: blueGrey),
          ],
        ),
        SizedBox(width: Responsive.getSize(5)),

        //SMALL CARDS
        Expanded(
          child: Column(
            children: [
              SizedBox(height: Responsive.getSize(5)),
              TneFrequencyCard.entry(),
              SizedBox(height: Responsive.getSize(8)),

              TneFrequencyCard.exit(),
            ],
          ),
        ),
      ],
    );
  }
}
