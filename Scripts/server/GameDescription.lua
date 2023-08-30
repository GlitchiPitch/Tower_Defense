local MainTable = {}


MainTable.Variables = {
    hp = 'Health',
    d = 'Damage',
    s = 'Speed',
    n = 'Name'
}

MainTable.Keys = {

}

MainTable.PlayerMobs = { 
    mob1 = {Name = 'PlayerMob1', Health = 5, Speed = 5, Id = 1},
    mob2 = {Name = 'PlayerMob2', Health = 5, Speed = 5, Id = 2},
}

MainTable.GameEvents = {
    SpawnMob = 'SpawnMob'
}
MainTable.Signals = {
    ToGame = 'ToGame', ToTower = 'ToTower', ToMob = 'ToMob'
}

return MainTable