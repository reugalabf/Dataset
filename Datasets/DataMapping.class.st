Class {
	#name : #DataMapping,
	#superclass : #Object,
	#instVars : [
		'map'
	],
	#category : #'Datasets-DataMappings'
}

{ #category : #'instance creation' }
DataMapping class >> from: dataset keyColumn: aString valueColumn: anotherString [
	^ self new
		from: dataset keyColumn: aString valueColumn: anotherString round: 0.5;
		yourself
]

{ #category : #'instance creation' }
DataMapping class >> from: dataset keyColumn: aString valueColumn: anotherString round: anInteger [
	^ self new
		from: dataset keyColumn: aString valueColumn: anotherString round: anInteger; 
		yourself
]

{ #category : #converting }
DataMapping >> asWeightedAverageMap [
	| dict |
	dict := Dictionary new.
	map
		keysAndValuesDo: [ :key :datum | dict at: key put: (self halt weightedAverageFrom: datum) ].
	^ self class new
		setMap: dict;
		yourself
]

{ #category : #'instance creation' }
DataMapping >> from: dataset keyColumn: aString valueColumn: anotherString round: anInteger [
	map notNil
		ifTrue: [ self error: 'DataMapping is not empty' ].
	map := Dictionary new.
	dataset rows
		do: [ :each | 
			(each valueAt: anotherString)
				ifNotNil: [ map
						at: (self normalized: (each valueAt: aString) resolution: anInteger)
						ifPresent: [ :value | value add: (each valueAt: anotherString) value asNumber ]
						ifAbsentPut: (SortedCollection with: (each valueAt: anotherString) value asNumber) ] ]
]

{ #category : #accessing }
DataMapping >> map [
	^ map
]

{ #category : #'instance creation' }
DataMapping >> normalized: datum resolution: resolution [
	^ datum value asNumber truncateTo: resolution 
]

{ #category : #accessing }
DataMapping >> numberOfRows [
	^ map size
]

{ #category : #accessing }
DataMapping >> setMap: aDictionary [
	^ map := aDictionary
]

{ #category : #accessing }
DataMapping >> valuesAt: akey [
	^ map at: akey
]

{ #category : #private }
DataMapping >> weightedAverageFrom: aCollection [
	| num |
	num := 0.
	aCollection asBag
		associationsDo: [ :assoc | num := num + (assoc key * assoc value) ].
	^ num / aCollection size
]
