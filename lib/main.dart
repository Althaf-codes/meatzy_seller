import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meatzy/Provider/meat_seller_provider.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants/Global_Variables.dart';

import 'Provider/user_provider.dart';
import 'Screen/Details/meat_seller_details_screen.dart';
import 'Screen/MainHomePage.dart';
import 'Service/firebase_auth_service.dart';
import 'Widget/toggle.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
            create: (_) => FirebaseAuthMethods(
                  FirebaseAuth.instance,
                )),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<MeatSellerProvider>(
            create: (_) => MeatSellerProvider()),
        StreamProvider(
            create: (context) => context.read<FirebaseAuthMethods>().authState,
            initialData: null),
      ],
      child: MaterialApp(
          scaffoldMessengerKey: _scaffoldKey,
          title: 'MeatzySeller',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: false,
            scaffoldBackgroundColor: GlobalVariables.greyBackgroundCOlor,
            appBarTheme: const AppBarTheme(
                elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
          ),
          routes: {
            Toggle.route: (context) => const Toggle(),
            MainHomePage.route: (context) => const MainHomePage(),
          },

          //  onGenerateRoute: (route) => getRoutes(route),
          home: const AuthWrapper()
          //  HomeScreen(controller: scrollController)
          ), //const AuthWrapper()),
    );
    //const SellScreen());  // const AdminMainHomePage()); // MainHomePage());
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool isMeatSellerRegistered = false;
  // late String userid;

  @override
  void initState() {
    getSellerData();
    super.initState();
  }

  void getSellerData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      // userid = prefs.getString("xuserid")!;
      // prefs.setBool("ismeatsellerRegistered", true);
      isMeatSellerRegistered = prefs.getBool("ismeatsellerRegistered")!;
      print("the islogged in 1 is $isMeatSellerRegistered");
    });
    if (isMeatSellerRegistered == null) {
      setState(() {
        isMeatSellerRegistered = false;
        print('the isMeatSellerRegistered in 2 $isMeatSellerRegistered');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final firebaseUser = context.watch<User>();

    final firebaseUser = context.watch<User?>();
    //  final isloggedInUser = context.watch<FirebaseAuthMethods>().authState;
    //print("islogged in is : ${isloggedInUser.isBroadcast}");

    if (firebaseUser != null) {
      // print("isloggedin value in main.dart is $islogged");

      if (isMeatSellerRegistered == false) {
        return MeatSellerDetailsScreen();
      }

      print('THE USER IS ${firebaseUser.uid}');
      return const MainHomePage();
    } else {
      //print('THE USER IS ${firebaseUser!.uid}');
      // print('THE USER IS NULL');
      return const Toggle();
    }
    // return Toggle();
  }
}
