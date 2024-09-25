import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_application_2/configs/components/date_time_text_field_widget.dart';

import 'package:news_application_2/state_mgt/bloc/admin/bloc/manage_news_admin_bloc.dart';
import 'package:news_application_2/utils/extensions/flush_bar_extension.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/helper_methods/navigation_utils.dart';
import 'package:news_application_2/utils/utils.dart';
import 'package:news_application_2/utils/validation/news_validator.dart';
import 'package:news_application_2/widgets/round_button.dart';

class TextFormFieldsViaAdminCreateAdminView extends StatefulWidget {
  const TextFormFieldsViaAdminCreateAdminView(
      {super.key, required this.imgFile});
  final ValueNotifier<File?> imgFile;
  @override
  State<TextFormFieldsViaAdminCreateAdminView> createState() =>
      _TextFormFieldsViaAdminCreateAdminViewState();
}

class _TextFormFieldsViaAdminCreateAdminViewState
    extends State<TextFormFieldsViaAdminCreateAdminView> {
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
            controller: _titleTextEdtContlr,
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
              controller: _discTextEdtContlr,
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
            controller: _authorTextEdtContlr,
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
            controller: _sourceTextEdtContlr,
            decoration: Utils.commonDecoration(
                hint: 'Enter Source Name Here?', context: context),
            validator: (value) => NewsValidators.sourceValid(value),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: context.mqh * .02),
          // publishedAt -> The date and time that the article was published, in UTC (+000)

          // SizedBox(height: context.mqh * .004),
          // DateTimeTextFieldWidgetForCreateAdminView(
          //   publishAtTextEdtContlr: _publishAtTextEdtContlr,
          // ),
          //height
          SizedBox(height: context.mqh * .04),
          //submit btn here
          SubmitFormButtonCreateNewsAdminView(
              formKey: _formKey,
              title: _titleTextEdtContlr,
              desc: _discTextEdtContlr,
              author: _authorTextEdtContlr,
              source: _sourceTextEdtContlr,
              publishedAt: _publishAtTextEdtContlr,
              imageFile: widget.imgFile),
          //height
          SizedBox(height: context.mqh * .004),
        ],
      ),
    );
  }
}

class SubmitFormButtonCreateNewsAdminView extends StatefulWidget {
  const SubmitFormButtonCreateNewsAdminView({
    super.key,
    required this.formKey,
    required this.title,
    required this.desc,
    required this.author,
    required this.source,
    required this.publishedAt,
    required this.imageFile,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController title;
  final TextEditingController desc;
  final TextEditingController author;
  final TextEditingController source;
  final TextEditingController publishedAt;
  final ValueNotifier<File?> imageFile;

  @override
  State<SubmitFormButtonCreateNewsAdminView> createState() =>
      _SubmitFormButtonCreateNewsAdminViewState();
}

class _SubmitFormButtonCreateNewsAdminViewState
    extends State<SubmitFormButtonCreateNewsAdminView> {
  bool _isDataLoading = false;

  @override
  Widget build(BuildContext context) {
    return
      RoundButton(
      title: 'Submit',
      onTap: () {
        if (widget.formKey.currentState!.validate()) {
          // Form is valid
          // DialogUtils.showSuccessSnackBar(
          //     context, 'Form submitted successfully!');
          String uid = FirebaseAuth.instance.currentUser?.uid ?? 'uid';
          debugPrint('submit: ${widget.imageFile}');

          if (widget.imageFile.value?.path == null) return;

          setState(() {
            _isDataLoading = true;
          });
          context.read<ManageNewsAdminBloc>().add(
                CreateNewsAdminDashboard(
                  id: uid,
                  title: widget.title.text,
                  desc: widget.desc.text,
                  author: widget.author.text,
                  source: widget.source.text,
                  publishedAt: Timestamp.now(), // Convert DateTime to Timestamp
                  image: widget.imageFile.value?.path,
                ),
              );

          debugPrint('publishedAtSubmit: ${widget.publishedAt.text}');
          context.flushBarSuccessMessage(
              message: 'Form submitted successfully!');

          // NavigationUtils.popNavigation(context);

          setState(() {
            _isDataLoading = false;
          });
        } else {
          context.flushBarErrorMessage(
              message: 'Please fill in all required fields');
        }
      },
      color: Theme.of(context).colorScheme.onPrimary,
      loading: _isDataLoading,
    );
  }
}
