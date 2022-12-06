import 'dart:io';

import 'package:dori/components/dory_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({Key? key}) : super(key: key);

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final _nameController = TextEditingController();
  File? _pickedImage;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  } //화면이 끝날때 controller 종료 권장

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const CloseButton(),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, //좌측정렬
                children: [
                  const SizedBox(height: largeSpace),
                  Text('어떤 약이에요?', style: Theme.of(context).textTheme.headline4),
                  const SizedBox(height: largeSpace),
                  Center(
                    child: CircleAvatar(
                        radius: 40,
                        child: CupertinoButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SafeArea(
                                    child: Padding(
                                      padding: pagePadding,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              ImagePicker()
                                                  .pickImage(
                                                      source: ImageSource.camera)
                                                  .then((xfile) {
                                                if (xfile != null) {
                                                  setState(() {
                                                    _pickedImage =
                                                        File(xfile.path);
                                                  });
                                                }
                                                Navigator.maybePop(context);
                                              });
                                            },
                                            child: Text('카메라로 촬영'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              ImagePicker()
                                                  .pickImage(
                                                      source: ImageSource.gallery)
                                                  .then((xfile) {
                                                if (xfile != null) {
                                                  setState(() {
                                                    _pickedImage =
                                                        File(xfile.path);
                                                  });
                                                }
                                                Navigator.maybePop(context);
                                              });
                                            },
                                            child: Text('앨범에서 가져오기'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          padding: _pickedImage == null ? null : EdgeInsets.zero,
                          // 이미지가 없으면 처리
                          child: _pickedImage == null
                              ? const Icon(
                                  CupertinoIcons.photo_camera_solid,
                                  size: 30,
                                  color: Colors.white,
                                )
                              : CircleAvatar(
                                  //이미지가 반드시 있을때 처리
                                  foregroundImage: FileImage(_pickedImage!),
                                  radius: 40,
                                ),
                        )),
                  ),
                  const SizedBox(height: largeSpace + regularSpace),
                  Text('약이름', style: Theme.of(context).textTheme.subtitle1),
                  TextFormField(
                    controller: _nameController,
                    maxLength: 20,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                      hintText: '복용할 약 이름을 기입해주세요.',
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                      contentPadding: textFieldContentPadding,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: submitButtonBoxPadding,
            child: SizedBox(
              height: sumbitButtonHeight,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.subtitle1),
                  child: Text('다음')),
            ),
          ),
        ));
  }
}
