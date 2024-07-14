class PinCodeState {
  final bool isCompleted;
  final String otp;

  PinCodeState(this.isCompleted, this.otp);

  PinCodeState copyWith({bool? isCompleted, String? otp}) {
    return PinCodeState(
      isCompleted ?? this.isCompleted,
      otp ?? this.otp,
    );
  }
}