# utl-proc-means-output-observation-id-associated-with-max-and-min-age
Output observation id associated with max and min
    Proc Means Output observation id associated with max and min

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

