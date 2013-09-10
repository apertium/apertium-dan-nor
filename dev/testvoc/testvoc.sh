if [[ $1 = "nob-dan" ]]; then
echo "==Norwegian (Bokmål)->Danish===========================";
bash inconsistency.sh nob-dan > /tmp/nob-dan.testvoc; bash inconsistency-summary.sh /tmp/nob-dan.testvoc nob-dan
echo ""

elif [[ $1 = "nno-dan" ]]; then
echo "==Norwegian (Nynorsk)->Danish===========================";
bash inconsistency.sh nno-dan > /tmp/nno-dan.testvoc; bash inconsistency-summary.sh /tmp/nno-dan.testvoc nno-dan

elif [[ $1 = "dan-nob" ]]; then
echo "==Danish->Norwegian (Bokmål)===========================";
bash inconsistency.sh dan-nob > /tmp/dan-nob.testvoc; bash inconsistency-summary.sh /tmp/dan-nob.testvoc dan-nob

elif [[ $1 = "dan-nno" ]]; then
echo "==Danish->Norwegian (Nynorsk)===========================";
bash inconsistency.sh dan-nno > /tmp/dan-nno.testvoc; bash inconsistency-summary.sh /tmp/dan-nno.testvoc dan-nno


fi
