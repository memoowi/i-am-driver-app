part of 'pending_list_bloc.dart';

@immutable
sealed class PendingListEvent {}

class FetchPendingList extends PendingListEvent {}
