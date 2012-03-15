structure State :> MonadState where type 'a inner = 'a = StateT(Identity)
