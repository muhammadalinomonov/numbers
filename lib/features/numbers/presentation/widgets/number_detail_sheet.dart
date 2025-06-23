import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numbers/features/numbers/domain/entities/number_trivia_entity.dart';
import 'package:numbers/features/numbers/presentation/blocs/number/numbers_bloc.dart';
import 'package:numbers/features/numbers/presentation/widgets/common_button.dart';

class NumberDetailSheet extends StatefulWidget {
  const NumberDetailSheet({super.key, required this.numberTrivia});

  final NumberTriviaEntity numberTrivia;

  @override
  State<NumberDetailSheet> createState() => _NumberDetailSheetState();
}

class _NumberDetailSheetState extends State<NumberDetailSheet> {
  late bool _isSaved;

  @override
  void initState() {
    super.initState();

    _isSaved = widget.numberTrivia.isSaved;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumbersBloc, NumbersState>(
      builder: (context, state) {
        return Container(
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(12).copyWith(top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    context.read<NumbersBloc>().add(
                          SaveNumberTriviaEvent(
                            number: widget.numberTrivia,
                            onSuccess: () {
                              if(!_isSaved){
                                Navigator.pop(context);
                              }
                            },
                            onError: () {
                              setState(() {
                                _isSaved = !_isSaved; // Revert the change on error
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to save number trivia'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            isSaved: _isSaved,
                          ),
                        );

                    setState(() {
                      _isSaved = !_isSaved;
                    });
                  },
                  icon: Icon(_isSaved ? Icons.bookmark : Icons.bookmark_border),
                ),
              ),
              Text(
                widget.numberTrivia.number.toString(),
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.numberTrivia.text,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              CommonButton(
                text: 'Ok',
                onTap: () => Navigator.pop(context),
                margin: EdgeInsets.only(bottom: 8),
              ),
            ],
          ),
        );
      },
    );
  }
}
