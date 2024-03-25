part of 'booking_list_bloc.dart';

@immutable
sealed class BookingListEvent {}

class FetchBookingList extends BookingListEvent {}
