import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';

class BaseRefreshFooter extends StatelessWidget {
  const BaseRefreshFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const Text("");
        } else if (mode == LoadStatus.loading) {
          body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = const Text("Load Failed! Click retry!");
        } else if (mode == LoadStatus.canLoading) {
          body = const Text("release to load more");
        } else {
          body = const Text("No more Data");
        }
        return SizedBox(
          height: 50.0,
          child: Center(child: body),
        );
      },
    );
  }
}
