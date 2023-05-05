import 'package:flutter/material.dart';

class CustomContextMenuPage extends StatelessWidget {
  const CustomContextMenuPage({super.key});

  DialogRoute _showDialog(BuildContext context) {
    return DialogRoute<void>(
      context: context,
      builder: (context) =>
          const AlertDialog(title: Text('Calling from context menu!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom context menu example'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            const SizedBox(height: 20.0),

            // Default context menu
            const SelectableText('Default context menu.'),
            const SizedBox(height: 20.0),

            // Platform specific context menu
            TextField(
              maxLines: 3,
              controller:
                  TextEditingController(text: 'Platform specific context menu'),
              contextMenuBuilder: (context, editableTextState) {
                return AdaptiveTextSelectionToolbar.editableText(
                  editableTextState: editableTextState,
                );
              },
            ),
            const SizedBox(height: 20.0),

            // Custom phone selection menu
            TextField(
              maxLines: 2,
              controller: TextEditingController(
                text:
                    'Select the phone number and open the menu: +919876543210',
              ),
              contextMenuBuilder: (context, editableTextState) {
                final TextEditingValue value =
                    editableTextState.textEditingValue;
                final List<ContextMenuButtonItem> buttonItems =
                    editableTextState.contextMenuButtonItems;
                if (isValidPhone(value.selection.textInside(value.text))) {
                  buttonItems.insert(
                      0,
                      ContextMenuButtonItem(
                        label: 'Call number',
                        onPressed: () {
                          ContextMenuController.removeAny();
                          Navigator.of(context).push(_showDialog(context));
                        },
                      ));
                }
                return AdaptiveTextSelectionToolbar.buttonItems(
                  anchors: editableTextState.contextMenuAnchors,
                  buttonItems: buttonItems,
                );
              },
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  bool isValidPhone(String text) {
    return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(text);
  }
}
