
h1<-function(t) ifelse(t<5, .1,.5)
h2<-function(t) ifelse(t<5, .5, .1)

H1<-function(t) ifelse(t<5, t*.1, .5*(t-5)+.1*5)
H2<-function(t) ifelse(t<5, t*.5, .1*(t-5)+.5*5)

S1<-function(t) exp(-H1(t))
S2<-function(t) exp(-H2(t))

set.seed(2017-9-8)
times<-c(seq(0,10,length=1000),100)
u1<-runif(30)
t1<-sapply(u1, function(u) min(times[S1(times)<u]))
u2<-runif(30)
t2<-sapply(u2, function(u) min(times[S2(times)<u]))
tt<-c(t1,t2)
ss<-rep(1,length(tt))
g<-rep(0:1,each=30)
d<-data.frame(time=tt,status=ss,group=g)
write.csv(d, "fakelogrank1.csv")


survdiff(Surv(time,status)~group,data=d)
survdiff(Surv(time,status)~group,data=d, rho=1)
survdiff(Surv(time,status)~group,data=d, rho=-1)


set.seed(2017-9-8)
times<-c(seq(0,30,length=1000),100)
u1<-runif(500)
t1<-sapply(u1, function(u) min(times[S1(times)<u]))
u2<-runif(500)
t2<-sapply(u2, function(u) min(times[S2(times)<u]))
tt<-c(t1,t2)
ss<-rep(1,length(tt))
g<-rep(0:1,each=500)
start<-runif(1000,0,5)+runif(1000,0,5)

d<-data.frame(start=start,time=tt,status=ss,group=g)

coxph(Surv(start, time,status)~group,data=subset(d,start<time))
coxph(Surv(time,status)~group,data=d)
write.csv(d, "fakelogrank2.csv")

