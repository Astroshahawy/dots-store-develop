import 'package:dots/core/route/route_name.dart';
import 'package:dots/core/route/routes.dart';
import 'package:dots/l10n/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../core/utils/assets_file.dart';
import '../../../../../core/utils/local_storage/local_storage.dart';
import '../../../../../core/utils/local_storage/storage_keys.dart';

class CategoriesGridWidget extends StatelessWidget {
  const CategoriesGridWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme myColor = context.schemeGx;
    final userTypeINT = Storage.getInt(StorageAuthKeys.userTypeINT);

    return Container(
      decoration: BoxDecoration(
        color: myColor.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: SingleChildScrollView(
        child: userTypeINT == 1 // If Employee
            ? StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  CategoryItem(
                    title: LocaleKeys.givePoints.tr(),
                    icon: 'give points.png',
                    onTap: () {
                      context.pushName(RouteName.awardPoints);
                    },
                  ),
                  CategoryItem(
                    title: LocaleKeys.giveCashback.tr(),
                    icon: 'give cashback.png',
                    onTap: () {
                      context.pushName(RouteName.cashback);
                    },
                  ),
                ],
              )
            : StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  CategoryItem(
                    title: LocaleKeys.givePoints.tr(),
                    icon: 'give points.png',
                    onTap: () {
                      context.pushName(RouteName.awardPoints);
                    },
                  ),
                  CategoryItem(
                    title: LocaleKeys.giveCashback.tr(),
                    icon: 'give cashback.png',
                    onTap: () {
                      context.pushName(RouteName.cashback);
                    },
                  ),
                  CategoryItem(
                    icon: 'offers packs.png',
                    title: LocaleKeys.offerPackages.tr(),
                    onTap: () {
                      context.pushName(RouteName.offerPackagesPage);
                    },
                  ),
                  CategoryItem(
                    icon: 'my invoices.png',
                    title: LocaleKeys.organizationBills.tr(),
                    onTap: () {
                      context.pushName(RouteName.invoicePage);
                    },
                  ),
                  CategoryItem(
                    title: LocaleKeys.subscribePackages.tr(),
                    icon: 'offers packs.png',
                    onTap: () {
                      context.pushName(RouteName.packagesPage);
                    },
                  ),
                  CategoryItem(
                    title: 'giveMeal'.tr(),
                    icon: 'give pormotional meals.png',
                    onTap: () {
                      context.pushName(RouteName.giveMeal);
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final String icon;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    // final myColor = context.schemeGx;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: ClipOval(
              child: Image.asset(AssetsFile.images(icon)),
            ),
          ),
          Text(
            title,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
          ).boldGx().fontSizeGx(12),
        ],
      ),
    );
  }
}
