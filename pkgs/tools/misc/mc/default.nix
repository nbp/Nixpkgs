{ stdenv, fetchurl, pkgconfig, glib, gpm, file, e2fsprogs
, libX11, libICE, perl, zip, unzip, gettext, slang}:

stdenv.mkDerivation rec {
  name = "mc-4.7.5.3";
  
  src = fetchurl {
    url = http://www.midnight-commander.org/downloads/mc-4.7.5.3.tar.bz2;
    sha256 = "1di8fsdg6y98iq3846j145qjk4bf5rgjj2hxnxdbcwfp8p3v8x88";
  };
  
  buildInputs = [ pkgconfig perl glib gpm slang zip unzip file gettext libX11 libICE e2fsprogs ];

  meta = {
    description = "File Manager and User Shell for the GNU Project";
    homepage = http://www.midnight-commander.org;
    license = "GPLv2+";
    maintainers = [ stdenv.lib.maintainers.sander ];
  };
}
