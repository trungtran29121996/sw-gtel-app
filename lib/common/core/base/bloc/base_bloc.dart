import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_app_gtel/common/core/base/event/base_event.dart';
import 'package:sw_app_gtel/common/core/base/state/base_state.dart';

abstract class BaseBloc<E extends BaseEvent, S extends BaseState>
    extends Bloc<E, S> {
  BaseBloc({required S state}) : super(state);
}
