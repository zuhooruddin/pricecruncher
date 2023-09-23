import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:price_cruncher_new/mainApp/BottomNavigationBar/bottomNavBar.dart';
import 'package:price_cruncher_new/models/items_model.dart';
import 'package:price_cruncher_new/providers/language_provider.dart';
import 'package:price_cruncher_new/providers/loader_provider.dart';
import 'package:price_cruncher_new/providers/shop_provider.dart';
import 'package:price_cruncher_new/providers/user_data_provider.dart';
import 'package:price_cruncher_new/providers/user_provider.dart';
import 'package:price_cruncher_new/splashScreen.dart';
import 'package:provider/provider.dart';

class Bridge extends StatefulWidget {
  final String locale;

  Bridge({super.key, required this.locale});

  @override
  State<Bridge> createState() => _BridgeState();
}

class _BridgeState extends State<Bridge> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoaderProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ChangeLanguageProvider()),
        ChangeNotifierProvider(create: (_) => ShopProvider()),
        ChangeNotifierProvider(create: (_) => ShoppingListProvider()),
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent,
          ),
        ),
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == ScreenBottomNavBar.routeName) {
            final arguments = settings.arguments as AddItem;
            return MaterialPageRoute(
              builder: (BuildContext context) {
                return ScreenBottomNavBar(
                  item: arguments,
                );
              },
            );
          }
          return null;
        },
        home: const SplashScreen(),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:price_cruncher_new/providers/language_provider.dart';
// import 'package:price_cruncher_new/providers/loader_provider.dart';
// import 'package:price_cruncher_new/providers/user_provider.dart';
// import 'package:price_cruncher_new/splashScreen.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class Bridge extends StatefulWidget {
//   final String locale;

//   Bridge({super.key, required this.locale});

//   @override
//   State<Bridge> createState() => _BridgeState();
// }

// class _BridgeState extends State<Bridge> {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => LoaderProvider()),
//         ChangeNotifierProvider(create: (_) => UserProvider()),
//         ChangeNotifierProvider(create: (_) => ChangeLanguageProvider()),
//       ],
//       child: Consumer<ChangeLanguageProvider>(
//         builder: (context, provider, child) {
//           if (widget.locale.isEmpty) {
//             provider.changeLangauge(Locale('en'));
//           }
//           return GetMaterialApp(
//             debugShowCheckedModeBanner: false,
//             locale: widget.locale == ''
//                 ? Locale('en')
//                 : provider.appLocale == null
//                     ? Locale('en')
//                     : provider.appLocale,
//             localizationsDelegates: [
//               AppLocalizations.delegate,
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//             supportedLocales: AppLocalizations.supportedLocales,
//             theme: ThemeData(
//               textTheme:
//                   GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
//               bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//                 backgroundColor: Colors.transparent,
//               ),
//             ),
//             home: const SplashScreen(),
//           );
//         },
//       ),
//     );
//   }
// }
