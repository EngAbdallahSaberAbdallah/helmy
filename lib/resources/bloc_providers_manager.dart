import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/dream/cubits/plans_cubit/cubit/plans_cubit.dart';
import '../modules/auth/blocs/auth_bloc/auth_bloc.dart';
import '../modules/auth/cubits/get_cities_cubit/get_cities_cubit.dart';
import '../modules/auth/cubits/governorate_and_city_cubit/governorate_and_city_cubit.dart';
import '../modules/auth/repository/auth_repository.dart';
import '../modules/dream/cubits/add_dream/cubit/add_dream_cubit.dart';
import '../modules/dream/cubits/draw_bottom_btns/dream_bottom_btn_cubit.dart';
import '../modules/dream/cubits/interpreter_cubit/cubit/interpreter_cubit.dart';
import '../modules/favourite/cubit/cubit/favourite_cubit/favourites_cubit.dart';
import '../modules/favourite/cubit/cubit/home_cubit/cubit/home_cubit.dart';
import '../modules/interpreter/start/cubits/interpreter_bottom_nav_bar_cubit.dart';
import '../modules/my_dreams/cubit/cubit/my_dreams_cubit.dart';
import '../modules/profile/repository/profile_repository.dart';
import '../modules/tafsser/bloc/bloc/tafsser_bloc.dart';
import '../modules/profile/cubit/profile_cubit.dart';
import 'package:provider/single_child_widget.dart';
import '../modules/start/cubits/bottom_nav_bar_cubit.dart';

List<SingleChildWidget> get blocProviderList {
  return [
    // BlocProvider(
    //   create: (context) => ThemeModeCubit(),
    // ),
    BlocProvider(create: (context) => AuthBloc(AuthRepository())),
    BlocProvider(create: (context) => CityCubit()),
    BlocProvider(create: (context) => GetCitiesCubit(AuthRepository())),
    BlocProvider(
      create: (context) => BottomNavBarCubit(),
    ),
    BlocProvider(
      create: (context) => InterpreterBottomNavBarCubit(),
    ),
    BlocProvider(
      create: (context) => HomeCubit(),
    ),

    BlocProvider(
      create: (context) => FavouritesCubit(),
    ),
    BlocProvider(
      create: (context) => DreamBottomBtnCubit(),
    ),
    BlocProvider(create: (context) => TafsserBloc()),
    BlocProvider(create: (context) => FavouritesCubit()),
    BlocProvider(create: (context) => MyDreamsCubit()),
    BlocProvider(create: (context) => AddDreamCubit()),
    BlocProvider(create: (context) => InterpreterCubit()),
    BlocProvider(create: (context) => PlansCubit()),
    BlocProvider(create: (context) => ProfileCubit(ProfileRepository())),
  ];
}
