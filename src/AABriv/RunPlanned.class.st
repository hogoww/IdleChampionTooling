Class {
	#name : #RunPlanned,
	#superclass : #Object,
	#instVars : [
		'adventure',
		'jumps',
		'areas'
	],
	#category : #'AABriv-model'
}

{ #category : #'as yet unclassified' }
RunPlanned class >> planFor: anAdventure jumpingBy: anAmount [
	^ self new
		adventure: anAdventure ;
		jumps: anAmount ;
		yourself
]

{ #category : #accessing }
RunPlanned >> adventure [

	^ adventure
]

{ #category : #accessing }
RunPlanned >> adventure: anObject [

	adventure := anObject
]

{ #category : #query }
RunPlanned >> cacheAreasEncounteredTo: anInteger [
	areas := self collectAreasTo: anInteger.
]

{ #category : #query }
RunPlanned >> collectAreasTo: aMaxArea [
	^ ((0 to: aMaxArea - 1 by: jumps + 1) 
		collect: [ :i | i -> (adventure areaAt: (i rem: 50) + 1) ])
		asOrderedCollection
]

{ #category : #query }
RunPlanned >> encountersAreaNumber: anIndex [
	^ (areas at: anIndex ifAbsent:[ nil ]) isNotNil
]

{ #category : #query }
RunPlanned >> howManyAreasTo: anInteger [ 
	^ (1 to: anInteger by: jumps + 1) size
]

{ #category : #accessing }
RunPlanned >> jumps [

	^ jumps
]

{ #category : #accessing }
RunPlanned >> jumps: anObject [

	jumps := anObject
]

{ #category : #accessing }
RunPlanned >> lastAreaNumber [
	^ areas last key
]
