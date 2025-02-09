import 'dart:developer';

import 'package:flutter/material.dart';

Widget field(
  TextEditingController controllername,
  String labeltext,
  String hinttext, {
  Color fillColor = Colors.white,
  TextInputType inputtype = TextInputType.text,
  bool showtext = false,
}) {
  return TextFormField(
    controller: controllername,
    decoration: InputDecoration(
      filled: true,
      fillColor: fillColor,
      labelText: labeltext,
      hintText: hinttext,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), // Smooth rounded edges
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
    ),
    keyboardType: inputtype,
    obscureText: showtext,
  );
}

Widget custemcard(String name, Function funtionname) {
  return SizedBox(
    height: 90,
    child: InkWell(
      onTap: () {
        funtionname();
      },
      child: Card(
        color: Colors.black,
        child: Center(
          child: Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    ),
  );
}

void customsnackbar(BuildContext context, String content, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Text(
        content,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}

Widget fieledvalidation(
  TextEditingController controllername,
  String labeltext,
  String hinttext,
  String? Function(String?)? validator, {
  Color fillColor = Colors.white,
  TextInputType inputtype = TextInputType.name,
  bool showtext = false,
}) {
  return TextFormField(
    validator: validator,
    controller: controllername,
    decoration: InputDecoration(
      filled: true,
      fillColor: fillColor,
      labelText: labeltext,
      hintText: hinttext,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), // Smooth corners
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
    ),
    keyboardType: inputtype,
    obscureText: showtext,
  );
}

Widget fieldValidation(
    {required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    final Function(String)? onChanged}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      border: const OutlineInputBorder(),
    ),
    keyboardType: keyboardType,
    onChanged: onChanged,
    validator: validator,
  );
}

conformationdialog(
    {required BuildContext context,
    required String content,
    required void Function()? yesonPressed}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(content),
          content: Text(content),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: () {},
                child: TextButton(
                    onPressed: () {},
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.black,
                        foregroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () {
                        yesonPressed;
                      },
                      child: const Text("Add"),
                    )))
          ],
        );
      });
}

fieldalert(
    {required BuildContext context,
    required String text,
    required TextEditingController controllername,
    required void Function()? yesonPressed}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          content: TextField(
            controller: controllername,
            decoration: const InputDecoration(
              labelText: "Brand",
              hintText: "Brand Name",
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.black,
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {
                yesonPressed;
                Navigator.pop(context);
              },
              child: const Text("Add"),
            )
          ],
        );
      });
}

Widget customText(
    {required String text,
    Color color = Colors.black,
    double size = 20,
    FontWeight fonttype = FontWeight.normal}) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: size, fontWeight: fonttype),
  );
}

conformationDialog(
    {required BuildContext context,
    required void Function()? yesonPressed}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Delete it",
            style: TextStyle(fontSize: 50),
          ),
          content: const Text(
            "Are you Sure you want to delete It?",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.black,
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {
                yesonPressed;
              },
              child: const Text("Delete"),
            )
          ],
        );
      });
}

class CustemElevatedButton extends StatelessWidget {
  Function()? actionFuntion;
  String ButtonName;
  Color background;
  Color foreground;

  CustemElevatedButton(
      {super.key,
      required this.ButtonName,
      required this.actionFuntion,
      this.background = Colors.black,
      this.foreground = Colors.white});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: background,
            foregroundColor: foreground),
        onPressed: actionFuntion,
        child: Text(ButtonName));
  }
}

class CustemElevatedButtonWithIcon extends StatelessWidget {
  Function()? actionFuntion;
  String ButtonName;
  Color background;
  Color foreground;
  IconData icon;

  CustemElevatedButtonWithIcon(
      {super.key,
      required this.ButtonName,
      required this.actionFuntion,
      required this.icon,
      this.background = Colors.black,
      this.foreground = Colors.white});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: background,
            foregroundColor: foreground),
        onPressed: actionFuntion,
        label: Text(ButtonName));
  }
}

//     String errormessage = e.toString().replaceFirst("Exception", "");
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         behavior: SnackBarBehavior.floating,
//         duration: Duration(seconds: 2),
//         margin: EdgeInsets.all(8),
//         backgroundColor: Colors.red,
//         padding: EdgeInsets.all(8),
//         content: Text(
//           "Error: ${errormessage}",
//           style: TextStyle(fontSize: 15),
//         )));
//   }
// }
class Custemsnackbarforexception extends StatefulWidget {
  Exception e;
  BuildContext context;

  Custemsnackbarforexception(
      {super.key, required this.e, required this.context});

  @override
  State<Custemsnackbarforexception> createState() =>
      _CustemsnackbarforexceptionState();
}

class _CustemsnackbarforexceptionState
    extends State<Custemsnackbarforexception> {
  String errormessage = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    errormessage = widget.e.toString().replaceFirst("Exception", "");
    log(errormessage);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(8),
        backgroundColor: Colors.red,
        padding: const EdgeInsets.all(8),
        content: Text(
          "Error: $errormessage",
          style: const TextStyle(fontSize: 15),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

custumSnackBarException(Object e, BuildContext context) {
  String errormessage = e.toString().replaceFirst("Exception", "");
  log(errormessage);
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(8),
      backgroundColor: Colors.red,
      padding: const EdgeInsets.all(8),
      content: Text(
        "Error: $errormessage",
        style: const TextStyle(fontSize: 15),
      )));
}

void CustumAlertDialog(
    {required BuildContext context,
    required String title,
    required String subtitle,
    required String noButton,
    required String yesButton,
    required void Function() yesonPressed,
    required void Function() noonpressed}) {
  showDialog(
      context: context,
      builder: (Context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 50),
          ),
          content: Text(
            subtitle,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
                onPressed: noonpressed,
                child: Text(
                  noButton,
                  style: const TextStyle(color: Colors.black),
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.black,
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: yesonPressed,
              child: Text(yesButton),
            )
          ],
        );
      });
}

void popTwice(BuildContext context) {
  Navigator.pop(context); // Pops the current route
  Navigator.pop(context); // Pops the previous route
}

class BuildNavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BuildNavItem({super.key, 
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  _BuildNavItemState createState() => _BuildNavItemState();
}

class _BuildNavItemState extends State<BuildNavItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap(
            widget.index); // Calling the onTap function passed from parent
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.icon,
            color: widget.currentIndex == widget.index
                ? Colors.white
                : Colors.grey,
          ),
          Text(
            widget.label,
            style: TextStyle(
              color: widget.currentIndex == widget.index
                  ? Colors.white
                  : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomChoiceChip extends StatelessWidget {
  final String label;
  final String type;
  final int index;
  final String selected;
  final int selected1;
  final Function(String, int) onSelectionChanged;

  const CustomChoiceChip({super.key, 
    required this.label,
    required this.type,
    required this.index,
    required this.selected,
    required this.selected1,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = type == "All" ? selected == "All" : selected1 == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          onSelectionChanged(type, index);
        },
        selectedColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        showCheckmark: false,
      ),
    );
  }
}

class MyCustomWidget extends StatefulWidget {
  const MyCustomWidget({super.key});

  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  String _selected = "All";
  int _selected1 = -1;

  void _filteredProducts() {
    // Your logic to filter products goes here
  }

  void _onSelectionChanged(String type, int index) {
    setState(() {
      if (type == "All") {
        _selected = "All";
        _selected1 = -1;
      } else {
        _selected1 = index;
        _selected = "";
      }
      _filteredProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomChoiceChip(
          label: "All",
          type: "All",
          index: 0,
          selected: _selected,
          selected1: _selected1,
          onSelectionChanged: _onSelectionChanged,
        ),
        CustomChoiceChip(
          label: "Option 1",
          type: "Option",
          index: 1,
          selected: _selected,
          selected1: _selected1,
          onSelectionChanged: _onSelectionChanged,
        ),
        CustomChoiceChip(
          label: "Option 2",
          type: "Option",
          index: 2,
          selected: _selected,
          selected1: _selected1,
          onSelectionChanged: _onSelectionChanged,
        ),
      ],
    );
  }
}

Widget searchField(TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: "Search products...",
      prefixIcon: const Icon(Icons.search, color: Colors.black54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    ),
  );
}
