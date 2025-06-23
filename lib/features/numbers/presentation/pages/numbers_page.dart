import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:numbers/core/utils/enums.dart';
import 'package:numbers/features/numbers/presentation/blocs/number/numbers_bloc.dart';
import 'package:numbers/features/numbers/presentation/pages/saved_numbers_page.dart';
import 'package:numbers/features/numbers/presentation/widgets/common_button.dart';
import 'package:numbers/features/numbers/presentation/widgets/number_detail_sheet.dart';

class NumbersPage extends StatefulWidget {
  const NumbersPage({super.key});

  @override
  State<NumbersPage> createState() => _NumbersPageState();
}

class _NumbersPageState extends State<NumbersPage> {
  late TextEditingController _controller;
  late NumbersBloc _numberBloc;
  final phoneMaskFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _numberBloc = NumbersBloc();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: BlocProvider.value(
        value: _numberBloc,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Numbers'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SavedNumbersPage()));
                  },
                  icon: Icon(Icons.bookmark))
            ],
          ),
          body: BlocConsumer<NumbersBloc, NumbersState>(
            listenWhen: (previous, current) => previous.getNumberStatus != current.getNumberStatus,
            listener: (context, state) {
              if (state.getNumberStatus.isSuccess) {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: _numberBloc,
                    child: NumberDetailSheet(numberTrivia: state.numberTrivia),
                  ),
                );
              } else if (state.getNumberStatus.isFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      height: 48,
                      margin: EdgeInsets.only(bottom: 16),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...InformationTypes.values.map(
                            (type) => CommonButton(
                              color: type == state.selectedCategory ? Colors.blue : Colors.grey,
                              margin: EdgeInsets.only(right: 12),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              onTap: () {
                                if (state.selectedCategory == type) return;
                                _controller.clear();
                                _numberBloc.add(SelectCategoryEvent(type));
                              },
                              text: type.name,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextField(
                      inputFormatters: state.selectedCategory == InformationTypes.date ? [phoneMaskFormatter] : [],
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Enter a number',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            text: "Random",
                            onTap: () {
                              _numberBloc.add(GetRandomNumberTriviaEvent());
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: CommonButton(
                            text: "Confirm",
                            onTap: () {
                              final input = _controller.text;
                              if (input.isNotEmpty) {
                                _numberBloc.add(GetNumberTriviaEvent(input));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    if (state.getNumberStatus.isInProgress) const CircularProgressIndicator(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
