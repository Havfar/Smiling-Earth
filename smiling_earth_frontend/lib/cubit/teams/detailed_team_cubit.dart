import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detailed_team_state.dart';

class DetailedteamCubit extends Cubit<DetailedteamState> {
  DetailedteamCubit() : super(DetailedteamInitial());
}
