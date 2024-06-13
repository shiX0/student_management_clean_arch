import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_starter/features/batch/presentation/viewmodel/batch_view_model.dart';

class BatchView extends ConsumerStatefulWidget {
  const BatchView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BatchViewState();
}

class _BatchViewState extends ConsumerState<BatchView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController batchController = TextEditingController();
    var batchState = ref.watch(batchViewModelProvider);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("Add Batch"),
            TextFormField(
              controller: batchController,
              decoration: const InputDecoration(
                labelText: 'Enter a batch',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      ref.read(batchViewModelProvider.notifier).addBatch(
                          BatchEntity(batchName: batchController.text));
                    },
                    child: const Text('add batch'))),
            const Text("Batch List"),
            if (batchState.isLoading) ...{
              const Center(
                child: CircularProgressIndicator(),
              )
            } else if (batchState.error != null) ...{
              Text("Batch Err ${batchState.error.toString()}")
            } else if (batchState.lstBatches.isEmpty) ...{
              const Text("NO Batches")
            } else ...{
              Expanded(
                child: ListView.builder(
                  itemCount: batchState.lstBatches.length,
                  itemBuilder: (context, index) {
                    var batches = batchState.lstBatches[index];
                    return ListTile(
                      leading: IconButton(
                        icon: const Icon(Icons.group_outlined),
                        onPressed: () {},
                      ),
                      title: Text(batches.batchName!),
                      subtitle: Text(batches.batchId ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {},
                      ),
                    );
                  },
                ),
              )
            }
          ],
        ),
      ),
    );
  }
}
