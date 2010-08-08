#!/bin/bash

if [[ $# -lt 1 ]]; then
	echo "Not enough arguments to generation-test.sh";
	echo "bash generation-test.sh <corpus>";
	exit;
fi

if [[ $1 == "-r" ]]; then
	if [[ $# -lt 2 ]]; then 
		echo $#;
		echo "Not enough arguments to generation-test.sh -r";
		echo "bash generation-test.sh -r <corpus>";
		exit;
	fi
	args=("$@")
	echo "Corpus in: "`dirname $2`;
	echo -n "Processing corpus for generation test... ";
	rm -f /tmp/da-nb.corpus.txt
	for i in `seq 1 $#`; do 
		if [[ ${args[$i]} != "" && -f ${args[$i]} ]]; then 
			cat ${args[$i]} >> /tmp/da-nb.corpus.txt
		fi
	done
	echo "done.";
	echo -n "Translating corpus for generation test (this could take some time)... ";
	cat /tmp/da-nb.corpus.txt | apertium -d ../ da-nb-transfer | sed 's/\$\W*\^/$\n^/g' > /tmp/da-nb.gentest.transfer
	echo "done.";
fi

if [[ ! -f /tmp/da-nb.gentest.transfer ]]; then
	echo "Something went wrong in processing the corpus, you have no output file.";
	echo "Try running:"
	echo "   sh generation-test.sh -r <corpus>";
	exit;
fi

cat /tmp/da-nb.gentest.transfer | sed 's/^ //g' | grep -v -e '@' -e '*' -e '[0-9]<Num>' -e '#}' -e '#{' | sed 's/\$>/$/g' | sort -f | uniq -c | sort -gr > /tmp/da-nb.gentest.stripped
cat /tmp/da-nb.gentest.stripped | lt-proc -d ../da-nb.autogen.bin > /tmp/da-nb.gentest.surface
cat /tmp/da-nb.gentest.stripped | sed 's/^ *[0-9]* \^/^/g' > /tmp/da-nb.gentest.nofreq
paste /tmp/da-nb.gentest.surface /tmp/da-nb.gentest.nofreq | grep -e '\/' -e '#'  > /tmp/da-nb.generation.errors.txt
cat /tmp/da-nb.generation.errors.txt  | grep -v '#' | grep '\/' > /tmp/da-nb.multiform
cat /tmp/da-nb.generation.errors.txt  | grep '#.*\/' > /tmp/da-nb.multibidix 
cat /tmp/da-nb.generation.errors.txt  | grep '#' | grep -v '\/' > /tmp/da-nb.tagmismatch 

echo "";
echo "===============================================================================";
echo "Multiple surface forms for a single lexical form";
echo "===============================================================================";
cat /tmp/da-nb.multiform

echo "";
echo "===============================================================================";
echo "Multiple bidix entries for a single source language lexical form";
echo "===============================================================================";
cat /tmp/da-nb.multibidix

echo "";
echo "===============================================================================";
echo "Tag mismatch between transfer and generation";
echo "===============================================================================";
cat /tmp/da-nb.tagmismatch

echo "";
echo "===============================================================================";
echo "Summary";
echo "===============================================================================";
wc -l /tmp/da-nb.multiform /tmp/da-nb.multibidix /tmp/da-nb.tagmismatch
