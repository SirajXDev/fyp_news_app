import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/state_mgt/bloc/admin/bloc/manage_news_admin_bloc.dart';
import 'package:news_application_2/utils/utils.dart';

class ReadNewsAdminPanelView extends StatefulWidget {
  const ReadNewsAdminPanelView({super.key});

  @override
  State<ReadNewsAdminPanelView> createState() => _ReadNewsAdminPanelViewState();
}

class _ReadNewsAdminPanelViewState extends State<ReadNewsAdminPanelView> {
  @override
  void initState() {
    String docId = FirebaseAuth.instance.currentUser?.uid ?? 'docId';
    context
        .read<ManageNewsAdminBloc>()
        .add(FetchNewsAdminDashboard(docId: docId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageNewsAdminBloc, ManageNewsAdminState>(
      builder: (context, state) {
        return const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleTextThemeWidget(title: "ReadNewsAdminPanelView"),
          ],
        );
      },
    );
  }
}
