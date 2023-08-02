import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_sp2/core/data/repositories/user_repository.dart';
import 'package:food_ordering_sp2/ui/shared/colors.dart';
import 'package:food_ordering_sp2/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_ordering_sp2/ui/shared/custom_widgets/custom_toast.dart';
import 'package:image_picker/image_picker.dart';

class NewSingupView extends StatefulWidget {
  NewSingupView({Key? key}) : super(key: key);

  @override
  State<NewSingupView> createState() => _NewSingupViewState();
}

class _NewSingupViewState extends State<NewSingupView> {
  final ImagePicker picker = ImagePicker();
  FileTypeModel? selectedFile;
  bool showOption = false;

  TextEditingController ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: ListView(children: [
          Center(
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                InkWell(
                  onTap: selectedFile == null
                      ? () {
                          setShowOption(true);
                        }
                      : null,
                  child: CircleAvatar(
                    radius: 50,
                    child: selectedFile == null || selectedFile!.path.isEmpty
                        ? Icon(Icons.image)
                        : selectedFile!.type != FileType.FILE
                            ? Image.file(File(selectedFile!.path))
                            : Icon(Icons.file_copy),
                  ),
                ),
                Visibility(
                  visible: selectedFile != null,
                  child: InkWell(
                    onTap: () {
                      setShowOption(true);
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.mainOrangeColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: showOption,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  text: 'Camera',
                  onPressed: () {
                    pickFile(FileType.CAMERA)
                        .then((value) => selectedFile = value);
                  },
                ),
                CustomButton(
                  text: 'Gallery',
                  onPressed: () {
                    pickFile(FileType.GALLERY)
                        .then((value) => selectedFile = value);
                  },
                ),
                CustomButton(
                  text: 'File',
                  onPressed: () {
                    pickFile(FileType.FILE)
                        .then((value) => selectedFile = value);
                  },
                ),
              ],
            ),
          ),
          CustomButton(
            text: 'Register',
            onPressed: () {
              if (selectedFile == null) {
                CustomToast.showMeassge(message: 'Please choose image');
                return;
              }
              UserRepository().register(
                  firstname: "Ma ANA",
                  lastname: 'MA HOE',
                  photoPath: selectedFile!.path);
            },
          )
        ]),
      ),
    );
  }

  void setShowOption(bool value) {
    setState(() {
      showOption = value;
    });
  }

  Future<FileTypeModel> pickFile(FileType type) async {
    String? path;
    switch (type) {
      case FileType.GALLERY:
        await picker
            .pickImage(source: ImageSource.gallery)
            .then((value) => path = value?.path ?? '');
        break;
      case FileType.CAMERA:
        await picker
            .pickImage(source: ImageSource.camera)
            .then((value) => path = value?.path ?? '');
        break;
      case FileType.FILE:
        await FilePicker.platform
            .pickFiles()
            .then((value) => path = value?.paths[0] ?? '');
        break;
    }
    setShowOption(false);
    return FileTypeModel(path ?? '', type);
  }
}

enum FileType {
  GALLERY,
  CAMERA,
  FILE;
}

class FileTypeModel {
  FileType type;
  String path;

  FileTypeModel(this.path, this.type);
}
