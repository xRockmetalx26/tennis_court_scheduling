import 'package:flutter/material.dart';

class DataLoader {
  static Future<T?> loadData<T>(BuildContext context, Function loaderFunction,
      {Widget indicator =
          const CircularProgressIndicator()}) async {
    T? data = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Center(
                  child: FutureBuilder<T>(
                      future: loaderFunction(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          Navigator.of(context).pop(snapshot.data);
                        }

                        return indicator;
                      })));
        });

    return data;
  }
}