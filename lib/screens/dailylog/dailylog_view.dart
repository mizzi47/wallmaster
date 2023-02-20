import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wallmaster/model/dailylogmodel.dart';
import 'package:wallmaster/widgets/drawer.dart' as constant_drawer;
import 'package:wallmaster/widgets/imagesliders.dart' as testslider;
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class InitDailyLogView extends StatelessWidget {
  var dailylogdata;
  InitDailyLogView(
      {required this.dailylogdata});
  @override
  Widget build(BuildContext context) {
    DailyLogModel _dbdailylogmodel = DailyLogModel();
    return FutureBuilder(
        future: _dbdailylogmodel.getDailyLogFiles(dailylogdata['dailylog_id']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DailyLogViewPage(getdailylogdata: dailylogdata, getdailylogfiles: snapshot.data);
          } else {
            return LoadingAnimationWidget.fourRotatingDots(
              color: Colors.white,
              size: 100,
            );
          }
        },
      );
  }
}
class DailyLogViewPage extends StatefulWidget {
  var getdailylogdata;
  var getdailylogfiles;
      DailyLogViewPage({ this.getdailylogdata, this.getdailylogfiles });
  @override
  _DailyLogViewPageState createState() => _DailyLogViewPageState();
}

class _DailyLogViewPageState extends State<DailyLogViewPage> {
// class DailyLogView extends StatelessWidget {
//   DailyLogView(
//       {required this.dailylogdata, required this.dailylogfiles});
  var dailylogdata;
  var dailylogfiles;
  @override
  void initState() {
    super.initState();
    // access the property 'data' using 'widget.data'
    dailylogdata = widget.getdailylogdata;
    dailylogfiles = widget.getdailylogfiles;
  }

  final formkey = new GlobalKey<FormState>();
  final _advancedDrawerController = AdvancedDrawerController();
  var datePicked;
  @override
  Widget build(BuildContext context) {
    print(dailylogfiles);
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
        appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.5),
          title: const Text('Daily Log Details'),
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
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        readOnly: true,
                        maxLines: null,
                        obscureText: false,
                        decoration: InputDecoration(
                            icon: Icon(Icons.account_circle_sharp),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Wall Finishes/ Floor Finishes",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.update_rounded),
                              title: const Text('Update:'),
                              subtitle: Text(dailylogdata['update']),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.pending_rounded),
                              title: const Text('Pending:'),
                              subtitle: Text(dailylogdata['pending']),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.security_update_warning_sharp),
                              title: const Text('Issue:'),
                              subtitle: Text(dailylogdata['issue']),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  testslider.sliders(context, dailylogfiles)
                ],
              ),),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}