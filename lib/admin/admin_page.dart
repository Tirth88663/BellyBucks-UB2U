import 'package:bellybucks/admin/add_product_page.dart';
import 'package:bellybucks/admin/all_product_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../consts/theme_data.dart';
import '../main.dart';
import '../provider/dark_theme_provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xffE5413F),
      ),
      home: SafeArea(
        child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "BellyBucks",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: Colors.black),
            ),
            titleSpacing: 1.5,
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AddProduct()),
                  );
                },
                icon:
                    const Icon(Icons.library_add_outlined, color: Colors.black),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.white70,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AllProducts()),
              );
            },
            child:
                const Icon(Icons.library_books_outlined, color: Colors.black),
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('orders').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                if (streamSnapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final DocumentSnapshot data =
                          streamSnapshot.data!.docs[index];
                      var order = data['products'];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 10),
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: width * 0.35,
                            minWidth: width,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(2, 2),
                                spreadRadius: 0,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Name : ',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '${data['customerName']}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(flex: 1),
                                    IconButton(
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .runTransaction(
                                          (Transaction myTransaction) async {
                                            myTransaction.delete(streamSnapshot
                                                .data!.docs[index].reference);
                                            setState(() {});
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.done_rounded),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Contact : ',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '${data['mobileNumber']}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Order : ',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 156),
                                  child: Text(
                                    '$order',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/no_orders.PNG",
                          fit: BoxFit.cover,
                          height: 300.0,
                          width: 300.0,
                          //color: Colors.transparent,
                          colorBlendMode: BlendMode.modulate,
                        ),
                        Text(
                          'No orders yet !',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 28.0,
                                color: Colors.red,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xffE5413F)),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class AdminApp extends StatefulWidget {
  const AdminApp({Key? key}) : super(key: key);

  @override
  State<AdminApp> createState() => _AdminAppState();
}

class _AdminAppState extends State<AdminApp> {
  // This widget is the root of your application.

  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          themeChangeProvider.getDarkTheme;
          return MaterialApp(
            title: 'BellyBucks',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            scrollBehavior: MyCustomScrollBehavior(),
            home: const AdminPage(),
          );
        },
      ),
    );
  }
}
