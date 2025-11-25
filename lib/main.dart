// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:savethedate/services/auth_layout.dart';
// import 'package:savethedate/ui/browsing/profilecardview_v.dart';
// import 'package:savethedate/ui/landing/landing_v.dart';
// import 'package:savethedate/ui/navigation/homenavigation_v.dart';
// import 'package:savethedate/ui/signin/login/chatgptlogin.dart';
// import 'package:savethedate/ui/signup_main/signup_main_v.dart';

// // import 'package:savethedate/ui/signup_main/signup_main_v.dart'

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         textTheme: TextTheme(
//           bodyMedium: GoogleFonts.inter(fontWeight: FontWeight.w700),
//         ),
//       ),
//       home: AuthLayout(),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:savethedate/firebase_options.dart';
import 'package:savethedate/services/auth_layout.dart';
import 'package:savethedate/services/firestore_service.dart';
import 'package:savethedate/services/supabase.dart';
import 'package:savethedate/ui/browsing/viewmodels/likemanager_vm.dart';
import 'package:savethedate/ui/core/globals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:savethedate/ui/signin/signup/entercode_vm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SupabaseClass().initSupabase(); // make sure Supabase is initialized
  SupabaseClass().setsupabaseclient();
  // await dotenv.load(fileName: ".env");
  FirebaseAuth.instance.signInAnonymously();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirestoreService()),

        ChangeNotifierProvider(create: (_) => LikeManager()),

        ChangeNotifierProvider(create: (_) => EntercodeVm()),

        // Add more as needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: myRed,
          selectionColor: const Color.fromARGB(255, 255, 196, 192),
          selectionHandleColor: myRed,
        ),
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
      ),
      home: AuthLayout(),
      // home: SignupMain(),
    );
  }
}
