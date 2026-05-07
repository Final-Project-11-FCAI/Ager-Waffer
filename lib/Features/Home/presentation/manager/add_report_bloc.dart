import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Home/data/repositories/add_report_repository.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/add_report_state.dart';
import 'package:bloc/bloc.dart';

import '../../data/models/add_report_model.dart';

class AddReportBloc extends Bloc<AppEvent, AddReportState> {

  AddReportBloc()
      : super(
    AddReportState(
      reportData: Data(),
      status: addReportStatus.initial,
    ),
  ) {

    on<AddReportEvent>(_onAddReport);
  }

  Future<void> _onAddReport(
      AddReportEvent event,
      Emitter<AddReportState> emit,
      ) async {

    emit(state.copyWith(status: addReportStatus.loading));

    var response = await addReportRepository.addReport(
      addReportEntity: event.addReportEntity,
    );

    if (response.isSuccess!) {

      emit(
        state.copyWith(
          status: addReportStatus.success,
          reportData: response.data ?? Data(),
        ),
      );

    } else {

      emit(
        state.copyWith(
          status: addReportStatus.failure,
          failureMessage: response.messageAr ?? '',
        ),
      );
    }
  }
}

AddReportBloc addReportBloc = AddReportBloc();