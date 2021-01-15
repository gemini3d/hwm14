# NRL HWM14 Horizontal Wind Model

This CMake script downloads NRL HWM14 source and builds "build/libhwm14" by:

```sh
cmake -B build
cmake --build build
```

optionally run self-tests:

```sh
cd build
ctest -V
```
