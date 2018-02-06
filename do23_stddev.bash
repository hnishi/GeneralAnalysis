#!/bin/bash -eu

NAME="do23_stddev.bash";
VERSION=1.0;

echo Program: $NAME  
echo Version: $VERSION  


#awk '{print substr($1,8,4),substr($1,17,4),$2}' out_do12_105.txt |less

#inputfile=3d_out_do21_rg_sasa.dat 
#outputfile=out_do23.dat  

################################
# AWK scripts                  #
################################
read -d '' scriptVariable << 'EOF'
{
  x[NR] = $1
}
END{
  if(NR == 0) exit

  for(i in x){
    sum_x += x[i]
  }

  m_x = sum_x / NR

  for(i in x){
    sum_dx2 += (x[i] - m_x) ^ 2
  }

  print "average ",m_x 
  print "variance",sum_dx2 / NR
  print "standard_deviation ",sqrt(sum_dx2 / NR)
}
EOF
################################
# End of AWK Scripts           #
################################

#awk -v fn_out1=$outputfile "$scriptVariable" ${inputfile}
#echo $scriptVariable 

for i in 1 2 3 4 6 7
do
  echo $i
  echo Rg
  awk  "$scriptVariable" rg_${i}.txt
  echo SASA
  awk  "$scriptVariable" sasa_${i}.txt
done  
