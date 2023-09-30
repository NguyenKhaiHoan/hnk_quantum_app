part of 'value.dart';

class RangeValue extends IterableValue {
  const RangeValue(this.start, this.step, this.stop) : super._();

  final Value start;
  final Value step;
  final Value stop;

  @override
  Iterable<Value> get value sync* {
    var v = start;
    while (true) {
      if (v.gt(stop).value) {
        break;
      }
      yield v;
      v = v.add(step);
    }
  }

  @override
  String toString() => 'Range()';

  @override
  ComplexValue toComplex() => throw InvalidOperationException('Cannot convert');

  @override
  FloatValue toFloat() => throw InvalidOperationException('Cannot convert');

  @override
  IntValue toInt() => throw InvalidOperationException('Cannot convert');

  @override
  BitValue toBit() => throw InvalidOperationException('Cannot convert');

  @override
  BoolValue toBool() => throw InvalidOperationException('Cannot convert');

  @override
  AngleValue toAngle() => throw InvalidOperationException('Cannot convert');

  @override
  Value? promoteFor(Value a) =>
      throw InvalidOperationException('Cannot convert');

  @override
  FloatValue promote(Value a) =>
      throw InvalidOperationException('Cannot convert');

  @override
  BoolValue eq(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  BoolValue lt(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  BoolValue lte(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  Value add(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  Value sub(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  Value mul(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  Value div(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  Value mod(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  Value pow(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  Value sqrt() => throw InvalidOperationException('Cannot convert');

  @override
  Value exp() => throw InvalidOperationException('Cannot convert');

  @override
  Value log() => throw InvalidOperationException('Cannot convert');
}
