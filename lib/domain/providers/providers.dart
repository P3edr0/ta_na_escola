import 'package:provider/provider.dart';
import 'package:ta_na_escola/data/base_datasource/auth/check_credential_datasource.dart';
import 'package:ta_na_escola/data/datasources/auth/check_credential_datasource_impl.dart';
import 'package:ta_na_escola/data/repository/login/login_repository_impl.dart';
import 'package:ta_na_escola/domain/repository/auth/auth_repository.dart';
import 'package:ta_na_escola/domain/repository/session/session_repository.dart';
import 'package:ta_na_escola/domain/repository/student/student_repository.dart';
import 'package:ta_na_escola/domain/usecases/auth/check_credential_usecase.dart';
import 'package:ta_na_escola/domain/usecases/auth/create_password_usecase.dart';
import 'package:ta_na_escola/domain/usecases/auth/login_usecase.dart';
import 'package:ta_na_escola/domain/usecases/session/get_session_usecase.dart';
import 'package:ta_na_escola/domain/usecases/student/fetch_student_usecase.dart';
import 'package:ta_na_escola/presenter/auth/face_detector/store/face_capture_controller.dart';
import 'package:ta_na_escola/presenter/auth/login/controller/login_controller.dart';
import 'package:ta_na_escola/presenter/auth/preview_face_capture/controller/preview_capturered_face_controller.dart';
import 'package:ta_na_escola/presenter/auth/recover_password/store/recover_password_controller.dart';
import 'package:ta_na_escola/presenter/core/store/core_controller.dart';
import 'package:ta_na_escola/presenter/features/frequency/store/controller.dart';
import 'package:ta_na_escola/presenter/features/home/controller/controller.dart';
import 'package:ta_na_escola/presenter/features/notification/store/controller.dart';

import '../../data/base_datasource/auth/create_face_id_datasource.dart';
import '../../data/base_datasource/auth/create_password_datasource.dart';
import '../../data/base_datasource/auth/login_datasource.dart';
import '../../data/base_datasource/auth/recover_password_datasource.dart';
import '../../data/base_datasource/notification/notification_datasource.dart';
import '../../data/base_datasource/session/create_session.dart';
import '../../data/base_datasource/session/delete_session.dart';
import '../../data/base_datasource/session/get_session.dart';
import '../../data/base_datasource/student/student_datasource.dart';
import '../../data/datasources/auth/create_face_id_datasource_impl.dart';
import '../../data/datasources/auth/create_password_datasource_impl.dart';
import '../../data/datasources/auth/login_datasource_impl.dart';
import '../../data/datasources/auth/recover_password_datasource_impl.dart';
import '../../data/datasources/local/secure_storage/session/create_session.dart';
import '../../data/datasources/local/secure_storage/session/delete_session.dart';
import '../../data/datasources/local/secure_storage/session/get_session.dart';
import '../../data/datasources/notification/get_notification_categories_datasource.dart';
import '../../data/datasources/notification/get_notifications_by_category_datasource.dart';
import '../../data/datasources/notification/update_notification_status_datasource.dart';
import '../../data/datasources/student/fetch_student_datasource.dart';
import '../../data/datasources/student/get_filtered_frequency_datasource.dart';
import '../../data/datasources/student/get_frequency_datasource.dart';
import '../../data/repository/notification/notification_repository_impl.dart';
import '../../data/repository/session/create_session_repository_impl.dart';
import '../../data/repository/session/delete_session_repository_impl.dart';
import '../../data/repository/session/get_session_repository_impl.dart';
import '../../data/repository/student/student_repository_impl.dart';
import '../../presenter/auth/create_password/controller/create_password_controller.dart';
import '../../presenter/auth/credential/controller/controller.dart';
import '../../shared/utils/routes/route_observer.dart';
import '../repository/notification/notification_repository.dart';
import '../usecases/auth/create_face_id_usecase.dart';
import '../usecases/auth/recover_password_usecase.dart';
import '../usecases/notification/get_notification_categories_usecase.dart';
import '../usecases/notification/get_notifications_by_category_usecase.dart';
import '../usecases/notification/update_notification_status_usecase .dart';
import '../usecases/session/create_session_usecase.dart';
import '../usecases/session/delete_session_usecase.dart';
import '../usecases/student/get_filtered_frequency_usecase.dart';
import '../usecases/student/get_frequency_usecase.dart';

class Providers {
  static final providers = [
    /////////////////////// SESSION PROVIDERS /////////
    // CREATE SESSION /////////
    Provider<ICreateSessionDatasource>(
      create: (ctx) => SecureStorageCreateSession(),
    ),
    Provider<ICreateSessionRepository>(
      create: (ctx) => CreateSessionRepositoryImpl(
        datasource: ctx.read<ICreateSessionDatasource>(),
      ),
    ),
    // DELETE SESSION /////////
    Provider<IDeleteSessionDatasource>(
      create: (ctx) => SecureStorageDeleteSession(),
    ),
    Provider<IDeleteSessionRepository>(
      create: (ctx) => DeleteSessionRepositoryImpl(
        datasource: ctx.read<IDeleteSessionDatasource>(),
      ),
    ),
    // GET SESSION /////////
    Provider<IGetSessionDatasource>(create: (ctx) => SecureStorageGetSession()),
    Provider<IGetSessionRepository>(
      create: (ctx) => GetSessionRepositoryImpl(
        datasource: ctx.read<IGetSessionDatasource>(),
      ),
    ),

    /////////////////////// AUTH PROVIDERS /////////
    ChangeNotifierProvider<RouteStackObserver>(
      create: (ctx) => RouteStackObserver.instance(),
    ),

    // CHECK CREDENTIAL /////////
    Provider<ICheckCredentialDatasource>(
      create: (ctx) => CheckCredentialDatasourceImpl(),
    ),
    Provider<ICheckCredentialRepository>(
      create: (ctx) => CheckCredentialRepositoryImpl(
        datasource: ctx.read<ICheckCredentialDatasource>(),
      ),
    ),
    ChangeNotifierProvider<CredentialController>(
      create: (ctx) => CredentialController(
        checkCredentialUsecase: CheckCredentialUsecase(
          repository: ctx.read<ICheckCredentialRepository>(),
        ),
      ),
    ),

    // CHECK CREDENTIAL /////////
    ChangeNotifierProvider<FaceCaptureController>(
      create: (ctx) => FaceCaptureController(),
    ),

    // LOGIN /////////
    Provider<ILoginDatasource>(create: (ctx) => LoginDatasourceImpl()),
    Provider<ILoginRepository>(
      create: (ctx) =>
          LoginRepositoryImpl(datasource: ctx.read<ILoginDatasource>()),
    ),
    ChangeNotifierProvider<LoginController>(
      create: (ctx) => LoginController(
        loginUsecase: LoginUsecase(repository: ctx.read<ILoginRepository>()),
        createSessionUseCase: CreateSessionUseCase(
          repository: ctx.read<ICreateSessionRepository>(),
        ),
      ),
    ),

    // CREATE PASSWORD /////////
    Provider<ICreatePasswordDatasource>(
      create: (ctx) => CreatePasswordDatasourceImpl(),
    ),
    Provider<ICreatePasswordRepository>(
      create: (ctx) => CreatePasswordRepositoryImpl(
        datasource: ctx.read<ICreatePasswordDatasource>(),
      ),
    ),
    ChangeNotifierProvider<CreatePasswordController>(
      create: (ctx) => CreatePasswordController(
        createPasswordUsecase: CreatePasswordUsecase(
          repository: ctx.read<ICreatePasswordRepository>(),
        ),
      ),
    ),

    // CREATE FACE ID /////////
    Provider<ICreateFaceIdDatasource>(
      create: (ctx) => CreateFaceIdDatasourceImpl(),
    ),
    Provider<ICreateFaceIdRepository>(
      create: (ctx) => CreateFaceIdRepositoryImpl(
        datasource: ctx.read<ICreateFaceIdDatasource>(),
      ),
    ),
    ChangeNotifierProvider<PreviewCapturedFaceController>(
      create: (ctx) => PreviewCapturedFaceController(
        createFaceIdUsecase: CreateFaceIdUsecase(
          repository: ctx.read<ICreateFaceIdRepository>(),
        ),
      ),
    ),

    // RECOVER PASSWORD /////////
    Provider<IRecoverPasswordDatasource>(
      create: (ctx) => RecoverPasswordDatasourceImpl(),
    ),
    Provider<IRecoverPasswordRepository>(
      create: (ctx) => RecoverPasswordRepositoryImpl(
        datasource: ctx.read<IRecoverPasswordDatasource>(),
      ),
    ),

    ChangeNotifierProvider<RecoverPasswordController>(
      create: (ctx) => RecoverPasswordController(
        recoverPasswordUsecase: RecoverPasswordUsecase(
          repository: ctx.read<IRecoverPasswordRepository>(),
        ),
      ),
    ),

    ///////////////////////CORE PROVIDERS /////////
    // SESSION  ////////////
    ChangeNotifierProvider<CoreController>(
      create: (ctx) => CoreController(
        deleteSessionUseCase: DeleteSessionUseCase(
          repository: ctx.read<IDeleteSessionRepository>(),
        ),
        getSessionUseCase: GetSessionUseCase(
          repository: ctx.read<IGetSessionRepository>(),
        ),
        loginController: ctx.read<LoginController>(),
        credentialController: ctx.read<CredentialController>(),
      ),
    ),

    // STUDENT /////////
    Provider<IFetchStudentDatasource>(
      create: (ctx) => FetchStudentDatasourceImpl(),
    ),
    Provider<IFetchStudentRepository>(
      create: (ctx) => FetchStudentRepositoryImpl(
        datasource: ctx.read<IFetchStudentDatasource>(),
      ),
    ),
    ChangeNotifierProvider<HomeController>(
      create: (ctx) => HomeController(
        fetchStudentUsecase: FetchStudentUsecase(
          repository: ctx.read<IFetchStudentRepository>(),
        ),
      ),
    ),

    // FREQUENCY /////////
    Provider<IGetFrequencyDatasource>(
      create: (ctx) => GetFrequencyDatasourceImpl(),
    ),
    Provider<IGetFrequencyRepository>(
      create: (ctx) => GetFrequencyRepositoryImpl(
        datasource: ctx.read<IGetFrequencyDatasource>(),
      ),
    ),
    Provider<IGetFilteredFrequencyDatasource>(
      create: (ctx) => GetFilteredFrequencyDatasourceImpl(),
    ),
    Provider<IGetFilteredFrequencyRepository>(
      create: (ctx) => GetFilteredFrequencyRepositoryImpl(
        datasource: ctx.read<IGetFilteredFrequencyDatasource>(),
      ),
    ),
    ChangeNotifierProvider<FrequencyController>(
      create: (ctx) => FrequencyController(
        getFrequencyUsecase: GetFrequencyUsecase(
          repository: ctx.read<IGetFrequencyRepository>(),
        ),
        getFilteredFrequencyUsecase: GetFilteredFrequencyUsecase(
          repository: ctx.read<IGetFilteredFrequencyRepository>(),
        ),
      ),
    ),

    // NOTIFICATIONS /////////
    Provider<IGetNotificationsByCategoryDatasource>(
      create: (ctx) => GetNotificationsByCategoryDatasourceImpl(),
    ),
    Provider<IGetNotificationsByCategoryRepository>(
      create: (ctx) => GetNotificationsByCategoryRepositoryImpl(
        datasource: ctx.read<IGetNotificationsByCategoryDatasource>(),
      ),
    ),
    // NOTIFICATIONS /////////
    Provider<IGetNotificationCategoriesDatasource>(
      create: (ctx) => GetNotificationCategoriesDatasourceImpl(),
    ),
    Provider<IGetNotificationCategoriesRepository>(
      create: (ctx) => GetNotificationCategoriesRepositoryImpl(
        datasource: ctx.read<IGetNotificationCategoriesDatasource>(),
      ),
    ),
    // NOTIFICATIONS /////////
    Provider<IUpdateNotificationStatusDatasource>(
      create: (ctx) => UpdateNotificationStatusDatasourceImpl(),
    ),
    Provider<IUpdateNotificationStatusRepository>(
      create: (ctx) => UpdateNotificationStatusRepositoryImpl(
        datasource: ctx.read<IUpdateNotificationStatusDatasource>(),
      ),
    ),
    ChangeNotifierProvider<NotificationController>(
      create: (ctx) => NotificationController(
        getNotificationCategoriesUsecase: GetNotificationCategoriesUsecase(
          repository: ctx.read<IGetNotificationCategoriesRepository>(),
        ),
        getNotificationsByCategoryUsecase: GetNotificationsByCategoryUsecase(
          repository: ctx.read<IGetNotificationsByCategoryRepository>(),
        ),
        updateNotificationStatusUsecase: UpdateNotificationStatusUsecase(
          repository: ctx.read<IUpdateNotificationStatusRepository>(),
        ),
      ),
    ),
  ];
}
