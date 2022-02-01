Class {
	#name : #Monster,
	#superclass : #AbstractMonster,
	#category : #'AABriv-model'
}

{ #category : #accessing }
Monster >> resolveLinksWith: aDatabase [
	attack := aDatabase attackWithId: attackId.
]
