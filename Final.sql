SET DEFINE OFF;

DROP TABLE CLASSES;
CREATE TABLE CLASSES
(CLASS_ID NUMBER(10),
CLASS_NAME VARCHAR2(9), 
CONSTRAINT CLASS_ID_PK PRIMARY KEY (CLASS_ID) );


DROP TABLE PLAYERS;
CREATE TABLE PLAYERS
(PLAYER_ID NUMBER(10),
PLAYER_NAME VARCHAR2(30),
CLASS_ID NUMBER(10),
RACE VARCHAR2(10),
STRENGTH NUMBER(10),
DEXTERITY NUMBER(10),
CONSTITUTION NUMBER(10),
INTELLIGENCE NUMBER(10),
WISDOM NUMBER(10),
CHARISMA NUMBER(10),
INITIATIVE NUMBER(10),
MAX_HP NUMBER(10),
ARMOR_CLASS NUMBER(10),
PASSIVE_PERCEPTION NUMBER(10),
DATE_CREATED DATE,
CONSTRAINT PLAYER_ID_PK PRIMARY KEY (PLAYER_ID),
CONSTRAINT PLAYERCLASS_ID_FK FOREIGN KEY (CLASS_ID) REFERENCES CLASSES (CLASS_ID),
CHECK (PASSIVE_PERCEPTION IS NOT NULL));

grant update on players to public;
grant update(player_id, player_name, strength) on players to linglu;
revoke all on players from linglu;
revoke all on players from public;


DROP TABLE MONSTERS;
CREATE TABLE MONSTERS
(MONSTER_ID NUMBER,
MONSTER_NAME VARCHAR(30),
MONSTER_TYPE VARCHAR(30),
STRENGTH NUMBER,
DEXTERITY NUMBER,
CONSTITUTION NUMBER,
INTELLIGENCE NUMBER,
WISDOM NUMBER,
CHARISMA NUMBER,
INITIATIVE NUMBER,
MAX_HP NUMBER,
ARMOR_CLASS NUMBER,
PASSIVE_PERCEPTION NUMBER,
DATE_CREATED DATE,
CONSTRAINT MONSTER_ID_PK PRIMARY KEY (MONSTER_ID));

DROP TABLE SPELLS;
CREATE TABLE SPELLS 
(SPELL_ID NUMBER(10),
SPELL_NAME VARCHAR2(128),
SPELL_LEVEL NUMBER(10),
SPELL_TYPE VARCHAR2(128),
CASTING_TIME VARCHAR2(128),
SPELL_RANGE VARCHAR2(128),
COMPONENTS VARCHAR2(128),
DURATION VARCHAR2(128),
DESCRIPTION CLOB,
HIGHER_LEVELS CLOB,
CONSTRAINT SPELL_ID_PK PRIMARY KEY (SPELL_ID))
 ;
 

DROP TABLE CLASS_SPELLS;

CREATE TABLE CLASS_SPELLS
(CLASS_ID NUMBER(10),
SPELL_ID NUMBER(10), 
CONSTRAINT CLASSSPELL_ID_PK PRIMARY KEY (CLASS_ID, SPELL_ID),
CONSTRAINT CLASS_ID_FK FOREIGN KEY (CLASS_ID) REFERENCES CLASSES (CLASS_ID),
CONSTRAINT SPELL_ID_FK FOREIGN KEY (SPELL_ID) REFERENCES SPELLS (SPELL_ID) );



INSERT INTO CLASSES
 SELECT 1, 'barbarian' FROM dual UNION ALL 
 SELECT 2, 'bard' FROM dual UNION ALL 
 SELECT 3, 'cleric' FROM dual UNION ALL 
 SELECT 4, 'druid' FROM dual UNION ALL 
 SELECT 5, 'fighter' FROM dual UNION ALL 
 SELECT 6, 'monk' FROM dual UNION ALL 
 SELECT 7, 'paladin' FROM dual UNION ALL 
 SELECT 8, 'ranger' FROM dual UNION ALL 
 SELECT 9, 'rogue' FROM dual UNION ALL 
 SELECT 10, 'sorcerer' FROM dual UNION ALL 
 SELECT 11, 'warlock' FROM dual UNION ALL 
 SELECT 12, 'wizard' FROM dual;

INSERT INTO PLAYERS
 SELECT 1, 'Musgraben', 6, 'Gnome', 12, 15, 14, 12, 14, 8, 2, 10, 14, 12, '12-MAY-46' FROM dual UNION ALL 
 SELECT 2, 'Olrok', 5, 'Half-Orc', 17, 10, 15, 8, 13, 12, 0, 12, 18, 13, '23-AUG-37' FROM dual UNION ALL 
 SELECT 3, 'Hobart', 3, 'Halfling', 14, 14, 13, 8, 15, 11, 2, 9, 18, 12, '11-JAN-12' FROM dual UNION ALL 
 SELECT 4, 'Gobblefirn', 1, 'Elf', 15, 13, 15, 10, 10, 12, 1, 14, 13, 12, '15-NOV-16' FROM dual;
 
 INSERT INTO MONSTERS
SELECT 1, 'Goblin', 'Humanoid', 8, 14, 10, 10, 8, 8, 2, 7, 15, 9, '14-FEB-22' FROM dual UNION ALL 
SELECT 2, 'Aboleth', 'Aberration', 21, 9, 15, 18, 15, 18, -1, 135, 17, 20, '28-JUL-74' FROM dual UNION ALL 
SELECT 3, 'Wolf', 'Beast', 12, 15, 12, 3, 12, 6, 2, 11, 13, 13, '18-MAR-86' FROM dual UNION ALL 
SELECT 4, 'Air Elemental', 'Elemental', 14, 20, 14, 6, 10, 6, 2, 90, 15, 10, '30-JUN-16' FROM dual;



INSERT INTO SPELLS
 SELECT 1, 'Aid', 2, '2nd-level abjuration', '1 action', '30 feet', 'V, S, M (a tiny strip of white cloth)', '8 hours', 'Your spell bolsters your allies with toughness and resolve. Choose up to three creatures within range. Each target''s Max HP and current HP increase by 5 for the duration', 'When you cast this spell using a slot of 3rd level or higher, a target''s HP increases by an addition 5 for each slot above 2nd.' FROM dual UNION ALL 
 SELECT 2, 'Alarm', 1, '1st-level abjuration', '1 minute', '30 feet', 'property | Components | V, S, M (a tiny bell and a piece of fine silver wire)', '8 hours', 'Choose a door, window, or an area within range that is no larger than a 20-foot cube. Until the spell ends, an alarm alerts you whenever a Tiny or larger creature touches or enters the warded area. You can designate creatures to not trigger the alarm.<br>A mental alarm alerts you if you are within 1 mile and wakes you if sleeping.<br>An audible alarm produces a bell sound for 10 seconds within 60 feet', '' FROM dual UNION ALL 
 SELECT 3, 'Alter Self', 2, '2nd-level transmutation', '1 action', 'Self', 'V, S', 'Concentration, up to 1 hour', 'You can choose Aquatic Adaptation, Change Appearance, or Natural Weapons for the spell''s duration.<br>Aquatic Adaptation allows you to breathe underwater and grants a swim speed equal to walking speed<br>Change Appearance allows you to change the way others perceive you, but cannot change to another creature type or size.<br>Natural Weapons grants you fangs, claws or the like to use as a natural attack with a +1 bonus to attack rolls and damage.', '' FROM dual UNION ALL 
 SELECT 4, 'Animal Friendship', 1, '1st-level enchantment', '1 action', '30 feet', 'V, S, M (a morsel of food)', '24 hours', 'A beast within range that can see and hear you must make a Wisdom save or be charmed for the duration. Harm from you or your allies ends the effect.', 'When you case this spell using a slot of 2nd level or higher, you can affect one additional beast for every slot level above 1st.' FROM dual UNION ALL 
 SELECT 5, 'Animal Messenger', 2, '2nd-level enchantment', '1 action', '30 feet', 'V, S, M (a morsel of food)', '24 hours', 'Designate a Tiny creature within range that you can see. That creature travels up to 50 miles per day flying (25 by land) and delivers a message to a person fitting a general description given by you. The message can be up to 25 words and is delivered in your voice.', 'If you cast the spell with a spell slot above 2nd, the duration of the spell increases by 48 hours for each slot level above 2nd.' FROM dual UNION ALL 
 SELECT 6, 'Animal Shapes', 8, '8th-level transmutation', '1 action', '30 feet', 'V, S', 'Concentration, up to 24 hours', 'Choose any number of willing targets within range and transform them into a beast of Large size or smaller and CR 4 or lower. Each target can be given a different form.<br>Transformation lasts for the duration or until target reaches 0 HP or dies. Targets keep their mental scores but get physical scores of beast, cannot speak or cast spells, and has its gear melded into its new form,', '' FROM dual UNION ALL 
 SELECT 7, 'Animate Dead', 3, '3rd-level necromancy', '1 minute', '10 feet', 'V, S, M (a drop of blood, a piece of flesh, and a pinch of bone dust)', 'Instantaneous', 'You animate a pile of bones or a corpse into an undead that follows your commands. As a bonus action you mentally command any creature made by this spell if it is within 60 feet of you. You must recast this every 24 hours to maintain it for up to 4 creatures.', 'For each slot level above 3rd this spell animates or maintains control over 2 additional creatures.' FROM dual UNION ALL 
 SELECT 8, 'Animate Objects', 5, '5th-level transmutation', '1 action', '120 feet', 'V, S', 'Concentration, up to 1 minute', 'You animate up to ten objects within range. Medium objects count as 2, Large as 4, and Huge as 8. The objects attack when mentally commanded using a slam attack (listed on separate card) Animated objects can move up to 30 feet per round.', 'You animate two additional objects for each slot level above 5th used for this spell.' FROM dual UNION ALL 
 SELECT 9, 'Antilife Shell', 5, '5th-level abjuration', '1 action', 'Self (10-foot radius)', 'V, S', 'Concentration, up to 1 hour', 'A magical barrier extends 10 feet out from you. Living creatures cannot pass through or attack through the barrier with weapons or spells.<br>If you move in a way to force a creature to pass through the barrier, the spell ends.', '' FROM dual UNION ALL 
 SELECT 10, 'Antimagic Field', 8, '8th-level abjuration', '1 action', 'Self (10-foot radius sphere)', 'V, S, M (a pinch of powdered iron or iron filings)', 'Concentration, up to 1 hour', 'A 10-foot sphere surrounds you in which magic does not function. Spells can''t be case, summoned creatures disappear, and magic items become mundane within sphere. <br>Spells are suppressed within the sphere, but still consume their duration, and resume when the sphere no longer suppresses them.<br>Artifacts and deity magic are unaffected by this spell.', '' FROM dual UNION ALL 
 SELECT 11, 'Aura of Life', 4, '4th-level abjuration', '1 action', 'Self (30-foot radius)', 'V', 'Concentration, up to 10 minutes', 'A 30-foot radius aura emanates from you. Nonhostile creatures within the aura get resistance against necrotic damage and cannot have their HP Max reduced. Any living creature who has 0 HP gains 1 HP within the aura.', '' FROM dual UNION ALL 
 SELECT 12, 'Aura of Purity', 4, '4th-level abjuration', '1 action', 'Self (30-foot radius)', 'V', 'Concentration, up to 10 minutes', 'Each nonhostile creature (including you) within range has resistance against Poison damage, cannot become diseased, and has advantage against the Blinded, Charmed, Deafened, Frightened, Paralyzed, Poisoned, and Stunned conditions.', '' FROM dual UNION ALL 
 SELECT 13, 'Aura of Vitality', 3, '3rd-level evocation', '1 action', 'Self (30-foot radius)', 'V', 'Concentration, up to 1 minute', 'You can use a bonus action to heal one creature within range, including yourself, to regain 2d6 hit points. This can be done each round during the duration.', '' FROM dual UNION ALL 
 SELECT 14, 'Awaken', 5, '5th-level transmutation', '8 hours', 'Touch', 'V, S, M (an agate worth 1,000 gp, which the spell consumes)', 'Instantaneous', 'After spending the casting time tracing pathways in the gemstone focus, you touch a Huge or smaller beast or plant with an Intelligence of 3 or less. The touched plant or beast gains awareness, the ability to move, an Intelligence of 10 and the ability to speak one language you know.<br>The awakened creature is charmed by you for 30 days or until you or your allies harm it.', '' FROM dual UNION ALL 
 SELECT 15, 'Bane', 1, '1st-level enchantment', '1 action', '30 feet', 'V, S, M (a drop of blood)', 'Concentration, up to 1 minute', 'Up to three creatures within range must make a Charisma save. On a failure a creature must roll 1d4 and subtract the result from all attack rolls and saving throws for the duration.', 'For each slot level above 1st used for this spell, target one additional creature.' FROM dual UNION ALL 
 SELECT 16, 'Banishing Smite', 5, '5th-level abjuration', '1 bonus action', 'Self', 'V', 'Concentration, up to 1 minute', 'Your next attack deals an extra 5d10 force damage. If that attack reduces the target to 50 HP or less it is banished. If native to another plane, it goes home, if native to the current plane, it is banished to a demiplane for the duration of the spell. Creatures return from said demiplane when the duration ends in the condition it left in, but is incapacitated while in the demiplane.', '' FROM dual UNION ALL 
 SELECT 17, 'Banishment', 4, '4th-level abjuration', '1 action', '60 feet', 'V, S, M (an item distasteful to the target)', 'Concentration, up to 1 minute', 'Target must succeed a Charisma saving throw or be banished to another plane of existence. If the target is native to the current plane it is banished to a demiplane for the duration, but returns in the same condition. If it is native to another plane it is returned there.', 'You can target one additional creature for every slot level above 4th used for this spell.' FROM dual UNION ALL 
 SELECT 18, 'Barkskin', 2, '2nd-level transmutation', '1 action', 'Tough', 'V, S, M (a handful of oak bark)', 'Concentration, up to 1 hour', 'Touched creature''s AC cannot be less than 16 for the duration and takes on a rough, bark-like appearance.', '' FROM dual UNION ALL 
 SELECT 19, 'Beacon of Hope', 3, '3rd-level abjuration', '1 action', '30 feet', 'V, S', 'Cocentration, up to 1 minute', 'Choose any number of creatures within range. Those affected have advantage on Wisdom and death saving throws, and recovers the maximum number of HP possible from healing effects.', '' FROM dual UNION ALL 
 SELECT 20, 'Beast Sense', 2, '2nd-level divination', '1 action', 'Touch', 'S', 'Concentration, up to 1 hour', 'You touch a willing beast and for the duration you see what the beast sees and hear what it hears. ', '' FROM dual UNION ALL 
 SELECT 21, 'Antipathy/Sympathy', 8, '8th-level enchantment', '1 hour', '60 feet', 'V, S, M (a lump of alum soaked in vinegar for Antipathy or honey for Sympathy)', '10 days', 'You select a Huge or smaller creature or an area of no more than a 200-foot cube and a type of intelligent creature. <br>For Antipathy the selected creature type must make a Wisdom saving throw or must flee the target of the spell until it is out of sight for the duration.<br>For Sympathy the selected creature type must make a Wisdom saving throw or must draw closer to the target of the spell for the duration.', '' FROM dual UNION ALL 
 SELECT 22, 'Arcane Eye', 4, '4th-level divination', '1 action', '30 feet', 'V, S, M (a bit of bat fur)', 'Concentration, up to 1 hour', 'You create an invisible floating eye that you can receive visual information from for the duration. The eye can be moved up to 30 feet per round and has no limit on how far away from you it can be, It cannot pass through solid objects, but can fit through a space as small as a 1-inch square. The eye has darkvision out to 30 feet.', '' FROM dual UNION ALL 
 SELECT 23, 'Arcane Gate', 6, '6th-level conjuration', '1 action', '500 feet', 'V, S', 'Concentration, up to 10 minutes', 'You create a set of two linked portals: one within 10 feet of you and one up to 500 feet away. The portal is 10 feet wide and can only be entered from one direction. The portal is invisible from behind and cannot be entered thusly. The portals can be rotated as a bonus action.', '' FROM dual UNION ALL 
 SELECT 24, 'Arcane Lock', 2, '2nd-level abjuration', '1 action', 'Touch', 'V, S, M (gold dust worth at least 25 gp, which the spell consumes)', 'Until dispelled', 'You choose a door, window, gate, chest, or other entryway and lock it magically. You can designate any number of creatures that can open it normally and can also designated a password that unlocks the object if spoken within 5 feet of it. Casting Knock on the object suppresses this effect for 10 minutes.<br>When affected by this spell the object''s DC to pick or break is increased by 10.', '' FROM dual UNION ALL 
 SELECT 25, 'Armor of Agathys', 1, '1st-level abjuration', '1 action', 'Self', 'V, S, M (a cup of water)', '1 hour', 'A magical frost envelops you, granting 5 temporary HP as well as dealing 5 cold damage to anything that strikes you while you have this temporary HP.', 'The temporary HP and cold damage both increase by 5 for each slot level spent above 1st for this spell.' FROM dual UNION ALL 
 SELECT 26, 'Arms of Hadar', 1, '1st-level conjuration', '1 action', 'Self (10-foot radius)', 'V, S', 'Instantaneous', 'Tendrils of dark energy erupt from you out to a 10-foot radius, attacking all creatures within 10 feet of you. Each creature within range make a Strength saving throw. Upon failure it takes 2d6 necrotic damage. Upon success it takes half damage.', 'The damage dealt by this spell increases by 1d6 for each slot level above 1st used.' FROM dual UNION ALL 
 SELECT 27, 'Astral Projection', 9, '9th-level necromancy', '1 hour', '10 feet', 'V, S, M (for each creature affected, you must provide a jacinth worth 10,000 gp and one ornately carved silver bar worth 100 gp)', 'Special', 'You and up to eight willing creatures project your astral selves into the Astral Plane.<br>Creatures are returned to their bodies when either: dismissed by you as an action; their astral bodies or regular bodies are dropped to 0 HP.<br>Your projections can enter other planes, transporting your bodies with you to the new Plane.', '' FROM dual UNION ALL 
 SELECT 28, 'Augury', 2, '2nd-level divination', '1 minute', 'Self', 'V, S, M (specially marked sticks, bones, or similar tokens worth 25 gp)', 'Instantaneous', 'You cast bones, play cards, or some other divination method to decipher how an event will work out within the next 30 minutes.', '' FROM dual UNION ALL 
 SELECT 29, 'Bestow Curse', 3, '3rd-level necromancy', '1 action', 'Touch', 'V, S', 'Concentration, up to 1 minute', 'The creature touched must make a Wisdom saving throw or receives one of the following effects: Disadvantage on checks and saves with on ability score; disadvantage on attack rolls against you; target makes a wisdom saving throw every turn or does nothing; or you spells and attacks deal an extra 1d8 damage.', 'The duration goes up to 10 minutes with a 4th level slot, 8 hours for 5th, 24 hours for 7th, and until dispelled for 9th.' FROM dual UNION ALL 
 SELECT 30, 'Bigby''s Hand', 5, '5th-level evocation', '1 action', '120 feet', 'V, S, M (an eggshell and a snakeskin glove)', 'Concentration, up to 1 minute', 'A Large hand with an AC of 20, a Strength of 26, and a Dexterity of 10 appears within range. It can move up to 60 feet per round and can attack with a punch (melee spell attack, 4d8 force damage), a push (Strength vs Athletics), a grab (Strength to grapple, 2d6 + spell ability mod damage), or to provide you cover.', 'Damage dealt by the fist and grasp deal an extra die of damage for each slot level above 5th used.' FROM dual UNION ALL 
 SELECT 31, 'Blade Barrier', 6, '6th-level evocation', '1 action', '90 feet', 'V, S', 'Concentration, up to 10 minutes', 'You create a wall of whirling blades that can manifest as a straight wall up to 100 feet long, 20 feet high, and 5 feet thick; or a ringed wall up to 60 feet in diameter. <br>When a creature enters the wall''s area it must make a Dexterity saving throw. It takes 6d10 slashing damage on a failed save, half damage with a success.', '' FROM dual UNION ALL 
 SELECT 32, 'Blade Ward', 0, 'Abjuration cantrip', '1 action', 'Self', 'V, S', '1 round', 'Until the end of your next turn you have resistance against bludgeoning, piercing, and slashing damage dealt by weapon attacks.', '' FROM dual UNION ALL 
 SELECT 33, 'Bless', 1, '1st-level enchantment', '1 action', '30 feet', 'V, S, M (a sprinkling of holy water)', 'Concentration, up to 1 minute', 'Up to three creatures within range can choose to add 1d4 to any attack roll made during the duration.', 'You can target one additional creature for every slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 34, 'Blight', 4, '4th-level necromancy', '1 action', '30 feet', 'V, S', 'Instantaneous', 'A target within range must make a Constitution save. On a failure it takes 8d8 necrotic damage and half damage on a success. This has no effect on undead or constructs.<br>If you target a plant creature or magical plant it makes the Constitution save at disadvantage. Nonmagical plants get no saving throw and simply withers and dies.', 'The damage increases by 1d8 for each slot level above 4th used for this spell.' FROM dual UNION ALL 
 SELECT 35, 'Blinding Smite', 3, '3rd-level evocation', '1 bonus action', 'Self', 'V', 'Concentration, up to 1 minute', 'Your next weapon attack deals an extra 3d8 radiant damage and blinds the target for the duration unless it makes a Constitution save.<br>A creature blinded by this spell makes a new save on each of its turns. On a success it is no longer blinded.', '' FROM dual UNION ALL 
 SELECT 36, 'Blindness/Deafness', 2, '2nd-level necromancy', '1 action', '30 feet', 'V', '', 'One creature within range must make a Constitution saving throw. If it fails it is blinded or deafened (your choice) for the duration. The creature can make a new save on each of its turns to end this effect.', 'You can target one additional creature for each slot level above 2nd used to cast this spell.' FROM dual UNION ALL 
 SELECT 37, 'Blink', 3, '3rd-level transmutation', '1 action', 'Self', 'V, S', '1 minute', 'At the start of every turn for the duration, rill 1d20. On a roll of 11 or higher you disappear into the Ethereal Plane. At the start of your next turn, and when the spell ends, you reappear in an unoccupied space within 10 feet of where you disappeared.', '' FROM dual UNION ALL 
 SELECT 38, 'Blur', 2, '2nd-level illusion', '1 action', 'Self', 'V', 'Concentration, up to 1 minute', 'Your body blurs and is obscured. All creatures who attack you during the duration suffer disadvantage. Creatures who do not rely on sight or who can see through illusions are immune to this effect.', '' FROM dual UNION ALL 
 SELECT 39, 'Branding Smite', 2, '2nd-level evocation', '1 bonus action', 'Self', 'V', 'Concentration, up to 1 minute', 'The next time you strike a for, it takes an extra 2d6 radiant damage and sheds dim light until the spell ends.', 'The damage dealt by this spell increases by 1d6 for each slot level above 2nd used.' FROM dual UNION ALL 
 SELECT 40, 'Burning Hands', 1, '1st-level evocation', '1 action', 'Self (15-foot cone)', 'V, S', 'Instantaneous', 'All creatures within a 15-foot cone in front of you take 3d6 fire damage, but take half damage on a successful Dexterity saving throw. This also ignites all flammable objects in range as well.', 'The damage dealt by this spell increases by 1d6 for every slot level above 1st used during casting.' FROM dual UNION ALL 
 SELECT 41, 'Call Lightning', 3, '3rd-level conjuration', '1 action', '120 feet', 'V, S', 'Concentration, up to 1 minute', 'A storm cloud appears 100 feet above you which strikes lightning down on a point you designate within range. Each creature within 5 feet of that point must make a Dexterity saving throw. Creatures take 3d10 damage on a failed save, half on a success.<br>You can use this effect again each round as an action until the duration expires.', 'The damage of this spell increases by 1d10 for each slot level above 3rd used in casting.' FROM dual UNION ALL 
 SELECT 42, 'Calm Emotions', 2, '2nd-level enchantment', '1 action', '60 feet', 'V, S', 'Concentration, up to 1 minute', 'All creatures within 20 feet of a point you designate within range make a Charisma saving throw or suffer from one of two effects:<br>Suppress charm or frightened effects; or<br>Make targets indifferent to creatures it was hostile toward.<br>Creatures can willingly fail the Charisma saving throw.', '' FROM dual UNION ALL 
 SELECT 43, 'Chain Lightning', 6, '6th-level evocation', '1 action', '150 feet', 'V, S, M (a bit of fur; a piece of amber, glass, or a crystal rod; and three silver pins)', 'Instantaneous', 'A bolt of lightning strikes a target within range, then lances out to strike up to three additional targets within 30 feet of the first. Creatures struck by this take 10d8 damage, halved by a successful Dexterity saving throw.', 'An additional bolt of lightning leaps from the first target to additional targets for each slot level above 6th used.' FROM dual UNION ALL 
 SELECT 44, 'Charm Person', 1, '1st-level enchantment', '1 action', '30 feet', 'V, S', '1 hour', 'You target one creature within range. That creature must make a Wisdom saving throw. If it fails it regards you as friendly for the duration or until you or an ally cause harm to it. When the duration ends the creature is aware it was charmed by you.', 'You can target one additional creature for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 45, 'Chill Touch', 0, 'Necromancy cantrip', '1 action', '120 feet', 'V, S', '1 round', 'Make a ranged spell attack against a creature within range. The target takes 1d8 necrotic damage and can''t regain HP until the start of your next turn. If this hits an undead target, it also has disadvantage on attack rolls until the end of your next turn.<br>This spell''s damage increases to 2d8 at 5th level, 3d8 at 11th, and 4d8 at 17th.', '' FROM dual UNION ALL 
 SELECT 46, 'Chromatic Orb', 1, '1st-level evocation', '1 action', '120 feet', 'V, S, M (a diamond worth 50 gp)', 'Instantaneous', 'Make a ranged spell attack. This spell deals 2d8 cold, fire, electricity, acid, poison, or thunder damage (your choice).', 'The damage increases by 1d8 for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 47, 'Circle of Death', 6, '6th-level necromancy', '1 action', '150 feet', 'V, S, M (the powder of a crushed black pearl worth at least 500 gp)', 'Instantaneous', 'Negative energy radiates out to 60 feet from a point you designate within range. Creatures within the area take 8d6 necrotic damage, halved on a successful Constitution saving throw.', 'The damage increases by 2d6 for each slot level above 6th used to cast this spell.' FROM dual UNION ALL 
 SELECT 48, 'Circle of Power', 5, '5th-level abjuration', '1 action', 'Self (30-foot radius)', 'V', 'Concentration, up to 10 minutes', 'A magical aura emanates from you granting all allies within 30 feet advantage against spells and other magical effects. Also, any creature under the effect of this spell makes a successful saving throw it takes no damage instead of half damage from spell effects.', '' FROM dual UNION ALL 
 SELECT 49, 'Clairvoyance', 3, '3rd-level divination', '10 minutes', '1 mile', 'V, S, M (a focus worth at least 100 gp, either a jeweled horn for hearing or a glass eye for seeing)', 'Concentration, up to 10 minutes', 'An invisible sensor appears in the place of your choosing that you can choose to either hear or see through.', '' FROM dual UNION ALL 
 SELECT 50, 'Clone', 8, '8th-level necromancy', '1 hour', 'Touch', 'V, S, M (a diamond worth at least 1,000 gp and at least 1 cubic inch of flesh from a creature, and a vessel large enough to hold', 'Instantaneous', 'This spell creates an inert duplicate that is formed inside a sealed vessel and reaches maturity after 120 days. If the target of the spell dies after the clone reaches maturity its soul is transferred to the clone.', '' FROM dual UNION ALL 
 SELECT 51, 'Cloud of Daggers', 2, '2nd-level conjuration', '1 action', '60 feet', 'V, S, M (a sliver of glass)', 'Concentration, up to 1 minute', 'You fill a 5-foot cube with spinning daggers for the duration. Creatures who enter the area or start their turn there take 4d4 slashing damage.', 'The damage increases by 2d4 for each slot level above 2nd used to cast this spell.' FROM dual UNION ALL 
 SELECT 52, 'Cloudkill', 5, '5th-level conjuration', '1 action', '120 feet', 'V, S', 'Concentration, up to 10 minutes', 'You fill a 20-foot radius area within range with yellow-green fog. Creatures who enter or start their turn in the fog take 5d8 poison damage, but can make a Constitution saving throw for half damage. ', 'The damage increases by 1d8 for each slot level above 5th used to cast this spell.' FROM dual UNION ALL 
 SELECT 53, 'Color Spray', 1, '1st-level illusion', '1 action', 'Self (15-foot cone)', 'V, S, M (a pinch of powder or sand that is colored red, yellow, and blue)', '1 round', 'Roll 6d10 to start this spell, it affects this many creatures in HP in a 15-foot cone in front of you. Starting with the creature with the lowest current HP, each creature affected by this spell is blinded for the duration. To be affected a creature must have equal to or less than the value remaining from the initial roll.', 'This spell affects an additional 2d10 HP for each slot level above 1st used.' FROM dual UNION ALL 
 SELECT 54, 'Command', 1, '1st-level enchantment', '1 action', '60 feet', 'V', '1 round', 'The target must pass a Wisdom saving throw or else follow a one-word command issued by you on its next turn. Commands can be: Approach; Drop; Flee; Grovel; Halt; or other one-word commands.', 'You can affect one additional creature within 30 feet of the initial target for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 55, 'Commune', 5, '5th-level divination (ritual)', '1 minute', 'Self', 'V, S, M (incense and a vial or holy or unholy water)', '1 minute', 'You contact your deity or a deity''s proxy and may ask up to three questions over the duration and receive true, yes-or-no answers. ', '' FROM dual UNION ALL 
 SELECT 56, 'Commune with Nature', 5, '5th-level divination (ritual)', '1 minute', 'Self', 'V, S', 'Instantaneous', 'This spell grants you knowledge of up to to three facts about the surrounding 3 miles if outdoors, or 300 feet if underground. You choose three from: terrain and bodies of water; prevalent plants, minerals, animals or peoples; powerful celestials, fey, fiends, elementals or undead; influence from other planes; or buildings.', '' FROM dual UNION ALL 
 SELECT 57, 'Compelled Duel', 1, '1st-level enchantment', '1 bonus action', '30 feet', 'V', 'Concentration, up to 1 minute', 'The target must make a Wisdom saving throw or be drawn into a duel with you. On a failed save, the target has disadvantage on attack rolls against anyone but you and must make a Wisdom save if it attempts to move farther than 30 feet away from you.<br>This effect ends if you attack or cast a spell on a creature other than the target, if an ally damages the target, or if you end your turn more than 30 feet away from the target.', '' FROM dual UNION ALL 
 SELECT 58, 'Comprehend Languages', 1, '1st-level divination (ritual)', '1 action', 'Self', 'V, S, M (a pinch of soot and salt)', '1 hour', 'For the duration you understand the literal meaning of any language spoken near you and can read any language written, provided you are touching the surface on which it is written.', '' FROM dual UNION ALL 
 SELECT 59, 'Compulsion', 4, '4th-level enchantment', '1 action', '30 feet', 'V, S', 'Concentration, up to 1 minute', 'Creatures of your choice that you can see within range must make a Wisdom saving throw. Upon failure the affected creatures must use as much of their movement as possible to move in the direction you designate. After moving this way the creature can make another Wisdom save to end this effect.<br>Creatures cannot be compelled to move into dangerous areas (burning building, spike pit, etc.) but will provoke opportunity attacks through movement.', '' FROM dual UNION ALL 
 SELECT 60, 'Cone of Cold', 5, '5th-level evocation', '1 action', 'Self (60-foot cone)', 'V, S, M ( a small crystal or glass cone)', 'Instantaneous', 'A 60-foot cone of cold air erupts from your hands, dealing 8d8 cold damage to all creatures within the area. Creatures make a Constitution saving throw to take half damage. Creatures killed by this spell become frozen statues.', 'The damage increases by 1d8 for each slot level above 5th used to cast this spell.' FROM dual UNION ALL 
 SELECT 61, 'Confusion', 4, '4th-level enchantment', '1 action', '90 feet', 'V, S, M (three nut shells)', 'Concentration, up to 1 minute', 'Creatures within a 10-foot radius sphere centered on a spot within range make a Wisdom save. On a failure, a creature must roll 1d10 at the start of its turn to determine its action.<br>1: Creature moves in a random direction; 2-6: The creature makes no movement or action; 7-8: Creature attacks a random nearby creature; 9-10: The creature moves and attacks normally.', 'The radius of influence increases by 5 feet for each slot level above 4th used to cast this spell.' FROM dual UNION ALL 
 SELECT 62, 'Conjure Animals', 3, '3rd-level conjuration', '1 action', '60 feet', 'V, S', 'Concentration, up to 1 hour', 'Fey spirits appear and take the form of: 1 beast of CR2 or lower; 2 beasts of CR1 or lower; 4 beasts of CR1/2 or lower; or 8 beasts of CR1/4 of lower.<br>The summoned creatures are friendly toward you and will obey your commands.', 'You summon twice as many creatures if a 5th-level slot is used, three times as many with a 7th-level slot, and four times as many with a 9th-level slot.' FROM dual UNION ALL 
 SELECT 63, 'Conjure Barrage', 3, '3rd-level conjuration', '1 action', 'Self (60-foot cone)', 'V, S, M (one piece of ammunition or a thrown weapon)', 'Instantaneous', 'You throw a weapon or shoot a piece of ammunition into the air to create a 60-foot cone of identical weapons that shoot forward, dealing 3d8 damage of the same type of the weapon or ammunition used. Creatures hit may make a Dexterity saving throw to take half damage.', '' FROM dual UNION ALL 
 SELECT 64, 'Conjure Celestial', 7, '7th-level conjuration', '1 minute', '90 feet', 'V, S', 'Concentration, up to 1 hour', 'You conjure a celestial of CR4 or lower in an unoccupied space within range. It will follow your commands and is considered friendly toward you.', 'If a 9th-level slot is used for this spell, you may conjure a Celestial of CR5 or lower.' FROM dual UNION ALL 
 SELECT 65, 'Conjure Elemental', 5, '5th-level conjuration', '1 minute', '90 feet', 'V, S, M (burning incense for air, soft clay for earth, sulfur and phosphorous for fire, or water and sand for water)', 'Concentration, up to 1 hour', 'You conjure an elemental of the chosen type and CR5 or lower in an unoccupied space within range. The elemental is friendly toward you and your allies and obeys your commands.', 'The CR of the summoned elemental increases by 1 for each slot level above 5th used to cast this spell.' FROM dual UNION ALL 
 SELECT 66, 'Conjure Fey', 6, '6th-level conjuration', '1 minute', '90 feet', 'V, S', 'Concentration, up to 1 hour', 'A fey spirit of CR6 or lower appears in the form of a beast of CR6 or lower. It is friendly toward you and your allies and follows your commands.', 'The CR of the Fey spirit increases by 1 for each slot level above 6th used to cast this spell.' FROM dual UNION ALL 
 SELECT 67, 'Conjure Minor Elementals', 4, '4th-level conjuration', '1 minute', '90 feet', 'V, S', 'Concentration, up to 1 hour', 'You summon: 1 elemental of CR2 or lower; 2 elementals of CR1 or lower; 4 elementals of CR1/2 or lower; or 8 elementals of CR1/4 or lower. These are friendly toward you and follow your commands.', 'When using a 6th-level slot to cast this spell, twice as many elementals appear, when using an 8th-level slot, three times as many appear.' FROM dual UNION ALL 
 SELECT 68, 'Conjure Volley', 5, '5th-level conjuration', '1 action', '150 feet', 'V, S, M (one piece of ammunition or one thrown weapon)', 'Instantaneous', 'You throw or fire one weapon or piece of ammunition into the air and choose a spot within the spell''s range. The weapon transforms into hundreds of duplicates that rain down in a 40-foot radius centered on the point you choose. Creatures in the area take 8d8 damage, but can make a Dexterity saving throw for half damage.', '' FROM dual UNION ALL 
 SELECT 69, 'Conjure Woodland Beings', 4, '4th-level conjuration', '1 action', '60 feet', 'V, S, M (one holly berry per creature summoned)', 'Concentration, up to 1 hour', 'You summon fey creatures that appear in one of the following forms: 1 fey of CR2 or lower; 2 fey of CR1 or lower; 4 fey of CR1/2 or lower; or 8 fey of CR1/4 or lower. The summoned creature(s) are friendly toward you and follow your commands.', 'When a 6th-level slot is used for this spell, double the number of fey summoned. If an 8th-level slot is used, triple it.' FROM dual UNION ALL 
 SELECT 70, 'Contact Other Plane', 5, '5th-level divination (ritual)', '1 minute', 'Self', 'V', '1 minute', 'You contact a demigod or other extraplanar being and can ask up to 5 questions with one-word answers. When casting the spell, you must make a DC15 Intelligence saving throw or take 6d6 psychic damage and become insane until your next long rest. When insane you cannot take actions and speak only in gibberish.', '' FROM dual UNION ALL 
 SELECT 71, 'Contagion', 5, '5th-level necromancy', '1 action', 'Touch', 'V, S', '7 days', 'Make a melee spell attack. On a hit the target must make one Constitution save per turn until it either fails or passes three times. Upon three failures, one of the following effects takes place:<br>Subject is blinded and has disadvantage on Wisdom saves and checks; subject has disadvantage on Strength checks, saves, and attacks; Subject has disadvantage on Charisma checks and vulnerability to all types of damage; Subject has disadvantage on Intelligence saves and checks and acts as if Confused in combat; Subject has disadvantage on Dexterity checks, saves, and attacks; or Subject has disadvantage on Constitution saves and checks and starts to bleed from any type of damage.', '' FROM dual UNION ALL 
 SELECT 72, 'Contingency', 6, '6th-level evocation', '10 minutes', 'Self', 'V, S, M (a statuette of yourself carved from ivory worth at least 1,500 gp)', '10 days', 'You cast this spell along with another spell of 5th level or lower and set a condition. When the condition is met, the second spell takes effect on you, even if it normally has the ability to affect other creatures.', '' FROM dual UNION ALL 
 SELECT 73, 'Continual Flame', 2, '2nd-level evocation', '1 action', 'Touch', 'V, S, M (ruby dust worth 50 gp, which the spell consumes)', 'Until dispelled', 'A flame the equivalent in brightness to a torch is created. It gives off no heat and doesn''t consume oxygen. A Continual Flame can be hidden or covered but never quenched.', '' FROM dual UNION ALL 
 SELECT 74, 'Control Water', 4, '4th-level transmutation', '1 action', '300 feet', 'V, S, M (a drop of water and a pinch of dust)', 'Concentration, up to 10 minutes', 'You take control of a 100-foot cube of standing water within range and manipulate it with: Flood, creating a 20-foot rise in water level; Part Water, making a trench; Redirect Flow, even over and around obstacles; or Vortex. Creatures can escape the Vortex with a Athletics saving throw, but take 2d8 bludgeoning damage every round they are in the vortex.', '' FROM dual UNION ALL 
 SELECT 75, 'Control Weather', 8, '8th-level transmutation', '10 minutes', 'Self (5-mile radius)', 'V, S, M (Burning incense and bits of earth and wood mixed with water)', 'Concentration, up to 8 hours', 'You take control of the weather within a 5-mile radius. You can alter the condition of the weather over the course of 1d4 x 10 minutes as often as you wish for the duration. ', '' FROM dual UNION ALL 
 SELECT 76, 'Cordon of Arrows', 2, '2nd-level transmutation', '1 action', '5 feet', 'V, S, M (four or more arrows or bolts)', '8 hours', 'You stick four pieces of ammunition in the ground near you when you cast the spell. Whenever a creature other than you comes within 30 feet of you one piece of ammunition flies at it and attacks. That creature must make a Dexterity save or take 1d6 piercing damage.', 'The amount of ammunition increases by 2 for each slot level above 2nd used to cast this spell.' FROM dual UNION ALL 
 SELECT 77, 'Counterspell', 3, '3rd-level abjuration', '1 reaction, which you take while within 60 feet of a spell being cast', '60 feet', 'S', 'Instantaneous', 'A creature within 60 feet of you attempting to cast a spell of 3rd level or lower fails. If the spell is 4th level or higher, you roll a spell check with a DC of 10 + the spell''s level.', 'When you cast this spell using a slot of higher than 3rd level, the interrupted spell has no effect if it is equal to or lower in level to the slot used.' FROM dual UNION ALL 
 SELECT 78, 'Create Food/Water', 3, '3rd-level conjuration', '1 action', '30 feet', 'V, S', 'Instantaneous', 'You create 45 pounds of food and 30 gallons of water on the ground or in containers nearby, enough to sustain up to fifteen humanoids or five steeds for 24 hours. The food is bland but nourishing and spoils after 24 hours if uneaten. The water is clean and doesn''t go bad.', '' FROM dual UNION ALL 
 SELECT 79, 'Create/Destroy Water', 1, '1st-level transmutation', '1 action', '30 feet', 'V, S, M (a drop of water if creating water or a few grains of sand if destroying water)', 'Instantaneous', 'You create up to 10 gallons of water within range in an open container or make rain in a 30-foot cube; or you destroy up to 10 gallons of water or a 30-foot cube of fog.', 'You create/destroy an additional 10 gallons of 5 cubic feet of water for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 80, 'Create Undead', 6, '6th-level necromancy', '1 minute', '10 feet', 'V, S, M (one clay pot full of grave dirt, one with brackish water, and an onyx worth 150 gp for each corpse)', 'Instantaneous', 'You can only cast this spell at night. You choose up to three medium or small corpses and turn them into Ghouls under your command. You must cast this spell again within 24 hours or the Ghouls will stop obeying you.', 'You can create and maintain additional creatures and creature types with higher slot levels.' FROM dual UNION ALL 
 SELECT 81, 'Creation', 5, '5th-level illusion', '1 minute', '30 feet', 'V, S, M (a tiny piece of matter of the type you wish to create)', 'Special', 'You pull shadow material from Shadowfell to create matter no larger than a 5-foot cube. <br>Vegetable matter: 1 day; Stone or Crystal: 12 hours; Precious metals: 1 hour; Gems: 10 minutes; or Adamantine or Mithral: 1 minute.', 'The size of the cube created grows by 5 feet for every slot level above 5th used to cast this spell.' FROM dual UNION ALL 
 SELECT 82, 'Crown of Madness', 2, '2nd-level enchantment', '1 action', '120 feet', 'V, S', 'Concentration, up to 1 minute', 'The target creature is charmed by you unless it passes a Wisdom saving throw. If charmed, the target must use its action before movement to attack a nearby creature that you designate. You must maintain the spell as an action each turn and the target can make a new Wisdom saving throw at the end of each round to end the spell.', '' FROM dual UNION ALL 
 SELECT 83, 'Crusader''s Mantle', 3, '3rd-level evocation', '1 action', 'Self (30-foot radius)', 'V', 'Concentration, up to 1 minute', 'A holy aura emanates from you, allowing all allies within 30 feet of you to deal an extra 1d4 radiant damage when it hits with a melee weapon attack.', '' FROM dual UNION ALL 
 SELECT 84, 'Cure Wounds', 1, '1st-level evocation', '1 action', 'Touch', 'V, S', 'Instantaneous', 'A creature you touch is healed a number of hit points equal to 1d8 + your spellcasting ability modifier. This has no effect on undead or constructs.', 'The hit points healed increase by 1d8 for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 85, 'Dancing Lights', 0, 'Evocation cantrip', '1 action', '120 feet', 'V, S, M (a bit of phosphorous or wychwood, or a glowworm)', 'Concentration, up to 1 minute', 'You create up to 4 torch-sized lights within range, each shedding light in a 10-foot radius. You can move the lights up to 60 feet per round as a bonus action, but the lights must remain within range of the spell and within 20 feet of each other.', '' FROM dual UNION ALL 
 SELECT 86, 'Darkness', 2, '2nd-level evocation', '1 action', '60 feet', 'V, M (bat fur and a drop of pitch or piece of coal)', 'Concentration, up to 10 minutes', 'a 15-foot radius sphere of darkness emanates from a point or object you designate within range. Darkvision and nonmagical light cannot pierce it. Completely covering the source of the darkness suppresses the effect.', '' FROM dual UNION ALL 
 SELECT 87, 'Darkvision', 2, '2nd-level transmutation', '1 action', 'Touch', 'V, S, M (either a pinch of dried carrot or an agate)', '8 hours', 'Touched creature gains Darkvision out to 60 feet for the duration.', '' FROM dual UNION ALL 
 SELECT 88, 'Daylight', 3, '3rd-level evocation', '1 action', '60 feet', 'V, S', '1 hour', 'Bright light emanates from a point or object you designate within range for the duration. Covering the source of the light suppresses the effect.', '' FROM dual UNION ALL 
 SELECT 89, 'Death Ward', 4, '4th-level abjuration', '1 action', ' Touch', 'V, S', '8 hours', 'The affected creature is protected somewhat against death. The first time the creature would drop to 0 HP, it instead drops to 1 HP and the spell ends. If the target is subject to an effect that would cause instant death without dealing damage, the effect is negated and the spell ends.', '' FROM dual UNION ALL 
 SELECT 90, 'Delayed Blast Fireball', 7, '7th-level evocation', '1 action', '150 feet', 'V, S, M (a tiny ball of bat guano and sulfur)', 'Concentration, up to 1 minute', 'You point at a spot and a tiny yellow light appears there for as long as you concentrate or release the effect. When the effect ends, the bead detonates out to a 20-foot radius damaging all creatures in range. Creatures make a Dexterity save for half damage. This deals 12d6 fire damage, increasing by 1d6 for each round the bead remains undetonated.', 'The damage increases by 1d6 for each slot level above 7th used to cast this spell.' FROM dual UNION ALL 
 SELECT 91, 'Demiplane', 8, '8th-level conjuration', '1 action', '60 feet', 'S', '1 hour', 'You create a door to a demiplane within range. The demiplane consists of a 30-foot cubed room. When the spell ends the doorway to the demiplane disappears and all creatures, inside and out, remain where they are. Subsequent castings of this spell can connect to the same demiplane or a new one.', '' FROM dual UNION ALL 
 SELECT 92, 'Destructive Wave', 5, '5th-level evocation', '1 action', 'Self (30-foot radius)', 'V', 'Instantaneous', 'A wave of force emanates from you, forcing all creatures within 30 feet to make a Constitution saving throw. Creatures take 5d6 thunder and 5d6 radiant or necrotic (your choice) damage from this and are knocked prone. Creatures who make the saving throw take half damage and are not knocked prone.', '' FROM dual UNION ALL 
 SELECT 93, 'Detect Evil & Good', 1, '1st-level divination', '1 action', 'Self', 'V, S', 'Concentration, up to 10 minutes', 'You know if there is an aberration, fiend, fey, celestial, elemental, or undead within 30 feet of you. You also know if a place or object within 30 feet has been consecrated or desecrated.', '' FROM dual UNION ALL 
 SELECT 94, 'Detect Magic', 1, '1st-level divination (ritual)', '1 action', 'Self', 'V, S', 'Concentration, up to 10 minutes', 'For the duration, you sense the presence of magic within 30 feet of you. If you sense magic this way, you can use your action to see a faint aura and determine the school of magic, if any.', '' FROM dual UNION ALL 
 SELECT 95, 'Detect Poison & Disease', 1, '1st-level divination', '1 action', 'Self', 'V, S, M (a yew leaf)', 'Concentration, up to 10 minutes', 'For the duration, you can sense the presence, location, and type of poison, disease, and poisonous creatures within 30 feet of you.', '' FROM dual UNION ALL 
 SELECT 96, 'Detect Thoughts', 2, '2nd-level divination', '1 action', 'Self', 'V, S, M (a piece of copper)', 'Concentration, up to 1 minute', 'You are able to read the surface thoughts of any creature within 30 feet using this spell. You can focus, as an action, to delve deeper into a creature''s thoughts. This can be used to determined if there are creatures with readable thoughts within 30 feet of you, even unseen.', '' FROM dual UNION ALL 
 SELECT 97, 'Dimension Door', 4, '4th-level conjuration', '1 action', '500 feet', 'V', 'Instantaneous', 'You and up to one willing medium-sized creature within 5 feet of you are instantly teleported to a designated spot within range. If you would arrive in a space already occupied by a creature, you and any creature you take with you take 4d6 force damage and the spell fails.', '' FROM dual UNION ALL 
 SELECT 98, 'Disguise Self', 1, '1st-level illusion', '1 action', 'Self', 'V, S', '1 hour', 'You change your appearance to that of your choosing, so long as it is still humanoid and no more than 1 foot taller or shorter than your natural height. This does not stand up to physical inspection. <br>To discern that you are disguised, a creature must spend an action and succeed on an Investigation check.', '' FROM dual UNION ALL 
 SELECT 99, 'Disintegrate', 6, '6th-level transmutation', '1 action', '60 feet', 'V, S, M (a lodestone and a pinch of dust)', 'Instantaneous', 'A thin green ray shoots from your finger, dealing 10d6 + 40 force damage to the target. Creatures struck can make a Dexterity saving throw for half damage. If this spell reduces a creature to 0 HP, it disintegrates into a pile of fine dust.', 'This deals an additional 3d6 damage for each slot level above 6th used to cast this spell.' FROM dual UNION ALL 
 SELECT 100, 'Dispel Evil & Good', 5, '5th-level abjuration', '1 action', 'Self', 'V, S, M (holy water or powdered silver and iron)', 'Concentration, up to 1 minute', 'Fey, Undead, Celestials, Fiends, and elementals have disadvantage on attack rolls against you. <br>You can touch a creature charmed, frightened, or possessed by one of the above creatures, ending that effect and this spell''s effect.<br>You can make a melee spell attack on a creature mentioned above. On a hit the creature must make a Charisma save or be sent to its home plane. This ends the spell''s effect.', '' FROM dual UNION ALL 
 SELECT 101, 'Dispel Magic', 3, '3rd-level abjuration', '1 action', '120 feet', 'V, S', 'Instantaneous', 'A single 3rd-level or lower spell effect within range chosen by you is dispelled. For 4th-level and higher effects, you must make a DC 10 + the spell''s level check to dispel it.', 'This automatically dispels a spell effect of an equal or lower level of the slot level used to cast it.' FROM dual UNION ALL 
 SELECT 102, 'Dissonant Whispers', 1, '1st-level enchantment', '1 action', '60 feet', 'V', 'Instantaneous', 'You whisper a melody that only one creature within range can hear. That creature takes 3d6 psychic damage and must use its reaction to move as far away from you as possible. A successful Wisdom saving throw halves the damage and the creature is not forced to move.', 'The damage increases by 1d6 for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 103, 'Divination', 4, '4th-level divination (ritual)', '1 action', 'Self', 'V, S, M (incense and a sacrificial offering, worth 25 gp, which the spell consumes)', 'Instantaneous', 'You contact a god or a god''s servants and can ask a single question pertaining to an activity to occur within the next 7 days and receive a truthful reply.', '' FROM dual UNION ALL 
 SELECT 104, 'Divine Favor', 1, '1st-level evocation', '1 bonus action', 'Self', 'V, S', 'Concentration, up to 1 minute', 'Your weapon attacks deal an extra 1d4 radiant damage until the spell ends.', '' FROM dual UNION ALL 
 SELECT 105, 'DIvine Word', 7, '7th-level evocation', '1 bonus action', '30 feet', 'V', 'Instantaneous', 'Any number of creatures within range are affected depending on their current HP. A Charisma saving throw negates these effects:<br><50 HP: deafened for 1 minute; <br><40 HP: deafened and blinded for 10 minutes; <br><30 HP: Blinded, deafened, and stunned for 1 hour; or<br><20 HP: killed instantly.', '' FROM dual UNION ALL 
 SELECT 106, 'Dominate Beast', 4, '4th-level enchantment', '1 action', '60 feet', 'V, S', 'Concentration, up to 1 minute', 'You take control of a beast within range for the duration, barring a successful Wisdom saving throw from it. You can order the beast to act as you say or use an action to control the beast precisely. Each time the controlled beast takes damage, it gets a new saving throw.', 'The duration goes up to 10 minutes with a 5th level slot, 1 hour with a 6th, or 8 hours with a 7th.' FROM dual UNION ALL 
 SELECT 107, 'Dominate Monster', 8, '8th-level enchantment', '1 action', '60 feet', 'V, S', 'Concentration, up to 1 minute', 'You take control of any creature within range, barring a successful Wisdom saving throw. You can order it telepathically or take precise control over it with an action. The creature gets a new saving throw whenever it takes damage.', 'When you cast this spell with a 9th-level slot, the duration is concentration, up to 8 hours.' FROM dual UNION ALL 
 SELECT 108, 'Dominate Person', 5, '5th-level enchantment', '1 action', '60 feet', 'V, S', 'Concentration, up to 1 minute', 'You take control of a humanoid within range that you can see, barring a successful Wisdom saving throw. You can control the humanoid telepathically or take precise control over it with an action. Each time the humanoid takes damage, it gets another saving throw.', 'The spell''s duration increases to 10 minutes if a 6th level slot is used, 1 hour for a 7th level slot, or 8 hours with an 8th level slot.' FROM dual UNION ALL 
 SELECT 109, 'Drawmij''s Instant Summons', 6, '6th-level conjuration (ritual)', '1 minute', 'Touch', 'V, S, M (a sapphire worth 1,000 gp)', 'Until dispelled', 'You inscribe a rune on an object weighing no more than 10 points. When you crush the ruby and speak the name of the item inscribed it instantly appears in your hands, or provides the location of the item if it is being held by another creature.', '' FROM dual UNION ALL 
 SELECT 110, 'Dream', 5, '5th-level illusion', '1 minute', 'Special', 'V, S, M (a handful of sand, a dab of ink, and a writing quill plucked from a sleeping bird)', '8 hours', 'You target any creature that is known to you that is on the same plane of existence. You, or a willing creature you touch, appears to the subject in a dream as a messenger. You can choose to make the messenger monstrous. Doing so deals 3d6 psychic damage to the subject upon waking up, barring a successful Wisdom saving throw.', '' FROM dual UNION ALL 
 SELECT 111, 'Druidcraft', 0, 'Transmutation cantrip', '1 action', '30 feet', 'V, S', 'Instantaneous', 'You create one of the following effects:<br>You create a tiny, harmless illusion that predicts the weather for the next 24 hours; or<br>You instantly make one plant bud or bloom; or<br>You create a harmless sensory effect; or<br>You instantly light or snuff a small campfire, torch, or candle.', '' FROM dual UNION ALL 
 SELECT 112, 'Earthquake', 8, '8th-level evocation', '1 action', '500 feet', 'V, S, M (a pinch of dirt, a piece of rock, and a lump of clay)', 'Concentration, up to 1 minute', 'A 100-foot radius area within range that you can see tremors and shakes, becoming difficult terrain. Creatures in the area must make a Dexterity saving throw or fall prone. Creatures casting a spell in the area must make a Constitution saving throw or the spell fails.', '' FROM dual UNION ALL 
 SELECT 113, 'Eldritch Blast', 0, 'Evocation cantrip', '1 action', '120 feet', 'V, S', 'Instantaneous', 'Make a ranged spell attack against a target within range. On a hit, the target takes 1d10 force damage.<br>At 5th level a second beam is created by this spell, a third at 11th, and a fourth at 17th. Beams can be directed at the same target or different ones. Make separate attack rolls for each beam.', '' FROM dual UNION ALL 
 SELECT 114, 'Elemental Weapon', 3, '3rd-level transmutation', '1 action', 'Touch', 'V, S', 'Concentration, up to 1 hour', 'A nonmagical weapon touched when you cast this spell becomes magical. It gets a +1 bonus on attack rolls and deals an extra 1d4 damage on hit of your choice of acid, cold, fire, lightning, or thunder damage.', 'When a 5th or 6th level slot is used for this spell, the attack bonus is +2 and the damage is +2d4. A 7th level or higher slot grants+3 to hit and +3d4 to damage.' FROM dual UNION ALL 
 SELECT 115, 'Enhance Ability', 2, '2nd-level transmutation', '1 action', 'Touch', 'V, S, M (fur or a feather from a beast)', 'Concentration, up to 1 hour', 'The touched creature gains Advantage on one type of ability check for the duration.', 'You can target one additional creature for every slot above 2nd level used to cast this spell.' FROM dual UNION ALL 
 SELECT 116, 'Enlarge/Reduce', 2, '2nd-level transmutation', '1 action', '30 feet', 'V, S, M (a pinch of powdered iron)', 'Concentration, up to 1 minute', 'The target is enlarged or reduced by one size category for the duration. If Enlarged, its weapon attacks deal an extra 1d4 damage and has advantage on Strength checks and saving throws. If Reduced, its weapon attacks deal 1d4 less damage and has disadvantage on Strength saves and checks.<br>An unwilling target gets a Constitution saving throw to resist the effects of this spell.', '' FROM dual;
INSERT INTO SPELLS
 SELECT 117, 'Ensnaring Strike', 1, '1st-level conjuration', '1 bonus action', 'Self', 'V', 'Concentration, up to 1 minute', 'A writhing mass of thorny vines appear when you next strike with a weapon. The target must make a Strength saving throw or is restrained by the vines for the duration. While restrained, the target takes 1d6 piercing damage at the start of its turn. A restrained creature can spend an action to attempt a Strength check to break free of the vines.', 'The vines deal an additional 1d6 damage per round for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 118, 'Entangle', 1, '1st-level conjuration', '1 action', '90 feet', 'V, S', 'Concentration, up to 1 minute', 'Weeds and vines sprout from the ground in a 20-foot radius centered on a point within range, creating difficult terrain. Creatures in the area when you cast the spell must make a Strength saving throw or be restrained by the plants until the spell ends. A restrained creature can spend its action to make a Strength check to break free.', '' FROM dual UNION ALL 
 SELECT 119, 'Enthrall', 2, '2nd-level enchantment', '1 action', '60 feet', 'V, S', '1 minute', 'Creatures of your choice within range receive disadvantage on Perception checks to notice anything other than you for the duration. Creatures get a Wisdom saving throw to resist the effects of this spell, and creatures immune to charm cannot be affected.', '' FROM dual UNION ALL 
 SELECT 120, 'Etherealness', 7, '7th-level transmutation', '1 action', 'Self', 'V, S', 'Up to 8 hours', 'You partially enter the Ethereal Plane, allowing you to move through solid objects and even move in any direction for the duration. ', 'If you cast this spell using a slot of 8th level or higher, you can target up to three willing creatures for each slot level above 7th used.' FROM dual UNION ALL 
 SELECT 121, 'Evard''s Black Tentacles', 4, '4th-level conjuration', '1 action', '90 feet', 'V, S, M (a piece of tentacle from a giant squid or giant octopus)', 'Concentration, up to 1 minute', 'Black tentacles fill up a 20-foot square within range of the spell, creating difficult terrain. Creatures who enter or start their turn in the affected area must make a Dexterity saving throw. On a failure, they are restrained by the tentacles and take 3d6 bludgeoning damage. Creatures who start their turn restrained take 2d6 bludgeoning damage and can then choose to make either a Strength or Dexterity check to break free.', '' FROM dual UNION ALL 
 SELECT 122, 'Expeditious Retreat', 1, '1st-level transmutation', '1 bonus action', 'Self', 'V, S', 'Concentration, up to 10 minutes', 'You can use the Dash action immediately upon casting this spell, and can then use the Dash action as a bonus action each turn for the duration.', '' FROM dual UNION ALL 
 SELECT 123, 'Eyebite', 6, '6th-level necromancy', '1 action', 'Self', 'V, S', 'Concentration, up to 1 minute', 'You target one creature per turn up to 60 feet away to receive one of the following effects, negated by a Wisdom saving throw:<br>Asleep: target falls unconscious, can be awoken by damage or another creature using an action to wake it.<br>Panicked: target uses the Dash action to move as far away from you as possible<br>Sickened: target has disadvantage on attack rolls and ability checks, but can attempt a new save each round.', '' FROM dual UNION ALL 
 SELECT 124, 'Fabricate', 4, '4th-level transmutation', '10 minutes', '120 feet', 'V, S', 'Instantaneous', 'You take raw materials and fabricate a Large object in a 10-foot cube or up to 8 connected 5-foot cubes. If you are working with Stone, metal, or some other mineral substance, the fabricated product can be no larger than Medium.', '' FROM dual UNION ALL 
 SELECT 125, 'Faerie Fire', 1, '1st-level evocation', '1 action', '60 feet', 'V', 'Concentration, up to 1 minute', 'All objects in a 20-foot cube are outlined in blue, green, or violet light. Any creatures in the area are also outlined, unless the succeed on a Dexterity saving throw. Attack rolls made against outlined creatures have advantage and outlines creatures do not benefit from invisibility.', '' FROM dual UNION ALL 
 SELECT 126, 'False Life', 1, '1st-level necromancy', '1 action', 'Self', 'V, S, M (a small amount of alcohol or distilled spirits)', '1 hour', 'You gain 1d4 +4 temporary hit points for the duration.', 'You gain 5 additional temporary hit points for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 127, 'Fear', 3, '3rd-level illusion', '1 action', 'Self (30-foot cone)', 'V, S, M (a white feather or the heart of a hen)', 'Concentration, up to 1 minute', 'You project a phantasmal image in front of you. Each creature in a 30-foot cone must make a Wisdom saving throw or be frightened for the duration.<br>A frightened creature must take the Dash action to move away from you by the safest route on its turn. If it ends its turn in a place that does not have line of sight to you, it gets another Wisdom saving throw against this spell.', '' FROM dual UNION ALL 
 SELECT 128, 'Feather Fall', 1, '1st-level transmutation', '1 reaction, when you or a creature within 60 feet falls', '60 feet', 'V, S, M (a small feather or piece of down)', '1 minute', 'Choose up to five falling creatures within range. Affected creatures falling speed becomes 60 feet per round until the spell ends. If the creature lands before the spell ends it takes no falling damage and can land on its feet, ending the effect for that creature.', '' FROM dual UNION ALL 
 SELECT 129, 'Feeblemind', 8, '8th-level enchantment', '1 action', '150 feet', 'V, S, M (a handful of clay, crystal, glass, or mineral spheres)', 'Instantaneous', 'The target takes 4d6 psychic damage and must make an Intelligence saving throw. On a failed save, the target''s Intelligence and Charisma scores become 1. It can no longer cast spells or understand language, nor can it communicate in an intelligible way. It can still identify friends and act to protect them.<br>Every 30 days, the creature can attempt the saving throw again to end the effect. ', '' FROM dual UNION ALL 
 SELECT 130, 'Feign Death', 3, '3rd-level necromancy (ritual)', '1 action', 'Touch', 'V, S, M (a pinch of graveyard dirt)', '1 hour', 'You touch a willing creature and put it into a state of sleep similar to death. To all outward examinations, the creature is dead for the duration of the spell.', '' FROM dual UNION ALL 
 SELECT 131, 'Find Familar', 1, '1st-level conjuration (ritual)', '1 hour', '10 feet', 'V, S, M (10 gp worth of charcoal, incense, and herbs that must be consumed by fire in a brazier)', 'Instantaneous', 'You summon a familiar that is bonded to you in the form of a tiny animal. A familiar can deliver touch spells for you if desired.', '' FROM dual UNION ALL 
 SELECT 132, 'Find Steed', 2, '2nd-level conjuration', '10 minutes', '30 feet', 'V, S', 'Instantaneous', 'You summon a spirit that assumes the form of an unusually intelligent, strong, and loyal steed in the form of your choosing (horse, pony, mastiff, camel, elk, etc.)', '' FROM dual UNION ALL 
 SELECT 133, 'Find the Path', 6, '6th-level divination', '1 minute', 'Self', 'V, S, M (a set of divinatory tools worth 100 gp and an object from the location you wish to find)', 'Concentration, up to 1 day', 'The spell shows you the shortest, most direct route to your chosen destination. As long as the spell lasts and your destination is on the same plane of existence, you know the direction and distance to your destination.', '' FROM dual UNION ALL 
 SELECT 134, 'Find Traps', 2, '2nd-level divination', '1 action', '120 feet', 'V, S', 'Instantaneous', 'This spell reveals the presence of traps within range of the spell, but not their location.', '' FROM dual UNION ALL 
 SELECT 135, 'Finger of Death', 7, '7th-level necromancy', '1 action', '60 feet', 'V, S', 'Instantaneous', 'One creature within range takes 7d8 + 30 necrotic damage, and can make a Constitution saving throw for half damage. A humanoid killed by this spell is raised at the start of your next turn as a zombie permanently under your control.', '' FROM dual UNION ALL 
 SELECT 136, 'Fireball', 3, '3rd-level evocation', '1 action', '150 feet', 'V, S, M (a tiny ball of bat guano and sulfur)', 'Instantaneous', 'A 20-foot explosion of fire erupts from the target point, dealing 8d6 fire damage to all creatures within the area. Creatures make a Dexterity saving throw for half damage. Unattended flammable objects catch fire.', 'An additional 1d6 damage is dealt for each slot level above 3rd used to cast this spell.' FROM dual UNION ALL 
 SELECT 137, 'Fire Bolt', 0, 'Evocation cantrip', '1 action', '120 feet', 'V, S', 'Instantaneous', 'Make a Ranged spell attack. On hit, the target takes 1d10 fire damage. If this strikes an unattended flammable object, it catches on fire.', 'This spell''s damage increases to 2d10 at 5th level, 3d10 at 11th, and 4d10 at 17th.' FROM dual UNION ALL 
 SELECT 138, 'Fire Shield', 4, '4th-level evocation', '1 action', 'Self', 'V, S, M (a bit of phosphorous or a firefly)', '10 minutes', 'Flames envelop you, shedding bright light in a 10-foor radius around you. You can choose a warm shield or cold shield.<br>A warm shield grants you resistance to cold damage and deals 2d8 fire damage to a creature that strikes you. A cold shield grants fire resistance and deals 2d8 cold damage to creatures that strike you.', '' FROM dual UNION ALL 
 SELECT 139, 'Fire Storm', 7, '7th-level evocation', '1 action', '150 feet', 'V, S', 'Instantaneous', 'A storm of fire consisting of ten 10-foot cubes of fire appear, connected to one another, arranged as you wish. Creatures caught in the area take 7d10 fire damage, Dexterity save for half damage. You can choose if the fire ignites plant life or not.', '' FROM dual UNION ALL 
 SELECT 140, 'Flame Blade', 2, '2nd-level evocation', '1 bonus action', 'Self', 'V, S, M (leaf of sumac)', 'Concentration, up to 10 minutes', 'A scimitar of fire appears in your hand, shedding bright light in a 10-foot radius. You can use your action to make a melee attack with the fiery blade, dealing 3d6 fire damage on a hit.', 'The damage of the blade increases by 1d6 for every 2 slot levels above 2nd used to cast this spell.' FROM dual UNION ALL 
 SELECT 141, 'Flame Strike', 5, '5th-level evocation', '1 action', '60 feet', 'V, S, M (a bit of sulfur)', 'Instantaneous', 'A 10-foot radius, 40-foot high cylinder of divine fire appears in your designated location, dealing 4d6 fire and 4d6 radiant damage to all creatures within its effect. Creatures make a Dexterity saving throw for half damage.', 'Either the fire or radiant damage (your choice) increases by 1d6 for each slot level above 5th used to cast this spell.' FROM dual UNION ALL 
 SELECT 142, 'Flaming Sphere', 2, '2nd-level conjuration', '1 action', '60 feet', 'V, S, M (a bit of tallow, a pinch of brimstone, and a dusting of powdered iron)', 'Concentration, up to 1 minute', 'A 5-foot diameter sphere of fire appears where you designate. Creatures that end their turn within 5 feet of the sphere take 2d6 fire damage, Dexterity save for half damage. On your turn you can spend a bonus action to direct the sphere and move it up to 30 feet.', 'The damage increases by 1d6 for each slot level above 2nd used to cast this spell.' FROM dual UNION ALL 
 SELECT 143, 'Flesh to Stone', 6, '6th-level transmutation', '1 action', '60 feet', 'V, S, M (a pinch of lime, water, and earth)', 'Concentration, up to 1 minute', 'A creature within range must make a Constitution saving throw or start to turn into a statue. If the target fails its initial Constitution save, it then must make a Constitution save every round until it either passes or fails three times. If it passes three times the effect ends. If it fails three times it is turned to stone for the duration. If you maintain your concentration for the duration, the creature remains a statue until dispelled.', '' FROM dual UNION ALL 
 SELECT 144, 'Fly', 3, '3rd-level transmutation', '1 action ', 'Touch', 'V, S, M (a wing feather from any bird)', 'Concentration, up to 10 minutes', 'The touched subject gains a fly speed of 60 feet for the duration. The creature falls if it is still aloft when the effect ends and it can''t prevent itself from falling.', 'You can target one additional creature for each slot level above 3rd used to cast this spell.' FROM dual UNION ALL 
 SELECT 145, 'Fog Cloud', 1, '1st-level conjuration', '1 action', '120 feet', 'V, S', 'Concentration, up to 1 hour', 'You create a 20-foot radius cloud of fog centered on a point you designate within range. It lasts for the duration or until a moderate wind disperses it.', 'The radius of the cloud is extended by 20 feet for each slot level above first used to cast this spell.' FROM dual UNION ALL 
 SELECT 146, 'Forbiddance', 6, '6th-level abjuration', '10 minutes', 'Touch', 'V, S, M (a sprinkling of holy water, rare incense, and powdered ruby worth at least 1,000 gp)', '1 day', 'An area of 40,000 square feet (30 feet high) is protected against magical travel. Choose Elemental, Fey, Fiend, Celestial, or Undead when casting this spell. Creatures of the chosen type who enter or start their turn in the spell''s area take 5d10 radiant or necrotic damage (your choice).<br>If you cast Forbiddance every day for 30 days, the effect becomes permanent.', '' FROM dual UNION ALL 
 SELECT 147, 'Forcecage', 7, '7th-level evocation', '1 action', '100 feet', 'V, S, M (ruby dust worth 1,500 gp)', '1 hour', 'You create a cage (20 feet per side) or box (10 feet per side) of force to trap a creature or creatures inside. Creatures trapped cannot leave by nonmagical means and must succeed on a Charisma saving throw when attempting to leave through magical means. A failed Charisma save makes the spell attempted lost as well.', '' FROM dual UNION ALL 
 SELECT 148, 'Foresight', 9, '9th-level divination', '1 minute', 'Touch', 'V, S, M (a hummingbird feather)', '8 hours', 'You bestow a limited ability to see into the immediate future on a touched creature. This creature has advantage on all attack rolls, ability checks, and saving throws for the duration. Additionally, all attack rolls against the creature have disadvantage for the duration.<br>This spell ends if you cast it again before the effect expires.', '' FROM dual UNION ALL 
 SELECT 149, 'Freedom of Movement', 4, '4th-level abjuration', '1 action', 'Tough', 'V, S, M (a leather strap, bound around the arm or similar appendage)', '1 hour', 'A willing creature touched, for the duration, is unhampered by difficult terrain, cannot be restrained or paralyzed, can spend 5 feet of movement to escape nonmagical restraints, and has no movement penalty for being underwater.', '' FROM dual UNION ALL 
 SELECT 150, 'Friends', 0, 'Enchantment cantrip', '1 action', 'Self', 'S, M (a small amount of makeup applied during casting)', 'Concentration, up to 1 minute', 'You have advantage on all Charisma checks directed at one creature of your choice for the duration. When the spell ends, the creature knows it was magically manipulated and becomes hostile toward you.', '' FROM dual UNION ALL 
 SELECT 151, 'Gaseous Form', 3, '3rd-level transmutation', '1 action', 'Touch', 'V, S, M (a bit of gauze and a wisp of smoke)', 'Concentration, up to 1 hour', 'You transform a willing creature touched into a cloud for the duration. The creature can only fly, and only 10 feet per round. It has advantage on Strength, Dexterity, and Constitution checks and can pass through small holes and narrow openings. The creature cannot attack or cast spells while in gaseous form.', '' FROM dual UNION ALL 
 SELECT 152, 'Gate', 9, '9th-level conjuration', '1 action', '60 feet', 'V, S, M (a diamond worth at least 5,000 gp)', 'Concentration, up to 1 minute', 'You open a gate to another Plane of existence within range. The portal lasts for the duration and any creature can pass through it from one plane to the other. When you cast the spell, you may name a specific creature. If that creature is on the plane you are creating a Gate to, the portal opens next to it and draws it through to your plane. You have no control over it, however.', '' FROM dual UNION ALL 
 SELECT 153, 'Gaes', 5, '5th-level enchantment', '1 minute', '60 feet', 'V', '30 days', 'The targeted creature is given a service or task by you. It must make a Wisdom save to resist this effect. On a failed save, the creature must act to carry out the task demanded. The creature takes 5d10 psychic damage each time it performs an action that is counter to your instructions.', 'If you use a 7th or 8th level slot for this spell, the duration becomes 1 year. If you use a 9th level slot, it becomes permanent.' FROM dual UNION ALL 
 SELECT 154, 'Gentle Repose', 2, '2nd-level necromancy (ritual)', '1 action', 'Touch', 'V, S, M (a pinch of salt and one copper piece for each of the corpse''s eyes)', '10 days', 'A corpse you touch does not decay and cannot be turned into an undead for the duration. This also effectively extends the time limit on the spell Raise Dead', '' FROM dual UNION ALL 
 SELECT 155, 'Giant Insect', 4, '4th-level transmutation', '1 action', '30 feet', 'V, S', 'Concentration, up to 10 minutes', 'You transform up to ten centipedes, three spiders, five wasps, or one scorpion within range into giant versions of themselves for the duration.<br>You can verbally command the creatures and they act on your turn in combat. The spell ends when the duration expires or you dismiss the effect.', '' FROM dual UNION ALL 
 SELECT 156, 'Glibness', 8, '8th-level transmutation', '1 action', 'Self', 'V', '1 hour', 'Until the spell ends, you can treat any Charisma check as if you rolled a 15. Additionally, no matter what you say, magic that would determine truthfulness would indicate you are telling the truth.', '' FROM dual UNION ALL 
 SELECT 157, 'Globe of Invulnerability', 6, '6th-level abjuration', '1 action', 'Self (10-foot radius)', 'V, S, M (a glass or crystal bead that shatters when the spell ends)', 'Concentration, up to 1 minute', 'A shimmering barrier appears in a 10-foot radius around you. Any spell of 5th level or lower cast from outside the barrier cannot affect those inside it, even if the spell is cast using a higher slot level. ', 'The barrier blocks one slot level higher for each slot level above 6th used to cast this spell.' FROM dual UNION ALL 
 SELECT 158, 'Glyph of Warding', 3, '3rd-level abjuration', '1 hour', 'Touch', 'V, S, M (incense and powdered diamond worth at least 200 gp)', 'Until dispelled or triggered', 'You inscribe a glyph on a surface or object and set a trigger condition for it.<br>Explosive: when triggered an explosion of 5d8 elemental damage hits all within a 20-foot radius, Dexterity save for half damage; or Spell: You can store up to a 3rd level spell in the glyph to be cast when the glyph is triggered.', 'Damage and spell slots increase by 1d8 or 1 level for each slot level above 3rd used to cast this spell.' FROM dual UNION ALL 
 SELECT 159, 'Goodberry', 1, '1st-level transmutation', '1 action', 'Touch', 'V, S, M (a sprig of mistletoe)', 'Instantaneous', 'Up to ten magic-infused berries appear in your hand. Eating a berry restores 1 Hit Point and provide 24 hours worth of nourishment. The berries lose their potency if they have not been consumed within 24 hours.', '' FROM dual UNION ALL 
 SELECT 160, 'Grasping Vine', 4, '4th-level conjuration', '1 bonus action', '30 feet', 'V, S', 'Concentration, up to 1 minute', 'A vine sprouts from the ground in any space within range. The vine grabs at a creature up to 30 feet away from it that you can see. That creature must make a Dexterity saving throw or be pulled 20 feet toward the vine. Until the spell ends, the vine can lash out at the same creature or another one as a bonus action on your turn.', '' FROM dual UNION ALL 
 SELECT 161, 'Grease', 1, '1st-level conjuration', '1 action', '60 feet', 'V, S, M (a bit of pork rind or butter)', '1 minute', 'A 10-foot radius area of grease appears centered on a spot within range. All creatures in the area must make a Dexterity saving throw or fall prone. Creatures who enter or end their turn in the area must make a Dexterity saving throw or fall prone.', '' FROM dual UNION ALL 
 SELECT 162, 'Greater Invisibility', 4, '4th-level illusion', '1 action', 'Touch', 'V, S', 'Concentration, up to 1 minute', 'You or a creature you touch becomes invisible until the spell ends. Anything the target is wearing or carrying is invisible as long as it is on the target''s person.', '' FROM dual UNION ALL 
 SELECT 163, 'Greater Restoration', 5, '5th-level abjuration', '1 action', 'Touch', 'V, S, M (diamond dust worth at least 100 gp, which the spell consumes)', 'Instantaneous', 'You reduce to target''s exhaustion level by one, or end one of the following effects:<br>One Charm or Petrify effect; <br>one curse, including attunement to a cursed item;<br>any one ability score reduction; or<br>one max HP reduction', '' FROM dual UNION ALL 
 SELECT 164, 'Guardian of Faith', 4, '4th-level conjuration', '1 action', '30 feet', 'V', '8 hours', 'A Large guardian appears in an unoccupied space you designate within range. Whenever a creature comes within 10 feet of the guardian for the first time, it must make a Dexterity saving throw or take 20 radiant damage, half damage on a successful save. The guardian vanishes once it has dealt 60 damage, or the spell expires.', '' FROM dual UNION ALL 
 SELECT 165, 'Guards and Wards', 6, '6th-level abjuration', '10 minutes', 'Touch', 'V, S, M (burning incense, brimstone, oil, a knotted string, umber hulk blood, and a silver rod worth 10 gp)', '24 hours', 'up to 2,500 square feet is warded. Corridors fill with fog, doors are magically locked, stairways are filled with webs, and other effects of your choice. This effect can become permanent if cast every day for 1 year.<br>Dispel Magic can only remove one of these effects at a time.', '' FROM dual UNION ALL 
 SELECT 166, 'Guidance', 0, 'Divination cantrip', '1 action', 'Touch', 'V, S', 'Concentration, up to 1 minute', 'Before the spell ends, the touched creature can roll 1d4 and add the result to any one ability check.', '' FROM dual UNION ALL 
 SELECT 167, 'Guiding Bolt', 1, '1st-level evocation', '1 action', '120 feet', 'V, S', '1 round', 'Make a ranged spell attack against a target within range. The target takes 4d6 radiant damage and the next attack made against it before the end of your next turn has advantage. ', 'The damage increases by 1d6 for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 168, 'Gust of Wind', 2, '2nd-level evocation', '1 action', 'Self (60-foot line)', 'V, S, M (a legume seed)', 'Concentration, up to 1 minute', 'A blast of wind 60 feet long and 10 feet wide blasts from you in the direction you choose. Each creature that starts its turn in that area must make a Strength saving throw of be pushed 15 feet in the direction the wind is blowing. This wind disperses vapors and has a 50% chance to snuff out protected fires. You can redirect the wind each round as a bonus action.', '' FROM dual UNION ALL 
 SELECT 169, 'Hail or Thorns', 1, '1st-level conjuration', '1 bonus action', 'Self', 'V', 'Concentration, up to 1 minute', 'When next you make a ranged attack against a creature before the spell ends, thorns sprout from the weapon. The target of the attack and each creature within 10 take 1d10 piercing damage, Dexterity save for half damage.', 'The damage increases by 1d10 for each slot level above 1st used to cast this spell, to a maximum of 6d10.' FROM dual UNION ALL 
 SELECT 170, 'Hallow', 5, '5th-level evocation', '24 hours', 'Touch', 'V, S, M (herbs, oils, and incense worth at least 1,000 gp, which is consumed)', 'Until dispelled', 'A 60-foot radius area is infused with holy or unholy power. Celestials, Fey, Fiends, Undead, and Elementals cannot enter the area, unless you choose to exclude one or more of those groups upon casting. You can also bind an extra effect to the area: Courage, Darkness, Daylight, Energy Protection, Energy Vulnerability, Everlasting Rest, Extradimensional Interference, Fear, Silence, or Tongues.', '' FROM dual UNION ALL 
 SELECT 171, 'Hallucinatory Terrain', 4, '4th-level illusion', '10 minutes', '300 feet', 'V, S, M (a stone, a twig, and a bit of green plant)', '24 hours', 'A 150-foot cube within range is changed to look, sound, and smell like another type of terrain. Creatures entering the terrain can tell it is not real, and an Investigation check can be used to discern an illusion.', '' FROM dual UNION ALL 
 SELECT 172, 'Harm', 6, '6th-level necromancy', '1 action', '60 feet', 'V, S', 'Instantaneous', 'You deal 14d6 necrotic damage to a creature within range. It can make a Constitution saving throw for half damage. This spell cannot reduce a creature''s HP below 1. If the target failed its Constitution save, it has its Maximum HP reduced by the amount of damage the spell dealt for 1 hour. Any effect that removes disease removes this effect as well.', '' FROM dual UNION ALL 
 SELECT 173, 'Haste', 3, '3rd-level transmutation', '1 action', '30 feet', 'V, S, M (a shaving of licorice root)', 'Concentration, up to 1 minute', 'A willing creature within range has its speed doubled, gains +2 to AC, has advantage on Dexterity saving throws, and gains an additional action on each of its turns. That extra action can only be used to Attack (one weapon attack only), Dash, Disengage, Hide, or Use an Object.<br>When the effect ends, the creature cannot move or take actions until after its next turn.', '' FROM dual UNION ALL 
 SELECT 174, 'Heal', 6, '6th-level evocation', '1 action', '60 feet', 'V, S', 'Instantaneous', 'This spell heals 70 hit points to any creature within range, and also cures blindness, deafness, and any diseases affecting it. This has no effect on undead or constructs.', 'The creature heals an additional 10 hit points for every slot level above 6th used to cast this spell.' FROM dual UNION ALL 
 SELECT 175, 'Healing Word', 1, '1st-level evocation', '1 bonus action', '60 feet', 'V', 'Instantaneous', 'A creature of your choice that you can see within range is healed 1d4 + you spellcasting ability modifier hit points. This has no effect on undead or constructs.', 'The creature heals an extra 1d4 hit points for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 176, 'Heat Metal', 2, '2nd-level transmutation', '1 action', '60 feet', 'V, S, M (a piece of iron and a flame)', 'Concentration, up to 1 minute', 'Any creature within range that is in physical contact with a metal object takes 2d8 fire damage. If a creature is holding or wearing the object it takes damage from, it must make a Constitution saving throw or drop it, if possible. Creatures that do not drop the heated object have disadvantage on attack rolls and ability checks until the start of your next turn.', 'The damage increases by 1d8 for each slot level above 2nd used to cast this spell.' FROM dual UNION ALL 
 SELECT 177, 'Hellish Rebuke', 1, '1st-level evocation', '1 reaction, in response to being damaged', '60 feet', 'V, S', 'Instantaneous', 'You point your finger at a creature in range that just damaged you. It is wreathed in flame and takes 2d10 fire damage, Dexterity save for half damage.', 'The target takes an extra 1d10 damage for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 178, 'Heroes'' Feast', 6, '6th-level conjuration', '10 minutes', '30 feet', 'V, S, M (1 gem-encrusted bowl worth at least 1,000 gp)', 'Instantaneous', 'You summon forth a great feast that takes up to one hour to consume for up to 12 creatures. Any creature that partakes of the feast is cured of all diseases and poisons, is immune to poison and being frightened, has advantage on Wisdom saving throws, and has their Max HP increase by 2d10 for 24 hours.', '' FROM dual UNION ALL 
 SELECT 179, 'Heroism', 1, '1st-level enchantment', '1 action', 'Touch', 'V, S', 'Concentration, up to 1 minute', 'For the duration, the touched creature gains immunity to being Frightened and gains temporary HP equal to your spellcasting modifier each round. These temporary HP are lost when the spell ends.', 'You can target one additional creature for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 180, 'Hex', 1, '1st-level enchantment', '1 bonus action', '90 feet', 'V, S, M (the petrified eye of a newt)', 'Concentration, up to 1 hour', 'You curse a creature within range that you can see. For the duration you deal an extra 1d6 necrotic damage to the target with attacks and it has disadvantage on ability checks with one ability score. If the target drops to 0 hp before the spell ends, you can use a bonus action to shift the effect to a new creature.', 'The duration increases to 8 hours if a 3rd or 4th level slot is used to cast this spell, or 24 hours for a 5th level or higher.' FROM dual UNION ALL 
 SELECT 181, 'Hold Monster', 5, '5th-level enchantment', '1 action', '90 feet', 'V, S, M (a small, straight piece of iron)', 'Concentration, up to 1 minute', 'A creature within range must succeed on a Wisdom saving throw or be paralyzed for the duration. At the end of each of its turns, the creature can make a new saving throw to end the effect.', 'You can target one additional creature for each slot level above 5th used to cast this spell. All creatures targeted must be within 30 feet of each other.' FROM dual UNION ALL 
 SELECT 182, 'Hold Person', 2, '2nd-level enchantment', '1 action', '60 feet', 'V, S, M (a small, straight piece of iron)', 'Concentration, up to 1 minute', 'A humanoid within range must make a Wisdom saving throw or be paralyzed for the duration. A paralyzed humanoid can attempt a new saving throw at the end of each of its turns to end this effect.', 'You can target one additional humanoid for each slot level above 2nd used to cast this spell. All targets must be within 30 feet of each other.' FROM dual UNION ALL 
 SELECT 183, 'Holy Aura', 8, '8th-level abjuration', '1 action', 'Self', 'V, S, M (a tiny reliquary worth at least 1,000 gp containing a sacred relic)', 'Concentration, up to 1 minute', 'Creatures you choose within 30 feet of you have advantage on all saving throws for the duration, and creatures have disadvantage on attack rolls against them. If a Fiend or Undead attempts to attack a creature under the effect of this spell, it must make a Constitution saving throw or be blinded for the duration.', '' FROM dual UNION ALL 
 SELECT 184, 'Hunger of Hadar', 3, '3rd-level conjuration', '1 action', '150 feet', 'V, S, M (a pickled octopus tentacle)', 'Concentration, up to 1 minute', 'A 20-foot radius sphere of darkness appears within range. The area is difficult terrain and creatures in the area are blinded. Any creature that starts its turn in the area takes 2d6 cold damage and any creature that ends its turn in the area must make a Dexterity saving throw or take 2d6 acid damage.', '' FROM dual UNION ALL 
 SELECT 185, 'Hunter''s Mark', 1, '1st-level divination', '1 bonus action', '90 feet', 'V', 'Concentration, up to 1 hour', 'You choose a creature you can see within range. For the duration, you deal 1d6 extra damage to that creature with weapon attacks and you have advantage on Survival and Perception checks to locate it. If the target is dropped to 0 HP before the spell ends, you can designate a new target as a bonus action.', 'The duration increases to 8 hours if a 3rd or 4th level slot is used, and 24 hours for a 5th or higher.' FROM dual UNION ALL 
 SELECT 186, 'Hypnotic Pattern', 3, '3rd-level illusion', '1 action', '120 feet', 'S, M (a glowing stick of incense or a crystal vial filled with phosphorescent material)', 'Concentration, up to 1 minute', 'A hypnotic weave appears in a 30-foot cube within range. All creatures who see the pattern must make a Wisdom saving throw. On a failure, a creature becomes charmed for the duration. Creatures charmed this way are considered incapacitated and have a speed of 0. Damaging an affected creature ends the effect for that creature.', '' FROM dual UNION ALL 
 SELECT 187, 'Ice Storm', 4, '4th-level evocation', '1 action', '300 feet', 'V, S, M (a pinch of dust and a few drops of water)', 'Instantaneous', 'A 20-foot radius, 40-foot tall cylinder area within range becomes difficult terrain for 1 round. Any creature in that area takes 2d8 bludgeoning damage and 4d6 cold damage, halved with a successful Dexterity saving throw.', 'The bludgeoning damage increases by 1d8 for each slot level above 4th used to cast this spell.' FROM dual UNION ALL 
 SELECT 188, 'Identify', 1, '1st-level divination (ritual)', '1 minute', 'Touch', 'V, S, M (a pearl worth at least 100 gp)', 'Instantaneous', 'You learn the magical properties of any item you hold while casting this spell, as well as how to use those properties. You learn what spells are affecting the object, as well as whether it was created by a spell or not, and which spell.<br>If you touch a creature while casting this spell instead, you learn which spells, if any, are currently affecting it.', '' FROM dual UNION ALL 
 SELECT 189, 'Illusory Script', 1, '1st-level illusion (ritual)', '1 minute', 'Touch', 'S, M (a lead-based ink worth at least 10 gp, which the spell consumes)', '10 days', 'You write a message that appears only to those you designate when casting this spell. All others who read it see only an unintelligible gaggle of words, or a different message altogether.<br>A creature with True Sight can see the message as normal, whether designated or not.', '' FROM dual UNION ALL 
 SELECT 190, 'Imprisonment', 9, '9th-level abjuration', '1 minute', '30 feet', 'V, S, M (a vellum depiction of the target, as well as another component worth at least 500 gp per HD of the target)', 'Until dispelled', 'The targeted creature must make a Wisdom saving throw or be bound by this spell. Bound creatures can be: buried in a sphere of force, chained in place, banished to a tiny demiplane, shrunk to 1 inch and stuck in a gem, or put into magical slumber.<br>The spell can only be ended with a 9th-level Dispel Magic or with a condition that you set upon casting.', '' FROM dual UNION ALL 
 SELECT 191, 'Incendiary Cloud', 8, '8th-level conjuration', '1 action', '150 feet', 'V, S', 'Concentration, up to 1 minute', 'A 20-foot radius sphere of fiery fog appears centered on a spot in range. Creatures in the cloud must make a Dexterity saving throw. They take 10d8 fire damage on a failed save, half on a success. They must make the saving throw and take damage when entering the area or ending their turn in it.', '' FROM dual UNION ALL 
 SELECT 192, 'Inflict Wounds', 1, '1st-level necromancy', '1 action', 'Touch', 'V, S', 'Instantaneous', 'Make a melee spell attack on a creature you can reach. On a hit, the creature takes 3d10 necrotic damage.', 'The damage increases by 1d10 for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 193, 'Insect Plague', 5, '5th-level conjuration', '1 action', '300 feet', 'V, S, M (a few grains of sugar, some kernels of grain, and a smear of fat)', 'Concentration, up to 10 minutes', 'A 20-foot radius sphere of locusts appears centered on a spot within range. All within the sphere take 4d10 piercing damage, halved with a Constitution saving throw. Any creature that enters or ends their turn in the area take this damage.', 'the damage increases by 1d10 for each slot level above 5th used to cast this spell.' FROM dual UNION ALL 
 SELECT 194, 'Invisibility', 2, '2nd-level illusion', '1 action', 'Touch', 'V, S, M (an eyelash encased in gum arabic)', 'Concentration, up to 1 hour', 'A creature you touch becomes invisible for the duration. Anything the target is wearing or carrying is also invisible. The spell ends if the target attacks or casts a spell.', 'You can target one additional creature for each slot level above 2nd used to cast this spell.' FROM dual UNION ALL 
 SELECT 195, 'Jump', 1, '1st-level transmutation', '1 action', 'Touch', 'V, S, M (a grasshopper''s hind leg)', '1 minute', 'Touched creature''s jump distance is tripled for the duration.', '' FROM dual UNION ALL 
 SELECT 196, 'Knock', 2, '2nd-level transmutation', '1 action', '60 feet', 'V', 'Instantaneous', 'A mundane locked item is unlocked, unstuck, or unbarred. An arcane lock is suppressed for 10 minutes. This spell produces a knocking sound audible up to 300 feet away.', '' FROM dual UNION ALL 
 SELECT 197, 'Legend Lore', 5, '5th-level divination', '10 minutes', 'Self', 'V, S, M (incense worth 250 gp, and four ivory strips worth 50 gp each)', 'Instantaneous', 'You find out information about a legendary figure or item that you name. The lore is always accurate, but possibly vague.', '' FROM dual UNION ALL 
 SELECT 198, 'Leomund''s Secret Chest', 4, '4th-level conjuration', '1 action', 'Touch', 'V, S, M (an exquisite chest worth at least 5,000 gp and a tiny replica worth 50 gp)', 'Instantaneous', 'You hide a chest in the Ethereal Plane. You can summon it by touching the replica to recall it, sending it back the same way. After 60 days there is a cumulative 5% chance that the spell effect ends. If the chest is in the Ethereal Plane when this effect ends, it is irretrievably lost.', '' FROM dual UNION ALL 
 SELECT 199, 'Leomund''s Tiny Hut', 3, '3rd-level evocation (ritual)', '1 minute', 'Self (10-foot radius hemisphere)', 'V, S, M (a small crystal bead)', '8 hours', 'A 10-foot dome of force appears around and above you. Up to nine creatures plus you can fit inside the dome. Spells and other effects cannot be cast into or through the dome and you can control how bright it is inside. ', '' FROM dual UNION ALL 
 SELECT 200, 'Lesser Restoration', 2, '2nd-level abjuration', '1 action', 'Touch', 'V, S', 'Instantaneous', 'You touch a creature and end one disease or condition (blinded, deafened, paralyzed, or poisoned) affecting it.', '' FROM dual UNION ALL 
 SELECT 201, 'Levitate', 2, '2nd-level transmutation', '1 action', '60 feet', 'V, S, M (small leather loop or piece of golden wire)', 'Concentration, up to 10 minutes', 'One creature or object of your choice floats up to 20 feet up for the duration. A creature can move only by pushing or pulling along a solid object, like climbing. You can change the target''s altitude by 20 feet per round. If you are the target, you can move up or down as part of your movement.', '' FROM dual UNION ALL 
 SELECT 202, 'Light', 0, 'Evocation cantrip', '1 action', 'Touch', 'V, M (a firefly or phosphorescent moss)', '1 hour', 'You touch an object that is no larger than 10 feet in any one dimension. That object shines brightly for 20 feet, and dimly for 20 feet beyond that.', '' FROM dual UNION ALL 
 SELECT 203, 'Lightning Arrow', 3, '3rd-level transmutation', '1 bonus action', 'Self', 'V, S', 'Concentration, up to 1 minute', 'The weapon (if thrown) or piece of ammunition of your next ranged attack becomes a bolt of lightning. Make the attack roll as normal, but the target takes 4d8 lightning damage on a hit, half on a miss, instead of the weapon''s normal damage. Whether you hit or not, all creatures within 10 feet of the target must make a Dexterity saving throw. On a failure they take 2d8 lightning damage, half with a success.', 'The damage for both effects increases by 1d8 for each slot level above 3rd used to cast this spell.' FROM dual UNION ALL 
 SELECT 204, 'Lightning Bolt', 3, '3rd-level evocation', '1 action', 'Self (100-foot line)', 'V, S, M (a bit of fur and a rod of amber, crystal, or glass)', 'Instantaneous', 'A bolt of lightning lances out from you in a line 100 feet long by 5 feet wide. Creatures in the path take 8d6 lightning damage, Dexterity save for half damage.', 'The damage increases by 1d6 for each slot level above 3rd used to cast this spell.' FROM dual UNION ALL 
 SELECT 205, 'Locate Animals/Plants', 2, '2nd-level divination (ritual)', '1 action', 'Self', 'V, S, M (a bit of fur from a bloodhound)', 'Instantaneous', 'Concentrating on the name of a specific kind of beast or plant, you learn the location and distance to the closest one matching your description within 5 miles, if any.', '' FROM dual UNION ALL 
 SELECT 206, 'Locate Creature', 4, '4th-level divination', '1 action', 'Self', 'V, S, M (a bit of fur from a bloodhound)', 'Concentration, up to 1 hour', 'Describe or name a creature that is familiar to you, You sense the direction to the creature''s location if that creature is within 1,000 feet of you.', '' FROM dual UNION ALL 
 SELECT 207, 'Locate Object', 2, '2nd-level divination', '1 action', 'Self', 'V, S, M (a forked twig)', 'Concentration, up to 10 minutes', 'Describe or name an object that is familiar to you. If that object is within 1,000 feet of you then you know the direction and distance to it.', '' FROM dual UNION ALL 
 SELECT 208, 'Longstrider', 1, '1st-level transmutation', '1 action', 'Touch', 'V, S, M (a pinch of dirt)', '1 hour', 'Touched creature''s speed increases by 10 feet for the duration.', 'You can target one additional creature for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 209, 'Mage Armor', 1, '1st-level abjuration', '1 action', 'Touch', 'V, S, M (a piece of cured leather)', '8 hours', 'Touched creature gains a protective magical force, granting it an AC of 13 + Dexterity modifier. The spell ends if the target dons armor or if you dismiss the effect as an action.', '' FROM dual UNION ALL 
 SELECT 210, 'Mage Hand', 0, 'Conjuration cantrip', '1 action', '30 feet', 'V, S', '1 minute', 'A spectral, floating hand appears within range for the duration. You can move the hand up to 30 feet as an action. It can manipulate objects and open doors and containers. It cannot attack, activate magic items, or carry more than 10 pounds.', '' FROM dual UNION ALL 
 SELECT 211, 'Magic Circle', 3, '3rd-level abjuration', '1 minute', '10 feet', 'V, S, M (holy water or powdered silver and iron worth at least 100 gp)', '1 hour', 'A 10-foot radius, 20-foot tall cylinder appears and you select celestials, fey, fiends, elementals, or undead. The chosen creature cannot enter the circle, has disadvantage on those within the circle, and cannot charm or frighten those within the circle. <br>You can choose to reverse this effect to trap a creature in the circle instead.', 'The duration increases by 1 hour for each slot level above 3rd used to cast this spell.' FROM dual UNION ALL 
 SELECT 212, 'Magic Jar', 6, '6th-level necromancy', '1 minute', 'Self', 'V, S, M (a gem, crystal, reliquary, or other container worth 5,000 gp)', 'Until dispelled', 'Your soul leaves your body and inhabits the container. You can attempt to possess a creature within 100 feet of the container. The target must make a Charisma save. On a failure your soul switches with that of the creature and you control its body. You can leave the possessed body and return to the container or your own body when you choose.', '' FROM dual UNION ALL 
 SELECT 213, 'Magic Missile', 1, '1st-level evocation', '1 action', '120 feet', 'V, S', 'Instantaneous', 'Three glowing darts of force each strike a creature of your choosing, dealing 1d4 + 1 force damage each. You can direct the darts at separate targets or all at one, as you wish.', 'One more dart is created for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 214, 'Magic Mouth', 2, '2nd-level illusion (ritual)', '1 minute', '30 feet', 'V, S, M (a small bit of honeycomb and jade dust worth at least 10 gp)', 'Until; dispelled', 'You speak a message and set a trigger condition for the message to be delivered. You can choose to have the spell end when the message is delivered or repeat the message each time the trigger condition is met.', '' FROM dual UNION ALL 
 SELECT 215, 'Magic Weapon', 2, '2nd-level transmutation', '1 bonus action', 'Touch', 'V, S', 'Concentration, up to 1 hour', 'For the duration, a Weapon touched gains a +1 bonus to attack rolls and damage rolls.', 'The bonus to attacks and damage increases to +2 with a 4th level or higher slot or +3 with a 6th level or higher slot.' FROM dual UNION ALL 
 SELECT 216, 'Major Image', 3, '3rd-level illusion', '1 action', '120 feet', 'V, S, M (a bit of fleece)', 'Concentration, up to 10 minutes', 'You create an image that moves, smells, and even gives off temperature appropriate to the image it depicted. As long as you are in range of the illusion, you can control it and alter its appearance so as to appear realistic. A creature who uses its action to examine the illusion can make an Investigation check to determine the reality of the illusion.', 'If you cast this spell with a slot of 6th level or higher it does not require your concentration to be maintained.' FROM dual UNION ALL 
 SELECT 217, 'Mass Cure Wounds', 5, '5th-level conjuration', '1 action', '60 feet', 'V, S', 'Instantaneous', 'Choose up to 6 creatures within 30 feet of a point you choose within range. Each creature regains 3d8 + your spellcasting modifier hit points. This spell has no effect on undead or constructs.', 'The hit points regained increases by 1d8 for each slot level above 5th used to cast this spell.' FROM dual UNION ALL 
 SELECT 218, 'Mass Heal', 9, '9th-level conjuration', '1 action', '60 feet', 'V, S', 'Instantaneous', 'You heal up to 700 total hit points spread out over any number of creatures within range. Creatures healed by this spell are cured of all diseases and of any effect making them blind or deafened. This spell has no effect on undead or constructs.', '' FROM dual UNION ALL 
 SELECT 219, 'Mass Healing Word', 3, '3rd-level evocation', '1 action', '60 feet', 'V', 'Instantaneous', 'Up to six creatures within range regain hit points equal to 1d4 + your spellcasting ability modifier. This has no effect on undead or constructs.', 'Creatures heal an additional 1d4 for each slot level above 6th used to cast this spell.' FROM dual UNION ALL 
 SELECT 220, 'Mass Suggestion', 6, '6th-level enchantment', '1 action', '60 feet', 'V, M (a snake''s tongue and either a bit of honeycomb or a drop of sweet oil)', '24 hours', 'You suggest a course of action and magically influence up to twelve creatures within range to perform that action. Each target makes a Wisdom saving throw or is compelled to complete the suggested task.', 'The duration increases to 10 days with a 7th level slot, 30 days with an 8th, and a year and a day with a 9th.' FROM dual UNION ALL 
 SELECT 221, 'Maze', 8, '8th-level conjuration', '1 action', '60 feet', 'V, S', 'Concentration, up to 10 minutes', 'You banish a creature you can see within range into a labyrinthine demiplane. The target remains there until the spell expires or it escapes the maze. <br>The target can use its action to make an Intelligence check to escape the maze (a minotaur or goristro demon automatically succeeds). The target reappears in the space it left when the spell ends.', '' FROM dual UNION ALL 
 SELECT 222, 'Meld into Stone', 3, '3rd-level transmutation (ritual)', '1 action', 'Touch', 'V, S', '8 hours', 'You step into a stone object or surface large enough to fully contain your body. While merged with the stone you cannot see what occurs outside it. You remain aware of the passage of time and can cast spells on yourself. Leaving the stone ends the spell effect and you can only leave the stone where you entered it.', '' FROM dual UNION ALL 
 SELECT 223, 'Melf''s Acid Arrow', 2, '2nd-level evocation', '1 action', '90 feet', 'V, S, M (powdered rhubarb leaf and an adder''s stomach)', 'Instantaneous', 'Make a ranged spell attack against a target within range. On a hit, the arrow deals 4d4 acid damage immediately and 2d4 acid damage at the end of its next turn. On a miss the arrow deals half of the initial damage and no secondary damage.', 'Both the initial and secondary damage increases by 1d4 for each slot level above 2nd used to cast this spell.' FROM dual UNION ALL 
 SELECT 224, 'Mending', 0, 'Transmutation cantrip', '1 minute', 'Touch', 'V, S, M (two lodestones)', 'instantaneous', 'This spell repairs a single break or tear in an object you touch. This can physically restore a magic item or construct, but cannot restore the magical abilities to such items.', '' FROM dual UNION ALL 
 SELECT 225, 'Message', 0, 'Transmutation cantrip', '1 action', '120 feet', 'V, S, M (a short piece of copper wire)', '1 round', 'You point your finger at a creature within range and whisper a message. The target hears the message and can reply in a whisper that only you can hear.', '' FROM dual UNION ALL 
 SELECT 226, 'Meteor Swarm', 9, '9th-level evocation', '1 action', '1 mile', 'V, S', 'Instantaneous', 'Four orbs of fire hit the ground at different points you can see within range. Each orb deals 20d6 fire and 20d6 bludgeoning damage to creatures within a 40-foot radius of each impact with a Dexterity save for half damage. A creature in the area of more than one burst is only affected once.', '' FROM dual UNION ALL 
 SELECT 227, 'Mind Blank', 8, '8th-level abjuration', '1 action', 'Touch', 'V, S', '24 hours', 'For the duration, the touched target is immune to psychic damage, any effect that would read its emotions or thoughts, divination spells, and the charmed condition.', '' FROM dual UNION ALL 
 SELECT 228, 'Minor Illusion', 0, 'Illusion cantrip', '1 action', '30 feet', 'S, M (a bit of fleece)', '1 minute', 'You create a sound or image within range that lasts for the duration. ', '' FROM dual UNION ALL 
 SELECT 229, 'Mirage Arcane', 7, '7th-level illusion', '10 minutes', 'Sight', 'V, S', '10 days', 'You make terrain in an area up to 1 square mile look, sound, smell and even feel like some other sort of terrain. A creature with True Sight can see through the illusion to the terrain''s true form, but can still physically interact with the illusion. Any illusory object taken out of the area of effect disappears immediately.', '' FROM dual UNION ALL 
 SELECT 230, 'Mirror Image', 2, '2nd-level illusion', '1 action', 'Self', 'V, S', '1 minute', 'Three illusory duplicates of yourself appear in your space. Each time a creature targets you with an attack, roll 1d20 to determine whether the attack hits you or a duplicate. If all three duplicates are active, a roll of 6 or more hits a duplicate. If 2 duplicates, a roll of 8 or higher targets one. If 1 duplicate, a roll of 11 or higher targets it.', '' FROM dual UNION ALL 
 SELECT 231, 'Mislead', 5, '5th-level illusion', '1 action', 'Self', 'S', 'Concentration, up to 1 hour', 'You become invisible as an illusory double of yourself appears where you are standing. The double lasts for the duration, but your invisibility ends if you cast a spell or attack. You can use your action to direct the double up to twice your speed and make it gesture, speak and behave in any way you choose.', '' FROM dual UNION ALL 
 SELECT 232, 'Misty Step', 2, '2nd-level conjuration', '1 bonus action', 'Self', 'V', 'Instantaneous', 'Briefly surrounded by silvery mist, you teleport up to 30 feet to an unoccupied space that you can see.', '' FROM dual UNION ALL 
 SELECT 233, 'Modify Memory', 5, '5th-level enchantment', '1 action', '30 feet', 'V, S', 'Concentration, up to 1 minute', 'A creature that you can see within range makes a Wisdom saving throw or is charmed by you. While the charm lasts you can affect the target''s memory of an event that happened within the last 24 hours and lasted no more than 10 minutes.', 'By using a higher slot level, you can modify an event that happened up to 7 days ago (6th level), 30 days ago (7th level), 1 year ago (8th level), or any time in the creature''s past (9th level).' FROM dual UNION ALL 
 SELECT 234, 'Moonbeam', 2, '2nd-level evocation', '1 action', '120 feet', 'V, S, M (several seeds of any moonseed plant and a piece of opalescent feldspar)', 'Concentration, up to 1 minute', 'A 5-foot radius, 40-foot tall cylinder of silvery light fills an area within range. Any creature that enters or starts its turn in the area takes 2d10 radiant damage, halved with a Constitution saving throw.<br>On your turn you can move the beam up to 60 feet in any direction.', 'The damage increases by 1d10 for each slot level above 2nd used to cast this spell.' FROM dual UNION ALL 
 SELECT 235, 'Mordenkainen''s Faithful Hound', 4, '4th-level conjuration', '1 action', '30 feet', 'V, S, M (a tiny silver whistle, a piece of bone, and a thread)', '8 hours', 'You summon a phantom watchdog. Whenever a creature comes within 30 feet of it without speaking a designated password the hound starts barking loudly. The hound sees invisible creatures and even into the Ethereal Plane, and it ignores illusions. The hound can attempt to bite on your turn. It''s attack bonus is your spellcasting ability modifier + your proficiency bonus. On a hit it deals 4d8 piercing damage.', '' FROM dual;
INSERT INTO SPELLS
 SELECT 236, 'Mordenkainen''s Magnificent Mansion', 7, '7th-level conjuration', '1 minute', '300 feet', 'V, S, M (a mini portal carved from ivory, polished marble, and a tiny silver spoon)', '24 hours', 'You create an extradimensional dwelling, complete with near-transparent servants and a banquet of food fit for up to 100 people. ', '' FROM dual UNION ALL 
 SELECT 237, 'Mordenkainen''s  Private Sanctum', 4, '4th-level abjuration', '10 minutes', '120 feet', 'V, S, M (a think sheet of lead, piece of opaque glass, wad of cotton/cloth, and powdered chrysolite)', '24 hours', 'You make a cub between 5 and 100 feet on a side within the area that:<br>sound cannot pass through; prevents vision into; cannot be divined into; and cannot be teleported into or out of', 'You increase the size of one side by up to 100 feet for each slot level above 4th used to cast this spell.' FROM dual UNION ALL 
 SELECT 238, 'Mordenkainen''s Sword', 7, '7th-level evocation', '1 action', '60 feet', 'V, S, M (a miniature platinum sword worth 250 gp)', 'Concentration, up to 1 minute', 'A sword appears floating in the air. You can make a melee spell attack on a creature within 5 feet of the sword each turn. On a hit, the sword deals 3d10 force damage. You can move the sword up to 20 feet each round before attacking.', '' FROM dual UNION ALL 
 SELECT 239, 'Move Earth', 6, '6th-level transmutation', '1 action', '120 feet', 'V, S, M (an iron blade and a small bag of soil)', 'Concentration, up to 2 hours', 'You can reshape up to a 40 square foot area of terrain into any shape you want. Shaping the terrain takes 10 minutes and at the end of each 10 minute interval you can choose to reshape the area again.', '' FROM dual UNION ALL 
 SELECT 240, 'Nondetection', 3, '3rd-level abjuration', '1 action', 'Touch', 'V, S, M (a pinch of diamond dust worth 25 gp)', '8 hours', 'For the duration the creature you touch cannot be targeted by divination magic or perceived through magical scrying sensors. This effect can also be placed over an area or object no larger than 10 feet in any dimension.', '' FROM dual UNION ALL 
 SELECT 241, 'Nystul''s Magic Aura', 2, '2nd-level illusion', '1 action', 'Touch', 'V, S, M (a small square of silk)', '24 hours', 'The target creature or unattended object receives either a false aura when under the gaze of Detect Magic, or changing the way the creature or object is perceived by effects like a paladin''s Divine Sense.', '' FROM dual UNION ALL 
 SELECT 242, 'Otiluke''s Freezing Sphere', 6, '6th-level evocation', '1 action', '300 feet', 'V, S, M (a small crystal sphere)', 'Instantaneous', 'A small globe of frozen energy streaks to a point within range and explodes in a 60-foot radius sphere. Creatures in the area take 10d6 cold damage, with a Constitution saving throw for half damage. Water in the area is frozen up to 6 inches thick for 1 minute.', 'The damage increases by 1d6 for each slot level above 6th used to cast this spell.' FROM dual UNION ALL 
 SELECT 243, 'Otiluke''s Resilient Sphere', 4, '4th-level evocation', '1 action', '30 feet', 'V, S, M (a hemispherical piece of clear crystal and gum arabic)', 'Concentration, up to 1 minute', 'A sphere of force encloses a Large or smaller creature within range. An unwilling creature can attempt a Dexterity saving throw to avoid the effect. The sphere is impenetrable and immune to all damage. An enclosed creature can push against the sphere, making it roll up to half their speed.<br>A Disintegrate spell destroys the sphere without harming anything inside it.', '' FROM dual UNION ALL 
 SELECT 244, 'Otto''s Irresistable Dance', 6, '6th-level enchantment', '1 action', '30 feet', 'V', 'Concentration, up to 1 minute', 'A creature within range starts dancing in place, using all of its movement each turn to dance. Creatures immune to charm cannot be affects. Dancing creatures have disadvantage on Dexterity saving throws and attack rolls, and anyone attacking a dancing creature has advantage.<br>As an action, a dancing creature can make a Wisdom saving throw to end this effect.', '' FROM dual UNION ALL 
 SELECT 245, 'Pass Without Trace', 2, '2nd-level abjuration', '1 action', 'Self', 'V, S, M (ashes from a burned leaf of mistletoe and a sprig of spruce)', 'Concentration, up to 1 hour', 'For the duration, creatures you choose within 30 feet get a +10 bonus on Stealth checks and cannot be tracked by nonmagical means.', '' FROM dual UNION ALL 
 SELECT 246, 'Passwall', 5, '5th-level transmutation', '1 action', '60 feet', 'V, S, M (a pinch of sesame seeds)', '1 hour', 'A passage appears at a point you choose on a surface such as a wall, ceiling, or floor. The passage can be up to 20 feet deep. Any creature inside the passage when the spell expires is safely ejected to a spot nearest to the surface.', '' FROM dual UNION ALL 
 SELECT 247, 'Phantasmal Force', 2, '2nd-level illusion', '1 action', '60 feet', 'V, S, M (a bit of fleece)', 'Concentration, up to 1 minute', 'You create an illusion which appears only to one creature within range. The creature can make an Intelligence saving throw upon casting to ignore this effect. At any time, the creature can make an Investigation check to discover the illusion. Otherwise the creature treats the illusion as being real in every way, and can even take damage from it.', '' FROM dual UNION ALL 
 SELECT 248, 'Phantasmal Killer', 4, '4th-level illusion', '1 action', '120 feet', 'V, S', 'Concentration, up to 1 minute', 'You tap into the deepest fears of a target within range and make an illusory manifestation of it, visible only to that creature. The target must make a Wisdom saving throw or become frightened for the duration. Each turn while the effect is in place, the target must make a Wisdom saving throw or take 4d10 damage. On a successful save, the spell ends.', 'The damage increases by 1d10 for each slot level above 4th used to cast this spell.' FROM dual UNION ALL 
 SELECT 249, 'Phantom Steed', 3, '3rd-level illusion (ritual)', '1 minute', '30 feet', 'V, S', '1 hour', 'You conjure a large horselike creature within range that you or another creature of your choosing can ride. The horse can move up to 100 feet per round and can travel 10 miles in an hour, 13 at a fast pace.', '' FROM dual UNION ALL 
 SELECT 250, 'Planar Ally', 6, '6th-level conjuration', '10 minutes', '60 feet', 'V, S', 'Instantaneous', 'You beseech a god, demon prince, or some other powerful otherworldly entity for aid. It sends an Outsider to you which you can then bargain with for aid. The price is dependent on the task requested.', '' FROM dual UNION ALL 
 SELECT 251, 'Planar Binding', 5, '5th-level abjuration', '1 hour', '60 feet', 'V. S. M (a jewel worth at least 1,000 gp)', '24 hours', 'You bind a celestial, elemental, fiend, or fey to your service for the duration. The creature must be present for the entirety of the spellcasting and makes a Charisma saving throw. If it fails the save, it is bound to do your bidding for the duration.', 'The duration increases to 10 days if a 7th-level slot is used, 180 days for an 8th, and a year and a day for a 9th.' FROM dual UNION ALL 
 SELECT 252, 'Plane Shift', 7, '7th-level conjuration', '1 action', 'Touch', 'V, S, M (a forked metal rod worth 250 gp)', 'Instantaneous', 'You and up to 8 willing creatures are transported to another plane of existence of your choosing. If you use this to banish an otherworldly creature instead, make a melee spell attack against it. On a hit, the creature must make a Charisma saving throw or be banished to a random location on the plane you choose.', '' FROM dual UNION ALL 
 SELECT 253, 'Plant Growth', 3, '3rd-level transmutation', '1 action or 8 hours', '150 feet', 'V, S', 'Instantaneous', 'If cast as an action, choose a spot within range that you can see. All plant life within 100 feet of that spot becomes thick and overgrown and creatures must spend 4 feet of movement to move 1 foot.<br>If cast as 8 hours, you enrich the land within half a mile. The plants within range become enriched for 1 year, yielding twice the normal amount of food when harvested.', '' FROM dual UNION ALL 
 SELECT 254, 'Poison Spray', 0, 'Conjuration cantrip', '1 action', '10 feet', 'V, S', 'Instantaneous', 'You target a creature within range that you can see. The creature must succeed on a Constitution saving throw or take 1d12 damage. This spell''s damage increases to 2d12 at 5th level, 3d12 at 11th level, and 4d12 at 17th level.', '' FROM dual UNION ALL 
 SELECT 255, 'Polymorph', 4, '4th-level transmutation', '1 action', '60 feet', 'V, S, M (a caterpillar cocoon)', 'Concentration, up to 1 hour', 'A creature within range is transformed into a new form. This new form can have a CR of up to the transformed creature''s CR or level. An unwilling creature can make a Wisdom saving throw to avoid this effect.', '' FROM dual UNION ALL 
 SELECT 256, 'Power Word Heal', 9, '9th-level evocation', '1 action', 'Touch', 'V, S', 'Instantaneous', 'The touched creature regains all of its hit points and is cured of the charmed, frightened, paralyzed, or stunned conditions. If the creature is prone it can stand up as a reaction. This spell has no effect on undead or constructs.', '' FROM dual UNION ALL 
 SELECT 257, 'Power Word Kill', 9, '9th-level enchantment', '1 action', '60 feet', 'V', 'Instantaneous', 'You target one creature within range. If that creature has 100 or fewer hit points, it dies instantly. If it has more than 100 hit points, this spell has no effect.', '' FROM dual UNION ALL 
 SELECT 258, 'Power Word Stun', 8, '8th-level enchantment', '1 action', '60 feet', 'V', 'Instantaneous', 'You target a creature within range. If that creature has 150 hit points or less, it is stunned, otherwise the spell does nothing. On each of its turns the creature makes a Constitution saving throw. On a successful save, the creature is no longer stunned.', '' FROM dual UNION ALL 
 SELECT 259, 'Prayer of Healing', 2, '2nd-level evocation', '10 minutes', '30 feet', 'V', 'Instantaneous', 'Up to six creatures within range regain 2d8 + your spellcasting modifier hit points. This spell has no effect on undead and constructs.', 'Creatures regain an additional 1d8 hit points for each slot level above 2nd used to cast this spell.' FROM dual UNION ALL 
 SELECT 260, 'Prestidigitation', 0, 'Transmutation cantrip', '1 action', '10 feet', 'V, S', 'Up to 1 hour', 'With this spell you can: create a harmless sensory effect; light or snuff a small fire or candle; clean or soil a small object; chill, warm or flavor nonliving material; make a color or mark appear on a surface for 1 hour; create a trinket in your hand until your next turn.<br>you can have up to 3 non-instantaneous effects active at once.', '' FROM dual UNION ALL 
 SELECT 261, 'Prismatic Spray', 7, '7th-level evocation', '1 action', 'Self (60-foot cone)', 'V, S', 'Instantaneous', 'Each target within a 60-foot cone rolls a Dexterity saving throw and 1d8. The 1d8 roll determines the effect for that creature:<br>1: 10d6 fire damage; 2: 10d6 acid damage; 3: 10d6 lightning damage; 4: 10d6 poison damage; 5: 10d6 cold damage; 6: target must make Constitution saves until it passes or fails 3 times. 3 failures makes it petrified; 7: target is blinded, then transported to a random plane of existence; 8: 2 other effects, roll 1d8 twice and take both.', '' FROM dual UNION ALL 
 SELECT 262, 'Prismatic Wall', 9, '9th-level abjuration', '1 action', '90 feet', 'V, S', '10 minutes', 'A wall of shimmering colors appears. Creatures within 20 feet of it must make a Constitution check or be blinded. Creatures attempting to pass through it must make 7 dexterity saving throws or it takes the following effects, in order: 10d6 fire damage, 10d6 acid damage, 10d6 electric damage, 10d6 poison damage, 10d6 cold damage, restrained and then petrified, and blinded and then banished to another plane.', '' FROM dual UNION ALL 
 SELECT 263, 'Produce Flame', 0, 'Conjuration cantrip', '1 action', 'Self', 'V, S', '10 minutes', 'A flame appears in the palm of your hand for the duration. You can attack with the flame, though that ends the spell. To attack, make a ranged spell attack at a creature within 30 feet. On a hit the target takes 1d8 fire damage. This damage increases to 2d8 at 5th level, 3d8 at 11th level, and 4d8 at 17th level.', '' FROM dual UNION ALL 
 SELECT 264, 'Programmed Illusion', 6, '6th-level illusion', '1 action', '120 feet', 'V, S, M (a bit of fleece and jade dust worth 25 gp)', 'Until dispelled', 'You set an illusion with a trigger condition. The illusion is imperceptible before it is triggered and the programmed performance can be up to 5 minutes in length. <br>When the condition you specify occurs, the illusion springs to life, performs its programmed function, then disappears and resets after 10 minutes, ready to be triggered again. ', '' FROM dual UNION ALL 
 SELECT 265, 'Project Image', 7, '7th-level illusion', '1 action', '500 miles', 'V, S, M (a small replica of you worth at least 5 gp)', 'Concentration, up to 1 day', 'You create an illusory image of yourself that lasts for the duration. The illusion looks and sounds like you and can appear anywhere within range that you have seen before. As a bonus action on your turn, you can see through the illusion''s eyes and move it up to 30 feet per round.', '' FROM dual UNION ALL 
 SELECT 266, 'Protection from Energy', 3, '3rd-level abjuration', '1 action', 'Touch', 'V, S', 'Concentration, up to 1 hour', 'For the duration, one creature you touch has resistance to one damage type of your choice from: Acid, Cold, Fire, Lightning, or Thunder.', '' FROM dual UNION ALL 
 SELECT 267, 'Protection from Evil/Good', 1, '1st-level abjuration', '1 action', 'Touch', 'V, S, M (holy water or powdered silver and iron)', 'Concentration, up to 10 minutes', 'Touched creature has protection against Aberrations, celestials, elementals, fey, fiends, and undead for the duration. Those creatures have disadvantage on attack rolls against the target, the target cannot be charmed, possessed or frightened by those creature types.', '' FROM dual UNION ALL 
 SELECT 268, 'Protection from Poison', 2, '2nd-level abjuration', '1 action', 'Touch', 'V, S', '1 hour', 'Touched creature is cured of one type of poison. For the duration, the creature has advantage on saving throws against being poisoned and has resistance to poison damage.', '' FROM dual UNION ALL 
 SELECT 269, 'Purify Food and Drink', 1, '1st-level transmutation (ritual)', '1 action', '10 feet', 'V, S', 'Instantaneous', 'All nonmagical food and drink within a 5-foot radius sphere centered on a spot you choose is rendered free from poison and disease.', '' FROM dual UNION ALL 
 SELECT 270, 'Raise Dead', 5, '5th-level necromancy', '1 hour', 'Touch', 'V, S, M (a diamond worth 500 gp)', 'Instantaneous', 'You return a dead creature you touch to life, provided it has been dead for no more than 10 days. If the soul is willing to return to the body, it returns to life with 1 hit point.<br>Creatures brought back this way suffer a -4 penalty to attack rolls, saving throws, and ability checks. This penalty is reduced by 1 every time the creature completes a long rest.', '' FROM dual UNION ALL 
 SELECT 271, 'Rary''s Telepathic Bond', 5, '5th-level divination (ritual)', '1 action', '30 feet', 'V, S, M (pieces of eggshell from two different kinds of creatures)', '1 hour', 'You forge a telepathic link with up to 8 willing creatures of your choice within range. For the duration, the targets can communicate telepathically over any distance, though not across planes of existence.', '' FROM dual UNION ALL 
 SELECT 272, 'Ray of Enfeeblement', 2, '2nd-level necromancy', '1 action', '60 feet', 'V, S', 'Concentration, up to 1 minute', 'Make a ranged spell attack against a target. On a hit, the target deals half damage with weapon attacks that use Strength. The target can make a Constitution saving throw at the end of each of its turns to end this effect.', '' FROM dual UNION ALL 
 SELECT 273, 'Ray of Frost', 0, 'Evocation cantrip', '1 action', '60 feet', 'V, S', 'Instantaneous', 'Make a ranged spell attack against a target within range. On a hit, the target takes 1d8 cold damage and has its speed reduced by 10 feet for one round. The spell''s damage increases to 2d8 at 5th level, 3d8 at 11th level, and 4d8 at 17th level.', '' FROM dual UNION ALL 
 SELECT 274, 'Ray of Sickness', 1, '1st-level necromancy', '1 action', '60 feet', 'V, S', 'Instantaneous', 'Make a ranged spell attack against a target you can see within range. On a hit, the target takes 2d8 poison damage and must make a Constitution saving throw. On a failure, it is also poisoned until the end of your next turn.', 'The damage increases by 1d8 for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 275, 'Regenerate', 7, '7th-level transmutation', '1 minute', 'Touch', 'V, S, M (a prayer wheel and holy water)', '1 hour', 'Touched creature regains 4d8 + 15 hit points instantly. For the duration, the target also regains 1 hit point at the start of each turn (10 HP per minute).<br>The target''s severed body members are restored after 2 minutes as long as you hold the severer part against the stump.', '' FROM dual UNION ALL 
 SELECT 276, 'Reincarnate', 5, '5th-level transmutation', '1 hour', 'Touch', 'V, S, M (rare oils and unguents worth 1,000 gp)', 'Instantaneous', 'You touch a dead creature that has been dead no longer than 10 days. The spell forms a new adult body and calls that soul to it. The DM rolls 1d100 to determine the new race of the target. The creature retains all memories and capabilities it had before, exchanging its racial abilities for that of its new form.', '' FROM dual UNION ALL 
 SELECT 277, 'Remove Curse', 3, '3rd-level abjuration', '1 action', 'Touch', 'V, S', 'Instantaneous', 'At your touch, all curses affecting one creature or object end. If the object is a cursed magic item, its curse remains, but the spell breaks its attunement to the owner of the object so it can be removed or discarded.', '' FROM dual UNION ALL 
 SELECT 278, 'Resistance', 0, 'Abjuration cantrip', '1 action', 'Touch', 'V, S, M (a miniature clock)', 'Concentration, up to 1 minute', 'Once before the spell expires, the touched creature can roll 1d4 and add the result to any one saving throw.', '' FROM dual UNION ALL 
 SELECT 279, 'Resurrection', 7, '7th-level necromancy', '1 hour', 'Touch', 'V, S, M (1 diamond worth 1,000 gp)', 'Instantaneous', 'You touch a dead creature that has been dead no more than a century that didn''t die of old age and isn''t undead, and bring it back to life.<br>Creatures brought back this way take a -4 penalty on attack rolls, saves, and ability checks, decreasing the penalty by 1 for every long rest completed.<br>After casting this spell, you cannot cast spells and have disadvantage on attacks, saves, and ability checks until you finish a long rest.', '' FROM dual UNION ALL 
 SELECT 280, 'Reverse Gravity', 7, '7th-level transmutation', '1 action', '100 feet', 'V, S, M (a lodestone and iron filings)', 'Concentration, up to 1 minute', 'Gravity reverses in a 50-foot radius, 100-foot tall cylinder area centered on a spot you can see within range. A creature caught in this area can make a Dexterity saving throw to grab onto a fixed object within reach to avoid falling up. Creatures stop falling when they reach the top of the cylinder or hit a ceiling or other fixed object above them. When the spell expires, creatures in the area fall as normal.', '' FROM dual UNION ALL 
 SELECT 281, 'Revivify', 3, '3rd-level conjuration', '1 action', 'Touch', 'V, S, M (diamonds worth 300 gp)', 'Instantaneous', 'You touch a creature that has died within the past minute and return it to life with 1 hit point. This does not work on creatures that died of old age, nor can it restore lost body parts.', '' FROM dual UNION ALL 
 SELECT 282, 'Rope Trick', 2, '2nd-level transmutation', '1 action', 'Touch', 'V, S, M (powdered corn extract and a twisted loop of parchment)', '1 hour', 'You touch a length of rope up to 60 feet long that then stands up straight. At the top of the rope opens an extradimensional space that can fit up to eight medium or smaller creatures. The rope can be pulled into the space to hide it as well.<br>Attacks and spells cannot pass through the extradimensional portal and anything inside the space when the spell expires drops.', '' FROM dual UNION ALL 
 SELECT 283, 'Sacred Flame', 0, 'Evocation cantrip', '1 action', '60 feet', 'V, S', 'Instantaneous', 'Flames descend on a creature within range that you can see. That creature makes a Dexterity saving throw or takes 1d8 radiant damage. The damage increases to 2d8 at 5th level, 3d8 at 11th level, and 4d8 at 17th level.', '' FROM dual UNION ALL 
 SELECT 284, 'Sanctuary', 1, '1st-level abjuration', '1 bonus action', '30 feet', 'V, S, M (a small silver mirror)', '1 minute', 'A creature within range is warded from attacks. Any creature who targets the warded creature with an attack or spell must first make a Wisdom saving throw. On a failed save the creature must select a new target or lost the attack or spell. <br>This effect ends if the warded creature attacks or casts a spell that affects an enemy creature.', '' FROM dual UNION ALL 
 SELECT 285, 'Scorching Ray', 2, '2nd-level evocation', '1 action', '120 feet', 'V, S', 'Instantaneous', 'You create three rays of fire and hurl them at targets within range. You can target separate creatures with each or target one creature with multiple rays. Make a ranged spell attack. On a hit, the target takes 2d6 fire damage.', 'One additional ray is created for each slot level above 2nd used to cast this spell.' FROM dual UNION ALL 
 SELECT 286, 'Scrying', 5, '5th-level divination', '10 minutes', 'Self', 'V, S, M (a focus worth at least 1,000 gp)', 'Concentration, up to 10 minutes', 'You attempt to see and hear a particular creature you choose that is on the same plane of existence. The target makes a Wisdom save, which is modified by the target''s knowledge and physical connection to you. <br>On a successful save, the spell fails and you cannot target that creature again for 24 hours. On a failure, you see all within 10 feet of the target.', '' FROM dual UNION ALL 
 SELECT 287, 'Searing Smite', 1, '1st-level evocation', '1 bonus action', 'Self', 'V', 'Concentration, up to 1 minute', 'Your next attack against a creature deals an extra 1d6 fire damage and causes the creature to catch fire. On each of its turns after that, the creature makes a Constitution saving throw. On failure it takes 1d6 fire damage; on success the fire is put out.', 'The initial fire damage is increased by 1d6 for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 288, 'See Invisibility', 2, '2nd-level divination', '1 action', 'self', 'V, S, M (a pinch of talc and a small sprinkling of silver powder)', '1 hour', 'For the duration you can see invisible creatures and objects as if they were visible. You also see into the Ethereal Plane. Ethereal creatures and objects appear translucent and ghostly.', '' FROM dual UNION ALL 
 SELECT 289, 'Seeming', 5, '5th-level illusion', '1 action', '30 feet', 'V, S', '8 hours', 'You change the appearance of up to 8 creatures within range, giving each target a new, illusory appearance. Creatures can make an Investigation check to discern the illusions for what they are.', '' FROM dual UNION ALL 
 SELECT 290, 'Sending', 3, '3rd-level evocation', '1 action', 'Unlimited', 'V, S, M (a short piece of fine copper wire)', '1 round', 'You send a short message to any creature with which you are familiar. The creature hears the message in its mind and can respond immediately.<br>This can send a message across any distance and even to other planes of existence, but there is a 5% chance it fails if the recipient is on another plane.', '' FROM dual UNION ALL 
 SELECT 291, 'Sequester', 7, '7th-level transmutation', '1 action', 'Touch', 'V, S, M (a powder composed of diamond, emerald, ruby, and sapphire dust worth 5,000 gp)', 'Until dispelled', 'A willing creature or object is hidden away. It becomes invisible and undetectable through divination. If the target is a creature it enters a state of suspended animation.<br>You can set a condition for the spell to end early. The condition must be visible and take place within 1 mile of the creature. This effect also ends if the subject takes any damage.', '' FROM dual UNION ALL 
 SELECT 292, 'Shapechange', 9, '9th-level transmutation', '1 action', 'Self', 'V, S, M (1 jade circlet worth 1,500 gp)', 'Concentration, up to 1 hour', 'For the duration, you transform into a creature that you have seen before that has a CR equal to or lower than your level. You can alter your form as an action, following the same restrictions. ', '' FROM dual UNION ALL 
 SELECT 293, 'Shatter', 2, '2nd-level evocation', '1 action', '60 feet', 'V, S, M (a chip of mica)', 'Instantaneous', 'A sudden loud, ringing noise emanates in a 10-foot radius from a point you designate within range. Creatures within the area take 2d8 thunder damage, with a Constitution saving throw for half damage.', 'The damage increases by 1d8 for each slot level above 2nd used to cast this spell.' FROM dual UNION ALL 
 SELECT 294, 'Shield', 1, '1st-level abjuration', '1 reaction, taken when hit by an attack or magic missile', 'Self', 'V, S', '1 round', 'An invisible barrier of magical force appears and protects you. Until the start of your next turn you have a +5 bonus to your AC, including against the triggering attack, and take no damage from Magic Missile.', '' FROM dual UNION ALL 
 SELECT 295, 'Shield of Faith', 1, '1st-level abjuration', '1 bonus action', '60 feet', 'V, S, M (a small parchment with a bit of holy text written on it)', 'Concentration, up to 10 minutes', 'A shimmering force surrounds a creature of your choice within range, granting +2 AC for the duration.', '' FROM dual UNION ALL 
 SELECT 296, 'Shillelagh', 0, 'Transmutation cantrip', '1 bonus action', 'Touch', 'V, S, M (mistletoe, a shamrock leaf, and a club)', '1 minute', 'The club or quarterstaff becomes magical for the duration. You can use your spellcasting modifier instead of Strength for attack and damage rolls with the weapon for the duration, and the damage die becomes 1d8.', '' FROM dual UNION ALL 
 SELECT 297, 'Shocking Grasp', 0, 'Evocation cantrip', '1 action', 'Touch', 'V, S', 'Instantaneous', 'Make a melee spell attack. On a hit, the target takes 1d8 lightning damage and can''t take reactions until its next turn. This damage increases to 2d8 at 5th level, 3d8 at 11th level, and 4d8 at 17th level.', '' FROM dual UNION ALL 
 SELECT 298, 'Silence', 2, '2nd-level illusion (ritual)', '1 action', '120 feet', 'V, S', 'Concentration, up to 10 minutes', 'For the duration, no sound can enter or pass trough a 20-foot radius sphere centered on a point you designate within range. Any creature or object entirely inside the sphere is immune to thunder damage, and are deafened while inside. Spells that require verbal components are impossible in the sphere.', '' FROM dual UNION ALL 
 SELECT 299, 'Silent Image', 1, '1st-level illusion', '1 action', '60 feet', 'V, S, M (a bit of fleece)', 'Concentration, up to 10 minutes', 'You create an image of an object or creature that is no larger than a 15-foot cube. The image gives off no sound, smells, or any other sensory effects. You can move the image as an action to any spot within range, and can manipulate it so that the movement appears normal, like a humanoid walking.<br>Creatures can make an Investigation check to discern the illusion.', '' FROM dual UNION ALL 
 SELECT 300, 'Simulacrum', 7, '7th-level illusion', '12 hours', 'Touch', 'V, S, M (snow or ice in large quantity, and ruby dust worth 1,500 gp)', 'Until dispelled', 'You duplicate any creature that is within range for the duration of casting. The duplicate appears to be a double of the original creature, but has half hit points and can never get stronger or learn new abilities. The simulacrum is friendly toward you and anyone you designate and obeys your spoken commands. If it is dropped to 0 HP, it melts away.', '' FROM dual UNION ALL 
 SELECT 301, 'Sleep', 1, '1st-level enchantment', '1 action', '90 feet', 'V, S, M (a pinch of fine sand, rose petals)', '1 minute', 'Roll 5d8 to determine how many hit points in creatures you can affect with this spell. Starting with the creature with the lowest hit points within 20 feet of a spot you designate within range, creatures fall asleep until all of the hit points rolled are used up.', 'Increase the hit points put to sleep by 2d8 for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 302, 'Sleet Storm', 3, '3rd-level conjuration', '1 action', '150 feet', 'V, S, M (a pinch of dust and a few drops of water)', 'Concentration, up to 1 minute', 'For the duration, a 20-foot radius, 40-foot tall cylinder area within range is heavily obscured and flames are doused. The ground becomes difficult terrain and all creatures who start their turn in or enter the area make a Dexterity saving throw or fall prone. Creatures attempting to cast a spell in the area must make a Constitution saving throw or lose concentration.', '' FROM dual UNION ALL 
 SELECT 303, 'Slow', 3, '3rd-level transmutation', '1 action', '120 feet', 'V, S, M (a drop of molasses)', 'Concentration, up to 1 minute', 'Up to six creatures within a 40-foot cube within range must make a Wisdom saving throw of be affected by this spell. <br>Affected creatures have their speed halved, -2 to AC and Dexterity saving throws, can use either an action or bonus action on its turn (not both). Spellcasters have a chance to have the spell delayed for one turn. Affected creatures can make a Wisdom save every round to end this effect.', '' FROM dual UNION ALL 
 SELECT 304, 'Spare the Dying', 0, 'Necromancy cantrip', '1 action', 'Touch', 'V, S', 'Instantaneous', 'You touch a living creature that has 0 hit points. The creature be comes stable. This has no effect on undead or constructs.', '' FROM dual UNION ALL 
 SELECT 305, 'Speak with Animals', 1, '1st-level divination (ritual)', '1 action', 'Self', 'V, S', '10 minutes', 'You gain the ability to speak and understand beasts for the duration.', '' FROM dual UNION ALL 
 SELECT 306, 'Speak with Dead', 3, '3rd-level necromancy', '1 action', '10 feet', 'V, S, M (burning incense)', '10 minutes', 'A corpse within range that has not been the target of this spell in the last 10 days answers up to five questions over the duration. The corpse knows only what it knew in life.', '' FROM dual UNION ALL 
 SELECT 307, 'Speak with Plants', 3, '3rd-level transmutation', '1 action', 'Self (30-foot radius)', 'V, S', '10 minutes', 'You grant plants within 30 feet of you sentience and the ability to communicate with you.', '' FROM dual UNION ALL 
 SELECT 308, 'Spider Climb', 2, '2nd-level transmutation', '1 action', 'Touch', 'V, S, M (a drop of bitumen and a spider)', 'Concentration, up to 1 hour', 'Until the spell ends, one willing creature you touch has the ability to move up, down, and across vertical surfaces and hand upside down along ceilings, while leaving its hands free. The target gains a climb speed equal to its walking speed.', '' FROM dual UNION ALL 
 SELECT 309, 'Spike Growth', 2, '2nd-level transmutation', '1 action', '150 feet', 'V, S, M (seven sharp thorns)', 'Concentration, up to 10 minutes', 'A 20-foot radius area of ground is covered with spikes and thorns. Creatures within the area and entering it take 2d4 piercing damage for every 5 feet they travel through the area.<br>The area is camouflaged to look natural. Creatures must make a Perception check to notice the thorns before entering/avoiding the area.', '' FROM dual UNION ALL 
 SELECT 310, 'Spirit Guardians', 3, '3rd-level conjuration', '1 action', 'Self (15-foot radius)', 'V, S, M (a holy symbol)', 'Concentration, up to 10 minutes', 'Spirits form a 15-foot radius ring of protection around you. Creatures entering or starting their turn in the area take 3d8 radiant (good) or necrotic (evil) damage, Wisdom save for half damage, and have their movement halved.', 'The damage increases by 1d8 for each slot level above 3rd used to cast this spell.' FROM dual UNION ALL 
 SELECT 311, 'Spiritual Weapon', 2, '2nd-level evocation', '1 bonus action', '60 feet', 'V. S', '1 minute', 'A floating, spectral weapon appears within range. When you cast this spell, make a melee spell attack against a creature within range. On a hit, the creature takes 1d8 + your spellcasting ability modifier force damage. As a bonus action on your turn, you can move the weapon up to 20 feet and attack with it.', 'The damage dealt by the weapon increases by 1d8 for every two slot levels above 2nd used to cast this spell.' FROM dual UNION ALL 
 SELECT 312, 'Staggering Smite', 4, '4th-level evocation', '1 bonus action', 'Self', 'V', 'Concentration, up to 1 minute', 'The next time you hit a creature with a melee weapon, the attack deals an extra 4d6 psychic damage and the target makes a Wisdom saving throw. On failure, the target has disadvantage on attack rolls and ability checks, and cannot take reactions until after its next turn.', '' FROM dual UNION ALL 
 SELECT 313, 'Stinking Cloud', 3, '3rd-level conjuration', '1 action', '90 feet', 'V, S, M (a rotten egg or several skunk cabbage leaves)', 'Concentration, up to 1 minute', 'You create a 20-foot radius cloud of yellow gas centered on a spot within range. Creatures that start completely within the cloud must make a Constitution saving throw or spend their turn retching and reeling. Creatures that do not need to breathe are immune to this effect.', '' FROM dual UNION ALL 
 SELECT 314, 'Stone Shape', 4, '4th-level transmutation', '1 action', 'Touch', 'V, S, M (soft clay)', 'Instantaneous', 'You touch a stone object of medium size or smaller or a section of stone no more than 5 feet in any dimension and form it into any shape that suits your purpose. The object can have up to 2 hinges and a latch, but nothing more mechanically complicated than that.', '' FROM dual UNION ALL 
 SELECT 315, 'Stonekin', 4, '4th-level abjuration', '1 action', 'Touch', 'V, S, M (diamond dust worth 100 gp)', 'Concentration, up to 1 hour', 'The spell turns the flesh of a willing creature you touch as hard as stone. For the duration, the creature has resistance to nonmagical bludgeoning, piercing and slashing damage.', '' FROM dual UNION ALL 
 SELECT 316, 'Storm of Vengeance', 9, '9th-level conjuration', '1 action', 'Sight', 'V, S ', 'Concentration, up to 1 minute', 'Creatures in the area when the storm forms make a Constitution saving throw or takes 2d6 thunder damage and is deafened for 5 minutes.<br>Round 2: creatures under the cloud take 1d6 acid damage<br>Round 3: bolts of lightning strike 6 creatures under the cloud, dealing 10d6 damage (Dex save for half)<br>Round 4: Hail deals 2d6 bludgeoning damage<br>Round 5-10: creatures take 1d6 cold damage, ranged attacks are impossible.', '' FROM dual UNION ALL 
 SELECT 317, 'Suggestion', 2, '2nd-level enchantment', '1 action', '30 feet', 'V, M (a snake''s tongue and honeycomb or sweet oil)', 'Concentration, up to 8 hours', 'You suggest a course of action for a target within range. The target makes a Wisdom saving throw. On a failure, it performs the suggested course of action to the best of its ability.', '' FROM dual UNION ALL 
 SELECT 318, 'Sunbeam', 6, '6th-level evocation', '1 action', 'Self (60-foot line)', 'V, S, M (a magnifying glass)', 'Concentration, up to 1 minute', 'An intense beam of light shines from your hands in a 60-foot long by 5-foot wide line. Creatures in the effect take 6d8 radiant damage and are blinded until your next turn. A successful Constitution saving throw halves the damage and negates the blindness. Undead and oozes have disadvantage on the saving throw.<br>You can create a new line of radiance as an action on each of your turns for the duration.', '' FROM dual UNION ALL 
 SELECT 319, 'Sunburst', 8, '8th-level evocation', '1 action', '150 feet', 'V, S, M (fire and a piece of sunstone)', 'Instantaneous', 'Brilliant sunlight fills a 60-foot radius area within range. Creatures within the area take 12d6 radiant damage and are blinded for 1 minute. A successful Constitution saving throw halves the damage and negates the blind. Undead and oozes have disadvantage on the save.<br>Blinded creatures can make a Constitution saving throw on each of their turns to end the condition.', '' FROM dual UNION ALL 
 SELECT 320, 'Swift Quiver', 5, '5th-level transmutation', '1 bonus action', 'Touch', 'V, S, M (a quiver containing at least one piece of ammo)', 'Concentration, up to 1 minute', 'You transmute your quiver so that it supplies an endless supply of ammunition for the duration. On each of your turns you can use a bonus action to make two attacks with a weapon that uses ammunition from the quiver. Each time you fire, the quiver magically replaces the ammunition back in the quiver.', '' FROM dual UNION ALL 
 SELECT 321, 'Symbol', 7, '7th-level abjuration', '1 minute', 'Touch', 'V, S, M (mercury, phosphorous, and powdered diamond and opal worth 1,000 gp)', 'Until dispelled or triggered', 'You transcribe a glyph or rune that triggers on a condition you set and can cause: death; discord; fear; hopelessness; insanity; pain; sleep; or stunning', '' FROM dual UNION ALL 
 SELECT 322, 'Tasha''s Hideous Laughter', 1, '1st-level enchantment', '1 action', '30 feet', 'V, S, M (tiny tarts and a feather)', 'Concentration, up to 1 minute', 'A creature you can see within range must make a Wisdom saving throw or falls prone in laughter and is incapacitated for the duration. Each round, and each time it takes damage, the creature can make a new Wisdom saving throw to end this effect. The target has advantage on this save if it is triggered by damage.', '' FROM dual UNION ALL 
 SELECT 323, 'Telekinesis', 5, '5th-level transmutation', '1 action', '60 feet', 'V, S', 'Concentration, up to 10 minutes', 'You can manipulate creatures or objects within range with your mind. If attempting to move a creature, make an ability check with your spellcasting ability opposed by the creature''s Strength check. If you win you can move the creature up to 30 feet and the creature is restrained. You can move an unattended object up to 1,000 pounds up to 30 feet within the range of this spell.', '' FROM dual UNION ALL 
 SELECT 324, 'Telepathy', 8, '8th-level evocation', '1 action', 'Unlimited', 'V, S, M (a pair of linked silver rings)', '24 hours', 'You create a telepathic link to any creature with which you are familiar on the same plane of existence. For the duration of the spell you and the linked creature can instantaneously share mental images and thoughts.', '' FROM dual UNION ALL 
 SELECT 325, 'Teleport', 7, '7th-level conjuration', '1 action', '10 feet', 'V', 'Instantaneous', 'You transport yourself and up to eight willing creatures or a 10-foot cube to a destination on the same plane of existence that is known to you.', '' FROM dual UNION ALL 
 SELECT 326, 'Teleportation Circle', 5, '5th-level conjuration', '1 minute', '10 feet', 'V, M (rare chalks and inks worth 50 gp)', '1 round', 'You draw a 10-foot diameter circle on the ground, linking that location with a permanent teleportation circle somewhere else on the same plane of existence. You can create a permanent teleportation circle by casting this spell every day for one year.', '' FROM dual UNION ALL 
 SELECT 327, 'Tenser''s Floating Disk', 1, '1st-level conjuration (ritual)', '1 action', '30 feet', 'V, S, M (a drop of mercury)', '1 hour', 'You create a 3-foot wide disk of force that can hold up to 500 pounds. While this is within 20 feet of you it does not move, but will move to stay within 20 feet of you if you are traveling. ', '' FROM dual UNION ALL 
 SELECT 328, 'Thaumaturgy', 0, 'Transmutation cantrip', '1 action', '30 feet', 'V', 'Up to 1 minute', 'You create one of the following effects:<br>your voice booms three times as loud; you cause flames to flicker and change for 1 minute; you cause harmless tremors for 1 minute; you create a harmless sound within range; you cause an unlocked door or window to fly open; or you alter the appearance of your eyes for 1 minute<br>You can have up to three of these 1-minute effects active at once.', '' FROM dual UNION ALL 
 SELECT 329, 'Thorn Whip', 0, 'Transmutation cantrip', '1 action', '30 feet', 'V, S, M (the stem of a plant with thorns)', 'Instantaneous', 'A large, vine-like whip attacks a creature within range. Make a melee spell attack. On a hit the creature takes 1d6 piercing damage. If the target is Large or smaller, pull it 10 feet closer to you. The damage increases to 2d6 at 5th level, 3d6 at 11th level, and 4d6 at 17th level.', '' FROM dual UNION ALL 
 SELECT 330, 'Thunderous Smite', 1, '1st-level evocation', '1 bonus action', 'Self', 'V', 'Concentration, up to 1 minute', 'The first time you hit with a melee weapon during this spell''s duration, your weapon deals an extra 2d6 thunder damage. The target must also make a Strength saving throw or be pushed 10 feet away from you.', '' FROM dual UNION ALL 
 SELECT 331, 'Thunderwave', 1, '1st-level evocation', '1 action', 'Self (15-foot cube)', 'V, S', 'Instantaneous', 'Creatures within a 15-foot cube of you take 2d8 thunder damage and are pushed 10 feet away. If they make a Constitution saving throw they take half damage and are not pushed.', 'The damage increases by 1d8 for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 332, 'Time Stop', 9, '9th-level transmutation', '1 action', 'Self ', 'V', 'Instantaneous', 'You briefly stop time for everyone but yourself. You take 1d4 +1 turns in a row, during which you can move and take actions as normal.<br>The spell ends if any of the actions you take affect another creature or an object worn by another creature, or if you move more than 1,000 feet away from where you case the spell.', '' FROM dual UNION ALL 
 SELECT 333, 'Tongues', 3, '3rd-level divination', '1 action', 'Touch', 'V, M (a small clay model of a ziggurat)', '1 hour', 'The touched creature gains the ability to speak and understand any language for the duration.', '' FROM dual UNION ALL 
 SELECT 334, 'Transport via Plants', 6, '6th-level conjuration', '1 action', '10 feet', 'V, S', '1 round', 'This creates a link between a Large or larger inanimate plant within range and another plant on the same plane of existence. For the duration, creatures can step into the target plant and exit from the destination plant using 5 feet of movement.', '' FROM dual UNION ALL 
 SELECT 335, 'Tree Stride', 5, '5th-level conjuration', '1 action', 'Self', 'V, S', 'Concentration, up to 1 minute', 'You gain the ability to enter a tree and move inside it to inside another tree of the same type within 500 feet. You can use this mode of transportation once per round for the duration, and must end each round outside of a tree.', '' FROM dual UNION ALL 
 SELECT 336, 'True Polymorph', 9, '9th-level transmutation', '1 action', '30 feet', 'V, S, M (1 drop of mercury, a dollop of gum arabic, and a wisp of smoke)', 'Concentration, up to 1 hour', 'You choose one creature or object within range to transform into another creature or object for the duration. Creatures get a Wisdom saving throw to resist this effect.', '' FROM dual UNION ALL 
 SELECT 337, 'True Resurrection', 9, '9th-level necromancy', '1 hour', 'Touch', 'V, S, M (a sprinkle of holy water and diamonds worth 25,000 gp)', 'Instantaneous', 'You touch a creature that has been dead for no longer than 200 years and that died of something other than old age. This spell brings the creature back to life, even creating a new body if the old one is not available, in which case you must speak the creature''s name to perform the spell.', '' FROM dual UNION ALL 
 SELECT 338, 'True Seeing', 6, '6th-level divination', '1 action', 'Touch', 'V, S, M (an ointment for the eyes that costs 25 gp)', '1 hour', 'For the duration, a willing creature you touched has truesight, notices secret doors hidden by magic, and can see into the Ethereal Plane, all out to a range of 120 feet.', '' FROM dual UNION ALL 
 SELECT 339, 'True Stirke', 0, 'Divination cantrip', '1 action', '30 feet', 'S', 'Concentration, up to 1 round', 'You have advantage on the next attack roll you make against the target creature before the end of your next turn.', '' FROM dual UNION ALL 
 SELECT 340, 'Tsuani', 8, '8th-level conjuration', '1 action', 'Sight', 'V, S', 'Concentration, up to 6 rounds', 'A wall of water up to 300 feet tall, 300 feet wide, and 50 feet thick appears starting at a point you choose. Creatures within the area take 6d10 bludgeoning damage, halved with a Strength saving throw. Every round, on your turn, the wave moves 80 feet directly away from you. Any creature caught by the wave takes bludgeoning damage that decreases by 1d10 each round until the duration ends. Creatures caught in the wall can move by swimming if they make an Athletics check.', '' FROM dual UNION ALL 
 SELECT 341, 'Unseen Servant', 1, '1st-level conjuration (ritual)', '1 action', '60 feet', 'V, S, M (a piece of string and a piece of wood)', '1 hour', 'An invisible force appears and follows your commands and performs mundane tasks for you for the duration. The force cannot attack and has 1 hit point. It disappears if it is more than 60 feet away from you at any point for the duration.', '' FROM dual UNION ALL 
 SELECT 342, 'Vampiric Touch', 3, '3rd-level necromancy', '1 action', 'Self', 'V, S', 'Concentration, up to 1 minute', 'As an action each turn for the duration, make a melee spell attack. On a hit, deal 3d6 necrotic damage to the target, and you regain hit points equal to half the damage done.', 'The damage increases by 1d6 for each slot level above 3rd used to cast this spell.' FROM dual UNION ALL 
 SELECT 343, 'Vicious Mockery', 0, 'Enchantment cantrip', '1 action', '60 feet', 'V', 'Instantaneous', 'A target within range that can hear you must make a Wisdom saving throw or take 1d4 psychic damage and have disadvantage on the next attack it makes before the end of its next turn. This damage increases to 2d4 at 5th level, 3d4 at 11th level, and 4d4 at 17th level.', '' FROM dual UNION ALL 
 SELECT 344, 'Wall of Fire', 4, '4th-level evocation', '1 action', '120 feet', 'V, S, M (a small piece of phosphorous)', 'Concentration, up to 1 minute', 'A wall of fire up to 60 feet long, 20 feet high and 1 foot thick appears within range. Creatures within the area take 5d8 fire damage, halved with a successful Dexterity check. Upon casting, you choose one side of the wall. Creature that enter or start their turn with 10 feet of that side of the wall take 5d8 fire damage, and again if they pass through the wall.', '' FROM dual UNION ALL 
 SELECT 345, 'Wall of Force', 5, '5th-level evocation', '1 action', '120 feet', 'V, S, M (powder from a crushed clear gem)', 'Concentration, up to 10 minutes', 'An invisible wall of force appears within range. It can be a sphere or hemisphere 10 feet in radius, or a wall made of up to ten 10-foot panels connected to each other. The wall cannot be passed through by any physical object or creature and is impervious to damage. The only way to end this effect early is to dismiss it or if a Disintegrate spell hits the wall. The effect even extends into the Ethereal Plane.', '' FROM dual UNION ALL 
 SELECT 346, 'Wall of Ice', 6, '6th-level evocation', '1 action', '120 feet', 'V, S, M (a small piece of quartz)', 'Concentration, up to 10 minutes', 'You form a solid wall of ice within range as a dome up to 10 feet in radius or a flat surface up to ten 10-foot panels connected to each other. The wall can push creatures out of its way, dealing 10d6 cold damage, halved on a Dexterity saving throw. ', 'The damage dealt when the wall appears increases by 2d6 for each slot level above 6th used to cast this spell.' FROM dual UNION ALL 
 SELECT 347, 'Wall of Stone', 5, '5th-level evocation', '1 action', '120 feet', 'V, S, M (a small block of granite)', 'Concentration, up to 10 minutes', 'You create a nonmagical wall of stone that can appear either as a sphere or hemisphere up to 10 feet in radius, or up to ten 10-foot slabs connected to at least one other slab. If you maintain this spell for the full duration, it becomes permanent, otherwise it disappears when the spell ends.', '' FROM dual UNION ALL 
 SELECT 348, 'Wall of Thorns', 6, '6th-level conjuration', '1 action', '120 feet', 'V, S, M (a handful of thorns)', 'Concentration, up to 10 minutes', 'You create a wall of tangled, thick thorny brush that can be circular up to a 20-foot radius or a flat wall up to 60 feet long. Creatures in a space where you create the wall take 7d8 piercing damage, halved by a Dexterity saving throw. Creatures can pass through the wall, but must spend 4 feet of movement to move 1 foot. Creatures entering or ending their turn in the wall take 7d8 slashing damage, halved by a Dexterity saving throw.', '' FROM dual UNION ALL 
 SELECT 349, 'Warding Bond', 2, '2nd-level abjuration', '1 action', 'Touch', 'V, S, M (A pair of platinum rings worth 50 gp)', '1 hour', 'You touch a willing creature and create a connection between you. For the duration, the creature has +1 AC and to all saving throws, and has resistance to all damage. Whenever the creature takes damage, you take the same amount of damage. The spell ends if you drop to 0 hit points or if the target moves farther than 60 feet from you.', '' FROM dual UNION ALL 
 SELECT 350, 'Water Breathing', 3, '3rd-level transmutation (ritual)', '1 action', '30 feet', 'V, S, M (a short reed or piece of straw)', '24 hours', 'This spell grants you and up to ten creatures within range the ability to breath underwater until the spell ends. All affected creatures also retain their natural mode of respiration.', '' FROM dual UNION ALL 
 SELECT 351, 'Water Walk', 3, '3rd-level transmutation (ritual)', '1 action', '30 feet ', 'V, S, M ( a piece of cork)', '1 hour', 'This spell grants up to 10 creatures within range the ability to walk on water, acid, mud, snow, quicksand, or lava as if it were a solid surface, though those walking on lava still take damage from the heat. If an affected creature is submerged, they float toward the surface at a pace of 60 feet per round.', '' FROM dual UNION ALL 
 SELECT 352, 'Web', 2, '2nd-level conjuration', '1 action', '60 feet', 'V, S, M (a bit of spiderweb)', 'Concentration, up to 1 hour', 'You conjure a 20-foot cube of webbing centered on a spot within range. If the web is not anchored between two points, it collapses in on itself and ends on our next turn. Any creature that enters or ends its turn in the web must make a Dexterity saving throw or be restrained either for the duration or until it breaks free. Restrained creature make a Strength check to break free of the web.', '' FROM dual UNION ALL 
 SELECT 353, 'Weird', 9, '9th-level illusion', '1 action', '120 feet', 'V, S', 'Concentration, up to 1 minute', 'Each creature in a 30-foot radius area centered on a spot you choose within range must make a Wisdom saving throw. Creatures who fail are frightened for the duration. Each round, frightened creatures must make a Wisdom save or take 4d10 psychic damage. The spell ends for those that make the saving throw.', '' FROM dual UNION ALL 
 SELECT 354, 'Wind Walk', 6, '6th-level transmutation', '1 minute', '30 feet', 'V, S, M (fire and holy water)', '8 hours', 'Up to 10 willing creatures within range are turned into gaseous forms for the duration. While in this form creatures have resistance to damage from nonmagical weapons. Affected creatures can revert to their normal form and back to gaseous form with a 1 minute transformation process each. They are incapacitated during this process.', '' FROM dual UNION ALL 
 SELECT 355, 'Wind Wall', 3, '3rd-level evocation', '1 action', '120 feet', 'V, S, M (a tiny fan and a feather)', 'Concentration, up to 1 minute', 'A wall of wind 50 feet long and 15 feet tall appears within range. Creatures in the wall''s path when it appears take 3d8 bludgeoning damage, halved with a Dexterity saving throw. The wind wall keeps small or smaller flying creatures and ordinary projectiles away.', '' FROM dual UNION ALL 
 SELECT 356, 'Wish', 9, '9th-level conjuration', '1 action', 'Self', 'V', 'Instantaneous', 'You can use this to create any spell effect of 8th level or lower; create a nonmagical object worth up to 25,000 gp appear; up to 20 creatures are fully healed; 10 creatures get resistance to one damage type; 10 creatures get immunity to a single spell effect; or undo a single recent event.<br>Casting this spell takes a massive toll on the caster. Each spell you cast before a long rest deals 1d10 necrotic damage per level to you. Your Strength score also drops to 3 for 2d4 days.', '' FROM dual;
INSERT INTO SPELLS
 SELECT 357, 'Witch Bolt', 1, '1st-level evocation', '1 action', '30 feet', 'V, S, M (a twig from a tree that has been struck by lightning)', 'Concentration, up to 1 minute', 'Make a ranged spell attack against a target within range. On a hit, the target takes 1d12 lightning damage. As an action on each of your turns for the duration you can deal another 1d12 lightning damage to the target as long as it stays within range. ', 'The damage increases by 1d12 for each slot level above 1st used to cast this spell.' FROM dual UNION ALL 
 SELECT 358, 'Word of Recall', 6, '6th-level conjuration', '1 action', '5 feet', 'V', 'Instantaneous', 'You and up to five willing creatures within 5 feet of you are instantly teleported to a previously designated sanctuary. You designate a sanctuary by casting this spell in a location strongly linked to your deity.', '' FROM dual UNION ALL 
 SELECT 359, 'Wrathful Smite', 1, '1st-level evocation', '1 bonus action', 'Self', 'V', 'Concentration, up to 1 minute', 'Your next attack deals an extra 1d6 psychic damage and the target must make a Wisdom saving throw or be frightened for the duration. If frightened, the creature can use an action to make a Wisdom saving throw to end this effect.', '' FROM dual UNION ALL 
 SELECT 360, 'Zone of Truth', 2, '2nd-level enchantment', '1 action', '60 feet', 'V, S', '10 minutes', 'You create a 15-foot radius area where creature can only speak truth. Creatures within this area make a Charisma saving throw. On a failure, they cannot willingly tell a lie. You know whether each creature in the area succeeds or fails its save. Creatures in the area also know they are under the effects of this spell and can thus refuse to answer a question they would normally lie in response to.', '' FROM dual UNION ALL 
 SELECT 361, 'Acid Splash', 0, 'Conjuration cantrip', '1 action', '60 feet', 'V, S', 'Instantaneous', 'You hurl a bubble of acid. Choose one creature within range, or choose two creatures within range that arernwithin 5 feet of each other. A target must succeed on a Dexterity saving throw or take 1d6 acid damage.rn', 'This spell''s damage increases by Id6 when you reachrn5th level (2d6), 11th level (3d6), and 17th level (4d6).' FROM dual;



INSERT INTO CLASS_SPELLS
 SELECT 2, 32 FROM dual UNION ALL 
 SELECT 10, 32 FROM dual UNION ALL 
 SELECT 11, 32 FROM dual UNION ALL 
 SELECT 12, 32 FROM dual UNION ALL 
 SELECT 10, 45 FROM dual UNION ALL 
 SELECT 11, 45 FROM dual UNION ALL 
 SELECT 12, 45 FROM dual UNION ALL 
 SELECT 2, 85 FROM dual UNION ALL 
 SELECT 10, 85 FROM dual UNION ALL 
 SELECT 12, 85 FROM dual UNION ALL 
 SELECT 4, 111 FROM dual UNION ALL 
 SELECT 11, 113 FROM dual UNION ALL 
 SELECT 10, 137 FROM dual UNION ALL 
 SELECT 12, 137 FROM dual UNION ALL 
 SELECT 2, 150 FROM dual UNION ALL 
 SELECT 10, 150 FROM dual UNION ALL 
 SELECT 11, 150 FROM dual UNION ALL 
 SELECT 12, 150 FROM dual UNION ALL 
 SELECT 3, 166 FROM dual UNION ALL 
 SELECT 4, 166 FROM dual UNION ALL 
 SELECT 2, 202 FROM dual UNION ALL 
 SELECT 3, 202 FROM dual UNION ALL 
 SELECT 10, 202 FROM dual UNION ALL 
 SELECT 12, 202 FROM dual UNION ALL 
 SELECT 2, 210 FROM dual UNION ALL 
 SELECT 10, 210 FROM dual UNION ALL 
 SELECT 11, 210 FROM dual UNION ALL 
 SELECT 12, 210 FROM dual UNION ALL 
 SELECT 2, 224 FROM dual UNION ALL 
 SELECT 3, 224 FROM dual UNION ALL 
 SELECT 4, 224 FROM dual UNION ALL 
 SELECT 10, 224 FROM dual UNION ALL 
 SELECT 12, 224 FROM dual UNION ALL 
 SELECT 2, 225 FROM dual UNION ALL 
 SELECT 10, 225 FROM dual UNION ALL 
 SELECT 12, 225 FROM dual UNION ALL 
 SELECT 2, 228 FROM dual UNION ALL 
 SELECT 10, 228 FROM dual UNION ALL 
 SELECT 11, 228 FROM dual UNION ALL 
 SELECT 12, 228 FROM dual UNION ALL 
 SELECT 4, 254 FROM dual UNION ALL 
 SELECT 10, 254 FROM dual UNION ALL 
 SELECT 11, 254 FROM dual UNION ALL 
 SELECT 12, 254 FROM dual UNION ALL 
 SELECT 2, 260 FROM dual UNION ALL 
 SELECT 10, 260 FROM dual UNION ALL 
 SELECT 11, 260 FROM dual UNION ALL 
 SELECT 12, 260 FROM dual UNION ALL 
 SELECT 4, 263 FROM dual UNION ALL 
 SELECT 10, 273 FROM dual UNION ALL 
 SELECT 12, 273 FROM dual UNION ALL 
 SELECT 3, 278 FROM dual UNION ALL 
 SELECT 4, 278 FROM dual UNION ALL 
 SELECT 3, 283 FROM dual UNION ALL 
 SELECT 4, 296 FROM dual UNION ALL 
 SELECT 10, 297 FROM dual UNION ALL 
 SELECT 12, 297 FROM dual UNION ALL 
 SELECT 3, 304 FROM dual UNION ALL 
 SELECT 3, 328 FROM dual UNION ALL 
 SELECT 4, 329 FROM dual UNION ALL 
 SELECT 2, 339 FROM dual UNION ALL 
 SELECT 10, 339 FROM dual UNION ALL 
 SELECT 11, 339 FROM dual UNION ALL 
 SELECT 12, 339 FROM dual UNION ALL 
 SELECT 2, 343 FROM dual UNION ALL 
 SELECT 8, 2 FROM dual UNION ALL 
 SELECT 12, 2 FROM dual UNION ALL 
 SELECT 2, 4 FROM dual UNION ALL 
 SELECT 4, 4 FROM dual UNION ALL 
 SELECT 8, 4 FROM dual UNION ALL 
 SELECT 2, 15 FROM dual UNION ALL 
 SELECT 3, 15 FROM dual UNION ALL 
 SELECT 11, 25 FROM dual UNION ALL 
 SELECT 11, 26 FROM dual UNION ALL 
 SELECT 3, 33 FROM dual UNION ALL 
 SELECT 10, 40 FROM dual UNION ALL 
 SELECT 12, 40 FROM dual UNION ALL 
 SELECT 2, 44 FROM dual UNION ALL 
 SELECT 4, 44 FROM dual UNION ALL 
 SELECT 10, 44 FROM dual UNION ALL 
 SELECT 11, 44 FROM dual UNION ALL 
 SELECT 12, 44 FROM dual UNION ALL 
 SELECT 10, 46 FROM dual UNION ALL 
 SELECT 12, 46 FROM dual UNION ALL 
 SELECT 10, 53 FROM dual UNION ALL 
 SELECT 12, 53 FROM dual UNION ALL 
 SELECT 3, 54 FROM dual UNION ALL 
 SELECT 7, 54 FROM dual UNION ALL 
 SELECT 7, 57 FROM dual UNION ALL 
 SELECT 2, 58 FROM dual UNION ALL 
 SELECT 10, 58 FROM dual UNION ALL 
 SELECT 11, 58 FROM dual UNION ALL 
 SELECT 12, 58 FROM dual UNION ALL 
 SELECT 3, 79 FROM dual UNION ALL 
 SELECT 4, 79 FROM dual UNION ALL 
 SELECT 2, 84 FROM dual UNION ALL 
 SELECT 3, 84 FROM dual UNION ALL 
 SELECT 4, 84 FROM dual UNION ALL 
 SELECT 7, 84 FROM dual UNION ALL 
 SELECT 8, 84 FROM dual UNION ALL 
 SELECT 3, 93 FROM dual UNION ALL 
 SELECT 7, 93 FROM dual UNION ALL 
 SELECT 2, 94 FROM dual UNION ALL 
 SELECT 3, 94 FROM dual UNION ALL 
 SELECT 4, 94 FROM dual UNION ALL 
 SELECT 7, 94 FROM dual UNION ALL 
 SELECT 8, 94 FROM dual UNION ALL 
 SELECT 10, 94 FROM dual UNION ALL 
 SELECT 12, 94 FROM dual UNION ALL 
 SELECT 3, 95 FROM dual UNION ALL 
 SELECT 4, 95 FROM dual UNION ALL 
 SELECT 7, 95 FROM dual UNION ALL 
 SELECT 8, 95 FROM dual UNION ALL 
 SELECT 2, 98 FROM dual UNION ALL 
 SELECT 10, 98 FROM dual UNION ALL 
 SELECT 12, 98 FROM dual UNION ALL 
 SELECT 2, 102 FROM dual UNION ALL 
 SELECT 7, 104 FROM dual UNION ALL 
 SELECT 8, 117 FROM dual UNION ALL 
 SELECT 4, 118 FROM dual UNION ALL 
 SELECT 10, 122 FROM dual UNION ALL 
 SELECT 11, 122 FROM dual UNION ALL 
 SELECT 12, 122 FROM dual UNION ALL 
 SELECT 2, 125 FROM dual UNION ALL 
 SELECT 4, 125 FROM dual UNION ALL 
 SELECT 10, 126 FROM dual UNION ALL 
 SELECT 12, 126 FROM dual UNION ALL 
 SELECT 2, 128 FROM dual UNION ALL 
 SELECT 10, 128 FROM dual UNION ALL 
 SELECT 12, 128 FROM dual UNION ALL 
 SELECT 12, 131 FROM dual UNION ALL 
 SELECT 4, 145 FROM dual UNION ALL 
 SELECT 8, 145 FROM dual UNION ALL 
 SELECT 10, 145 FROM dual UNION ALL 
 SELECT 12, 145 FROM dual UNION ALL 
 SELECT 12, 161 FROM dual UNION ALL 
 SELECT 3, 167 FROM dual UNION ALL 
 SELECT 8, 169 FROM dual UNION ALL 
 SELECT 2, 175 FROM dual UNION ALL 
 SELECT 3, 175 FROM dual UNION ALL 
 SELECT 4, 175 FROM dual UNION ALL 
 SELECT 11, 177 FROM dual UNION ALL 
 SELECT 2, 179 FROM dual UNION ALL 
 SELECT 7, 179 FROM dual UNION ALL 
 SELECT 11, 180 FROM dual UNION ALL 
 SELECT 8, 185 FROM dual UNION ALL 
 SELECT 2, 188 FROM dual UNION ALL 
 SELECT 12, 188 FROM dual UNION ALL 
 SELECT 2, 189 FROM dual UNION ALL 
 SELECT 11, 189 FROM dual UNION ALL 
 SELECT 12, 189 FROM dual UNION ALL 
 SELECT 3, 192 FROM dual UNION ALL 
 SELECT 4, 195 FROM dual UNION ALL 
 SELECT 8, 195 FROM dual UNION ALL 
 SELECT 10, 195 FROM dual UNION ALL 
 SELECT 12, 195 FROM dual UNION ALL 
 SELECT 2, 208 FROM dual UNION ALL 
 SELECT 4, 208 FROM dual UNION ALL 
 SELECT 8, 208 FROM dual UNION ALL 
 SELECT 12, 208 FROM dual UNION ALL 
 SELECT 10, 209 FROM dual UNION ALL 
 SELECT 12, 209 FROM dual UNION ALL 
 SELECT 10, 213 FROM dual UNION ALL 
 SELECT 12, 213 FROM dual UNION ALL 
 SELECT 3, 267 FROM dual UNION ALL 
 SELECT 7, 267 FROM dual UNION ALL 
 SELECT 11, 267 FROM dual UNION ALL 
 SELECT 12, 267 FROM dual UNION ALL 
 SELECT 3, 269 FROM dual UNION ALL 
 SELECT 4, 269 FROM dual UNION ALL 
 SELECT 7, 269 FROM dual UNION ALL 
 SELECT 10, 274 FROM dual UNION ALL 
 SELECT 12, 274 FROM dual UNION ALL 
 SELECT 3, 284 FROM dual UNION ALL 
 SELECT 7, 287 FROM dual UNION ALL 
 SELECT 10, 294 FROM dual UNION ALL 
 SELECT 12, 294 FROM dual UNION ALL 
 SELECT 3, 295 FROM dual UNION ALL 
 SELECT 7, 295 FROM dual UNION ALL 
 SELECT 2, 299 FROM dual UNION ALL 
 SELECT 10, 299 FROM dual UNION ALL 
 SELECT 12, 299 FROM dual UNION ALL 
 SELECT 2, 301 FROM dual UNION ALL 
 SELECT 10, 301 FROM dual UNION ALL 
 SELECT 12, 301 FROM dual UNION ALL 
 SELECT 2, 305 FROM dual UNION ALL 
 SELECT 4, 305 FROM dual UNION ALL 
 SELECT 8, 305 FROM dual UNION ALL 
 SELECT 2, 322 FROM dual UNION ALL 
 SELECT 12, 322 FROM dual UNION ALL 
 SELECT 12, 327 FROM dual UNION ALL 
 SELECT 7, 330 FROM dual UNION ALL 
 SELECT 2, 331 FROM dual UNION ALL 
 SELECT 4, 331 FROM dual UNION ALL 
 SELECT 10, 331 FROM dual UNION ALL 
 SELECT 12, 331 FROM dual UNION ALL 
 SELECT 2, 341 FROM dual UNION ALL 
 SELECT 11, 341 FROM dual UNION ALL 
 SELECT 12, 341 FROM dual UNION ALL 
 SELECT 10, 357 FROM dual UNION ALL 
 SELECT 11, 357 FROM dual UNION ALL 
 SELECT 12, 357 FROM dual UNION ALL 
 SELECT 7, 359 FROM dual UNION ALL 
 SELECT 3, 1 FROM dual UNION ALL 
 SELECT 7, 1 FROM dual UNION ALL 
 SELECT 10, 3 FROM dual UNION ALL 
 SELECT 12, 3 FROM dual UNION ALL 
 SELECT 2, 5 FROM dual UNION ALL 
 SELECT 4, 5 FROM dual UNION ALL 
 SELECT 8, 5 FROM dual UNION ALL 
 SELECT 4, 18 FROM dual UNION ALL 
 SELECT 8, 18 FROM dual UNION ALL 
 SELECT 4, 20 FROM dual UNION ALL 
 SELECT 8, 20 FROM dual UNION ALL 
 SELECT 12, 24 FROM dual UNION ALL 
 SELECT 3, 28 FROM dual UNION ALL 
 SELECT 2, 36 FROM dual UNION ALL 
 SELECT 3, 36 FROM dual UNION ALL 
 SELECT 10, 36 FROM dual UNION ALL 
 SELECT 12, 36 FROM dual UNION ALL 
 SELECT 10, 38 FROM dual UNION ALL 
 SELECT 12, 38 FROM dual UNION ALL 
 SELECT 7, 39 FROM dual UNION ALL 
 SELECT 2, 42 FROM dual UNION ALL 
 SELECT 3, 42 FROM dual UNION ALL 
 SELECT 2, 51 FROM dual UNION ALL 
 SELECT 10, 51 FROM dual UNION ALL 
 SELECT 11, 51 FROM dual UNION ALL 
 SELECT 12, 51 FROM dual UNION ALL 
 SELECT 3, 73 FROM dual UNION ALL 
 SELECT 12, 73 FROM dual UNION ALL 
 SELECT 8, 76 FROM dual UNION ALL 
 SELECT 2, 82 FROM dual UNION ALL 
 SELECT 10, 82 FROM dual UNION ALL 
 SELECT 11, 82 FROM dual UNION ALL 
 SELECT 10, 86 FROM dual UNION ALL 
 SELECT 11, 86 FROM dual UNION ALL 
 SELECT 12, 86 FROM dual UNION ALL 
 SELECT 4, 87 FROM dual UNION ALL 
 SELECT 8, 87 FROM dual UNION ALL 
 SELECT 10, 87 FROM dual UNION ALL 
 SELECT 12, 87 FROM dual UNION ALL 
 SELECT 2, 96 FROM dual UNION ALL 
 SELECT 10, 96 FROM dual UNION ALL 
 SELECT 12, 96 FROM dual UNION ALL 
 SELECT 2, 115 FROM dual UNION ALL 
 SELECT 3, 115 FROM dual UNION ALL 
 SELECT 4, 115 FROM dual UNION ALL 
 SELECT 10, 115 FROM dual UNION ALL 
 SELECT 10, 116 FROM dual UNION ALL 
 SELECT 12, 116 FROM dual UNION ALL 
 SELECT 2, 119 FROM dual UNION ALL 
 SELECT 11, 119 FROM dual UNION ALL 
 SELECT 7, 132 FROM dual UNION ALL 
 SELECT 3, 134 FROM dual UNION ALL 
 SELECT 4, 134 FROM dual UNION ALL 
 SELECT 8, 134 FROM dual UNION ALL 
 SELECT 4, 140 FROM dual UNION ALL 
 SELECT 4, 142 FROM dual UNION ALL 
 SELECT 12, 142 FROM dual UNION ALL 
 SELECT 3, 154 FROM dual UNION ALL 
 SELECT 12, 154 FROM dual UNION ALL 
 SELECT 4, 168 FROM dual UNION ALL 
 SELECT 10, 168 FROM dual UNION ALL 
 SELECT 12, 168 FROM dual UNION ALL 
 SELECT 2, 176 FROM dual UNION ALL 
 SELECT 4, 176 FROM dual UNION ALL 
 SELECT 2, 182 FROM dual UNION ALL 
 SELECT 3, 182 FROM dual UNION ALL 
 SELECT 4, 182 FROM dual UNION ALL 
 SELECT 10, 182 FROM dual UNION ALL 
 SELECT 11, 182 FROM dual UNION ALL 
 SELECT 12, 182 FROM dual UNION ALL 
 SELECT 2, 194 FROM dual UNION ALL 
 SELECT 10, 194 FROM dual UNION ALL 
 SELECT 11, 194 FROM dual UNION ALL 
 SELECT 12, 194 FROM dual UNION ALL 
 SELECT 2, 196 FROM dual UNION ALL 
 SELECT 10, 196 FROM dual UNION ALL 
 SELECT 12, 196 FROM dual UNION ALL 
 SELECT 2, 200 FROM dual UNION ALL 
 SELECT 3, 200 FROM dual UNION ALL 
 SELECT 4, 200 FROM dual UNION ALL 
 SELECT 7, 200 FROM dual UNION ALL 
 SELECT 8, 200 FROM dual UNION ALL 
 SELECT 10, 201 FROM dual UNION ALL 
 SELECT 12, 201 FROM dual UNION ALL 
 SELECT 2, 205 FROM dual UNION ALL 
 SELECT 4, 205 FROM dual UNION ALL 
 SELECT 8, 205 FROM dual UNION ALL 
 SELECT 2, 207 FROM dual UNION ALL 
 SELECT 3, 207 FROM dual UNION ALL 
 SELECT 4, 207 FROM dual UNION ALL 
 SELECT 7, 207 FROM dual UNION ALL 
 SELECT 8, 207 FROM dual UNION ALL 
 SELECT 12, 207 FROM dual UNION ALL 
 SELECT 2, 214 FROM dual UNION ALL 
 SELECT 12, 214 FROM dual UNION ALL 
 SELECT 7, 215 FROM dual UNION ALL 
 SELECT 12, 215 FROM dual UNION ALL 
 SELECT 12, 223 FROM dual UNION ALL 
 SELECT 10, 230 FROM dual UNION ALL 
 SELECT 11, 230 FROM dual UNION ALL 
 SELECT 12, 230 FROM dual UNION ALL 
 SELECT 10, 232 FROM dual UNION ALL 
 SELECT 11, 232 FROM dual UNION ALL 
 SELECT 12, 232 FROM dual UNION ALL 
 SELECT 4, 234 FROM dual UNION ALL 
 SELECT 12, 241 FROM dual UNION ALL 
 SELECT 4, 245 FROM dual UNION ALL 
 SELECT 8, 245 FROM dual UNION ALL 
 SELECT 2, 247 FROM dual UNION ALL 
 SELECT 10, 247 FROM dual UNION ALL 
 SELECT 12, 247 FROM dual UNION ALL 
 SELECT 3, 259 FROM dual UNION ALL 
 SELECT 3, 268 FROM dual UNION ALL 
 SELECT 4, 268 FROM dual UNION ALL 
 SELECT 7, 268 FROM dual UNION ALL 
 SELECT 8, 268 FROM dual UNION ALL 
 SELECT 11, 272 FROM dual UNION ALL 
 SELECT 12, 272 FROM dual UNION ALL 
 SELECT 12, 282 FROM dual UNION ALL 
 SELECT 10, 285 FROM dual UNION ALL 
 SELECT 12, 285 FROM dual UNION ALL 
 SELECT 2, 288 FROM dual UNION ALL 
 SELECT 10, 288 FROM dual UNION ALL 
 SELECT 12, 288 FROM dual UNION ALL 
 SELECT 2, 293 FROM dual UNION ALL 
 SELECT 10, 293 FROM dual UNION ALL 
 SELECT 11, 293 FROM dual UNION ALL 
 SELECT 12, 293 FROM dual UNION ALL 
 SELECT 2, 298 FROM dual UNION ALL 
 SELECT 3, 298 FROM dual UNION ALL 
 SELECT 8, 298 FROM dual UNION ALL 
 SELECT 10, 308 FROM dual UNION ALL 
 SELECT 11, 308 FROM dual UNION ALL 
 SELECT 12, 308 FROM dual UNION ALL 
 SELECT 4, 309 FROM dual UNION ALL 
 SELECT 8, 309 FROM dual UNION ALL 
 SELECT 3, 311 FROM dual UNION ALL 
 SELECT 2, 317 FROM dual UNION ALL 
 SELECT 10, 317 FROM dual UNION ALL 
 SELECT 11, 317 FROM dual UNION ALL 
 SELECT 12, 317 FROM dual UNION ALL 
 SELECT 3, 349 FROM dual UNION ALL 
 SELECT 10, 352 FROM dual UNION ALL 
 SELECT 12, 352 FROM dual UNION ALL 
 SELECT 2, 360 FROM dual UNION ALL 
 SELECT 3, 360 FROM dual UNION ALL 
 SELECT 7, 360 FROM dual UNION ALL 
 SELECT 3, 7 FROM dual UNION ALL 
 SELECT 12, 7 FROM dual UNION ALL 
 SELECT 7, 13 FROM dual UNION ALL 
 SELECT 3, 19 FROM dual UNION ALL 
 SELECT 2, 29 FROM dual UNION ALL 
 SELECT 3, 29 FROM dual UNION ALL 
 SELECT 12, 29 FROM dual UNION ALL 
 SELECT 7, 35 FROM dual UNION ALL 
 SELECT 10, 37 FROM dual UNION ALL 
 SELECT 12, 37 FROM dual UNION ALL 
 SELECT 4, 41 FROM dual UNION ALL 
 SELECT 2, 49 FROM dual UNION ALL 
 SELECT 3, 49 FROM dual UNION ALL 
 SELECT 10, 49 FROM dual UNION ALL 
 SELECT 12, 49 FROM dual UNION ALL 
 SELECT 4, 62 FROM dual UNION ALL 
 SELECT 8, 62 FROM dual UNION ALL 
 SELECT 8, 63 FROM dual UNION ALL 
 SELECT 10, 77 FROM dual UNION ALL 
 SELECT 11, 77 FROM dual UNION ALL 
 SELECT 12, 77 FROM dual UNION ALL 
 SELECT 3, 78 FROM dual UNION ALL 
 SELECT 7, 78 FROM dual UNION ALL 
 SELECT 7, 83 FROM dual UNION ALL 
 SELECT 3, 88 FROM dual UNION ALL 
 SELECT 4, 88 FROM dual UNION ALL 
 SELECT 7, 88 FROM dual UNION ALL 
 SELECT 8, 88 FROM dual UNION ALL 
 SELECT 10, 88 FROM dual UNION ALL 
 SELECT 11, 88 FROM dual UNION ALL 
 SELECT 2, 101 FROM dual UNION ALL 
 SELECT 3, 101 FROM dual UNION ALL 
 SELECT 4, 101 FROM dual UNION ALL 
 SELECT 7, 101 FROM dual UNION ALL 
 SELECT 10, 101 FROM dual UNION ALL 
 SELECT 12, 101 FROM dual UNION ALL 
 SELECT 7, 114 FROM dual UNION ALL 
 SELECT 2, 127 FROM dual UNION ALL 
 SELECT 10, 127 FROM dual UNION ALL 
 SELECT 11, 127 FROM dual UNION ALL 
 SELECT 12, 127 FROM dual UNION ALL 
 SELECT 2, 130 FROM dual UNION ALL 
 SELECT 3, 130 FROM dual UNION ALL 
 SELECT 4, 130 FROM dual UNION ALL 
 SELECT 12, 130 FROM dual UNION ALL 
 SELECT 10, 136 FROM dual UNION ALL 
 SELECT 12, 136 FROM dual UNION ALL 
 SELECT 10, 144 FROM dual UNION ALL 
 SELECT 11, 144 FROM dual UNION ALL 
 SELECT 12, 144 FROM dual UNION ALL 
 SELECT 10, 151 FROM dual UNION ALL 
 SELECT 11, 151 FROM dual UNION ALL 
 SELECT 12, 151 FROM dual UNION ALL 
 SELECT 2, 158 FROM dual UNION ALL 
 SELECT 3, 158 FROM dual UNION ALL 
 SELECT 12, 158 FROM dual UNION ALL 
 SELECT 10, 173 FROM dual UNION ALL 
 SELECT 12, 173 FROM dual UNION ALL 
 SELECT 11, 184 FROM dual UNION ALL 
 SELECT 2, 186 FROM dual UNION ALL 
 SELECT 10, 186 FROM dual UNION ALL 
 SELECT 11, 186 FROM dual UNION ALL 
 SELECT 12, 186 FROM dual UNION ALL 
 SELECT 2, 199 FROM dual UNION ALL 
 SELECT 12, 199 FROM dual UNION ALL 
 SELECT 8, 203 FROM dual UNION ALL 
 SELECT 12, 203 FROM dual UNION ALL 
 SELECT 10, 204 FROM dual UNION ALL 
 SELECT 3, 211 FROM dual UNION ALL 
 SELECT 7, 211 FROM dual UNION ALL 
 SELECT 10, 211 FROM dual UNION ALL 
 SELECT 11, 211 FROM dual UNION ALL 
 SELECT 12, 211 FROM dual UNION ALL 
 SELECT 2, 216 FROM dual UNION ALL 
 SELECT 11, 216 FROM dual UNION ALL 
 SELECT 12, 216 FROM dual UNION ALL 
 SELECT 3, 219 FROM dual UNION ALL 
 SELECT 3, 222 FROM dual UNION ALL 
 SELECT 4, 222 FROM dual UNION ALL 
 SELECT 2, 240 FROM dual UNION ALL 
 SELECT 8, 240 FROM dual UNION ALL 
 SELECT 12, 240 FROM dual UNION ALL 
 SELECT 12, 249 FROM dual UNION ALL 
 SELECT 2, 253 FROM dual UNION ALL 
 SELECT 4, 253 FROM dual UNION ALL 
 SELECT 8, 253 FROM dual UNION ALL 
 SELECT 3, 266 FROM dual UNION ALL 
 SELECT 4, 266 FROM dual UNION ALL 
 SELECT 8, 266 FROM dual UNION ALL 
 SELECT 10, 266 FROM dual UNION ALL 
 SELECT 12, 266 FROM dual UNION ALL 
 SELECT 3, 277 FROM dual UNION ALL 
 SELECT 7, 277 FROM dual UNION ALL 
 SELECT 11, 277 FROM dual UNION ALL 
 SELECT 12, 277 FROM dual UNION ALL 
 SELECT 3, 281 FROM dual UNION ALL 
 SELECT 7, 281 FROM dual UNION ALL 
 SELECT 2, 290 FROM dual UNION ALL 
 SELECT 3, 290 FROM dual UNION ALL 
 SELECT 12, 290 FROM dual UNION ALL 
 SELECT 4, 302 FROM dual UNION ALL 
 SELECT 10, 302 FROM dual UNION ALL 
 SELECT 12, 302 FROM dual UNION ALL 
 SELECT 10, 303 FROM dual UNION ALL 
 SELECT 12, 303 FROM dual UNION ALL 
 SELECT 2, 306 FROM dual UNION ALL 
 SELECT 3, 306 FROM dual UNION ALL 
 SELECT 2, 307 FROM dual UNION ALL 
 SELECT 4, 307 FROM dual UNION ALL 
 SELECT 8, 307 FROM dual UNION ALL 
 SELECT 3, 310 FROM dual UNION ALL 
 SELECT 2, 313 FROM dual UNION ALL 
 SELECT 10, 313 FROM dual UNION ALL 
 SELECT 12, 313 FROM dual UNION ALL 
 SELECT 2, 333 FROM dual UNION ALL 
 SELECT 3, 333 FROM dual UNION ALL 
 SELECT 10, 333 FROM dual UNION ALL 
 SELECT 11, 333 FROM dual UNION ALL 
 SELECT 12, 333 FROM dual UNION ALL 
 SELECT 11, 342 FROM dual UNION ALL 
 SELECT 12, 342 FROM dual UNION ALL 
 SELECT 4, 350 FROM dual UNION ALL 
 SELECT 8, 350 FROM dual UNION ALL 
 SELECT 10, 350 FROM dual UNION ALL 
 SELECT 12, 350 FROM dual UNION ALL 
 SELECT 3, 351 FROM dual UNION ALL 
 SELECT 4, 351 FROM dual UNION ALL 
 SELECT 8, 351 FROM dual UNION ALL 
 SELECT 10, 351 FROM dual UNION ALL 
 SELECT 4, 355 FROM dual UNION ALL 
 SELECT 8, 355 FROM dual UNION ALL 
 SELECT 7, 11 FROM dual UNION ALL 
 SELECT 7, 12 FROM dual UNION ALL 
 SELECT 3, 17 FROM dual UNION ALL 
 SELECT 7, 17 FROM dual UNION ALL 
 SELECT 10, 17 FROM dual UNION ALL 
 SELECT 11, 17 FROM dual UNION ALL 
 SELECT 12, 17 FROM dual UNION ALL 
 SELECT 12, 22 FROM dual UNION ALL 
 SELECT 4, 34 FROM dual UNION ALL 
 SELECT 10, 34 FROM dual UNION ALL 
 SELECT 11, 34 FROM dual UNION ALL 
 SELECT 12, 34 FROM dual UNION ALL 
 SELECT 2, 59 FROM dual UNION ALL 
 SELECT 2, 61 FROM dual UNION ALL 
 SELECT 4, 61 FROM dual UNION ALL 
 SELECT 10, 61 FROM dual UNION ALL 
 SELECT 12, 61 FROM dual UNION ALL 
 SELECT 4, 67 FROM dual UNION ALL 
 SELECT 12, 67 FROM dual UNION ALL 
 SELECT 4, 69 FROM dual UNION ALL 
 SELECT 8, 69 FROM dual UNION ALL 
 SELECT 3, 74 FROM dual UNION ALL 
 SELECT 4, 74 FROM dual UNION ALL 
 SELECT 12, 74 FROM dual UNION ALL 
 SELECT 3, 89 FROM dual UNION ALL 
 SELECT 7, 89 FROM dual UNION ALL 
 SELECT 2, 97 FROM dual UNION ALL 
 SELECT 10, 97 FROM dual UNION ALL 
 SELECT 11, 97 FROM dual UNION ALL 
 SELECT 12, 97 FROM dual UNION ALL 
 SELECT 3, 103 FROM dual UNION ALL 
 SELECT 4, 106 FROM dual UNION ALL 
 SELECT 10, 106 FROM dual UNION ALL 
 SELECT 12, 121 FROM dual UNION ALL 
 SELECT 12, 124 FROM dual UNION ALL 
 SELECT 12, 138 FROM dual UNION ALL 
 SELECT 2, 149 FROM dual UNION ALL 
 SELECT 3, 149 FROM dual UNION ALL 
 SELECT 4, 149 FROM dual UNION ALL 
 SELECT 8, 149 FROM dual UNION ALL 
 SELECT 4, 155 FROM dual UNION ALL 
 SELECT 2, 162 FROM dual UNION ALL 
 SELECT 10, 162 FROM dual UNION ALL 
 SELECT 12, 162 FROM dual UNION ALL 
 SELECT 3, 164 FROM dual UNION ALL 
 SELECT 2, 171 FROM dual UNION ALL 
 SELECT 4, 171 FROM dual UNION ALL 
 SELECT 11, 171 FROM dual UNION ALL 
 SELECT 12, 171 FROM dual UNION ALL 
 SELECT 4, 187 FROM dual UNION ALL 
 SELECT 10, 187 FROM dual UNION ALL 
 SELECT 12, 187 FROM dual UNION ALL 
 SELECT 12, 198 FROM dual UNION ALL 
 SELECT 2, 206 FROM dual UNION ALL 
 SELECT 3, 206 FROM dual UNION ALL 
 SELECT 4, 206 FROM dual UNION ALL 
 SELECT 7, 206 FROM dual UNION ALL 
 SELECT 8, 206 FROM dual UNION ALL 
 SELECT 12, 206 FROM dual UNION ALL 
 SELECT 12, 235 FROM dual UNION ALL 
 SELECT 12, 237 FROM dual UNION ALL 
 SELECT 12, 243 FROM dual UNION ALL 
 SELECT 12, 248 FROM dual UNION ALL 
 SELECT 2, 255 FROM dual UNION ALL 
 SELECT 4, 255 FROM dual UNION ALL 
 SELECT 10, 255 FROM dual UNION ALL 
 SELECT 12, 255 FROM dual UNION ALL 
 SELECT 7, 312 FROM dual UNION ALL 
 SELECT 3, 314 FROM dual UNION ALL 
 SELECT 4, 314 FROM dual UNION ALL 
 SELECT 12, 314 FROM dual UNION ALL 
 SELECT 4, 315 FROM dual UNION ALL 
 SELECT 8, 315 FROM dual UNION ALL 
 SELECT 10, 315 FROM dual UNION ALL 
 SELECT 12, 315 FROM dual UNION ALL 
 SELECT 4, 344 FROM dual UNION ALL 
 SELECT 10, 344 FROM dual UNION ALL 
 SELECT 12, 344 FROM dual UNION ALL 
 SELECT 2, 8 FROM dual UNION ALL 
 SELECT 10, 8 FROM dual UNION ALL 
 SELECT 12, 8 FROM dual UNION ALL 
 SELECT 4, 9 FROM dual UNION ALL 
 SELECT 2, 14 FROM dual UNION ALL 
 SELECT 4, 14 FROM dual UNION ALL 
 SELECT 7, 16 FROM dual UNION ALL 
 SELECT 12, 30 FROM dual UNION ALL 
 SELECT 7, 48 FROM dual UNION ALL 
 SELECT 10, 52 FROM dual UNION ALL 
 SELECT 12, 52 FROM dual UNION ALL 
 SELECT 3, 55 FROM dual UNION ALL 
 SELECT 4, 56 FROM dual UNION ALL 
 SELECT 8, 56 FROM dual UNION ALL 
 SELECT 10, 60 FROM dual UNION ALL 
 SELECT 12, 60 FROM dual UNION ALL 
 SELECT 4, 65 FROM dual UNION ALL 
 SELECT 12, 65 FROM dual UNION ALL 
 SELECT 8, 68 FROM dual UNION ALL 
 SELECT 11, 70 FROM dual UNION ALL 
 SELECT 12, 70 FROM dual UNION ALL 
 SELECT 3, 71 FROM dual UNION ALL 
 SELECT 4, 71 FROM dual UNION ALL 
 SELECT 10, 81 FROM dual UNION ALL 
 SELECT 12, 81 FROM dual UNION ALL 
 SELECT 3, 100 FROM dual UNION ALL 
 SELECT 7, 100 FROM dual UNION ALL 
 SELECT 2, 108 FROM dual UNION ALL 
 SELECT 12, 108 FROM dual UNION ALL 
 SELECT 2, 110 FROM dual UNION ALL 
 SELECT 11, 110 FROM dual UNION ALL 
 SELECT 12, 110 FROM dual UNION ALL 
 SELECT 3, 141 FROM dual UNION ALL 
 SELECT 2, 153 FROM dual UNION ALL 
 SELECT 3, 153 FROM dual UNION ALL 
 SELECT 4, 153 FROM dual UNION ALL 
 SELECT 7, 153 FROM dual UNION ALL 
 SELECT 12, 153 FROM dual UNION ALL 
 SELECT 2, 163 FROM dual UNION ALL 
 SELECT 3, 163 FROM dual UNION ALL 
 SELECT 4, 163 FROM dual UNION ALL 
 SELECT 3, 170 FROM dual UNION ALL 
 SELECT 2, 181 FROM dual UNION ALL 
 SELECT 10, 181 FROM dual UNION ALL 
 SELECT 11, 181 FROM dual UNION ALL 
 SELECT 12, 181 FROM dual UNION ALL 
 SELECT 3, 193 FROM dual UNION ALL 
 SELECT 4, 193 FROM dual UNION ALL 
 SELECT 10, 193 FROM dual UNION ALL 
 SELECT 2, 197 FROM dual UNION ALL 
 SELECT 3, 197 FROM dual UNION ALL 
 SELECT 12, 197 FROM dual UNION ALL 
 SELECT 2, 217 FROM dual UNION ALL 
 SELECT 3, 217 FROM dual UNION ALL 
 SELECT 4, 217 FROM dual UNION ALL 
 SELECT 2, 231 FROM dual UNION ALL 
 SELECT 12, 231 FROM dual UNION ALL 
 SELECT 2, 233 FROM dual UNION ALL 
 SELECT 12, 233 FROM dual UNION ALL 
 SELECT 12, 246 FROM dual UNION ALL 
 SELECT 2, 251 FROM dual UNION ALL 
 SELECT 3, 251 FROM dual UNION ALL 
 SELECT 4, 251 FROM dual UNION ALL 
 SELECT 12, 251 FROM dual UNION ALL 
 SELECT 2, 270 FROM dual UNION ALL 
 SELECT 3, 270 FROM dual UNION ALL 
 SELECT 7, 270 FROM dual UNION ALL 
 SELECT 12, 271 FROM dual UNION ALL 
 SELECT 4, 276 FROM dual UNION ALL 
 SELECT 2, 286 FROM dual UNION ALL 
 SELECT 3, 286 FROM dual UNION ALL 
 SELECT 4, 286 FROM dual UNION ALL 
 SELECT 11, 286 FROM dual UNION ALL 
 SELECT 12, 286 FROM dual UNION ALL 
 SELECT 2, 289 FROM dual UNION ALL 
 SELECT 10, 289 FROM dual UNION ALL 
 SELECT 12, 289 FROM dual UNION ALL 
 SELECT 8, 320 FROM dual UNION ALL 
 SELECT 10, 323 FROM dual UNION ALL 
 SELECT 12, 323 FROM dual UNION ALL 
 SELECT 2, 326 FROM dual UNION ALL 
 SELECT 10, 326 FROM dual UNION ALL 
 SELECT 12, 326 FROM dual UNION ALL 
 SELECT 4, 335 FROM dual UNION ALL 
 SELECT 8, 335 FROM dual UNION ALL 
 SELECT 12, 345 FROM dual UNION ALL 
 SELECT 4, 347 FROM dual UNION ALL 
 SELECT 10, 347 FROM dual UNION ALL 
 SELECT 12, 347 FROM dual UNION ALL 
 SELECT 10, 23 FROM dual UNION ALL 
 SELECT 11, 23 FROM dual UNION ALL 
 SELECT 12, 23 FROM dual UNION ALL 
 SELECT 3, 31 FROM dual UNION ALL 
 SELECT 10, 43 FROM dual UNION ALL 
 SELECT 12, 43 FROM dual UNION ALL 
 SELECT 10, 47 FROM dual UNION ALL 
 SELECT 11, 47 FROM dual UNION ALL 
 SELECT 12, 47 FROM dual UNION ALL 
 SELECT 4, 66 FROM dual UNION ALL 
 SELECT 11, 66 FROM dual UNION ALL 
 SELECT 12, 72 FROM dual UNION ALL 
 SELECT 3, 80 FROM dual UNION ALL 
 SELECT 11, 80 FROM dual UNION ALL 
 SELECT 12, 80 FROM dual UNION ALL 
 SELECT 10, 99 FROM dual UNION ALL 
 SELECT 12, 99 FROM dual UNION ALL 
 SELECT 12, 109 FROM dual UNION ALL 
 SELECT 2, 123 FROM dual UNION ALL 
 SELECT 10, 123 FROM dual UNION ALL 
 SELECT 11, 123 FROM dual UNION ALL 
 SELECT 12, 123 FROM dual UNION ALL 
 SELECT 2, 133 FROM dual UNION ALL 
 SELECT 3, 133 FROM dual UNION ALL 
 SELECT 4, 133 FROM dual UNION ALL 
 SELECT 11, 143 FROM dual UNION ALL 
 SELECT 12, 143 FROM dual UNION ALL 
 SELECT 3, 146 FROM dual UNION ALL 
 SELECT 10, 157 FROM dual UNION ALL 
 SELECT 12, 157 FROM dual UNION ALL 
 SELECT 2, 165 FROM dual UNION ALL 
 SELECT 12, 165 FROM dual UNION ALL 
 SELECT 3, 172 FROM dual UNION ALL 
 SELECT 3, 174 FROM dual UNION ALL 
 SELECT 4, 174 FROM dual UNION ALL 
 SELECT 3, 178 FROM dual UNION ALL 
 SELECT 4, 178 FROM dual UNION ALL 
 SELECT 12, 212 FROM dual UNION ALL 
 SELECT 2, 220 FROM dual UNION ALL 
 SELECT 10, 220 FROM dual UNION ALL 
 SELECT 11, 220 FROM dual UNION ALL 
 SELECT 12, 220 FROM dual UNION ALL 
 SELECT 4, 239 FROM dual UNION ALL 
 SELECT 10, 239 FROM dual UNION ALL 
 SELECT 12, 239 FROM dual UNION ALL 
 SELECT 12, 242 FROM dual UNION ALL 
 SELECT 2, 244 FROM dual UNION ALL 
 SELECT 12, 244 FROM dual UNION ALL 
 SELECT 3, 250 FROM dual UNION ALL 
 SELECT 2, 264 FROM dual UNION ALL 
 SELECT 12, 264 FROM dual UNION ALL 
 SELECT 4, 318 FROM dual UNION ALL 
 SELECT 10, 318 FROM dual UNION ALL 
 SELECT 12, 318 FROM dual UNION ALL 
 SELECT 4, 334 FROM dual UNION ALL 
 SELECT 2, 338 FROM dual UNION ALL 
 SELECT 3, 338 FROM dual UNION ALL 
 SELECT 10, 338 FROM dual UNION ALL 
 SELECT 11, 338 FROM dual UNION ALL 
 SELECT 12, 338 FROM dual UNION ALL 
 SELECT 12, 346 FROM dual UNION ALL 
 SELECT 4, 348 FROM dual UNION ALL 
 SELECT 4, 354 FROM dual UNION ALL 
 SELECT 3, 358 FROM dual UNION ALL 
 SELECT 3, 64 FROM dual UNION ALL 
 SELECT 10, 90 FROM dual UNION ALL 
 SELECT 12, 90 FROM dual UNION ALL 
 SELECT 3, 105 FROM dual UNION ALL 
 SELECT 2, 120 FROM dual UNION ALL 
 SELECT 3, 120 FROM dual UNION ALL 
 SELECT 10, 120 FROM dual UNION ALL 
 SELECT 11, 120 FROM dual UNION ALL 
 SELECT 12, 120 FROM dual UNION ALL 
 SELECT 10, 135 FROM dual UNION ALL 
 SELECT 11, 135 FROM dual UNION ALL 
 SELECT 12, 135 FROM dual UNION ALL 
 SELECT 3, 139 FROM dual UNION ALL 
 SELECT 4, 139 FROM dual UNION ALL 
 SELECT 10, 139 FROM dual UNION ALL 
 SELECT 2, 147 FROM dual UNION ALL 
 SELECT 11, 147 FROM dual UNION ALL 
 SELECT 12, 147 FROM dual UNION ALL 
 SELECT 2, 229 FROM dual UNION ALL 
 SELECT 4, 229 FROM dual UNION ALL 
 SELECT 12, 229 FROM dual UNION ALL 
 SELECT 2, 236 FROM dual UNION ALL 
 SELECT 12, 236 FROM dual UNION ALL 
 SELECT 2, 238 FROM dual UNION ALL 
 SELECT 12, 238 FROM dual UNION ALL 
 SELECT 3, 252 FROM dual UNION ALL 
 SELECT 10, 252 FROM dual UNION ALL 
 SELECT 11, 252 FROM dual UNION ALL 
 SELECT 12, 252 FROM dual UNION ALL 
 SELECT 10, 261 FROM dual UNION ALL 
 SELECT 12, 261 FROM dual UNION ALL 
 SELECT 2, 265 FROM dual UNION ALL 
 SELECT 12, 265 FROM dual UNION ALL 
 SELECT 2, 275 FROM dual UNION ALL 
 SELECT 3, 275 FROM dual UNION ALL 
 SELECT 4, 275 FROM dual UNION ALL 
 SELECT 2, 279 FROM dual UNION ALL 
 SELECT 3, 279 FROM dual UNION ALL 
 SELECT 4, 280 FROM dual UNION ALL 
 SELECT 10, 280 FROM dual UNION ALL 
 SELECT 12, 280 FROM dual UNION ALL 
 SELECT 12, 291 FROM dual UNION ALL 
 SELECT 12, 300 FROM dual UNION ALL 
 SELECT 2, 321 FROM dual UNION ALL 
 SELECT 3, 321 FROM dual UNION ALL 
 SELECT 12, 321 FROM dual UNION ALL 
 SELECT 2, 325 FROM dual UNION ALL 
 SELECT 10, 325 FROM dual UNION ALL 
 SELECT 12, 325 FROM dual UNION ALL 
 SELECT 4, 6 FROM dual UNION ALL 
 SELECT 3, 10 FROM dual UNION ALL 
 SELECT 12, 10 FROM dual UNION ALL 
 SELECT 4, 21 FROM dual UNION ALL 
 SELECT 12, 21 FROM dual UNION ALL 
 SELECT 12, 50 FROM dual UNION ALL 
 SELECT 3, 75 FROM dual UNION ALL 
 SELECT 4, 75 FROM dual UNION ALL 
 SELECT 12, 75 FROM dual UNION ALL 
 SELECT 11, 91 FROM dual UNION ALL 
 SELECT 12, 91 FROM dual UNION ALL 
 SELECT 2, 107 FROM dual UNION ALL 
 SELECT 10, 107 FROM dual UNION ALL 
 SELECT 11, 107 FROM dual UNION ALL 
 SELECT 12, 107 FROM dual UNION ALL 
 SELECT 3, 112 FROM dual UNION ALL 
 SELECT 4, 112 FROM dual UNION ALL 
 SELECT 10, 112 FROM dual UNION ALL 
 SELECT 2, 129 FROM dual UNION ALL 
 SELECT 4, 129 FROM dual UNION ALL 
 SELECT 11, 129 FROM dual UNION ALL 
 SELECT 12, 129 FROM dual UNION ALL 
 SELECT 2, 156 FROM dual UNION ALL 
 SELECT 11, 156 FROM dual UNION ALL 
 SELECT 3, 183 FROM dual UNION ALL 
 SELECT 10, 191 FROM dual UNION ALL 
 SELECT 12, 191 FROM dual UNION ALL 
 SELECT 12, 221 FROM dual UNION ALL 
 SELECT 2, 227 FROM dual UNION ALL 
 SELECT 12, 227 FROM dual UNION ALL 
 SELECT 2, 258 FROM dual UNION ALL 
 SELECT 10, 258 FROM dual UNION ALL 
 SELECT 11, 258 FROM dual UNION ALL 
 SELECT 12, 258 FROM dual UNION ALL 
 SELECT 4, 319 FROM dual UNION ALL 
 SELECT 10, 319 FROM dual UNION ALL 
 SELECT 12, 319 FROM dual UNION ALL 
 SELECT 12, 324 FROM dual UNION ALL 
 SELECT 4, 340 FROM dual UNION ALL 
 SELECT 3, 27 FROM dual UNION ALL 
 SELECT 11, 27 FROM dual UNION ALL 
 SELECT 12, 27 FROM dual UNION ALL 
 SELECT 2, 148 FROM dual UNION ALL 
 SELECT 4, 148 FROM dual UNION ALL 
 SELECT 11, 148 FROM dual UNION ALL 
 SELECT 12, 148 FROM dual UNION ALL 
 SELECT 3, 152 FROM dual UNION ALL 
 SELECT 10, 152 FROM dual UNION ALL 
 SELECT 12, 152 FROM dual UNION ALL 
 SELECT 11, 190 FROM dual UNION ALL 
 SELECT 12, 190 FROM dual UNION ALL 
 SELECT 3, 218 FROM dual UNION ALL 
 SELECT 10, 226 FROM dual UNION ALL 
 SELECT 12, 226 FROM dual UNION ALL 
 SELECT 2, 256 FROM dual UNION ALL 
 SELECT 2, 257 FROM dual UNION ALL 
 SELECT 10, 257 FROM dual UNION ALL 
 SELECT 11, 257 FROM dual UNION ALL 
 SELECT 12, 257 FROM dual UNION ALL 
 SELECT 12, 262 FROM dual UNION ALL 
 SELECT 4, 292 FROM dual UNION ALL 
 SELECT 12, 292 FROM dual UNION ALL 
 SELECT 4, 316 FROM dual UNION ALL 
 SELECT 10, 332 FROM dual UNION ALL 
 SELECT 12, 332 FROM dual UNION ALL 
 SELECT 2, 336 FROM dual UNION ALL 
 SELECT 11, 336 FROM dual UNION ALL 
 SELECT 12, 336 FROM dual UNION ALL 
 SELECT 3, 337 FROM dual UNION ALL 
 SELECT 4, 337 FROM dual UNION ALL 
 SELECT 12, 353 FROM dual UNION ALL 
 SELECT 10, 356 FROM dual UNION ALL 
 SELECT 12, 356 FROM dual UNION ALL 
 SELECT 7, 33 FROM dual UNION ALL 
 SELECT 4, 159 FROM dual UNION ALL 
 SELECT 8, 159 FROM dual UNION ALL 
 SELECT 4, 160 FROM dual UNION ALL 
 SELECT 8, 160 FROM dual UNION ALL 
 SELECT 7, 92 FROM dual UNION ALL 
 SELECT 10, 361 FROM dual UNION ALL 
 SELECT 12, 361 FROM dual;


--Retrieve the player name, class name, and race of each player.
SELECT P.PLAYER_NAME, C.CLASS_NAME, P.RACE FROM PLAYERS P
INNER JOIN CLASSES C
ON P.CLASS_ID = C.CLASS_ID;

--Retrieve all classes that can cast the spell Bane.
SELECT C.CLASS_NAME FROM CLASSES C
INNER JOIN CLASS_SPELLS CS
ON C.CLASS_ID = CS.CLASS_ID
WHERE CS.SPELL_ID = 15;

--Retrieve the player names and classes of all players with an armor class and strength of at least 15.
SELECT P.PLAYER_NAME, C.CLASS_NAME FROM PLAYERS P
INNER JOIN CLASSES C
ON C.CLASS_ID = P.CLASS_ID
WHERE P.STRENGTH >= 15 AND ARMOR_CLASS >= 15;

--Retrieve all spells with a spell name that starts with c.
SELECT SPELL_NAME FROM SPELLS
WHERE SPELL_NAME LIKE 'C%';

--Return the name of the player(s) with the highest max hp.
SELECT PLAYER_NAME FROM PLAYERS
WHERE MAX_HP = (SELECT MAX(MAX_HP) FROM PLAYERS);

--Retrieve the total amount of spells each class has available to choose from (not counting classes that 
--don't use spells.)
SELECT C.CLASS_ID, C.CLASS_NAME, COUNT(SPELL_ID) AS SPELL_COUNT FROM CLASS_SPELLS CS
LEFT OUTER JOIN CLASSES C
ON C.CLASS_ID = CS.CLASS_ID
GROUP BY C.CLASS_ID, C.CLASS_NAME;

--Retrieve all classes that can cast the spell Cloudkill.
SELECT CLASS_NAME FROM CLASSES
WHERE CLASS_ID IN(SELECT CLASS_ID FROM CLASS_SPELLS WHERE SPELL_ID = 52);

--Create a view of all classes that do not cast spells.
CREATE OR REPLACE VIEW MARTIAL_CLASSES AS
SELECT * FROM CLASSES
WHERE CLASS_ID != ALL(SELECT CLASS_ID FROM CLASS_SPELLS);
SELECT * FROM MARTIAL_CLASSES;
--Create a table that has all players and monsters with their initiatives in order.
DROP TABLE INIT;
CREATE TABLE INIT AS
SELECT PLAYER_NAME, INITIATIVE
FROM PLAYERS
UNION SELECT MONSTER_NAME, INITIATIVE
FROM MONSTERS
ORDER BY INITIATIVE;
SELECT * FROM INIT;

--Create a view that estimates if players or monsters will succeed in a constitution saving throw
CREATE OR REPLACE VIEW SAVINGTHROW AS
SELECT PLAYER_NAME, CONSTITUTION, DECODE(TRUNC((CONSTITUTION-10)/2),2,'SUCCEED','FAIL')AS PREDICT
FROM PLAYERS
UNION
SELECT MONSTER_NAME, CONSTITUTION, DECODE(TRUNC((CONSTITUTION-10)/2),2,'SUCCEED','FAIL')AS PREDICT
FROM MONSTERS
ORDER BY CONSTITUTION;
SELECT * FROM SAVINGTHROW;

--Create a view that shows the number of spells per spell type with spell levels lower than 5
CREATE OR REPLACE VIEW LOWSPELLS AS
SELECT SPELL_TYPE, COUNT(*) AS COUNTER FROM SPELLS
GROUP BY SPELL_TYPE, SPELL_LEVEL
HAVING SPELL_LEVEL < 5;

SELECT * FROM LOWSPELLS;

--Does the same as above, but in a way that the view can be used to update the spells table with
--my own homemade spell
SELECT * FROM SPELLS;

CREATE OR REPLACE VIEW LOWERSPELLS AS
SELECT SPELL_ID, SPELL_NAME FROM SPELLS
WHERE SPELL_LEVEL < 4;
SELECT * FROM LOWERSPELLS;

SAVEPOINT A;

INSERT INTO LOWERSPELLS values (362, 'Dummy Spell');

DELETE FROM SPELLS WHERE SPELL_ID = 362;

ROLLBACK TO SAVEPOINT A;

--Update cleric in players table to have the fighter's constitution stat
SELECT * FROM PLAYERS;
UPDATE PLAYERS SET CONSTITUTION = (SELECT CONSTITUTION FROM PLAYERS WHERE PLAYER_ID = 2)
WHERE PLAYER_ID = 3;

--Creates a view that shows all spell types with only the spell level text included (excluding cantrips)
CREATE OR REPLACE VIEW SPELLTYPES AS
SELECT SPELL_ID, SPELL_NAME, SUBSTR(SPELL_TYPE,0,9) AS TYPES FROM SPELLS
WHERE SPELL_LEVEL != 0;

SELECT * FROM SPELLTYPES;

--shows all spells shorter than 6 letters
SELECT SPELL_NAME FROM SPELLS WHERE LENGTH(SPELL_NAME) < 6;

--shows all dates created for players and monsters formatted as 'Month; DDth "Day"; YyyY'
SELECT PLAYER_NAME, TO_CHAR(DATE_CREATED, 'Month; DDth "Day"; YyyY') AS DATES FROM PLAYERS
UNION
SELECT MONSTER_NAME, TO_CHAR(DATE_CREATED, 'Month; DDth "Day"; YyyY') AS DATES FROM MONSTERS;

--shows all players created between these 2 dates
SELECT PLAYER_NAME, DATE_CREATED FROM PLAYERS WHERE DATE_CREATED BETWEEN '10-JAN-12' AND '24-AUG-37';

--average the initiatives from the monsters and players table to see if one has a particular advantage 
SELECT AVG(P.INITIATIVE), AVG(M.INITIATIVE) FROM PLAYERS P, MONSTERS M; 

SELECT * FROM SPELLS;

--delete all rows from spells that have a casting time of 1 action and a spell range of self
DROP TABLE CLASS_SPELLS;
DELETE FROM SPELLS WHERE 
CASTING_TIME = '1 action' AND SPELL_RANGE = 'Self';

--adding an index to spells table
SELECT * FROM SPELLS;
DROP TABLE CLASS_SPELLS;
ALTER TABLE SPELLS DROP CONSTRAINT SPELL_ID_PK;
ALTER TABLE SPELLS ADD CONSTRAINT SPELL_ID_PK PRIMARY KEY (SPELL_ID);
DROP INDEX SPELLER;
create unique index SPELLER on SPELLS(SPELL_ID);
Select * from spells;

-----------------------------FINAL----------------------------------------------
set echo on;
set serveroutput on;
set serveroutput on format wrapped;
begin
    DBMS_OUTPUT.put_line('simple comment');
end;
/
--------------------------------------------------------------------------------
--code blocks with variables and loops to process data (likely using insert)
--------------------------------------------------------------------------------
--create and fill a table using a code block of all spells of school evocation
DROP TABLE EVOCATION_SPELLS;
CREATE TABLE EVOCATION_SPELLS
(SPELL_ID NUMBER(10),
SPELL_NAME VARCHAR2(128),
SPELL_TYPE VARCHAR2(128),
CONSTRAINT EVOCATION_SPELL_ID_PK PRIMARY KEY (SPELL_ID) );

delete from EVOCATION_SPELLS;

declare
	a_id NUMBER(10);
	a_name VARCHAR2(128);
    a_type VARCHAR2(128);
	counter NUMBER:=0;
begin
    select count(*) into counter from SPELLS;
    FOR i IN (SELECT SPELL_ID, SPELL_NAME, SPELL_TYPE FROM SPELLS WHERE SPELL_TYPE
    LIKE '%evocation')
    loop
    a_id := i.SPELL_ID;
    a_name := i.SPELL_NAME;
    a_type := i.SPELL_TYPE;
    INSERT INTO EVOCATION_SPELLS values(a_id, a_name, a_type);
    end loop;
end;
/

select * from evocation_spells;
--------------------------------------------------------------------------------
--code blocks to retrieve records from tables in database using cursors
--------------------------------------------------------------------------------
--use a cursor to achieve the same thing in the previous code block
declare
	a_id NUMBER(10);
	a_name VARCHAR2(128);
    a_type VARCHAR2(128);
	counter NUMBER:=0;
	cursor evo_cursor is
		select SPELL_ID, SPELL_NAME, SPELL_TYPE from SPELLS WHERE SPELL_TYPE LIKE '%evocation';
	evo_val evo_cursor%ROWTYPE; --create an array with one row, where each field uses the table column data type
	evo_val_type evo_val.SPELL_TYPE%TYPE;
begin
    for i in evo_cursor
    loop
        a_id := i.spell_id;
        a_name := i.spell_name;
        a_type := i.spell_type;
        insert into EVOCATION_SPELLS values(a_id, a_name, a_type);
    end loop;
end;
/

select * from evocation_spells;
delete from evocation_spells;

--------------------------------------------------------------------------------
--functions (1)
--------------------------------------------------------------------------------
--create a function that outputs if a class uses spells or not
create or replace function martial_class(classer NUMBER)
return VARCHAR2
is
spellmelee VARCHAR2(10);
notaclass EXCEPTION;
begin
    if classer = 1 or classer = 5 or classer = 6 or classer = 9 then 
        spellmelee := 'melee';
    elsif classer = 2 or classer = 3 or classer = 4 or classer = 7 or
    classer = 8 or classer = 10 or classer = 11 or classer = 12 then
        spellmelee := 'spell';
    else
        raise notaclass;
    end if;
return (spellmelee);
    exception
    when notaclass then
    raise_application_error (-20001, 'Not a class');

end;
/
select * from spells;
select * from class_spells;
select * from players;
select * from monsters;
select * from classes;
select class_id, class_name, martial_class(class_id) from classes;
--------------------------------------------------------------------------------
--functions (2)
--------------------------------------------------------------------------------
--create a function that pulls the school a spell belongs to from the spell table
create or replace function school(id IN number)
return VARCHAR2
is
school_id NUMBER;
schoollevel NUMBER;
schooltype VARCHAR2(128);
begin
    select SPELL_LEVEL into schoollevel from spells where spell_id = id;
    if(schoollevel != 0) then 
        select substr(spell_type, 11) into schooltype 
        from spells where spell_id = id;
    else
        select nvl(substr(spell_type, 0, instr(spell_type, ' ')-1), spell_type)
        into schooltype
        from spells where spell_id = id;
    end if;
return (schooltype);

end;
/
select * from spells;
select spell_id, spell_name, school(spell_id) from spells;
--------------------------------------------------------------------------------
--stored procedures (1)
--------------------------------------------------------------------------------
--use a procedure to fill a table of all spells a specific class can use
select * from class_spells;
DROP TABLE SPECIFIC_CLASS;
CREATE TABLE SPECIFIC_CLASS
(CLASS_ID NUMBER(10),
CLASS_NAME VARCHAR2(9),
SPELL_ID NUMBER(10),
SPELL_NAME VARCHAR2(128),
SPELL_TYPE VARCHAR2(128));

delete from SPECIFIC_CLASS;

create or replace
procedure specific_class_spells(classer number)
as
begin
        insert into specific_class (class_id, class_name, spell_id, spell_name, spell_type)
        select c.class_id, c.class_name, s.spell_id, s.spell_name, school(s.spell_id) from classes c
        join class_spells cs on c.class_id = cs.class_id
        join spells s
        on s.spell_id = cs.spell_id where c.class_id = classer;
end;
/


select * from classes;
select * from spells;
select * from players;
select * from specific_class;
delete from specific_class;
execute specific_class_spells(4);
--------------------------------------------------------------------------------
--stored procedures (2)
--------------------------------------------------------------------------------
--use a procedure to update the player table when a player levels up
create or replace
procedure level_up(player number, chosenstat varchar2)
as
invalidstat exception;
begin
        if chosenstat = 'STRENGTH' then
            update players
            set strength = strength + 1,
            max_hp = max_hp + 1
            where player_id = player;
        elsif chosenstat = 'DEXTERITY' then
            update players
            set dexterity = dexterity + 1,
            max_hp = max_hp + 1
            where player_id = player;
        elsif chosenstat = 'CONSTITUTION' then
            update players
            set constitution = constitution + 1,
            max_hp = max_hp + 1
            where player_id = player;
        elsif chosenstat = 'INTELLIGENCE' then
            update players
            set intelligence = intelligence + 1,
            max_hp = max_hp + 1
            where player_id = player;
        elsif chosenstat = 'WISDOM' then
            update players
            set wisdom = wisdom + 1,
            max_hp = max_hp + 1
            where player_id = player;
        elsif chosenstat = 'CHARISMA' then
            update players
            set charisma = charisma + 1,
            max_hp = max_hp + 1
            where player_id = player;
        else
            raise invalidstat;
        end if;
        exception
            when invalidstat then
            raise_application_error (-20001, 'Invalid stat');
        
end;
/
select * from players;
execute level_up(1, 'CONSTITUTION');
execute level_up(1, ' ');
--------------------------------------------------------------------------------
--package (1)
--------------------------------------------------------------------------------
--create a package that uses the previous school function and specific_class_spells procedure
create or replace package CLASS_BASED
as
    function school(id IN number) return VARCHAR2;
    procedure specific_class_spells(classer number);
end class_based;
/

create or replace package body CLASS_BASED
as


function school(id IN number)
return VARCHAR2
is
school_id NUMBER;
schoollevel NUMBER;
schooltype VARCHAR2(128);
begin
    select SPELL_LEVEL into schoollevel from spells where spell_id = id;
    if(schoollevel != 0) then 
        select substr(spell_type, 11) into schooltype 
        from spells where spell_id = id;
    else
        select nvl(substr(spell_type, 0, instr(spell_type, ' ')-1), spell_type)
        into schooltype
        from spells where spell_id = id;
    end if;
return (schooltype);

end school;


procedure specific_class_spells(classer number)
as
begin
        insert into specific_class (class_id, class_name, spell_id, spell_name, spell_type)
        select c.class_id, c.class_name, s.spell_id, s.spell_name, school(s.spell_id) from classes c
        join class_spells cs on c.class_id = cs.class_id
        join spells s
        on s.spell_id = cs.spell_id where c.class_id = classer;
end specific_class_spells;

end CLASS_BASED;
/

select spell_id, spell_name, class_based.school(spell_id) from spells;

--------------------------------------------------------------------------------
--object (1)
--------------------------------------------------------------------------------
--create an object type to represent the class table when stored in a copy of the player table

drop type CLASS_TY;
create or replace type CLASS_TY as object
(CLASS_ID NUMBER(10),
CLASS_NAME VARCHAR2(9));
/

DROP TABLE PLAYER_CLASS;
CREATE TABLE PLAYER_CLASS
(PLAYER_ID NUMBER(10),
PLAYER_NAME VARCHAR2(30),
CLASSES CLASS_TY,
RACE VARCHAR2(10),
STRENGTH NUMBER(10),
DEXTERITY NUMBER(10),
CONSTITUTION NUMBER(10),
INTELLIGENCE NUMBER(10),
WISDOM NUMBER(10),
CHARISMA NUMBER(10),
INITIATIVE NUMBER(10),
MAX_HP NUMBER(10),
ARMOR_CLASS NUMBER(10),
PASSIVE_PERCEPTION NUMBER(10),
DATE_CREATED DATE,
CONSTRAINT PLAYERCLASS_ID_PK PRIMARY KEY (PLAYER_ID));

create or replace function class_find(id in number)
return class_ty
is
classer number;
classer_name VARCHAR2(9);
begin
    select class_id, class_name into classer, classer_name from classes
    where class_id = id;
return (class_ty(classer, classer_name));

end;
/

insert into player_class (player_id, player_name, classes, race, strength,
dexterity, constitution, intelligence, wisdom, charisma, initiative, max_hp, armor_class,
passive_perception, date_created) select player_id, player_name, class_find(class_id), race,
strength, dexterity, constitution, intelligence, wisdom, charisma, initiative, max_hp, armor_class,
passive_perception, date_created from players;

select * from player_class;


--------------------------------------------------------------------------------
--triggers for keeping track of different types of activies, one for insertion, 
--one for deletion (1)
--------------------------------------------------------------------------------
--this trigger inserts a copy of the updated row in the player table whenever the
--player table is updated into the altered_players table
create table altered_players as select * from players;
alter table altered_players add new_strength number(10);
alter table altered_players add new_dexterity number(10);
alter table altered_players add new_constitution number(10);
alter table altered_players add new_intelligence number(10);
alter table altered_players add new_wisdom number(10);
alter table altered_players add new_charisma number(10);
alter table altered_players add new_max_hp number(10);
alter table altered_players add alter_date date;
alter table altered_players rename column strength to old_strength;
alter table altered_players rename column dexterity to old_dexterity;
alter table altered_players rename column constitution to old_constitution;
alter table altered_players rename column intelligence to old_intelligence;
alter table altered_players rename column wisdom to old_wisdom;
alter table altered_players rename column charisma to old_charisma;
alter table altered_players rename column max_hp to old_max_hp;

select * from players;
select * from altered_players;
delete from altered_players;

create or replace trigger player_upd_row
before update on players
for each row
when (new.max_hp > old.max_hp)
begin
insert into altered_players(player_id, player_name, class_id, race, old_strength, old_dexterity,
old_constitution, old_intelligence, old_wisdom, old_charisma, initiative, old_max_hp, armor_class,
passive_perception, date_created, new_strength, new_dexterity, new_constitution, new_intelligence,
new_wisdom, new_charisma, new_max_hp, alter_date)
values(:old.player_id, :old.player_name, :old.class_id, :old.race, :old.strength, :old.dexterity,
:old.constitution, :old.intelligence, :old.wisdom, :old.charisma, :old.initiative, :old.max_hp, :old.armor_class,
:old.passive_perception, :old.date_created, :new.strength, :new.dexterity, :new.constitution, :new.intelligence,
:new.wisdom, :new.charisma, :new.max_hp, sysdate);
end;
/

execute level_up(1, 'CONSTITUTION');
select * from altered_players;
--------------------------------------------------------------------------------
--triggers for keeping track of different types of activies, one for insertion, 
--one for deletion (2)
--------------------------------------------------------------------------------
--this trigger stores the deleted row from the players table when a player is deleted
--in the deleted players table
create table deleted_players as select * from players;
alter table deleted_players add delete_date date;
delete from deleted_players;
Create or replace trigger PLAYER_DELETED
before delete on PLAYERS
for each row
begin
Insert into PLAYER_DELETED(player_id, player_name, class_id, race, Strength, dexterity,
constitution, intelligence, wisdom, charisma, initiative, max_hp, armor_class,
passive_perception, date_created, delete_date)
values(:old.player_id, :old.player_name, :old.class_id, :old.race, :old.strength, :old.dexterity,
:old.constitution, :old.intelligence, :old.wisdom, :old.charisma, :old.initiative, :old.max_hp, :old.armor_class,
:old.passive_perception, :old.date_created, sysdate);
end;
/
delete from players;
select * from deleted_players;

-----------------------------FINAL----------------------------------------------
set echo on;
set serveroutput on;
set serveroutput on format wrapped;
begin
    DBMS_OUTPUT.put_line('simple comment');
end;
/
--------------------------------------------------------------------------------
--1 
--code blocks with variables and loops to process data (likely using insert)
--------------------------------------------------------------------------------
--create and fill a table using a code block of all spells of school evocation
DROP TABLE EVOCATION_SPELLS;
CREATE TABLE EVOCATION_SPELLS
(SPELL_ID NUMBER(10),
SPELL_NAME VARCHAR2(128),
SPELL_TYPE VARCHAR2(128),
CONSTRAINT EVOCATION_SPELL_ID_PK PRIMARY KEY (SPELL_ID) );

delete from EVOCATION_SPELLS;

declare
	a_id NUMBER(10);
	a_name VARCHAR2(128);
    a_type VARCHAR2(128);
	counter NUMBER:=0;
begin
    select count(*) into counter from SPELLS;
    FOR i IN (SELECT SPELL_ID, SPELL_NAME, SPELL_TYPE FROM SPELLS WHERE SPELL_TYPE
    LIKE '%evocation')
    loop
    a_id := i.SPELL_ID;
    a_name := i.SPELL_NAME;
    a_type := i.SPELL_TYPE;
    INSERT INTO EVOCATION_SPELLS values(a_id, a_name, a_type);
    end loop;
end;
/

select * from evocation_spells;
--------------------------------------------------------------------------------
--2
--code blocks to retrieve records from tables in database using cursors
--------------------------------------------------------------------------------
--use a cursor to achieve the same thing in the previous code block
declare
	a_id NUMBER(10);
	a_name VARCHAR2(128);
    a_type VARCHAR2(128);
	counter NUMBER:=0;
	cursor evo_cursor is
		select SPELL_ID, SPELL_NAME, SPELL_TYPE from SPELLS WHERE SPELL_TYPE LIKE '%evocation';
	evo_val evo_cursor%ROWTYPE; --create an array with one row, where each field uses the table column data type
	evo_val_type evo_val.SPELL_TYPE%TYPE;
begin
    for i in evo_cursor
    loop
        a_id := i.spell_id;
        a_name := i.spell_name;
        a_type := i.spell_type;
        insert into EVOCATION_SPELLS values(a_id, a_name, a_type);
    end loop;
end;
/

select * from evocation_spells;
delete from evocation_spells;

--------------------------------------------------------------------------------
--5
--functions (1)
--------------------------------------------------------------------------------
--create a function that outputs if a class uses spells or not
--note: includes exception handling for if the inputed class_id is not found in
--the table
create or replace function martial_class(classer NUMBER)
return VARCHAR2
is
spellmelee VARCHAR2(10);
notaclass EXCEPTION;
begin
    if classer = 1 or classer = 5 or classer = 6 or classer = 9 then 
        spellmelee := 'melee';
    elsif classer = 2 or classer = 3 or classer = 4 or classer = 7 or
    classer = 8 or classer = 10 or classer = 11 or classer = 12 then
        spellmelee := 'spell';
    else
        raise notaclass;
    end if;
return (spellmelee);
    exception
    when notaclass then
    raise_application_error (-20001, 'Not a class');

end;
/
select * from spells;
select * from class_spells;
select * from players;
select * from monsters;
select * from classes;
select class_id, class_name, martial_class(class_id) from classes;
--------------------------------------------------------------------------------
--5
--functions (2)
--------------------------------------------------------------------------------
--create a function that pulls the school a spell belongs to from the spell table
create or replace function school(id IN number)
return VARCHAR2
is
school_id NUMBER;
schoollevel NUMBER;
schooltype VARCHAR2(128);
begin
    select SPELL_LEVEL into schoollevel from spells where spell_id = id;
    if(schoollevel != 0) then 
        select substr(spell_type, 11) into schooltype 
        from spells where spell_id = id;
    else
        select nvl(substr(spell_type, 0, instr(spell_type, ' ')-1), spell_type)
        into schooltype
        from spells where spell_id = id;
    end if;
return (schooltype);

end;
/
select * from spells;
select spell_id, spell_name, school(spell_id) from spells;
--------------------------------------------------------------------------------
--6
--stored procedures (1)
--------------------------------------------------------------------------------
--use a procedure to fill a table of all spells a specific class can use
select * from class_spells;
DROP TABLE SPECIFIC_CLASS;
CREATE TABLE SPECIFIC_CLASS
(CLASS_ID NUMBER(10),
CLASS_NAME VARCHAR2(9),
SPELL_ID NUMBER(10),
SPELL_NAME VARCHAR2(128),
SPELL_TYPE VARCHAR2(128));

delete from SPECIFIC_CLASS;

create or replace
procedure specific_class_spells(classer number)
as
begin
        insert into specific_class (class_id, class_name, spell_id, spell_name, spell_type)
        select c.class_id, c.class_name, s.spell_id, s.spell_name, school(s.spell_id) from classes c
        join class_spells cs on c.class_id = cs.class_id
        join spells s
        on s.spell_id = cs.spell_id where c.class_id = classer;
end;
/


select * from classes;
select * from spells;
select * from players;
select * from specific_class;
delete from specific_class;
execute specific_class_spells(4);
--------------------------------------------------------------------------------
--6
--stored procedures (2)
--------------------------------------------------------------------------------
--use a procedure to update the player table when a player levels up
--note: includes exception handling for if an invalid string is inserted
create or replace
procedure level_up(player number, chosenstat varchar2)
as
invalidstat exception;
begin
        if chosenstat = 'STRENGTH' then
            update players
            set strength = strength + 1,
            max_hp = max_hp + 1
            where player_id = player;
        elsif chosenstat = 'DEXTERITY' then
            update players
            set dexterity = dexterity + 1,
            max_hp = max_hp + 1
            where player_id = player;
        elsif chosenstat = 'CONSTITUTION' then
            update players
            set constitution = constitution + 1,
            max_hp = max_hp + 1
            where player_id = player;
        elsif chosenstat = 'INTELLIGENCE' then
            update players
            set intelligence = intelligence + 1,
            max_hp = max_hp + 1
            where player_id = player;
        elsif chosenstat = 'WISDOM' then
            update players
            set wisdom = wisdom + 1,
            max_hp = max_hp + 1
            where player_id = player;
        elsif chosenstat = 'CHARISMA' then
            update players
            set charisma = charisma + 1,
            max_hp = max_hp + 1
            where player_id = player;
        else
            raise invalidstat;
        end if;
        exception
            when invalidstat then
            raise_application_error (-20001, 'Invalid stat');
        
end;
/
select * from players;
execute level_up(1, 'CONSTITUTION');
execute level_up(1, ' ');
--------------------------------------------------------------------------------
--7
--package (1)
--------------------------------------------------------------------------------
--create a package that uses the previous school function and specific_class_spells procedure
create or replace package CLASS_BASED
as
    function school(id IN number) return VARCHAR2;
    procedure specific_class_spells(classer number);
end class_based;
/

create or replace package body CLASS_BASED
as


function school(id IN number)
return VARCHAR2
is
school_id NUMBER;
schoollevel NUMBER;
schooltype VARCHAR2(128);
begin
    select SPELL_LEVEL into schoollevel from spells where spell_id = id;
    if(schoollevel != 0) then 
        select substr(spell_type, 11) into schooltype 
        from spells where spell_id = id;
    else
        select nvl(substr(spell_type, 0, instr(spell_type, ' ')-1), spell_type)
        into schooltype
        from spells where spell_id = id;
    end if;
return (schooltype);

end school;


procedure specific_class_spells(classer number)
as
begin
        insert into specific_class (class_id, class_name, spell_id, spell_name, spell_type)
        select c.class_id, c.class_name, s.spell_id, s.spell_name, school(s.spell_id) from classes c
        join class_spells cs on c.class_id = cs.class_id
        join spells s
        on s.spell_id = cs.spell_id where c.class_id = classer;
end specific_class_spells;

end CLASS_BASED;
/

select spell_id, spell_name, class_based.school(spell_id) from spells;

--------------------------------------------------------------------------------
--8
--object (1)
--------------------------------------------------------------------------------
--create an object type to represent the class table when stored in a copy of the player table

select * from players;
select * from classes;

drop type CLASS_TY;
create or replace type CLASS_TY as object
(CLASS_ID NUMBER(10),
CLASS_NAME VARCHAR2(9));
/

DROP TABLE PLAYER_CLASS;
CREATE TABLE PLAYER_CLASS
(PLAYER_ID NUMBER(10),
PLAYER_NAME VARCHAR2(30),
CLASSES CLASS_TY,
RACE VARCHAR2(10),
STRENGTH NUMBER(10),
DEXTERITY NUMBER(10),
CONSTITUTION NUMBER(10),
INTELLIGENCE NUMBER(10),
WISDOM NUMBER(10),
CHARISMA NUMBER(10),
INITIATIVE NUMBER(10),
MAX_HP NUMBER(10),
ARMOR_CLASS NUMBER(10),
PASSIVE_PERCEPTION NUMBER(10),
DATE_CREATED DATE,
CONSTRAINT PLAYERCLASS_ID_PK PRIMARY KEY (PLAYER_ID));

create or replace function class_find(id in number)
return class_ty
is
classer number;
classer_name VARCHAR2(9);
begin
    select class_id, class_name into classer, classer_name from classes
    where class_id = id;
return (class_ty(classer, classer_name));

end;
/

insert into player_class (player_id, player_name, classes, race, strength,
dexterity, constitution, intelligence, wisdom, charisma, initiative, max_hp, armor_class,
passive_perception, date_created) select player_id, player_name, class_find(class_id), race,
strength, dexterity, constitution, intelligence, wisdom, charisma, initiative, max_hp, armor_class,
passive_perception, date_created from players;

select * from player_class;


--------------------------------------------------------------------------------
--4
--triggers for keeping track of different types of activies, one for insertion, 
--one for deletion (1)
--------------------------------------------------------------------------------
--this trigger inserts a copy of the updated row in the player table whenever the
--player table is updated into the altered_players table
create table altered_players as select * from players;
alter table altered_players add new_strength number(10);
alter table altered_players add new_dexterity number(10);
alter table altered_players add new_constitution number(10);
alter table altered_players add new_intelligence number(10);
alter table altered_players add new_wisdom number(10);
alter table altered_players add new_charisma number(10);
alter table altered_players add new_max_hp number(10);
alter table altered_players add alter_date date;
alter table altered_players rename column strength to old_strength;
alter table altered_players rename column dexterity to old_dexterity;
alter table altered_players rename column constitution to old_constitution;
alter table altered_players rename column intelligence to old_intelligence;
alter table altered_players rename column wisdom to old_wisdom;
alter table altered_players rename column charisma to old_charisma;
alter table altered_players rename column max_hp to old_max_hp;

select * from players;
select * from altered_players;
delete from altered_players;

create or replace trigger player_upd_row
before update on players
for each row
when (new.max_hp > old.max_hp)
begin
insert into altered_players(player_id, player_name, class_id, race, old_strength, old_dexterity,
old_constitution, old_intelligence, old_wisdom, old_charisma, initiative, old_max_hp, armor_class,
passive_perception, date_created, new_strength, new_dexterity, new_constitution, new_intelligence,
new_wisdom, new_charisma, new_max_hp, alter_date)
values(:old.player_id, :old.player_name, :old.class_id, :old.race, :old.strength, :old.dexterity,
:old.constitution, :old.intelligence, :old.wisdom, :old.charisma, :old.initiative, :old.max_hp, :old.armor_class,
:old.passive_perception, :old.date_created, :new.strength, :new.dexterity, :new.constitution, :new.intelligence,
:new.wisdom, :new.charisma, :new.max_hp, sysdate);
end;
/

execute level_up(1, 'CONSTITUTION');
select * from altered_players;
--------------------------------------------------------------------------------
--4
--triggers for keeping track of different types of activies, one for insertion, 
--one for deletion (2)
--------------------------------------------------------------------------------
--this trigger stores the deleted row from the players table when a player is deleted
--in the deleted_players table
select * from monsters;
select * from players;
create table deleted_players as select * from players;
alter table deleted_players add delete_date date;
delete from deleted_players;
Create or replace trigger PLAYER_DELETED
before delete on PLAYERS
for each row
begin
Insert into DELETED_PLAYERS(player_id, player_name, class_id, race, Strength, dexterity,
constitution, intelligence, wisdom, charisma, initiative, max_hp, armor_class,
passive_perception, date_created, delete_date)
values(:old.player_id, :old.player_name, :old.class_id, :old.race, :old.strength, :old.dexterity,
:old.constitution, :old.intelligence, :old.wisdom, :old.charisma, :old.initiative, :old.max_hp, :old.armor_class,
:old.passive_perception, :old.date_created, sysdate);
end;
/
delete from players;
select * from deleted_players;
