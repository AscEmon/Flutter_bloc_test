import 'package:bloc_test/utils/enum.dart';

class SignInState {
  SignInState({
    this.allPostStatus = AllPostStatus.initial,
    this.passwordShow = false,
    this.isValidated = false,
  });

  final AllPostStatus allPostStatus;
  final bool passwordShow;
  final bool isValidated;

  SignInState copyWith({
    AllPostStatus? allPostStatus,
    bool? passwordShow,
    bool? isValidated,
  }) {
    return SignInState(
      allPostStatus: allPostStatus ?? this.allPostStatus,
      passwordShow: passwordShow ?? this.passwordShow,
      isValidated: isValidated ?? this.isValidated,
    );
  }
}
