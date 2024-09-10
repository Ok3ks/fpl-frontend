import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class Log {
  static Logger? _logger;
  static File? _logFile;

  static Future<void> init() async {
    _logFile = await _getLogFile();
    var fileOutput = FileOutput(_logFile!);
    _logger = Logger(
      printer: PrettyPrinter(),
      output: MultiOutput([ConsoleOutput(), fileOutput]),
    );
  }

  static Logger get logger {
    if (_logger == null) {
      throw Exception('Logger is not initialized. Call Log.init() first.');
    }
    return _logger!;
  }

  static Future<File> _getLogFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/app.log');
    if (!file.existsSync()) {
      file.createSync();
    }
    return file;
  }
}

class FileOutput extends LogOutput {
  final File file;

  FileOutput(this.file);

  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      file.writeAsStringSync('$line\n', mode: FileMode.append, flush: true);
    }
  }
}
