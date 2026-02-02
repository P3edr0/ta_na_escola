import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:ta_na_escola/components/buttons/rounded_button.dart';
import 'package:ta_na_escola/responsiveness/leg_font_style.dart';
import 'package:ta_na_escola/responsiveness/responsive.dart';
import 'package:ta_na_escola/theme/colors.dart';

import '../../services/version/url_launcher_service.dart/url_launcher_service.dart';

class NotificationDialog {
  const NotificationDialog();

  static Future show({
    required String? image,
    required String? title,
    required String content,
    required String htmlContent,
    required BuildContext context,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title != null
            ? Text(
                title,

                style: TneFontStyle.titleBold,
                textAlign: TextAlign.center,
              )
            : null,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(content, textAlign: TextAlign.center),
              if (image != null) Image.network(image),
              Html(
                data: htmlContent,
                style: {
                  // Estilos globais
                  'body': Style(
                    fontSize: FontSize(14),
                    lineHeight: LineHeight(1.6),
                  ),
                  'h1': Style(
                    fontSize: FontSize(18),
                    fontWeight: FontWeight.bold,
                    margin: Margins.only(bottom: 12),
                  ),
                  'h2': Style(
                    fontSize: FontSize(16),
                    fontWeight: FontWeight.bold,
                    margin: Margins.only(bottom: 10),
                  ),
                  'p': Style(margin: Margins.only(bottom: 12)),
                  'strong': Style(fontWeight: FontWeight.bold),
                  'em': Style(fontStyle: FontStyle.italic),
                },
                extensions: [
                  // Extensão para melhorar imagens no HTML
                  TagExtension(
                    tagsToExtend: {"img"},
                    builder: (extensionContext) {
                      final src = extensionContext.attributes['src'];
                      if (src == null) return const SizedBox();

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: src,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              height: Responsive.getSize(150),
                              color: Colors.grey[200],
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: Responsive.getSize(150),
                              color: Colors.grey[200],
                              child: const Icon(Icons.broken_image),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
                onLinkTap: (url, attributes, element) async {
                  // Abre links em navegador
                  if (url != null) {
                    final urlLauncherService = context
                        .read<IUrlLauncherService>();

                    // Use o UrlLauncherService que criamos anteriormente
                    await urlLauncherService.launchCurrentUrl(url);
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TneRoundedButton(
            onTap: () => Navigator.of(context).pop(),

            child: Text(
              'Fechar',
              style: TneFontStyle.bodyBoldSec.copyWith(color: secondaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
