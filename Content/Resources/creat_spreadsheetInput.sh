
LogRatioFile=ratio_100test.dugio
spreadsheetFile=ratio100test.fa

# Get number fos samples and data sample rate from headers
# Calculate finc which is the frequency increment in the file
# Read the data and flip it so 0Hz is first sample (done with suflip
# Print frequency,Ratio to a file that can be read in with Spread sheet software

let dt=`dugio2 read file=$LogRatioFile query=* line=LMOC008012P1_cable1_gun1 |surange |grep dt| awk '{print $2*2}'`
let ns=`dugio2 read file=$LogRatioFile query=* line=LMOC008012P1_cable1_gun1 |surange |grep ns| awk '{print $2}'`

echo $dt $ns

finc=$(bc -l <<< "1000000/$dt/($ns-1)")
dugio2 read file=$LogRatioFile query=* line=LMOC008012P1_cable1_gun1 |suflip flip=3 |suascii bare=3 |
awk '{INDX+=1; print (INDX-1)*'$finc',$1}' >$spreadsheetFile

echo $finc
