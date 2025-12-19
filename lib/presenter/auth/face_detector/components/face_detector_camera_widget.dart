import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../../components/loadings/loading.dart';
import '../../../../domain/entities/face_detector_view_model.dart';
import '../../preview_face_capture/components/painter/face_detector_painter.dart';

class FaceDetectorCameraWidget extends StatelessWidget {
  final FaceDetectorViewModel viewModel;
  final CameraController? cameraController;

  const FaceDetectorCameraWidget({
    required this.viewModel,
    required this.cameraController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                color: Colors.black,
                width: double.maxFinite,
                height: double.maxFinite,
                child: viewModel.isLoading
                    ? const TnePageLoading()
                    : AspectRatio(
                        aspectRatio: cameraController!
                            .value
                            .aspectRatio, // Aspecto automático
                        child: CameraPreview(cameraController!),
                      ),
              ),
              ClipPath(
                clipper: FaceDetectorClipper(),
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 70),
      ],
    );
  }
}
