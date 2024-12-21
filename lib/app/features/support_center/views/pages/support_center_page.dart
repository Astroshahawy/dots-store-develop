import 'package:dots/core/utils/assets_file.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/const_file.dart';
import '../../../../components/forms/custom_text_field.dart';
import '../../../../components/lottie_widget.dart';

class SupportCenterPage extends StatelessWidget {
  const SupportCenterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('help_str'.tr()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const LottieWidget(
            lottie: AssetsFile.callCenterLottie,
          ),
          GP.g24(),
          CustomTextField(
            label: 'name_str'.tr(),
            icon: Icon(FontAwesomeIcons.user, size: ConstSizes.s18),
          ),
          GP.g24(),
          CustomTextField(
            label: 'email_str'.tr(),
            icon: Icon(FontAwesomeIcons.solidEnvelope, size: ConstSizes.s18),
          ),
          GP.g24(),
          MultiLineTextField(
            label: 'type_message_str'.tr(),
          ),
          GP.g24(),
          ElevatedButton(
            onPressed: () {},
            child: Text('send_str'.tr()),
          ),
        ],
      ),
    );
  }
}
