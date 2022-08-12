
function Touch() 
{
    if(activator.GetTeam() == 3)//CT
    {
        EntFireByHandle(self, "FireUser3", "", 0.00, activator, activator);
    }
    else
    {
        EntFireByHandle(self, "FireUser4", "", 0.00, activator, activator);
    }    
}