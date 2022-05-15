local playerGUID = UnitGUID("player")
local lastCritTime = time()

local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function(self, event)
  self:COMBAT_LOG_EVENT_UNFILTERED(CombatLogGetCurrentEventInfo())
end)

function f:COMBAT_LOG_EVENT_UNFILTERED(...)
  local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
  local spellId, spellName, spellSchool
  local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand

  if subevent == "SWING_DAMAGE" then
    amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand = select(12, ...)
  elseif subevent == "SPELL_DAMAGE" then
    spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand = select(12, ...)
  end

  if critical and sourceGUID == playerGUID then
    local currentTime = time()
    if (lastCritTime + 1 <= currentTime) then
      if (1 == math.random(1,100)) then
        PlaySoundFile("Interface\\AUDIO\\owen-wilson\\special.mp3","master")
      else
        PlaySoundFile("Interface\\AUDIO\\owen-wilson\\"..tostring(math.random(1,16))..".mp3","master")
        return true
      end
      lastCritTime = currentTime
    end
  end
end