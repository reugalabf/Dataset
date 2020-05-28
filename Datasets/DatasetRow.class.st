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
		setData: anArray;
		setDescriptor: aDescriptor;
		yourself
]

{ #category : #exporting }
DatasetRow >> exportCSVOn: ws [
	
	1 to: data size - 1 do: [ :idx | 
		ws
			nextPutAll: (data at: idx) printString;
			nextPut: $, ].
	ws
		nextPutAll: data last printString;
		cr.
	^ ws contents
]

{ #category : #initialization }
DatasetRow >> setData: anArray [
	data := anArray
]

{ #category : #initialization }
DatasetRow >> setDescriptor: aDescriptor [
	descriptor := aDescriptor
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
