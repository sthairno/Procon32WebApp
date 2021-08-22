import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as api;

class SubjectDetailsDialog extends StatelessWidget {
  const SubjectDetailsDialog(
    this.subject, {
    Key? key,
  }) : super(key: key);

  final api.Subject subject;

  void _downloadFile(String url) {
    html.AnchorElement anchorElement = new html.AnchorElement(href: url);
    anchorElement.download = url.split('/').last;
    anchorElement.click();
  }

  Widget _buildDetailsWidget() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("課題名: ${subject.name}"),
            Text("課題ID: ${subject.id}"),
            Text("原画像ID: ${subject.baseImageId}"),
            Text("作成者ID: ${subject.createdUserId}"),
            Text("作成日: ${subject.createdDateTime}"),
            Text("課題サイズ: ${subject.size!.width} x ${subject.size!.height}"),
            Text("ピース個数: ${subject.peaceCount.x} x ${subject.peaceCount.y}"),
            Text("最大選択回数: ${subject.maxSelectCount}"),
            Text("選択コスト: ${subject.selectionCost}"),
            Text("交換コスト: ${subject.swapCost}"),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: "ダウンロード",
            onPressed: () async {
              var result = await showDialog<String>(
                context: context,
                builder: (context) => SimpleDialog(
                  children: [
                    SimpleDialogOption(
                      child: Row(
                        children: [
                          const Icon(Icons.download),
                          Text("プレビュー画像をダウンロード(.png)"),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pop(context, "png");
                      },
                    ),
                    SimpleDialogOption(
                      child: Row(
                        children: [
                          const Icon(Icons.download),
                          Text("課題画像をダウンロード(.ppm)"),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pop(context, "ppm");
                      },
                    ),
                  ],
                ),
              );

              switch (result) {
                case "png":
                  _downloadFile(
                      "https://procon32.sthairno.dev${subject.previewFilePath}");
                  break;
                case "ppm":
                  _downloadFile(
                      "https://procon32.sthairno.dev${subject.subjectFilePath}");
                  break;
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: "情報",
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => BottomSheet(
                  onClosing: () {},
                  builder: (context) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          child: Text(
                            "課題情報",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                      const Divider(),
                      _buildDetailsWidget(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Image.network(
          "https://procon32.sthairno.dev${subject.previewFilePath}",
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
