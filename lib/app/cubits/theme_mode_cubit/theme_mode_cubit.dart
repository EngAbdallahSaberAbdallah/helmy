// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:helmy_project_flutter/app/cubits/theme_mode_cubit/theme_mode_state.dart';

// class ThemeModeCubit extends HydratedCubit<ThemeModeState> {
//   ThemeModeCubit() : super(const ThemeModeState(isDark: true)); // Initial state

//   void toggleTheme() {
//     emit(state.copyWith(isDark: !state.isDark));
//   }

//   @override
//   ThemeModeState? fromJson(Map<String, dynamic> json) {
//     return ThemeModeState.fromJson(json);
//   }

//   @override
//   Map<String, dynamic>? toJson(ThemeModeState state) {
//     return state.toJson();
//   }
// }