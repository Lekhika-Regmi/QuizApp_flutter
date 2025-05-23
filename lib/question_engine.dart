import 'question.dart';

class QuestionEngine {
  final List<Question> _questions = [
    Question(
      questionText: '5 + 7 = ?',
      options: ['10', '11', '12', '13'],
      correctIndex: 2,
    ),
    Question(
      questionText: '6 × 3 = ?',
      options: ['18', '21', '16', '19'],
      correctIndex: 0,
    ),
    Question(
      questionText: '15 - 9 = ?',
      options: ['5', '6', '7', '8'],
      correctIndex: 1,
    ),
    Question(
      questionText: '9 ÷ 3 = ?',
      options: ['1', '2', '3', '4'],
      correctIndex: 2,
    ),
    Question(
      questionText: '4 × 5 = ?',
      options: ['20', '25', '15', '10'],
      correctIndex: 0,
    ),
    Question(
      questionText: '8 + 6 = ?',
      options: ['14', '15', '13', '12'],
      correctIndex: 0,
    ),
    Question(
      questionText: '12 ÷ 4 = ?',
      options: ['3', '4', '5', '2'],
      correctIndex: 0,
    ),
    Question(
      questionText: '7 × 7 = ?',
      options: ['42', '48', '49', '56'],
      correctIndex: 2,
    ),
  ];

  List<Question> get questions => _questions;
}
