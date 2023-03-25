import 'package:flutter/material.dart';
import 'package:hot_foots/model/PromotionItem.dart';
import '../widgets/CustomTextInput.dart';

class EditPromotionDialog extends StatefulWidget {
  final String initialPromotionName;
  final String initialPromotionDescription;

  const EditPromotionDialog({
    Key key,
    this.initialPromotionName,
    this.initialPromotionDescription, PromotionItem promotion,
  }) : super(key: key);

  @override
  _EditPromotionDialogState createState() => _EditPromotionDialogState();
}

class _EditPromotionDialogState extends State<EditPromotionDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialPromotionName ?? '';
    _descriptionController.text = widget.initialPromotionDescription ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Promotion'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextInput(
              hintText: 'Promotion Name',
              controller: _nameController,
            ),
            SizedBox(height: 16),
            CustomTextInput(
              hintText: 'Promotion Description',
              controller: _descriptionController,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Save button action
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
