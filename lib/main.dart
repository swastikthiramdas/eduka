import 'package:eduka/providers/user_provider.dart';
import 'package:eduka/screens/Login_screen.dart';
import 'package:eduka/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBw5xo5MjyeXSfV3-8v_LofcJzNgTIfL0U",
        projectId: "new-project-6e5b9",
        storageBucket: "new-project-6e5b9.appspot.com",
        messagingSenderId: "1001063707791",
        appId: "1:1001063707791:web:13633d7405a7afecd36cfa",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Eduka',
          theme: ThemeData(
            fontFamily: GoogleFonts.poppins().fontFamily,
            primarySwatch: Colors.blue,
          ),
          home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const HomeScreen();
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                );
              }
            }
            return Login_screen();
          },
        ),
              // Login_screen()
    )
    );
  }
}
