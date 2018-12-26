import 'package:examples_bloc/apps/login/provider.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginProvider bloc = LoginProviderImplementation();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 18.0),
              child: StreamBuilder<String>(
                stream: bloc.email,
                builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                  print(bloc.email);
                  return TextField(
                    onChanged: bloc.onChangeEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "ex: acbacb@gmail.com",
                      labelText: "Email",
                      errorText: snapshot.error,
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 18.0),
              child: StreamBuilder<String>(
                stream: bloc.password,
                builder: (BuildContext ctx, AsyncSnapshot snapshot) =>
                    TextField(
                      onChanged: bloc.onChangePassword,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "*******",
                        labelText: "Password",
                        errorText: snapshot.error,
                      ),
                    ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 18.0),
              child: StreamBuilder<bool>(
                stream: bloc.disabledBtn,
                builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                  return RaisedButton(
                    onPressed: snapshot.hasData ? () {} : null,
                    child: Text('Submit'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
