Class {
	#name : #IdleChampionUser,
	#superclass : #IdleChampionObject,
	#instVars : [
		'instanceID',
		'userId',
		'userHash',
		'name',
		'inventoryStates',
		'cneQueries'
	],
	#pools : [
		'IdleChampionChestIDs'
	],
	#classInstVars : [
		'RegisteredUser'
	],
	#category : #'AABriv-webQuery'
}

{ #category : #initializing }
IdleChampionUser class >> initialize [
	self resetRegisteredUsers
]

{ #category : #'instance creation' }
IdleChampionUser class >> new [
	| newUser |
	newUser := super new.
	RegisteredUser add: newUser.
	^ newUser
]

{ #category : #accessing }
IdleChampionUser class >> registeredUsers [
	^ RegisteredUser
]

{ #category : #initializing }
IdleChampionUser class >> resetRegisteredUsers [
	RegisteredUser := OrderedCollection new
]

{ #category : #accessing }
IdleChampionUser class >> userNamed: aName [
	^ RegisteredUser detect: [ :anICPUser | anICPUser name = aName ]
]

{ #category : #accessing }
IdleChampionUser >> activeGameInstanceId [
	^ (json at: #details)at: #active_game_instance_id
]

{ #category : #'api-chests' }
IdleChampionUser >> buyChests: aChestID times: aNumberOfChests [

	| currentNumberOfChests |
	self gems // (IdleChampionChestIDs priceForChest: aChestID) >= aNumberOfChests ifFalse: [ 
		self error: 'Not enough currency to buy ' , aNumberOfChests printString , ' '
			, (IdleChampionChestIDs nameForID: aChestID) ].

	UIManager default
		displayProgress: 'Buying ' , (IdleChampionChestIDs nameForID: aChestID) , ' ' , aNumberOfChests printString
		from: aNumberOfChests
		to: 0
		during: [ :bar | 
			currentNumberOfChests := aNumberOfChests.
			^ (1 to: currentNumberOfChests // 100 + 1)
				  collect: [ :i | | res |
					  bar value: currentNumberOfChests.
					  bar title: 'Buying ' , (IdleChampionChestIDs nameForID: aChestID) , ' ' , currentNumberOfChests printString , '/' ,aNumberOfChests printString.
					  res := self cneQueries buyChests: aChestID times: (100 min: currentNumberOfChests).
					  currentNumberOfChests := currentNumberOfChests - (100 min: currentNumberOfChests).
					  res ]
				  into: OrderedCollection new ]
]

{ #category : #'api-chests' }
IdleChampionUser >> buyMaximumGold [
	^ self buyChests: GoldID times: self gems // (IdleChampionChestIDs priceForChest: GoldID)
]

{ #category : #'api-chests' }
IdleChampionUser >> buyMaximumSilver [
	^ self buyChests: SilverID times: self gems // (IdleChampionChestIDs priceForChest: SilverID)
]

{ #category : #initialization }
IdleChampionUser >> checkCneQueriesState [
	self initializeCneQueries.
	self updateCneQueriesIfTooOld.
]

{ #category : #'api-chests' }
IdleChampionUser >> chestsOf: aChestID [
	^ self currentInventoryState chestsOf: aChestID
]

{ #category : #accessing }
IdleChampionUser >> cneQueries [
	self checkCneQueriesState.
	^ cneQueries
]

{ #category : #accessing }
IdleChampionUser >> currentInventoryState [
	^ inventoryStates last
]

{ #category : #accessing }
IdleChampionUser >> gems [
	^ self currentInventoryState gems
]

{ #category : #initialization }
IdleChampionUser >> initialize [
	inventoryStates := OrderedCollection new.
]

{ #category : #initialization }
IdleChampionUser >> initializeCneQueries [
	^  cneQueries ifNil: [ 
		cneQueries := CodeNameEntertainmentQueries forICPUser: self.
		self update
		]
]

{ #category : #accessing }
IdleChampionUser >> initializeIfPossible [
	"Allow for more flexibility while creating a user"
	userId ifNil: [ ^ self ].
	userHash ifNil: [ ^ self ].
	self initializeYourself
]

{ #category : #initialization }
IdleChampionUser >> initializeYourself [
	"force creation of cneQueries and first user datas"
	self cneQueries.
]

{ #category : #accessing }
IdleChampionUser >> instanceID [
	^ instanceID
]

{ #category : #accessing }
IdleChampionUser >> instanceID: anObject [

	instanceID := anObject
]

{ #category : #accessing }
IdleChampionUser >> inventoryState [
	^ inventoryStates
]

{ #category : #accessing }
IdleChampionUser >> inventoryStates: anObject [

	inventoryStates := anObject
]

{ #category : #accessing }
IdleChampionUser >> name [

	^ name
]

{ #category : #accessing }
IdleChampionUser >> name: anObject [
	name := anObject.
	self initializeIfPossible.
]

{ #category : #'api-chests' }
IdleChampionUser >> openAllGoldChests [
	^ self openChests: GoldID times: (self chestsOf: GoldID)
]

{ #category : #'api-chests' }
IdleChampionUser >> openAllSilverChests [
	^ self openChests: SilverID times: (self chestsOf: SilverID)
]

{ #category : #'api-chests' }
IdleChampionUser >> openChests: aChestID times: aNumberOfChests [

	| currentNumberOfChests |
	(self chestsOf: aChestID) >= aNumberOfChests ifFalse: [ 
		self error: 'Not enough ' , (IdleChampionChestIDs nameForID: aChestID) , ' Chests available' ].
	UIManager default
		displayProgress: 'Opening ' , (IdleChampionChestIDs nameForID: aChestID) , ' ' , aNumberOfChests printString
		from: aNumberOfChests
		to: 0
		during: [ :bar | 
			currentNumberOfChests := aNumberOfChests.
			(1 to: currentNumberOfChests // 50 + 1)
				collect: [ :i | | res |
					  bar value: currentNumberOfChests.
					  bar title: 'Openning ' , (IdleChampionChestIDs nameForID: aChestID) , ' ' , currentNumberOfChests printString , '/' , aNumberOfChests printString.
					res := self openedChestsFromJson: (self cneQueries openChests: aChestID times: (50 min: currentNumberOfChests)).
					currentNumberOfChests := currentNumberOfChests - (50 min: currentNumberOfChests).
					res ] into: OrderedCollection new ]
]

{ #category : #'api-chests' }
IdleChampionUser >> openGoldChests: aNumberOfChests [
	^ self openChests: GoldID times: aNumberOfChests
]

{ #category : #'api-chests' }
IdleChampionUser >> openSilverChests: aNumberOfChests [
	^ self openChests: SilverID times: aNumberOfChests
]

{ #category : #'result-interpration' }
IdleChampionUser >> openedChestsFromJson: aChestJson [
	| chest |
	chest := ChestOpenningResult new.
	chest chestType: (IdleChampionChestIDs nameForID: ((aChestJson at: #actions) first at: #chest_type_id)).
	chest chestContentsFromJson: (aChestJson at: #loot_details).
	^ chest
]

{ #category : #api }
IdleChampionUser >> redeemAllCodesFrom: aString [
	| extractedCode |
	extractedCode := IdleChampionUtils extractCodesFrom: aString.
	^ extractedCode lines collect: [ :aCode |
		self redeemCode: aCode
		] into: Bag new
]

{ #category : #api }
IdleChampionUser >> redeemCode: aCode [
	| result |
	result := self cneQueries redeemCodeServerCall: aCode.
	^ self redeemCodeResultString: result
]

{ #category : #'result-interpration' }
IdleChampionUser >> redeemCodeResultString: result [
	(result at: #okay) ifTrue: [
		^ (result at: #loot_details) 
			collect: [ :aResult |
				String streamContents: [ :s | 
					s << ((aResult at: #after) - (aResult at: #before)) printString.
					s space.
					s << (aResult at: #loot_item)
				]]].
	^ (result at: #failure_reason)
]

{ #category : #api }
IdleChampionUser >> update [
	json := cneQueries getUserDetailsJson. 
	instanceID := (json at: #details) at: #instance_id.
	inventoryStates add: (IdleChampionUserState new initializeFrom: json).
]

{ #category : #api }
IdleChampionUser >> updateAndCompare [
	| previousState |
	previousState := self currentInventoryState.
	self update.
	self currentInventoryState compareTo: previousState
]

{ #category : #initialization }
IdleChampionUser >> updateCneQueriesIfTooOld [
	"don't know what 'too old' might be yet"
]

{ #category : #accessing }
IdleChampionUser >> userHash [

	^ userHash
]

{ #category : #accessing }
IdleChampionUser >> userHash: anObject [

	userHash := anObject.
	self initializeIfPossible.
]

{ #category : #accessing }
IdleChampionUser >> userId [

	^ userId
]

{ #category : #accessing }
IdleChampionUser >> userId: anObject [

	userId := anObject.
	self initializeIfPossible.
]
