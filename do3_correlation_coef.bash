#!/bin/bash -eu

NAME="do3_correlation_coef.bash";
VERSION=1.0;

echo Program: $NAME  
echo Version: $VERSION  

inp1=../gyrate_1_10_cut10ns.dat
inp2=../../out_do4_6_26.txt

tmp1=zzz
paste $inp1 $inp2 > $tmp1

################################
# AWK scripts                  #
################################
read -d '' scriptVariable << 'EOF'
{
  x[NR] = $1
  y[NR] = $2
}
END{
  if(NR == 0) exit

  for(i in x){
    sum_x += x[i]
    sum_y += y[i]
  }

  m_x = sum_x / NR
  m_y = sum_y / NR

  for(i in x){
    sum_dx2 += (x[i] - m_x) ^ 2
    sum_dy2 += (y[i] - m_y) ^ 2
    sum_dxdy += (x[i] - m_x) * (y[i] - m_y)
  }

  if(sum_dx2 == 0.0 || sum_dy2 == 0.0) exit

  print sum_dxdy / sqrt(sum_dx2) / sqrt(sum_dy2)
}
EOF
################################
# End of AWK Scripts           #
################################

awk "$scriptVariable" $tmp1

rm $tmp1

