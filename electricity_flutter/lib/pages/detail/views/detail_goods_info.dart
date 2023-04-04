import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailWebWidget extends StatefulWidget {
  const DetailWebWidget(
      {Key? key, required this.goodInfo, required this.webHeight})
      : super(key: key);
  final String goodInfo;
  final Function(double height) webHeight;

  @override
  State<DetailWebWidget> createState() => _DetailWebWidgetState();
}

class _DetailWebWidgetState extends State<DetailWebWidget> {
  late WebViewController? _webController;
  double webHeight = 100;

  @override
  void initState() {
    String htmlStr = _expandHtmlStr(widget.goodInfo);
    _webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('Resize', onMessageReceived: (message) {
        setState(() {
          webHeight = double.parse(message.message);
        });
        widget.webHeight(webHeight);
      })
      ..loadHtmlString(htmlStr);

    super.initState();
  }

  @override
  void dispose() {
    _webController?.clearCache();
    _webController?.clearLocalStorage();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.goodInfo.isEmpty) return const SizedBox();
    return SizedBox(
      height: webHeight,
      child: WebViewWidget(
        controller: _webController!,
      ),
    );
  }

  String _expandHtmlStr(String htmlStr) {
    String resultStr = """
   <!DOCTYPE html>
        <html>
        <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
          <body>
          $htmlStr
          </body>
        </html>
        <script>
          const resizeObserver = new ResizeObserver(entries =>
          Resize.postMessage(document.documentElement.scrollHeight.toString()) )
          resizeObserver.observe(document.body)
        </script>
  """;
    return resultStr;
  }
}
