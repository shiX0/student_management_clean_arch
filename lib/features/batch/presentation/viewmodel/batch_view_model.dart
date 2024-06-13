import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/common/my_snackbar.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_starter/features/batch/domain/usecases/batch_usecase.dart';
import 'package:student_management_starter/features/batch/presentation/state/batch_state.dart';

final batchViewModelProvider =
    StateNotifierProvider<BatchViewModel, BatchState>((ref) {
  return BatchViewModel(ref.read(batchUsecaseProvider));
});

class BatchViewModel extends StateNotifier<BatchState> {
  BatchViewModel(this.batchUsecase) : super(BatchState.initial()) {
    getAllBatches();
  }
  final BatchUsecase batchUsecase;

  addBatch(BatchEntity batch) async {
    state = state.copyWith(isLoading: true);
    var data = await batchUsecase.addBatch(batch);
    data.fold((l) {
      state = state.copyWith(isLoading: false, error: l.error);
      showMySnackbar(message: l.error, color: Colors.red[800]);
    }, (r) {
      state = state.copyWith(isLoading: false, error: null);
      showMySnackbar(message: "Batch Added Sucessfully!");
    });
    getAllBatches();
  }

  getAllBatches() async {
    state = state.copyWith(isLoading: true);
    var data = await batchUsecase.getAllBatches();
    data.fold((l) {
      state = state.copyWith(isLoading: false, error: l.error);
      showMySnackbar(message: l.error, color: Colors.red[800]);
    }, (r) {
      state = state.copyWith(isLoading: false, lstBatches: r, error: null);
    });
  }
}
