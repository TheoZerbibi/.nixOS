{nixpkgs, ...}: {
  home.packages = with nixpkgs.unstable; [
    clang-tools
    cmake
    gnumake
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