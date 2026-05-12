# hotpants — High Order Transform of Psf ANd Template Subtraction

Astronomical image subtraction tool (v5.1.11) for difference imaging, built in C.

## Build & Install

### Prerequisites

- **gcc** or compatible C compiler
- **cfitsio** — FITS I/O library

Install cfitsio:

```sh
# macOS
brew install cfitsio

# Linux (Debian/Ubuntu)
sudo apt-get install libcfitsio-dev
```

### Build from source

```sh
make
```

This produces three binaries: `hotpants`, `extractkern`, `maskim`.

### Install

```sh
make install PREFIX=/usr/local
```

Or install via Homebrew:

```sh
brew install astro-lee/tap/hotpants
```

## CI

GitHub Actions builds on `linux-x86_64` and `macos-arm64` via matrix. Releases are triggered by pushing a `v*` tag (e.g. `v5.1.11`), which also updates the Homebrew tap formula automatically.

## Key files

- `Makefile` — primary build (Linux); auto-detects cfitsio via pkg-config
- `Makefile.macosx` — macOS build
- `.github/workflows/build-and-release.yml` — CI/CD pipeline
- `main.c` — program entry point and argument parsing
- `alard.c` — core Alard/Lupton image subtraction algorithm
- `functions.c` — utility and kernel-fitting functions
- `vargs.c` — command-line argument handling
- `extractkern.c` — kernel extraction utility
- `maskim.c` — image masking utility
- `defaults.h` — default parameter values
- `globals.h` — global variable declarations
- `functions.h` — function prototypes

## Homebrew

This project is distributed via [Astro-Lee/homebrew-tap](https://github.com/Astro-Lee/homebrew-tap):

```
brew tap astro-lee/tap
brew install hotpants
```
