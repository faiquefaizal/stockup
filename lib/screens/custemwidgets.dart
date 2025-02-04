import 'dart:developer';

import 'package:flutter/material.dart';

Widget field(
    TextEditingController controllername, String labeltext, String hinttext,
    {Color colr = Colors.white,
    TextInputType inputtype = TextInputType.name,
    bool showtext = false}) {
  return TextFormField(
    controller: controllername,
    decoration: InputDecoration(
        fillColor: colr,
        filled: true,
        border: const OutlineInputBorder(),
        labelText: labeltext,
        hintText: hinttext),
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
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(content),
    backgroundColor: color,
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
  ));
}

Widget fieledvalidation(
  TextEditingController controllername,
  String labeltext,
  String hinttext,
  String? Function(String?)? validator, {
  Color colr = Colors.white,
  TextInputType inputtype = TextInputType.name,
  bool showtext = false,
}) {
  return TextFormField(
    validator: validator,
    controller: controllername,
    decoration: InputDecoration(
        fillColor: colr,
        filled: true,
        border: const OutlineInputBorder(),
        labelText: labeltext,
        hintText: hinttext),
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
      {super.key, required this.ButtonName,
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
      {super.key, required this.ButtonName,
      required this.actionFuntion,
      required this.icon,
      this.background = Colors.black,
      this.foreground = Colors.white});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: Icon(icon),
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

  Custemsnackbarforexception({super.key, required this.e, required this.context});

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
