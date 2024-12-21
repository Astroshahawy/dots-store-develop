import 'package:dots/core/utils/const_file.dart';
import 'package:dots/injection/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/wrap_service.dart';
import '../../logic/static_pages_cubit/static_pages_cubit.dart';
import '../widgets/expandable_widget.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StaticPagesCubit>(
      create: (_) => injector<StaticPagesCubit>()..staticPagesCu(ConstString.privacyPolicy),
      child: const _PrivacyPolicyBody(),
    );
  }
}

class _PrivacyPolicyBody extends StatelessWidget {
  const _PrivacyPolicyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'privacy_policy_str'.tr(),
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: BlocBuilder<StaticPagesCubit, StaticPagesState>(
        builder: (context, state) {
          return WrapService(
            status: state.status,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpandableWidget(
                  title: '${state.data[index].title}',
                  description: '${state.data[index].description}',
                );
              },
            ),
          );
        },
      ),
    );
  }
}
