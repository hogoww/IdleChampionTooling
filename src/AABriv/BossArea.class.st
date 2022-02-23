Class {
	#name : #BossArea,
	#superclass : #AbstractArea,
	#instVars : [
		'bossHealth',
		'waves',
		'wavesIds'
	],
	#category : #'AABriv-model'
}

{ #category : #accessing }
BossArea >> allMonsters [ 
	^ super allMonsters , waves flatCollect: [ :aWave | aWave  ]
]

{ #category : #accessing }
BossArea >> bossHealth [

	^ bossHealth
]

{ #category : #accessing }
BossArea >> bossHealth: anObject [

	bossHealth := anObject
]

{ #category : #accessing }
BossArea >> bosses [
	self shouldBeImplemented.
]

{ #category : #testing }
BossArea >> isBossArea [
	^ true
]

{ #category : #testing }
BossArea >> isFitForKrullBush [
	self hasBush ifFalse: [ ^ false ].
	^ self allMonsters noneSatisfy: [ :aMonster | aMonster isBoss and: [ aMonster isRanged ] ]
]

{ #category : #accessing }
BossArea >> resolveLinksWith: aDatabase [

	super resolveLinksWith: aDatabase.
	waves := wavesIds collect: [ :aCollectionOfIds |
		aCollectionOfIds collect: [ :aMonsterId | 
			aDatabase monsterWithId: aMonsterId ]].
]

{ #category : #accessing }
BossArea >> waves [

	^ waves
]

{ #category : #accessing }
BossArea >> waves: anObject [

	waves := anObject
]

{ #category : #accessing }
BossArea >> wavesIds [
	^ wavesIds
]

{ #category : #accessing }
BossArea >> wavesIds: anObject [

	wavesIds := anObject
]
