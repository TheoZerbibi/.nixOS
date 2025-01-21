{nixpkgs, ...}: {
  home.packages = with nixpkgs.unstable; [
    clang-tools
    cmake
    gnumake
    libclang
    libgcc
    valgrind
    codespell
    conan
    cppcheck
    doxygen
    gtest
    lcov
    vcpkg-tool
    docker-compose
  ];
}