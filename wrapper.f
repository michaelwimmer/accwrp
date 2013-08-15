c Wrappers allowing to link MacOSX's Accelerate framework to
c gfortran compiled code.

c ------ IMPORTANT ------
c
c Has to be compiled with -fno-underscoring in order to work!
c
c ------ IMPORTANT ------

c Accelerate BLAS is cblas (http://www.netlib.org/blas/blast-forum/cblas.tgz);
c these wrappers call the cblas functions. Since cblas takes some
c arguments by value (instead of by reference/as a pointer as usual in
c fortran), the GNU Fortran extension %VAL(...) has to be used

      REAL FUNCTION SDOT_( N, SX, INCX, SY, INCY )
      INTEGER INCX, INCY, N
      REAL SX(*), SY(*)
      EXTERNAL CBLAS_SDOT
      REAL CBLAS_SDOT
      SDOT = CBLAS_SDOT( %VAL(N), SX, %VAL(INCX), SY, %VAL(INCY) )
      END FUNCTION

      REAL FUNCTION SDSDOT_( N, SB, SX, INCX, SY, INCY )
      REAL SB
      INTEGER INCX, INCY, N
      REAL SX(*), SY(*)
      EXTERNAL CBLAS_SDSDOT
      REAL CBLAS_SDSDOT
      SDSDOT_ = CBLAS_SDSDOT( %VAL(N), SB, SX, %VAL(INCX), SY,
     $                        %VAL(INCY) )
      END FUNCTION

      REAL FUNCTION SASUM_( N, SX, INCX )
      INTEGER INCX, N
      REAL SX(*)
      EXTERNAL CBLAS_SASUM
      REAL CBLAS_SASUM
      SASUM_ = CBLAS_SASUM( %VAL(N), SX, %VAL(INCX) )
      END FUNCTION

      REAL FUNCTION SNRM2_( N, SX, INCX )
      INTEGER INCX, N
      REAL SX(*)
      EXTERNAL CBLAS_SNRM2
      REAL CBLAS_SNRM2
      SNRM2_ = CBLAS_SNRM2( %VAL(N), SX, %VAL(INCX) )
      END FUNCTION

      REAL FUNCTION SCASUM_( N, CX, INCX )
      INTEGER INCX, N
      COMPLEX CX(*)
      EXTERNAL CBLAS_SCASUM
      REAL CBLAS_SCASUM
      SCASUM_ = CBLAS_SCASUM( %VAL(N), CX, %VAL(INCX) )
      END FUNCTION

      REAL FUNCTION SCNRM2_( N, CX, INCX )
      INTEGER INCX, N
      COMPLEX CX(*)
      EXTERNAL CBLAS_SCNRM2
      REAL CBLAS_SCNRM2
      SCNRM2_ = CBLAS_SCNRM2( %VAL(N), CX, %VAL(INCX) )
      END FUNCTION

      COMPLEX FUNCTION CDOTC_( N, CX, INCX, CY, INCY )
      INTEGER INCX, INCY, N
      COMPLEX CX(*), CY(*)
      COMPLEX RESULT
      EXTERNAL CBLAS_CDOTC_SUB
      CALL CBLAS_CDOTC_SUB( %VAL(N), CX, %VAL(INCX), CY, %VAL(INCY),
     $                      RESULT )
      CDOTC_ = RESULT
      END FUNCTION

      COMPLEX FUNCTION CDOTU_( N, CX, INCX, CY, INCY )
      INTEGER INCX, INCY, N
      COMPLEX CX(*), CY(*)
      COMPLEX RESULT
      EXTERNAL CBLAS_CDOTU_SUB
      CALL CBLAS_CDOTU_SUB( %VAL(N), CX, %VAL(INCX), CY, %VAL(INCY),
     $                      RESULT )
      CDOTU_ = RESULT
      END FUNCTION

      DOUBLE COMPLEX FUNCTION ZDOTC_( N, CX, INCX, CY, INCY )
      INTEGER INCX, INCY, N
      DOUBLE COMPLEX CX(*), CY(*)
      DOUBLE COMPLEX RESULT
      EXTERNAL CBLAS_ZDOTC_SUB
      CALL CBLAS_ZDOTC_SUB( %VAL(N), CX, %VAL(INCX), CY, %VAL(INCY),
     $                      RESULT )
      ZDOTC_ = RESULT
      END FUNCTION

      DOUBLE COMPLEX FUNCTION ZDOTU_( N, CX, INCX, CY, INCY )
      INTEGER INCX, INCY, N
      DOUBLE COMPLEX CX(*), CY(*)
      DOUBLE COMPLEX RESULT
      EXTERNAL CBLAS_ZDOTU_SUB
      CALL CBLAS_ZDOTU_SUB( %VAL(N), CX, %VAL(INCX), CY, %VAL(INCY),
     $                      RESULT )
      ZDOTU_ = RESULT
      END FUNCTION

c The LAPACK in the Accelerate framework is a CLAPACK
c (www.netlib.org/clapack) and has hence a different interface than the
c modern Fortran LAPACK libraries. These wrappers here help to link
c Fortran code to Accelerate.

c This wrapper files covers all Lapack functions that are in all
c versions before Lapack 3.2 (Lapack 3.2 adds CLANHF and SLANSF that
c would be problematic, but those do not exist in OSX <= 10.6, and are
c actually not used in scipy)

c This wrapper makes use of the fact that Accelerate contains (that's
c kind of undocumented, but apperantly always the case) both symbol
c names with and without underscore

      COMPLEX FUNCTION CLADIV_( X, Y )
      COMPLEX            X, Y
      COMPLEX            Z
      EXTERNAL           CLADIV
      CALL CLADIV(Z, X, Y)
      CLADIV_ = Z
      END FUNCTION

      DOUBLE COMPLEX FUNCTION ZLADIV_( X, Y )
      DOUBLE COMPLEX     X, Y
      DOUBLE COMPLEX     Z
      EXTERNAL           ZLADIV
      CALL ZLADIV(Z, X, Y)
      ZLADIV_ = Z
      END FUNCTION

      REAL FUNCTION CLANGB_( NORM, N, KL, KU, AB, LDAB, WORK)
      CHARACTER          NORM
      INTEGER            KL, KU, LDAB, N
      REAL               WORK( * )
      COMPLEX            AB( LDAB, * )
      EXTERNAL           CLANGB
      DOUBLE PRECISION   CLANGB
      CLANGB_ = REAL(CLANGB( NORM, N, KL, KU, AB, LDAB, WORK))
      END FUNCTION

      REAL FUNCTION CLANGE_( NORM, M, N, A, LDA, WORK)
      CHARACTER          NORM
      INTEGER            LDA, M, N
      REAL               WORK( * )
      COMPLEX            A( LDA, * )
      EXTERNAL           CLANGE
      DOUBLE PRECISION   CLANGE
      CLANGE_ = REAL(CLANGE( NORM, M, N, A, LDA, WORK))
      END FUNCTION

      REAL FUNCTION CLANGT_( NORM, N, DL, D, DU)
      CHARACTER          NORM
      INTEGER            N
      COMPLEX            D( * ), DL( * ), DU( * )
      EXTERNAL           CLANGT
      DOUBLE PRECISION   CLANGT
      CLANGT_ = REAL(CLANGT( NORM, N, DL, D, DU))
      END FUNCTION

      REAL FUNCTION CLANHB_( NORM, UPLO, N, K, AB, LDAB, WORK)
      CHARACTER          NORM, UPLO
      INTEGER            K, LDAB, N
      REAL               WORK( * )
      COMPLEX            AB( LDAB, * )
      EXTERNAL           CLANHB
      DOUBLE PRECISION   CLANHB
      CLANHB_ = REAL(CLANHB( NORM, UPLO, N, K, AB, LDAB, WORK))
      END FUNCTION

      REAL FUNCTION CLANHE_( NORM, UPLO, N, A, LDA, WORK)
      CHARACTER          NORM, UPLO
      INTEGER            LDA, N
      REAL               WORK( * )
      COMPLEX            A( LDA, * )
      EXTERNAL           CLANHE
      DOUBLE PRECISION   CLANHE
      CLANHE_ = REAL(CLANHE( NORM, UPLO, N, A, LDA, WORK))
      END FUNCTION

c only available from OSX 10.7 on
c
c      REAL FUNCTION CLANHF_( NORM, TRANSR, UPLO, N, A, WORK)
c      CHARACTER          NORM, TRANSR, UPLO
c      INTEGER            N
c      REAL               WORK( 0: * )
c      COMPLEX            A( 0: * )
c      EXTERNAL           CLANHF
c      DOUBLE PRECISION   CLANHF
c      CLANHF_ = REAL(CLANHF( NORM, TRANSR, UPLO, N, A, WORK))
c      END FUNCTION

      REAL FUNCTION CLANHP_( NORM, UPLO, N, AP, WORK)
      CHARACTER          NORM, UPLO
      INTEGER            N
      REAL               WORK( * )
      COMPLEX            AP( * )
      EXTERNAL           CLANHP
      DOUBLE PRECISION   CLANHP
      CLANHP_ = REAL(CLANHP( NORM, UPLO, N, AP, WORK))
      END FUNCTION

      REAL FUNCTION CLANHS_( NORM, N, A, LDA, WORK)
      CHARACTER          NORM
      INTEGER            LDA, N
      REAL               WORK( * )
      COMPLEX            A( LDA, * )
      EXTERNAL           CLANHS
      DOUBLE PRECISION   CLANHS
      CLANHS_ = REAL(CLANHS( NORM, N, A, LDA, WORK))
      END FUNCTION

      REAL FUNCTION CLANHT_( NORM, N, D, E)
      CHARACTER          NORM
      INTEGER            N
      REAL               D( * )
      COMPLEX            E( * )
      EXTERNAL           CLANHT
      DOUBLE PRECISION   CLANHT
      CLANHT_ = REAL(CLANHT( NORM, N, D, E))
      END FUNCTION

      REAL FUNCTION CLANSB_( NORM, UPLO, N, K, AB, LDAB, WORK)
      CHARACTER          NORM, UPLO
      INTEGER            K, LDAB, N
      REAL               WORK( * )
      COMPLEX            AB( LDAB, * )
      EXTERNAL           CLANSB
      DOUBLE PRECISION   CLANSB
      CLANSB_ = REAL(CLANSB( NORM, UPLO, N, K, AB, LDAB, WORK))
      END FUNCTION

      REAL FUNCTION CLANSP_( NORM, UPLO, N, AP, WORK)
      CHARACTER          NORM, UPLO
      INTEGER            N
      REAL               WORK( * )
      COMPLEX            AP( * )
      EXTERNAL           CLANSP
      DOUBLE PRECISION   CLANSP
      CLANSP_ = REAL(CLANSP( NORM, UPLO, N, AP, WORK))
      END FUNCTION

      REAL FUNCTION CLANSY_( NORM, UPLO, N, A, LDA, WORK)
      CHARACTER          NORM, UPLO
      INTEGER            LDA, N
      REAL               WORK( * )
      COMPLEX            A( LDA, * )
      EXTERNAL           CLANSY
      DOUBLE PRECISION   CLANSY
      CLANSY_ = REAL(CLANSY( NORM, UPLO, N, A, LDA, WORK))
      END FUNCTION

      REAL FUNCTION CLANTB_( NORM, UPLO, DIAG, N, K, AB, LDAB, WORK)
      CHARACTER          DIAG, NORM, UPLO
      INTEGER            K, LDAB, N
      REAL               WORK( * )
      COMPLEX            AB( LDAB, * )
      EXTERNAL           CLANTB
      DOUBLE PRECISION   CLANTB
      CLANTB_ = REAL(CLANTB( NORM, UPLO, DIAG, N, K, AB, LDAB, WORK))
      END FUNCTION

      REAL FUNCTION CLANTP_( NORM, UPLO, DIAG, N, AP, WORK)
      CHARACTER          DIAG, NORM, UPLO
      INTEGER            N
      REAL               WORK( * )
      COMPLEX            AP( * )
      EXTERNAL           CLANTP
      DOUBLE PRECISION   CLANTP
      CLANTP_ = REAL(CLANTP( NORM, UPLO, DIAG, N, AP, WORK))
      END FUNCTION

      REAL FUNCTION CLANTR_( NORM, UPLO, DIAG, M, N, A, LDA, WORK)
      CHARACTER          DIAG, NORM, UPLO
      INTEGER            LDA, M, N
      REAL               WORK( * )
      COMPLEX            A( LDA, * )
      EXTERNAL           CLANTR
      DOUBLE PRECISION   CLANTR
      CLANTR_ = REAL(CLANTR( NORM, UPLO, DIAG, M, N, A, LDA, WORK))
      END FUNCTION

      REAL FUNCTION SCSUM1_( N, CX, INCX)
      INTEGER            INCX, N
      COMPLEX            CX( * )
      EXTERNAL           SCSUM1
      DOUBLE PRECISION   SCSUM1
      SCSUM1_ = REAL(SCSUM1( N, CX, INCX))
      END FUNCTION

      REAL FUNCTION SLANGB_( NORM, N, KL, KU, AB, LDAB, WORK)
      CHARACTER          NORM
      INTEGER            KL, KU, LDAB, N
      REAL               AB( LDAB, * ), WORK( * )
      EXTERNAL           SLANGB
      DOUBLE PRECISION   SLANGB
      SLANGB_ = REAL(SLANGB( NORM, N, KL, KU, AB, LDAB, WORK))
      END FUNCTION

      REAL FUNCTION SLANGE_( NORM, M, N, A, LDA, WORK)
      CHARACTER          NORM
      INTEGER            LDA, M, N
      REAL               A( LDA, * ), WORK( * )
      EXTERNAL           SLANGE
      DOUBLE PRECISION   SLANGE
      SLANGE_ = REAL(SLANGE( NORM, M, N, A, LDA, WORK))
      END FUNCTION

      REAL FUNCTION SLANGT_( NORM, N, DL, D, DU)
      CHARACTER          NORM
      INTEGER            N
      REAL               D( * ), DL( * ), DU( * )
      EXTERNAL           SLANGT
      DOUBLE PRECISION   SLANGT
      SLANGT_ = REAL(SLANGT( NORM, N, DL, D, DU))
      END FUNCTION

      REAL FUNCTION SLANHS_( NORM, N, A, LDA, WORK)
      CHARACTER          NORM
      INTEGER            LDA, N
      REAL               A( LDA, * ), WORK( * )
      EXTERNAL           SLANHS
      DOUBLE PRECISION   SLANHS
      SLANHS_ = REAL(SLANHS( NORM, N, A, LDA, WORK))
      END FUNCTION

      REAL FUNCTION SLANSB_( NORM, UPLO, N, K, AB, LDAB, WORK)
      CHARACTER          NORM, UPLO
      INTEGER            K, LDAB, N
      REAL               AB( LDAB, * ), WORK( * )
      EXTERNAL           SLANSB
      DOUBLE PRECISION   SLANSB
      SLANSB_ = REAL(SLANSB( NORM, UPLO, N, K, AB, LDAB, WORK))
      END FUNCTION

c only availble from OSX 10.7 on
c      REAL FUNCTION SLANSF_( NORM, TRANSR, UPLO, N, A, WORK)
c      CHARACTER          NORM, TRANSR, UPLO
c      INTEGER            N
c      REAL               A( 0: * ), WORK( 0: * )
c      EXTERNAL           SLANSF
c      DOUBLE PRECISION   SLANSF
c      SLANSF_ = REAL(SLANSF( NORM, TRANSR, UPLO, N, A, WORK))
c      END FUNCTION

      REAL FUNCTION SLANSP_( NORM, UPLO, N, AP, WORK)
      CHARACTER          NORM, UPLO
      INTEGER            N
      REAL               AP( * ), WORK( * )
      EXTERNAL           SLANSP
      DOUBLE PRECISION   SLANSP
      SLANSP_ = REAL(SLANSP( NORM, UPLO, N, AP, WORK))
      END FUNCTION

      REAL FUNCTION SLANST_( NORM, N, D, E)
      CHARACTER          NORM
      INTEGER            N
      REAL               D( * ), E( * )
      EXTERNAL           SLANST
      DOUBLE PRECISION   SLANST
      SLANST_ = REAL(SLANST( NORM, N, D, E))
      END FUNCTION

      REAL FUNCTION SLANSY_( NORM, UPLO, N, A, LDA, WORK)
      CHARACTER          NORM, UPLO
      INTEGER            LDA, N
      REAL               A( LDA, * ), WORK( * )
      EXTERNAL           SLANSY
      DOUBLE PRECISION   SLANSY
      SLANSY_ = REAL(SLANSY( NORM, UPLO, N, A, LDA, WORK))
      END FUNCTION

      REAL FUNCTION SLANTB_( NORM, UPLO, DIAG, N, K, AB, LDAB, WORK)
      CHARACTER          DIAG, NORM, UPLO
      INTEGER            K, LDAB, N
      REAL               AB( LDAB, * ), WORK( * )
      EXTERNAL           SLANTB
      DOUBLE PRECISION   SLANTB
      SLANTB_ = REAL(SLANTB( NORM, UPLO, DIAG, N, K, AB, LDAB, WORK))
      END FUNCTION

      REAL FUNCTION SLANTP_( NORM, UPLO, DIAG, N, AP, WORK)
      CHARACTER          DIAG, NORM, UPLO
      INTEGER            N
      REAL               AP( * ), WORK( * )
      EXTERNAL           SLANTP
      DOUBLE PRECISION   SLANTP
      SLANTP_ = REAL(SLANTP( NORM, UPLO, DIAG, N, AP, WORK))
      END FUNCTION

      REAL FUNCTION SLANTR_( NORM, UPLO, DIAG, M, N, A, LDA, WORK)
      CHARACTER          DIAG, NORM, UPLO
      INTEGER            LDA, M, N
      REAL               A( LDA, * ), WORK( * )
      EXTERNAL           SLANTR
      DOUBLE PRECISION   SLANTR
      SLANTR_ = REAL(SLANTR( NORM, UPLO, DIAG, M, N, A, LDA, WORK))
      END FUNCTION

      REAL FUNCTION SLAPY2_( X, Y)
      REAL               X, Y
      EXTERNAL           SLAPY2
      DOUBLE PRECISION   SLAPY2
      SLAPY2_ = REAL(SLAPY2( X, Y))
      END FUNCTION

      REAL FUNCTION SLAPY3_( X, Y, Z)
      REAL               X, Y, Z
      EXTERNAL           SLAPY3
      DOUBLE PRECISION   SLAPY3
      SLAPY3_ = REAL(SLAPY3( X, Y, Z))
      END FUNCTION

      REAL FUNCTION SLAMCH_( CMACH)
      CHARACTER          CMACH
      EXTERNAL           SLAMCH
      DOUBLE PRECISION   SLAMCH
      SLAMCH_ = REAL(SLAMCH( CMACH))
      END FUNCTION
