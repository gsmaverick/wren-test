#!/usr/bin/env python

# This script will bundle wren-test into a single `module.wren` file which can
# be included in your project. This is done to work around the Wren module
# system which currently doesn't handle deeply nested imports very well.
import fnmatch
import os

# Directory which contains this script.
scriptRoot = os.path.dirname(os.path.realpath(__file__))

# Top-level wren-test directory.
wrenTestRoot = os.path.abspath(os.path.join(scriptRoot, ".."))

# Path to the "src" directory in wren-test.
sourcesDirectory = os.path.join(wrenTestRoot, "src")

# Get all Wren source files in the "src" directory.
sources = [os.path.join(dirpath, path)
    for (dirpath, _, files) in os.walk(sourcesDirectory)
    for path in fnmatch.filter(files, '*.wren')]

# Workaround for https://github.com/munificent/wren/issues/246.
a = sources.index('/Users/gavin/Projects/wren-test/src/matchers.wren')
b = len(sources) - 1
sources[b], sources[a] = sources[a], sources[b]

# List of all source lines to be written to module file.
sourceLines = []

# Iterate over every source file to add necessary lines.
for source in sources:
    with open(source, 'r') as sourceFile:
        linesToAdd = [l for l in sourceFile if not l.startswith("import")]
        sourceLines.extend(linesToAdd)

with open(os.path.join(wrenTestRoot, "module.wren"), 'w') as moduleFile:
    moduleFile.writelines(sourceLines)

