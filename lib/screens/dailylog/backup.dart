// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:multi_image_picker_view/multi_image_picker_view.dart';
// import 'package:path/path.dart';
// import 'package:wallmaster/model/dailylogmodel.dart';
// import 'package:wallmaster/widgets/drawer.dart' as constant_drawer;
// import 'package:wallmaster/widgets/imagesliders.dart' as testslider;
//
// import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
// import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
// import 'package:roundcheckbox/roundcheckbox.dart';
//
// class DailyLogAdd extends StatefulWidget {
//   @override
//   _DailyLogAddState createState() => _DailyLogAddState();
// }
//
// class _DailyLogAddState extends State<DailyLogAdd> {
//   List<File>? files;
//   var selectedfile;
//   Response? response;
//   String? progress;
//   Dio dio = new Dio();
//   DailyLogModel _md = new DailyLogModel();
//   final controller = MultiImagePickerController(
//     maxImages: 10,
//     allowedImageTypes: ['png', 'jpg', 'jpeg'],
//     withData: true,
//     withReadStream: true,
//   );
//   List<String> scope = [
//     'Wework',
//     'Ceiling',
//     'Wiring',
//     'Wall Finishes',
//     'Floor Finishes',
//     'Carpentry Finishes',
//     'Steel/aluminium Finishes'
//   ];
//   var selectedscope = [];
//   final formkey = new GlobalKey<FormState>();
//   final _advancedDrawerController = AdvancedDrawerController();
//   TextEditingController update = new TextEditingController();
//   TextEditingController pending = new TextEditingController();
//   TextEditingController issue = new TextEditingController();
//   TextEditingController logdate = new TextEditingController();
//   var datePicked;
//
//   @override
//   Widget build(BuildContext context) {
//     selectedscope = [];
//     selectedscope.length = 7;
//     return AdvancedDrawer(
//       backdropColor: Colors.blueGrey,
//       controller: _advancedDrawerController,
//       animationCurve: Curves.easeInOut,
//       animationDuration: const Duration(milliseconds: 300),
//       animateChildDecoration: true,
//       rtlOpening: false,
//       // openScale: 1.0,
//       disabledGestures: false,
//       childDecoration: const BoxDecoration(
//         borderRadius: const BorderRadius.all(Radius.circular(16)),
//       ),
//       drawer: constant_drawer.build(context),
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.blue.withOpacity(0.5),
//           title: const Text('Add New Daily Log'),
//           leading: IconButton(
//             onPressed: _handleMenuButtonPressed,
//             icon: ValueListenableBuilder<AdvancedDrawerValue>(
//               valueListenable: _advancedDrawerController,
//               builder: (_, value, __) {
//                 return AnimatedSwitcher(
//                   duration: Duration(milliseconds: 250),
//                   child: Icon(
//                     value.visible ? Icons.clear : Icons.menu,
//                     key: ValueKey<bool>(value.visible),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Center(
//             child: Form(
//               key: formkey,
//               child: Column(
//                 children: [
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Text('Scope Of Work :')),
//                   ),
//                   Container(
//                     child: Column(
//                       children: List.generate(scope.length, (index) {
//                         return Row(
//                           children: [
//                             Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: RoundCheckBox(
//                                   onTap: (selected) {
//                                     if(selected == true){
//                                       selectedscope[index] = scope[index].toString();
//                                       print(scope[index].toString());
//                                       print(selectedscope);
//                                     }
//                                     if(selected == false){
//                                       selectedscope[index] = null;
//                                       print(index);
//                                       print(selectedscope);
//                                     }
//                                   },
//                                   size: 30,
//                                   uncheckedColor: Colors.white,
//                                 )),
//                             Text(scope[index].toString())
//                           ],
//                         );
//                       }),
//                     ),
//                   ),
//                   Container(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: TextFormField(
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter update';
//                           }
//                           return null;
//                         },
//                         maxLines: null,
//                         controller: update,
//                         obscureText: false,
//                         decoration: InputDecoration(
//                             icon: Icon(Icons.update_rounded),
//                             filled: true,
//                             fillColor: Colors.white,
//                             contentPadding:
//                             EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                             hintText: "Update",
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0))),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: TextFormField(
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter pending';
//                           }
//                           return null;
//                         },
//                         maxLines: null,
//                         controller: pending,
//                         obscureText: false,
//                         decoration: InputDecoration(
//                             icon: Icon(Icons.pending_rounded),
//                             filled: true,
//                             fillColor: Colors.white,
//                             contentPadding:
//                             EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                             hintText: "Pending",
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0))),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: TextFormField(
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter issue';
//                           }
//                           return null;
//                         },
//                         maxLines: null,
//                         controller: issue,
//                         obscureText: false,
//                         decoration: InputDecoration(
//                             icon: Icon(Icons.security_update_warning_sharp),
//                             filled: true,
//                             fillColor: Colors.white,
//                             contentPadding:
//                             EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                             hintText: "Issues",
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0))),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: TextFormField(
//                         onTap: () async {
//                           FocusScope.of(context).requestFocus(new FocusNode());
//                           datePicked = await DatePicker.showSimpleDatePicker(
//                             context,
//                             firstDate: DateTime(1960),
//                             dateFormat: "dd-MMMM-yyyy",
//                             looping: true,
//                           );
//                           logdate.text = datePicked.toString();
//                         },
//                         validator: (value) {
//                           if (value!.isEmpty ||
//                               value == 'null' ||
//                               value == null) {
//                             return 'Please enter submit date';
//                           }
//                           return null;
//                         },
//                         controller: logdate,
//                         obscureText: false,
//                         decoration: InputDecoration(
//                             icon: Icon(Icons.calendar_today),
//                             filled: true,
//                             fillColor: Colors.white,
//                             contentPadding:
//                             EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                             hintText: "Submit date",
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0))),
//                       ),
//                     ),
//                   ),
//                   Divider(color: Colors.black),
//                   // MultiImagePickerView(
//                   //   controller: controller,
//                   //   padding: const EdgeInsets.all(10),
//                   // ),
//                   Divider(color: Colors.black),
//                   Container(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: SizedBox(
//                           width: MediaQuery.of(context).size.width,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green),
//                             onPressed: () async {
//                               if (formkey.currentState!.validate()) {
//                                 //_md.addDailyLog(selectedscope, update.text, pending.text, issue.text, logdate.text, files);
//                                 //print(controller.images.first.bytes.toString());
//                                 for (int i = 0; i < files!.length; i++) {
//                                   // String uploadurl = "https://www.prismakhaslab.com/cpms/api/file_upload.php";
//                                   String uploadurl = 'http://192.168.0.116/wallmaster/api/fileupload.php';
//
//                                   FormData formdata = FormData.fromMap({
//                                     "file": await MultipartFile.fromFile(files![i].path,
//                                         filename: basename(files![i].path)
//                                       //show only filename from path
//                                     ),
//                                   });
//
//                                   response = await dio.post(
//                                     uploadurl,
//                                     data: formdata,
//                                   );
//                                   if (response!.statusCode == 200) {
//                                     print(response.toString());
//                                     //print response from server
//                                   } else {
//                                     print("Error during connection to server.");
//                                   }
//                                 }
//                                 // Navigator.push(
//                                 //   context,
//                                 //   MaterialPageRoute(builder: (context) => JobList()),
//                                 // );
//                               }
//                             },
//                             child: Text('Submit'),
//                           ),
//                         ),
//                       )),
//                   Container(
//                       child: ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           shape: new RoundedRectangleBorder(
//                             borderRadius:
//                             new BorderRadius.circular(30.0),
//                           ),
//                         ),
//                         onPressed: () {
//                           selectFile();
//                         },
//                         icon: Icon(Icons.folder_open),
//                         label: Text("CHOOSE FILE"),
//                       )),
//                   SizedBox(height: 10.0),
//                   //if selectedfile is null then show empty container
//                   //if file is selected then show upload button
//                   if (files == null)
//                     Container()
//                   else
//                     for (int i = 0; i < files!.length; i++)
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: <Widget>[
//                             Icon(Icons.file_copy_rounded,
//                                 color: Colors.yellow),
//                             Text(basename(files![i].path),
//                                 style: TextStyle(
//                                     color: Colors.black))
//                           ],
//                         ),
//                       ),
//                   SizedBox(height: 10.0),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   selectFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'pdf', 'mp4'],
//     );
//     if (result != null) {
//       //if there is selected file
//       files = result.paths.map((path) => File(path!)).toList();
//     }
//     print(basename(files![0].path));
//     setState(() {});
//   }
//
//   void _handleMenuButtonPressed() {
//     // NOTICE: Manage Advanced Drawer state through the Controller.
//     // _advancedDrawerController.value = AdvancedDrawerValue.visible();
//     _advancedDrawerController.showDrawer();
//   }
// }
