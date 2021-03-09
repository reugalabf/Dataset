Class {
	#name : #DatasetRow,
	#superclass : #Object,
	#instVars : [
		'data',
		'descriptor'
	],
	#category : #'Datasets-Sources'
}

{ #category : #'as yet unclassified' }
DatasetRow class >> on: anArray descriptor: aDescriptor [
	^ self new
		loadData: anArray 
		withDescriptor: aDescriptor;
		yourself
]

{ #category : #initialization }
DatasetRow >> data [
	^ data
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

{ #category : #accessing }
DatasetRow >> join: anotherRow descriptor: anotherDescriptor [
	"| joinDatasetValues |
	joinDatasetValues := OrderedCollection new.
	1 to: data size do: [ :idx | joinDatasetValues addLast: data , anotherRow data ].
	self class
		on: joinDatasetValues asArray
		descriptor: (descriptor join: anotherDescriptor)"
		
	^self class
		on: (data , anotherRow data) 
		descriptor: (descriptor join: anotherDescriptor)
]

{ #category : #'as yet unclassified' }
DatasetRow >> loadData: anArray withDescriptor: aDescriptor [
	descriptor := aDescriptor.
	1 to: anArray size do: [ :idx | 
		data
			addLast: (Datum  value: ((anArray at: idx) value) describedBy: (descriptor columnAt: idx)) ]
]

{ #category : #initialization }
DatasetRow >> subDatasetRowWithDescriptor: subDescriptor [
	| subDatasetValues |
	subDatasetValues := subDescriptor columnNames
		collect: [ :each | data at: (descriptor indexOfColumn: each) ].
	self class on: subDatasetValues descriptor: subDescriptor
]

{ #category : #accessing }
DatasetRow >> valueAt: aString [
	^ data at: (descriptor indexOfColumn: aString)
]
