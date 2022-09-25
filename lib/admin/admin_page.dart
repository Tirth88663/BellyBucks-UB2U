import 'package:bellybucks/admin/add_product_page.dart';
import 'package:bellybucks/admin/all_product_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xffE5413F),
            title: Text(
              "BellyBucks",
              style: GoogleFonts.poppins(),
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
                icon: const Icon(Icons.library_add_outlined),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: const Color(0xffE5413F),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AllProducts()),
                );
              },
              child: const Icon(Icons.library_books_outlined)),
          body: Container(),
        ),
      ),
    );
  }
}
