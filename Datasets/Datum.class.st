Class {
	#name : #Datum,
	#superclass : #Object,
	#instVars : [
		'value',
		'descriptor'
	],
	#category : #'Datasets-Core'
}

{ #category : #'as yet unclassified' }
Datum class >> value: anObject describedBy: anAssociation [
	^ self new
		value: anObject
			descriptor: (DatumDescriptor name: anAssociation key type: anAssociation value);
		yourself
]

{ #category : #'as yet unclassified' }
Datum class >> value: anObject descriptor: datumDescriptor [
	^ self new
		value: anObject descriptor: datumDescriptor;
		yourself
]

{ #category : #'as yet unclassified' }
Datum >> equalValue: anObject [
	^ value = anObject value
]

{ #category : #exporting }
Datum >> exportCSVOn: aWriteStream [
	value printOn: aWriteStream
]

{ #category : #evaluating }
Datum >> value [
	^ value
]

{ #category : #accessing }
Datum >> value: anObject descriptor: datumDescriptor [
	value := anObject.
	descriptor := datumDescriptor
]
