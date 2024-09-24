import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_application_2/data/response/api_response.dart';
import 'package:news_application_2/models/news_create_admin.dart';

part 'manage_news_admin_event.dart';
part 'manage_news_admin_state.dart';

class ManageNewsAdminBloc
    extends Bloc<ManageNewsAdminEvent, ManageNewsAdminState> {
  ManageNewsAdminBloc()
      : super(
            ManageNewsAdminState(createNewsAdminModel: ApiResponse.loading())) {
    on<CreateNewsAdminDashboard>(_addNewsAdminMethod);
    on<FetchNewsAdminDashboard>(_fetchNewsAdminMethod);
    on<UpdateNewsAdminDashboard>(_modifyNewsAdminMethod);
    on<DeleteNewsAdminDashboard>(_removeNewsAdminMethod);
  }
}

Future<void> _addNewsAdminMethod(
    CreateNewsAdminDashboard event, Emitter<ManageNewsAdminState> emit) async {}
Future<void> _fetchNewsAdminMethod(
    FetchNewsAdminDashboard event, Emitter<ManageNewsAdminState> emit) async {}
Future<void> _modifyNewsAdminMethod(
    UpdateNewsAdminDashboard event, Emitter<ManageNewsAdminState> emit) async {}
Future<void> _removeNewsAdminMethod(
    DeleteNewsAdminDashboard event, Emitter<ManageNewsAdminState> emit) async {}
