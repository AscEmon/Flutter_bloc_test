import 'package:bloc_test/data_provider/api_client.dart';
import 'package:bloc_test/mvc/signin_module/bloc/signin_event.dart';
import 'package:bloc_test/mvc/signin_module/bloc/signin_state.dart';
import 'package:bloc_test/utils/enum.dart';
import 'package:bloc_test/utils/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final ApiClient apiClient = ApiClient();
  final formKey = GlobalKey<FormState>();
  TextEditingController loginPhoneNumber = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  bool obscureText = false;
  bool isTextEditingEmpty = false;

  SignInBloc() : super(SignInState()) {
    on<SignInSubmitEvent>(_signInFunction);
    on<PasswordShowEvent>(_toggle);
    on<ValidateEvent>(_Validated);
  }

  void _signInFunction(
    SignInEvent signInEvent,
    Emitter<SignInState> emit,
  ) async {
    final map = Map<String, dynamic>();
    map['phone_number'] = loginPhoneNumber.text.toString();
    map['password'] = loginPassword.text.toString();
    map.log();

    try {
      if (formKey.currentState!.validate()) {
        emit(SignInState(allPostStatus: AllPostStatus.loading));
        map.log();
        await Future.delayed(const Duration(seconds: 2));
        loginPhoneNumber.clear();
        loginPassword.clear(); 
        emit(state.copyWith(allPostStatus: AllPostStatus.success));
        "isCalled".log();
      }
    } on Exception catch (e) {
      e.log();
      emit(state.copyWith(allPostStatus: AllPostStatus.error));
    }
  }

  void _toggle(SignInEvent signInEvent, Emitter<SignInState> emit) {
    obscureText = !obscureText;
    obscureText.log();
    emit(state.copyWith(passwordShow: obscureText));
  }

  void _Validated(SignInEvent signInEvent, Emitter<SignInState> emit) {
    if (loginPhoneNumber.text.isNotEmpty && loginPassword.text.isNotEmpty) {
      emit(state.copyWith(isValidated: true));
    } else {
      emit(state.copyWith(isValidated: false));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    loginPassword.dispose();
    loginPhoneNumber.dispose();
    formKey.currentState?.dispose();
    return super.close();
  }
}
