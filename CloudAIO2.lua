--Version 5.4 *FINAL* I Will no longer...

-- Varus
-- Cassiopeia
if GetObjectName(GetMyHero()) == "Cassiopeia" then 
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Cassiopeia Loaded</font>"))
--Menu
Config = scriptConfig("Cassiopeia", "Cassiopeia")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use Smart E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Es", "Use E", SCRIPT_PARAM_ONOFF, false)
Config.addParam("Z", "LaneClear E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("U", "LaneClear W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("I", "LaneClear Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "LastHit E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("S", "Use HP W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("D", "Use Q KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("O", "Use E KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("V", "Use W KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
LC()
LH()
KSC()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then
 
-- Cassiopeia E
if IsInDistance(unit, 700) and Config.E and GotBuff(unit, "cassiopeianoxiousblastpoison") == 1 or GotBuff(unit, "cassiopeiamiasmapoison") == 1 or GotBuff(unit, "cassiopeiatwinfangdebuff") == 1 or GotBuff(unit, "poison") == 1 then
    CastTargetSpell(unit, _E)
end
if IsInDistance(unit, 700) and Config.Es then
    CastTargetSpell(unit, _E)
end
-- Cassiopeia W
    if Config.W then
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,850,55,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and IsInDistance(unit, 850) then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                end
            end
-- Cassiopeia Q
    local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1000,250,850,60,false,true)
    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and IsInDistance(unit, 850) and Config.Q then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                end
-- Cassiopeia R
             if Config.R then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,825,55,false,true)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 700) and EnemiesAround(GetMyHeroPos(), 825) >= 3 then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
            end
end
end
end)
function LC()
   if IWalkConfig.LaneClear then
    for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
          if IsInDistance(Q, 700) then
            if Config.Z then
        local EnemyPos = GetOrigin(Q)
                    if CanUseSpell(myHero, _E) == READY and IsInDistance(Q, 700) and Config.Z and GotBuff(Q, "cassiopeianoxiousblastpoison") == 1 or GotBuff(Q, "cassiopeiamiasmapoison") == 1 or GotBuff(Q, "cassiopeiatwinfangdebuff") == 1 then
            CastTargetSpell(Q, _E)
    end
            local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _Q) == READY and Config.I and IsInDistance(Q, 850) then
            CastSkillShot(_Q,EnemyPos.x,EnemyPos.y,EnemyPos.z)
    end
            local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _W) == READY  and Config.U and IsInDistance(Q, 850) then
            CastSkillShot(_W,EnemyPos.x,EnemyPos.y,EnemyPos.z)
    end
    end
end
end
end
end
function LH()
   if IWalkConfig.LastHit then
          if Config.F then
      for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
        if IsInDistance(Q, 700) then
        local z = (GetCastLevel(myHero,_E)*55)+(GetBonusAP(myHero)*1)
        local hp = GetCurrentHP(Q)
        local Dmg = CalcDamage(myHero, Q, z)
        if Dmg > hp then
if CanUseSpell(myHero, _E) == READY then
    CastTargetSpell(Q, _E)
            end
        end
          end
        end
      end
        end

   end
end
function KSC()
for i,enemy in pairs(GetEnemyHeroes()) do
local z = (GetCastLevel(myHero,_E)*25)+(GetBonusAP(myHero)*.55)
         local H = (GetCastLevel(myHero,_Q)*40)+(GetBonusAP(myHero)*.45)
         local G = (GetCastLevel(myHero,_W)*45)+(GetBonusAP(myHero)*.90)
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1000,250,850,60,false,true)
    if CanUseSpell(myHero, _Q) == READY and WPred.HitChance == 1 and IsInDistance(enemy, 850) and Config.D and CalcDamage(myHero, enemy, H) > GetCurrentHP(enemy) and ValidTarget(enemy,850) then
    CastSkillShot(_Q,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                end
if CalcDamage(myHero, enemy, z) > GetCurrentHP(enemy) and IsInDistance(enemy, 700) and Config.O and ValidTarget(enemy,850) then
    CastTargetSpell(enemy, _E)
end
 local QPred = GetPredictionForPlayer(GetMyHeroPos(),enemy,GetMoveSpeed(enemy),1600,250,850,55,false,true)
    if CanUseSpell(myHero, _W) == READY and QPred.HitChance == 1 and IsInDistance(enemy, 850) and Config.V and CalcDamage(myHero, enemy, G) > GetCurrentHP(enemy) and ValidTarget(enemy,850) then
    CastSkillShot(_W,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                end
            end
end
if GetObjectName(GetMyHero()) == "Vladimir" then
--Menu
Config = scriptConfig("Vladimir", "Vladimir")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Z", "LaneClear E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("U", "LaneClear W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("I", "LaneClear Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "LastHit E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Y", "LastHit Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("S", "Use HP W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("D", "Use Q KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("O", "Use E KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
LaneCleared()
LastHitd()
KS()
SaveMeW()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then
 
-- Vladimir E
    if Config.E then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,850,50,false,true)
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 610) then
            CastSpell(_E)
            end
        end

-- Vladimir W
    if Config.W then
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and IsInDistance(unit, 150) then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                end
            end
-- Vladimir Q
            if Config.Q then
                 if CanUseSpell(myHero, _Q) == READY and IsObjectAlive(unit) and IsInDistance(unit, 600) then
            CastTargetSpell(unit,_Q)
            end
        end
-- Vladimir R
             if Config.R then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,700,55,false,true)
    local ult = (GetCastLevel(myHero,_R)*112)+(GetBonusAP(myHero)*0.78)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 700) and CalcDamage(myHero, unit, ult) then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
            end
    end

end
end)
function LaneCleared()
   if IWalkConfig.LaneClear then
    for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
          if IsInDistance(Q, 650) then
            if Config.Z then
        local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _E) == READY and IsInDistance(Q, 610) then
            CastSpell(_E)
    end
                if CanUseSpell(myHero, _W) == READY and IsInDistance(Q, 150) and Config.U then
            CastSpell(_W)
    end
                    if CanUseSpell(myHero, _Q) == READY and IsInDistance(Q, 600) and Config.I then
            CastTargetSpell(Q, _Q)
    end
    end
end
end
end
end
function LastHitd()
   if IWalkConfig.LastHit then
          if Config.F then
      for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
        if IsInDistance(Q, 610) then
        local z = (GetCastLevel(myHero,_Q)*25)+(GetBonusAP(myHero)*.45)
         local H = (GetCastLevel(myHero,_Q)*35)+(GetBonusAP(myHero)*.60)

        local hp = GetCurrentHP(Q)
        local Dmg = CalcDamage(myHero, Q, z)
        local Fmg = CalcDamage(myHero, Q, H)
        if Dmg > hp then
if CanUseSpell(myHero, _E) == READY then
    CastSpell(_E)
            end
            if Fmg > hp then
            if Config.Y then
                 if CanUseSpell(myHero, _Q) == READY and IsObjectAlive(Q) and IsInDistance(Q, 600) then
            CastTargetSpell(Q,_Q)
            end
          end
        end
          end
        end
      end
        end

   end
end
function SaveMeW()
if Config.S then
if CanUseSpell(myHero, _W) and (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.15 and GotBuff(myHero, "recall") == 0 then
  CastSpell(_W)
end
end
end
function KS()
for i,enemy in pairs(GetEnemyHeroes()) do
local z = (GetCastLevel(myHero,_Q)*25)+(GetBonusAP(myHero)*.45)
         local H = (GetCastLevel(myHero,_Q)*35)+(GetBonusAP(myHero)*.60)
          if CalcDamage(myHero, enemy, H) > GetCurrentHP(enemy) and IsInDistance(enemy, 600) and Config.D then
    CastTargetSpell(enemy, _Q)
end
if CalcDamage(myHero, enemy, z) > GetCurrentHP(enemy) and IsInDistance(enemy, 610) and Config.O then
    CastSpell(_E)
end
end
end
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Vladimir Loaded</font>"))
end
if GetObjectName(GetMyHero()) == "Varus" then
--Menu
Config = scriptConfig("Varus", "Varus")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "LaneClear", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
LaneClearE()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then
 
-- Varus E
    if Config.E then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,850,50,false,true)
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end

-- Varus W
-- Varus Q
    if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, 1625) and Config.Q then
      local myHeroPos = GetMyHeroPos()
      CastSkillShot(_Q, myHeroPos.x, myHeroPos.y, myHeroPos.z)
      for i=250, 1625, 250 do
        DelayAction(function()
            local _Qrange = 225 + math.min(225, i/2)
              local Pred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1625,50,false,true)
              if Pred.HitChance >= 1 then
                CastSkillShot2(_Q, Pred.PredPos.x, Pred.PredPos.y, Pred.PredPos.z)
              end
          end, i)
      end
    end
-- Varus R
             if Config.R then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,false,true)
    local ult = (GetCastLevel(myHero,_R)*200)+(GetBonusAP(myHero)*.6)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1550) then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
            end
    end

end
end)
function LaneClearE()
   if IWalkConfig.LaneClear then
    for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
          if IsInDistance(Q, 650) then
            if Config.F then
-- Syndra cast W at Enemy
        local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _E) == READY then
            CastSkillShot(_E,EnemyPos.x,EnemyPos.y,EnemyPos.z)
    end
    end
end
end
end
end
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Varus Loaded</font>"))
end
if GetObjectName(GetMyHero()) == "Ziggs" then
--Menu
Config = scriptConfig("Ziggs", "Ziggs")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KsQ", "Use Q in KS", SCRIPT_PARAM_ONOFF, false)
Config.addParam("KsW", "Use W in KS", SCRIPT_PARAM_ONOFF, false)
Config.addParam("KsR", "Use R in KS", SCRIPT_PARAM_ONOFF, false)
Config.addParam("F", "LaneClear", SCRIPT_PARAM_ONOFF, true)
--Config.addParam("J", "JungleClear", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("H", "Use Q Harass", SCRIPT_PARAM_ONOFF, false)
Config.addParam("Z", "Use E Harass", SCRIPT_PARAM_ONOFF, false)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
LevelConfig = scriptConfig("Level", "Auto Level")
LevelConfig.addParam("L1","Max QE",SCRIPT_PARAM_ONOFF,false)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
--Start
OnLoop(function(myHero)
AutoIgnite()
LevelUp2()
Harass2()
Killsteal2()
--LaneClear2()
--JungleClear()
 -- Ziggs Q
 if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then
                 -- Ziggs Q

                         if Config.Q then
        if GetCastName(myHero, _Q) == "ZiggsQ" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero, _Q),50,true,true)
            if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1  then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
        -- Ziggs E
                 if GetCastName(myHero, _E) == "ZiggsE" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,900,50,true,true)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
    -- Ziggs W
   if GetCastName(myHero, _W) == "ZiggsW" then
            if Config.W then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,5300,50,false,true)
                          if (GetCurrentHP(unit)/GetMaxHP(unit))<0.3 and
                    CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsObjectAlive(myHero) and IsInDistance(unit, 1000) then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
-- Ziggs R
   if GetCastName(myHero, _R) == "ZiggsR" then
                 if Config.R then
        local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,5300,55,false,true)
        local ult = (GetCastLevel(myHero,_R)*100)+(GetBonusDmg(myHero)*1.5)
        if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1550) then
       if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                    end
                end
            end
    end
end
end
end)
function JungleClear2()
    for _,Q in pairs(GetAllMinions(MINION_JUNGLE)) do
          if IsInDistance(Q, 650) then
            if Config.J then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),Q,GetMoveSpeed(Q),1700,250,800,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
            if Config.Y then
            if CanUseSpell(myHero, _W) == READY then
            CastTargetSpell(Obj_AI_Minion, _W)
            end
        end
-- Ziggs cast W at Enemy
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),Q,GetMoveSpeed(Q),1700,250,925,50,false,true)
            if Config.Y then
            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
end
end
end
end
function LevelUp2()     
if LevelConfig.L1 then
if GetLevel(myHero) == 1 then
  LevelSpell(_Q)
elseif GetLevel(myHero) == 2 then
  LevelSpell(_E)
elseif GetLevel(myHero) == 3 then
  LevelSpell(_W)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 6 then
  LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
  LevelSpell(_Q)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 14 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 15 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 16 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 17 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_W)
end
end
end
end
function Killsteal2()
local unit = GetCurrentTarget()
 if ValidTarget(unit, 1550) then
        for i,enemy in pairs(GetEnemyHeroes()) do
                          local z = ((GetCastLevel(myHero,_Q)*45)+(GetBonusAP(myHero)*1))
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero, _Q),50,true,true)
if CanUseSpell(myHero, _Q) == READY and ValidTarget(enemy,GetCastRange(myHero,_Q)) and Config.KsQ 
  and CalcDamage(myHero, enemy, z) > GetCurrentHP(unit) then
 CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
   if GetCastName(myHero, _R) == "ZiggsR" then
                 if Config.KsR then
        local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,5300,55,false,true)
        local ult = (GetCastLevel(myHero,_R)*100)+(GetBonusDmg(myHero)*1.5)
        if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1550) then
       if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                    end
                end
            end
    end
-- Ziggs cast W at Enemy
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,925,50,true,true)
            if Config.KsW then
                 local ult = (GetCastLevel(myHero,_R)*35)+(GetBonusAP(myHero)*.5)
            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
end
end
function LaneClear2()
   if IWalkConfig.LaneClear then
    for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
         local EnemyPos = GetOrigin(Q)
          if IsInDistance(Q, 650) then
            if Config.F then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),Q,GetMoveSpeed(Q),1700,250,800,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .45 then
            CastSkillShot(_Q,EnemyPos.x,EnemyPos.y,EnemyPos.z)
            end
        end
-- Ziggs cast W at Enemy
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),Q,GetMoveSpeed(Q),1700,250,925,50,false,true)
            if CanUseSpell(myHero, _W) == READY and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .45 then
            CastSkillShot(_W,EnemyPos.x,EnemyPos.y,EnemyPos.z)
        end
    end
end
end
end

function Harass2()
                if IWalkConfig.Harass then
                if Config.H then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero, _Q),50,true,true)
            if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .45 then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end
    end
    if Config.Z then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,925,50,true,true)
            if CanUseSpell(myHero, _E) == READY and QPred.HitChance == 1 and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .45 then
            CastSkillShot(_E,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
        end
    end
end
    myHeroPos = GetOrigin(myHero)
DrawCircle(9022, 52.840878, 4360,80,1,1,0xffffffff)
DrawCircle(12060, 51, 4806,80,1,1,0xffffffff)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xffff00ff) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z, GetCastRange(myHero,_E) ,3,100,0xffff00ff) end
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawW then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_W),3,100,0xffff00ff) end
end
if GetObjectName(GetMyHero()) == "Syndra" then
    PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Syndra Loaded</font>"))
--Menu
Config = scriptConfig("Syndra", "Syndra")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KsQ", "Use Q in KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KsW", "Use W in KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("KsR", "Use R in KS", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "LaneClear", SCRIPT_PARAM_ONOFF, true)
--Config.addParam("J", "JungleClear", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("H", "Use Q Harass", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Y", "Use W Harass", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Stun", "Press to Stun", SCRIPT_PARAM_KEYDOWN, string.byte("T")) --Maxxel logic
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
LevelConfig = scriptConfig("Level", "Auto Level")
LevelConfig.addParam("L1","Max EQ",SCRIPT_PARAM_ONOFF,false)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawW","Draw W", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, true)
--Start
OnLoop(function(myHero)
AutoIgnite()
Stun()
LevelUp3()
Harass3()

Killsteal3()
LaneClear3()
--JungleClear()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1200) then
 
-- Syndra Q cast
    if GetCastName(myHero, _Q) == "SyndraQ" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,800,50,false,true)
            if Config.Q then
            if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
 
-- Syndra cast W on Minion
    if GetCastName(myHero, _W) == "SyndraW" then
            if Config.W then
            if CanUseSpell(myHero, _W) == READY then
            CastTargetSpell(Obj_AI_Minion, _W)
            end
        end
    end
-- Syndra cast W at Enemy
        if GetCastName(myHero, _W) == "SyndraW" then
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,925,50,true,true)
            if Config.W then
            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
-- Syndra PUSH
        if GetCastName(myHero, _E) == "SyndraE" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,700,50,true,true)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
-- Syndra Ultimate
if GetCastName(myHero, _R) == "SyndraR" then
            if Config.R then
        if unit ~= nil then
         local ult = (GetCastLevel(myHero,_R)*135)+(GetBonusAP(myHero)*.6)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 675) then
    if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
    CastTargetSpell(unit, _R)
                end
            end
        end
    end
end

end
end
end)
function JungleClear3()
    for _,Q in pairs(GetAllMinions(MINION_JUNGLE)) do
          if IsInDistance(Q, 650) then
            if Config.J then
    if GetCastName(myHero, _Q) == "SyndraQ" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),Q,GetMoveSpeed(Q),1700,250,800,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
        if GetCastName(myHero, _W) == "SyndraW" then
            if Config.Y then
            if CanUseSpell(myHero, _W) == READY then
            CastTargetSpell(Obj_AI_Minion, _W)
            end
        end
    end
-- Syndra cast W at Enemy
        if GetCastName(myHero, _W) == "SyndraW" then
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),Q,GetMoveSpeed(Q),1700,250,925,50,false,true)
            if Config.Y then
            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
end
end
end
end
function LevelUp3()     
if LevelConfig.L1 then
if GetLevel(myHero) == 1 then
  LevelSpell(_Q)
elseif GetLevel(myHero) == 2 then
  LevelSpell(_W)
elseif GetLevel(myHero) == 3 then
  LevelSpell(_E)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 6 then
  LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
  LevelSpell(_Q)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 14 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 15 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 16 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 17 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_E)
end
end
end
end
function Killsteal3()
local unit = GetCurrentTarget()
 if ValidTarget(unit, 1550) then
        for i,enemy in pairs(GetEnemyHeroes()) do
                          local z = ((GetCastLevel(myHero,_Q)*45)+(GetBonusAP(myHero)*1.6))
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,800,50,true,true)
if CanUseSpell(myHero, _Q) == READY and ValidTarget(enemy,GetCastRange(myHero,_Q)) and Config.KsQ 
  and CalcDamage(myHero, enemy, z) > GetCurrentHP(unit) then
 CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
        if GetCastName(myHero, _R) == "SyndraR" then
            if Config.KsR then
        if unit ~= nil then
         local ult = (GetCastLevel(myHero,_R)*135)+(GetBonusAP(myHero)*1.5)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 675) then
    if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
    CastTargetSpell(unit, _R)
                end
            end
        end
    end
end
            if GetCastName(myHero, _W) == "SyndraW" then
            if Config.KsW then
                 local ult = (GetCastLevel(myHero,_R)*40)+(GetBonusAP(myHero)*1)
            if CanUseSpell(myHero, _W) == READY then if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
            CastTargetSpell(Obj_AI_Minion, _W)
            end
        end
        end
    end
-- Syndra cast W at Enemy
        if GetCastName(myHero, _W) == "SyndraW" then
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,925,50,true,true)
            if Config.KsW then
                 local ult = (GetCastLevel(myHero,_R)*40)+(GetBonusAP(myHero)*1)

            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
                if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
        end
    end
end
end
function Stun()
local unit = GetCurrentTarget() --Maxxxel logic
local myHeroPos = GetOrigin(myHero)
    if Config.Stun then
        if ValidTarget(unit,1200) then
            local timea
            local distanceStun=0
            if timea~=nil and CanUseSpell(myHero, _Q) ~= READY and CanUseSpell(myHero, _E) ~= READY then
                timea=nil
            end
        ---Values---
            local enemyposition = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1200,50,true,true)
            enemyposx=enemyposition.PredPos.x
            enemyposy=enemyposition.PredPos.y
            enemyposz=enemyposition.PredPos.z
            local TargetPos = Vector(enemyposx,enemyposy,enemyposz)
            if GetDistance(unit)>=700 then
                distanceStun=GetDistance(unit)-700
            end
            if GetDistance(unit)<700 then
                distanceStun=0
            end
            local firePos = TargetPos-(TargetPos-myHeroPos)*(distanceStun/GetDistance(unit)) 
            local dPredict = GetDistance(myHero,firePosPoint)
        ---Values end---
            if CanUseSpell(myHero, _Q) == READY and CanUseSpell(myHero, _E) == READY and timea==nil then
                if dPredict < 1200 then
                    CastSkillShot(_Q,firePos.x,0,firePos.z)
                    timea = GetTickCount()
                end
            end
            if CanUseSpell(myHero, _E) == READY and timea~=GetTickCount() then
                    CastSkillShot(_E,firePos.x,0,firePos.z)
            end
        end
        Move()
    end
    end
    function Move()
    local movePos = GenerateMovePos()
    if GetDistance(GetMousePos()) > GetHitBox(myHero) then
        MoveToXYZ(movePos.x, 0, movePos.z)
    end
    end
function LaneClear3()
   if IWalkConfig.LaneClear then
    for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do

          if IsInDistance(Q, 700) then
            if Config.F then
    if GetCastName(myHero, _Q) == "SyndraQ" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),Q,GetMoveSpeed(Q),1700,250,800,50,false,true)
        local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _Q) == READY then
            CastSkillShot(_Q,EnemyPos.x,EnemyPos.y,EnemyPos.z)
            end
        end
    end
        if GetCastName(myHero, _W) == "SyndraW" then
local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _W) == READY then
            CastTargetSpell(Obj_AI_Minion, _W)
            end
        end

-- Syndra cast W at Enemy
        if GetCastName(myHero, _W) == "SyndraW" then
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),Q,GetMoveSpeed(Q),1700,250,925,50,false,true)
local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _W) == READY then
            CastSkillShot(_W,EnemyPos.x,EnemyPos.y,EnemyPos.z)
            end
        end

end
end
end
end

function Harass3()
                if IWalkConfig.Harass then
                if Config.H then
    if GetCastName(myHero, _Q) == "SyndraQ" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,800,50,true,true)
            if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .45 then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
        if GetCastName(myHero, _W) == "SyndraW" then
            if Config.Y then
            if CanUseSpell(myHero, _W) == READY and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .45 then
            CastTargetSpell(Obj_AI_Minion, _W)
            end
        end
    end
-- Syndra cast W at Enemy
        if GetCastName(myHero, _W) == "SyndraW" then
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,925,50,true,true)
            if Config.Y then
            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .45 then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
end
    myHeroPos = GetOrigin(myHero)
DrawCircle(9022, 52.840878, 4360,80,1,1,0xffffffff)
DrawCircle(12060, 51, 4806,80,1,1,0xffffffff)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xffff00ff) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z, GetCastRange(myHero,_E) ,3,100,0xffff00ff) end
if CanUseSpell(myHero, _W) == READY and DrawingsConfig.DrawW then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_W),3,100,0xffff00ff) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z, GetCastRange(myHero,_R) ,3,100,0xffff00ff) end
end
-- kalista
if GetObjectName(GetMyHero()) == "Kalista" then
--Menu
Config = scriptConfig("Kalista", "Kalista")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Rs", "Use R Save", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "E Clear", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Z", "Spam E", SCRIPT_PARAM_KEYDOWN, string.byte("C"))
Config.addParam("M", "Execute Jungle", SCRIPT_PARAM_ONOFF, true)
Config.addParam("N", "Auto E Kill", SCRIPT_PARAM_ONOFF, true)
Config.addParam("I", "KS Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("G", "Send Ghost", SCRIPT_PARAM_KEYDOWN, string.byte("T"))
Config.addParam("X", "Wall Jump 1", SCRIPT_PARAM_KEYDOWN, string.byte("L"))
Config.addParam("Y", "Wall Jump 2", SCRIPT_PARAM_KEYDOWN, string.byte("K"))
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
ItemsConfig = scriptConfig("Items", "Items")
ItemsConfig.addParam("I4","Use QSS",SCRIPT_PARAM_ONOFF,true)
LevelConfig = scriptConfig("Level", "Auto Level")
LevelConfig.addParam("L1","Max EQ",SCRIPT_PARAM_ONOFF,false)
LevelConfig.addParam("L2","Max EW",SCRIPT_PARAM_ONOFF,false)
DrawingsConfig = scriptConfig("Drawings", "Drawings")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawE","Draw E", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawDMG", "Draw Damage", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawQW", "Draw Wall Jump", SCRIPT_PARAM_ONOFF, true)
--Start
OnLoop(function(myHero)
Killsteal()
AutoIgnite()
Drawings()
LevelUpMeleeSupport()
LevelUp() 
LaneClear()
JungleClear()
Ghost()
WallJump()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then

if DrawingsConfig.DrawDMG then
local hp  = GetCurrentHP(unit)
local dmg = 0
local targetPos = GetOrigin(unit)
local drawPos = WorldToScreen(1,targetPos.x,targetPos.y,targetPos.z)
    if CanUseSpell(myHero, _Q) == READY then
      local Dmgz = GetBonusDmg(myHero)+GetBaseDamage(myHero)
          dmg = dmg + CalcDamage(myHero, unit, GotBuff(unit,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + (Dmgz * 0.6)) + (GotBuff(unit,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*Dmgz) or 0)
    end
    if CanUseSpell(myHero, _E) == READY then
      dmg = dmg + CalcDamage(myHero, unit, 0, 10 + 10*GetCastLevel(myHero,_E) + 0.6*GetBonusDmg(myHero))
    end
    if dmg > hp then
      DrawText("Killable",20,drawPos.x,drawPos.y,0xffffffff)
      DrawDmgOverHpBar(unit,hp,0,hp,0xffffffff)
    else
      DrawText(math.floor(100 * dmg / hp).."%",20,drawPos.x,drawPos.y,0xffffffff)
      DrawDmgOverHpBar(unit
      ,hp,0,dmg,0xffffffff)
    end
end
if GetItemSlot(myHero,3140) > 0 and ItemsConfig.I4 and GotBuff(myHero, "Stun") == 1 then
CastTargetSpell(unit, GetItemSlot(myHero,3140))
end
if GetItemSlot(myHero,3139) > 0 and ItemsConfig.I4 and GotBuff(myHero, "Stun") == 1 then
CastTargetSpell(unit, GetItemSlot(myHero,3139))
end
                 if Config.Q then
                                             local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1150,50,true,true)
            if CanUseSpell(myHero, _Q) == READY then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
                                  --kalista E
                 
              if Config.E then
   local Dmgz= GetBonusDmg(myHero)+GetBaseDamage(myHero)
 local dmg = (GotBuff(unit,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + (Dmgz * 0.6)) + (GotBuff(unit,"kalistaexpungemarker")-1) * (GetCastLevel(myHero,_E) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*Dmgz) or 0)
   if CalcDamage(myHero, unit, dmg) > GetCurrentHP(unit)  then
                  if CanUseSpell(myHero,_E) == READY then
                    CastSpell(_E)
                  end
                end
              end
                if IWalkConfig.Harass then
                if Config.Z then
              if GotBuff(unit,"kalistaexpungemarker") > 4 then
                if CanUseSpell(myHero,_E) == READY and IsInDistance(unit, 1200) then
                  CastSpell(_E)
                end
              end
            end
        end
    -- Cast R
            if Config.R then
                  if (GetCurrentHP(unit)/GetMaxHP(unit))<0.6 and
                    IsObjectAlive(unit) and
                   CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1200) and EnemiesAround(GetMyHeroPos(), 1400) >= 2 then
            CastSpell(_R)
            end
        end
end
end
end)
-- LanClear
function LaneClear()
if IWalkConfig.LaneClear then
      if Config.F then
       for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
          if IsInDistance(Q, 650) then
            local Dmgz = GetBonusDmg(myHero)+GetBaseDamage(myHero)
            local dmg = (GotBuff(Q,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + (Dmgz * 0.6)) + (GotBuff(Q,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*Dmgz) or 0)
            local hp = GetCurrentHP(Q)
            local Dmg = CalcDamage(myHero, Q, dmg)
            if Dmg > hp then
            if CanUseSpell(myHero,_E) == READY and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .35 then
            CastSpell(_E) 
           end
        end
     end
  end
end
end
end
function Ghost() 
if Config.G then
if CanUseSpell(myHero, _W) == READY then
CastSkillShot(_W,10092.000000, -71.240601, 4452.000000)
end
end
end
          function WallJump()
           local HeroPos = GetOrigin(myHero)
        if Config.X and HeroPos.x == 11972 and HeroPos.z == 4708 then                
                          CastSkillShot(_Q,11572, -71.240601, 4102)  
                          MoveToXYZ(11572, -71.240601, 4102) 
                          elseif Config.X then 
                             MoveToXYZ(11972, 59.729401, 4708)  

    end
        if Config.Y and HeroPos.x == 9022 and HeroPos.z == 4360 then                
                          CastSkillShot(_Q,9744, -71.240601, 4654)  
                          MoveToXYZ(9634, -71.240601, 4544) 
                          elseif Config.Y then 
                             MoveToXYZ(9022, 52.840878, 4360)  
                               
    end
    end
          function JungleClear()
                  if IWalkConfig.JungleClear then
                  if Config.M then
       for _,Q in pairs(GetAllMinions(MINION_JUNGLE)) do
          if IsInDistance(Q, 650) then
            local Dmgz = GetBonusDmg(myHero)+GetBaseDamage(myHero)
            local dmg = (GotBuff(Q,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + (Dmgz * 0.6)) + (GotBuff(Q,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*Dmgz) or 0)
            local hp = GetCurrentHP(Q)
            local Dmg = CalcDamage(myHero, Q, dmg)
            if Dmg > hp then
            if CanUseSpell(myHero,_E) == READY and (GetCurrentMana(myHero)/GetMaxMana(myHero)) > .35 then
            CastSpell(_E) 
           end
        end
    end
     end
  end
end
end
function Killsteal()
local unit = GetCurrentTarget()
 if ValidTarget(unit, 1550) then
        for i,enemy in pairs(GetEnemyHeroes()) do
                          local z = ((GetCastLevel(myHero,_Q)*30)+(GetBonusDmg(myHero)*1.9))
if CanUseSpell(myHero, _Q) == READY and ValidTarget(enemy,GetCastRange(myHero,_Q)) and Config.I 
  and (GetCastLevel(myHero,_Q)*60)+(GetBonusDmg(myHero)*1) and CalcDamage(myHero, enemy, z) > GetCurrentHP(unit) then
    CastTargetSpell(enemy, _Q)
            end
        end
        if Config.N then
   local Dmgz= GetBonusDmg(myHero)+GetBaseDamage(myHero)
 local dmg = (GotBuff(unit,"kalistaexpungemarker") > 0 and (10 + (10 * GetCastLevel(myHero,_E)) + (Dmgz * 0.6)) + (GotBuff(unit,"kalistaexpungemarker")-1) * (kalE(GetCastLevel(myHero,_E)) + (0.175 + 0.025 * GetCastLevel(myHero,_E))*Dmgz) or 0)
   if CalcDamage(myHero, unit, dmg) > GetCurrentHP(unit)  then
                  if CanUseSpell(myHero,_E) == READY then
                    CastSpell(_E)
                  end
                end
              end
end
end
function LevelUpMeleeSupport()     
if LevelConfig.L2 then
if GetLevel(myHero) == 1 then
  LevelSpell(_E)
elseif GetLevel(myHero) == 2 then
  LevelSpell(_W)
elseif GetLevel(myHero) == 3 then
  LevelSpell(_Q)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 6 then
  LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
  LevelSpell(_E)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 14 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 15 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 16 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 17 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_Q)
end
end
end
function LevelUp()     
if LevelConfig.L1 then
if GetLevel(myHero) == 1 then
  LevelSpell(_E)
elseif GetLevel(myHero) == 2 then
  LevelSpell(_Q)
elseif GetLevel(myHero) == 3 then
  LevelSpell(_W)
elseif GetLevel(myHero) == 4 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 5 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 6 then
  LevelSpell(_R)
elseif GetLevel(myHero) == 7 then
  LevelSpell(_E)
elseif GetLevel(myHero) == 8 then
        LevelSpell(_E)
elseif GetLevel(myHero) == 9 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 10 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 11 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 12 then
        LevelSpell(_Q)
elseif GetLevel(myHero) == 13 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 14 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 15 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 16 then
        LevelSpell(_R)
elseif GetLevel(myHero) == 17 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_W)
end
end
end
function kalE(x) if x <= 1 then return 10 else return kalE(x-1) + 2 + x end end -- Insipireds code.
function Drawings()
myHeroPos = GetOrigin(myHero)
DrawCircle(9022, 52.840878, 4360,80,1,1,0xffffffff)
DrawCircle(12060, 51, 4806,80,1,1,0xffffffff)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xffff00ff) end
if CanUseSpell(myHero, _E) == READY and DrawingsConfig.DrawE then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z, GetCastRange(myHero,_E) ,3,100,0xffff00ff) end
end
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Kalista Loaded</font>"))
end
-- Vi
if GetObjectName(GetMyHero()) == "Vi" then
--Menu
Config = scriptConfig("Vi", "Vi")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
if Config.Combo and waitTickCount < GetTickCount() then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then
                 
                 
    local target = GetTarget(725, DAMAGE_PHYSICAL) -- Q from Deftsu
    if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, 725) and Config.Q then
      local myHeroPos = GetMyHeroPos()
      CastSkillShot(_Q, myHeroPos.x, myHeroPos.y, myHeroPos.z)
      for i=250, 725, 250 do
        DelayAction(function()
            local _Qrange = 225 + math.min(225, i/2)
              local Pred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),math.huge,600,_Qrange,100,true,true)
              if Pred.HitChance >= 1 then
                CastSkillShot2(_Q, Pred.PredPos.x, Pred.PredPos.y, Pred.PredPos.z)
              end
          end, i)
      end
    end
                                  --Vi E
                 
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 175) then
            CastSpell(_E)
            end
        end
    -- Cast R
            if Config.R then
                  if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 800) then
            CastTargetSpell(unit, _R)
            end
        end
end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Vi Loaded</font>"))
end
-- Yasuo
if GetObjectName(GetMyHero()) == "Yasuo" then
--Menu
Config = scriptConfig("Yasuo", "Yasuo")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "E to Minion (Combo)", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
  local unit = GetCurrentTarget()
AutoIgnite()
if Config.Combo then
if ValidTarget(unit, 1550) then
                 -- Gang Q

                         if Config.Q then
                          local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero, _Q),50,false,true)
if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 1200) and QPred.HitChance == 1 then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                end
            end
        -- Yasuo E
                 if GetCastName(myHero, _E) == "YasuoDashWrapper" then
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 475) then
            CastTargetSpell(unit,_E)
            end
        end
    end
-- Yasuo R
            if Config.R then
                    local ult = (GetCastLevel(myHero,_R)*100)+(GetBonusDmg(myHero)*1.50)
                   if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) and CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 1200) then
            CastSpell(_R)
            end
        end
    end
end
end)

OnLoop(function(myHero)
if Config.Combo then
      if Config.F then
      for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
 local unit = GetCurrentTarget()
 if unit == nil then return end
 if IsInDistance(Q, 750) or IsInDistance(unit, 750) then
        local targetPos = GetOrigin(Q)
        local drawPos = WorldToScreen(1,targetPos.x,targetPos.y,targetPos.z)
        local hp = GetCurrentHP(Q)
        local Dmg = CalcDamage(myHero, Q, GetBonusDmg(myHero)+GetBaseDamage(myHero))
        local unit = GetCurrentTarget()
            if Dmg < hp or Dmg > hp then
              elseif GotBuff(unit, "YasuoDashWrapper") > 1 then return end
        if GetCastName(myHero, _E) == "YasuoDashWrapper" then
if CanUseSpell(myHero, _E) == READY then
    CastTargetSpell(Q,_E)
                end
end
            end
        end
          end

      end
    end)
OnProcessSpell(function(unit, spell) -- All of this is from ispired
  myHero = GetMyHero()
  if Config.W and unit and GetTeam(unit) ~= GetTeam(myHero) and GetObjectType(unit) == GetObjectType(myHero) and GetDistance(unit) < 1500 then
    if myHero == spell.target and spell.name:lower():find("attack") and GetRange(unit) >= 450 and CalcDamage(unit, myHero, GetBonusDmg(unit)+GetBaseDamage(unit))/GetCurrentHP(myHero) > 0.1337 then
      local wPos = GenerateWallPos(GetOrigin(unit))
      CastSkillShot(_W, wPos.x, wPos.y, wPos.z)
    elseif spell.endPos then
      local makeUpPos = GenerateSpellPos(GetOrigin(unit), spell.endPos, GetDistance(unit, myHero))
      if GetDistanceSqr(makeUpPos) < (GetHitBox(myHero)*3)^2 or GetDistanceSqr(spell.endPos) < (GetHitBox(myHero)*3)^2 then
        local wPos = GenerateWallPos(GetOrigin(unit))
        CastSkillShot(_W, wPos.x, wPos.y, wPos.z)
      end
    end
  end
end)
function GenerateWallPos(unitPos)
    local tV = {x = (unitPos.x-GetMyHeroPos().x), z = (unitPos.z-GetMyHeroPos().z)}
    local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
    return {x = GetMyHeroPos().x + 400 * tV.x / len, y = 0, z = GetMyHeroPos().z + 400 * tV.z / len}
end

function GenerateSpellPos(unitPos, spellPos, range)
    local tV = {x = (spellPos.x-unitPos.x), z = (spellPos.z-unitPos.z)}
    local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
    return {x = unitPos.x + range * tV.x / len, y = 0, z = unitPos.z + range * tV.z / len}
end -- Inspireds END
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Yasuo Loaded</font>"))
end
-- Sona
if GetObjectName(GetMyHero()) == "Sona" then
--Menu
Config = scriptConfig("Sona", "Sona")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
       local unit = GetCurrentTarget()
                if Config.W then
                for _, ally in pairs(GetAllyHeroes()) do
            if Config.W then
            if (GetCurrentHP(ally)/GetMaxHP(ally))<0.6 and
                    CanUseSpell(myHero, _W) == READY and IsInDistance(ally, 1000) and IsObjectAlive(ally) then
            CastSpell(_W)
        end
    end
end
end
    if GetCastName(myHero, _W) == "SonaW" then
            if Config.W then
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.5 and
                    CanUseSpell(myHero, _W) == READY and IsObjectAlive(myHero) then
            CastSpell(_W)
            end
        end
    end
AutoIgnite()
if Config.Combo then
if ValidTarget(unit, 1550) then
                 -- Sona Q
                         if Config.Q then
        if GetCastName(myHero, _Q) == "SonaQ" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,260,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 850) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
            end
        end
    end
                     -- Sona R
                         if Config.R then
        if GetCastName(myHero, _R) == "SonaR" then
        local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1000,50,false,true)
             if (GetCurrentHP(unit)/GetMaxHP(unit))<0.6 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(myHero) and IsInDistance(unit, 1000) then
            CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z) 
            end
        end
    end
end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Sona Loaded</font>"))
end
--Khazix
if GetObjectName(GetMyHero()) == "Khazix" then
--Menu
Config = scriptConfig("Khazix", "Khazix")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1700) then

    -- Khazix E
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero,_E),50,false,true)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
                         -- Khazix Q
            if Config.Q then
                 if CanUseSpell(myHero, _Q) == READY and IsObjectAlive(unit) and IsInDistance(unit, 325) then
            CastTargetSpell(unit,_Q)
            end
        end
-- Khazix Q
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,600,50,true,true)
            if Config.W then
            if CanUseSpell(myHero, _W) == READY and IsInDistance(unit, 1000) and WPred.HitChance == 1 then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Khazix Loaded</font>"))
end
--Rumble
if GetObjectName(GetMyHero()) == "Rumble" then
--Menu
Config = scriptConfig("Rumble", "Rumble")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1700) then

-- Rumble Q
        if GetCastName(myHero, _Q) == "RumbleFlameThrower" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,600,50,false,true)
            if Config.Q then
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 600) and QPred.HitChance == 1 then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
    -- Rumble E
        if GetCastName(myHero, _E) == "RumbleGrenade" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,850,50,true,true)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 850) and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
-- Rumble R
        local myorigin = GetOrigin(unit)
local mymouse = GetCastRange(myHero,_R) 
if Config.R then
 local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1700,55,false,true)
if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1700) then 
    CastSkillShot3(_R,myorigin,EPred)
end
end
        local myorigin = GetOrigin(unit)
local mymouse = GetCastRange(myHero,_R) 
if Config.R then
 local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1700,55,false,true)
if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1700) then 
    CastSkillShot3(_R,myorigin,EPred)
end
end
end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Rumble Loaded</font>"))
end
-- Alistar
if GetObjectName(GetMyHero()) == "Alistar" then
--Menu
Config = scriptConfig("Alistar", "Alistar")
Config.addParam("QW", "Use QW Combo", SCRIPT_PARAM_ONOFF, false)
Config.addParam("WQ", "Use WQ Combo", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
       local unit = GetCurrentTarget()
    if GetCastName(myHero, _R) == "FerociousHowl" then
            if Config.R then
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.4 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(myHero) and IsInDistance(unit, 1000) then
            CastSpell(_R)
            end
        end
    end
                for _, ally in pairs(GetAllyHeroes()) do
            if Config.E then
            if (GetCurrentHP(ally)/GetMaxHP(ally))<0.7 and
                    CanUseSpell(myHero, _E) == READY and IsInDistance(ally, 575) and IsObjectAlive(ally) then
            CastSpell(_E)
        end
    end
end
    if GetCastName(myHero, _E) == "TriumphantRoar" then
            if Config.E then
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.7 and
                    CanUseSpell(myHero, _E) == READY and IsObjectAlive(myHero) and IsInDistance(unit, 1000) then
            CastSpell(_E)
            end
        end
    end
AutoIgnite()
if Config.Combo then
if ValidTarget(unit, 1550) then
                    -- Alistar W
   if GetCastName(myHero, _W) == "Headbutt" then
            if Config.WQ then
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsInDistance(unit, 650) then
           CastTargetSpell(unit, _W)
            end
        end
    end
                 -- Alistar Q
                         if Config.WQ then
        if GetCastName(myHero, _Q) == "Pulverize" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,260,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 365) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
            end
        end
    end
                     -- Alistar Q
                         if Config.QW then
        if GetCastName(myHero, _Q) == "Pulverize" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,260,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 365) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
            end
        end
    end
                        -- Alistar W
   if GetCastName(myHero, _W) == "Headbutt" then
            if Config.QW then
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsInDistance(unit, 300) then
           CastTargetSpell(unit, _W)
            end
        end
    end
end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Alistar Loaded</font>"))
end
-- Leona
if GetObjectName(GetMyHero()) == "Leona" then
--Menu
Config = scriptConfig("Leona", "Leona")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
LeonaW()
local unit = GetCurrentTarget()
if Config.Combo then
if ValidTarget(unit, 1550) then
                 
                                                  -- Leona Q
                         if Config.Q then
        if GetCastName(myHero, _Q) == "LeonaShieldOfDaybreak" then
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 625) then
                        CastTargetSpell(unit,_Q)
            end
        end
    end
                                  --Leona E 
                 if Config.E then
                 if GetCastName(myHero, _E) == "LeonaZenithBlade" then
                local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero,_E),50,false,true)
                 if CanUseSpell(myHero, _E) == READY and IsObjectAlive(unit) and IsInDistance(unit, 700)  then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
                     -- Leona R
                     if Config.R then
                 if GetCastName(myHero, _R) == "LeonaSolarFlare" then
                local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero,_R),50,false,true)
                if (GetCurrentHP(unit)/GetMaxHP(unit))<0.8 and
                 CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 1100) then
            CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
            end
        end
    end
end
end
end)
function LeonaW()
        if GetCastName(myHero, _W) == "LeonaSolarBarrier" then
            if Config.W then
                local unit = GetCurrentTarget()
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.75 and
                    CanUseSpell(myHero, _W) == READY and GotBuff(myHero, "recall") == 0 then
            CastTargetSpell(myHero, _W)
            end
        end
    end
end
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Leona Loaded</font>"))
end
-- Swain
if GetObjectName(GetMyHero()) == "Swain" then
--Menu
Config = scriptConfig("Swain", "Swain")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
       local unit = GetCurrentTarget()
    if GetCastName(myHero, _R) == "SwainMetamorphism" then
            if Config.R then
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.3 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(myHero) and IsInDistance(unit, 1000) then
            CastTargetSpell(myHero,_R)
            end
        end
    end
AutoIgnite()
if Config.Combo then
if ValidTarget(unit, 1550) then
                 
                                                  -- Swain Q
                         if Config.Q then
        if GetCastName(myHero, _Q) == "SwainDecrepify" then
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 625) then
                        CastTargetSpell(unit,_Q)
            end
        end
    end
                                  --Swain E 
                 if Config.E then
                 if GetCastName(myHero, _E) == "SwainTorment" then
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 625) then
            CastTargetSpell(unit,_E)
            end
        end
    end
                     -- Swain W
   if Config.W then
   if GetCastName(myHero, _W) == "SwainShadowGrasp" then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero,_W),50,false,true)
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsInDistance(unit, 625)  then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
                     if Config.R then
                 if GetCastName(myHero, _R) == "SwainMetamorphism" then
                local ult = (GetCastLevel(myHero,_R)*50+130)+(GetBonusAP(myHero)*.2)
                if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 700) then
            CastTargetSpell(myHero, _R)
            end
        end
    end
end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Swain Loaded</font>"))
end
-- Gnar
if GetObjectName(GetMyHero()) == "Gnar" then
--Menu
Config = scriptConfig("Gnar", "Gnar")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
--Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Q2", "Use Q2", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W2", "Use W2", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E2", "Use E2", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
if Config.Combo then
local mymouse = GetMousePos()
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then
                 
                                                  -- Gnar Q
                         if Config.Q then
        if GetCastName(myHero, _Q) == "GnarQ" then
            local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1100,50,true,true)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 1100) then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
                                  --Gnar E gnarbigqwe
                 if Config.E then
                 if GetCastName(myHero, _E) == "GnarE" then
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 1100) then
            CastSkillShot(_E, GetMousePos().x, GetMousePos().y, GetMousePos().z)
            end
        end
    end
                     -- Gnar W
   if Config.W2 then
   if GetCastName(myHero, _W) == "gnarbigw" then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,GetCastRange(myHero,_W),50,false,true)
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and ValidTarget(unit, GetCastRange(myHero,_W)) then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
                             if Config.Q2 then
        if GetCastName(myHero, _Q) == "gnarbigq" then
            local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1100,50,true,true)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 1100) then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
                     if Config.E2 then
                 if GetCastName(myHero, _E) == "gnarbige" then
                    local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,475,50,false,true)
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 1100) then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
    
end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Gnar Loaded</font>"))
end
-- Udyr
if GetObjectName(GetMyHero()) == "Udyr" then
--Menu
Config = scriptConfig("Udyr", "Udyr")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then
                 
                                  --Udyr E
                 if GetCastName(myHero, _E) == "UdyrBearStance" then
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 125) then
            CastTargetSpell(myHero,_E)
            end
        end
    end
                 -- Udyr Q
                         if Config.Q then
        if GetCastName(myHero, _Q) == "UdyrTigerStance" then
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 125) then
                        CastTargetSpell(myHero,_Q)
            end
        end
    end
                     -- Udyr W
   if GetCastName(myHero, _W) == "UdyrTurtleStance" then
            if Config.W then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,900,50,false,true)
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsInDistance(unit, 125) then
            CastTargetSpell(myHero,_W)
            end
        end
    end
    -- Cast R
   if GetCastName(myHero, _R) == "UdyrPhoenixStance" then
            if Config.R then
                  if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 250) then
            CastTargetSpell(myHero, _R)
            end
        end
    end
end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Udyr Loaded</font>"))
end
-- Brand
if GetObjectName(GetMyHero()) == "Brand" then
--Menu
Config = scriptConfig("Brand", "Brand")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then
                 
                                  --Brand E
                 if GetCastName(myHero, _E) == "BrandConflagration" then
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 625) then
            CastTargetSpell(unit,_E)
            end
        end
    end
                 -- Brand Q
                         if Config.Q then
        if GetCastName(myHero, _Q) == "BrandBlaze" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1050,50,true,true)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 1050) and GotBuff(unit, "brandablaze") == 1 then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
                     -- Brand W
   if GetCastName(myHero, _W) == "BrandFissure" then
            if Config.W then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,900,50,false,true)
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsInDistance(unit, 900) then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
    -- Cast R
   if GetCastName(myHero, _R) == "BrandWildfire" then
            if Config.R then
                local ult = (GetCastLevel(myHero,_R)*100)+(GetBonusAP(myHero)*.50)
                if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 750) then
            CastTargetSpell(unit, _R)
            end
        end
    end
end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Brand Loaded</font>"))
end
-- Fiora
if GetObjectName(GetMyHero()) == "Fiora" then
--Menu
Config = scriptConfig("Fiora", "Fiora")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then
                 
                 -- Fiora Q
                         if Config.Q then
        if GetCastName(myHero, _Q) == "FioraQ" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,400,50,false,true)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 400) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            end
        end
    end
                     -- Fiora W
   if GetCastName(myHero, _W) == "FioraW" then
            if Config.W then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,750,50,false,true)
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsInDistance(unit, 750) then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
                 --Fiora E
                 if GetCastName(myHero, _E) == "FioraE" then
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 260) then
            CastTargetSpell(myHero,_E)
            end
        end
    end
    -- Cast R
   if GetCastName(myHero, _R) == "FioraR" then
            if Config.R then
                if (GetCurrentHP(unit)/GetMaxHP(unit))<0.4 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 500) then
            CastTargetSpell(unit, _R)
            end
        end
    end
end
end
end)
OnProcessSpell(function(unit, spell) -- Modified Yasuo Wall Code 
  myHero = GetMyHero()
  if Config.W and unit and GetTeam(unit) ~= GetTeam(myHero) and GetObjectType(unit) == GetObjectType(myHero) and GetDistance(unit) < 1500 then
    if myHero == spell.target and spell.name:lower():find("attack") and GetRange(unit) >= 450 and CalcDamage(unit, myHero, GetBonusDmg(unit)+GetBaseDamage(unit))/GetCurrentHP(myHero) > 0.1337 then
      local wPos = GenerateWPos(GetOrigin(unit))
      CastSkillShot(_W, wPos.x, wPos.y, wPos.z)
    elseif spell.endPos then
      local makeUpPos = GenerateSpellPos(GetOrigin(unit), spell.endPos, GetDistance(unit, myHero))
      if GetDistanceSqr(makeUpPos) < (GetHitBox(myHero)*3)^2 or GetDistanceSqr(spell.endPos) < (GetHitBox(myHero)*3)^2 then
        local wPos = GenerateWPos(GetOrigin(unit))
        CastSkillShot(_W, wPos.x, wPos.y, wPos.z)
      end
    end
  end
end)
function GenerateWPos(unitPos)
    local tV = {x = (unitPos.x-GetMyHeroPos().x), z = (unitPos.z-GetMyHeroPos().z)}
    local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
    return {x = GetMyHeroPos().x + 400 * tV.x / len, y = 0, z = GetMyHeroPos().z + 400 * tV.z / len}
end

function GenerateSpellPos(unitPos, spellPos, range)
    local tV = {x = (spellPos.x-unitPos.x), z = (spellPos.z-unitPos.z)}
    local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
    return {x = unitPos.x + range * tV.x / len, y = 0, z = unitPos.z + range * tV.z / len}
end --  END of AUTOPARRY
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Fiora Loaded</font>"))
end

-- Riven
if GetObjectName(GetMyHero()) == "Riven" then
--Menu
Config = scriptConfig("Riven", "Riven")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then
                 --Riven E
                 if GetCastName(myHero, _E) == "RivenFeint" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,325,50,true,true)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z) 
            end
        end
    end
                 -- Riven Q
                         if Config.Q then
        if GetCastName(myHero, _Q) == "RivenTriCleave" then
        local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,260,50,false,true)
        DelayAction(function() AttackUnit(unit) end, 1800)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 260) then
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z) 
            end
        end
    end
    -- Riven W
   if GetCastName(myHero, _W) == "RivenMartyr" then
            if Config.W then
                local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,125,50,false,true)
                 if CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsInDistance(unit, 125) then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
    -- Cast R
   if GetCastName(myHero, _R) == "RivenFengShuiEngine" then
            if Config.R then
                if (GetCurrentHP(unit)/GetMaxHP(unit))<0.3 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 900) then
            CastTargetSpell(myHero, _R)
            end
        end
    end
    --Cast R windslash
       if GetCastName(myHero, _R) == "rivenizunablade" then
            if Config.R then
                local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,900,50,false,true)
                     if (GetCurrentHP(unit)/GetMaxHP(unit))<0.4 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 900) then
            CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
            end
        end
    end
end
end
end)

OnProcessSpell(function(unit, spell)
local unit = GetCurrentTarget()
if unit and unit == myHero and spell and spell.name and spell.name:lower():find("attack") then
if Config.Combo and ValidTarget(unit) then
local targetPos = GetOrigin(unit)
DelayAction(function() CastSkillShot(_Q, targetPos.x, targetPos.y, targetPos.z) end, spell.windUpTime * 800)
end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Riven Loaded</font>"))
end

-- Gangplank
if GetObjectName(GetMyHero()) == "Gangplank" then
--Menu
Config = scriptConfig("Gangplank", "Gangplank")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "LastHit", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
  local unit = GetCurrentTarget()
  --Auto heal if under or 30% HP AND ENEMY IS IN 1000 RANGE.
   if GetCastName(myHero, _W) == "GangplankW" then
            if Config.R then
                          if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.3 and
                    CanUseSpell(myHero, _W) == READY and IsObjectAlive(unit) and IsInDistance(unit, 1000) then
            CastTargetSpell(myHero, _W)
            end
        end
    end
       -- Auto R (ks)
       if GetCastName(myHero, _R) == "GangplankR" then
            if Config.R then
                                local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,10000,50,false,true)
                          if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.2 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 10000) then
            CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
            end
        end
    end
AutoIgnite()
QFarm()
if Config.Combo then
if ValidTarget(unit, 1550) then
                 -- Gang Q

                         if Config.Q then
        if GetCastName(myHero, _Q) == "GangplankQWrapper" then
if CanUseSpell(myHero, _Q) == READY then
    CastTargetSpell(unit ,_Q)
                end
            end
        end
        -- Gangplank E
                 if GetCastName(myHero, _E) == "GangplankE" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1000,50,false,true)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
-- Gangplank R
   if GetCastName(myHero, _R) == "GangplankR" then
            if Config.R then
                local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,10000,50,false,true)
                     if (GetCurrentHP(unit)/GetMaxHP(unit))<0.2 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(unit) and IsInDistance(unit, 10000) then
            CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
            end
        end
    end
end
end
end)
function QFarm()
if IWalkConfig.LastHit then
      if Config.F then
      for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
        if IsInDistance(Q, 750) then
        local z = (GetCastLevel(myHero,_Q)*25)+(GetBonusDmg(myHero)*1.7)
        local hp = GetCurrentHP(Q)
        local Dmg = CalcDamage(myHero, Q, z)
        if Dmg > hp then
if CanUseSpell(myHero, _Q) == READY then
    CastTargetSpell(Q,_Q)
            end
        end
          end
        end
        end
      end
    end
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Gangplank Loaded</font>"))
end

-- Irelia
if GetObjectName(GetMyHero()) == "Irelia" then
--Menu
Config = scriptConfig("Irelia", "Irelia")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Es", "Use E Stun", SCRIPT_PARAM_ONOFF, false)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("F", "LastHit", SCRIPT_PARAM_ONOFF, true)
Config.addParam("G", "KS Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
Killsteal4()
AutoIgnite()
QFamr()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then
                 -- Irelia Q
                 if Config.Q then
        if GetCastName(myHero, _Q) == "IreliaGatotsu" then
if CanUseSpell(myHero, _Q) == READY then
    CastTargetSpell(unit,_Q)
                end
            end
        end
        -- Irelia E
             if Config.E then
if GetCastName(myHero, _E) == "IreliaEquilibriumStrike" then
    if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 325) then
    CastTargetSpell(unit,_E)
                end
            end
end
        -- Irelia E
             if Config.Es then
if GetCastName(myHero, _E) == "IreliaEquilibriumStrike" then
    if (GetCurrentHP(myHero) < GetCurrentHP(unit)) and CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 325) then
    CastTargetSpell(unit,_E)
                end
            end
end
    if Config.W then
        if GetCastName(myHero, _W) == "IreliaHitenStyle" then
if CanUseSpell(myHero, _W) == READY  and IsInDistance(unit, 325) then
    CastTargetSpell(unit,_W)
                end
            end
        end
-- Irelia R
       if Config.R then
        if GetCastName(myHero, _R) == "IreliaTranscendentBlades" then
        local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1000,55,false,true)
if (GetCurrentHP(unit)/GetMaxHP(unit))<0.3 and IsObjectAlive(unit) and CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1000)  then
     CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
    end
    end
end
end
end)
function QFamr()
if IWalkConfig.LastHit then
      if Config.F then
      for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
        if IsInDistance(Q, 750) then
        local z = (GetCastLevel(myHero,_Q)*30)+(GetBonusDmg(myHero)*1.9)
        local hp = GetCurrentHP(Q)
        local Dmg = CalcDamage(myHero, Q, z)
        if Dmg > hp then
if CanUseSpell(myHero, _Q) == READY then
    CastTargetSpell(Q,_Q)
            end
        end
          end
        end
        end
      end
    end
function Killsteal4()
local unit = GetCurrentTarget()
 if ValidTarget(unit, 1550) then
        for i,enemy in pairs(GetEnemyHeroes()) do
                          local z = ((GetCastLevel(myHero,_Q)*30)+(GetBonusDmg(myHero)*1.9))
if CanUseSpell(myHero, _Q) == READY and ValidTarget(enemy,GetCastRange(myHero,_Q)) and Config.I 
  and (GetCastLevel(myHero,_Q)*30)+(GetBonusDmg(myHero)*1.9) and CalcDamage(myHero, enemy, z) > GetCurrentHP(unit) then
    CastTargetSpell(enemy, _Q)
            end
        end
end
end
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Irelia Loaded</font>"))
end

--Evelynn
if GetObjectName(GetMyHero()) == "Evelynn" then
--Menu
Config = scriptConfig("Evelynn", "Evelynn")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then

-- Evelynn W
    if Config.W then
        if GetCastName(myHero, _W) == "EvelynnW" then
if CanUseSpell(myHero, _W) == READY then
    CastTargetSpell(myHero,_W)
                end
            end
        end
-- Evelynn Q
    if Config.Q then
        if GetCastName(myHero, _Q) == "EvelynnQ" then
if CanUseSpell(myHero, _Q) == READY then
    CastTargetSpell(myHero,_Q)
                end
            end
        end
    -- Evelynn E
   if Config.E then
        if GetCastName(myHero, _E) == "EvelynnE" then
if CanUseSpell(myHero, _E) == READY then
    CastTargetSpell(unit,_E)
                end
    end
end
-- Evelynn R
             if Config.R then
if GetCastName(myHero, _R) == "EvelynnR" then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,650,55,false,true)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1550) then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
            end
end
end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Evelynn Loaded</font>"))
end

--Akali
if GetObjectName(GetMyHero()) == "Akali" then
--Menu
Config = scriptConfig("Akali", "Akali")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then
                 if Config.Q then
        if GetCastName(myHero, _Q) == "AkaliMota" then
if CanUseSpell(myHero, _Q) == READY then
    CastTargetSpell(unit,_Q)
                end
            end
        end
             -- Akali E
             if Config.E then
if GetCastName(myHero, _E) == "AkaliShadowSwipe" then
    local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,325,55,false,true)
    if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 325) then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
                end
            end
-- Akali W
    if Config.W then
        if GetCastName(myHero, _W) == "AkaliSmokeBomb" then
if CanUseSpell(myHero, _W) == READY then
    CastTargetSpell(unit,_W)
                end
            end
        end
    -- Akali R
   if Config.R then
        if GetCastName(myHero, _R) == "AkaliShadowDance" then
if CanUseSpell(myHero, _R) == READY then
    CastTargetSpell(unit,_R)
                end
    end
end
end
end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Akali Loaded</font>"))
end

--Menu
if GetObjectName(GetMyHero()) == "Azir" then
--Azir
Config = scriptConfig("Azir", "Azir")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then

-- Azir W
    if Config.W then
        if GetCastName(myHero, _W) == "AzirW" then
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,850,55,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                end
            end
    end
-- Azir Q
    if Config.Q then
        if GetCastName(myHero, _Q) == "AzirQ" then
    local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,false,true)
    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                end
            end
    end
    -- Azir E
    if Config.E then
        if GetCastName(myHero, _E) == "AzirE" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,850,50,false,true)
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
-- Azir R
             if Config.R then
if GetCastName(myHero, _R) == "AzirR" then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,250,55,false,true)
  local ult = (GetCastLevel(myHero,_R)*75)+(GetBonusAP(myHero)*.6)
    if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) or (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.27 and CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 250) then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
            end
end
end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Azir Loaded</font>"))
end

--Viktor
if GetObjectName(GetMyHero()) == "Viktor" then
--Menu
Config = scriptConfig("Viktor", "Viktor")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then

-- Viktor W
    if Config.W then
        if GetCastName(myHero, _W) == "ViktorGravitonField" then
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,700,55,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                end
            end
    end
-- Viktor Q
    if Config.Q then
        if GetCastName(myHero, _Q) == "ViktorPowerTransfer" then
if CanUseSpell(myHero, _Q) == READY then
    CastTargetSpell(unit,_Q)
                end
            end
        end
    -- Viktor E
    local myorigin = GetOrigin(unit)
local mymouse = GetCastRange(myHero,_E) 
if Config.E then
        if GetCastName(myHero, _E) == "ViktorDeathRay" then
 local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,false,true)
if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 1500) then 
    CastSkillShot3(_E,myorigin,myorigin)
    end
end
end
-- Viktor R
             if Config.R then
if GetCastName(myHero, _R) == "ViktorChaosStorm" then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,700,55,false,true)
    local ult = (GetCastLevel(myHero,_R)*200+25)+(GetBonusDmg(myHero)*1.6)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1550) then
   if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
                end
            end
        end
end
end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Viktor Loaded</font>"))
end
-- VelKoz
if GetObjectName(GetMyHero()) == "Velkoz" then
--Menu
Config = scriptConfig("VelKoz", "VelKoz")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1550) then
 
-- Velkoz E
    if Config.E then
        if GetCastName(myHero, _E) == "VelkozE" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,850,50,false,true)
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end

-- Velkoz W
    if Config.W then
        if GetCastName(myHero, _W) == "VelkozW" then
    local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,false,true)
    if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and IsInDistance(unit, 1500) then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                end
            end
    end
-- Velkoz Q
    if Config.Q then
        if GetCastName(myHero, _Q) == "VelkozQ" then
    local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1050,55,true,true)
    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                end
            end
    end
-- Velkoz R
             if Config.R then
if GetCastName(myHero, _R) == "VelkozR" then
    local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,false,true)
    local ult = (GetCastLevel(myHero,_R)*200)+(GetBonusAP(myHero)*.6)
    if CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 1550) then
      if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
          end
                end
            end
    end
end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Velkoz Loaded</font>"))
end

-- Ekko
if GetObjectName(GetMyHero()) == "Ekko" then
--Menu
Config = scriptConfig("Ekko", "Ekko")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
    local unit = GetCurrentTarget()
    if GetCastName(myHero, _R) == "EkkoR" then
            if Config.R then
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.2 and
                    CanUseSpell(myHero, _R) == READY and IsObjectAlive(myHero) and IsInDistance(unit, 1000) then
            CastTargetSpell(myHero,_R)
            end
        end
    end
AutoIgnite()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1200) then
 
-- Q cast
        if GetCastName(myHero, _Q) == "EkkoQ" then
                local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1075,50,false,true)
                        if Config.Q then
                        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                        end
                end
        end
-- W Cast
    if GetCastName(myHero, _W) == "EkkoW" then
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1600,50,false,true)
            if Config.W then
            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
-- E Cast Will cast E and if im correct then GoS will click champ and Ekko will blink Cast = 325 range Blink= 425
    if GetCastName(myHero, _E) == "EkkoE" then
        local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,750,50,false,true)
            if Config.E then
            if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 then
            CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
            end
        end
    end
-- R Cast Disabled till i manage how to Use R when low --THANKS SNOWBALL
    if GetCastName(myHero, _R) == "EkkoR" then
            if Config.R then
              local ult = (GetCastLevel(myHero,_R)*150+50)+(GetBonusAP(myHero)*1.30)
                      local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,325,50,false,true)
                         if CanUseSpell(myHero, _R) and IsInDistance(unit, 325) then 
            if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
            CastSkillShot(_R,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z) 
              end
            end
            end
    end
end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Ekko Loaded</font>"))
end
--Nidalee
if GetObjectName(GetMyHero()) == "Nidalee" then
--Menu
Config = scriptConfig("Nidalee", "Nidalee")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Q2", "Use Q2", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W2", "Use W2", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E2", "Use E2", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
-- Nidalee human heal --THANKS SNOWBALL
            if GetCastName(myHero, _E) == "PrimalSurge" then
        if Config.E then
                     if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.2 and
                    CanUseSpell(myHero, _E) == READY and IsObjectAlive(myHero) then
            CastTargetSpell(myHero,_E)
        end
    end
end
AutoIgnite()
if Config.Combo then
local unit = GetCurrentTarget()
if ValidTarget(unit, 1500) then
 
-- Nidalee Human Trap
    if GetCastName(myHero, _W) == "Bushwhack" then
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,900,50,true,true)
            if Config.W then
            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
-- Nidalee human spear
    if GetCastName(myHero, _Q) == "JavelinToss"then
    -- GetPredictionForPlayer(startPosition, targetUnit, targetUnitMoveSpeed, spellTravelSpeed, spellDelay, spellRange, spellWidth, collision, addHitBox)
    local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1600,250,1500,55,true,true)
    if Config.Q then
    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                end
            end
    end
-- Tansform to cougar
if GetCastName(myHero, _R) == "AspectOfTheCougar" then
            if Config.R then
              if (GetCurrentHP(unit)/GetMaxHP(unit))<0.6 and 
    CanUseSpell(myHero, _R) == READY and CanUseSpell(myHero, _W) == READY and CanUseSpell(myHero, _Q) ~= READY and IsInDistance(unit, 750) then
    CastTargetSpell(myHero, _R)
                end
            end
        end
-- Cougar attack Q
            if GetCastName(myHero, _Q) == "Takedown" then
        if Config.Q2 then
    if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 475) then
    CastTargetSpell(unit, _Q)
    end
        end
    end
    -- Cougar pounce W
            if GetCastName(myHero, _W) == "Pounce" then
        if Config.W2 then
    if CanUseSpell(myHero, _W) == READY and IsInDistance(unit, 375) then
    CastTargetSpell(unit, _W)
            end
        end
    end
    -- E cast in cougar form
            if GetCastName(myHero, _E) == "Swipe" then
        if Config.E2 then
    if CanUseSpell(myHero, _E) == READY and IsInDistance(unit, 300) then
    CastTargetSpell(unit, _E)
            end
        end
    end
-- Transform back
    if GetCastName(myHero, _R) == "AspectOfTheCougar" then
        if Config.R then
         if (GetCurrentHP(unit)/GetMaxHP(unit))<0.6 and 
    CanUseSpell(myHero, _R) == READY and IsInDistance(unit, 750) and GotBuff(myHero, "nidaleepassivehunting") == 1 then
        CastSpell(_R)
                end
            end
                end
        end
 
        end
    end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Nidalee Loaded</font>"))
 end
-- Graves
if GetObjectName(GetMyHero()) == "Graves" then
--Menu
Config = scriptConfig("Graves", "Graves")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Combo", "Combo", SCRIPT_PARAM_KEYDOWN, string.byte(" "))
--Start
OnLoop(function(myHero)
AutoIgnite()
if Config.Combo then
local unit = GetCurrentTarget()
local mymouse = GetMousePos()
if ValidTarget(unit, 1200) then
 
-- Q cast
        if GetCastName(myHero, _Q) == "GravesClusterShot" then
                local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,900,50,false,true)
                        if Config.Q then
                        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
                        end
                end
        end
-- W Cast
    if GetCastName(myHero, _W) == "GravesSmokeGrenade" then
        local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1600,50,false,true)
            if Config.W then
            if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 then
            CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
            end
        end
    end
-- E Cast 
    if GetCastName(myHero, _E) == "GravesMove" then
            if Config.E then
        CastSkillShot(_E, GetMousePos().x, GetMousePos().y, GetMousePos().z)
            end
        end
-- R Cast 
    if GetCastName(myHero, _R) == "GravesChargedShot" then
      if Config.R then
        local ult = (GetCastLevel(myHero,_R)*150+150)+(GetBonusDmg(myHero)*1.50)
        local RPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1700,250,1000,50,true,true)
                        if CanUseSpell(myHero_R) == READY and RPred.HitChance == 1 and IsInDistance(target, GetCastRange(myHero,_R)) then
                                  if CalcDamage(myHero, unit, ult) > GetCurrentHP(unit) then
                          CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
        end
        end
    end
end

end
end
end)
PrintChat(string.format("<font color='#1244EA'>[CloudAIO]</font> <font color='#FFFFFF'>Graves Loaded</font>"))
end
-- Recall thing by Kristian
local recalling = {}
local x = 5
local y = 500
local barWidth = 250
local rowHeight = 18
local onlyEnemies = true
local onlyFOW = true

OnLoop(function()
  
  local i = 0
  for hero, recallObj in pairs(recalling) do
    local percent=math.floor(GetCurrentHP(recallObj.hero)/GetMaxHP(recallObj.hero)*100)
    local color=percentToRGB(percent)
    local leftTime = recallObj.starttime - GetTickCount() + recallObj.info.totalTime
    
    if leftTime<0 then leftTime = 0 end
    FillRect(x,y+rowHeight*i-2,168,rowHeight,0x50000000)
    if i>0 then FillRect(x,y+rowHeight*i-2,168,1,0xC0000000) end
    
    DrawText(string.format("%s (%d%%)", hero, percent), 14, x+2, y+rowHeight*i, color)
    
    if recallObj.info.isStart then
      DrawText(string.format("%.1fs", leftTime/1000), 14, x+115, y+rowHeight*i, color)
      FillRect(x+169,y+rowHeight*i, barWidth*leftTime/recallObj.info.totalTime,14,0x80000000)
    else
      if recallObj.killtime == nil then
        if recallObj.info.isFinish and not recallObj.info.isStart then
          recallObj.result = "finished"
          recallObj.killtime =  GetTickCount()+2000
        elseif not recallObj.info.isFinish then
          recallObj.result = "cancelled"
          recallObj.killtime =  GetTickCount()+2000
        end
        
      end
      DrawText(recallObj.result, 14, x+115, y+rowHeight*i, color)
    end
    
    if recallObj.killtime~=nil and GetTickCount() > recallObj.killtime then
      recalling[hero] = nil
    end
    
    i=i+1
  end
end)

function percentToRGB(percent) 
  local r, g
    if percent == 100 then
        percent = 99 end
    
    if percent < 50 then
        r = math.floor(255 * (percent / 50))
        g = 255
    else
        r = 255
        g = math.floor(255 * ((50 - percent % 50) / 50))
    end
  
    return 0xFF000000+g*0xFFFF+r*0xFF
end


OnProcessRecall(function(Object,recallProc)
  if onlyEnemies and GetTeam(GetMyHero())==GetTeam(Object) then return end
  if onlyFOW and recalling[GetObjectName(Object)] == nil  and IsVisible(Object) then return end
  
  rec = {}
  rec.hero = Object
  rec.info = recallProc
  rec.starttime = GetTickCount()
  rec.killtime = nil
  rec.result = nil
  recalling[GetObjectName(Object)] = rec

end)
PrintChat("Recall tracker by Krystian loaded.")
