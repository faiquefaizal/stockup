import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stockup/db_funtions.dart/brand_funtions.dart';
import 'package:stockup/db_funtions.dart/product_funtion.dart';
import 'package:stockup/models/brands/brand_model.dart';
import 'package:stockup/models/product/product_model.dart';
import 'package:stockup/screens/custemwidgets.dart';

class Edititem extends StatefulWidget {
  int index;
  Edititem({super.key, required this.index});

  @override
  State<Edititem> createState() => _EdititemState();
}

class _EdititemState extends State<Edititem> {
  final _form = GlobalKey<FormState>();
  final _itemnamecontroller = TextEditingController();

  final _pricecontroller = TextEditingController();

  final _sellingprice = TextEditingController();

  final _quantity = TextEditingController();

  final _ramcontroller = TextEditingController();

  final _operationgsystemcontroller = TextEditingController();

  final _colorcontroller = TextEditingController();

  final _storagecontroller = TextEditingController();
  final _screensize = TextEditingController();
  String? imagepath;
  String? selectedBrand;
  String? productId;

  _loadProduct(int index) async {
    var product = getProductById(index);
    if (product != null) {
      _itemnamecontroller.text = product.productame;
      _colorcontroller.text = product.color;
      _operationgsystemcontroller.text = product.os;
      _quantity.text = product.quatity.toString();
      _pricecontroller.text = product.price.toString();
      _ramcontroller.text = product.ram;
      _storagecontroller.text = product.storage;
      _sellingprice.text = product.sellingPrice.toString();
      _screensize.text = product.screenSize;
      selectedBrand = product.brandId;
      productId = product.productId;

      setState(() {
        imagepath = product.imagePath;
      });
    }
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
  void initState() {
    _loadProduct(widget.index);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("edit Item"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _form,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    _openCamera();
                  },
                  child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black54, width: 2),
                      ),
                      child: (imagepath != null)
                          ? Image.file(fit: BoxFit.cover, File(imagepath!))
                          : Center(
                              child: customText(text: "enter image"),
                            )),
                ),
                const SizedBox(
                  height: 20,
                ),
                fieledvalidation(_itemnamecontroller, "item name", "model name",
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
                field(_sellingprice, "Selling price", "Selling price"),
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
                fieledvalidation(
                  _ramcontroller,
                  "RAM",
                  "Enter the RAM",
                  inputtype: TextInputType.number,
                  (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter RAM";
                    }
                    if (int.tryParse(value) == null) {
                      return "Enter a valid number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                fieledvalidation(
                  _colorcontroller,
                  "Color",
                  "Enter the color of the phone",
                  (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter Color";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                fieledvalidation(
                  _storagecontroller,
                  "Storage",
                  "Phone storage capacity",
                  inputtype: TextInputType.number,
                  (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter Storage";
                    }
                    if (int.tryParse(value) == null) {
                      return "Enter a valid number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                fieledvalidation(
                  _operationgsystemcontroller,
                  "OS",
                  "Operating System",
                  (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter operating system";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                fieledvalidation(
                  _screensize,
                  "Screen Size",
                  "Enter screen size in inches",
                  inputtype: TextInputType.numberWithOptions(decimal: true),
                  (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter screen size";
                    }
                    if (double.tryParse(value) == null) {
                      return "Enter a valid number";
                    }
                    return null;
                  },
                ),
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
                        _savebutton();
                      },
                      child: const Text("Edit Product")),
                )
              ],
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

  _savebutton() async {
    var itemname = _itemnamecontroller.text.trim();
    int itemprice = int.parse(_pricecontroller.text);
    int sellingprice = int.parse(_sellingprice.text);
    var quatity = int.parse(_quantity.text);
    var ram = _ramcontroller.text.trim();
    var os = _operationgsystemcontroller.text.trim();
    var color = _colorcontroller.text.trim();
    var storage = _storagecontroller.text.trim();
    var screenSize = _screensize.text.trim();
    var product = ProductModel(
        productId: productId!,
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
      customsnackbar(context, "item already Exist", Colors.red);
      return;
    }
    await editProducts(product);
    Navigator.pop(context);
  }
}
