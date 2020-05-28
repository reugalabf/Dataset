Class {
	#name : #Dataset,
	#superclass : #Object,
	#instVars : [
		'rows',
		'descriptor'
	],
	#category : #'Datasets-Sources'
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

{ #category : #accessing }
Dataset >> columns [
	^ descriptor columns
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

{ #category : #accessing }
Dataset >> rows [
	^ rows
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
	subDataset := Dataset emptyWithDescriptor: subDescriptor.
	rows
		do:
			[ :each | subDataset addRow: (each subDatasetRowWithDescriptor: subDescriptor) ].
	^ subDataset
]
