queue <- 0;

function AssignRocketLauncherName() {
    queue += 1;
    printl("queue = " + queue)
    EntFireByHandle(activator,"AddOutput","targetname GuyPickedUpRocketLauncher" + queue.tostring(),0.02,null,null);
}

function CheckGetName(Type) {
    if(Type == 0) {
        return EntFireByHandle(caller,"AddOutput","targetname PropRocketPicked" + queue.tostring(),0.01,null,null);
    }
    if(Type == 1) {
        return EntFireByHandle(caller,"AddOutput","targetname triggerMeasureRocketPicked" + queue.tostring(),0.01,null,null);
    }
}

function PreSpawnInstance(classname, targetname) {
    if (queue == 0) {
        return;
    }
    local keyvalues = {
        MeasureReference = "triggerMeasureRocketPicked" + queue.tostring()
        MeasureTarget = "GuyPickedUpRocketLauncher" + queue.tostring()
        TargetName = "measuremovementRocketLauncher" + queue.tostring()
        Target = "PropRocketPicked" + queue.tostring()
        TargetReference = "triggerMeasureRocketPicked" + queue.tostring()
    }
    return keyvalues;
}

function PostSpawn(entities) {
    foreach(targetname,handle in entities) {
    }
}