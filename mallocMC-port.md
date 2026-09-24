# mallocMC alpaka3 port

## Plan

- [x] Inspect `mallocMC` for legacy alpaka integration points and identify likely alpaka3 replacements.
- [x] Update dependency fetching and CMake integration to pull `alpaka-group/alpaka3` and match alpaka3's build requirements.
- [x] Replace legacy accelerator/tag/device/queue usage in library headers with alpaka3 APIs.
- [x] Replace legacy accelerator/tag/device/queue usage in tests and examples with alpaka3 APIs.
- [x] Update warp-size handling to use alpaka3 `onAcc::Acc` compile-time information where required.
- [x] Build and run the CPU test suite.
- [x] Build and run the CPU examples across the enabled host backends.
- [x] Configure and compile the project with `nvcc` without running GPU tests.
- [x] Do a final regression pass and record remaining risks.

## Notes

- Keep changes local to `mallocMC`.
- Prefer API adapters or small helper traits over wide rewrites where possible.
- The temporary `alpaka3_compat.hpp` and `alpaka3_host.hpp` helpers were removed again; the port now uses alpaka3 APIs directly.
- CPU tests and CPU examples pass with direct alpaka3 usage.
- `nvcc` builds now complete for both the full project and the standalone examples build without running GPU tests.
- The native-CUDA convenience wrapper in `mallocMC.cuh` now defaults to the `OldMalloc` path for raw CUDA kernels. This keeps the wrapper buildable with alpaka3/NVCC without trying to emulate a full alpaka accelerator inside a native CUDA kernel.
- Remaining risks: GPU runtime execution was not verified; the optional Gallatin dependency was unavailable; HIP and SYCL were not tested.

## Latest validation

Tested against alpaka3 `dev` at commit `0c4eaacf4235998930a6de5d1e2f4385dd6f3295`.

CUDA-enabled configure (using alpaka3's current `alpaka_DEP_CUDA` option, without legacy backend flags):

```sh
cmake -S . -B /tmp/mallocMC-final-build \
  -DmallocMC_BUILD_TESTING=ON \
  -DmallocMC_BUILD_EXAMPLES=ON \
  -DmallocMC_USE_alpaka=ON_ALWAYS_FETCH \
  -DmallocMC_USE_Catch2=ON_ALWAYS_FETCH \
  -Dalpaka_DEP_CUDA=ON \
  -Dalpaka_CUDA_NvidiaGpu=ON \
  -Dalpaka_EXEC_CpuSerial=ON \
  -DCMAKE_CUDA_HOST_COMPILER=/usr/bin/g++-15 \
  -DCMAKE_CUDA_ARCHITECTURES=75
cmake --build /tmp/mallocMC-final-build --parallel 4
ctest --test-dir /tmp/mallocMC-final-build -E mallocMCExampleNativeCuda --output-on-failure
```

All five executables compiled; the compile database contains 11 NVCC commands including CUDA-backend tests/examples. Four CTest targets passed. The native-CUDA runtime test was excluded; passing tests do not establish GPU runtime correctness.
