TMPDIR=/tmp

if [[ $1 == "dan-nob" ]]; then
lt-expand ../../apertium-da-nb.da.dix | grep -v '<prn><enc>' | grep -v 'REGEX' | grep -e ':<:' -e '\w:\w' | sed 's/:<:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/tmp_testvoc1.txt |
        apertium-pretransfer|
        apertium-transfer ../../apertium-da-nb.da-nb.t1x  ../../da-nb.t1x.bin  ../../da-nb.autobil.bin | tee $TMPDIR/tmp_testvoc2.txt |
        lt-proc -d ../../da-nb.autogen.bin  | sed 's/ \.//g' > $TMPDIR/tmp_testvoc3.txt
	lt-proc -d ../../nb-da.autogen.bin $TMPDIR/tmp_testvoc1.txt | sed 's/ \.//g'  > $TMPDIR/tmp_testvoc0.txt
paste -d _ $TMPDIR/tmp_testvoc0.txt $TMPDIR/tmp_testvoc1.txt $TMPDIR/tmp_testvoc2.txt $TMPDIR/tmp_testvoc3.txt | sed 's/\^.<sent>\$//g' | sed 's/_/ ------>  /g'
elif [[ $1 == "nob-dan" ]]; then
lt-expand ../../apertium-da-nb.nb.dix | grep -v '<prn><enc>' | grep -v 'REGEX' | grep -e ':<:' -e '\w:\w' | sed 's/:<:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent><clb>$/g' | tee $TMPDIR/tmp_testvoc1.txt |
        apertium-pretransfer|
        apertium-transfer ../../apertium-da-nb.nb-da.t1x  ../../nb-da.t1x.bin  ../../nb-da.autobil.bin | tee $TMPDIR/tmp_testvoc2.txt |
        lt-proc -d ../../nb-da.autogen.bin  | sed 's/ \.//g' > $TMPDIR/tmp_testvoc3.txt
	lt-proc -d ../../da-nb.autogen.bin $TMPDIR/tmp_testvoc1.txt | sed 's/ \.//g'  > $TMPDIR/tmp_testvoc0.txt
paste -d _ $TMPDIR/tmp_testvoc0.txt $TMPDIR/tmp_testvoc1.txt $TMPDIR/tmp_testvoc2.txt $TMPDIR/tmp_testvoc3.txt | sed 's/\^.<sent>\$//g' | sed 's/_/ ------>  /g'
else
	echo "Unsupported mode.";
fi
