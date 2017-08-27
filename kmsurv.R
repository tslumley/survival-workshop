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

