import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/components/avatar/avatar.dart';
import 'package:ta_na_escola/components/loadings/loading.dart';
import 'package:ta_na_escola/domain/entities/user_entity.dart';
import 'package:ta_na_escola/presenter/auth/login/controller/login_controller.dart';
import 'package:ta_na_escola/presenter/features/home/controller/controller.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';
import 'package:ta_na_escola/shared/utils/app_assets.dart';
import 'package:ta_na_escola/shared/utils/handler/name_handler.dart';
import 'package:ta_na_escola/shared/utils/routes/app_routes.dart';

import '../../../../responsiveness/responsive.dart';
import '../../../../theme/colors.dart';
import '../../../components/avatar/avatar_border.dart';
import '../../../components/dialogs/error_dialog.dart';
import '../../../components/dialogs/quit_app_dialog.dart';
import '../../../shared/utils/routes/app_navigator.dart';
import 'widgets/home_card_collection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final AppNavigator _navigator = AppNavigator();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final controller = context.read<HomeController>();
      final loginController = context.read<LoginController>();
      final token = loginController.user!.token;
      await controller.fetchStudent(token: token);
      if (context.mounted) {
        if (controller.hasError) {
          await ErrorDialog.show('Atenção', controller.exception!, context);

          _navigator.goto(TneRoutes.credential, clearStack: true);
          return;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Apenas testando");
    return Scaffold(
      backgroundColor: black,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (didPop) {
            return;
          }

          bool shouldPop = await QuitAppDialog.show(
            'Sair do Tá na escola?',
            "Deseja sair do Tá na escola?",
            context,
          );
          if (shouldPop) {
            SystemNavigator.pop();
          }
        },
        child: SafeArea(
          child: Consumer<HomeController>(
            builder: (context, controller, child) {
              if (controller.loading) {
                return TnePageLoading();
              }
              final student = controller.selectedStudent;
              final handledSchoolYear = student?.schoolYear == 'null'
                  ? 'x'
                  : student?.schoolYear;
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
                            TneAppAssets.backgroundSecondary,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: Responsive.getSize(16),
                          left: 0,
                          right: 0,
                          child: Selector<LoginController, UserEntity>(
                            selector: (_, loginController) =>
                                loginController.user!,
                            builder: (context, user, child) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: Responsive.getSize(24),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TneAvatar(
                                      onTap: null,
                                      image: NetworkImage(user.image ?? ''),
                                      radius: 16,
                                    ),
                                    SizedBox(width: Responsive.getSize(6)),
                                    Text(
                                      NameHandler.firstName(user.name),
                                      style: TneFontStyle.smallBold.copyWith(
                                        color: secondaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    if (kDebugMode || kProfileMode)
                                      Text(
                                        'VERSÂO DE TESTE',
                                        style: TneFontStyle.bodyBold.copyWith(
                                          color: alertColor,
                                        ),
                                      ),
                                    SizedBox(width: Responsive.getSize(24)),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: Responsive.getSize(0),
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsetsDirectional.symmetric(
                              horizontal: Responsive.getSize(32),
                            ),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Responsive.getSize(70)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Responsive.getSize(10),
                                          ),
                                          decoration: BoxDecoration(
                                            color: accentColor,
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: Text(
                                            student?.name ?? '',
                                            style: TneFontStyle.bodyLargeBoldSec
                                                .copyWith(
                                                  color: secondaryColor,
                                                ),
                                          ),
                                        ),

                                        Text(
                                          '${student?.age ?? '-'} anos | $handledSchoolYearº Ano',
                                          style: TneFontStyle.body.copyWith(
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  student?.schoolName ?? '-- Nome da escola --',
                                  style: TneFontStyle.body.copyWith(
                                    color: grey,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: Responsive.getSize(10)),

                                HomeCardCollection(),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: Responsive.getSize(590),
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Spacer(),
                              ...controller.students.map((student) {
                                final bool isSelected =
                                    controller.selectedStudent?.id ==
                                    student.id;

                                if (isSelected) {
                                  return Expanded(
                                    child: TneAvatarBorder(
                                      image: NetworkImage(student.image ?? ''),
                                      radius: 40,
                                      hasBottomPadding: true,
                                      color: accentColor,
                                    ),
                                  );
                                }

                                return TneAvatar(
                                  onTap: () =>
                                      controller.setSelectedStudent(student),
                                  image: NetworkImage(student.image ?? ''),
                                  radius: 30,

                                  subtitle: NameHandler.firstName(student.name),
                                );
                              }),
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
      ),
    );
  }
}
