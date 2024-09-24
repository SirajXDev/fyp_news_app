part of 'manage_news_admin_bloc.dart';

sealed class ManageNewsAdminState extends Equatable {
  const ManageNewsAdminState();
  
  @override
  List<Object> get props => [];
}

final class ManageNewsAdminInitial extends ManageNewsAdminState {}
