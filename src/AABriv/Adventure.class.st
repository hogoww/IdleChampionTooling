Class {
	#name : #Adventure,
	#superclass : #Object,
	#instVars : [
		'campaign',
		'areas',
		'description',
		'id',
		'name',
		'areaSetId'
	],
	#category : #'AABriv-model'
}

{ #category : #initialization }
Adventure >> areaAt: anAreaIndex [
	^ areas at: anAreaIndex
]

{ #category : #initialization }
Adventure >> areaAt: anAreaIndex put: anArea [
	areas at: anAreaIndex put: anArea
]

{ #category : #accessing }
Adventure >> areaSetId [

	^ areaSetId
]

{ #category : #accessing }
Adventure >> areaSetId: anObject [

	areaSetId := anObject
]

{ #category : #accessing }
Adventure >> areas [

	^ areas
]

{ #category : #accessing }
Adventure >> areas: anObject [

	areas := anObject
]

{ #category : #accessing }
Adventure >> campaign [

	^ campaign
]

{ #category : #accessing }
Adventure >> campaign: anObject [

	campaign := anObject
]

{ #category : #accessing }
Adventure >> description [

	^ description
]

{ #category : #accessing }
Adventure >> description: anObject [

	description := anObject
]

{ #category : #accessing }
Adventure >> id [

	^ id
]

{ #category : #accessing }
Adventure >> id: anObject [

	id := anObject
]

{ #category : #initialization }
Adventure >> initialize [
	areas := Array new: 50.
]

{ #category : #accessing }
Adventure >> name [

	^ name
]

{ #category : #accessing }
Adventure >> name: anObject [

	name := anObject
]
