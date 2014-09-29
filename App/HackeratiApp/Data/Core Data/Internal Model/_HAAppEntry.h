// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HAAppEntry.h instead.

#import <CoreData/CoreData.h>

extern const struct HAAppEntryAttributes {
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *company;
	__unsafe_unretained NSString *contentType;
	__unsafe_unretained NSString *copyright;
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *releaseDate;
	__unsafe_unretained NSString *storeLink;
	__unsafe_unretained NSString *summary;
	__unsafe_unretained NSString *title;
} HAAppEntryAttributes;

@interface HAAppEntryID : NSManagedObjectID {}
@end

@interface _HAAppEntry : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) HAAppEntryID* objectID;

@property (nonatomic, strong) NSString* category;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* company;

//- (BOOL)validateCompany:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* contentType;

//- (BOOL)validateContentType:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* copyright;

//- (BOOL)validateCopyright:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* price;

//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* releaseDate;

//- (BOOL)validateReleaseDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* storeLink;

//- (BOOL)validateStoreLink:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* summary;

//- (BOOL)validateSummary:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@end

@interface _HAAppEntry (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCategory;
- (void)setPrimitiveCategory:(NSString*)value;

- (NSString*)primitiveCompany;
- (void)setPrimitiveCompany:(NSString*)value;

- (NSString*)primitiveContentType;
- (void)setPrimitiveContentType:(NSString*)value;

- (NSString*)primitiveCopyright;
- (void)setPrimitiveCopyright:(NSString*)value;

- (NSString*)primitivePrice;
- (void)setPrimitivePrice:(NSString*)value;

- (NSString*)primitiveReleaseDate;
- (void)setPrimitiveReleaseDate:(NSString*)value;

- (NSString*)primitiveStoreLink;
- (void)setPrimitiveStoreLink:(NSString*)value;

- (NSString*)primitiveSummary;
- (void)setPrimitiveSummary:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

@end
