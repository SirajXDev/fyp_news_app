import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'manage_news_admin_event.dart';
part 'manage_news_admin_state.dart';

class ManageNewsAdminBloc extends Bloc<ManageNewsAdminEvent, ManageNewsAdminState> {
  ManageNewsAdminBloc() : super(ManageNewsAdminInitial()) {
    on<ManageNewsAdminEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
