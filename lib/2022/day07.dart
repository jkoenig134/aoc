import 'dart:math';

import '/utils/utils.dart';

class AOCFile {
  final String name;
  final bool isFolder;
  final int? _size;
  final Map<String, AOCFile>? children;

  int get size => _size ?? children!.values.fold(0, (p, c) => p + c.size);

  AOCFile.file(this.name, this._size)
      : isFolder = false,
        children = null;

  AOCFile.folder(this.name, this.children)
      : isFolder = true,
        _size = null;
}

class FileSystem {
  final AOCFile rootDirectory = AOCFile.folder('root', {});
  FileSystem();

  List<AOCFile> _getFoldersAndSubFolders(AOCFile directory) => [
        directory,
        ...directory.children!.values
            .where((e) => e.isFolder)
            .expand((e) => _getFoldersAndSubFolders(e))
      ];

  List<AOCFile> get allFolders => _getFoldersAndSubFolders(rootDirectory);

  int sizeToFree(int neededSpace) {
    final currentFreeSpace = 70000000 - rootDirectory.size;
    return neededSpace - currentFreeSpace;
  }

  final cwd = <String>[];
  AOCFile get folderFromCwd => cwd.fold(
        rootDirectory,
        (previousValue, element) => previousValue.children![element]!,
      );

  void cd(String to) {
    if (to == '..') {
      cwd.removeLast();
    } else {
      cwd.add(to);
    }
  }

  void ls(String contents) {
    final split = contents.split(' ');
    final cmd = split[0];
    final name = split[1];

    if (cmd == 'dir') {
      folderFromCwd.children![name] = AOCFile.folder(name, {});
    } else {
      folderFromCwd.children![name] = AOCFile.file(
        name,
        int.parse(cmd),
      );
    }
  }

  factory FileSystem.fromInput(List<String> input) {
    final fs = FileSystem();

    final actualLines = input.skip(1).toList();
    for (var i = 0; i < actualLines.length; i++) {
      final parts = actualLines[i].replaceFirst('\$ ', '').split(' ');

      switch (parts[0]) {
        case 'ls':
          while (actualLines.length > i + 1 &&
              !actualLines[i + 1].startsWith('\$ ')) {
            fs.ls(actualLines[++i]);
          }
          break;

        case 'cd':
          fs.cd(parts[1]);
          break;
      }
    }

    return fs;
  }
}

main(List<String> args) => runSolutions(
      (i) => FileSystem.fromInput(i.asString()),
      part1,
      part2,
    );

int part1(FileSystem input) =>
    input.allFolders.map((e) => e.size).where((e) => e < 100000).sum;

int part2(FileSystem input) => input.allFolders
    .map((e) => e.size)
    .where((element) => element > input.sizeToFree(30000000))
    .toList()
    .reduce(min);
