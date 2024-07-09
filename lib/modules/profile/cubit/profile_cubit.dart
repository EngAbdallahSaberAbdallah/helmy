import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';

import '../../../helpers/cache_helper.dart';
import '../../../helpers/services_locator.dart';
import '../../../helpers/snackbar_helper.dart';
import '../models/UserProfile.dart';
import '../repository/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;
  ProfileCubit(this.profileRepository) : super(ProfileInitial());

  void updateProfile(
      {String imagePath = "", String name = "", String countryId = ""}) {
    print('I am here in update profile');
    emit(GetProfileLoading());
    profileRepository
        .updateProfile(name: name, imagePath: imagePath, countryId: countryId)
        .then((result) {
      result.fold((failure) {
        emit(GetProfileError(failure.message));
        SnackBarHelper.showErrorSnackBar(tr('failed'), failure.message);
      }, (response) async {
        getProfile();
        // await getIt.get<CacheHelper>().savePhone(response.phone!);
        // await getIt.get<CacheHelper>().saveAvatar(
        //     response.avatar != null ? response.avatar.toString() : "");
        // await getIt.get<CacheHelper>().saveName(response.firstName!);
        // await getIt.get<CacheHelper>().saveLastName(response.lastName!);
        // await getIt.get<CacheHelper>().saveGender(response.gender!);
        emit(GetProfileSuccess());
      });
    });
  }

  void getProfile() {
    profileRepository.getUserProfile();
  }
}
