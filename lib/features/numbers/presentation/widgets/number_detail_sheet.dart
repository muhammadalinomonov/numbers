import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numbers/features/numbers/presentation/blocs/number/numbers_bloc.dart';
import 'package:numbers/features/numbers/presentation/widgets/common_button.dart';

class NumberDetailSheet extends StatefulWidget {
  const NumberDetailSheet({super.key});

  @override
  State<NumberDetailSheet> createState() => _NumberDetailSheetState();
}

class _NumberDetailSheetState extends State<NumberDetailSheet> {
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
                child: IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_border)),
              ),
              Text(
                state.numberTrivia.number.toString(),
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                state.numberTrivia.text,
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
