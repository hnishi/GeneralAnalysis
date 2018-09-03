#!/bin/bash -eu

NAME="do_histo.bash";
VERSION=1.2;

echo Program: $NAME  
echo Version: $VERSION  


#inputfile=$1 #major_major_angle_400ns.dat  
#outfile=$2 #histo.dat  
#echo $inputfile
#echo $outfile

width_win=1.0
# for general histogram, interval_win shold be equal to width_win.
interval_win=1.0 # shift from a previous window
min_x=0
max_x=20
column=5 #column number in the file to calulate 


################################
# AWK scripts                  #
################################
read -d '' scriptVariable << 'EOF'
BEGIN {
  for (i=v_min_x;i+v_width_win<=v_max_x;i+=v_interval_win) {
    num_sum[i] = 0; #initialization
  }
  total_data = 0;
}
{
  for (i=v_min_x;i+v_width_win<=v_max_x;i+=v_interval_win) {
    if (i <= $v_column && $v_column < i+v_interval_win) {
      num_sum[i] ++; 
      total_data ++;
    }
  }
}
END {
  for (i=v_min_x;i+v_width_win<=v_max_x;i+=v_interval_win) {
      print i,num_sum[i] > v_outfile
  }
  print "total number of data =", total_data
}
EOF
################################
# End of AWK Scripts           #
################################

string1="p "

for i in $(ls out_do2*);do 
echo $i
inputfile=$i #major_major_angle_400ns.dat  
outfile="out_do4_"$i #histo.dat  

awk -v v_min_x="${min_x}" \
    -v v_width_win="${width_win}" \
    -v v_interval_win="${interval_win}" \
    -v v_max_x="${max_x}" \
    -v v_outfile="${outfile}" \
    -v v_column="${column}" \
"$scriptVariable" ${inputfile}

string1=$string1" \""${outfile}"\" w l, " 

done

echo $string1 | sed -e 's/,$//g' 
echo $string1 | sed -e 's/,$//g' > plot_out_do4.gp
echo pause -1 >> plot_out_do4.gp
