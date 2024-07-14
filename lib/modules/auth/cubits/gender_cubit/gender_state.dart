import 'package:equatable/equatable.dart';

enum Gender { male, female }

class GenderState extends Equatable {
  final Gender selectedGender;

  const GenderState(this.selectedGender);

  @override
  List<Object?> get props => [selectedGender];
}