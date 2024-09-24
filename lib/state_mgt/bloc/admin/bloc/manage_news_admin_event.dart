part of 'manage_news_admin_bloc.dart';

abstract class ManageNewsAdminEvent extends Equatable {
  const ManageNewsAdminEvent();

  @override
  List<Object> get props => [];
}

class CreateNewsAdminDashboard extends ManageNewsAdminEvent {
  final CreateNewsAdminModel createNewsAdminModel;
  const CreateNewsAdminDashboard({required this.createNewsAdminModel});
  @override
  List<Object> get props => [createNewsAdminModel];
}

class FetchNewsAdminDashboard extends ManageNewsAdminEvent {
  final String docId;

  const FetchNewsAdminDashboard({required this.docId});
  @override
  List<Object> get props => [docId];
}

class UpdateNewsAdminDashboard extends ManageNewsAdminEvent {
  final CreateNewsAdminModel updateNewsAdminModel;
  const UpdateNewsAdminDashboard({
    required this.updateNewsAdminModel,
  });
  @override
  List<Object> get props => [updateNewsAdminModel];
}

class DeleteNewsAdminDashboard extends ManageNewsAdminEvent {
  final String docId;

  const DeleteNewsAdminDashboard({required this.docId});
  @override
  List<Object> get props => [docId];
}
