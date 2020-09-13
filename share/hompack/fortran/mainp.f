C
C MAIN ROUTINE TO TEST POLSYS
C
C THIS ROUTINE REQUIRES ONE INPUT FILE, READ AS UNIT FOR007.
C
C A SAMPLE INPUT FILE AND ASSOCIATED OUTPUT ARE GIVEN
C IN THE COMMENTS THAT FOLLOW.  THIS SAMPLE PROBLEM IS
C CITED IN THE HOMPACK REPORT.
C
C***** SAMPLE INPUT DATA:
C TWO QUADRICS, NO SOLUTIONS AT INFINITY, TWO REAL SOLUTIONS.
C 00001       IFLGHM
C 00001       IFLGSC
C     4       ITOTDG
C                 1.D-04    EPSBIG
C                 1.D-14    EPSSML
C                 1.D-00    SSPAR(5)
C    10       NUMRR
C     2       N
C 00006                     NUMTRM(1)
C 00002                     DEG(1,1,1)
C 00000                     DEG(1,2,1)
C            -.00098D 00
C 00000                     DEG(1,1,2)
C 00002                     DEG(1,2,2)
C            978000.D 00
C 00001                     DEG(1,1,3)
C 00001                     DEG(1,2,3)
C               -9.8D 00
C 00001                     DEG(1,1,4)
C 00000                     DEG(1,2,4)
C             -235.0D 00
C 00000                     DEG(1,1,5)
C 00001                     DEG(1,2,5)
C            88900.0D 00
C 00000                     DEG(1,1,6)
C 00000                     DEG(1,2,6)
C             -1.000D 00
C 00006                     NUMTRM(2)
C 00002                     DEG(2,1,1)
C 00000                     DEG(2,2,1)
C             -.0100D 00
C 00000                     DEG(2,1,2)
C 00002                     DEG(2,2,2)
C             -.9840D 00
C 00001                     DEG(2,1,3)
C 00001                     DEG(2,2,3)
C             -29.70D 00
C 00001                     DEG(2,1,4)
C 00000                     DEG(2,2,4)
C             .00987D 00
C 00000                     DEG(2,1,5)
C 00001                     DEG(2,2,5)
C             -.1240D 00
C 00000                     DEG(2,1,6)
C 00000                     DEG(2,2,6)
C             -.2500D 00
C***** END OF SAMPLE INPUT DATA.
C
C***** ASSOCIATED SAMPLE OUTPUT:
C
C
C  POLYS TEST ROUTINE 5/20/85
C
C
C TWO QUADRICS PBHP0403, NO SOLUTIONS AT INFINITY    .........
C
C IF IFLGHM=1,HOMOGENEOUS;IF IFLGHM=2,INHOMOGENEOUS;IFLGHM= 1
C
C IF IFLGSC=1,SCLGEN USED; IF IFLGSC=2, NO SCALING; IFLGSC= 1
C
C ITOTDG=    4
C
C EPSBIG,EPSSML = 0.100000000000000D-03 0.100000000000000D-13
C NUMBER OF EQUATIONS =    2
C
C
C  NUMBER OF RECALLS WHEN IFLAG=3:     40
C
C
C
C  ****** COEFFICIENT TABLEAU ******
C
C
C  NUMT( 1)=    6
C  KDEG( 1, 1, 1)=    2
C  KDEG( 1, 2, 1)=    0
C  COEF( 1, 1)=-0.980000000000000D-03
C  KDEG( 1, 1, 2)=    0
C  KDEG( 1, 2, 2)=    2
C  COEF( 1, 2)= 0.978000000000000D+06
C  KDEG( 1, 1, 3)=    1
C  KDEG( 1, 2, 3)=    1
C  COEF( 1, 3)=-0.980000000000000D+01
C  KDEG( 1, 1, 4)=    1
C  KDEG( 1, 2, 4)=    0
C  COEF( 1, 4)=-0.235000000000000D+03
C  KDEG( 1, 1, 5)=    0
C  KDEG( 1, 2, 5)=    1
C  COEF( 1, 5)= 0.889000000000000D+05
C  KDEG( 1, 1, 6)=    0
C  KDEG( 1, 2, 6)=    0
C  COEF( 1, 6)=-0.100000000000000D+01
C
C
C  NUMT( 2)=    6
C  KDEG( 2, 1, 1)=    2
C  KDEG( 2, 2, 1)=    0
C  COEF( 2, 1)=-0.100000000000000D-01
C  KDEG( 2, 1, 2)=    0
C  KDEG( 2, 2, 2)=    2
C  COEF( 2, 2)=-0.984000000000000D+00
C  KDEG( 2, 1, 3)=    1
C  KDEG( 2, 2, 3)=    1
C  COEF( 2, 3)=-0.297000000000000D+02
C  KDEG( 2, 1, 4)=    1
C  KDEG( 2, 2, 4)=    0
C  COEF( 2, 4)= 0.987000000000000D-02
C  KDEG( 2, 1, 5)=    0
C  KDEG( 2, 2, 5)=    1
C  COEF( 2, 5)=-0.124000000000000D+00
C  KDEG( 2, 1, 6)=    0
C  KDEG( 2, 2, 6)=    0
C  COEF( 2, 6)=-0.250000000000000D+00
C
C
C
C
C  PATH NUMBER =    1
C
C  FINAL VALUES FOR PATH
C
C  ARCLEN = 0.100553311312353D+02
C  NFE =   53
C  IFLG2 =    1
C  T = 0.100000000000000D+01
C  X = 0.234233851959126D+04 0.791152831437911D-11
C  X =-0.788344824094138D+00-0.268347762088076D-14
C  X =-0.949359459408658D-02-0.106447550900261D-02
C  X =
C
C
C  PATH NUMBER =    2
C
C  FINAL VALUES FOR PATH
C
C  ARCLEN = 0.172112868960496D+01
C  NFE =   37
C  IFLG2 =    1
C  T = 0.100000000000000D+01
C  X = 0.161478579234367D-01 0.168496955498881D+01
C  X = 0.267994739614462D-03 0.442802993973661D-02
C  X =-0.381948972942403D+00 0.372068943457283D+00
C  X =
C
C
C  PATH NUMBER =    3
C
C  FINAL VALUES FOR PATH
C
C  ARCLEN = 0.202329539135269D+01
C  NFE =   35
C  IFLG2 =    1
C  T = 0.100000000000000D+01
C  X = 0.161478579234362D-01-0.168496955498881D+01
C  X = 0.267994739614461D-03-0.442802993973661D-02
C  X =-0.329370493847660D+00 0.556619775523013D+00
C  X =
C
C
C  PATH NUMBER =    4
C
C  FINAL VALUES FOR PATH
C
C  ARCLEN = 0.416327291917901D+01
C  NFE =   46
C  IFLG2 =    1
C  T = 0.100000000000000D+01
C  X = 0.908921229615394D-01-0.111985846294633D-14
C  X =-0.911497098197500D-01 0.117962440099502D-17
C  X =-0.573673395727962D-01 0.136243663709219D+00
C  X =
C
C
C  TOTAL NFE OVER ALL PATHS =        171
C
C***** END OF ASSOCIATED SAMPLE OUTPUT.
C
C *************************************************************
C
C  PROGRAM DESCRIPTION:  1. READS IN DATA.
C                        2. GENERATES POLSYS INPUT.
C                        3. CALLS POLSYS.
C                        4. WRITES POLSYS OUTPUT.
C
C DIMENSIONS SHOULD BE SET AS FOLLOWS:
C
C     DIMENSION NUMT(NN),COEF(NN,MMAXT),KDEG(NN,NN+1,MMAXT)
C     DIMENSION IFLG2(TTOTDG)
C     DIMENSION LAMBDA(TTOTDG),ROOTS(2,NN+1,TTOTDG),ARCLEN(TTOTDG),
C    + NFE(TTOTDG)
C     DIMENSION WK(LENWK),IWK(LENIWK)
C WHERE:
C    N   IS THE NUMBER OF EQUATIONS.  NN .GE. N.
C    MAXT  IS THE MAXIMUM NUMBER OF TERMS IN ANY ONE EQUATION.
C       MMAXT  .GE.  MAXT.
C    TOTDG  IS THE TOTAL DEGREE OF THE SYSTEM.  TTOTDG .GE. TOTDG.
C    LENWK  IS THE DIMENSION OF THE WORKSPACE  WK .  LENWK  MUST
C       BE GREATER THAN OR EQUAL TO
C       21 + 61*N + 10*N**2 + 7*N*MMAXT + 4*N**2*MMAXT.
C    LENIWK  IS THE DIMENSION OF THE WORKSPACE  IWK .  LENIWK  MUST BE
C       GREATER THAN OR EQUAL TO  43 + 7*N + N*(N+1)*MMAXT.
C
C THIS TEST CODE HAS DIMENSIONS SET AS FOLLOWS:
C
C NN=10, MMAXT=30, TTOTDG=999
C LENWK = 21 + 610 + 1000 + 2100 + 12000 = 15731
C LENIWK = 43 + 70 + 3300 = 3413
C
      PROGRAM MAINP
      INTEGER IFLG1,IFLG2,IFLGHM,IFLGSC,ITEST,ITOTIT,IWK,J,K,KDEG,
     + L,LENIWK,LENWK,M,MMAXT,N,NFE,NN,NP1,NT,NUMRR,NUMT,TTOTDG
      DOUBLE PRECISION ARCLEN,COEF,EPSBIG,EPSSML,LAMBDA,ROOTS,
     + SSPAR,WK
      CHARACTER*72 TITLE
C
      DIMENSION ARCLEN(999),COEF(10,30),IFLG2(999),IWK(3413),
     + KDEG(10,11,30),LAMBDA(999),NFE(999),NUMT(10),ROOTS(2,11,999),
     + SSPAR(8),WK(15731)
C
      NN=10
      MMAXT=30
      TTOTDG=999
      LENWK=15731
      LENIWK=3413
C
C
      OPEN (UNIT=7,FILE='innhp.dat',STATUS='old')
      OPEN (UNIT=6,FILE='OUTHP.DAT',STATUS='new')
C
          SSPAR(1)=.0
          SSPAR(2)=.0
          SSPAR(3)=.0
          SSPAR(4)=.0
          SSPAR(6)=.0
          SSPAR(7)=.0
          SSPAR(8)=.0
C
 1000 FORMAT(I5)
 2000 FORMAT(D22.15)
C
      WRITE(6,10)
  10  FORMAT( '  POLSYS TEST ROUTINE 8/12/85',//)
C
      READ(7,*) TITLE
      WRITE(6,21) TITLE
 21   FORMAT(' ',A72)
C
      READ(7,1000) IFLGHM
      READ(7,1000) IFLGSC
      READ(7,1000) TTOTDG
C
      READ(7,2000) EPSBIG
      READ(7,2000) EPSSML
      READ(7,2000) SSPAR(5)
      READ(7,1000) NUMRR
      READ(7,1000) N
C
      WRITE(6,100) IFLGHM
 100  FORMAT(/
     +' IF IFLGHM=1,HOMOGENEOUS;IF IFLGHM=0,INHOMOGENEOUS;IFLGHM=',I2)
      WRITE(6,102) IFLGSC
 102  FORMAT(/
     +' IF IFLGSC=1,SCLGNP USED; IF IFLGSC=0, NO SCALING; IFLGSC=',I2)
      WRITE(6,104) TTOTDG
 104  FORMAT(/,' TTOTDG=',I5)
C
C
      WRITE(6,106) EPSBIG,EPSSML,SSPAR(5),N
 106  FORMAT(/,' EPSBIG,EPSSML =',2D22.15,
     +       //,' SSPAR(5) =',D22.15,
     +       //,' NUMBER OF EQUATIONS =',I5)
      WRITE(6,108) NUMRR
 108  FORMAT(/,' NUMBER OF RECALLS WHEN IFLAG=3:  ',I5)
C
      NP1=N+1
C
C NOTE THAT THE DEGREES OF VARIABLES IN EACH TERM OF EACH EQUATION
C ARE DEFINED BY THE FOLLOWING INDEXING SCHEME:
C
C     KDEG(J,  L,  K)
C
C          ^   ^   ^
C
C          E   V   T
C          Q   A   E
C          U   R   R
C          A   I   M
C          T   A
C          I   B
C          O   L
C          N   E
C
C
      WRITE(6,200)
 200  FORMAT(//,'  ****** COEFFICIENT TABLEAU ******')
C
      DO 202 J=1,N
C
         WRITE(6,205)
 205     FORMAT(/)
C
         READ(7,1000) NUMT(J)
         WRITE(6,210) J,NUMT(J)
 210     FORMAT('  NUMT(',I2,')=',I5)
C
         NT=NUMT(J)
C
         DO 215 K=1,NT
C
             DO 218 L=1,N
                READ(7,1000) KDEG(J,L,K)
                WRITE(6,220) J,L,K,KDEG(J,L,K)
 220            FORMAT('  KDEG(',I2,',',I2,',',I2,')=',I5)
C
 218         CONTINUE
C
                READ(7,2000) COEF(J,K)
                WRITE(6,230) J,K,COEF(J,K)
 230            FORMAT('  COEF(',I2,',',I2,')=',D22.15)
C
 215     CONTINUE
C
 202  CONTINUE
C
         WRITE(6,205)
         WRITE(6,205)
C
      IFLG1=10*IFLGHM+IFLGSC
C
      DO 235 M=1,TTOTDG
          IFLG2(M)=-2
 235  CONTINUE
C
      CALL POLSYS(N,NUMT,COEF,KDEG,IFLG1,IFLG2,
     + EPSBIG,EPSSML,SSPAR,
     + NUMRR,NN,MMAXT,TTOTDG,LENWK,LENIWK,
     + LAMBDA,ROOTS,ARCLEN,NFE,WK,IWK)
      WRITE(6,240) IFLG1
 240  FORMAT(/,'  IFLG1=',I5,/)
C
      ITOTIT=0
      DO 250 M=1,TTOTDG
C
         ITOTIT=ITOTIT+NFE(M)
C
         WRITE(6,260) M
 260     FORMAT('  PATH NUMBER =',I5)
         WRITE(6,270)
 270     FORMAT(/'  FINAL VALUES FOR PATH'/)
C
         WRITE(6,280) ARCLEN(M)
 280     FORMAT('  ARCLEN =',D22.15)
         WRITE(6,290) NFE(M)
 290     FORMAT('  NFE =',I5)
         WRITE(6,300) IFLG2(M)
 300     FORMAT('  IFLG2 =',I5)
C
C*******************************
C
C   DESIGNATE SOLUTIONS "REAL" OR "COMPLEX"
C
         ITEST=0
         DO 310 J=1,N
            IF(ABS(ROOTS(2,J,M)).GE.1.E-4) ITEST=1
 310     CONTINUE
         IF( ITEST.EQ.1) THEN
             WRITE(6,779)
 779         FORMAT(' COMPLEX SOLUTION  ')
         ELSE
             WRITE(6,780)
 780         FORMAT(' REAL SOLUTION  ')
         END IF
C
C*******************************
C
C
C   DESIGNATE SOLUTION "FINITE" OR "INFINITE"
C
      IF( ABS(ROOTS(1,NP1,M))+ABS(ROOTS(2,NP1,M)) .LT. 1.E-6) THEN
          WRITE(6,781)
 781      FORMAT(' INFINITE SOLUTION  ')
        ELSE
          WRITE(6,782)
 782      FORMAT('   FINITE SOLUTION  ')
      END IF
C
C*******************************
C
         WRITE(6,320) LAMBDA(M),(ROOTS(1,J,M),ROOTS(2,J,M),J=1,N)
 320     FORMAT('  LAMBDA =',D22.15,/,10(' X    =',2D22.15,/))
         WRITE(6,330) ROOTS(1,NP1,M),ROOTS(2,NP1,M)
 330     FORMAT(/,' XNP1 =',2D22.15,/)
C
         WRITE(6,205)
C
 250  CONTINUE
C
         WRITE(6,400) ITOTIT
 400     FORMAT('  TOTAL NFE OVER ALL PATHS = ',I10)
C
C
      STOP
      END
