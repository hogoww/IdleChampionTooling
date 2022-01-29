Class {
	#name : #IdleChampionUtils,
	#superclass : #Object,
	#category : #'AABriv-model'
}

{ #category : #code }
IdleChampionUtils class >> extractCodesFrom: aString [
	| res |
	res := aString lines
		select: [ :l | l first = $[ ]
		thenCollect: [ :l | 
			| line |
				  line := l last: l size - (l indexOf: $:).
				  line last: line size - (line indexOf: $:) ].
	^ String streamContents: [:s | res do: [ :i | s << i ] separatedBy: [ s cr ] ].
]
