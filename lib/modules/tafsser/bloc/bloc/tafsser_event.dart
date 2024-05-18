part of 'tafsser_bloc.dart';

sealed class TafsserEvent extends Equatable {
  const TafsserEvent();

  @override
  List<Object> get props => [];
}

class GetDreams extends TafsserEvent {}

class GetSingleDream extends TafsserEvent {
  final String dreamId;

  const GetSingleDream({required this.dreamId});

  @override
  List<Object> get props => [dreamId];
}

class CreateDream extends TafsserEvent {
  final DreamDetail dreamDetail;
  final String lang;
  final File voiceRecord;

  const CreateDream(
      {required this.dreamDetail,
      required this.lang,
      required this.voiceRecord});
}
