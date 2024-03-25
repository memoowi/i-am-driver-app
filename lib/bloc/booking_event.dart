part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent {}

class UpdateBookingEvent extends BookingEvent {
  final BuildContext context;
  final int bookingId;

  UpdateBookingEvent({
    required this.context,
    required this.bookingId,
  });
}
