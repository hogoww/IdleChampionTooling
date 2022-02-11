Class {
	#name : #CodeNameEntertainmentQueries,
	#superclass : #IdleChampionQueries,
	#instVars : [
		'userHash',
		'user',
		'userObject'
	],
	#pools : [
		'IdleChampionChestIDs'
	],
	#category : #'AABriv-webQuery'
}

{ #category : #url }
CodeNameEntertainmentQueries class >> baseUrl [
	^ 'http://ps7.idlechampions.com/~idledragons/post.php?call='
]

{ #category : #initialization }
CodeNameEntertainmentQueries class >> forICPUser: anICPUser [ 
	^ self forUser: anICPUser user
		andHash: anICPUser userHash
]

{ #category : #url }
CodeNameEntertainmentQueries class >> forUser: aUser andHash: aHash [
	^ self basicNew
		user: aUser;
		userHash: aHash;
		initialize;
		yourself
]

{ #category : #url }
CodeNameEntertainmentQueries class >> handleErrorIfAnyFrom: aJson [
	(aJson at: #success) 
		ifFalse: [ self error: 
			(String streamContents: [ :s | 
				 s << (aJson at: #error_code) printString;
					<< ' ';
					<< (aJson at: #failure_reason)
		 	])
		]
]

{ #category : #'query-support' }
CodeNameEntertainmentQueries >> baseUrl [
	^ self class baseUrl
]

{ #category : #'query-parts' }
CodeNameEntertainmentQueries >> chestPart: aChestType [
	^ ZnMimePart fieldName: 'chest_type_id' value: aChestType printString
]

{ #category : #query }
CodeNameEntertainmentQueries >> getUserDetailsJson [
	| response |
	response := self newQuery
		url: self userDetailsUrl asUrl;
		addPart: 	(ZnMimePart fieldName: 'include_free_play_objectives' value: 'true');
		addPart: 	(ZnMimePart fieldName: 'instance_key' value: '1');
		addPart: 	self userPart;
		addPart: self userHashPart;
		post;
		response.
	^ self jsonFrom: response
]

{ #category : #initialization }
CodeNameEntertainmentQueries >> initialize [
	userObject := IdleChampionUser new
		initializeFrom: self getUserDetailsJson;
		userId: user;
		userHash: userHash;
		yourself.
]

{ #category : #'query-parts' }
CodeNameEntertainmentQueries >> instanceIdPart [
	^ ZnMimePart fieldName: 'instance_id' value: userObject instanceID
]

{ #category : #'rest-support' }
CodeNameEntertainmentQueries >> jsonFrom: response [
	^ self class jsonFrom: response

]

{ #category : #'rest-support' }
CodeNameEntertainmentQueries >> newQuery [
	^ self class newQuery
]

{ #category : #'api-chests' }
CodeNameEntertainmentQueries >> openAllChests: aChestID [
	| availableChests |
	availableChests := userObject howManyChestsOf: aChestID.
	(0 to: availableChests % 50) collect: [ :i|
		| queryRes |
		queryRes := self openChest: aChestID times: 50
		] into: OrderedCollection new
]

{ #category : #api }
CodeNameEntertainmentQueries >> openAllSilverChests [
	^ self openAllChests: SilverID.
]

{ #category : #query }
CodeNameEntertainmentQueries >> openChest: aChestType times: aNumberOfChests [
"	""&gold_per_second=0
	&checksum=4c5f019b6fc6eefa4d47d21cfaf1bc68
	&user_id="" UserID 
	""&hash="" UserHash 
	""&instance_id="" InstanceID 
	""&chest_type_id="" chestid 
	""&game_instance_id="" ActiveInstance 
	""&count=""
			"

	| response query |
	query := self newQuery
		url: self openGenericChestsURL asUrl;
		addPart: (ZnMimePart fieldName: 'gold_per_second' value: '0');
		addPart: (ZnMimePart fieldName: 'checksum' value: '4c5f019b6fc6eefa4d47d21cfaf1bc68').
		
	query addUserPartsFrom: userObject.
	response := query
		addPart: (self chestPart: aChestType);
		addPart: (ZnMimePart fieldName: '	"game_instance_id' value: '1');
		addPart: (ZnMimePart fieldName: 'count' value: aNumberOfChests printString);
		post; 
		response.
	^ self jsonFrom: response
]

{ #category : #query }
CodeNameEntertainmentQueries >> openChests [
"	chestparams := ""&gold_per_second=0
	&checksum=4c5f019b6fc6eefa4d47d21cfaf1bc68
	&user_id="" UserID 
	""&hash="" UserHash 
	""&instance_id="" InstanceID 
	""&chest_type_id="" chestid 
	""&game_instance_id="" ActiveInstance 
	""&count=""
			
			rawresults := ServerCall(""opengenericchest"", chestparams count)"

	| response query aCode |
	query := self newQuery
		url: self redeemUrl asUrl.
	query addDummyDataParts.
	query addUserParts.
	response := query
		addPart: 	(ZnMimePart fieldName: 'code' value: aCode);
		post;
		response.
	^ self jsonFrom: response
]

{ #category : #url }
CodeNameEntertainmentQueries >> openGenericChestsURL [
	^ String streamContents: [ :s | 
		s << self baseUrl;
			<< 'opengenericchest'
		]
]

{ #category : #api }
CodeNameEntertainmentQueries >> redeemAllCodesFrom: aString [
	| extractedCode |
	extractedCode := IdleChampionUtils extractCodesFrom: aString.
	^ extractedCode lines collect: [ :aCode |
		self redeemCode: aCode
		] into: Bag new
]

{ #category : #api }
CodeNameEntertainmentQueries >> redeemCode: aCode [
	| result |
	result := self redeemCodeServerCall: aCode.
	^ self redeemCodeResultString: result
]

{ #category : #'query-result' }
CodeNameEntertainmentQueries >> redeemCodeResultString: result [
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

{ #category : #query }
CodeNameEntertainmentQueries >> redeemCodeServerCall: aCode [
	| response query |
	query := self newQuery
		url: self redeemUrl asUrl.
	query addDummyDataParts.
	query addUserPartsFrom: userObject.
	response := query
		addPart: 	(ZnMimePart fieldName: 'code' value: aCode);
		post;
		response.
	^ self jsonFrom: response
]

{ #category : #url }
CodeNameEntertainmentQueries >> redeemUrl [
	^ self baseUrl , 'redeemcoupon'
]

{ #category : #accessing }
CodeNameEntertainmentQueries >> user [

	^ user
]

{ #category : #accessing }
CodeNameEntertainmentQueries >> user: anObject [

	user := anObject
]

{ #category : #url }
CodeNameEntertainmentQueries >> userDetailsUrl [
	^ String streamContents: [ :s | 
		s << self baseUrl;
			<< 'getuserdetails'
		]
]

{ #category : #accessing }
CodeNameEntertainmentQueries >> userHash [
	"Rename to avoid clashing with #hash system method"
	^ userHash
]

{ #category : #accessing }
CodeNameEntertainmentQueries >> userHash: anObject [

	userHash := anObject
]

{ #category : #'query-parts' }
CodeNameEntertainmentQueries >> userHashPart [
	^ ZnMimePart fieldName: 'hash' value: userHash
]

{ #category : #'query-parts' }
CodeNameEntertainmentQueries >> userPart [
	^ ZnMimePart fieldName: 'user_id' value: user
]
