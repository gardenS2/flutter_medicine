import 'dart:io';

import 'package:dori/components/dory_constants.dart';
import 'package:dori/components/dory_page_route.dart';
import 'package:dori/pages/add_medicine/add_alarm_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'components/add_page_widget.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({Key? key}) : super(key: key);

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final _nameController = TextEditingController();
  File? _medicineImage;

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
      body: SingleChildScrollView(
        child: AddPageBody(
          children: [
                  const SizedBox(height: largeSpace),
                  Text('어떤 약이에요?', style: Theme.of(context).textTheme.headline4),
                  const SizedBox(height: largeSpace),
                  Center(
                    child: MedicineImageButton(
                      changeImageFile: (File? value) {
                        _medicineImage = value;
                      },
                    ),
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
                    //변화감지
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                ],
              ),
      ),
      bottomNavigationBar: BottomSubmitButton(
        onPressed: _nameController.text.isEmpty ? null : _onAddAlarmPage,
        text: '다음'),
    );
  }

  void _onAddAlarmPage() {
    Navigator.push(
      context,
      //페이드 효과 라우트
      FadePageRoute(
        page: AddAlarmPage(
          medicineImage: _medicineImage,
          medicineName: _nameController.text,
        ),
      ),
    );
  }
}



class MedicineImageButton extends StatefulWidget {
  const MedicineImageButton({Key? key, required this.changeImageFile})
      : super(key: key);

  //내부 위젯에서 소비되는 데이터를 외부에 전달
  final ValueChanged<File?> changeImageFile;

  @override
  State<MedicineImageButton> createState() => _MedicineImageButtonState();
}

class _MedicineImageButtonState extends State<MedicineImageButton> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 40,
        child: CupertinoButton(
          onPressed: _showBottomSheet,
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
        ));
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return PickImageBottomSheet(
            onPressedCamera: () => _onPressed(ImageSource.camera),
            onPressedGallery: () => _onPressed(ImageSource.gallery),
          );
        });
  }

  void _onPressed(ImageSource source) {
    ImagePicker().pickImage(source: source).then((xfile) {
      if (xfile != null) {
        setState(() {
          _pickedImage = File(xfile.path);
          widget.changeImageFile(_pickedImage);
        });
      }
      Navigator.maybePop(context);
    });
  }
}

class PickImageBottomSheet extends StatelessWidget {
  const PickImageBottomSheet(
      {Key? key, required this.onPressedCamera, required this.onPressedGallery})
      : super(key: key);

  final VoidCallback onPressedCamera;
  final VoidCallback onPressedGallery;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: onPressedCamera,
              child: Text('카메라로 촬영'),
            ),
            TextButton(
              onPressed: onPressedGallery,
              child: Text('앨범에서 가져오기'),
            ),
          ],
        ),
      ),
    );
  }
}
