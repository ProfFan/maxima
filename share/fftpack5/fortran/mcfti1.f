CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
C   FFTPACK 5.0 
C
C   Authors:  Paul N. Swarztrauber and Richard A. Valent
C
C   $Id$
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

      SUBROUTINE MCFTI1 (N,WA,FNF,FAC)
      REAL            WA(*),FAC(*) 
C
      CALL FACTOR (N,NF,FAC)
      FNF = NF
      IW = 1
      L1 = 1
      DO 110 K1=1,NF
         IP = FAC(K1)
         L2 = L1*IP
         IDO = N/L2
         CALL TABLES (IDO,IP,WA(IW))
         IW = IW+(IP-1)*(IDO+IDO)
         L1 = L2
  110 CONTINUE
      RETURN
      END
