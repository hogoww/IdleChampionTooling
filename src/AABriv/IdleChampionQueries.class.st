Class {
	#name : #IdleChampionQueries,
	#superclass : #Object,
	#category : #'AABriv-webQuery'
}

{ #category : #url }
IdleChampionQueries class >> baseUrl [
	^ self subclassResponsibility
]

{ #category : #query }
IdleChampionQueries class >> jsonFrom: aResponse [
	^ STONJSON fromString: (ReadStream on: aResponse entity string).
]

{ #category : #'query-support' }
IdleChampionQueries class >> newClient [
	"taken shamelessly from HTTPBasedRESTfulAPITest"

	^ ZnClient new
		beOneShot;
		enforceHttpSuccess: true;
		yourself
]

{ #category : #'query-support' }
IdleChampionQueries class >> newJWTAuthorizedClient [
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
IdleChampionQueries class >> newQuery [
	"improve readability"
	^ self newJWTAuthorizedClient
]

{ #category : #'query-support' }
IdleChampionQueries class >> page: aPageNumber [
	^ (ZnMimePart fieldName: 'p' value: aPageNumber printString)
]
