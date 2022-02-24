Class {
	#name : #CodeNameEntertainmentQueries,
	#superclass : #IdleChampionQueries,
	#instVars : [
		'icUser'
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
	^ self basicNew
		icUser: anICPUser;
		yourself
]

{ #category : #url }
CodeNameEntertainmentQueries class >> handleErrorIfAnyFrom: aJson [
	(aJson at: #success) 
		ifFalse: [ self error: 
			(String streamContents: [ :s | 
				 s 
					<< '(';
					<< (aJson at: #error_code) printString;
					<< ') ';
					<< (aJson at: #failure_reason)
		 	])
		]
]

{ #category : #'query-support' }
CodeNameEntertainmentQueries >> baseUrl [
	^ self class baseUrl
]

{ #category : #'query-parts' }
CodeNameEntertainmentQueries >> buffPart: aBuffType [
	^ ZnMimePart fieldName: 'buff_id' value: aBuffType
]

{ #category : #query }
CodeNameEntertainmentQueries >> buyChests: aChestType times: aNumberOfChests [
	| response |
	response := 	self newQuery
		url: self buyChestsURL;
		addDummyDataParts;
		addUserPartsFrom: icUser;
		addPart: (self chestPart: aChestType);
		addPart: (ZnMimePart fieldName: 'count' value: aNumberOfChests printString);
		post; 
		response.
	^ self jsonFrom: response
]

{ #category : #url }
CodeNameEntertainmentQueries >> buyChestsURL [
	^ (self baseUrl , 'buysoftcurrencychest') asUrl
]

{ #category : #'query-parts' }
CodeNameEntertainmentQueries >> chestPart: aChestType [
	^ ZnMimePart fieldName: 'chest_type_id' value: aChestType
]

{ #category : #query }
CodeNameEntertainmentQueries >> getUserDetailsJson [
	| response |
	response := self newQuery
		url: self userDetailsUrl;
		addPart: 	(ZnMimePart fieldName: 'include_free_play_objectives' value: 'true');
		addPart: 	(ZnMimePart fieldName: 'instance_key' value: '1');
		addPart: 	self userPart;
		addPart: self userHashPart;
		post;
		response.
	^ self jsonFrom: response
]

{ #category : #accessing }
CodeNameEntertainmentQueries >> icUser [

	^ icUser
]

{ #category : #accessing }
CodeNameEntertainmentQueries >> icUser: anObject [

	icUser := anObject
]

{ #category : #'query-parts' }
CodeNameEntertainmentQueries >> instanceIdPart [
	^ ZnMimePart fieldName: 'instance_id' value: icUser instanceID
]

{ #category : #'rest-support' }
CodeNameEntertainmentQueries >> jsonFrom: response [
	^ self class jsonFrom: response

]

{ #category : #'rest-support' }
CodeNameEntertainmentQueries >> newQuery [
	^ self class newQuery
]

{ #category : #query }
CodeNameEntertainmentQueries >> openChests: aChestType times: aNumberOfChests [
	| response |
	response := 	self newQuery
		url: self openGenericChestsURL;
		addPart: (ZnMimePart fieldName: 'gold_per_second' value: '0');
		addPart: (ZnMimePart fieldName: 'checksum' value: '4c5f019b6fc6eefa4d47d21cfaf1bc68');
		addUserPartsFrom: icUser;
		addPart: (self chestPart: aChestType);
		addPart: (ZnMimePart fieldName: 'game_instance_id' value: icUser activeGameInstanceId);
		addPart: (ZnMimePart fieldName: 'count' value: aNumberOfChests printString);
		post; 
		response.
	^ self jsonFrom: response
]

{ #category : #url }
CodeNameEntertainmentQueries >> openGenericChestsURL [
	^ (self baseUrl ,'opengenericchest') asUrl
]

{ #category : #query }
CodeNameEntertainmentQueries >> redeemCodeServerCall: aCode [
	| response query |
	query := self newQuery
		url: self redeemUrl.
	query addDummyDataParts.
	query addUserPartsFrom: icUser.
	response := query
		addPart: 	(ZnMimePart fieldName: 'code' value: aCode);
		post;
		response.
	^ self jsonFrom: response
]

{ #category : #url }
CodeNameEntertainmentQueries >> redeemUrl [
	^ (self baseUrl , 'redeemcoupon') asUrl
]

{ #category : #query }
CodeNameEntertainmentQueries >> useBuff: aBuffType times: aNumberOfBuff [
	| response |

" ""&buff_id="" buffid ""&hero_id="" heroid ""&num_uses=""
rawresults := ServerCall(""useserverbuff"",  count)"
	
	response := 	self newQuery
		url: self useBuffUrl;
"		addDummyDataParts;"
		addUserPartsFrom: icUser;
		addPart: (self buffPart: aBuffType);
		addPart: (ZnMimePart fieldName: 'num_uses' value: aNumberOfBuff printString);
		post; 
		response.
	^ self jsonFrom: response
]

{ #category : #url }
CodeNameEntertainmentQueries >> useBuffUrl [
	^ (self baseUrl , 'useserverbuff') asUrl
]

{ #category : #url }
CodeNameEntertainmentQueries >> userDetailsUrl [
	^ (self baseUrl , 'getuserdetails') asUrl
]

{ #category : #'query-parts' }
CodeNameEntertainmentQueries >> userHashPart [
	^ ZnMimePart fieldName: 'hash' value: icUser userHash
]

{ #category : #'query-parts' }
CodeNameEntertainmentQueries >> userPart [
	^ ZnMimePart fieldName: 'user_id' value: icUser userId
]
