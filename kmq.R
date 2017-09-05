

kmquantiles<-function(time, status, x, p=0.75, points=101){
	
	b<-bw.SJ(x)
	
	xs<-seq(min(x),max(x),length=points)
	rval <- list(x=xs, y=sapply(xs,function(xi) kmq(time,status,x,p,xi,b)))
	rownames(rval$y)<-p
	rval
}

kmq<-function(time,status,x,p, x0,b){
	w<-dnorm(x,x0,s=b)
	S<-survfit(Surv(time,status)~1,weights=w)
    sapply(p, function(p.){
    		i<-suppressWarnings(min(which(S$surv<=p.)))
    		S$time[i]
    })
}