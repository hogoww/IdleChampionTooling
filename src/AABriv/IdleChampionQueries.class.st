Class {
	#name : #IdleChampionQueries,
	#superclass : #Object,
	#category : #'AABriv-webQuery'
}

{ #category : #accessing }
IdleChampionQueries class >> baseUrl [
	^ self subclassResponsibility 
]

{ #category : #query }
IdleChampionQueries class >> jsonFrom: aResponse [
	^ STONJSON fromString: (ReadStream on: aResponse entity string)
]

{ #category : #'rest-support' }
IdleChampionQueries class >> newClient [
	"taken shamelessly from HTTPBasedRESTfulAPITest"

	^ ZnClient new
		beOneShot;
		enforceHttpSuccess: true;
		yourself
]

{ #category : #'rest-support' }
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

{ #category : #'rest-support' }
IdleChampionQueries class >> newQuery [
	"improve readability"
	^ self newJWTAuthorizedClient
]
