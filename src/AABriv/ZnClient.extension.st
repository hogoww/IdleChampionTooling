Extension { #name : #ZnClient }

{ #category : #'*AABriv' }
ZnClient >> addDummyDataParts [
	self
		addPart: 	(ZnMimePart fieldName: 'language_id' value: '1');
		addPart: 	(ZnMimePart fieldName: 'timestamp' value: '0');
		addPart: 	(ZnMimePart fieldName: 'request_id' value: '0');
		addPart: 	(ZnMimePart fieldName: 'network_id' value: '11');
		addPart: 	(ZnMimePart fieldName: 'mobile_client_version' value: '999').
]

{ #category : #'*AABriv' }
ZnClient >> addUserParts [
	self
		addPart: 	self userPart;
		addPart: self userHashPart;
		addPart: self instanceIdPart
]

{ #category : #'*AABriv' }
ZnClient >> addUserPartsFrom: aUserObject [
	self 
		addPart: (ZnMimePart fieldName: 'user_id' value: aUserObject userId);
		addPart: (ZnMimePart fieldName: 'hash' value: aUserObject userHash);
		addPart: 	(ZnMimePart fieldName: 'instance_id' value: aUserObject instanceID)
]
