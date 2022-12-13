import 'package:dori/components/dory_constants.dart';
import 'package:flutter/material.dart';

class AddPageBody extends StatelessWidget{
  const AddPageBody({ Key? key, required this.children}) : super(key: key);
final List<Widget> children;

  @override
  Widget build(BuildContext context){
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //좌측정렬
            children : children,
          ),
        ),
    );
  }
}
/*
class extends StatelessWidget {
  const ({ Key? : key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(

    );
  }
}*/

class BottomSubmitButton extends StatelessWidget {
  const BottomSubmitButton({
    Key? key,
    required this.onPressed,
    required this.text,
    }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context){
    return SafeArea(
        child: Padding(
          padding: submitButtonBoxPadding,
          child: SizedBox(
            height: sumbitButtonHeight,
            child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.subtitle1),
                child: Text(text)),
          ),
        ),
      );
  }
}

