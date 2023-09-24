import 'package:anglara_tech_task/di/app_component_base.dart';
import 'package:anglara_tech_task/firebase_options.dart';
import 'package:anglara_tech_task/shared/constants/route_constants.dart';
import 'package:anglara_tech_task/shared/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import 'shared/constants/colors.dart';
import 'shared/constants/constants.dart';
import 'shared/constants/strings.dart';
import 'shared/widgets/custom_progress_dialog.dart';

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.whiteColor,
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    AppComponentBase.instance.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? RouteList.homeScreen
          : RouteList.initial,
      routes: Routes.getRoutes(),
      builder: (context, widget) {
        return Stack(
          children: <Widget>[
            StreamBuilder<bool>(
                initialData: false,
                stream: AppComponentBase.instance.progressDialogStream,
                builder: (context, snapshot) {
                  return IgnorePointer(
                      ignoring: snapshot.data ?? false,
                      child: SafeArea(child: widget!));
                }),
            StreamBuilder<bool?>(
                initialData: true,
                stream: AppComponentBase
                    .instance.networkManage.internetConnectionStream,
                builder: (context, snapshot) {
                  return SafeArea(
                    child: AnimatedContainer(
                        height: snapshot.data ?? false ? 0 : 100,
                        duration: Constants.animationDuration,
                        color: AppColors.primaryColor,
                        child: const Material(
                          type: MaterialType.transparency,
                          child: Center(
                              child: Text(
                            Strings.noInternetConnection,
                          )),
                        )),
                  );
                }),
            StreamBuilder<bool?>(
                initialData: false,
                stream: AppComponentBase.instance.progressDialogStream,
                builder: (context, snapshot) {
                  if (snapshot.data ?? false) {
                    return const Center(child: CustomProgressDialog());
                  } else {
                    return const Offstage();
                  }
                })
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    AppComponentBase.instance.dispose();
    super.dispose();
  }
}
