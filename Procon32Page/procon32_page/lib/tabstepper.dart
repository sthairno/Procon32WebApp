import 'dart:math';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class TabStep {
  TabStep(
      {required this.name,
      required this.builder,
      this.validate,
      this.onFinish});

  final String name;

  final Widget Function() builder;

  final bool Function()? validate;

  final VoidCallback? onFinish;
}

class TabStepper extends StatefulWidget {
  TabStepper({Key? key, required this.steps, this.onCancel, this.onFinish})
      : super(key: key);

  final List<TabStep> steps;

  final VoidCallback? onCancel;

  final VoidCallback? onFinish;

  @override
  _TabStepperState createState() => _TabStepperState();
}

class _TabStepperState extends State<TabStepper> {
  static double _titleBarHeight = 40;
  static double _stepBarHeight = 50;

  late bool _listenerAdded;

  bool _isAnimationEvent = false;

  @override
  void initState() {
    super.initState();

    _listenerAdded = false;
  }

  void _onControllerUpdate(TabController controller) {
    if (controller.indexIsChanging) {
      // アニメーション開始
      setState(() {
        _isAnimationEvent = true;
      });
      print("start");
    } else {
      // アニメーション終了
      setState(() {
        _isAnimationEvent = true;
      });
      print("end");
    }
  }

  void _setTabIndex(TabController controller, int index) {
    if (controller.index == index) {
      return;
    }
    controller.index = index;
  }

  Widget _buildContent(TabController controller) {
    var result = Expanded(
      child: Container(
        child: TabBarView(
          physics: new NeverScrollableScrollPhysics(),
          children: List.generate(widget.steps.length, (index) {
            var step = widget.steps[index];
            if (index == controller.index ||
                (_isAnimationEvent && index == controller.previousIndex)) {
              return Container(
                child: Column(
                  children: [
                    _buildTitleBar(step.name),
                    Expanded(child: step.builder()),
                  ],
                ),
              );
            } else {
              return Container(
                child: Column(
                  children: [
                    _buildTitleBar(step.name),
                    Expanded(child: Container()),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
    _isAnimationEvent = false;
    return result;
  }

  Widget? _buildPrevButton(TabController controller) => controller.index > 0
      ? TextButton(
          onPressed: () {
            _setTabIndex(controller, controller.index - 1);
          },
          child: Row(
            children: [
              const Icon(Icons.navigate_before),
              Text("戻る", style: TextStyle(fontSize: 18.0)),
            ],
          ),
        )
      : TextButton(
          onPressed: widget.onCancel,
          child: Text("キャンセル", style: TextStyle(fontSize: 18.0)),
        );

  Widget? _buildNextButton(TabController controller) =>
      controller.index < widget.steps.length - 1
          ? ElevatedButton(
              onPressed: () {
                var isOk = widget.steps[controller.index].validate?.call();
                if (isOk == null || isOk) {
                  widget.steps[controller.index].onFinish?.call();

                  _setTabIndex(controller, controller.index + 1);
                }
              },
              child: Text("次へ", style: TextStyle(fontSize: 18.0)),
            )
          : ElevatedButton(
              onPressed: widget.onFinish,
              child: Text("生成", style: TextStyle(fontSize: 18.0)),
            );

  Widget _buildTitleBar(String title) => Container(
        height: _titleBarHeight,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1.0,
              blurRadius: 2.0,
              offset: Offset(0, 0),
            ),
          ],
          color: Colors.white,
        ),
        child: Center(
          child: Text(title, style: TextStyle(fontSize: 20.0)),
        ),
      );

  Widget _buildStepBar(TabController controller) => Container(
        height: _stepBarHeight,
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: DotsIndicator(
                dotsCount: widget.steps.length,
                position: controller.index + 0.0,
                onTap: (position) => _setTabIndex(
                    controller, min(position.round(), controller.index)),
              ),
            ),
            Row(children: () {
              var list = <Widget>[
                Expanded(
                  child: Container(),
                )
              ];
              var prev = _buildPrevButton(controller);
              if (prev != null) {
                list.insert(0, prev);
              }
              var next = _buildNextButton(controller);
              if (next != null) {
                list.add(next);
              }
              return list;
            }())
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    var result = DefaultTabController(
      length: 3,
      child: Builder(
        builder: (BuildContext context) {
          var controller = DefaultTabController.of(context)!;
          if (!_listenerAdded) {
            controller.addListener(() => _onControllerUpdate(controller));
            _listenerAdded = true;
          }
          return Column(
            children: [
              _buildContent(controller),
              _buildStepBar(controller),
            ],
          );
        },
      ),
    );
    return result;
  }
}
