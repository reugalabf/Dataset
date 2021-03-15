Class {
	#name : #Dataset,
	#superclass : #Object,
	#instVars : [
		'rows',
		'descriptor'
	],
	#category : #'Datasets-Core'
}

{ #category : #'instance creation' }
Dataset class >> emptyWithDescriptor: aDatasetDescriptor [
	^ self new
		setDescriptor: aDatasetDescriptor;
		yourself
]

{ #category : #'instance creation' }
Dataset class >> filename: aFilename descriptor: aDatasetDescriptor [
	^ self
		on: aFilename asFileReference readStream
			descriptor: aDatasetDescriptor;
		yourself
]

{ #category : #'instance creation' }
Dataset class >> on: readStream descriptor: aDatasetDescriptor [
	^ self new
		loadFrom: readStream withDescriptor: aDatasetDescriptor;
		yourself
]

{ #category : #adding }
Dataset >> addRow: aRow [
	rows addLast: aRow
]

{ #category : #converting }
Dataset >> canJoin: anotherDataset [
	^ self numberOfRows = anotherDataset numberOfRows
		and: [ descriptor canJoin: anotherDataset descriptor ]
]

{ #category : #testing }
Dataset >> checkConsistencyOn: columnName rule: aDatasetRule [
	^ self rows
		reject:
			[ :each | aDatasetRule checkConsitencyFor: (each valueAtName: columnName) ]
]

{ #category : #accessing }
Dataset >> columns [
	^ descriptor columns
]

{ #category : #initialization }
Dataset >> descriptor [
	^ descriptor
]

{ #category : #exporting }
Dataset >> exportCSV [
	| ws |
	ws := WriteStream on: String new.
	rows
		do: [ :row | 
			row exportCSVOn: ws.
			ws cr ].
	^ ws contents
]

{ #category : #initialization }
Dataset >> initialize [
	rows := OrderedCollection new
]

{ #category : #converting }
Dataset >> join: anotherDataset [
	^ self
		join: anotherDataset
		matchBlock: [ :myRow :otherRow | 
			(myRow valueAtName: (self descriptor columnAt: 1) key)
				equalValue: (otherRow valueAtName: (anotherDataset descriptor columnAt: 1) key) ]
]

{ #category : #converting }
Dataset >> join: anotherDataset matchBlock: aBlock [
	| joinDataset |
	joinDataset := Dataset
		emptyWithDescriptor: (self descriptor join: anotherDataset descriptor).
	rows
		do: [ :sourceRow | 
			| matches |
			matches := anotherDataset
				rowsMatching: [ :targetRow | aBlock value: sourceRow value: targetRow ]
				do: [ :matchingRow | joinDataset  addRow: (sourceRow join: matchingRow) ] ].
	^ joinDataset
]

{ #category : #converting }
Dataset >> join: anotherDataset matchColumns: anArray [
	^ self
		join: anotherDataset
		matchBlock: [ :sourceRow :targetRow | 
			| bool |
			bool := true.
			1 to: anArray size do: [ :idx | 
				bool := bool
					and: [ (sourceRow valueAtIndex: (anArray at: idx))
							equalValue: (targetRow valueAtIndex: (anArray at: idx)) ] ].
			bool ]
]

{ #category : #initialization }
Dataset >> loadFrom: aReadStream withDescriptor: aDatasetDescriptor [
	| reader |
	rows isEmpty ifFalse:[self error: 'Dataset is not empty'].
	descriptor := aDatasetDescriptor.
	reader := NeoCSVReader on: aReadStream.
	aDatasetDescriptor addFieldsTo: reader.
	reader
		do:
			[ :each | rows addLast: (DatasetRow on: each descriptor: aDatasetDescriptor) ]
]

{ #category : #'instance creation' }
Dataset >> numberOfRows [
	^ rows size
]

{ #category : #converting }
Dataset >> rightPaste: anotherDataset [ 
	| joinDataset joinDescriptor |
	(self canJoin: anotherDataset)
		ifFalse: [ self error: 'Datasets are not of the same size' ].
	joinDescriptor := descriptor join: anotherDataset descriptor.
	joinDataset := self class emptyWithDescriptor: joinDescriptor.
	1 to: rows size do: [ :idx | 
		joinDataset
			addRow:
				((rows at: idx)
					join: (anotherDataset rows at: idx)
					descriptor: joinDescriptor) ].
	^ joinDataset
]

{ #category : #accessing }
Dataset >> rows [
	^ rows
]

{ #category : #converting }
Dataset >> rowsMatching: aBlock [
	^ rows select: aBlock
]

{ #category : #converting }
Dataset >> rowsMatching: aBlock do: anotherBlock [
	rows
		do: [ :each | 
			(aBlock value: each)
				ifTrue: [ anotherBlock value: each ] ]
]

{ #category : #initialization }
Dataset >> setDescriptor: aDatasetDescriptor [
	descriptor := aDatasetDescriptor
]

{ #category : #converting }
Dataset >> subDatasetWithColumns: aCollection [
	| subDataset subDescriptor |
	subDescriptor := descriptor
		subDatasetDescriptorWithColumns: aCollection.
	subDataset := self class emptyWithDescriptor: subDescriptor.
	rows
		do:
			[ :each | subDataset addRow: (each subDatasetRowWithDescriptor: subDescriptor) ].
	^ subDataset
]
