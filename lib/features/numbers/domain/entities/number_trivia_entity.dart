import 'package:equatable/equatable.dart';

class NumberTriviaEntity extends Equatable {
  final int id;
  final String text;
  final int number;
  final String category;
  final String data;
  final bool isSaved;

  const NumberTriviaEntity({
    this.id = -1,
    this.text = '',
    this.number = 0,
    this.category = '',
    this.data = '',
    this.isSaved = false,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        number,
        category,
        data,
        isSaved,
      ];

  NumberTriviaEntity copyWith({
    String? text,
    int? number,
    String? category,
    String? data,
    bool? isSaved,
  }) {
    return NumberTriviaEntity(
      text: text ?? this.text,
      number: number ?? this.number,
      category: category ?? this.category,
      data: data ?? this.data,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
