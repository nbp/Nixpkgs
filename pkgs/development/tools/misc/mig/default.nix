{ fetchgit, stdenv, autoconf, automake, flex, bison, machHeaders
, cross ? null }:

let rev = "4fee6a5652f609cb68cdbd9049d4da7a194f15f8"; in
stdenv.mkDerivation rec {
  name = "mig-1.4-${rev}";

  src = fetchgit {
    url = "git://git.sv.gnu.org/hurd/mig.git";
    sha256 = "d6958d9b60925d4600aac133c9505bc873a16b203c69260bd0fb228922ee9273";
    inherit rev;
  };

  buildInputs = [ autoconf automake flex bison machHeaders ];

  preConfigure = "autoreconf -vfi";

  configureFlags =
    stdenv.lib.optionalString (cross != null) "--build=${cross.config}";

  meta = {
    description = "GNU MIG, the Mach interface generator";

    longDescription =
      '' GNU MIG is the GNU distribution of the Mach 3.0 interface generator
         MIG, as maintained by the GNU Hurd developers for the GNU project.

         You need this tool to compile the GNU Mach and GNU Hurd
         distributions, and to compile the GNU C library for the Hurd.  Also,
         you will need it for other software in the GNU system that uses
         Mach-based inter-process communication.
      '';

    license = "GPLv2+";

    homepage = http://www.gnu.org/software/hurd/microkernel/mach/mig/gnu_mig.html;

    # platforms = stdenv.lib.platforms.gnu;  # really GNU/Hurd
    maintainers = [ stdenv.lib.maintainers.ludo ];
  };
}
