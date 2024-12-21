import 'package:dots/app/features/add_employee/logic/cubit/add_employee_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/features/auth/logic/blocs/login_bloc/login_bloc.dart';
import 'app/features/auth/logic/blocs/redirect_cubit/redirect_cubit.dart';
import 'app/features/give_user/logic/cubit/give_user_cubit.dart';
import 'app/features/home/logic/cubit/home_cubit.dart';
import 'app/features/invoice/logic/cubit/invoice_cubit.dart';
import 'injection/injection_container.dart';

List<BlocProvider> providers = [
  BlocProvider<LoginBloc>(create: (context) => injector<LoginBloc>()),
  BlocProvider<GiveUserCubit>(create: (context) => injector<GiveUserCubit>()),
  BlocProvider<EmployeeCubit>(
      create: (context) => injector<EmployeeCubit>()..fetchEmployees()),
  BlocProvider<HomeCubit>(
      create: (context) => injector<HomeCubit>()..fetchSlider()),
  BlocProvider<RedirectCubit>(create: (context) => RedirectCubit()),
  BlocProvider<InvoiceCubit>(
      create: (context) => injector<InvoiceCubit>()..getInvoicesUnpaid()),
];
