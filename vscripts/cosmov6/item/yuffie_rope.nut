::Maker <- Entities.CreateByClassname("env_entity_maker")
Maker.__KeyValueFromString("EntityTemplate", self.GetName());
::CallBackLogic <- null;

::CreateRope <- function(logic)
{
    CallBackLogic = logic;
    Maker.SpawnEntity();
}

function PreSpawnInstance( entityClass, entityName )
{
	return {};
}

function PostSpawn(entities)
{
    local array = [];
    foreach (entity in entities)
    {
        array.push(entity);
    }
    CallBackLogic.GetScriptScope().CreateRopeCallBack(array);
}