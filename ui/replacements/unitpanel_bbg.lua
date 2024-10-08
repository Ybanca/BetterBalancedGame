include "UnitPanel_Expansion2"

-- Corrects Amani owner only trade route bonuses to show on Trade Select and Trade Overview panels
function TradeUnitView( viewData:table )
	if viewData.IsTradeUnit then
		local hideTradeYields:boolean = true;
		local IsAmaniCase:boolean = false;
		local addAmount = 0;
		local isCityState:boolean = false;
		local has_promo:boolean = false;
		local originPlayer:table = Players[Game.GetLocalPlayer()];
		local originCities:table = originPlayer:GetCities();
		for _, city in originCities:Members() do
			local outgoingRoutes:table = city:GetTrade():GetOutgoingRoutes();
			for i,route in ipairs(outgoingRoutes) do
				if viewData.UnitID == route.TraderUnitID then
					-- Add Origin Yields
					Controls.TradeResourceList:DestroyAllChildren();
					-- get trade route destinationCities
					local destinationPlayer:table = Players[route.DestinationCityPlayer];
					local destinationCities:table = destinationPlayer:GetCities();
					local destinationCity:table = destinationCities:FindID(route.DestinationCityID);
					local gov = destinationCity:GetAllAssignedGovernors();
					if #gov > 0 then
					    playerId = Game.GetLocalPlayer();
					    for i, j in ipairs(gov) do
                            if j:GetOwner() == playerId then
                                -- print('CS Amani Governor belongs to player');
                                -- check its a city state
                                for i, pCityState in ipairs(PlayerManager.GetAliveMinors()) do
		                            if pCityState:GetID() == destinationCity:GetOwner() then
			                            isCityState = true;
			                            break;
		                            end
	                            end
                                -- need this check to make sure its not Ibrahim (Ottoman governor)
                                if j:GetName() == 'LOC_GOVERNOR_THE_AMBASSADOR_NAME' and j:IsEstablished() and isCityState then
                                    -- print('Amani fully established, flag set to add Messenger promo yields.')
                                    IsAmaniCase = true;
                                    -- has_promo = j:HasPromotion(DB.MakeHash('GOVERNOR_PROMOTION_AMBASSADOR_FOREIGN_INVESTOR'));
                                    -- print('Amani Promotion recognised, flag set to add Foreign Investor yields')
                                end
                            end
                        end
                    end
					for j,yieldInfo in pairs(route.OriginYields) do
					    addAmount = 0;
					    if IsAmaniCase and j < 4 then
					    	if j < 3 then
					    	    addAmount = 2;
					    	    -- print('Added Amani Messenger +2 Prod/Food (should appear twice)')
					    	end
					    	--[[if has_promo then
					    	    if j == 3 then
					    		    addAmount = addAmount + 3;
					    		    -- print('Added Amani Foreign Investor +3 Gold')
					    		else
					    		    addAmount = addAmount + 1;
					    		    -- print('Added Amani Foreign Investor +1 Prod/Food (should appear twice)')
					    		end
					    	end --]]
					    end
						if yieldInfo.Amount > 0 or addAmount > 0 then
							local yieldDetails:table = GameInfo.Yields[yieldInfo.YieldIndex];
							AddTradeResourceEntry(yieldDetails, Round(yieldInfo.Amount + addAmount,1));
							hideTradeYields = false;
						end
					end
				end
			end
		end

		Controls.TradeYieldGrid:SetHide(hideTradeYields);
		Controls.TradeUnitContainer:SetHide(false);
	else
		Controls.TradeUnitContainer:SetHide(true);
	end
end
--[[ Commented out as currently unused in modinfo and needed file for amani display
print("Unitpanel Replacement for BBG")
--Hungary Huszar Display Override: 

function GetCombatModifierList(combatantHash:number)
	if (m_combatResults == nil) then
		return;
	end

	local baseStrengthValue = 0;
	local combatantResults = m_combatResults[combatantHash];

	baseStrengthValue = combatantResults[CombatResultParameters.COMBAT_STRENGTH];
	
	local baseStrengthText = baseStrengthValue .. " " .. Locale.Lookup("LOC_COMBAT_PREVIEW_BASE_STRENGTH");
	local interceptorModifierText = combatantResults[CombatResultParameters.PREVIEW_TEXT_INTERCEPTOR];
	local antiAirModifierText = combatantResults[CombatResultParameters.PREVIEW_TEXT_ANTI_AIR];
	local healthModifierText = combatantResults[CombatResultParameters.PREVIEW_TEXT_HEALTH];
	local terrainModifierText = combatantResults[CombatResultParameters.PREVIEW_TEXT_TERRAIN];
	local opponentModifierText = combatantResults[CombatResultParameters.PREVIEW_TEXT_OPPONENT];
	local modifierModifierText = combatantResults[CombatResultParameters.PREVIEW_TEXT_MODIFIER];
	local flankingModifierText = combatantResults[CombatResultParameters.PREVIEW_TEXT_ASSIST];
	local promotionModifierText = combatantResults[CombatResultParameters.PREVIEW_TEXT_PROMOTION];
	local defenseModifierText = combatantResults[CombatResultParameters.PREVIEW_TEXT_DEFENSES];
	local resourceModifierText = combatantResults[CombatResultParameters.PREVIEW_TEXT_RESOURCES];

	local modifierList:table = {};
	local modifierListSize:number = 0;
	if ( baseStrengthText ~= nil) then
		modifierList, modifierListSize = AddModifierToList(modifierList, modifierListSize, baseStrengthText, "ICON_STRENGTH");
	end
	if (interceptorModifierText ~= nil) then
		for i, item in ipairs(interceptorModifierText) do
			modifierList, modifierListSize = AddModifierToList(modifierList, modifierListSize, Locale.Lookup(item), "ICON_STATS_INTERCEPTOR");
		end
	end
	if (antiAirModifierText ~= nil) then
		for i, item in ipairs(antiAirModifierText) do
			modifierList, modifierListSize = AddModifierToList(modifierList, modifierListSize, Locale.Lookup(item), "ICON_STATS_ANTIAIR");
		end
	end
	if (healthModifierText ~= nil) then
		for i, item in ipairs(healthModifierText) do
			modifierList, modifierListSize = AddModifierToList(modifierList, modifierListSize, Locale.Lookup(item), "ICON_DAMAGE");
		end
	end
	if (terrainModifierText ~= nil) then
		for i, item in ipairs(terrainModifierText) do
			modifierList, modifierListSize = AddModifierToList(modifierList, modifierListSize, Locale.Lookup(item), "ICON_STATS_TERRAIN");
		end
	end
	if (opponentModifierText ~= nil) then
		for i, item in ipairs(opponentModifierText) do
			modifierList, modifierListSize = AddModifierToList(modifierList, modifierListSize, Locale.Lookup(item), "ICON_STRENGTH", combatantHash);
		end
	end
	if (modifierModifierText ~= nil) then
		for i, item in ipairs(modifierModifierText) do
			modifierList, modifierListSize = AddModifierToList(modifierList, modifierListSize, Locale.Lookup(item), "ICON_STRENGTH", combatantHash);
		end
	end
	if (flankingModifierText ~= nil) then
		for i, item in ipairs(flankingModifierText) do
			modifierList, modifierListSize = AddModifierToList(modifierList, modifierListSize, Locale.Lookup(item), "ICON_POSITION");
		end
	end
	if (promotionModifierText ~= nil) then
		for i, item in ipairs(promotionModifierText) do
			modifierList, modifierListSize = AddModifierToList(modifierList, modifierListSize, Locale.Lookup(item), "ICON_PROMOTION");
		end
	end
	if (defenseModifierText ~= nil) then
		for i, item in ipairs(defenseModifierText) do
			modifierList, modifierListSize = AddModifierToList(modifierList, modifierListSize, Locale.Lookup(item), "ICON_DEFENSE");
		end
	end
	if (resourceModifierText ~= nil) then
		for i, item in ipairs(resourceModifierText) do
			modifierList, modifierListSize = AddModifierToList(modifierList, modifierListSize, Locale.Lookup(item), "ICON_RESOURCES");
		end
	end

	return modifierList, modifierListSize;
end

function AddModifierToList(modifierList, modifierListSize, text, icon, combatantHash: number)
	combatantHash = nil or combatantHash
	local modifierEntry:table = {}
	if text ~= Locale.Lookup("LOC_BBG_HUSZAR_DISPLAY_MODIFIER") then
		modifierEntry["text"] = text;
	else
		--print("pass1")
		local combatantResults = m_combatResults[combatantHash]
		local combatantID = combatantResults[CombatResultParameters.ID]
		--print(combatantID)
		local combatantPlayer = Players[combatantID.player]
		--print(combatantPlayer)
		if combatantPlayer~=nil then
			--print("pass2")
			local value = 0
			local suzstring = ""
			local middlestring = "LOC_BBG_HUSZAR_DISPLAY_MODIFIER"
			for i = 0, 60 do
				local pPlayer = Players[i]
				if pPlayer~=nil then
					if not pPlayer:IsMajor() and pPlayer:IsAlive() then
						--print("pass 3")
						if pPlayer:GetInfluence():GetSuzerain()==combatantID.player then
							--print("pass 4")
							value = value + 1
							local civType = PlayerConfigurations[i]:GetCivilizationTypeID()
							--print(civType)
							local suzname = Locale.Lookup(GameInfo.Civilizations[civType].Name)
							if suzstring == "" or suzstring == nil then
								suzstring = suzname
							else
								suzstring = suzstring..", "..suzname
							end
							--print(suzname)
						end
					end
				end
			end
			--print("suzstring", suzstring)
			if suzstring == "" or suzstring == nil then
				--print("Pass No Suz")
				suzstring = Locale.Lookup("LOC_BBG_HUSZAR_NO_CITY_STATE")
			end
			local text = "+"..tostring(2*value).." "..Locale.Lookup("LOC_BBG_HUSZAR_DISPLAY_MODIFIER")..suzstring
			--print("Set text", text)
			modifierEntry["text"] = text
		end
	end
	--print(modifierEntry["text"])
	modifierEntry["icon"] = icon;
	modifierListSize = modifierListSize + 1;
	modifierList[modifierListSize] = modifierEntry;

	return modifierList, modifierListSize;
end

function GetCombatResults ( attacker, locX, locY )

	-- We have to ask Game Core to do an evaluation, is it busy?
	if (UI.IsGameCoreBusy() == true) then
		return;
	end

	if ( attacker == m_attackerUnit and locX == m_locX and locY == m_locY) then
		return;
	end

	m_attackerUnit	= attacker;
	m_locX = locX;
	m_locY = locY;

	if (locX ~= nil and locY ~= nil) then
		local eCombatType = nil;
		if (UI.GetInterfaceMode() == InterfaceModeTypes.RANGE_ATTACK) then
			local pPlayer:table	= Players[Game.GetLocalPlayer()];
			local pUnit = UnitManager.GetUnit(attacker.player, attacker.id);
			local pDistrict:table = pPlayer:GetDistricts():FindID( attacker );
			if (pUnit ~= nil) then
				eCombatType = CombatTypes.RANGED;
				if (pUnit:GetBombardCombat() > pUnit:GetRangedCombat()) then
					eCombatType = CombatTypes.BOMBARD;
				end
			elseif (pDistrict ~= nil) then
				eCombatType = CombatTypes.RANGED;
			end
		end

		local interfaceMode = UI.GetInterfaceMode();
		if( interfaceMode == InterfaceModeTypes.PRIORITY_TARGET ) then
			m_combatResults	= CombatManager.SimulatePriorityAttackInto( attacker, eCombatType, locX, locY );
		else
			m_combatResults	= CombatManager.SimulateAttackInto( attacker, eCombatType, locX, locY );
		end
	end
end
--]]