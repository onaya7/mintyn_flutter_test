import 'package:logger/web.dart';

Logger get logger => Logger(
      printer: PrettyPrinter(
        dateTimeFormat: DateTimeFormat.dateAndTime,
      ),
    );
