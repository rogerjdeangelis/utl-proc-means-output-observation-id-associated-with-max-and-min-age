Proc Means Output observation id associated with max and min

Simpler and better solution by Statgeek

github updated

Statgeek solution
https://gist.github.com/statgeek/25c614fafe1316a2da1fab830036bb5c

data have;
  input sex$ state$ age;
Datalines;
F NE 12
F CA 25
F RI 19
M AL 15
M VT 28
M NY 22
M MA 23
;;;;
run;

proc summary data=have nway;
by sex;
var age;
id state;
output out=want(drop=_: state) max= maxid=minState min= minid=maxState / autoname;
run;quit;


NOTE: There were 7 observations read from the data set WORK.HAVE.
NOTE: The data set WORK.WANT has 2 observations and 6 variables.
NOTE: PROCEDURE SUMMARY used (Total process time):
      real time           0.01 seconds
      cpu time            0.00 seconds


Up to 40 obs from WANT total obs=2

Obs    SEX    STATE    AGE_MAX    STATE2    AGE_MIN    STATE3

 1      F      RI         25        CA         12        NE
 2      M      VT         28        VT         15        AL



I applied data_null_'s simplification
data _null_; <datanull@GMAIL.COM>
https://listserv.uga.edu/cgi-bin/wa?A2=SAS-L;ee765358.1901a

INPUT
=====

data have;
  input sex$ state$ age;
Datalines;
F NE 12
F CA 25
F RI 19
M AL 15
M VT 28
M NY 22
M MA 23
;;;;
run;
                        | RULES
                        | ======
 WORK.HAVE total obs=7  |
                        |
  SEX    STATE    AGE   |   maxAge maxState  minAge minState
                        |
   F      NE       12   |     25    CA        12      NE
   F      CA       25   |
   F      RI       19   |
                        |
   M      AL       15   |
   M      VT       28   |
   M      NY       22   |     28    VT        15      AL
   M      MA       23   |


EXAMPLE OUTPUT
--------------

 WORK.WANT total obs=2

   SEX    MAXVAL  MAXSTATE    MINVAL   MINSTATE

    F       25       CA        12         NE
    M       28       VT        15         AL


PROCESS
=======

proc means data=have  nway noprint ;
  by sex;
  var age;
  output out=want(drop=_:)
         idgroup(max(age)          /* row with the maximum value   */
            out[1]                 /* 1 maximum value              */
            (age state)=maxVal maxState
         )
         idgroup(min(age)
           out[1]
           (age state)=minVal minState
        );
run;quit;

OUTPUT
======
 see above


