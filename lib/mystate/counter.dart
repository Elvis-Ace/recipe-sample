import 'package:mobx/mobx.dart';
part 'counter.g.dart';

class Counter = CounterBase with _$Counter;
abstract class CounterBase with Store{
  @observable
  String value = "Setting Up Data ....";

  @action
  void adjust(String newdata){
    value = newdata;
  }

}