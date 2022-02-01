Class {
	#name : #IdleChampionDataBase,
	#superclass : #Object,
	#instVars : [
		'attacks',
		'monsters',
		'quests',
		'backgrounds',
		'stories',
		'campaigns'
	],
	#category : #'AABriv-database'
}

{ #category : #'accessing-id' }
IdleChampionDataBase >> attackWithId: anID [

	^ attacks detect: [ :a | a id = anID ] ifNone: [ nil ]
]

{ #category : #accessing }
IdleChampionDataBase >> attacks [

	^ attacks
]

{ #category : #'accessing-id' }
IdleChampionDataBase >> backgroundWithId: anID [

	^ backgrounds detect: [ :a | a id = anID ] ifNone: [ nil ]
]

{ #category : #accessing }
IdleChampionDataBase >> backgrounds [

	^ backgrounds
]

{ #category : #'accessing-id' }
IdleChampionDataBase >> campaignWithID: anID [
	^ campaigns detect: [ :a | a id = anID ] ifNone: [ nil ]
]

{ #category : #accessing }
IdleChampionDataBase >> campaigns [

	^ campaigns
]

{ #category : #initialization }
IdleChampionDataBase >> fillAreasInformations [
	self fillMonsters.
	self fillQuests.
	self fillBackgrounds.
]

{ #category : #initialization }
IdleChampionDataBase >> fillAttacksFrom: attackJSONS [
	attacks ifNil: [ attacks := Dictionary new ].
	
	((attackJSONS at: #data) at: #attacks) do: [ :anAttackJSON | | attack |
		attack := Attack new
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

{ #category : #initialization }
IdleChampionDataBase >> fillBackgrounds [
	| backgroundsJSON |
	backgroundsJSON := KlehoQueries getBackgrounds.
	backgrounds := ((backgroundsJSON at: #data) at: #bgs) collect: [ :aBackgroundJSON | 
		Background new
			midGraphicId: (aBackgroundJSON at: #mid_graphic_id);
			distractions: (aBackgroundJSON at: #distractions);
			farGraphicID: (aBackgroundJSON at: #far_graphic_id);
			foreGraphicId: (aBackgroundJSON at: #fore_graphic_id);
			nearGraphicId: (aBackgroundJSON at: #near_graphic_id);
			id: (aBackgroundJSON at: #id);
			distractionsCnt: (aBackgroundJSON at: #distractions_cnt);
			properties: (aBackgroundJSON at: #properties);
			yourself ]
]

{ #category : #initialization }
IdleChampionDataBase >> fillBackgroundsFrom: backgroundJSONs [
	backgrounds := backgroundJSONs values collect: [ :aBackgroundJSON |
		Background new
			midGraphicId: (aBackgroundJSON at: #mid_graphic_id);
			distractions: (aBackgroundJSON at: #distractions);
			farGraphicID: (aBackgroundJSON at: #far_graphic_id);
			foreGraphicId: (aBackgroundJSON at: #fore_graphic_id);
			nearGraphicId: (aBackgroundJSON at: #near_graphic_id);
			id: (aBackgroundJSON at: #id);
			distractionsCnt: (aBackgroundJSON at: #distractions_cnt);
			properties: (aBackgroundJSON at: #properties);
			yourself

			]
]

{ #category : #initialization }
IdleChampionDataBase >> fillCampaigns [
	| campaignsJSON |
	campaignsJSON := (KlehoQueries getCampaignsJSON at: #data) at: #campaigns.
	^campaigns := campaignsJSON collect:[ :aCampaignDirectory | | campaign |
		campaign := Campaign new
			id: (aCampaignDirectory at: #id);
			description: (aCampaignDirectory at: #name);
			name: (aCampaignDirectory at: #short_name);
			type: (aCampaignDirectory at: #type);
			yourself.
		campaign fillAdventures.
		campaign
		].
]

{ #category : #initialization }
IdleChampionDataBase >> fillCampaignsFrom: adventureCampaignJSON [
	^ campaigns := adventureCampaignJSON collect:[ :aCampaignDirectory | | campaign |
		campaign := Campaign new
			id: (aCampaignDirectory at: #id);
			description: (aCampaignDirectory at: #name);
			name: (aCampaignDirectory at: #short_name);
			type: (aCampaignDirectory at: #type);
			yourself.
		campaign fillAdventures.
		campaign
		].
]

{ #category : #initialization }
IdleChampionDataBase >> fillMonsters [
	| monstersJSON |
	monstersJSON := KlehoQueries getMonsters.
	monsters := monstersJSON flatCollect: [ :aDictionary |
		self fillAttacksFrom: aDictionary.
		((aDictionary at: #data) at: #monsters) collect: [ :aMonsterJSON | 
			Monster new
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

{ #category : #initialization }
IdleChampionDataBase >> fillMonstersFrom: monstersJSON [
	monsters := monstersJSON values collect: [ :aMonsterJSON |
		Monster new
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

{ #category : #initialization }
IdleChampionDataBase >> fillQuests [
	| questsJSONs |
	questsJSONs := KlehoQueries getQuests.
	quests := questsJSONs flatCollect: [ :aDictionary |
		((aDictionary at: #data) at: #quests) collect: [ :aQuestJSON | 
			Quest new
				description: (aQuestJSON at: #description);
				type: (aQuestJSON at: #type);
				properties: (aQuestJSON at: #properties);
				goalGraphicId: (aQuestJSON at: #goal_graphic_id);
				goalAmount: (aQuestJSON at: #goal_amount);
				goalDescription: (aQuestJSON at: #goal_description);
				id: (aQuestJSON at: #id);
				yourself ]]
]

{ #category : #initialization }
IdleChampionDataBase >> fillQuestsFrom: questsJSON [
	quests := questsJSON values collect: [ :aQuestJSON |
		Quest new
			description: (aQuestJSON at: #description);
			type: (aQuestJSON at: #type);
			properties: (aQuestJSON at: #properties);
			goalGraphicId: (aQuestJSON at: #goal_graphic_id);
			goalAmount: (aQuestJSON at: #goal_amount);
			goalDescription: (aQuestJSON at: #goal_description);
			id: (aQuestJSON at: #id);
			yourself
			]
]

{ #category : #initialization }
IdleChampionDataBase >> fillStoriesFrom: storiesJSONs [
	stories :=  storiesJSONs collect: [ :aBackgroundJSON |
		self flag: #todo."laziness...."
		Story new
			"midGraphicId: (aBackgroundJSON at: #mid_graphic_id);"
			yourself

			]
]

{ #category : #query }
IdleChampionDataBase >> findAdventureNamed: aName [
	^ campaigns detect: [ :c | c findAdventureNamed: aName ]
]

{ #category : #initialization }
IdleChampionDataBase >> initialize [
	self fillAreasInformations.
	self fillCampaigns.
	self resolveLinks
]

{ #category : #'accessing-id' }
IdleChampionDataBase >> monsterWithId: anID [

	^ monsters detect: [ :a | a id = anID ] ifNone: [ nil ]
]

{ #category : #accessing }
IdleChampionDataBase >> monsters [

	^ monsters
]

{ #category : #'accessing-id' }
IdleChampionDataBase >> questWithId: anID [

	^ 	quests detect: [ :a | a id = anID ] ifNone: [ nil ]
]

{ #category : #accessing }
IdleChampionDataBase >> quests [

	^ quests
]

{ #category : #initialization }
IdleChampionDataBase >> resolveLinks [
	attacks do: [ :a | a resolveLinksWith: self ].
	monsters do: [ :m | m resolveLinksWith: self ].
	quests  do: [ :q | q resolveLinksWith: self ].
	backgrounds  do: [ :b | b resolveLinksWith: self ].
	stories  do: [ :s | s resolveLinksWith: self ].
	campaigns do: [ :c | c resolveLinksWith: self ].
]

{ #category : #accessing }
IdleChampionDataBase >> stories [

	^ stories
]

{ #category : #'accessing-id' }
IdleChampionDataBase >> storyWithId: anID [
	^ stories detect: [ :a | a id = anID ] ifNone: [ nil ]
]
