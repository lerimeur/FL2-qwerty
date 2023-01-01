import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fl2_qwerty_messenger/Page/rename.dart';
import 'package:fl2_qwerty_messenger/type.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  late bool darkMode = context.read<API>().user.darkMode;
  final ImagePicker _picker = ImagePicker();
  String _image = '';

  void goToRename() {
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const Rename(),
      ),
    );
  }

  void pushPic(String base64string) {
    context.read<API>().postProfilPic(base64string);
  }

  @override
  void initState() {
    super.initState();
    _image = context.read<API>().user.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SizedBox(
          height: defaultPadding * 0.5,
        ),
        Center(
          child: GestureDetector(
            onTap: () async {
              final XFile? image = await _picker.pickImage(
                source: ImageSource.camera,
                imageQuality: 20,
                preferredCameraDevice: CameraDevice.front,
              );
              if (image == null) {
                return;
              }
              final File imagefile = File(image.path);
              final Uint8List imagebytes = await imagefile.readAsBytes();
              final String base64string = base64.encode(imagebytes);
              pushPic(base64string);
              setState(() {
                _image = base64string;
              });
            },
            child: Container(
              child: _image != ''
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.memory(
                          const Base64Decoder().convert(_image),
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      width: 100,
                      height: 100,
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(
          height: defaultPadding * 0.25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 2),
            Text(
              '${context.watch<API>().user.firstname} ${context.watch<API>().user.lastname}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const Spacer(flex: 2),
          ],
        ),
        const SizedBox(
          height: defaultPadding * 0.75,
        ),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              children: <Widget>[
                const Text(
                  'Thème sombre',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
                ),
                const Spacer(),
                Switch(
                  activeColor: primaryColor,
                  value: darkMode,
                  onChanged: (bool value) {
                    context.read<API>().updateDarkMode(value);
                    setState(() {
                      darkMode = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: InkWell(
            onTap: () {
              goToRename();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
              child: Row(
                children: const <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nom et prénom',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
