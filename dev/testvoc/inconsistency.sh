TMPDIR=/var/folders/0G/0GZnbqjxFwmOuN6ymZlmPk+++TI/-Tmp-/
DIR=$1

if [[ $DIR == "dan-nob" ]]; then
lt-expand ../../apertium-dan-nor.dan.dix | grep -v '<prn><enc>' | grep -v '<cmp>'| grep -v 'NON_ANALYSIS'| grep -v 'REGEX' | grep -e ':<:' -e '\w:\w' | sed 's/:<:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/tmp_testvoc1.txt |
        apertium-pretransfer|
        apertium-transfer ../../apertium-dan-nor.dan-nob.t1x  ../../dan-nob.t1x.bin  ../../dan-nob.autobil.bin | tee $TMPDIR/tmp_testvoc2.txt |
        lt-proc -d ../../dan-nob.autogen.bin  | sed 's/ \.//g' > $TMPDIR/tmp_testvoc3.txt
	lt-proc -d ../../nor-dan.autogen.bin $TMPDIR/tmp_testvoc1.txt | sed 's/ \.//g'  > $TMPDIR/tmp_testvoc0.txt
paste -d _ $TMPDIR/tmp_testvoc0.txt $TMPDIR/tmp_testvoc1.txt $TMPDIR/tmp_testvoc2.txt $TMPDIR/tmp_testvoc3.txt | sed 's/\^.<sent>\$//g' | sed 's/_/ ------>  /g'

elif [[ $DIR == "nob-dan" ]]; then
lt-expand ../../apertium-dan-nor.nob.dix | grep -v '<prn><enc>' | grep -v '<cmp>'| grep -v 'NON_ANALYSIS'| grep -v 'REGEX' | grep -e ':<:' -e '\w:\w' | sed 's/:<:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent><clb>$/g' | tee $TMPDIR/tmp_testvoc1.txt |
        apertium-pretransfer|
        apertium-transfer ../../apertium-dan-nor.nor-dan.t1x  ../../nor-dan.t1x.bin  ../../nob-dan.autobil.bin | tee $TMPDIR/tmp_testvoc2.txt |
        lt-proc -d ../../nor-dan.autogen.bin  | sed 's/ \.//g' > $TMPDIR/tmp_testvoc3.txt
	lt-proc -d ../../dan-nob.autogen.bin $TMPDIR/tmp_testvoc1.txt | sed 's/ \.//g'  > $TMPDIR/tmp_testvoc0.txt
paste -d _ $TMPDIR/tmp_testvoc0.txt $TMPDIR/tmp_testvoc1.txt $TMPDIR/tmp_testvoc2.txt $TMPDIR/tmp_testvoc3.txt | sed 's/\^.<sent>\$//g' | sed 's/_/ ------>  /g'
elif [[ $DIR == "nno-dan" ]]; then
lt-expand ../../apertium-dan-nor.nno.dix | grep -v '<prn><enc>' | grep -v '<cmp>'| grep -v 'NON_ANALYSIS' | grep -v 'REGEX' | grep -e ':<:' -e '\w:\w' | sed 's/:<:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent><clb>$/g' | tee $TMPDIR/tmp_testvoc1.txt |
        apertium-pretransfer|
        apertium-transfer ../../apertium-dan-nor.nor-dan.t1x  ../../nor-dan.t1x.bin  ../../nno-dan.autobil.bin | tee $TMPDIR/tmp_testvoc2.txt |
        lt-proc -d ../../nor-dan.autogen.bin  | sed 's/ \.//g' > $TMPDIR/tmp_testvoc3.txt
	lt-proc -d ../../dan-nno.autogen.bin $TMPDIR/tmp_testvoc1.txt | sed 's/ \.//g'  > $TMPDIR/tmp_testvoc0.txt
paste -d _ $TMPDIR/tmp_testvoc0.txt $TMPDIR/tmp_testvoc1.txt $TMPDIR/tmp_testvoc2.txt $TMPDIR/tmp_testvoc3.txt | sed 's/\^.<sent>\$//g' | sed 's/_/ ------>  /g'
elif [[ $DIR == "dan-nno" ]]; then
lt-expand ../../apertium-dan-nor.dan.dix | grep -v '<prn><enc>' | grep -v '<cmp>'| grep -v 'NON_ANALYSIS'| grep -v 'REGEX' | grep -e ':<:' -e '\w:\w' | sed 's/:<:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/tmp_testvoc1.txt |
        apertium-pretransfer|
        apertium-transfer ../../apertium-dan-nor.dan-nno.t1x  ../../dan-nno.t1x.bin  ../../dan-nno.autobil.bin | tee $TMPDIR/tmp_testvoc2.txt |
        lt-proc -d ../../dan-nno.autogen.bin  | sed 's/ \.//g' > $TMPDIR/tmp_testvoc3.txt
	lt-proc -d ../../nor-dan.autogen.bin $TMPDIR/tmp_testvoc1.txt | sed 's/ \.//g'  > $TMPDIR/tmp_testvoc0.txt
paste -d _ $TMPDIR/tmp_testvoc0.txt $TMPDIR/tmp_testvoc1.txt $TMPDIR/tmp_testvoc2.txt $TMPDIR/tmp_testvoc3.txt | sed 's/\^.<sent>\$//g' | sed 's/_/ ------>  /g'
else
	echo "Unsupported mode.";
fi
