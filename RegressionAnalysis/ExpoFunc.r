

#x0<-c(0,4,10,20,25,30,40)
#y0<-c(3.37E+00,-2.48E+00,-3.92E+00,-4.30E+00,-5.72E+00,-6.54E+00,-7.83E+00)

#x1<-c(4,10,20,25,30,40)
#y1<-c(-2.48E+00,-3.92E+00,-4.30E+00,-5.72E+00,-6.54E+00,-7.83E+00)

x0<-c(0,4,10,20,25,30,40)
y0<-c(3.50887E-08,0.000643697,0.007226904,0.013651466,0.145811672,0.580259928,5.069118718)

x1<-c(0,4,10,20,25,30,40)
y1<-c(3.50887E-08,0.000643697,0.007226904,0.013651466,0.145811672,0.580259928,5.069118718)


#nls( y~a/(1+b*exp(c*x)), start=c(a=1,b=1,c=-1))

#fm1<-nls(y1~a*x1^(3/2)+b,start=c(a=1,b=1),trace=TRUE)
fm1<-nls(y1~a*exp(b*x1),start=c(a=0.1,b=0.1),trace=TRUE)

plot(x0,y0)
#lines(x1,fitted(fm1))

print(summary(fm1))

# For high resolution
## (1) Try1: generation of many points
## *** can plot only range of input data
r <- range(x1)
x2 <- seq(r[1],r[2],length.out=200)
y2 <- predict(fm1,list(x1=x2))
lines(x2,y2)

## (2) Try2
## *** just plot the function
#a1 <- coef(fm1)[1]
#b1 <- coef(fm1)[2]
#lines(x<-c(0:40),a1*exp(b1*x))
