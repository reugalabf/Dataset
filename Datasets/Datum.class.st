Class {
	#name : #Datum,
	#superclass : #Object,
	#instVars : [
		'value',
		'descriptor'
	],
	#category : #'Datasets-Datum'
}

{ #category : #'as yet unclassified' }
Datum class >> value: anObject descriptor: datumDescriptor [
	^ self new
		value: anObject descriptor: datumDescriptor;
		yourself
]

{ #category : #accessing }
Datum >> value: anObject descriptor: datumDescriptor [
	value := anObject.
	descriptor := datumDescriptor
]
