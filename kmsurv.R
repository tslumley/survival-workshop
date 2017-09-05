library(survival)
data(pbc)

dies<-function(time, status, from, to){
	keep<-time>from
	time<-time[keep]
	status<-status[keep]
	status[time>to]<-0 #I aten't dead
	mean(status)
}

t10<-with(pbc, dies(time/365, status, from=0, to=10))


t5<-with(pbc,c(dies(time/365,status,0,5),
	dies(time/365,status,5,10)))



t2<-with(pbc, c(dies(time/365,status,0,2),
	dies(time/365,status,2,4),
	dies(time/365,status,4,6),
	dies(time/365,status,6,8),
	dies(time/365,status,8,10)))
	
t1<-sapply(0:9, function(from) with(pbc, dies(time/365,status, from,from+1)))	

thalf<-sapply(seq(0,9.5,by=0.5), function(from) with(pbc, dies(time/365,status, from,from+0.5)))	

tmonth<-sapply(seq(0,9+11/12,by=1/12), function(from) with(pbc, dies(time/365,status, from,from+1/12)))	

## Individual points get noisier
plot(1:10,t1,type="h",xlab='Years',ylab="Proportion dying",ylim=range(0,t1))
plot(seq(1/12,10,by=1/12),tmonth,type="h",xlab='Years',ylab="Proportion dying")


## survival function doesn't
plot(c(0,10), c(1,cumprod(1-t10)),type="s",xlab="years",ylab="Proportion alive", ylim=c(0,1))
lines(c(0,5, 10), c(1, cumprod(1-t5)),type="s",lty=2)
lines(c(0,2,4,6,8,10), c(1, cumprod(1-t2)),type="s",lty=3)

lines(c(0:10), c(1, cumprod(1-t1)),type="s",lty=1,col="blue")
lines(seq(0,10,by=0.5), c(1, cumprod(1-thalf)),type="s",lty=3,col="blue")
lines(seq(0,10,by=1/12), c(1, cumprod(1-tmonth)),type="s",lty=1,col="goldenrod")

