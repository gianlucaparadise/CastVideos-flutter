import 'package:cast_videos_flutter/cast/cast_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cast_framework/widgets.dart';
import 'package:provider/provider.dart';

void openQueueList(BuildContext context) {
  Navigator.of(context, rootNavigator: true)
      .pushNamed(QueueListRoute.routeName);
}

class QueueListRoute extends StatelessWidget {
  static const routeName = "/QueueList";

  const QueueListRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final castManager = Provider.of<CastManager>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Queue"),
        actions: [
          CastButton(
            castFramework: castManager.castFramework,
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          "Queue is empty!",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
