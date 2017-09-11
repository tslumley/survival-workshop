/* This code reads .csv files directly from Thomas' github 			*/
/* https://github.com/tslumley/survival-workshop					*/
/* There are 10 files to load and colon.csv and pbc.csv have		*/
/* some additional edits made, including splitting pbc				*/

/* Final SAS files created are:										*/
/* CGD, PBC(unused), PBC_TRT_NA (from pbc.csv, subset where trt=NA),*/
/* PBC_TRT_NOTNA (from pbc.csv, subset where trt is not missing),	*/ 
/* AIDS, COLON (from colon.csv with only etype = 2), NICKEL, PBCSEQ,*/
/* HYPOXIA, RETINO (from retinopathy.csv),  						*/
/* FAKE1 (from fakelogrank1.csv) and FAKE2 (From fakelogrank2.csv)	*/

%MACRO getmycsv (csvname=);
FILENAME &csvname. temp;
PROC HTTP
	URL="https://raw.githubusercontent.com/tslumley/survival-workshop/master/&csvname..csv"
	METHOD="GET"
	OUT=&csvname.;
RUN;

PROC IMPORT
	FILE=&csvname.
	OUT=WORK.&csvname. replace
	DBMS=csv;
RUN;
%MEND getmycsv;

%getmycsv(csvname=cgd);
%getmycsv(csvname=pbc);
%getmycsv(csvname=aids);
%getmycsv(csvname=colon);
%getmycsv(csvname=nickel);
%getmycsv(csvname=pbcseq);
%getmycsv(csvname=hypoxia);

/* filenames too long, so these ones are a bit messier, sorry!*/
FILENAME retino temp;
PROC HTTP
	URL="https://raw.githubusercontent.com/tslumley/survival-workshop/master/retinopathy.csv"
	METHOD="GET"
	OUT=retino;
RUN;

PROC IMPORT
	FILE=retino
	OUT=WORK.retino replace
	DBMS=csv;
RUN;

FILENAME fake1 temp;
PROC HTTP
	URL="https://raw.githubusercontent.com/tslumley/survival-workshop/master/fakelogrank1.csv"
	METHOD="GET"
	OUT=fake1;
RUN;

PROC IMPORT
	FILE=fake1
	OUT=WORK.fake1 replace
	DBMS=csv;
RUN;

FILENAME fake2 temp;
PROC HTTP
	URL="https://raw.githubusercontent.com/tslumley/survival-workshop/master/fakelogrank2.csv"
	METHOD="GET"
	OUT=fake2;
RUN;

PROC IMPORT
	FILE=fake2
	OUT=WORK.fake2 replace
	DBMS=csv;
RUN;

* Subset colon data to just those that have etype = 2;

DATA colon;
	SET colon (where=(etype=2));
RUN;

* Make two subsets of pbc data, one with trt = NA and one with trt ne NA;

DATA pbc_trt_na;
	SET pbc (where=(cmiss(trt)));
RUN;

DATA pbc_trt_notna;
	SET pbc;
	IF cmiss(trt) then delete;
RUN;
