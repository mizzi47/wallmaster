import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wallmaster/model/jobmodel.dart';
import 'package:wallmaster/widgets/cardmyjob.dart';
import 'package:wallmaster/widgets/drawer.dart' as constant_drawer;
import 'package:wallmaster/model/jobmodel.dart' as jobmodel;

JobModel _dbjobmodel = JobModel();

class JobList extends StatefulWidget {
  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  final formkey = new GlobalKey<FormState>();
  final _advancedDrawerController = AdvancedDrawerController();
  final ScrollController _firstController = ScrollController();

  var spinkit = SpinKitRotatingCircle(
    color: Colors.white,
    size: 50.0,
  );

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
          title: const Text('My Job List'),
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
                  future: _dbjobmodel.getJob(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return Text(snapshot.toString());
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_off, size: 50.0,),
                              Text('NO DAILY LOGS FOUND')
                            ]);
                      }else{
                        return _buildMyItem(snapshot.data, context);
                      }
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
            return CardMyJob(
              jobdata: list![index],
            );
        },
      ),
    );
  }
  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
