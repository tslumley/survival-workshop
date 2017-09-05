d<-subset(aml,x=="Maintained")

p<-rep(1/11,11)
P<-rev(cumsum(rev(p)))
f<-with(d, stepfun(c(time),c(P,0)))
plot(f, main="",xlab="time",ylab="Proportion",pch=1+3*d$status)

p[4:11]<-p[4:11]+p[3]/length(4:11)
p[3]<-0
P<-rev(cumsum(rev(p)))
f<-with(d, stepfun(time,c(P,0)))
lines(f,col="red")

plot(f, main="",xlab="time",ylab="Proportion",pch=1+3*d$status)

p[7:11]<-p[7:11]+p[6]/length(7:11)
p[6]<-0
P<-rev(cumsum(rev(p)))
f<-with(d, stepfun(time,c(P,0)))
lines(f,col="red")

plot(f, main="",xlab="time",ylab="Proportion",pch=1+3*d$status)

p[10:11]<-p[10:11]+p[9]/length(10:11)
p[9]<-0
P<-rev(cumsum(rev(p)))
f<-with(d, stepfun(time,c(P,0)))
lines(f,col="red")

plot(f, main="",xlab="time",ylab="Proportion",pch=1+3*d$status)

## compare to Kaplan-Meier
lines(survfit(Surv(time,status)~1,data=d),col="orange",conf.int=FALSE,lty=2,lwd=2)