import 'dart:async';
import 'package:examples_bloc/apps/login/validators.dart';
import 'package:rxdart/rxdart.dart';

abstract class LoginProvider {
  void dispose();
  Function(String) get onChangeEmail;
  Function(String) get onChangePassword;
  // (another way)
  // StreamSink<String> get onChangeEmail;
  // StreamSink<String> get onChangePassword;
  Stream<String> get email;
  Stream<String> get password;
  Stream<bool> get disabledBtn;
}

class LoginProviderImplementation extends Object
    with Validators
    implements LoginProvider {
  final StreamController _emailController = PublishSubject<String>();
  final StreamController _passwordController = PublishSubject<String>();

  // (another way)
  Function(String) get onChangeEmail => _emailController.sink.add;
  Function(String) get onChangePassword => _passwordController.sink.add;

  // handle on change (another way)
  // StreamSink<String> get onChangeEmail => _emailController.sink;
  // StreamSink<String> get onChangePassword => _passwordController.sink;

  // transform the value, whenever handle on change already doen
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  Stream<bool> get disabledBtn =>
      Observable.combineLatest2(email, password, (a, b) => true);

  @override
  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
