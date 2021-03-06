// Copyright 2016 Google Inc. Use of this source code is governed by an
// MIT-style license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:grinder/grinder.dart';

import 'grind/npm.dart';
import 'grind/synchronize.dart';

export 'grind/bazel.dart';
export 'grind/benchmark.dart';
export 'grind/chocolatey.dart';
export 'grind/github.dart';
export 'grind/homebrew.dart';
export 'grind/npm.dart';
export 'grind/standalone.dart';
export 'grind/synchronize.dart';

main(List<String> args) => grind(args);

@DefaultTask('Compile async code and reformat.')
@Depends(format, synchronize)
all() {}

@Task('Run the Dart formatter.')
format() {
  Pub.run('dart_style',
      script: 'format',
      arguments: ['--overwrite']
        ..addAll(existingSourceDirs.map((dir) => dir.path)));
}

@Task('Installs dependencies from npm.')
npm_install() => run("npm", arguments: ["install"]);

@Task('Runs the tasks that are required for running tests.')
@Depends(format, synchronize, npm_package, npm_install)
before_test() {}
