function PreSpawnInstance( entityClass, entityName )
{
    local r = RandomInt(100,255)
    local g = RandomInt(100,255)
    local b = RandomInt(100,255)
    local keyvalues =
    { 
        rendercolor = r+" "+g+" "+b,
    }
	return keyvalues
}