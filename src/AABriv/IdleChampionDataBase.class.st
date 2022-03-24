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
		'chestTypes'
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
	^ attacks detect: [ :a | a id = anID ]
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

{ #category : #accessing }
IdleChampionDataBase >> chestTypes [
	^ chestTypes
]

{ #category : #'accessing-id' }
IdleChampionDataBase >> chestWithId:	anID [
	^ chestTypes detect: [ :aChest | aChest id = anID ]
]

{ #category : #'accessing-id' }
IdleChampionDataBase >> distractionWithId: anID [
	^ distractions detect: [ :d | d id = anID ]
]

{ #category : #filling }
IdleChampionDataBase >> fillAttacksFrom: attackJSONS [
	"Cannot currently query attacks directly, therefore we have to build it incrementally from monsters"
	attacks ifNil: [ attacks := Dictionary new ].
	
	((attackJSONS at: #data) at: #attacks) do: [ :anAttackJSON |
		| attack |
		attack := Attack newFrom: anAttackJSON.
		attacks at: attack id put: attack
		]
]

{ #category : #filling }
IdleChampionDataBase >> fillBackgrounds [
	| backgroundsJSON |
	backgroundsJSON := KlehoQueries getBackgrounds.
	backgrounds := ((backgroundsJSON at: #data) at: #bgs) collect: [ :aBackgroundJSON | 
		Background newFrom: aBackgroundJSON
		]
]

{ #category : #filling }
IdleChampionDataBase >> fillCampaigns [
	| campaignsJSON |
	campaignsJSON := (KlehoQueries getCampaigns at: #data) at: #campaigns.
	^ campaigns := campaignsJSON collect:[ :aCampaignJSON |
		Campaign newFrom: aCampaignJSON
		].
]

{ #category : #filling }
IdleChampionDataBase >> fillChests [
	| chestsJSON |
	chestsJSON := self getChestJSON.
	chestTypes := chestsJSON collect: [ :aChestJSON | 
		IdleChampionChest newFrom: aChestJSON
		]
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
		Distraction newFrom: aDistractionJSON
		]
]

{ #category : #filling }
IdleChampionDataBase >> fillMonsters [
	| monstersJSON |
	monstersJSON := KlehoQueries getMonsters.
	monsters := monstersJSON flatCollect: [ :aDictionary |
		self fillAttacksFrom: aDictionary.
		((aDictionary at: #data) at: #monsters) collect: [ :aMonsterJSON | 
			Monster newFrom: aMonsterJSON
			]
		]
]

{ #category : #filling }
IdleChampionDataBase >> fillQuests [
	| questsJSONs |
	questsJSONs := KlehoQueries getQuests.
	quests := questsJSONs flatCollect: [ :aDictionary |
		((aDictionary at: #data) at: #quests) collect: [ :aQuestJSON | 
			Quest newFrom: aQuestJSON
			]]
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

{ #category : #query }
IdleChampionDataBase >> lookForBrivStackingAdventureFor: aNumberOfJumps [
	^ self allAdventures reject:[ :anAdventure | 
		| rp |
		rp := RunPlanner new
			adventure: anAdventure;
			brivJumps: 6;
			objective: 770;
			calculateAreas.
		rp hasArmorBased or: [ rp hasHitBased ]	
		]
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
