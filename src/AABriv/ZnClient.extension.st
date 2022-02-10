Extension { #name : #ZnClient }

{ #category : #'*AABriv' }
ZnClient >> addDummyDataPart [
	self
		addPart: 	(ZnMimePart fieldName: 'language_id' value: '1');
		addPart: 	(ZnMimePart fieldName: 'timestamp' value: '0');
		addPart: 	(ZnMimePart fieldName: 'request_id' value: '0');
		addPart: 	(ZnMimePart fieldName: 'network_id' value: '11');
		addPart: 	(ZnMimePart fieldName: 'mobile_client_version' value: '999').
]
