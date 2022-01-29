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
				post;
				response.
	
	^ STONJSON fromString: (ReadStream on: response entity string).
]

{ #category : #query }
KlehoQueries class >> getAdventuresFor: aCampaignID page: aPageNumber [
	| response |
	response := self newJWTAuthorizedClient
				url: (self adventuresURL) asUrl;
				addPart: (ZnMimePart fieldName: 'campaign_id' value: aCampaignID printString);
				addPart: self maxLimit;
				addPart: (self page: aPageNumber);
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
				url: self adventuresURL asUrl;
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
				url: (self campaignsURL) asUrl;
				addPart: (ZnMimePart fieldName: 'limit' value: '100');
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
