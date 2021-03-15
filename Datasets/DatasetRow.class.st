Class {
	#name : #DatasetRow,
	#superclass : #Object,
	#instVars : [
		'data',
		'descriptor'
	],
	#category : #'Datasets-Core'
}

{ #category : #'as yet unclassified' }
DatasetRow class >> datumCollection: anArray descriptor: aDescriptor [
	^ self new
		setDatumCollection: anArray 
		withDescriptor: aDescriptor;
		yourself
]

{ #category : #'as yet unclassified' }
DatasetRow class >> on: anArray descriptor: aDescriptor [
	^ self new
		initializeWithData: anArray 
		withDescriptor: aDescriptor;
		yourself
]

{ #category : #initialization }
DatasetRow >> data [
	^ data
]

{ #category : #accessing }
DatasetRow >> descriptor [
	^ descriptor
]

{ #category : #exporting }
DatasetRow >> exportCSVOn: ws [
	1 to: data size - 1 do: [ :idx | 
		(data at: idx) exportCSVOn: ws.
		ws nextPut: $, ].
	data last exportCSVOn: ws
]

{ #category : #initialization }
DatasetRow >> initialize [
	super initialize.
	data := OrderedCollection new
]

{ #category : #'as yet unclassified' }
DatasetRow >> initializeWithData: anArray withDescriptor: aDescriptor [
	descriptor := aDescriptor.

	1 to: anArray size do: [ :idx | data addLast: ((Datum value: (anArray at: idx) describedBy: (descriptor columnAt: idx)) ) ]
]

{ #category : #splitjoin }
DatasetRow >> join: anotherRow [
	^self join: anotherRow descriptor: anotherRow descriptor
]

{ #category : #accessing }
DatasetRow >> join: anotherRow descriptor: anotherDescriptor [
	"| joinDatasetValues |
	joinDatasetValues := OrderedCollection new.
	1 to: data size do: [ :idx | joinDatasetValues addLast: data , anotherRow data ].
	self class
		on: joinDatasetValues asArray
		descriptor: (descriptor join: anotherDescriptor)"
		
	^self class
		datumCollection: (data , anotherRow data) 
		descriptor: (descriptor join: anotherDescriptor)
]

{ #category : #'as yet unclassified' }
DatasetRow >> setDatumCollection: anArray withDescriptor: aDescriptor [
	descriptor := aDescriptor.

	1 to: anArray size do: [ :idx | data addLast: (anArray at: idx) ]
]

{ #category : #initialization }
DatasetRow >> subDatasetRowWithDescriptor: subDescriptor [
	| subDatasetValues |
	subDatasetValues := subDescriptor columnNames
		collect: [ :each | data at: (descriptor indexOfColumn: each) ].
	self class on: subDatasetValues descriptor: subDescriptor
]

{ #category : #'as yet unclassified' }
DatasetRow >> valueAtIndex: aNumber [
	^ data at: aNumber
]

{ #category : #accessing }
DatasetRow >> valueAtName: aString [
	^ data at: (descriptor indexOfColumn: aString)
]
