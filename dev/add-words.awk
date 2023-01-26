#!/usr/bin/gawk -f

BEGIN {
    # nrestrict="<sg><ind>" # only dictionary forms
    # vrestrict="<inf>"     # only dictionary forms
    nrestrict=""          # try all forms
    vrestrict=""          # try all forms
    vprestrict=""         # try all forms
    asrestrict=""         # try all forms
    anrestrict=""         # try all forms
    avrestrict=""         # try all forms
    FS="/"
    langs["dan"]++
    langs["nob"]++
    langs["nno"]++
    mainposes["m"]++
    mainposes["mf"]++
    mainposes["f"]++
    mainposes["ut"]++
    mainposes["nt"]++
    mainposes["v"]++
    mainposes["as"]++
    mainposes["an"]++
    mainposes["av"]++
    mainposes["np"]++
    nounpos["m"]++
    nounpos["f"]++
    nounpos["mf"]++
    nounpos["ut"]++
    nounpos["nt"]++
    for(lang in langs) for(mainpos in mainposes) {
            # initialize so awk doesn't type-fail
            ana[lang][mainpos][""]++; delete ana[lang][mainpos][""]
            biknown[lang][mainpos][""]++; delete biknown[lang][mainpos][""]
    }
    for(lang in langs)while(getline<(tmpd"/"lang)){
      gsub(/[$^]/,"")
      for(a=2;a<=NF;a++){
          if($a~$1"<n><m>"nrestrict)       ana[lang]["m"][$1]++;
          if($a~$1"<n><mf>"nrestrict)      ana[lang]["mf"][$1]++;
          if($a~$1"<n><f>"nrestrict)       ana[lang]["f"][$1]++;
          if($a~$1"<n><ut>"nrestrict)      ana[lang]["ut"][$1]++;
          if($a~$1"<n><nt>"nrestrict)      ana[lang]["nt"][$1]++;
          if($a~$1"<vblex>"vrestrict)      ana[lang]["v"][$1]++
          if($a~$1"<adj><pp>"vprestrict)   ana[lang]["v"][$1]++
          if($a~$1"<adj><sint>"asrestrict) ana[lang]["as"][$1]++
          if($a~$1"<adj><pst>"anrestrict)  ana[lang]["an"][$1]++
          if($a~$1"<adv>"avrestrict)       ana[lang]["av"][$1]++
          if($a~$1"<np>")                  ana[lang]["np"][$1]++
      }
    }
    for(lang in langs) while(getline<(tmpd"/"lang"-known")){
      gsub(/[$^]/,"")
      for(a=2;a<=NF;a++){
          # biknown is used to skip existing – we want to skip ana[m] if biknown[ut/f/nt/m]:
          if($a~$1"<n>")         biknown[lang]["m"][$1]++
          if($a~$1"<n>")         biknown[lang]["mf"][$1]++
          if($a~$1"<n>")         biknown[lang]["f"][$1]++
          if($a~$1"<n>")         biknown[lang]["ut"][$1]++
          if($a~$1"<n>")         biknown[lang]["nt"][$1]++
          if($a~$1"<vblex>")     biknown[lang]["v"][$1]++
          if($a~$1"<adj><pp>")   biknown[lang]["v"][$1]++
          if($a~$1"<adj><(sint|pst)>") biknown[lang]["as"][$1]++
          if($a~$1"<adj><(sint|pst)>") biknown[lang]["an"][$1]++
          if($a~$1"<adv>")       biknown[lang]["av"][$1]++
          if($a~$1"<np>")        biknown[lang]["np"][$1]++
      }
    }
    FS=":"
    while(getline<(tmpd"/bi")){ bi[$1][$2]++ }

    for(ng in ana["dan"]) {
     for(nw in ana["dan"][ng]) {
      if(nw in bi)for(bw in bi[nw]) {
       biseen[nw][bw]++
       lr=""
       if(bw in biknown["nob"][ng] && nw in biknown["dan"][ng]) {
           bgs="";for(mainpos in mainposes) if(bw in ana["nob"][mainpos]) bgs=bgs"+"mainpos; sub(/^\+/,"",bgs)
           ngs="";for(mainpos in mainposes) if(nw in ana["dan"][mainpos]) ngs=ngs"+"mainpos; sub(/^\+/,"",ngs)
           print "<apertium-notrans>Both sides in (dan "ngs"; nob " bgs"), skipping. Compare </apertium-notrans>"bw"<apertium-notrans>"nw":"bw"</apertium-notrans>"
           continue
       }
       else if(!(bw in ana["nob"][ng]) && bw in biknown["nno"][ng] && nw in biknown["dan"][ng]) {
           bgs="";for(mainpos in mainposes) if(bw in ana["nno"][mainpos]) bgs=bgs"+"mainpos; sub(/^\+/,"",bgs)
           ngs="";for(mainpos in mainposes) if(nw in ana["dan"][mainpos]) ngs=ngs"+"mainpos; sub(/^\+/,"",ngs)
           print "<apertium-notrans>Both sides in (dan "ngs"; nno " bgs"; no nob analysis), skipping. Compare </apertium-notrans>"bw"<apertium-notrans>"nw":"bw"</apertium-notrans>"
           continue
       }
       else if(bw in biknown["nob"][ng]) {
           print "<apertium-notrans>nob-side already in bidix ("ng"), LR-ing. Compare </apertium-notrans>"bw"<apertium-notrans>"nw":"bw"</apertium-notrans>"
           lr=" r=\"LR\""
       }
       for(pos in ana["nno"]) {
           if(lr)s=""; else s="         "
           if(bw in ana["nno"][pos] && bw in ana["nob"][pos]) e[pos]="<e"lr">"s
           else if(bw in ana["nno"][pos]) e[pos]="<e"lr" vr=\"nno\">"
           else e[pos]="<e"lr" vr=\"nob\">"
       }
       if(ng=="f" &&nw in ana["dan"]["m"]) print "dan-side dupe!"
       if(ng=="f" &&nw in ana["dan"]["nt"]) print "dan-side dupe!"
       if(ng=="m" &&nw in ana["dan"]["nt"]) print "dan-side dupe!"
       nW=nw;gsub(/ /,"<b/>",nW)
       bW=bw;gsub(/ /,"<b/>",bW)
       if     (ng== "v" && bw in ana["nob"][ng])   print e[ng]   "<p><l>"nW"</l><r>"bW"</r></p><par n=\"vblex\"/></e>"
       else if(ng=="as" && bw in ana["nob"][ng])   print e[ng]   "<p><l>"nW"</l><r>"bW"</r></p><par n=\"adj_sint\"/></e>"
       else if(ng=="an" && bw in ana["nob"]["as"]) print e["as"] "<p><l>"nW"</l><r>"bW"</r></p><par n=\"adj:adj_sint\"/></e>"
       else if(ng=="as" && bw in ana["nob"]["an"]) print e["an"] "<p><l>"nW"</l><r>"bW"</r></p><par n=\"adj_sint:adj\"/></e>"
       else if(ng=="an" && bw in ana["nob"][ng])   print e[ng]   "<p><l>"nW"</l><r>"bW"</r></p><par n=\"adj\"/></e>"
       else if(ng=="av" && bw in ana["nob"][ng])   print e[ng]   "<p><l>"nW"<s n=\"adv\"/></l><r>"bW"<s n=\"adv\"/></r></p></e>"
       else if(ng=="np" && bw in ana["nob"][ng])   print e[ng]   "<p><l>"nW"<s n=\"np\"/></l><r>"bW"<s n=\"np\"/></r></p></e>"
       else {
           pr = 0
           nno_f_nob_m = (ng in nounpos && (bw in ana["nno"]["f"] && bw in ana["nob"]["m"]))
           some_m      = (ng in nounpos && (bw in ana["nno"]["m"] || bw in ana["nob"]["m"]))
           some_f      = (ng in nounpos && (bw in ana["nno"]["f"] || bw in ana["nob"]["f"]))
           some_mf     = (ng in nounpos && (bw in ana["nno"]["mf"] || bw in ana["nob"]["mf"]))
           some_nt     = (ng in nounpos && (bw in ana["nno"]["nt"] || bw in ana["nob"]["nt"]))
           if(nno_f_nob_m) { pr++; print "<e"lr">"s"<p><l>"nW"<s n=\"n\"/><s n=\""ng"\"/></l><r>"bW"<s n=\"n\"/></r></p><par n=\":f/m\"/></e>" }
           else if(some_m) { pr++; print e["m"]    "<p><l>"nW"<s n=\"n\"/><s n=\""ng"\"/></l><r>"bW"<s n=\"n\"/><s n=\"m\"/></r></p></e>" }
           else if(some_f) { pr++; print e["f"]    "<p><l>"nW"<s n=\"n\"/><s n=\""ng"\"/></l><r>"bW"<s n=\"n\"/><s n=\"f\"/></r></p></e>" }
           if(some_mf)     { pr++; print e["mf"]   "<p><l>"nW"<s n=\"n\"/><s n=\""ng"\"/></l><r>"bW"<s n=\"n\"/><s n=\"mf\"/></r></p><par n=\"sgpl:sp\"/></e>" }
           if(some_nt)     { pr++; print e["nt"]   "<p><l>"nW"<s n=\"n\"/><s n=\""ng"\"/></l><r>"bW"<s n=\"n\"/><s n=\"nt\"/></r></p></e>" }
           if(!pr) {
               # all the print <e> above failed:
               bgg=""; for(bg in ana["nob"])if(bw in ana["nob"][bg])bgg=bgg"]["bg; sub(/^\]\[/,"",bgg)
               if(!bgg) {
                   print "Only found in dan: "nw"["ng"], couldn't find in nno/nob: "bw
               }
               else {
                   print "Only mismatching PoS found: "nw"["ng"] vs "bw"["bgg"]"
               }
           }
       }
      }
     }
    }
    for(nw in bi) {
        for(bw in bi[nw]){
            if(!(nw in biseen && bw in biseen[nw])) {
                print "No analysis for: "nw":"bw
            }
        }
    }
}
