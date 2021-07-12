//used to patch the no-knockback spin exploit on some maps.
//install as csgo/scripts/vscripts/gfl/PushBack.nut

enemy <- null;

function LoadActivatorAsEnemyTarget() 
{
    enemy = activator;
}

//push_scale: speed kv of trigger_push that pushes back the ZM Item
function FuckTheEnemyUp(push_scale = 50)
{
    // Leave if either of them is invalid
    if (activator == null || enemy == null) return;

    // Compute the direction vector from player to enemy
    local a = enemy.GetCenter();
    local b = activator.GetCenter();
    local dir = Vector(a.x - b.x, a.y - b.y, a.z - b.z);

    // Normalize the direction
    dir.Norm();

    // Scale appropiately to get the velocity
    local vel = Vector(push_scale * dir.x, push_scale * dir.y, push_scale * dir.z);

    // Apply onto the enemy
    enemy.__KeyValueFromVector("basevelocity", vel);
}