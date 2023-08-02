import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_ordering_sp2/ui/shared/custom_widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

enum FileType { GALLERY, CAMERA, FILE }

class SingupView extends StatefulWidget {
  SingupView({Key? key}) : super(key: key);

  @override
  State<SingupView> createState() => _SingupViewState();
}

class _SingupViewState extends State<SingupView> {
  final ImagePicker picker = ImagePicker();

  bool? showOption = false;
  FileTypeModel? selectedFile;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: ListView(children: [
        Stack(
          children: [
            InkWell(
              onTap: selectedFile == null
                  ? () {
                      setState(() {
                        showOption = true;
                      });
                    }
                  : null,
              child: CircleAvatar(
                radius: 80,
                child: selectedFile == null
                    ? Icon(Icons.image)
                    : (selectedFile != null &&
                            selectedFile!.type == FileType.FILE
                        ? Icon(Icons.file_copy)
                        : ClipOval(
                            child: Image.file(File(selectedFile!.path)))),
              ),
            ),
            Visibility(
              visible: selectedFile != null,
              child: InkWell(
                onTap: () {
                  setState(() {
                    showOption = true;
                  });
                },
                child: CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.edit),
                ),
              ),
            )
          ],
        ),
        Visibility(
          visible: showOption!,
          child: Column(
            children: [
              CustomButton(
                text: 'Camera',
                onPressed: () async {
                  await pickFile(type: FileType.CAMERA).then(
                    (value) {
                      selectedFile = value;
                      setState(() {
                        showOption = false;
                      });
                    },
                  );
                },
              ),
              CustomButton(
                text: 'Gallery',
                onPressed: () async {
                  await pickFile(type: FileType.GALLERY).then(
                    (value) {
                      selectedFile = value;
                      setState(() {
                        showOption = false;
                      });
                    },
                  );
                },
              ),
              CustomButton(
                text: 'file',
                onPressed: () async {
                  await pickFile(type: FileType.FILE).then(
                    (value) {
                      selectedFile = value;
                      setState(() {
                        showOption = false;
                      });
                    },
                  );
                },
              ),
            ],
          ),
        )
      ]),
    ));
  }

  Future<FileTypeModel> pickFile({required FileType type}) async {
    String? path;

    switch (type) {
      case FileType.GALLERY:
        await picker
            .pickImage(source: ImageSource.gallery)
            .then((value) => path = value!.path);
        break;

      case FileType.CAMERA:
        await picker
            .pickImage(source: ImageSource.camera)
            .then((value) => path = value!.path);
        break;

      case FileType.FILE:
        await FilePicker.platform
            .pickFiles()
            .then((value) => path = value!.paths[0]);
        break;
    }

    return FileTypeModel(type, path ?? '');
  }
}

class FileTypeModel {
  FileType type;
  String path;

  FileTypeModel(this.type, this.path);
}
