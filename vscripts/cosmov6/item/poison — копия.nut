map_brush <- Entities.FindByName(null, "map_brush");

PLAYERS <- [];
ticking <- false;

lvl <- 0;
worktime <- 0;
dist <- 0;
damage <- 0;
slow <- 0;
speed <- 5.0;
speedmod <- 2.5;
//speed_max <- 70.0;
speed_max <- 50.0;
trace_dist <- 75.0;
trace_check <- null;
velocity <- null;

function Tick()
{
    if(!ticking)
    {
        PLAYERS.clear();
        self.Destroy();
        return;
    }
    if(PLAYERS.len() > 0)
    {
        foreach(p in PLAYERS)
        {
            if(p.IsValid() && p.GetTeam() == 2 && p.GetHealth() > 0)
            {
                local spos = self.GetOrigin();
                local apos = p.GetOrigin();

                if(GetDistance2D(spos,apos) <= dist)
                {
                    EntFireByHandle(map_brush, "RunScriptCode", "DamagePlayer("+damage+",::item)", 0, p, p);
                    EntFireByHandle(map_brush, "RunScriptCode", "SlowPlayer("+slow+",0.06)", 0, p, p);
                    
                    //DrawAxis(apos)
                }
            }
        }
    }
    EntFireByHandle(self, "RunScriptCode", "Tick(); ", 0.05, null, null);
}

function TickMove()
{
    if(ticking)
        return;

    local cnt = self.GetOrigin();
    local trace = vadd(cnt, trace_check);
    local hitDist = TraceLine(cnt, trace, null);

    if(hitDist > 0.05)//wall hit
    {
        local norm = GetApproxPlaneNormal(cnt, trace_check);
        if(!veq(norm, Vector(0,0,0)))
        {
            //local end = vadd(cnt, vscale(trace_check, hitDist));
            trace_check = vrefl(trace_check, norm);
			//velocity = Vector(velocity.x,velocity.y,0);
			trace_check.Norm();
            
            if(speed + speedmod >= speed_max)
            {
                speed = speed_max;
            }
            else speed += speedmod;

            velocity = trace_check * speed;
			trace_check = trace_check * trace_dist;
			// self.SetForwardVector(velocity);
        }
    }
    self.SetOrigin(cnt + velocity); 

    EntFireByHandle(self, "RunScriptCode", "TickMove(); ", 0.01, null, null);
}

function Touch()
{
    PLAYERS.push(activator);
}

function EndTouch()
{
    if(PLAYERS.len() > 0)
    {
        for (local i = 0; i < PLAYERS.len(); i++)
        {
            if(PLAYERS[i] == activator)PLAYERS.remove(i);
        }
    }
}

function PrintArray()
{
    if(PLAYERS.len() > 0)
    {
        for (local i = 0; i < PLAYERS.len(); i++)
        {
           printl(PLAYERS[i]);
        }
    }
    else
    {
        printl("CLEAR");
    }
}

function OnPostSpawn()
{
    EnableMove();
}

function EnableMove()
{
    velocity = self.GetForwardVector() * speed;
    trace_check = self.GetForwardVector() * trace_dist;
    EntFireByHandle(self, "FireUser1", "", 0.00, null, null);
    TickMove();
}
Level <- null;
Particle <- null;
Particle_Exlposion <- null;
Particle_Smoke1 <- null;
Particle_Smoke2 <- null;
Particle_Smoke3 <- null;
Touch_Trigger <- null;

function SetHandle(id)
{
    if(id == 0)
    {
        Particle = caller;
        EntFireByHandle(Particle, "Start", "", 0, null, null);
    }
    else if(id == 1)
        Particle_Exlposion = caller;
    else if(id == 2)
    {
        Touch_Trigger = caller;
        EntFireByHandle(self, "RunScriptcode", "Connect();", 0.1, null, null);
    }
    else if(id == 3)
        Particle_Smoke1 = caller;
    else if(id == 4)
        Particle_Smoke2 = caller;
    else if(id == 5)
        Particle_Smoke3 = caller;
}
function Connect()
{
    EntFireByHandle(Touch_Trigger, "AddOutPut", "OnStartTouch " + self.GetName() + ":RunScriptCode:Enable():0:1", 0, null, null);
    EntFireByHandle(Touch_Trigger, "Enable", "", 0.05, null, null);
}

function Enable()
{
    if(ticking)
        return;
    ticking = true;
    Tick();
    self.ConnectOutput("OnStartTouch", "Touch");
    self.ConnectOutput("OnEndTouch", "EndTouch");

    self.SetForwardVector(Vector(0,0,0));
    self.SetAngles(0,0,0);
    
    if(Level == 1)
        EntFireByHandle(Particle_Smoke1, "Start", "", 1.00, null, null);
    else if(Level == 2)
        EntFireByHandle(Particle_Smoke2, "Start", "", 1.00, null, null);
    else if(Level == 3)
        EntFireByHandle(Particle_Smoke3, "Start", "", 1.00, null, null);
    EntFireByHandle(Particle_Exlposion, "Start", "", 0.00, null, null);
    EntFireByHandle(Particle_Exlposion, "Kill", "", 0.5, null, null);
    EntFireByHandle(Particle, "DestroyImmediately", "", 0.00, null, null);
    EntFireByHandle(self, "Enable", "", 0.01, null, null);

    EntFireByHandle(self, "Enable", "", 0.01, null, null);
    EntFireByHandle(self, "RunScriptcode", "Disable();", worktime, null, null);
}

function Disable()
{
    ticking = false;
    self.DisconnectOutput("OnStartTouch", "Touch")
    self.DisconnectOutput("OnEndTouch", "EndTouch");
    EntFireByHandle(self, "Disable", "", 0.01, null, null);
}

function SelfDestroy()
{
    if(ticking)
        return;
    self.Destroy();
}

function GetDistance2D(v1,v2)return sqrt((v1.x-v2.x)*(v1.x-v2.x)+(v1.y-v2.y)*(v1.y-v2.y));

function DrawAxis(pos,s = 16,nocull = true,time = 4)
{
	DebugDrawLine(Vector(pos.x-s,pos.y,pos.z), Vector(pos.x+s,pos.y,pos.z), 255, 0, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y-s,pos.z), Vector(pos.x,pos.y+s,pos.z), 0, 255, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y,pos.z-s), Vector(pos.x,pos.y,pos.z+s), 0, 0, 255, nocull, time);
}

//Functions below by Enviolinador:
//============================================================
/**
 * Attempts to project a triangle onto a surface in front of a point and in a direction
 * to compute the normal of the plane in that surface
 */
function GetApproxPlaneNormal(orig, vec, delta=0.01, drawTrianglePlane=false)
{
    // Compute the direction vector
    local length = vec.Length();
    local dir = vnorm(vec);
    local yaw = atan2(dir.x, dir.z);
    local pitch = atan2(dir.y, sqrt((dir.x * dir.x) + (dir.z * dir.z)));

    // Compute R direction
    local xR = sin(yaw+delta)*cos(pitch+delta);
    local yR = sin(pitch+delta);
    local zR = cos(yaw+delta)*cos(pitch+delta);
    local endR = Vector(xR, yR, zR);
    local vecR = vscale(vnorm(endR), length);

    // Compute L direction
    local xL = sin(yaw-delta)*cos(pitch+delta);
    local yL = sin(pitch+delta);
    local zL = cos(yaw-delta)*cos(pitch+delta);
    local endL = Vector(xL, yL, zL);
    local vecL = vscale(vnorm(endL), length);

    // Find end points distance
    local distA = TraceLine(orig, vadd(orig, vec), null);
    local distB = TraceLine(orig, vadd(orig, vecR), null);
    local distC = TraceLine(orig, vadd(orig, vecL), null);

    // Compute the 3 triangle verts
    local vertA = vadd(orig, vscale(vec, distA));
    local vertB = vadd(orig, vscale(vecR, distB));
    local vertC = vadd(orig, vscale(vecL, distC));

    // Return a null vector if any of the traces hit nothing
    if(distA == 1 && distB == 1 && distC == 1)
        return Vector(0.0, 0.0, 0.0);
	
	/*
    // Draw the triangle used to compute the normal, if desired
    if(drawTrianglePlane)
    {
        DebugDrawLine(vertA, vertB, 255, 0, 0, false, 5);
        DebugDrawLine(vertB, vertC, 0, 255, 0, false, 5);
        DebugDrawLine(vertC, vertA, 0, 0, 255, false, 5);
    }
	*/

    // Compute the two planar vectors
    local t1 = vsub(vertB, vertA);
    local t2 = vsub(vertB, vertC);
    local norm = vcross(t1, t2);

    // Return if the normal is the null vector (either t1, t2 or both are null)
    if(vnull(norm))
        return norm;

    // Correct the normal if we're going in the same direction as the original vector
    norm = vnorm(norm);
    if(veqd(norm, dir))
        norm = vinv(norm);
    return norm;
}

/**
 * Compute the negated/inverse direction vector
 */
function vinv(v)
{
    return Vector(-v.x, -v.y, -v.z);
}

/**
 * Add two vectors
 */
function vadd(v1, v2)
{
    return Vector(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
}

/**
 * Subtract two vectors
 */
function vsub(v1, v2)
{
    return Vector(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
}

/**
 * Multiply all vector components by a scalar
 */
function vscale(v, s)
{
    return Vector(v.x * s, v.y * s, v.z * s);
}

/**
 * Cross product of two vectors, wrapping v1.Cross(v2)
 */
function vcross(v1, v2)
{
    return v1.Cross(v2);
}

/**
 * Divide all components of a vector by a scalar
 */
function vdiv(v, d)
{
    return Vector(v.x / d, v.y / d, v.z / d);
}

/**
 * Generate a '2D' vector with z = 0
 */
function v2D(v)
{
	return Vector(v.x, v.y, 0.0);
}

/**
 * Get the 2D angle (from top persp.) of a vector
 */
function v2Dang(v)
{
    return 180.0 * atan2(v.y, v.x) / PI;
}

/**
 * Normalization of a vector, equivalent for v.norm()
 */
function vnorm(v)
{
	return vdiv(v, v.Length())
}

/**
 * Dor product of two vectors
 */
function vdot(v1, v2)
{
    return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
}

/**
 * Cap vector length
 */
function vcap(v, limit)
{
    if(v.Length() > limit)
    	return vscale(v.norm(), limit);
    else
    	return v;
}

/**
 * Angle between two vectors
 */
function vang(v1, v2)
{
    local dot = vdot(v1, v2);
    local l1 = v1.Length();
    local l2 = v2.Length();
    return acos(dot/(l1*l2));
}

/**
 * Vector equality
 */
function veq(v1, v2)
{
    return v1.x == v2.x && 
           v1.y == v2.y &&
           v1.z == v2.z; 
}

/**
 * Vector equality with a delta
 */
function veqd(v1, v2, d=0.001){
    return abs(v1.x - v2.x) < d && 
           abs(v1.y - v2.y) < d &&
           abs(v1.z - v2.z) < d; 
}

/**
 * Check if a vector is the null vector
 */
function vnull(v)
{
    return v.x == 0 && v.y == 0 && v.z == 0;
}

/**
 * Compute the reflection of a vector v with respect to the normal n
 */
function vrefl(v, n)
{
    local nn = vnorm(n);
    local dot = vdot(v, nn);
    local term = vscale(n, 2*dot)
    return vsub(v, term); 
}

/**
 * Computes the sector on which a vector sits, in 2D space
 */
function SectorizeVector(vec, shift, numSectors=4)
{
    local angle = v2Dang(vec) + 180/numSectors - shift; 
    local wrappedAngle = angle/360 - floor(angle/360)
    return floor(numSectors * wrappedAngle);
}

/**
 * Compute a hacky intersection boundary made with tracelines
 * for a sphere. Returns the point it intersects at, null 
 * if everything is clear.
 */
function SphereCollideWithWorld(orig, radius, degree=5)
{
    local inc = PI / degree;
    local phiStop = PI - inc;

    local minDist = 1.0;
    local endPoint = null;
    for (local phi = 0.0; phi < PI; phi += inc) 
    {
        // Avoid computing the full circle on the edge cases
        local theta = 0.0;
        if (phi == 0.0 || phi == phiStop) 
            theta = PI - inc;

        for (; theta < 2 * PI; theta += inc) 
        {
            local ct = cos(theta);
            local st = sin(theta);
            local cp = cos(phi);
            local sp = sin(phi);
            local vec = vscale(Vector(ct * sp, st * sp, cp), radius)

            local end = vadd(orig, vec);
            local dist = TraceLine(orig, end, null);

            if (dist < minDist)
                endPoint = vadd(orig, vscale(vec, dist));
        } 
    } 
    return endPoint;
}

/**
 * Attempts to project a triangle onto a surface in front of a point and in a direction
 * to compute the normal of the plane in that surface
 */
function GetApproxPlaneNormal(orig, vec, delta=0.01, drawTrianglePlane=false)
{
    // Compute the direction vector
    local length = vec.Length();
    local dir = vnorm(vec);
    local yaw = atan2(dir.x, dir.z);
    local pitch = atan2(dir.y, sqrt((dir.x * dir.x) + (dir.z * dir.z)));

    // Compute R direction
    local xR = sin(yaw+delta)*cos(pitch+delta);
    local yR = sin(pitch+delta);
    local zR = cos(yaw+delta)*cos(pitch+delta);
    local endR = Vector(xR, yR, zR);
    local vecR = vscale(vnorm(endR), length);

    // Compute L direction
    local xL = sin(yaw-delta)*cos(pitch+delta);
    local yL = sin(pitch+delta);
    local zL = cos(yaw-delta)*cos(pitch+delta);
    local endL = Vector(xL, yL, zL);
    local vecL = vscale(vnorm(endL), length);

    // Find end points distance
    local distA = TraceLine(orig, vadd(orig, vec), null);
    local distB = TraceLine(orig, vadd(orig, vecR), null);
    local distC = TraceLine(orig, vadd(orig, vecL), null);

    // Compute the 3 triangle verts
    local vertA = vadd(orig, vscale(vec, distA));
    local vertB = vadd(orig, vscale(vecR, distB));
    local vertC = vadd(orig, vscale(vecL, distC));

    // Return a null vector if any of the traces hit nothing
    if(distA == 1 && distB == 1 && distC == 1)
        return Vector(0.0, 0.0, 0.0);

    // Draw the triangle used to compute the normal, if desired
    if(drawTrianglePlane)
    {
        DebugDrawLine(vertA, vertB, 255, 0, 0, false, 5);
        DebugDrawLine(vertB, vertC, 0, 255, 0, false, 5);
        DebugDrawLine(vertC, vertA, 0, 0, 255, false, 5);
    }

    // Compute the two planar vectors
    local t1 = vsub(vertB, vertA);
    local t2 = vsub(vertB, vertC);
    local norm = vcross(t1, t2);

    // Return if the normal is the null vector (either t1, t2 or both are null)
    if(vnull(norm))
        return norm;

    // Correct the normal if we're going in the same direction as the original vector
    norm = vnorm(norm);
    if(veqd(norm, dir))
        norm = vinv(norm);
    return norm;
}

/**
 * Computes the plane to point distance with a plane
 * defined as a point and its normalized normal vector.
 */
function GetPointToPlaneDistance(plp, pln, target)
{
    return vdot(target, pln) - vdot(plp, pln);
}