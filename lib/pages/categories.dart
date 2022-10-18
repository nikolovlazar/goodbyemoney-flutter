// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/cupertino.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void createCategory() {
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoNavigationBarBackButton(
              onPressed: () => Navigator.pop(context)),
          middle: const Text("Categories",
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          color: const Color.fromARGB(255, 0, 0, 0),
          child: Column(children: [
            Expanded(
                child: CupertinoFormSection.insetGrouped(children: [
              ...List.generate(
                  5,
                  (index) => GestureDetector(
                          child: DecoratedBox(
                        decoration: const BoxDecoration(),
                        child: CupertinoFormRow(
                            prefix: Row(children: [
                              Container(
                                  width: 12,
                                  height: 12,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  decoration: BoxDecoration(
                                    color: pickerColor,
                                    shape: BoxShape.circle,
                                  )),
                              const Text("Category name"),
                            ]),
                            helper: null,
                            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                            child: Container()),
                      )))
            ])),
            SafeArea(
                bottom: true,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: const Text('Pick a category color'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  color: pickerColor,
                                  onColorChanged: changeColor,
                                  heading: const Text('Select color'),
                                  subheading: const Text('Select color shade'),
                                  wheelSubheading: const Text(
                                      'Selected color and its shades'),
                                  pickersEnabled: const <ColorPickerType, bool>{
                                    ColorPickerType.primary: true,
                                    ColorPickerType.accent: true,
                                    ColorPickerType.custom: true,
                                    ColorPickerType.wheel: true,
                                  },
                                ),
                              ),
                              actions: <Widget>[
                                CupertinoButton(
                                  child: const Text('Got it'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                            width: 24,
                            height: 24,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: pickerColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  width: 2),
                            )),
                      ),
                      Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              child: CupertinoTextField(
                                placeholder: "Category name",
                                controller: _textController,
                              ))),
                      CupertinoButton(
                        onPressed: createCategory,
                        child: const Icon(CupertinoIcons.paperplane_fill),
                      )
                    ],
                  ),
                ))
          ]),
        ));
  }
}
