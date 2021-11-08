# NRL HWM14 Horizontal Wind Model

[![Actions Status](https://github.com/gemini3d/hwm14/workflows/ci/badge.svg)](https://github.com/gemini3d/hwm14/actions)


Build "build/libhwm14.*" by:

```sh
cmake -B build
cmake --build build

# optional
ctest --test-dir build
```

## hwm14 interface

```fortran
!!! Input arguments:
!!!        iyd - year and day as yyddd
!!!        sec - ut(sec)
!!!        alt - altitude(km)
!!!        glat - geodetic latitude(deg)
!!!        glon - geodetic longitude(deg)
!!!        stl - not used
!!!        f107a - not used
!!!        f107 - not used
!!!        ap - two element array with
!!!             ap(1) = not used
!!!             ap(2) = current 3hr ap index
!!!
!!! Output argument:
!!!        w(1) = meridional wind (m/sec + northward)
!!!        w(2) = zonal wind (m/sec + eastward)
```

```fortran
subroutine hwm14(iyd,sec,alt,glat,glon,stl,f107a,f107,ap,w)
integer(real32),intent(in)   :: iyd
real(real32),intent(in)      :: sec,alt,glat,glon,stl,f107a,f107
real(real32),intent(in)      :: ap(2)
real(real32),intent(out)     :: w(2)
real(real32)                 :: dw(2)
```

```fortran
subroutine dwm07(IYD,SEC,ALT,GLAT,GLON,AP,DW)
INTEGER,intent(in)      :: IYD
REAL(4),intent(in)      :: SEC,ALT,GLAT,GLON
REAL(4),intent(in)      :: AP(2)
REAL(4),intent(out)     :: DW(2)
```
