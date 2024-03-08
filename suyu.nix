{ pkgs, nx_tzdb, ... }:
let
  lib = pkgs.lib;
in
pkgs.stdenv.mkDerivation {
  pname = "suyu";
  version = "unstable-2024-03-05";
  src = pkgs.fetchFromGitLab {
    owner = "suyu-emu";
    repo = "suyu";
    rev = "5db58434e5b27354af7887fd05eea353f12e7d3d";
    hash = "sha256-gvcvdI3jdMKOL8JXm3gHC9sCOHvUbN3ROv/CuQpE9/U=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    glslang
    kdePackages.wrapQtAppsHook
    kdePackages.qttools
  ];

  buildInputs = with pkgs; [
    # vulkan-headers must come first, so the older propagated versions
    # don't get picked up by accident
    vulkan-headers
    boost
    catch2_3
    cpp-jwt
    cubeb
    discord-rpc
    # intentionally omitted: dynarmic - prefer vendored version for compatibility
    enet
    # vendored ffmpeg deps
    autoconf
    yasm
    libva  # for accelerated video decode on non-nvidia
    nv-codec-headers-12  # for accelerated video decode on nvidia
    # end vendored ffmpeg deps
    fmt
    # intentionally omitted: gamemode - loaded dynamically at runtime
    # intentionally omitted: httplib - upstream requires an older version than what we have
    libopus
    libusb1
    # intentionally omitted: LLVM - heavy, only used for stack traces in the debugger
    lz4
    nlohmann_json
    kdePackages.qtbase
    kdePackages.qtmultimedia
    kdePackages.qtwayland
    kdePackages.qtwebengine
    # intentionally omitted: renderdoc - heavy, developer only
    SDL2
    # not packaged in nixpkgs: simpleini
    # intentionally omitted: stb - header only libraries, vendor uses git snapshot
    # not packaged in nixpkgs: vulkan-memory-allocator
    # intentionally omitted: xbyak - prefer vendored version for compatibility
    zlib
    zstd
  ];

  dontFixCmake = true;

  cmakeFlags = [
    # actually has a noticeable performance impact
    "-DYUZU_ENABLE_LTO=ON"

    # build with qt6
    "-DENABLE_QT6=ON"
    "-DENABLE_QT_TRANSLATION=ON"

    # use system libraries
    "-DYUZU_USE_EXTERNAL_SDL2=OFF"
    "-DYUZU_USE_EXTERNAL_VULKAN_HEADERS=OFF"

    "-DYUZU_USE_BUNDLED_FFMPEG=ON"

    # don't check for missing submodules
    "-DYUZU_CHECK_SUBMODULES=OFF"

    # enable some optional features
    "-DYUZU_USE_QT_WEB_ENGINE=ON"
    "-DYUZU_USE_QT_MULTIMEDIA=ON"
    "-DUSE_DISCORD_PRESENCE=ON"

    # We dont want to bother upstream with potentially outdated compat reports
    "-DYUZU_ENABLE_COMPATIBILITY_REPORTING=OFF"
    "-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF" # We provide this deterministically
  ];

  qtWrapperArgs = [
    "--prefix LD_LIBRARY_PATH : ${pkgs.vulkan-loader}/lib"
  ];
  env.NIX_CFLAGS_COMPILE = lib.optionalString pkgs.stdenv.hostPlatform.isx86_64 "-msse4.1";
  # In the original, we changed the title bar. I decided to keep
  # it at its default
  preConfigure = ''
    mkdir -p build/externals/nx_tzdb
    ln -s ${nx_tzdb} build/externals/nx_tzdb/nx_tzdb
  '';

  postInstall = ''
    install -Dm444 $src/dist/72-yuzu-input.rules $out/lib/udev/rules.d/72-yuzu-input.rules
  '';
}
