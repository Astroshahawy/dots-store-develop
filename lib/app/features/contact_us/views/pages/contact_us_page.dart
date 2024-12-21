import 'package:dots/core/utils/assets_file.dart';
import 'package:dots/core/utils/const_file.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geeks_service/service/logger.dart';

import '../../../../components/logo_widget.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('contactUsString'.tr()),
      ),
      body: const Column(
        children: [
          LogoWidget(height: 150),
          ContactUsBody(),
        ],
      ),
    );
  }
}

class ContactUsBody extends StatelessWidget {
  const ContactUsBody({Key? key}) : super(key: key);

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ContactUsInfoTile(
              onTap: () async {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: '0555314335',
                );
                await _launchInBrowser(launchUri);
                logger.i(launchUri);
              },
              title: 'الهاتف',
              image: 'phone.png',
            ),
            ContactUsInfoTile(
              onTap: () async {
                final Uri launchUri = Uri(
                  scheme: 'mailto',
                  path: 'info@dotsapp.co',
                );
                await _launchInBrowser(launchUri);
                logger.i(launchUri);
              },
              title: 'البريد الإلكترونى',
              image: 'email.png',
            ),
            ContactUsInfoTile(
              onTap: () {},
              title: 'مكه السعوديه',
              image: 'address.png',
            ),
            Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                crossAxisSpacing: 30,
                mainAxisSpacing: 1 / 2,
                crossAxisCount: 3,
                children: <Widget>[
                  ContactUsInfoTile(
                    onTap: () async {
                      final Uri launchUri = Uri(
                        scheme: 'https',
                        // path: state.data!.whatsapp,
                      );
                      await _launchInBrowser(launchUri);
                      logger.i(launchUri);
                    },
                    // title: 'whatsapp_string'.tr(),
                    image: 'whats.png',
                  ),
                  ContactUsInfoTile(
                    onTap: () async {
                      final Uri launchUri = Uri(
                        scheme: 'https',
                        path: 'www.facebook.com',
                      );
                      await _launchInBrowser(launchUri);
                      logger.i(launchUri);
                    },
                    // title: 'facebook_string'.tr(),
                    image: 'facebook.png',
                  ),
                  ContactUsInfoTile(
                    onTap: () async {
                      final Uri launchUri = Uri(
                        scheme: 'https',
                        path: 'www.tiktok.com/@dotsapp_sa',
                      );
                      await _launchInBrowser(launchUri);
                      logger.i(launchUri);
                    },
                    // title: 'facebook_string'.tr(),
                    image: 'TikTok.png',
                  ),
                  ContactUsInfoTile(
                    onTap: () async {
                      final Uri launchUri = Uri(
                        scheme: 'https',
                        path: 'twitter.com/dotsapp_sa',
                      );
                      await _launchInBrowser(launchUri);
                      logger.i(launchUri);
                    },
                    // title: 'facebook_string'.tr(),
                    image: 'Twitter.png',
                  ),
                  ContactUsInfoTile(
                    onTap: () async {
                      final Uri launchUri = Uri(
                        scheme: 'https',
                        path: 'www.instagram.com/dotsapp_sa/',
                      );
                      await _launchInBrowser(launchUri);
                      logger.i(launchUri);
                    },
                    // title: 'instagram_string'.tr(),
                    image: 'insta.png',
                  ),
                  ContactUsInfoTile(
                    onTap: () async {
                      final Uri launchUri = Uri(
                        scheme: 'https',
                        path: 'www.youtube.com/',
                      );
                      await _launchInBrowser(launchUri);
                      logger.i(launchUri);
                    },
                    // title: 'youtube_string'.tr(),
                    image: 'youtube.png',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContactUsInfoTile extends StatelessWidget {
  const ContactUsInfoTile({
    Key? key,
    required this.image,
    this.title,
    required this.onTap,
  }) : super(key: key);
  final String? title;
  final String image;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(
              child: Image.asset(
                AssetsFile.images(image),
                height: 32,
                width: 32,
              ),
            ),
            GP.g16(),
            Expanded(
              child: Text(
                title ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
