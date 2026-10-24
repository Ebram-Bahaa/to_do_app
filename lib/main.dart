import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/auth/cubit/auth_cubit.dart';
import 'package:to_do_app/features/auth/repositories/auth_repository.dart';
import 'package:to_do_app/features/auth/screens/sign_up_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp( options:  FirebaseOptions(
    apiKey: 'AIzaSyB8-3iZ3r_bSDbPpVQ1Q0bC1cjnrnA6Lc8',
    appId: '1:987228612206:web:314b61871418129e54287f',
    messagingSenderId: '987228612206',
    projectId: 'to-do-app-76507',
    authDomain: 'to-do-app-76507.firebaseapp.com',
    storageBucket: 'to-do-app-76507.firebasestorage.app',
  ));
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'to-do-app',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (context) => AuthCubit(AuthRepository()),
        child: SignUpScreen(),
      ),
    );
  }
}
