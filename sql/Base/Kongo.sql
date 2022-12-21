--======Mvemba(Old Kongo Leader)======--

--5.1 Founder Belief Bug Fix
INSERT INTO Requirements(RequirementId, RequirementType) VALUES
	('BBG_REQUIRES_PLAYER_IS_RELIGIOUS_CONVERT', 'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES'),
	('BBG_REQUIRES_PLAYER_FOUNDED_RELIGION_OR_MVEMBA', 'REQUIREMENT_REQUIREMENTSET_IS_MET');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
	('BBG_REQSET_FOUNDER_OR_MVEMBA', 'REQUIREMENTSET_TEST_ANY');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
	('BBG_REQSET_FOUNDER_OR_MVEMBA', 'REQUIRES_PLAYER_FOUNDED_RELIGION'),
	('BBG_REQSET_FOUNDER_OR_MVEMBA', 'BBG_REQUIRES_PLAYER_IS_RELIGIOUS_CONVERT');

INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
	('BBG_REQUIRES_PLAYER_IS_RELIGIOUS_CONVERT', 'LeaderType', 'LEADER_MVEMBA'),
	('BBG_REQUIRES_PLAYER_FOUNDED_RELIGION_OR_MVEMBA', 'RequirementSetId', 'BBG_REQSET_FOUNDER_OR_MVEMBA');

UPDATE RequirementSetRequirements SET RequirementId = 'BBG_REQUIRES_PLAYER_FOUNDED_RELIGION_OR_MVEMBA' WHERE RequirementId = 'REQUIRES_PLAYER_FOUNDED_RELIGION' AND RequirementSetId <> 'BBG_REQSET_FOUNDER_OR_MVEMBA';

-- Kongo Military Unit get forest and jungle free move. Ngao move on hill but don't get general move.
INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
    ('BBG_MILITARY_UNITS_IGNORE_WOODS', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_MILITARY_UNITS_IGNORE_WOODS', 'AbilityType', 'BBG_IGNORE_WOODS_ABILITY');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('TRAIT_LEADER_RELIGIOUS_CONVERT', 'BBG_MILITARY_UNITS_IGNORE_WOODS');

INSERT INTO Types(Type, Kind) VALUES
    ('BBG_IGNORE_WOODS_ABILITY', 'KIND_ABILITY');

INSERT INTO TypeTags(Type, Tag) VALUES
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_RECON'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_MELEE'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_RANGED'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_ANTI_CAVALRY'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_LIGHT_CAVALRY'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_HEAVY_CAVALRY'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_SIEGE');

INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, ShowFloatTextWhenEarned, Permanent)  VALUES
    ('BBG_IGNORE_WOODS_ABILITY', 'LOC_BBG_IGNORE_WOODS_ABILITY_NAME', 'LOC_BBG_IGNORE_WOODS_ABILITY_DESCRIPTION', 1, 0, 1);

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
    ('BBG_IGNORE_WOODS_ABILITY', 'RANGER_IGNORE_FOREST_MOVEMENT_PENALTY');
--=======Kongo(Civilization)==========--

-- Grant relic on each gov plaza building.
INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, OwnerRequirementSetId) VALUES
    ('BBG_KONGO_RELIC_GOVBUILDING_TALL', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_TALL_REQUIREMENTS'),
    ('BBG_KONGO_RELIC_GOVBUILDING_WIDE', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_WIDE_REQUIREMENTS'),
    ('BBG_KONGO_RELIC_GOVBUILDING_CONQUEST', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_CONQUEST_REQUIREMENTS'),
    ('BBG_KONGO_RELIC_GOVBUILDING_FAITH', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_FAITH_REQUIREMENTS'),
    ('BBG_KONGO_RELIC_GOVBUILDING_CITYSTATES', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_CITYSTATES_REQUIREMENTS'),
    ('BBG_KONGO_RELIC_GOVBUILDING_SPIES', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_SPIES_REQUIREMENTS'),
    ('BBG_KONGO_RELIC_GOVBUILDING_SCIENCE', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_SCIENCE_REQUIREMENTS'),
    ('BBG_KONGO_RELIC_GOVBUILDING_CULTURE', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_CULTURE_REQUIREMENTS'),
    ('BBG_KONGO_RELIC_GOVBUILDING_MILITARY', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_MILITARY_REQUIREMENTS');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_KONGO_RELIC_GOVBUILDING_TALL', 'Amount', '1'),
    ('BBG_KONGO_RELIC_GOVBUILDING_WIDE', 'Amount', '1'),
    ('BBG_KONGO_RELIC_GOVBUILDING_CONQUEST', 'Amount', '1'),
    ('BBG_KONGO_RELIC_GOVBUILDING_FAITH', 'Amount', '1'),
    ('BBG_KONGO_RELIC_GOVBUILDING_CITYSTATES', 'Amount', '1'),
    ('BBG_KONGO_RELIC_GOVBUILDING_SPIES', 'Amount', '1'),
    ('BBG_KONGO_RELIC_GOVBUILDING_SCIENCE', 'Amount', '1'),
    ('BBG_KONGO_RELIC_GOVBUILDING_CULTURE', 'Amount', '1'),
    ('BBG_KONGO_RELIC_GOVBUILDING_MILITARY', 'Amount', '1');
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_TALL'),
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_WIDE'),
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_CONQUEST'),
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_FAITH'),
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_CITYSTATES'),
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_SPIES'),
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_SCIENCE'),
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_CULTURE'),
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_MILITARY');

-- +100% prod towards archealogists
INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId) VALUES
	('TRAIT_CIVILIZATION_NKISI', 'TRAIT_ARCHAEOLOGIST_PROD_BBG');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType) VALUES
	('TRAIT_ARCHAEOLOGIST_PROD_BBG', 'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_PRODUCTION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('TRAIT_ARCHAEOLOGIST_PROD_BBG', 'UnitType', 'UNIT_ARCHAEOLOGIST'),
	('TRAIT_ARCHAEOLOGIST_PROD_BBG', 'Amount', '100');

-- NGao 3PM
UPDATE Units SET BaseMoves=3 WHERE UnitType='UNIT_KONGO_SHIELD_BEARER';

-- Put back writer point.
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('TRAIT_CIVILIZATION_NKISI', 'TRAIT_DOUBLE_WRITER_POINTS');

-- +4 faith for each sculture and artifact
UPDATE ModifierArguments SET Value='4' WHERE Name='YieldChange' AND ModifierId IN ('TRAIT_GREAT_WORK_FAITH_SCULPTURE', 'TRAIT_GREAT_WORK_FAITH_ARTIFACT');