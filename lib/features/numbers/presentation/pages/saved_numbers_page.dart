import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:numbers/features/numbers/presentation/blocs/number/numbers_bloc.dart';
import 'package:numbers/features/numbers/presentation/widgets/number_detail_sheet.dart';

class SavedNumbersPage extends StatefulWidget {
  const SavedNumbersPage({super.key});

  @override
  State<SavedNumbersPage> createState() => _SavedNumbersPageState();
}

class _SavedNumbersPageState extends State<SavedNumbersPage> {

  late final NumbersBloc _numbersBloc;

  @override
  void initState() {
    super.initState();

    _numbersBloc = NumbersBloc()
      ..add(GetSavedNumberTriviaEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _numbersBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Saved Numbers'),
        ),
        body: BlocBuilder<NumbersBloc, NumbersState>(
          builder: (context, state) {
            if (state.savedNumberStatus.isInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.savedNumberStatus.isFailure) {
              return Center(child: Text(state.errorMessage ?? 'An error occurred'));
            } else if (state.savedNumbers.isEmpty) {
              return const Center(child: Text('No saved numbers'));
            } else {
              return ListView.builder(
                itemCount: state.savedNumbers.length,
                itemBuilder: (context, index) {
                  final number = state.savedNumbers[index];
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => BlocProvider.value(
                          value: _numbersBloc,
                          child: NumberDetailSheet(numberTrivia: number),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Text(
                        '${number.text}',
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
