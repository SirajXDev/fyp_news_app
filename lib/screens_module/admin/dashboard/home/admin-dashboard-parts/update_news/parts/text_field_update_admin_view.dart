import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/configs/components/date_time_text_field_widget.dart';
import 'package:news_application_2/models/news_create_admin.dart';

import 'package:news_application_2/state_mgt/bloc/admin/bloc/manage_news_admin_bloc.dart';
import 'package:news_application_2/utils/extensions/flush_bar_extension.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/helper_methods/navigation_utils.dart';
import 'package:news_application_2/utils/utils.dart';
import 'package:news_application_2/utils/validation/news_validator.dart';
import 'package:news_application_2/widgets/round_button.dart';

import '../../../../../../../data/response/status.dart';

class TextFormFieldsViaUpdateAdminView extends StatefulWidget {
  const TextFormFieldsViaUpdateAdminView({super.key, required this.imgFile, required this.createNewsAdminModel});
  final ValueNotifier<File?> imgFile;
  final CreateNewsAdminModel createNewsAdminModel;
  @override
  State<TextFormFieldsViaUpdateAdminView> createState() =>
      _TextFormFieldsViaAdminCreateAdminViewState();
}

class _TextFormFieldsViaAdminCreateAdminViewState
    extends State<TextFormFieldsViaUpdateAdminView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleTextEdtContlrUpdate =
      TextEditingController();
  final TextEditingController _discTextEdtContlrUpdate =
      TextEditingController();
  final TextEditingController _authorTextEdtContlrUpdate =
      TextEditingController();
  final TextEditingController _sourceTextEdtContlrUpdate =
      TextEditingController();

  @override
  void dispose() {
    _titleTextEdtContlrUpdate.dispose();
    _discTextEdtContlrUpdate.dispose();
    _authorTextEdtContlrUpdate.dispose();
    _sourceTextEdtContlrUpdate.dispose();
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
            controller: _titleTextEdtContlrUpdate,
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
              controller: _discTextEdtContlrUpdate,
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
            controller: _authorTextEdtContlrUpdate,
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
            controller: _sourceTextEdtContlrUpdate,
            decoration: Utils.commonDecoration(
                hint: 'Enter Source Name Here?', context: context),
            validator: (value) => NewsValidators.sourceValid(value),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          //height
          SizedBox(height: context.mqh * .04),
          //submit btn here
          SubmitFormButtonCreateNewsAdminView(
              formKey: _formKey,
              title: _titleTextEdtContlrUpdate,
              desc: _discTextEdtContlrUpdate,
              author: _authorTextEdtContlrUpdate,
              source: _sourceTextEdtContlrUpdate,
              imageFile: widget.imgFile, createNewsAdminModel: widget.createNewsAdminModel,
          ),
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
    required this.imageFile, required this.createNewsAdminModel,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController title;
  final TextEditingController desc;
  final TextEditingController author;
  final TextEditingController source;
  final ValueNotifier<File?> imageFile;
  final CreateNewsAdminModel createNewsAdminModel;


  @override
  State<SubmitFormButtonCreateNewsAdminView> createState() =>
      _SubmitFormButtonCreateNewsAdminViewState();
}

class _SubmitFormButtonCreateNewsAdminViewState
    extends State<SubmitFormButtonCreateNewsAdminView> {
  bool _isDataLoading = false;

  @override
  Widget build(BuildContext context) {
    return RoundButton(
      title: 'Submit',
      loading: _isDataLoading,
      onTap: () async{
        if (widget.formKey.currentState!.validate()) {
          // Form is valid
          String uid = FirebaseAuth.instance.currentUser?.uid ?? 'uid';
          debugPrint('submit: ${widget.imageFile}');

          if (widget.imageFile.value?.path == null) return;

          // Set loading state to true
          setState(() {
            _isDataLoading = true; // Start loading
          });

          // Dispatch the event to the Bloc
          context.read<ManageNewsAdminBloc>().add(
            UpdateNewsAdminDashboard(
              id: widget.createNewsAdminModel.id,
              title: widget.title.text,
              desc: widget.desc.text,
              author: widget.author.text,
              source: widget.source.text,
              publishedAt: Timestamp.now(), // Convert DateTime to Timestamp
              image: widget.imageFile.value?.path,
              imageId: widget.createNewsAdminModel.imageId,
            ),
          );

          await Future.delayed(Duration(seconds: 1)); // Adjust the delay duration as needed
          widget.title.clear();
          widget.desc.clear();
          widget.author.clear();
          widget.source.clear();
          widget.imageFile.value = null;
          context.flushBarSuccessMessage(
              message: 'Form submitted successfully!');
          // Set loading state to true
          setState(() {
            _isDataLoading = false; //

            context
                .read<ManageNewsAdminBloc>()
                .state.createNewsAdminModel

                .status ==
                Status.completed
                ?
                context.read<ManageNewsAdminBloc>().add(FetchNewsAdminDashboard())
                // NavigationUtils.popNavigation(context)

            // ScaffoldMessenger.of(context)
            //     .showSnackBar(const SnackBar(
            //     content: Text(
            //         'Profile updated successfully!')))
                : ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(
                content: Text(
                    'Error updating news! ')));// Start loading
          });
        } else {
          context.flushBarErrorMessage(
              message: 'Please fill in all required fields');
          // Set loading state to true
          setState(() {
            _isDataLoading = false; // Start loading
          });
        }
      },
      color: Theme.of(context).colorScheme.onPrimary,
    );  }
}
