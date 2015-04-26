# haskell/.profile.d/20-functions-haskell.sh
hmap()
{
  ghc -e "interact ($*)"
}

hmapl()
{
  hmap "unlines.($*).lines"
}

hmapw()
{
  hmapl "map (unwords.($*).words)"
}
