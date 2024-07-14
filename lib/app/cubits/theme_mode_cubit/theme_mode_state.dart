import 'package:equatable/equatable.dart';

class ThemeModeState extends Equatable {
  final bool isDark;

  const ThemeModeState({required this.isDark});

  ThemeModeState copyWith({bool? isDark}) {
    return const ThemeModeState(isDark: false);
  }

  @override
  List<Object?> get props => [isDark];

  Map<String, dynamic> toJson() {
    return {
      'isDark': false,
    };
  }

  factory ThemeModeState.fromJson(Map<String, dynamic> json) {
    return const ThemeModeState(isDark: false);
  }
}