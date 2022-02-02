Class {
	#name : #BaselineOfIdleChampionTooling,
	#superclass : #BaselineOf,
	#category : #BaselineOfIdleChampionTooling
}

{ #category : #baselines }
BaselineOfIdleChampionTooling >> baseline: spec [

  <baseline>
  spec
    for: #common
    do: [ self setUpDependencies: spec.
      spec package: #AABriv with: [ spec requires: #('Stargate') ] ]
]

{ #category : #baselines }
BaselineOfIdleChampionTooling >> projectClass [
	^ MetacelloCypressBaselineProject
]

{ #category : #baselines }
BaselineOfIdleChampionTooling >> setUpDependencies: spec [

  spec
    baseline: 'Stargate'
      with: [ spec
        repository: 'github://ba-st/Stargate:v6.1.0/source';
        loads: #('Deployment') ];
    import: 'Stargate'.
]
