#!/bin/sh

if [ -z $1 ]; then
	echo "Please pass in a project name as an argument"
	exit
fi

# check if project already exsists

project=$1
author='Nicholas Warfield'
directory=(src include lib tests resources)

# make all of the directories
for d in ${directory[@]} ; do
	mkdir -p $project/$d
done

# create a sample program
echo -e "#include <iostream>

int main() {
	std::cout << \"$author is making $project!\" << std::endl;
}" > $project/src/main.cpp

# set up testing enviornment
cp catch.hpp $project/lib

echo -e "#define CATCH_CONFIG_MAIN
#include \"catch.hpp\"

// Put tests in different files to minimize recompiling catch
" > $project/tests/test_main.cpp

echo -e "#include \"catch.hpp\"

TEST_CASE(\"Example\") {
	REQUIRE(1 == 1);
}
" > $project/tests/test_example.cpp

# set up makefile
echo "BINARY_NAME = $project
AUTHOR = $author

SOURCE_DIR = ${directory[0]}
OBJECT_DIR = ${directory[0]}/obj
INCLUDE_DIR = ${directory[1]}
LIBRARY_DIR = ${directory[2]}
RESOURCE_DIR = ${directory[4]}
BUILD_DIR = build
TEST_DIR = ${directory[3]}
" > $project/makefile

cat makefile >> $project/makefile
