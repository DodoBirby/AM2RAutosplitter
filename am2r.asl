state("AM2R", "v1.5+")
{
    uint room : "AM2R.exe", 0x5CB860;
    double metroids : "AM2R.exe", 0x003C9730, 0x34, 0x10, 0x400, 0x0;
    double facing : "AM2R.exe", 0x003C9434, 0x110, 0xAC, 0x8, 0x34, 0x10, 0x8BC, 0x0;
}
//double gamestart : "AM2R.exe", 0x003BD168, 0x0, 0x34, 0x10, 0x19C, 0x0;

init
{
    vars.completedSplits = new Dictionary<string, bool>();
    vars.completedSplits.Add( "goldenTemple", false );
    vars.completedSplits.Add( "hydroStation", false );
    vars.completedSplits.Add( "industrialComplex", false );
    vars.completedSplits.Add( "area35", false );
    vars.completedSplits.Add( "tower", false );
    vars.completedSplits.Add( "area5", false );
    vars.completedSplits.Add( "firstOmega", false );
    vars.completedSplits.Add( "omegaNest", false );
    vars.completedSplits.Add( "lab", false );
    vars.completedSplits.Add( "queen", false );
}

startup
{
}

start
{
    vars.canFinish = false;

    if (old.room != current.room && current.room == 17 && old.room == 1)
    {
        return true;
    }
}

update
{
    vars.canFinish = true;
    var completedSplits = vars.completedSplits;
    foreach(var split in completedSplits)
    {
        vars.canFinish = split.Value;
    }

    print(vars.canFinish.ToString());
}

// Splits happen on room transitions between specific rooms, and when
// a specific amount of metroids are emaining
// Golden Temple - 42 metroids. Room 55 -> 35
// Hydro Station - 34 metroids. Room 82 -> 33
// Industrial Complex - 31 metroids. Room 131 -> 130
// Area 3.5 - 20 metroids. Room 179 -> 178
// The Tower - 14 metroids. Room 186 -> 49
// Area 5 - 6 metroids. Room 238 -> 50
// First Omega - 4 metroids. Room 314 -> 313
// Omega Nest - 1 metroids. Room 335 -> 337
// Lab - 1 metroids. Room 367 -> 368
// Queen - 0 metroids. Room 368 -> 369
// Finished - 0 metroids. First frame of samus entering her ship

split
{

    // Only check on room transitions
    if (old.room != current.room && current.room == 17)
    {
        // Golden temple
        if (current.metroids == 42 && !vars.completedSplits["goldenTemple"] && old.room == 55)
        {
            vars.completedSplits["goldenTemple"] = true;
            return true;
        }

        // Hydro station
        if (current.metroids == 34 && !vars.completedSplits["hydroStation"] && old.room == 82)
        {
            vars.completedSplits["hydroStation"] = true;
            return true;
        }

        // Industrial complex
        if (current.metroids == 31 && !vars.completedSplits["industrialComplex"] && old.room == 131)
        {
            vars.completedSplits["industrialComplex"] = true;
            return true;
        }

        // Area 3.5
        if (current.metroids == 20 && !vars.completedSplits["area35"] && old.room == 179)
        {
            vars.completedSplits["area35"] = true;
            return true;
        }

        // The Tower
        if (current.metroids == 14 && !vars.completedSplits["tower"] && old.room == 186)
        {
            vars.completedSplits["tower"] = true;
            return true;
        }

        // Area 5
        if (current.metroids == 6 && !vars.completedSplits["area5"] && old.room == 238)
        {
            vars.completedSplits["area5"] = true;
            return true;
        }

        // First Omega
        if (current.metroids == 4 && !vars.completedSplits["firstOmega"] && old.room == 314)
        {
            vars.completedSplits["firstOmega"] = true;
            return true;
        }

        // Omega Nest
        if (current.metroids == 1 && !vars.completedSplits["omegaNest"] && old.room == 335)
        {
            vars.completedSplits["omegaNest"] = true;
            return true;
        }

        // Lab
        if (current.metroids == 1 && !vars.completedSplits["lab"] && old.room == 367)
        {
            vars.completedSplits["lab"] = true;
            return true;
        }

        // Queen
        if (current.metroids == 0 && !vars.completedSplits["queen"] && old.room == 368)
        {
            vars.completedSplits["queen"] = true;
            return true;
        }
    }

    if (vars.canFinish && current.facing == 0 && old.facing != 0) {
        return true;
    }
}

reset
{
    if (current.room == 1)
    {
        // Kinda dumb, but we reset this here.
        vars.completedSplits = new Dictionary<string, bool>();
        vars.completedSplits.Add( "goldenTemple", false );
        vars.completedSplits.Add( "hydroStation", false );
        vars.completedSplits.Add( "industrialComplex", false );
        vars.completedSplits.Add( "area35", false );
        vars.completedSplits.Add( "tower", false );
        vars.completedSplits.Add( "area5", false );
        vars.completedSplits.Add( "firstOmega", false );
        vars.completedSplits.Add( "omegaNest", false );
        vars.completedSplits.Add( "lab", false );
        vars.completedSplits.Add( "queen", false );

        return true;
    }
}
