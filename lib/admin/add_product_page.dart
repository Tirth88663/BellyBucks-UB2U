import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/product_model.dart';
import 'admin_page.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formkey = GlobalKey<FormState>();
  final nameEditingController = TextEditingController();
  final priceEditingController = TextEditingController();
  final categoryEditingController = TextEditingController();
  final imageUrlEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final productNameField = TextFormField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("product name is required");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter valid name(Min. 3 Characters)");
        }
        return null;
      },
      onSaved: (value) {
        nameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: const Color(0xffE5413F),
      decoration: InputDecoration(
        labelText: 'Product Name',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon:
            const Icon(CupertinoIcons.tag_fill, color: Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Product name (Min. 3 Characters) ",
        hintStyle:
            GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE5413F)),
        ),
      ),
    );
    final priceField = TextFormField(
      autofocus: false,
      controller: priceEditingController,
      keyboardType: TextInputType.number,
      validator: (value) {
        RegExp regex = RegExp(r'^\d+$');
        if (value!.isEmpty) {
          return ("Product Price is required");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter valid number(eg: 100, 50, 53, 11)");
        }
        return null;
      },
      onSaved: (value) {
        priceEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: const Color(0xffE5413F),
      decoration: InputDecoration(
        labelText: 'Price',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon: const Icon(Icons.money_outlined, color: Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "enter Price (eg: 100, 50, 53, 11)",
        hintStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE5413F)),
        ),
      ),
    );
    final categoryField = TextFormField(
      autofocus: false,
      controller: categoryEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("product category is required");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter valid detail (Min. 3 Characters)");
        }
        return null;
      },
      onSaved: (value) {
        categoryEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: const Color(0xffE5413F),
      decoration: InputDecoration(
        labelText: 'Product Category',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon:
            const Icon(Icons.category_rounded, color: Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Product Category (Min. 3 Characters) ",
        hintStyle:
            GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE5413F)),
        ),
      ),
    );
    final imageUrlField = TextFormField(
      autofocus: false,
      controller: imageUrlEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter product image Url";
        }
        //reg expression for email validation
        if (!RegExp(
                r'(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?')
            .hasMatch(value)) {
          return ("Please Enter Valid Url");
        }
        return null;
      },
      onSaved: (value) {
        imageUrlEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      cursorColor: const Color(0xffE5413F),
      decoration: InputDecoration(
        labelText: 'image Url',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon: const Icon(CupertinoIcons.link, color: Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "enter product image Url",
        hintStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE5413F)),
        ),
      ),
    );
    final addProductButton = MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 10,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      height: 40,
      minWidth: width * 0.35,
      color: const Color(0xffE5413F),
      onPressed: () {
        addToDB();
      },
      child: Text(
        "Add Product",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              "Add new Product",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            titleSpacing: 1.5,
            centerTitle: true,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 56, horizontal: 8),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: productNameField,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: priceField,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: categoryField,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: imageUrlField,
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 196, top: 24),
                          child: addProductButton,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }

  void addToDB() async {
    _formkey.currentState!.validate();
    if (_formkey.currentState!.validate()) {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      ProductModel productModel = ProductModel();

      productModel.name = nameEditingController.text;
      productModel.price = int.parse(priceEditingController.text);
      productModel.category = categoryEditingController.text;
      productModel.imageUrl = imageUrlEditingController.text;

      await firebaseFirestore
          .collection("products")
          .doc(productModel.name)
          .set(productModel.toMap());
      Fluttertoast.showToast(msg: "Product Added successfully :)");

      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => const AdminPage()),
          (route) => false);
    }
  }
}
