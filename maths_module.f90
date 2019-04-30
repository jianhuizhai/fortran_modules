MODULE maths_module
    USE constants_module, ONLY : twopi
    USE ISO_FORTRAN_ENV
    IMPLICIT NONE
    PRIVATE

    PUBLIC :: init_random_seed, normaldist
    PUBLIC :: cross, tensorMultVector, vectorTMultVector
    
    CONTAINS

    SUBROUTINE init_random_seed()
        ! NOTE: this subroutine is replaced by "call random_init()" intrinsic of Fortran 2018
        INTEGER :: n, u,ios
        INTEGER, ALLOCATABLE :: seed(:),check(:)

        CALL random_seed(size=n)
        ALLOCATE(seed(n),check(n))
  
        open(newunit=u, file='/dev/urandom', access="stream", &
                form="unformatted", action="read", status="old", iostat=ios)
  
        if (ios==0) then
            read(u,iostat=ios) seed
            if (ios/=0) error stop 'failed to read random source generator'
            close(u)
    
            call random_seed(put=seed)
        else
            call random_seed()   ! gfortran and ifort compilers pick a fresh seed.
            call random_seed(get=check)
            call random_seed()
            call random_seed(get=seed)
            if (all(check==seed)) write(error_unit,*) 'WARNING: your compiler is not picking a unique seed'
        endif
    
        !print *,'seed: ',seed    ! for debug/test

    END SUBROUTINE init_random_seed

    FUNCTION normaldist(mean,std) RESULT(r)
    ! This function is used to calculate normal distribution of random number
        IMPLICIT NONE
        REAL(KIND=8),INTENT(IN) :: mean,std
        REAL(KIND=8) :: r
        REAL(KIND=8),DIMENSION(2) :: zeta

        CALL RANDOM_NUMBER (zeta)

        r= DSQRT(-2.0*LOG(zeta(1)))*COS(twopi*zeta(2))
        r = mean + std * r
    END FUNCTION normaldist

    PURE FUNCTION cross(a,b)
    ! THIS function is used to calculate cross product of two vectors
        REAL(8), DIMENSION(3) :: cross
        REAL(8), DIMENSION(3), INTENT(IN) :: a,b

        cross(1) = a(2)*b(3)-a(3)*b(2)
        cross(2) = a(3)*b(1)-a(1)*b(3)
        cross(3) = a(1)*b(2)-a(2)*b(1)

    END FUNCTION

    PURE FUNCTION tensorMultVector(a,b)
    ! This function return the ralue -------tensor multiply vector
    ! tensor a; vector b;
        REAL(8),DIMENSION(3,3),INTENT(IN) :: a
        REAL(8),DIMENSION(3),INTENT(IN) :: b
        REAL(8),DIMENSION(3) :: tensorMultVector

        tensorMultVector(1) = a(1,1)*b(1)+a(1,2)*b(2)+a(1,3)*b(3)
        tensorMultVector(2) = a(2,1)*b(1)+a(2,2)*b(2)+a(2,3)*b(3)
        tensorMultVector(3) = a(3,1)*b(1)+a(3,2)*b(2)+a(3,3)*b(3)

    END FUNCTION

    PURE FUNCTION vectorTMultVector(a,b)
    ! This function is used to get the results of transpose of a vector multiply vector
    ! = tranpose(a)*b
        REAL(8),DIMENSION(3,3) :: vectorTMultVector
        REAL(8),DIMENSION(3),INTENT(IN) :: a,b

        vectorTMultVector(1,1) = a(1)*b(1)
        vectorTMultVector(1,2) = a(1)*b(2)
        vectorTMultVector(1,3) = a(1)*b(3)
        vectorTMultVector(2,1) = a(2)*b(1)
        vectorTMultVector(2,2) = a(2)*b(2)
        vectorTMultVector(2,3) = a(2)*b(3)
        vectorTMultVector(3,1) = a(3)*b(1)
        vectorTMultVector(3,2) = a(3)*b(2)
        vectorTMultVector(3,3) = a(3)*b(3)

    END FUNCTION

END MODULE maths_module
