program test_hwm
!! https://map.nrl.navy.mil/map/pub/nrl/HWM/HWM14/HWM14_ess224-sup-0002-supinfo/README.txt
use hwm_interface, only : hwm_14, dwm_07

implicit none (type, external)

integer :: day = 150
real ::  &
 utsec = 12 * 3600, &
 alt_km = 400., &
 glat = -45.0, &
 glon = -85.0, &
 Ap = 80.0

real :: Wmeridional, Wzonal, Dw(2)

call hwm_14(day, utsec, alt_km, glat, glon, Ap, Wmeridional, Wzonal)

call dwm_07(day, utsec, alt_km, glat, glon, Ap, Dw)

print '(4a14)', "Wmeridional", "Wzonal", "Dw(1)", "Dw(2)"
print '(4f14.6)', Wmeridional, Wzonal, Dw

if (abs(Wmeridional - 51.259384) > 0.001) error stop "Wmeridional"
if (abs(Wzonal - (-100.946259)) > 0.001) error stop 'Wzonal'

if (abs(DW(1) - 44.557793) > 0.001) error stop 'Dw(1)'
if (abs(DW(2) - (-18.965160)) > 0.001) error stop 'Dw(2)'

print *, "OK: HWM14"

end program
