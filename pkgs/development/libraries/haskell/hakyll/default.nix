{ cabal, binary, blazeHtml, citeprocHs, cryptohash, hamlet, mtl
, pandoc, parsec, regexBase, regexPcre, snapCore, snapServer
, tagsoup, time
}:

cabal.mkDerivation (self: {
  pname = "hakyll";
  version = "3.2.6.0";
  sha256 = "1yg97kihfxb250vk9dm2v9sh197lc6qjil0j40zgcwpss96xynax";
  buildDepends = [
    binary blazeHtml citeprocHs cryptohash hamlet mtl pandoc parsec
    regexBase regexPcre snapCore snapServer tagsoup time
  ];
  meta = {
    homepage = "http://jaspervdj.be/hakyll";
    description = "A static website compiler library";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [
      self.stdenv.lib.maintainers.andres
      self.stdenv.lib.maintainers.simons
    ];
  };
})
