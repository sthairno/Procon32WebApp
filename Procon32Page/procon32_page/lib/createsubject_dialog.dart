import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as imglib;
import 'tabstepper.dart';

class _SubjectData {
  String? displayName = null;

  int? maxSelectCount = null;

  int? selectionCost = null;

  int? swapCost = null;

  int? peaceCntX = null;

  int? peaceCntY = null;

  imglib.Image? image = null;
}

class CreateSubjectDialog extends StatefulWidget {
  const CreateSubjectDialog({Key? key}) : super(key: key);

  @override
  _CreateSubjectDialogState createState() => _CreateSubjectDialogState();
}

class _CreateSubjectDialogState extends State<CreateSubjectDialog> {
  late _SubjectData data;

  late Uint8List _imageBuff;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    data = new _SubjectData();
  }

  String? _validateIntegerString(String? value, int min, int max) {
    if (value == null) {
      return "整数値を入力してください";
    }
    var intVal = int.tryParse(value);
    if (intVal == null) {
      return "整数値を入力してください";
    }
    if (intVal < min || max < intVal) {
      return "$min~$maxの範囲で入力してください";
    }
    return null;
  }

  Widget _buildPeaceCountPicker() => Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Expanded(
            child: DropdownButtonFormField(
              value: data.peaceCntX,
              onChanged: (value) {
                setState(() {
                  data.peaceCntX = value as int?;
                });
              },
              validator: (value) => value == null ? "選択してください" : null,
              decoration: InputDecoration(labelText: "横分割数"),
              items: List.generate(
                16,
                (index) => index == 0
                    ? DropdownMenuItem<int>(child: Text(""))
                    : DropdownMenuItem<int>(
                        value: index + 1,
                        child: Text("${index + 1}"),
                      ),
              ),
            ),
          ),
          Text(" x "),
          Expanded(
            child: DropdownButtonFormField(
              value: data.peaceCntY,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    data.peaceCntY = value as int?;
                  });
                }
              },
              validator: (value) => value == null ? "選択してください" : null,
              decoration: InputDecoration(labelText: "縦分割数"),
              items: List.generate(
                16,
                (index) => index == 0
                    ? DropdownMenuItem<int>(child: Text(""))
                    : DropdownMenuItem<int>(
                        value: index + 1,
                        child: Text("${index + 1}"),
                      ),
              ),
            ),
          ),
        ],
      );

  Widget? _buildPeacePreviewGrid() =>
      data.peaceCntX != null && data.peaceCntY != null
          ? AspectRatio(
              aspectRatio: data.peaceCntX! / data.peaceCntY!,
              child: GridView.count(
                crossAxisCount: data.peaceCntX!,
                children: List.generate(
                  data.peaceCntX! * data.peaceCntY!,
                  (index) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 0.6,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null;

  Widget _buildImageUploader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600.0, maxHeight: 400.0),
        child: InkWell(
          onTap: () async {
            var validateResult = await () async {
              var result = await FilePicker.platform
                  .pickFiles(withData: true, type: FileType.image);
              if (result == null) {
                return null;
              }
              var file = result.files[0];
              if (file.bytes == null) {
                return "ファイルを開けませんでした";
              }
              var image = imglib.decodeImage(file.bytes!);
              if (image == null) {
                return "ファイルを読み込めませんでした";
              }
              setState(() {
                data.image = image;
                _imageBuff =
                    imglib.encodeJpg(imglib.copyResize(data.image!, width: 400))
                        as Uint8List;
              });
              return null;
            }();
            if (validateResult != null) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(validateResult)));
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade600, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: data.image == null
                ? Stack(
                    children: [
                      Center(
                        child: const Icon(Icons.image),
                      ),
                      _buildPeacePreviewGrid()
                    ].whereType<Widget>().toList(),
                  )
                : AspectRatio(
                    aspectRatio: data.image!.width / data.image!.height,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Positioned.fill(
                            child: Image.memory(_imageBuff, fit: BoxFit.fill)),
                        _buildPeacePreviewGrid(),
                      ].whereType<Widget>().toList(),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  TabStep _buildParamStep() => TabStep(
        name: "パラメーター設定",
        validate: () => _formKey.currentState!.validate(),
        onFinish: () => _formKey.currentState!.save(),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: "表示名"),
                    maxLength: 32,
                    validator: (value) {
                      if (value == null || value.length < 3) {
                        return "3文字以上入力してください";
                      }
                      if (!RegExp("^[^\\p{C}\\s]+\$", unicode: true)
                          .hasMatch(value)) {
                        return "^[^\\p{C}\\s]+\$";
                      }
                      return null;
                    },
                    onSaved: (value) => data.displayName = value!,
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: "最大選択回数", counterText: ""),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 3,
                    validator: (value) => _validateIntegerString(value, 2, 128),
                    onSaved: (value) => data.maxSelectCount = int.parse(value!),
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: "選択コスト", counterText: ""),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 3,
                    validator: (value) => _validateIntegerString(value, 1, 500),
                    onSaved: (value) => data.selectionCost = int.parse(value!),
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: "交換コスト", counterText: ""),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 3,
                    validator: (value) => _validateIntegerString(value, 1, 100),
                    onSaved: (value) => data.swapCost = int.parse(value!),
                  ),
                  Text("原画像"),
                  _buildPeaceCountPicker(),
                  _buildImageUploader(),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("課題を作成"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("作成"))
        ],
      ),
      body: TabStepper(
        onCancel: () => Navigator.pop(context),
        onFinish: () => Navigator.pop(context),
        steps: [
          _buildParamStep(),
          TabStep(name: "A", content: Container()),
          TabStep(name: "B", content: Container())
        ],
      ),
    );
  }
}
