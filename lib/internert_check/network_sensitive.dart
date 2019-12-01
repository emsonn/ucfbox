import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "connectivity_status.dart";

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final double opacity;

  const NetworkSensitive({this.child, this.opacity = 0.5});

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.WiFi ||
        connectionStatus == ConnectivityStatus.Cellular ||
        connectionStatus == null) {
      return child;
    }

    return AlertDialog(
      title: Text('Connection Problem'),
      content: Text('Please reconnect to a network.'),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {},
        )
      ],
    );
  }
}
