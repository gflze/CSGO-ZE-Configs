//used to patch the no-knockback spin exploit on some maps
//install as csgo/scripts/vscripts/PushBack.nut
enemy <- null;
const PUSH_SCALE = 48.0;

function LoadActivatorAsEnemyTarget() 
{
    enemy = activator;
}

function FuckTheEnemyUp()
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
    local vel = Vector(PUSH_SCALE * dir.x, PUSH_SCALE * dir.y, PUSH_SCALE * dir.z);

    // Apply onto the enemy
    enemy.__KeyValueFromVector("basevelocity", vel);
}