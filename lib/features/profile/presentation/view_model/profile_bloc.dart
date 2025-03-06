import 'package:carinfo/features/profile/domain/usecase/get_user_profile_usecase.dart';
import 'package:carinfo/features/profile/presentation/view_model/profile_event.dart';
import 'package:carinfo/features/profile/presentation/view_model/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;

  ProfileBloc({required this.getUserProfileUseCase}) : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is FetchUserProfile) {
      yield ProfileLoading();
      try {
        final user = await getUserProfileUseCase();
        yield ProfileLoaded(user: user);
      } catch (e) {
        yield ProfileError(message: e.toString());
      }
    }
  }
}
