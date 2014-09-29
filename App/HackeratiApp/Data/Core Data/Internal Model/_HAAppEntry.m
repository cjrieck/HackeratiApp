// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HAAppEntry.m instead.

#import "_HAAppEntry.h"

const struct HAAppEntryAttributes HAAppEntryAttributes = {
	.category = @"category",
	.company = @"company",
	.contentType = @"contentType",
	.copyright = @"copyright",
	.price = @"price",
	.releaseDate = @"releaseDate",
	.storeLink = @"storeLink",
	.summary = @"summary",
	.title = @"title",
};

@implementation HAAppEntryID
@end

@implementation _HAAppEntry

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"HAAppEntry" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"HAAppEntry";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"HAAppEntry" inManagedObjectContext:moc_];
}

- (HAAppEntryID*)objectID {
	return (HAAppEntryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic category;

@dynamic company;

@dynamic contentType;

@dynamic copyright;

@dynamic price;

@dynamic releaseDate;

@dynamic storeLink;

@dynamic summary;

@dynamic title;

@end

