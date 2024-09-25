part of 'manage_news_admin_bloc.dart';

abstract class ManageNewsAdminEvent extends Equatable {
  const ManageNewsAdminEvent();

  @override
  List<Object> get props => [];
}

class CreateNewsAdminDashboard extends ManageNewsAdminEvent {
  // final CreateNewsAdminModel createNewsAdminModel;
  final String id;
  final String? image;
  final String? title;
  final String? desc;
  final String? author;
  final String? source;
  final Timestamp? publishedAt;
  const CreateNewsAdminDashboard({
    required this.image,
    this.title,
    this.desc,
    this.author,
    this.source,
    this.publishedAt,
    required this.id,
  });
  @override
  List<Object> get props => [
        id,
        title ?? '',
        desc ?? '',
        author ?? '',
        source ?? '',
        publishedAt ?? ''
      ];
}

class FetchNewsAdminDashboard extends ManageNewsAdminEvent {
  final String docId;

  const FetchNewsAdminDashboard({required this.docId});
  @override
  List<Object> get props => [docId];
}

class UpdateNewsAdminDashboard extends ManageNewsAdminEvent {
  final String id;
  final String? image;
  final String? title;
  final String? desc;
  final String? author;
  final String? source;
  final Timestamp? publishedAt;
  const UpdateNewsAdminDashboard({
    required this.image,
    this.title,
    this.desc,
    this.author,
    this.source,
    this.publishedAt,
    required this.id,
  });
  @override
  List<Object> get props => [
        id,
        title ?? '',
        desc ?? '',
        author ?? '',
        source ?? '',
        publishedAt ?? ''
      ];
}

class DeleteNewsAdminDashboard extends ManageNewsAdminEvent {
  final CreateNewsAdminModel deleteNewsAdminModel;
  const DeleteNewsAdminDashboard({required this.deleteNewsAdminModel});
  @override
  List<Object> get props => [deleteNewsAdminModel];
}
