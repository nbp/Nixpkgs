{stdenv, fetchurl, pkgconfig, neon, libusb, openssl, udev, tcp_wrappers, freeipmi, avahi}:

stdenv.mkDerivation {
  name = "nut-2.6.3";
  src = fetchurl {
    url = http://www.networkupstools.org/source/2.6/nut-2.6.3.tar.gz;
    sha256 = "34913b729d2032faaf6f31e800a400bcd874f1f4daacae6fe0d388bd235b633a";
  };

  buildInputs = [pkgconfig neon libusb openssl udev tcp_wrappers freeipmi avahi];

  configureFlags = [
    "--with-all"
    "--with-ssl"
    "--with-wrap"
    "--with-freeipmi"
    "--with-avahi"
    "--with-doc"
    "--without-snmp" # Until we have it ...
    "--without-powerman" # Until we have it ...
    "--without-cgi"
  ];

  meta = {
    description = "Network UPS Tools";
    longDescription = ''
      Network UPS Tools is a collection of programs which provide a common
      interface for monitoring and administering UPS, PDU and SCD hardware.
      It uses a layered approach to connect all of the parts.
    '';
    homepage = http://www.networkupstools.org/;
    platforms = with stdenv.lib.platforms; linux;
    maintainers = with stdenv.lib.maintainers; [ pierron ];
  };
}
