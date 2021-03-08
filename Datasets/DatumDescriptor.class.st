Class {
	#name : #DatumDescriptor,
	#superclass : #Object,
	#instVars : [
		'name',
		'type'
	],
	#category : #'Datasets-Datum'
}

{ #category : #'instance creation' }
DatumDescriptor class >> name: aString type: aSymbol [
	^ self new
		name: aString type: aSymbol;
		yourself
]

{ #category : #accessing }
DatumDescriptor >> name: aString type: aSymbol [
	name := aString.
	type := aSymbol
]
