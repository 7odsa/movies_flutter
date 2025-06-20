import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_flutter/_resources/helpers/shared_prefs.dart';

part 'l10n_state.dart';

enum EnumLang { en, ar }

class L10nCubit extends Cubit<String> {
  L10nCubit() : super(SharedPrefs.getL10n());
  void switchLanguage(EnumLang lang) async {
    final newl10n = await SharedPrefs.toggle(lang);
    emit(newl10n);
  }
}
