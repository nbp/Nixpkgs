{ stdenv, fetchurl, pkgconfig, postgresql, curl, openssl, zlib }:

let

  version = "1.8.1";
  
  src = fetchurl {
    url = "mirror://sourceforge/zabbix/zabbix-${version}.tar.gz";
    sha256 = "0z4a5lbpgszc2vfg2hc30c1l3l1lbihinqx2sygxf9r5y9k7fj7g";
  };

in

{

  server = stdenv.mkDerivation {
    name = "zabbix-${version}";

    inherit src;

    configureFlags = "--enable-agent --enable-server --with-pgsql --with-libcurl";

    preConfigure =
      ''
        substituteInPlace ./configure \
          --replace " -static" "" \
          --replace /usr/include/iconv.h ${stdenv.gcc.libc}/include/iconv.h
      '';

    buildInputs = [ pkgconfig postgresql curl openssl zlib ];

    postInstall =
      ''
        ensureDir $out/share/zabbix
        cp -prvd frontends/php $out/share/zabbix/php
        ensureDir $out/share/zabbix/db/data
        cp -prvd create/data/*.sql $out/share/zabbix/db/data
        ensureDir $out/share/zabbix/db/schema
        cp -prvd create/schema/*.sql $out/share/zabbix/db/schema
      '';

    meta = {
      description = "An enterprise-class open source distributed monitoring solution";
      homepage = http://www.zabbix.com/;
      license = "GPL";
      maintainers = [ stdenv.lib.maintainers.eelco ];
      platforms = stdenv.lib.platforms.linux;
    };
  };
  
  agent = stdenv.mkDerivation {
    name = "zabbix-agent-${version}";

    inherit src;

    configureFlags = "--enable-agent";

    preConfigure =
      ''
        substituteInPlace ./configure \
          --replace /usr/include/iconv.h ${stdenv.gcc.libc}/include/iconv.h
      '';

    meta = {
      description = "An enterprise-class open source distributed monitoring solution (client-side agent)";
      homepage = http://www.zabbix.com/;
      license = "GPL";
      maintainers = [ stdenv.lib.maintainers.eelco ];
      platforms = stdenv.lib.platforms.all;
    };
  };
  
}
