{ stdenv, fetchurl, pkgconfig, gnum4, gdbm, libtool, glib, dbus, avahi
, gconf, gtk, libX11, libICE, libSM, libXtst, libXi, intltool, gettext
, alsaLib, libsamplerate, libsndfile, speex, bluez, udev }:

stdenv.mkDerivation rec {
  name = "pulseaudio-0.9.23";

  src = fetchurl {
    url = "http://freedesktop.org/software/pulseaudio/releases/${name}.tar.gz";
    sha256 = "0m72rrbgy9qncwhqsq9q35niicy6i06sk3g5i8w9bvkhmib27qll";
  };

  # Since `libpulse*.la' contain `-lgdbm', it must be propagated.
  propagatedBuildInputs = [ gdbm ];

  buildInputs =
    [ pkgconfig gnum4 libtool intltool glib dbus avahi
      libsamplerate libsndfile speex alsaLib bluez udev
      #gtk gconf libX11 libICE libSM libXtst libXi
    ];

  preConfigure = ''
    # Change the `padsp' script so that it contains the full path to
    # `libpulsedsp.so'.
    sed -i "src/utils/padsp" \
        -e "s|libpulsedsp\.so|$out/lib/libpulsedsp.so|g"

    # Move the udev rules under $(prefix).
    sed -i "src/Makefile.in" \
        -e "s|udevrulesdir[[:blank:]]*=.*$|udevrulesdir = $out/lib/udev/rules.d|g"
  '';

  configureFlags = ''
    --disable-solaris --disable-hal --disable-jack
    --disable-oss-output --disable-oss-wrapper
    --localstatedir=/var --sysconfdir=/etc
  '';

  installFlags = "sysconfdir=$(out)/etc";

  enableParallelBuilding = true;

  meta = {
    description = "PulseAudio, a sound server for POSIX and Win32 systems";

    longDescription = ''
      PulseAudio is a sound server for POSIX and Win32 systems.  A
      sound server is basically a proxy for your sound applications.
      It allows you to do advanced operations on your sound data as it
      passes between your application and your hardware.  Things like
      transferring the audio to a different machine, changing the
      sample format or channel count and mixing several sounds into
      one are easily achieved using a sound server.
    '';

    homepage = http://www.pulseaudio.org/;

    # Note: Practically, the server is under the GPL due to the
    # dependency on `libsamplerate'.  See `LICENSE' for details.
    licenses = "LGPLv2+";

    maintainers = [ stdenv.lib.maintainers.ludo ];
    platforms = stdenv.lib.platforms.gnu;
  };
}
