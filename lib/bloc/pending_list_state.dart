part of 'pending_list_bloc.dart';

@immutable
sealed class PendingListState {}

final class PendingListInitial extends PendingListState {}

final class PendingListLoading extends PendingListState {}

final class PendingListLoaded extends PendingListState {
  final BookingListModel data;
  PendingListLoaded({required this.data});
}
