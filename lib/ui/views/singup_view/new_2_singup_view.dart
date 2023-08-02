import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_sp2/core/data/repositories/shared_prefreance_repository.dart';
import 'package:food_ordering_sp2/core/data/repositories/user_repository.dart';
import 'package:food_ordering_sp2/core/enums/file_type.dart';
import 'package:food_ordering_sp2/core/enums/message_type.dart';
import 'package:food_ordering_sp2/ui/shared/colors.dart';
import 'package:food_ordering_sp2/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_ordering_sp2/ui/shared/custom_widgets/custom_toast.dart';
import 'package:food_ordering_sp2/ui/shared/utils.dart';
import 'package:food_ordering_sp2/ui/views/main_view/main_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class Singup2View extends StatefulWidget {
  Singup2View({Key? key}) : super(key: key);

  @override
  State<Singup2View> createState() => _Singup2ViewState();
}

class _Singup2ViewState extends State<Singup2View> {
  final ImagePicker picker = ImagePicker();
  FileModel? selectedFile;
  bool showOptions = false;

  TextEditingController ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(children: [
        Center(
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              InkWell(
                onTap: selectedFile == null || selectedFile!.path.isEmpty
                    ? () {
                        setShowOPtion(true);
                      }
                    : null,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.mainOrangeColor,
                  child: selectedFile == null
                      ? Icon(Icons.person)
                      : selectedFile!.path.isNotEmpty &&
                              selectedFile!.type == FileTypeEnum.FILE
                          ? Icon(Icons.file_copy)
                          : selectedFile!.path.isNotEmpty
                              ? Image.file(File(selectedFile!.path))
                              : Icon(Icons.person),
                ),
              ),
              Visibility(
                  visible:
                      selectedFile != null && selectedFile!.path.isNotEmpty,
                  child: InkWell(
                    onTap: () {
                      setShowOPtion(true);
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.mainBlueColor,
                    ),
                  ))
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Visibility(
          visible: showOptions,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                text: 'Camera',
                onPressed: () {
                  pickFile(FileTypeEnum.CAMERA)
                      .then((value) => selectedFile = value);
                },
              ),
              CustomButton(
                text: 'Gallery',
                onPressed: () {
                  pickFile(FileTypeEnum.GALLERY)
                      .then((value) => selectedFile = value);
                },
              ),
              CustomButton(
                text: 'File',
                onPressed: () {
                  pickFile(FileTypeEnum.FILE).then((value) => selectedFile = value);
                },
              ),
            ],
          ),
        ),
        CustomButton(
          text: 'Register',
          onPressed: () {
            UserRepository()
                .register(
                    firstname: 'Malek',
                    lastname: 'Alzein',
                    photoPath: selectedFile!.path)
                .then((value) {
              value.fold((l) {
                CustomToast.showMeassge(
                    message: l, messageType: MessageType.REJECTED);
              }, (r) {
                CustomToast.showMeassge(
                    message: 'Registerd Successfully',
                    messageType: MessageType.SUCCSESS);

                UserRepository()
                    .login(email: 'Test@gmail.com', password: 'Test@1234')
                    .then((value) {
                  value.fold((l) {
                    CustomToast.showMeassge(
                        message: l, messageType: MessageType.REJECTED);
                  }, (r) {
                    storage.setLoggedIN(true);
                    storage.setTokenInfo(r);

                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return MainView();
                      },
                    ));
                  });
                });
              });
            });
          },
        ),
        Lottie.asset(
          'assets/lottie/145958-figma-to-lottie-face.json',
        ),
        CustomButton(
          text: 'Open Link',
          onPressed: () async {
            final Uri _url = Uri.parse('https://flutter.dev');
            if (!await launchUrl(
              _url,
              mode: LaunchMode.externalApplication,
            )) {
              CustomToast.showMeassge(
                  message: 'Cant open url', messageType: MessageType.REJECTED);
            }
          },
        )
      ]),
    );
  }

  void setShowOPtion(bool value) {
    setState(() {
      showOptions = value;
    });
  }

  Future<FileModel> pickFile(FileTypeEnum type) async {
    String path = '';

    switch (type) {
      case FileTypeEnum.CAMERA:
        await picker
            .pickImage(source: ImageSource.camera)
            .then((value) => path = value?.path ?? '');
        break;
      case FileTypeEnum.GALLERY:
        await picker
            .pickImage(source: ImageSource.gallery)
            .then((value) => path = value?.path ?? '');
        break;
      case FileTypeEnum.FILE:
        await FilePicker.platform
            .pickFiles()
            .then((value) => path = value?.paths[0] ?? '');
        break;
    }
    setShowOPtion(false);
    return FileModel(path.isNotEmpty ? path : selectedFile!.path,
        path.isNotEmpty ? type : selectedFile!.type);
  }
}

class FileModel {
  FileTypeEnum type;
  String path;

  FileModel(this.path, this.type);
}

