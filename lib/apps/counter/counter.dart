import 'package:examples_bloc/apps/counter/provider.dart';
import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Provider bloc = ProviderImplementation();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Count visit'),
          StreamBuilder<int>(
            stream: bloc.counter,
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              return Text(snapshot.data);
            },
          ),
        ],
      ),
      floatingActionButton: StreamBuilder<int>(
        initialData: 1,
        builder: (BuildContext ctx, AsyncSnapshot snapshot) =>
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                bloc.onTapCounter(snapshot.data + 1);
              },
            ),
      ),
    );
  }
}
