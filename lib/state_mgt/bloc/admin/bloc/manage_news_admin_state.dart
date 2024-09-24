part of 'manage_news_admin_bloc.dart';

class ManageNewsAdminState extends Equatable {
  const ManageNewsAdminState({required this.createNewsAdminModel});
  final ApiResponse<List<CreateNewsAdminModel>> createNewsAdminModel;
  ManageNewsAdminState copyWith(
      {ApiResponse<List<CreateNewsAdminModel>>? createNewsAdminModel}) {
    return ManageNewsAdminState(
        createNewsAdminModel:
            createNewsAdminModel ?? this.createNewsAdminModel);
  }

  @override
  List<Object> get props => [createNewsAdminModel];
}
