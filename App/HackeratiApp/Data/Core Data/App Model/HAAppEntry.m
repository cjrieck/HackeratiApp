
#import "HAAppEntry.h"

@interface HAAppEntry ()

@end

@implementation HAAppEntry

// Custom logic goes here. Good for modularity and maintainability for future development. Maybe overkill for this project, but definitely good to have in case
- (NSArray *)enumeratedProperties
{
    return @[self.company, self.price, self.contentType, self.category, self.releaseDate, self.summary, self.storeLink, self.copyright];
}

@end
