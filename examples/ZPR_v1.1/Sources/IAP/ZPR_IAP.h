//
//  ZPR_IAP.h
//  IAPExample
//
//  Created by Xc Xu on 11/3/11.
//  Copyright (c) 2011 Break-medai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

extern NSString* kIAPComicProductId; // Upgrade Comic
extern NSString* kIAPRunnerModeProductId; // Super Kicks
extern NSString* kIAPTrampolineProductId; // Trampoline
extern NSString* kIAPComboPackProductId; // Combo Pack

typedef void (*PurchaseSuccessCallback) (SKPaymentTransaction*);
typedef void (*PurchaseFailedCallback) (SKPaymentTransaction*);
typedef void (*RestoreSuccessCallback) (void);
typedef void (*RestoreFailedCallback) (void);

@interface ZPR_IAP : NSObject<SKProductsRequestDelegate, SKPaymentTransactionObserver> {
@private
    BOOL requestedProducts;
    NSMutableDictionary* validProducts;
    SKProductsRequest* productsRequest;
    
    PurchaseSuccessCallback purchaseSuccessCallback;
    PurchaseFailedCallback purchaseFailedCallback;
    RestoreSuccessCallback restoreSuccessCallback;
    RestoreFailedCallback restoreFailedCallback;
}

@property (nonatomic, assign) PurchaseSuccessCallback purchaseSuccessCallback;
@property (nonatomic, assign) PurchaseFailedCallback purchaseFailedCallback;
@property (nonatomic, assign) RestoreSuccessCallback restoreSuccessCallback;
@property (nonatomic, assign) RestoreFailedCallback restoreFailedCallback;

- (id) initWithPurchaseSuccessCallback:(PurchaseSuccessCallback)purchaseSuccess PurchaseFailedCallback:(PurchaseFailedCallback)purchaseFailed;

- (BOOL) isRequestedProducts;
- (void) requestProducts;
- (SKProduct*) getComicProduct;
- (SKProduct*) getRunnerModeProduct;
- (SKProduct*) getTrampolineProduct;
- (SKProduct*) getComboPackProduct;

- (BOOL) canMakePurchases;
- (BOOL) readyToPurchases;
- (BOOL) purchaseComic;
- (BOOL) purchaseRunnerModeWithQuantity:(NSUInteger)quantity;
- (BOOL) purchaseTrampolineWithQuantity:(NSUInteger)quantity;
- (BOOL) purchaseComboPackWithQuantity:(NSUInteger)quantity;

- (BOOL) hasLocalStore;
- (void) restoreLocalStore;
- (void) initLocalStore;
- (BOOL) hasUnlockComicInLocalStore;
- (NSUInteger) quantityRunnerModeInLocalStore;
- (NSUInteger) reduceRunnerModeInLocalStoreWithQuantity:(NSUInteger)quantity;
- (NSUInteger) quantityTrampolineInLocalStore;
- (NSUInteger) reduceTrampolineInLocalStoreWithQuantity:(NSUInteger)quantity;

@end
