import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:news_application_2/data/response/api_response.dart';
import 'package:news_application_2/models/news_create_admin.dart';
import 'package:news_application_2/repository/admin/admin_crud_repo_imp.dart';
import 'package:news_application_2/repository/admin/base_admin_crud_repo.dart';

part 'manage_news_admin_event.dart';
part 'manage_news_admin_state.dart';

class ManageNewsAdminBloc
    extends Bloc<ManageNewsAdminEvent, ManageNewsAdminState> {
  final BaseAdminCRUdRepo _baseAdminCRUdRepo;
  ManageNewsAdminBloc(this._baseAdminCRUdRepo)
      : super(
            ManageNewsAdminState(createNewsAdminModel: ApiResponse.loading())) {
    on<CreateNewsAdminDashboard>(_addNewsAdminMethod);
    on<FetchNewsAdminDashboard>(_fetchNewsAdminMethod);
    on<UpdateNewsAdminDashboard>(_modifyNewsAdminMethod);
    on<DeleteNewsAdminDashboard>(_removeNewsAdminMethod);
  }
  Future<void> _addNewsAdminMethod(CreateNewsAdminDashboard event,
      Emitter<ManageNewsAdminState> emit) async {
    try {
      // Convert DateTime to Timestamp

      await _baseAdminCRUdRepo.createNewsAdminToDB(
          event.id,
          event.image,
          event.title,
          event.desc,
          event.author,
          event.source,
          event.publishedAt);
      List<CreateNewsAdminModel> fetchData =
          await _baseAdminCRUdRepo.readNewsAdminToDB();
      emit(state.copyWith(
          createNewsAdminModel: ApiResponse.completed(fetchData)));
    } catch (e) {
      emit(state.copyWith(createNewsAdminModel: ApiResponse.error('$e')));
      Logger.logError('_addNewsAdminMethod: $e');
    }
  }

  Future<void> _fetchNewsAdminMethod(
      FetchNewsAdminDashboard event, Emitter<ManageNewsAdminState> emit) async {
    try {
      List<CreateNewsAdminModel> fetchData =
          await _baseAdminCRUdRepo.readNewsAdminToDB();
      emit(state.copyWith(
          createNewsAdminModel: ApiResponse.completed(fetchData)));
    } catch (e) {
      emit(state.copyWith(createNewsAdminModel: ApiResponse.error('$e')));
      Logger.logError('_fetchNewsAdminMethod: $e');
    }
  }

  Future<void> _modifyNewsAdminMethod(UpdateNewsAdminDashboard event,
      Emitter<ManageNewsAdminState> emit) async {
    try {
      String imageId = DateTime.now().millisecondsSinceEpoch.toString();

      var updateNewsAdminModel = CreateNewsAdminModel(
        id: event.id,
        image: event.image,
        title: event.title,
        desc: event.desc,
        source: event.source,
        author: event.author,
        publishedAt: event.publishedAt,
        imageId: imageId,
      );
      _baseAdminCRUdRepo.updateNewsAdminToDB(updateNewsAdminModel);
      List<CreateNewsAdminModel> fetchData =
          await _baseAdminCRUdRepo.readNewsAdminToDB();
      emit(state.copyWith(
          createNewsAdminModel: ApiResponse.completed(fetchData)));
    } catch (e) {
      emit(state.copyWith(createNewsAdminModel: ApiResponse.error('$e')));
      Logger.logError('_fetchNewsAdminMethod: $e');
    }
  }

  Future<void> _removeNewsAdminMethod(DeleteNewsAdminDashboard event,
      Emitter<ManageNewsAdminState> emit) async {
    try {
      await _baseAdminCRUdRepo.deleteNewsAdminToDB(event.deleteNewsAdminModel);
      List<CreateNewsAdminModel> fetchData =
          await _baseAdminCRUdRepo.readNewsAdminToDB();
      emit(state.copyWith(
          createNewsAdminModel: ApiResponse.completed(fetchData)));
    } catch (e) {
      emit(state.copyWith(createNewsAdminModel: ApiResponse.error('$e')));
      Logger.logError('_fetchNewsAdminMethod: $e');
    }
  }
}
