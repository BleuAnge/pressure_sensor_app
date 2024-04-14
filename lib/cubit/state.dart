part of 'cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {
  final String isSensorAvailable;

  const HomeInitial({
    required this.isSensorAvailable
  });

  @override
  List<Object> get props => [
    isSensorAvailable
  ];

  HomeInitial copyWith({
    String? isSensorAvailable
  }) {
    return HomeInitial(
      isSensorAvailable: isSensorAvailable ?? this.isSensorAvailable
    );
  }
}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final double pressure;
  final StreamSubscription streamSubscription;

  const HomeLoaded({
    required this.streamSubscription,
    required this.pressure
  });

  @override
  List<Object> get props => [
    pressure
  ];

  HomeLoaded copyWith({
    double? pressure
  }) {
    return HomeLoaded(
      streamSubscription: streamSubscription,
      pressure: pressure ?? this.pressure
    );
  }
}
