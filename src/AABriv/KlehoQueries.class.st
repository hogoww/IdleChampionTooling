Class {
	#name : #KlehoQueries,
	#superclass : #IdleChampionQueries,
	#category : #'AABriv-webQuery'
}

{ #category : #url }
KlehoQueries class >> adventuresUrl [
	^ self baseUrl , 'list-adventures'
]

{ #category : #'query-support' }
KlehoQueries class >> areaInformationPart [
	^ ZnMimePart fieldName: 'scope' value: 'variants,areas,monsters,quests,stories,bgs'
]

{ #category : #url }
KlehoQueries class >> areaInformationUrl [
	^ self baseUrl , 'list-area-sets'
]

{ #category : #url }
KlehoQueries class >> backgroundUrl [
	^ self baseUrl, 'list-backgrounds'
]

{ #category : #url }
KlehoQueries class >> baseUrl [
	^ 'https://idle.kleho.ru/v02/adventures/'
]

{ #category : #url }
KlehoQueries class >> campaignsUrl [
	^ self baseUrl , 'list-campaigns'

]

{ #category : #url }
KlehoQueries class >> distractionsUrl [
	^ self baseUrl , 'list-distractions'
]

{ #category : #query }
KlehoQueries class >> getAdventuresFor: aCampaignID [
	| response |
	(Duration seconds: 1) wait.
	response := self newQuery
			
			url: (self adventuresUrl) asUrl;
			addPart: (ZnMimePart fieldName: 'campaign_id' value: aCampaignID printString);
			addPart: self maxLimit;
			addPart: (ZnMimePart fieldName: 'scope' value: 'variants,areas,monsters,stories,bgs') ;
			post;
			response.
	^ self jsonFrom: response
]

{ #category : #query }
KlehoQueries class >> getAreasFor: anAdventureID [
	| response |
	response := self newQuery
		url: self adventuresUrl asUrl;
		addPart: self maxLimit;
		post;
		response.
	^ self jsonFrom: response
]

{ #category : #query }
KlehoQueries class >> getBackgrounds [
	| response |
	response := self newQuery
		url: self backgroundUrl asUrl;
		addPart: self maxLimit;
		post;
		response.
	^ self jsonFrom: response.
]

{ #category : #query }
KlehoQueries class >> getCampaigns [
	| response |
	response := self newQuery
		url: self campaignsUrl asUrl;
		addPart: self maxLimit;
		post;
		response.
	^ self jsonFrom: response
]

{ #category : #query }
KlehoQueries class >> getDistractions [
	| response |
	response := self newQuery
		url: self distractionsUrl asUrl;
		addPart: self maxLimit;
		post;
		response.
	^ self jsonFrom: response
]

{ #category : #query }
KlehoQueries class >> getMonsters [
	| response pageNumber |
	pageNumber := 0.
	response := OrderedCollection new.
	[ | currentResponse |
		currentResponse := currentResponse := self getMonstersPage: pageNumber.
		response add: currentResponse.
		pageNumber = (((currentResponse at: #data) at: #_pages) - 1).
		] whileFalse: [  pageNumber := pageNumber + 1 ].
	^ response
]

{ #category : #'query-support' }
KlehoQueries class >> getMonstersPage: aPage [
	| response |
	response := self newQuery
		url: self monstersUrl asUrl;
		addPart: self maxLimit;
		addPart: (self page: aPage);
		post;
		response.
	^ self jsonFrom: response
]

{ #category : #query }
KlehoQueries class >> getQuests [
	| response pageNumber |
	pageNumber := 0.
	response := OrderedCollection new.
	[ | currentResponse |
		currentResponse := currentResponse := self getQuestsPage: pageNumber.
		response add: currentResponse.
		pageNumber = (((currentResponse at: #data) at: #_pages) - 1).
		] whileFalse: [  pageNumber := pageNumber + 1 ].
	^ response
]

{ #category : #'query-support' }
KlehoQueries class >> getQuestsPage: aPage [
	| response |
	response := self newQuery
		url: self questsUrl asUrl;
		addPart: self maxLimit;
		addPart: (self page: aPage);
		post;
		response.
	^ self jsonFrom: response
]

{ #category : #'query-support' }
KlehoQueries class >> maxLimit [
	^ ZnMimePart fieldName: 'limit' value: '1000'
]

{ #category : #'query-support' }
KlehoQueries class >> minLimit [
	"sometime we don't care about the base query"
	"Does 0 works?"
	^ ZnMimePart fieldName: 'limit' value: '1'
]

{ #category : #url }
KlehoQueries class >> monstersUrl [
	^ self baseUrl , 'list-monsters'
]

{ #category : #'query-support' }
KlehoQueries class >> page: aPageNumber [
	^ (ZnMimePart fieldName: 'p' value: aPageNumber printString)
]

{ #category : #url }
KlehoQueries class >> questsUrl [
	^ self baseUrl , 'list-quests'
]
