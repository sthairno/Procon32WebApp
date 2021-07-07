import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openapi/openapi.dart' as api;
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as imglib;
import 'package:cool_stepper/cool_stepper.dart';

class _PeaceData {
  int dispIdx;

  int rotAngle;

  _PeaceData({required this.dispIdx, this.rotAngle = 0}) {}
}

class _SubjectData {
  String? displayName = null;

  int? maxSelectCount = null;

  int? selectionCost = null;

  int? swapCost = null;

  int? peaceCntX = null;

  int? peaceCntY = null;

  imglib.Image? baseImage = null;

  List<_PeaceData> peaces = [];
}

class _PeaceTmpData {
  Uint8List thumbnail;

  Key widgetKey;

  _PeaceTmpData({required this.thumbnail}) : widgetKey = UniqueKey() {}
}

class PuzzleEditor extends StatefulWidget {
  const PuzzleEditor({Key? key, required this.data, this.visible = true})
      : super(key: key);

  final _SubjectData data;

  final bool visible;

  @override
  _PuzzleEditorState createState() => _PuzzleEditorState();
}

class _PuzzleEditorState extends State<PuzzleEditor> {
  late List<_PeaceTmpData> _peaceTmpData;

  bool _initialized = false;

  void _deleteData() {
    if (!_initialized) {
      return;
    }
    _peaceTmpData = [];
    widget.data.peaces = [];

    _initialized = false;
  }

  void _initData() {
    if (_initialized) {
      return;
    }
    int aryLength = widget.data.peaceCntX! * widget.data.peaceCntY!;
    int peaceSize = widget.data.baseImage!.width ~/ widget.data.peaceCntX!;
    int thumbnailPeaceSize = 400 ~/ widget.data.peaceCntX!;
    bool requiredResize = peaceSize > thumbnailPeaceSize;

    _peaceTmpData = List.generate(aryLength, (index) {
      int x = index % widget.data.peaceCntX!;
      int y = index ~/ widget.data.peaceCntX!;

      var peaceImg = imglib.copyCrop(widget.data.baseImage!, x * peaceSize,
          y * peaceSize, peaceSize, peaceSize);

      if (requiredResize) {
        peaceImg = imglib.copyResize(peaceImg, width: thumbnailPeaceSize);
      }

      return _PeaceTmpData(thumbnail: imglib.encodeJpg(peaceImg) as Uint8List);
    });

    widget.data.peaces =
        List.generate(aryLength, (index) => _PeaceData(dispIdx: index));

    _initialized = true;
  }

  void _updateData() {
    if (widget.visible) {
      _initData();
    } else {
      _deleteData();
    }
  }

  Widget _buildRotButton(_PeaceData data, _PeaceTmpData tmpData) => RotatedBox(
        quarterTurns: data.rotAngle,
        child: Image.memory(
          tmpData.thumbnail,
          width: double.infinity,
          key: tmpData.widgetKey,
          fit: BoxFit.cover,
        ),
      );

  Widget _buildPeaceWidget(int dispIdx) {
    var dataIdx =
        widget.data.peaces.indexWhere((data) => data.dispIdx == dispIdx);
    var data = widget.data.peaces[dataIdx];
    var tmpData = _peaceTmpData[dataIdx];

    return DragTarget(
      builder: (buildercontext, candidateData, rejectedData) {
        return Draggable(
            data: dataIdx,
            feedback: Image.memory(tmpData.thumbnail),
            child: candidateData.length > 0
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.red.shade100,
                  )
                : dispIdx == 0
                    ? _buildRotButton(data, tmpData)
                    : TextButton(
                        onPressed: () {
                          setState(() {
                            data.rotAngle = (data.rotAngle + 1) % 4;
                          });
                        },
                        child: _buildRotButton(data, tmpData),
                      ),
            childWhenDragging: Container());
      },
      onWillAccept: (_) => true,
      onAccept: (targetDataIdx) {
        if (targetDataIdx is int) {
          var targetData = widget.data.peaces[targetDataIdx];

          setState(() {
            // 交換元,交換先のピースが座標00のとき回転を戻す
            if (data.dispIdx == 0) {
              targetData.rotAngle = 0;
            }
            if (targetData.dispIdx == 0) {
              data.rotAngle = 0;
            }

            // 交換
            var tmp = data.dispIdx;
            data.dispIdx = targetData.dispIdx;
            targetData.dispIdx = tmp;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    _updateData();
    return _initialized
        ? AspectRatio(
            aspectRatio: widget.data.peaceCntX! / widget.data.peaceCntY!,
            child: GridView.count(
              crossAxisCount: widget.data.peaceCntX!,
              children: List.generate(
                widget.data.peaces.length,
                (dispIdx) => _buildPeaceWidget(dispIdx),
              ),
            ),
          )
        : Container();
  }
}

class CreateSubjectDialog extends StatefulWidget {
  const CreateSubjectDialog({Key? key}) : super(key: key);

  @override
  _CreateSubjectDialogState createState() => _CreateSubjectDialogState();
}

class _CreateSubjectDialogState extends State<CreateSubjectDialog> {
  late _SubjectData data;

  bool _isParamValid = false;

  imglib.Image? _selectedImage;

  Uint8List? _selectedImageThumbnail;

  final _paramFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    data = new _SubjectData();
  }

  void _createSelectedImageThumbnail() {
    const int maxWidth = 600;
    const int maxHeight = 400;

    var scale = min(
        maxWidth / _selectedImage!.width, maxHeight / _selectedImage!.height);

    if (scale < 1) {
      _selectedImageThumbnail = imglib.encodeJpg(imglib.copyResize(
          _selectedImage!,
          width: (_selectedImage!.width * scale).round(),
          height: (_selectedImage!.height * scale).round())) as Uint8List;
    } else {
      _selectedImageThumbnail = imglib.encodeJpg(_selectedImage!) as Uint8List;
    }
  }

  void _createClippedImage() {
    int peaceSize = min(_selectedImage!.width ~/ data.peaceCntX!,
        _selectedImage!.height ~/ data.peaceCntY!);
    int imgWidth = peaceSize * data.peaceCntX!;
    int imgHeight = peaceSize * data.peaceCntY!;
    data.baseImage = imglib.copyCrop(
        _selectedImage!,
        (_selectedImage!.width - imgWidth) ~/ 2,
        (_selectedImage!.height - imgHeight) ~/ 2,
        imgWidth,
        imgHeight);
  }

  // パラメーター設定

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
                _isParamValid = false;
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
                  _isParamValid = false;
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
                        color: Colors.red,
                        width: 0.6,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null;

  String? _loadImage(Uint8List bytes) {
    var image = imglib.decodeImage(bytes);
    if (image == null) {
      return "ファイルを読み込めませんでした";
    }
    if (image.width < 32 ||
        2048 < image.width ||
        image.height < 32 ||
        2048 < image.height) {
      return "画像の幅,高さは32px~2048pxである必要があります";
    }
    setState(() {
      _selectedImage = image;
      _createSelectedImageThumbnail();
      data.baseImage = null;
    });
    _isParamValid = false;
    return null;
  }

  Widget _buildImageSelector() {
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
              return _loadImage(file.bytes!);
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
            child: _selectedImage == null
                ? Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Center(
                        child: const Icon(Icons.image),
                      ),
                      _buildPeacePreviewGrid()
                    ].whereType<Widget>().toList(),
                  )
                : AspectRatio(
                    aspectRatio: _selectedImage!.width / _selectedImage!.height,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Positioned.fill(
                            child: Image.memory(_selectedImageThumbnail!,
                                fit: BoxFit.fill)),
                        _buildPeacePreviewGrid(),
                      ].whereType<Widget>().toList(),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  CoolStep _buildParamStep() => CoolStep(
        title: "パラメーター設定",
        subtitle: "",
        validation: () {
          var noError = (_paramFormKey.currentState!.validate() &&
              _selectedImage != null);
          if (noError) {
            setState(() {
              _paramFormKey.currentState!.save();
              _createClippedImage();
            });
          }
          _isParamValid = noError;
          return noError ? null : "Error";
        },
        content: Form(
          key: _paramFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: data.displayName,
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
                  initialValue: data.maxSelectCount?.toString(),
                  decoration:
                      InputDecoration(labelText: "最大選択回数", counterText: ""),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 3,
                  validator: (value) => _validateIntegerString(value, 2, 128),
                  onSaved: (value) => data.maxSelectCount = int.parse(value!),
                ),
                TextFormField(
                  initialValue: data.selectionCost?.toString(),
                  decoration:
                      InputDecoration(labelText: "選択コスト", counterText: ""),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 3,
                  validator: (value) => _validateIntegerString(value, 1, 500),
                  onSaved: (value) => data.selectionCost = int.parse(value!),
                ),
                TextFormField(
                  initialValue: data.swapCost?.toString(),
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
                _buildImageSelector(),
              ],
            ),
          ),
        ),
      );

  CoolStep _buildPeaceStep() => CoolStep(
        title: "並べ替え",
        subtitle: "ピースをドラッグして交換、タップして90度ずつ回転することができます",
        content: PuzzleEditor(
          data: data,
          visible: _isParamValid,
        ),
        validation: () => null,
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
      body: CoolStepper(
        onCompleted: () => Navigator.pop(context),
        config: CoolStepperConfig(
          backText: "戻る",
          nextText: "次へ",
          stepText: "",
          ofText: "/",
          finalText: "生成",
        ),
        steps: [
          _buildParamStep(),
          _buildPeaceStep(),
        ],
      ),
    );
  }
}
