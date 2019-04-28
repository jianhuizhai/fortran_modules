MODULE constants_module
    USE precision_module, only : dp
    IMPLICIT NONE
    PUBLIC

    real (dp), parameter :: c = 299792458.0_dp
! units m s-1

    real (dp), parameter :: e = 2.7182818284590452353602874713526624977_dp

    real (dp), parameter :: g = 9.812420_dp
! 9.780 356 m s-2 at sea level on the equator
! 9.812 420 m s-2 at sea level in london
! 9.832 079 m s-2 at sea level at the poles

    real (dp), parameter :: pi = 3.141592653589793238462643383279502884_dp, twopi = 2.0_dp*pi

END MODULE constants_module