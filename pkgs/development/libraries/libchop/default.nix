{ fetchurl, stdenv, zlib, bzip2, libgcrypt, gdbm, gperf, tdb, gnutls, db4
, libuuid, lzo, pkgconfig, guile }:

stdenv.mkDerivation rec {
  name = "libchop-0.5";

  src = fetchurl {
    url = "mirror://savannah/libchop/${name}.tar.gz";
    sha256 = "0i7gl0c99pf6794bbwm3iha6a0bciqq969mgwwv6gm9phiiy5s8b";
  };

  patches =
    [ ./0001-tests-Simplify-deserialize.c.patch
      ./0002-block-indexer-hash-Fix-off-by-n-in-ASCII-deserializa.patch
      ./0003-fix-test-makefile.patch
      ./0004-tests-Export-XDG_CACHE_HOME-in-utils-backup.patch
    ];

  buildNativeInputs = [ pkgconfig gperf ];
  buildInputs =
    [ zlib bzip2 lzo
      libgcrypt
      gdbm db4 tdb
      gnutls libuuid
      guile
    ];

  doCheck = true;

  meta = {
    description = "libchop, tools & library for data backup and distributed storage";

    longDescription =
      '' Libchop is a set of utilities and library for data backup and
         distributed storage.  Its main application is chop-backup, an
         encrypted backup program that supports data integrity checks,
         versioning at little cost, distribution among several sites,
         selective sharing of stored data, adaptive compression, and more.
         The library itself, which chop-backup builds upon, implements
         storage techniques such as content-based addressing, content hash
         keys, Merkle trees, similarity detection, and lossless compression.
         It makes it easy to combine them in different ways.  The
         ‘chop-archiver’ and ‘chop-block-server’ tools, illustrated in the
         manual, provide direct access to these facilities from the command
         line.  It is written in C and has Guile (Scheme) bindings.
      '';

    homepage = http://nongnu.org/libchop/;
    license = "GPLv3+";

    maintainers = with stdenv.lib.maintainers; [ ludo viric ];
    platforms = stdenv.lib.platforms.gnu;
  };
}
