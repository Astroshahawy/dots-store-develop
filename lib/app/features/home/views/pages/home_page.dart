import 'package:dots/app/features/home/views/pages/grid_view.dart';
import 'package:dots/core/network/wrap_service.dart';
import 'package:dots/core/route/routes.dart';
import 'package:dots/core/utils/const_file.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../../core/route/route_name.dart';
import '../../../../../core/utils/assets_file.dart';
import '../../../../components/custom_app_bar.dart';
import '../../../drawer/drawer.dart';
import '../../logic/cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeCubit>().fetchSlider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColor = context.schemeGx;
    // var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      // key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: const AppDrawer(),
      appBar: CustomAppBar(
        backgroundColor: context.schemeGx.primaryContainer,
        centerTitle: true,
        title: SvgPicture.asset(
          AssetsFile.svg('logo2.svg'),
          color: context.themeGx.colorScheme.onBackground,
          height: 25,
        ),
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Iconify(
              Bx.menu_alt_right,
              size: 35,
            ),
          );
        }),
        actions: [
          IconButton(
            onPressed: () {
              context.pushName(RouteName.notificationPage);
            },
            icon: Iconify(
              Ic.outline_notifications,
              size: 30,
              color: myColor.onPrimaryContainer,
            ),
          ),
        ],
      ),
      backgroundColor: myColor.primaryContainer,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            alignment: Alignment.topCenter,
            height: 360,
            color: myColor.primaryContainer,
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return state.data == null
                    ? const Text('قم بالاشتراك في باقه').boldGx().toCenter()
                    : WrapService(
                        status: state.status,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Divider(color: myColor.background),
                            // GP.g16(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      state.data == null
                                          ? const SizedBox.shrink()
                                          : Text(
                                              '${state.data?.description}',
                                              style: context.bodyLargeGx,
                                            ),
                                      state.data == null
                                          ? const SizedBox.shrink()
                                          : Text(
                                              '${'remainig_str'.tr()} ${state.data?.remainCustomersNumber} ${'client_str'.tr()}',
                                              style: context.labelSmallGx,
                                            ),
                                      Text(
                                        'cashback_str'.tr(),
                                        style: context.labelSmallGx,
                                      ),
                                    ],
                                  ),
                                  // GP.g16(),
                                  // GP.g4(),
                                  const Spacer(),
                                  CircularPercentIndicator(
                                    radius: 38.0,
                                    lineWidth: 10.0,
                                    percent: state.data == null
                                        ? 0.0
                                        : double.tryParse(
                                                '${state.data?.usagePercentage}') ??
                                            0.0,
                                    center: state.data!.usagePercentage == null
                                        ? const SizedBox.shrink()
                                        : Text(
                                            '${double.tryParse(state.data!.usagePercentage.toString()) ?? 0.0 * 100}%',
                                            style:
                                                context.bodyLargeGx?.copyWith(
                                              color: myColor.primary,
                                            ),
                                          ),
                                    progressColor: myColor.primary,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const SizedBox(
                                    height: 100,
                                    child: VerticalDivider(
                                      color: Colors.white60,
                                      width: 2,
                                      thickness: 2.5,
                                      endIndent: 1,
                                      indent: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),

                                  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        state.data == null
                                            ? const SizedBox.shrink()
                                            : Text(
                                                '${state.data?.description}',
                                                style: context.bodyLargeGx,
                                              ),
                                        state.data == null
                                            ? const SizedBox.shrink()
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    state.data?.dateM
                                                                ?.mealName ==
                                                            'null'
                                                        ? ''
                                                        : '${state.data?.dateM?.mealName}',
                                                    style: context.labelSmallGx,
                                                  ),
                                                  Text(
                                                    state.data?.dateM
                                                                ?.remainCustomersNumber ==
                                                            'null'
                                                        ? '${'remainig_str'.tr()} 0  ${'client_str'.tr()}'
                                                        : '${'remainig_str'.tr()} ${state.data?.dateM?.remainCustomersNumber} ${'client_str'.tr()}',
                                                    style: context.labelSmallGx,
                                                  ),
                                                  Text(
                                                    'free'.tr(),
                                                    style: context.labelSmallGx,
                                                  ),
                                                ],
                                              ),
                                      ]),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
                                  const Spacer(),
                                  CircularPercentIndicator(
                                    radius: 38.0,
                                    lineWidth: 10.0,
                                    percent: state.data == null
                                        ? 0.0
                                        : double.tryParse(
                                                '${state.data?.dateM?.usagePercentage}') ??
                                            0.0,
                                    center: state.data!.usagePercentage == null
                                        ? const SizedBox.shrink()
                                        : Text(
                                            '${double.tryParse(state.data!.usagePercentage.toString()) ?? 0.0 * 100}%',
                                            style:
                                                context.bodyLargeGx?.copyWith(
                                              color: Colors.orange,
                                            ),
                                          ),
                                    progressColor: Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                            GP.g24(),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: myColor.background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                // 'انت غير مشترك في اي باقه حاليا',
                                'total_clients_remainig_str'.tr(),
                                style: context.bodySmallGx,
                              ),
                            ),
                            GP.g4(),
                            // GP.g16(),
                            SizedBox(
                              height: 40,
                              child: ListView.separated(
                                padding: const EdgeInsets.only(bottom: 16),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    width: 2,
                                  );
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return Icon(
                                    Icons.star,
                                    color: index <= state.data!.rating! - 1
                                        ? Colors.orange
                                        : Colors.grey,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .57,
              child: const CategoriesGridWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
