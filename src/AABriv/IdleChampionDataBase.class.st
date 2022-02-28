Class {
	#name : #IdleChampionDataBase,
	#superclass : #Object,
	#instVars : [
		'attacks',
		'monsters',
		'quests',
		'backgrounds',
		'stories',
		'campaigns',
		'distractions',
		'chestsTypes'
	],
	#classInstVars : [
		'CachedDatabase'
	],
	#category : #'AABriv-database'
}

{ #category : #'as yet unclassified' }
IdleChampionDataBase class >> cachedDatabase [
	^ CachedDatabase ifNil: [ CachedDatabase := self new ]
]

{ #category : #'as yet unclassified' }
IdleChampionDataBase class >> reset [
	CachedDatabase := nil
]

{ #category : #api }
IdleChampionDataBase >> adventuresForChampion: aString [ 
	^ self allAdventures select: [ :anAdventure | (anAdventure name findString: aString) > 0 ] 
]

{ #category : #query }
IdleChampionDataBase >> allAdventures [
	^ campaigns flatCollect: [ :c | c adventures ]
]

{ #category : #query }
IdleChampionDataBase >> allAdventuresQuickTransitionSizeFor: aNumberOfBrivJump [
	| quickTransitionsAdventures |
	quickTransitionsAdventures := self allQuickTransitionsAdventuresFor: aNumberOfBrivJump.
	^ quickTransitionsAdventures collect:[:a | a key -> (a value key round: 2) ]
]

{ #category : #query }
IdleChampionDataBase >> allQuickTransitionsAdventuresFor: aNumberOfBrivJump [
	| quickTransitionsAdventures |
	quickTransitionsAdventures := self allAdventures collect: [ :a| a -> (a quickTransitionsFor: aNumberOfBrivJump) ].
	quickTransitionsAdventures := quickTransitionsAdventures reject: [ :a| a value key = 0 ].
	^ quickTransitionsAdventures sort:[ :a1 :a2 | a1 value key > a2 value key ].
]

{ #category : #'accessing-id' }
IdleChampionDataBase >> attackWithId: anID [
	"Only for some kinds of entities
	So far, particular bosses and spawners?"
	anID = 0 ifTrue: [ ^ Attack new ].
	anID ifNil: [ ^ Attack new ].
	^ attacks at: anID
	
]

{ #category : #accessing }
IdleChampionDataBase >> attacks [

	^ attacks
]

{ #category : #'accessing-id' }
IdleChampionDataBase >> backgroundWithId: anID [

	^ backgrounds detect: [ :a | a id = anID ]
]

{ #category : #accessing }
IdleChampionDataBase >> backgrounds [

	^ backgrounds
]

{ #category : #'accessing-id' }
IdleChampionDataBase >> campaignWithID: anID [
	^ campaigns detect: [ :a | a id = anID ]
]

{ #category : #accessing }
IdleChampionDataBase >> campaigns [

	^ campaigns
]

{ #category : #'accessing-id' }
IdleChampionDataBase >> distractionForId: anID [
	^ distractions detect: [ :d | d id = anID ]
]

{ #category : #filling }
IdleChampionDataBase >> fillAttacksFrom: attackJSONS [
	attacks ifNil: [ attacks := Dictionary new ].
	
	((attackJSONS at: #data) at: #attacks) do: [ :anAttackJSON | | attack |
		attack := Attack new
			json: anAttackJSON;
			graphicId: (anAttackJSON at: #graphic_id);
			description: (anAttackJSON at: #description);
			name: (anAttackJSON at: #name);
			aoeRadius: (anAttackJSON at: #aoe_radius); 
			id: (anAttackJSON at: #id);
			longDescription: (anAttackJSON at: #long_description); 
			target: (anAttackJSON at: #target);
			numTargets: (anAttackJSON at: #num_targets);
			tags: (anAttackJSON at: #tags);
			damageModifier: (anAttackJSON at: #damage_modifier);
			cooldown: (anAttackJSON at: #cooldown); 
			damageTypes: (anAttackJSON at: #damage_types);
			yourself.
		attacks at: (anAttackJSON at: #id) put: attack.
		]
]

{ #category : #filling }
IdleChampionDataBase >> fillBackgrounds [
	| backgroundsJSON |
	backgroundsJSON := KlehoQueries getBackgrounds.
	backgrounds := ((backgroundsJSON at: #data) at: #bgs) collect: [ :aBackgroundJSON | 
		Background new
			json: aBackgroundJSON;
			midGraphicId: (aBackgroundJSON at: #mid_graphic_id);
			distractionsIds: (aBackgroundJSON at: #distractions);
			farGraphicID: (aBackgroundJSON at: #far_graphic_id);
			foreGraphicId: (aBackgroundJSON at: #fore_graphic_id);
			nearGraphicId: (aBackgroundJSON at: #near_graphic_id);
			id: (aBackgroundJSON at: #id);
			distractionsCnt: (aBackgroundJSON at: #distractions_cnt);
			properties: (aBackgroundJSON at: #properties);
			yourself ]
]

{ #category : #filling }
IdleChampionDataBase >> fillCampaigns [
	| campaignsJSON |
	campaignsJSON := (KlehoQueries getCampaigns at: #data) at: #campaigns.
	^campaigns := campaignsJSON collect:[ :aCampaignJSON | | campaign |
		campaign := Campaign new
			json: aCampaignJSON;
			id: (aCampaignJSON at: #id);
			description: (aCampaignJSON at: #name);
			name: (aCampaignJSON at: #short_name);
			type: (aCampaignJSON at: #type);
			yourself.
		campaign fillAdventures.
		campaign
		].
]

{ #category : #filling }
IdleChampionDataBase >> fillChests [
	| chestsJSON |
	chestsJSON := self getChestJSON.
	chestsTypes := chestsJSON collect: [ :aChestJSON | 
		IdleChampionChest new
			json: aChestJSON;
			name: (aChestJSON at: #name);
			namePlural: (aChestJSON at: #name_plural);
			id: (aChestJSON at: #id);
			details: (aChestJSON at: #details);
			yourself ]
]

{ #category : #initialization }
IdleChampionDataBase >> fillCommonInformations [
	self fillMonsters.
	self fillQuests.
	self fillBackgrounds.
	self fillDistractions.
	self fillChests
]

{ #category : #filling }
IdleChampionDataBase >> fillDistractions [
	| distractionsJSON |
	distractionsJSON := KlehoQueries getDistractions.
	distractions := ((distractionsJSON at: #data) at: #distractions) collect: [ :aDistractionJSON | 
		Distraction new
			json: aDistractionJSON;
			type: (aDistractionJSON at: #type);
			rewards: (aDistractionJSON at: #rewards);
			name: (aDistractionJSON at: #name);
			graphicID: (aDistractionJSON at: #graphic_id);
			id: (aDistractionJSON at: #id);
			properties: (aDistractionJSON at: #properties);
			yourself ]
]

{ #category : #filling }
IdleChampionDataBase >> fillMonsters [
	| monstersJSON |
	monstersJSON := KlehoQueries getMonsters.
	monsters := monstersJSON flatCollect: [ :aDictionary |
		self fillAttacksFrom: aDictionary.
		((aDictionary at: #data) at: #monsters) collect: [ :aMonsterJSON | 
			Monster new
				json: aMonsterJSON;
				damageModifier: (aMonsterJSON at: #damage_modifier);
				graphicId: (aMonsterJSON at: #graphic_id);
				name:(aMonsterJSON at: #name);
				id: (aMonsterJSON at: #id);
				properties: (aMonsterJSON at: #properties);
				type: (aMonsterJSON at: #type);
				tags: (aMonsterJSON at: #tags);
				attackId: (aMonsterJSON at: #attack_id);
				healthModifier: (aMonsterJSON at: #health_modifier);
				scale: (aMonsterJSON at: #scale);
				yourself
			]
		]
]

{ #category : #filling }
IdleChampionDataBase >> fillQuests [
	| questsJSONs |
	questsJSONs := KlehoQueries getQuests.
	quests := questsJSONs flatCollect: [ :aDictionary |
		((aDictionary at: #data) at: #quests) collect: [ :aQuestJSON | 
			Quest new
				json: aQuestJSON;
				description: (aQuestJSON at: #description);
				type: (aQuestJSON at: #type);
				properties: (aQuestJSON at: #properties);
				goalGraphicId: (aQuestJSON at: #goal_graphic_id);
				goalAmount: (aQuestJSON at: #goal_amount);
				goalDescription: (aQuestJSON at: #goal_description);
				id: (aQuestJSON at: #id);
				yourself ]]
]

{ #category : #query }
IdleChampionDataBase >> findAdventureNamed: aName [
	| adv |
	campaigns do: [ :c | 
		adv := c findAdventureNamed: aName.
		adv ifNotNil: [ ^ adv ] ].
	^ nil
]

{ #category : #'fill-ressources' }
IdleChampionDataBase >> getChestJSON [
	 ^ ((IceRepository registeredRepositoryIncludingPackage: self class package) repositoryDirectory asFileReference /  'ressources' /'chestTypes.json' )
			ifExists: [ :f | STON fromString: f readStream contents ]
			ifAbsent: [ Warning signal: 'ChestTypes files should exists. Please file a bug report ' ]
	
]

{ #category : #query }
IdleChampionDataBase >> highestBushForEachAdventure [
	^ (self allAdventures 
		collect: [ :adventure | adventure -> adventure highestKrullBush ] 
		thenSelect: [ :association | association value > 0 ])
		sort: [ :v1 :v2 | v1 value > v2 value ].
]

{ #category : #query }
IdleChampionDataBase >> highestBushForEachAdventurePerCampaigns [
	^ self highestBushForEachAdventure groupedBy: [ :association | association key campaign ] .
]

{ #category : #query }
IdleChampionDataBase >> highestKrullBushForEachAdventure [
	^ (self allAdventures 
		collect: [ :adventure | adventure -> adventure highestKrullBush ] 
		thenSelect: [ :association | association value isNotNil ])
		sort: [ :v1 :v2 | v1 value areaId > v2 value areaId ].
]

{ #category : #query }
IdleChampionDataBase >> highestKrullBushForEachAdventurePerCampaigns [
	^ self highestKrullBushForEachAdventure groupedBy: [ :association | association key campaign ] .
]

{ #category : #initialization }
IdleChampionDataBase >> initialize [
	self fillCommonInformations.
	self fillCampaigns.
	self resolveLinks
]

{ #category : #'accessing-id' }
IdleChampionDataBase >> monsterWithId: anID [

	^ monsters detect: [ :a | a id = anID ]
]

{ #category : #accessing }
IdleChampionDataBase >> monsters [

	^ monsters
]

{ #category : #'accessing-id' }
IdleChampionDataBase >> questWithId: anID [

	^ 	quests detect: [ :a | a id = anID ]
]

{ #category : #accessing }
IdleChampionDataBase >> quests [

	^ quests
]

{ #category : #initialization }
IdleChampionDataBase >> resolveLinks [
	attacks do: [ :a | a resolveLinksWith: self ].
	monsters do: [ :m | m resolveLinksWith: self ].
	quests do: [ :q | q resolveLinksWith: self ].
	backgrounds do: [ :b | b resolveLinksWith: self ].
	"stories do: [ :s | s resolveLinksWith: self ]."
	campaigns do: [ :c | c resolveLinksWith: self ].
]

{ #category : #accessing }
IdleChampionDataBase >> stories [

	^ stories
]

{ #category : #'accessing-id' }
IdleChampionDataBase >> storyWithId: anID [
	self halt. "check that the stories are indeed filled before using this method."
	^ stories detect: [ :a | a id = anID ] ifNone: [ nil ]
]
