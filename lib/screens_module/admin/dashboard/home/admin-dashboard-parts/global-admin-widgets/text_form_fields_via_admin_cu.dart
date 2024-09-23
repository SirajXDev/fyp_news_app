import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_application_2/utils/extensions/flush_bar_extension.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/utils.dart';
import 'package:news_application_2/utils/validation/news_validator.dart';
import 'package:news_application_2/widgets/round_button.dart';

class TextFormFieldsViaAdminCU extends StatefulWidget {
  const TextFormFieldsViaAdminCU({super.key});

  @override
  State<TextFormFieldsViaAdminCU> createState() =>
      _TextFormFieldsViaAdminCUState();
}

class _TextFormFieldsViaAdminCUState extends State<TextFormFieldsViaAdminCU> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleTextEdtContlr = TextEditingController();
  final TextEditingController _discTextEdtContlr = TextEditingController();
  final TextEditingController _authorTextEdtContlr = TextEditingController();
  final TextEditingController _sourceTextEdtContlr = TextEditingController();
  final TextEditingController _publishAtTextEdtContlr = TextEditingController();

  @override
  void dispose() {
    _titleTextEdtContlr.dispose();
    _discTextEdtContlr.dispose();
    _authorTextEdtContlr.dispose();
    _sourceTextEdtContlr.dispose();
    _publishAtTextEdtContlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title -> The headline or title of the article.
          const TitleTextThemeWidget(title: 'Title', size: 14),
          SizedBox(height: context.mqh * .004),
          TextFormField(
            decoration: Utils.commonDecoration(
                hint: 'Enter Title Here?', context: context),
            // style: const TextStyle(fontSize: 15),
            validator: (value) => NewsValidators.titleValid(value),

            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: context.mqh * .02),
          //description -> A description or snippet from the article.
          const TitleTextThemeWidget(title: 'description', size: 14),
          SizedBox(height: context.mqh * .004),
          SizedBox(
            height: context.mqh * .1,
            child: TextFormField(
              minLines: null,
              maxLines: null,
              expands:
                  true, // expands: true with maxLines: null provides auto-expansion.
              decoration: Utils.commonDecoration(
                  hint: 'Enter Description Here?', context: context),
              validator: (value) => NewsValidators.descValid(value),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ).paddingOnly(bottom: 5),
          ),
          SizedBox(height: context.mqh * .02),
          //author -> The author of the article
          const TitleTextThemeWidget(title: 'Author', size: 14),
          SizedBox(height: context.mqh * .004),
          TextFormField(
            decoration: Utils.commonDecoration(
                hint: 'Enter Author Name Here?', context: context),
            validator: (value) => NewsValidators.authorValid(value),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: context.mqh * .02),
          // source ->  a display name for the source this article came from
          const TitleTextThemeWidget(title: 'Source Name', size: 14),
          SizedBox(height: context.mqh * .004),
          TextFormField(
            decoration: Utils.commonDecoration(
                hint: 'Enter Source Name Here?', context: context),
            validator: (value) => NewsValidators.sourceValid(value),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: context.mqh * .02),
          // publishedAt -> The date and time that the article was published, in UTC (+000)
          const TitleTextThemeWidget(title: 'publishedAt', size: 14),
          SizedBox(height: context.mqh * .004),
          DateTimeTextFieldWidgetForCreateAdminView(
            publishAtTextEdtContlr: _publishAtTextEdtContlr,
          ),
          //height
          SizedBox(height: context.mqh * .04),
          //submit btn here
          SubmitFormButtonCreateNewsAdminView(
            formKey: _formKey,
          ),
          //height
          SizedBox(height: context.mqh * .004),
        ],
      ),
    );
  }
}

class DateTimeTextFieldWidgetForCreateAdminView extends StatefulWidget {
  const DateTimeTextFieldWidgetForCreateAdminView({
    super.key,
    required this.publishAtTextEdtContlr,
  });
  final TextEditingController publishAtTextEdtContlr;
  @override
  State<DateTimeTextFieldWidgetForCreateAdminView> createState() =>
      _DateTimeTextFieldWidgetForCreateAdminViewState();
}

class _DateTimeTextFieldWidgetForCreateAdminViewState
    extends State<DateTimeTextFieldWidgetForCreateAdminView> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.publishAtTextEdtContlr,
      decoration: Utils.commonDecoration(
          hint: 'Enter Publish Date Here? DD/MM/YYYY',
          context: context,
          suffixIcon: const Icon(Icons.calendar_today)),
      onTap: () => _selectDateTime(context),
      readOnly: true,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDateTime != null) {
      if (!context.mounted) return;
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          widget.publishAtTextEdtContlr.text =
              DateFormat('dd/MM/yyyy HH:mm').format(selectedDateTime);
        });
      }
    }
  }
}

class SubmitFormButtonCreateNewsAdminView extends StatelessWidget {
  const SubmitFormButtonCreateNewsAdminView({
    super.key,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return RoundButton(
      title: 'Submit',
      onTap: () {
        if (formKey.currentState!.validate()) {
          // Form is valid
          // DialogUtils.showSuccessSnackBar(
          //     context, 'Form submitted successfully!');
          context.flushBarSuccessMessage(
              message: 'Form submitted successfully!');
        } else {
          // Form is invalid
          // DialogUtils.showErrorSnackBar(
          //     context, 'Please fill in all required fields');
          context.flushBarErrorMessage(
              message: 'Please fill in all required fields');
        }
      },
      color: Theme.of(context).colorScheme.onPrimary,
    );
  }
}
