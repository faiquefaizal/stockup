import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stockup/db_funtions.dart/brand_funtions.dart';
import 'package:stockup/db_funtions.dart/product_funtion.dart';
import 'package:stockup/models/brands/brand_model.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stockup/screens/custemwidgets.dart';

class Additemspage extends StatefulWidget {
  const Additemspage({super.key});

  @override
  State<Additemspage> createState() => _AdditemspageState();
}

class _AdditemspageState extends State<Additemspage> {
  final _itemnamecontroller = TextEditingController();
  final _form = GlobalKey<FormState>();

  final _pricecontroller = TextEditingController();

  final _sellingprice = TextEditingController();

  final _quantity = TextEditingController();

  final _ramcontroller = TextEditingController();

  final _operationgsystemcontroller = TextEditingController();

  final _colorcontroller = TextEditingController();

  final _storagecontroller = TextEditingController();

  final _screensize = TextEditingController();
  String? imagepath;
  List<String> brandlist = [];
  String? selectedBrand;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _openCamera() async {
    var pickedimage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedimage != null) {
      setState(() {
        imagepath = pickedimage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          title: const Text("Add Items"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _openCamera();
                    },
                    child: Container(
                        color: Colors.grey,
                        height: 150,
                        width: 150,
                        child: (imagepath != null)
                            ? Image.file(fit: BoxFit.cover, File(imagepath!))
                            : Center(
                                child: customText(text: "enter image"),
                              )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  fieledvalidation(
                      _itemnamecontroller, "item name", "model name",
                      inputtype: TextInputType.text, (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter item name";
                    }
                    return null;
                  }),
                  const SizedBox(height: 20),
                  fieledvalidation(_pricecontroller, "Price", "buying price",
                      inputtype: TextInputType.number, (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter item name";
                    }
                    if (int.tryParse(value) == null) {
                      return "Please enter a valid number";
                    }
                    return null;
                  }),
                  const SizedBox(height: 20),
                  fieledvalidation(
                      _sellingprice, "Selling price", "Selling price",
                      inputtype: TextInputType.number, (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter selling price";
                    }
                    if (int.tryParse(value) == null) {
                      return "Please enter a valid number";
                    }
                    return null;
                  }),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ValueListenableBuilder(
                          valueListenable: brandListnotifier,
                          builder: (context, List<BrandModel> value, child) {
                            // List<String> list =
                            //     value.map((brand) => brand.brandname).toList();

                            return DropdownButton<String>(
                              items: value.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item.brandId,
                                  child: Text(item.brandname),
                                );
                              }).toList(),
                              value: selectedBrand,
                              hint: const Text("Select a Brand"),
                              onChanged: (selectedValue) {
                                setState(() {
                                  selectedBrand = selectedValue;
                                });
                              },
                            );
                          }),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: fieledvalidation(
                            _quantity, "Quatity", "Stock Count",
                            inputtype: TextInputType.number, (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter quatity";
                          }
                          if (int.tryParse(value) == null) {
                            return "Please enter a valid number";
                          }
                          return null;
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  fieledvalidation(_ramcontroller, "Ram", "enter the ram ",
                      inputtype: TextInputType.number, (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter RAM";
                    }

                    return null;
                  }),
                  const SizedBox(height: 20),
                  fieledvalidation(_colorcontroller, "color",
                      "enter the color of the  phone", (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter Color";
                    }

                    return null;
                  }),
                  const SizedBox(height: 20),
                  fieledvalidation(
                      _storagecontroller, "Storage", "phone storage capacity",
                      inputtype: TextInputType.number, (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter Storage";
                    }

                    return null;
                  }),
                  const SizedBox(height: 20),
                  fieledvalidation(
                      _operationgsystemcontroller, "OS", "Operating System",
                      (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter operating system";
                    }
                    return null;
                  }),
                  const SizedBox(height: 20),
                  fieledvalidation(_screensize, "Screen size", "Screen Size",
                      (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter  screen size";
                    }
                    return null;
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            addItemsbutton();
                          }
                        },
                        child: const Text("Add Product")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget field(
      TextEditingController controllername, String labeltext, String hinttext,
      {TextInputType inputtype = TextInputType.name, bool showtext = false}) {
    return TextFormField(
      controller: controllername,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labeltext,
          hintText: hinttext),
      keyboardType: inputtype,
      obscureText: showtext,
    );
  }

  addItemsbutton() {
    var itemname = _itemnamecontroller.text.trim();
    int itemprice = int.parse(_pricecontroller.text);
    int sellingprice = int.parse(_sellingprice.text);
    var quatity = int.parse(_quantity.text);
    var ram = _ramcontroller.text.trim();
    var os = _operationgsystemcontroller.text.trim();
    var color = _colorcontroller.text.trim();
    var storage = _storagecontroller.text.trim();
    var screenSize = _screensize.text.trim();
    print(selectedBrand);

    String productId = generateId();
    var product = ProductModel(
        productId: productId,
        productame: itemname,
        price: itemprice,
        sellingPrice: sellingprice,
        ram: ram,
        color: color,
        storage: storage,
        os: os,
        screenSize: screenSize,
        brandId: selectedBrand!,
        quatity: quatity,
        imagePath: imagepath!);
    var itemCheck = productCheck(product);
    if (itemCheck) {
      customsnackbar(context, "Product Already Exist", Colors.red);
      return;
    }
    addProduct(product);
    Navigator.pop(context);
    // customsnackbar(context, "product added Sucessfully", Colors.green);
  }
}
