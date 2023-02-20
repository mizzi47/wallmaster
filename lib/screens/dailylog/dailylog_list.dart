import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallmaster/model/dailylogmodel.dart';
import 'package:wallmaster/screens/dailylog/dailylog_add.dart';
import 'package:wallmaster/widgets/carddailylog.dart';
import 'package:wallmaster/widgets/drawer.dart' as constant_drawer;

DailyLogModel _dbdailylogmodel = DailyLogModel();

class DailyLogList extends StatefulWidget {
  @override
  _DailyLogListState createState() => _DailyLogListState();
}

class _DailyLogListState extends State<DailyLogList> {
  final formkey = new GlobalKey<FormState>();
  final _advancedDrawerController = AdvancedDrawerController();
  final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) {

    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: constant_drawer.build(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.2),
          title: const Text('Daily Log List'),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.withOpacity(0.5)),
                onPressed: (){
                  Navigator.of(context,rootNavigator: true).push(MaterialPageRoute (
                    builder: (BuildContext context) => DailyLogAdd(),
                  ),);
                },
                child: Icon(Icons.add_box_rounded)
            )
          ],
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget> [
            Container(
              child: FutureBuilder<List>(
                  future: _dbdailylogmodel.getDailyLog(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return Text('Check Your Internet Connections!');
                    if (snapshot.hasData) {
                      return _buildMyItem(snapshot.data, context);
                    } else {
                      return LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.white,
                        size: 100,
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMyItem(List? list, BuildContext context) {
    return Scrollbar(
      thickness: 10,
      isAlwaysShown: true,
      controller: _firstController,
      child: ListView.builder(
        controller: _firstController,
        shrinkWrap: true,
        itemCount: list?.length,
        itemBuilder: (BuildContext context, int index) {
          return CardDailyLog(
            dailylogdata: list![index]
          );
        },
      ),
    );
  }
  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
