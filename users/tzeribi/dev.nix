{nixpkgs, ...}: {
  home.packages = with nixpkgs.unstable; [
    clang-tools
    cmake
    codespell
    conan
    cppcheck
    doxygen
    gtest
    lcov
    vcpkg-tool
  ];
}