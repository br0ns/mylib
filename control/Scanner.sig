signature Scanner =
sig
  include MonadStateP where type 'a inner = 'a option

end
