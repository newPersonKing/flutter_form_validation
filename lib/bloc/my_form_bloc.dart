import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class MyFormBloc extends Bloc<MyFormEvent, MyFormState> {
  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  @override
  MyFormState get initialState => MyFormState.initial();

  /*这个方法 啥也干不了 只能添加一些日志 输出*/
  @override
  void onTransition(Transition<MyFormEvent, MyFormState> transition) {
    print(transition);
  }

  /*先执行 mapEventToState 再执行 onTransition*/
  @override
  Stream<MyFormState> mapEventToState(
    MyFormEvent event,
  ) async* {
    print("mapEventToState");
    if (event is EmailChanged) {
      yield currentState.copyWith(
        email: event.email,
        isEmailValid: _isEmailValid(event.email),
      );
    }
    if (event is PasswordChanged) {
      yield currentState.copyWith(
        password: event.password,
        isPasswordValid: _isPasswordValid(event.password),
      );
    }
    if (event is FormSubmitted) {
      yield currentState.copyWith(formSubmittedSuccessfully: true);
    }
    if (event is FormReset) {
      yield MyFormState.initial();
    }
  }

  bool _isEmailValid(String email) {
    return _emailRegExp.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
