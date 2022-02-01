Class {
	#name : #KlehoQueries,
	#superclass : #Object,
	#category : #'AABriv-webQuery'
}

{ #category : #url }
KlehoQueries class >> adventuresURL [
	^ self basePath , 'list-adventures'
]

{ #category : #'query-support' }
KlehoQueries class >> areaInformationPart [
	^ ZnMimePart fieldName: 'scope' value: 'variants,areas,monsters,quests,stories,bgs'
]

{ #category : #url }
KlehoQueries class >> areaInformationUrl [
	^ self basePath , 'list-area-sets'
]

{ #category : #url }
KlehoQueries class >> backgroundUrl [
	^ self basePath, 'list-backgrounds'
]

{ #category : #url }
KlehoQueries class >> basePath [
	^ 'https://idle.kleho.ru/v02/adventures/'
]

{ #category : #url }
KlehoQueries class >> campaignsURL [
	^ self basePath , 'list-campaigns'

]

{ #category : #query }
KlehoQueries class >> getAdventuresFor: aCampaignID [
	| response |
	response := self newJWTAuthorizedClient
			url: (self adventuresURL) asUrl;
			addPart: (ZnMimePart fieldName: 'campaign_id' value: aCampaignID printString);
			addPart: self maxLimit;
			addPart: (ZnMimePart fieldName: 'scope' value: 'variants,areas,monsters,quests,stories,bgs') ;
			post;
			response.
	^ STONJSON fromString: (ReadStream on: response entity string).
]

{ #category : #query }
KlehoQueries class >> getAreasFor: anAdventureID [
	| response |
	response := self newJWTAuthorizedClient
		url: (self adventuresURL) asUrl;
		addPart: self maxLimit;
		post;
		response.
	^ STONJSON fromString: (ReadStream on: response entity string).
]

{ #category : #query }
KlehoQueries class >> getAreasInformations [
	| response |
	response := self newJWTAuthorizedClient
		url: self areaInformationUrl asUrl;
		addPart: self minLimit;
		addPart: self areaInformationPart;
		post;
		response.
	^ STONJSON fromString: (ReadStream on: response entity string).
]

{ #category : #query }
KlehoQueries class >> getBackgrounds [
	| response |
	response := self newJWTAuthorizedClient
		url: self backgroundUrl asUrl;
		addPart: self minLimit;
		addPart: self areaInformationPart;
		post;
		response.
	^ STONJSON fromString: (ReadStream on: response entity string).
]

{ #category : #query }
KlehoQueries class >> getCampaignsJSON [
	| response |
	response := self newJWTAuthorizedClient
		url: self campaignsURL asUrl;
		addPart: self maxLimit
		post;
		response.
	^ STONJSON fromString: (ReadStream on: response entity string).
]

{ #category : #query }
KlehoQueries class >> getMonsters [
	| response pageNumber |
	pageNumber := 1.
	response := OrderedCollection new.
	[ | currentResponse |
		currentResponse := currentResponse := self getMonstersPage: pageNumber.
		response add: currentResponse.
		pageNumber = ((currentResponse at: #data) at: #_pages).
		] whileFalse: [  pageNumber := pageNumber + 1 ].

	self halt.
	^ STONJSON fromString: (ReadStream on: response entity string).
]

{ #category : #'as yet unclassified' }
KlehoQueries class >> getMonstersPage: aPage [
	| response |
	response := self newJWTAuthorizedClient
		url: self monstersURL asUrl;
		addPart: self maxLimit;
		addPart: (self page: aPage);
		post;
		response.
	^ STONJSON fromString: (ReadStream on: response entity string).
]

{ #category : #'query-support' }
KlehoQueries class >> maxLimit [
	^ ZnMimePart fieldName: 'limit' value: '100'
]

{ #category : #'query-support' }
KlehoQueries class >> minLimit [
	"sometime we don't care about the base query"
	"Does 0 works?"
	^ ZnMimePart fieldName: 'limit' value: '1'
]

{ #category : #url }
KlehoQueries class >> monstersURL [
	^ self basePath , 'list-monsters'
]

{ #category : #'query-support' }
KlehoQueries class >> newClient [
	"taken shamelessly from HTTPBasedRESTfulAPITest"

	^ ZnClient new
		beOneShot;
		enforceHttpSuccess: true;
		yourself
]

{ #category : #'query-support' }
KlehoQueries class >> newJWTAuthorizedClient [
	"taken shamelessly from HTTPBasedRESTfulAPITest"
	| client jws |

	jws := JsonWebSignature new.
	jws algorithmName: JWAHMACSHA256 parameterValue.
	jws payload: JWTClaimsSet new.
	jws key: 'secret'.

	client := self newClient.
	client request setAuthorization: ( 'Bearer <1s>' expandMacrosWith: jws compactSerialized ).
	^ client
]

{ #category : #'query-support' }
KlehoQueries class >> page: aPageNumber [
	^ (ZnMimePart fieldName: 'page' value: aPageNumber printString)
]
