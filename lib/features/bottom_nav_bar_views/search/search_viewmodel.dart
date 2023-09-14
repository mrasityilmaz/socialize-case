import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/mixin/viewmodel_mixins/viewmodel_helper_mixin.dart';
import 'package:my_coding_setup/data/models/user_models/user_data_model/user_data_model.dart';
import 'package:my_coding_setup/domain/repositories/user_repository/i_auth_repository.dart';
import 'package:my_coding_setup/injection/injection_container.dart';

final class SearchViewModel extends ChangeNotifier with BusyAndErrorStateHelper {
  SearchViewModel();

  final TextEditingController searchController = TextEditingController();

  bool _isSearching = false;

  bool get isSearching => _isSearching;

  void setIsSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  List<UserDataModel> _searchedUsers = List.empty(growable: true);

  List<UserDataModel> get searchedUsers => _searchedUsers;

  void _setSearchedUsers(List<UserDataModel> value) {
    _searchedUsers = List.from(value);
    setInitialised(true);
    notifyListeners();
  }

  Future<void> search(String value) async {
    final result = await runBusyFuture(locator<IUserRepository>().searchUsers(query: value.trimRight()));

    _setSearchedUsers(result.getOrElse(() => []));
  }
}
