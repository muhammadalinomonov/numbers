import 'package:json_annotation/json_annotation.dart';
import 'package:numbers/features/numbers/domain/entities/number_trivia_entity.dart';
part 'number_trivia_model.g.dart';

@JsonSerializable()
class NumberTriviaModel extends NumberTriviaEntity {
  const NumberTriviaModel({
     super.id,
    super.number,
    super.text,
    super.category,
    super.data,
    super.isSaved = false,
  });

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) => _$NumberTriviaModelFromJson(json);

  Map<String, dynamic> toJson() => _$NumberTriviaModelToJson(this);


}
