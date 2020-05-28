Extension { #name : #NeoCSVReader }

{ #category : #'*Datasets' }
NeoCSVReader >> addDateAndTimeField [
	self addFieldConverter: [ :string | DateAndTime fromString: string ]
]

{ #category : #'*Datasets' }
NeoCSVReader >> addStringField [
	self addField
]
