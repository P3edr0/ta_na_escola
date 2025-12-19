import 'package:flutter/material.dart';
import 'package:ta_na_escola/domain/usecases/auth/create_face_id_usecase.dart';

class PreviewCapturedFaceController extends ChangeNotifier {
  PreviewCapturedFaceController({required this.createFaceIdUsecase});
  final CreateFaceIdUsecase createFaceIdUsecase;

  String? exception;

  bool loading = false;
  int currentPasswordRequire = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /////////////////// GET

  bool get hasError => exception != null;

  void setLoading([bool? newLoading]) {
    if (newLoading != null) {
      loading = newLoading;
      notifyListeners();
      return;
    }
    loading = !loading;
    notifyListeners();
  }

  Future<void> createFaceId({
    required String image,
    required String token,
  }) async {
    setLoading();

    final response = await createFaceIdUsecase(image: image, token: token);
    response.fold(
      (newException) {
        exception = newException.message;

        setLoading();
      },
      (success) {
        if (success) {
          exception = null;
          setLoading();

          return;
        }
      },
    );
  }
}
