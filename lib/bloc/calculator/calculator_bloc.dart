import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorState()) {
    on<ResetAC>(_onResetAC);
    on<AddNumber>(_onAddNumber);
    on<ChangeNegativePositive>(_onChangeNegativePositive);
    on<DeleteLastEntry>(_onDeleteLastEntry);
    on<OperationEntry>(_onOperationEntry);
    on<CalculateResult>(_onCalculateResult);
  }

  void _onResetAC(ResetAC event, emit) {
    emit(
      CalculatorState(
        firstNumber: '0',
        mathResult: '0',
        secondNumber: '0',
        operation: '+',
      ),
    );
  }

  void _onAddNumber(AddNumber event, emit) {
    emit(
      state.copyWith(
        mathResult: state.mathResult == '0'
            ? event.number
            : state.mathResult + event.number,
      ),
    );
  }

  void _onChangeNegativePositive(ChangeNegativePositive event, emit) {
    emit(
      state.copyWith(
        mathResult: state.mathResult.contains('-')
            ? state.mathResult.replaceFirst('-', '')
            : '-' + state.mathResult,
      ),
    );
  }

  void _onDeleteLastEntry(DeleteLastEntry event, emit) {
    emit(
      state.copyWith(
        mathResult: state.mathResult.length > 1
            ? state.mathResult.substring(0, state.mathResult.length - 1)
            : '0',
      ),
    );
  }

  void _onOperationEntry(OperationEntry event, emit) {
    emit(
      state.copyWith(
          firstNumber: state.mathResult,
          mathResult: '0',
          operation: event.operation,
          secondNumber: '0'),
    );
  }

  void _onCalculateResult(CalculateResult event, emit) {
    final double num1 = double.parse(state.firstNumber);
    final double num2 = double.parse(state.mathResult);

    switch (state.operation) {
      case '+':
        emit(
          state.copyWith(
            mathResult: '${num1 + num2}',
            secondNumber: state.mathResult,
          ),
        );
        break;

      case '-':
        emit(
          state.copyWith(
            mathResult: '${num1 - num2}',
            secondNumber: state.mathResult,
          ),
        );
        break;

      case '/':
        emit(
          state.copyWith(
            mathResult: '${num1 / num2}',
            secondNumber: state.mathResult,
          ),
        );
        break;

      case 'X':
        emit(
          state.copyWith(
            mathResult: '${num1 * num2}',
            secondNumber: state.mathResult,
          ),
        );
        break;

      default:
        emit(state);
    }
  }
}
