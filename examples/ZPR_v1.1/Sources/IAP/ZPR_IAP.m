//
//  ZPR_IAP.m
//  IAPExample
//
//  Created by Xc Xu on 11/3/11.
//  Copyright (c) 2011 Break-medai. All rights reserved.
//

#import "ZPR_IAP.h"
#import "UIDevice+IdentifierAddition.h"
#import "NSString+MD5Addition.h"

NSString* kIAPComicProductId = IAP_PRODUCT_ID_COMIC;
NSString* kIAPRunnerModeProductId = IAP_PRODUCT_ID_SNEAKERS;
NSString* kIAPTrampolineProductId = IAP_PRODUCT_ID_TRAMPOLINE;
NSString* kIAPComboPackProductId = IAP_PRODUCT_ID_COMBOPACK1;

NSString* kIAPSecretDefaultsKey = @"ZPR_IAP_Secret";
NSString* kIAPComicDefaultKey = @"ZPR_IAP_Comic";
NSString* kIAPRunnerModeDefaultKey = @"ZPR_IAP_RunnerMode";
NSString* kIAPTrampolineDefaultKey = @"ZPR_IAP_Trampoline";

#define ZPR_IAP_RUNNER_MODE_QUANTITY_IN_ONE_PURCHASE 5
#define ZPR_IAP_TRAMPOLINE_QUANTITY_IN_ONE_PURCHASE 3
#define ZPR_IAP_RUNNER_MODE_QUANTITY_IN_ONE_COMBO_PACK_PURCHASE 7
#define ZPR_IAP_TRAMPOLINE_QUANTITY_IN_ONE_COMBO_PACK_PURCHASE 4

@interface ZPR_IAP ()

- (void) recordTransaction:(SKPaymentTransaction *)transaction;
- (void) completeTransaction:(SKPaymentTransaction*) transaction;
- (void) failedTransaction:(SKPaymentTransaction*) transaction;
- (void) restoreTransaction:(SKPaymentTransaction*) transaction;

- (BOOL) checkSecret;
- (void) writeSecret;

@end

@implementation ZPR_IAP

@synthesize purchaseSuccessCallback;
@synthesize purchaseFailedCallback;
@synthesize restoreSuccessCallback;
@synthesize restoreFailedCallback;

- (id) init
{
    if ((self = [super init])) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        return self;
    }
    return nil;
}

- (id) initWithPurchaseSuccessCallback:(PurchaseSuccessCallback)purchaseSuccess PurchaseFailedCallback:(PurchaseFailedCallback)purchaseFailed
{
    purchaseSuccessCallback = purchaseSuccess;
    purchaseFailedCallback = purchaseFailed;
    
    return [self init];
}

- (void) dealloc
{
    if (productsRequest) {
        [productsRequest cancel];
        [productsRequest autorelease];
    }
    [validProducts release];
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    
    [super dealloc];
}

#pragma mark - Products

- (BOOL) isRequestedProducts
{
    return requestedProducts;
}

- (void) requestProducts
{
    if (productsRequest) {
        [productsRequest cancel];
        [productsRequest autorelease];
    }
    
    requestedProducts = NO;
    
    NSSet *productIdentifiers = [NSSet setWithObjects: 
                                 kIAPComicProductId, 
                                 kIAPRunnerModeProductId, 
                                 kIAPTrampolineProductId, 
                                 kIAPComboPackProductId,
                                 nil];
    productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
	productsRequest.delegate = self;
	[productsRequest start];
    
    [validProducts release];
}

- (SKProduct*) getComicProduct {
    SKProduct* ret = [validProducts objectForKey:kIAPComicProductId];
    
    if (ret == nil)
        NSLog(@"(%@) is invalid product", kIAPComicProductId);
    
    return ret;
}

- (SKProduct*) getRunnerModeProduct
{
    SKProduct* ret = [validProducts objectForKey:kIAPRunnerModeProductId];
    
    if (ret == nil)
        NSLog(@"(%@) is invalid product", kIAPRunnerModeProductId);
    
    return ret;
}

- (SKProduct*) getTrampolineProduct
{
    SKProduct* ret = [validProducts objectForKey:kIAPTrampolineProductId];
    
    if (ret == nil)
        NSLog(@"(%@) is invalid product", kIAPTrampolineProductId);
    
    return ret;
}

- (SKProduct*) getComboPackProduct
{
    SKProduct* ret = [validProducts objectForKey:kIAPComboPackProductId];
    
    if (ret == nil)
        NSLog(@"(%@) is invalid product", kIAPComboPackProductId);
    
    return ret;
}

#pragma mark - Purchases

- (BOOL) canMakePurchases
{
    BOOL ret = [SKPaymentQueue canMakePayments];

    if (ret)
        NSLog(@"ZPR IAP can make purchases");
    else
        NSLog(@"ZPR IAP can not make purchased");
    return ret;
}

- (BOOL) readyToPurchases
{
    BOOL ret = [self canMakePurchases] && [self isRequestedProducts];
    if (!ret) {
        [self requestProducts];
        ret = [SKPaymentQueue canMakePayments];
    }
    if (ret)
        NSLog(@"ZPR IAP ready to purchases");
    else
        NSLog(@"ZPR IAP not ready to purchases");
    return ret;
}

- (BOOL) purchaseComic
{
    if ([self readyToPurchases]) {
        SKProduct* product = [self getComicProduct];
        if (product) {
            SKPayment *payment = [SKPayment paymentWithProduct:product];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
            return YES;
        }
        else {
            return NO;
        }
    }
    else {
        return NO;
    }
}

- (BOOL) purchaseRunnerModeWithQuantity:(NSUInteger)quantity
{
    if ([self readyToPurchases]) {
        SKProduct* product = [self getRunnerModeProduct];
        if (product && quantity > 0) {
            SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
            payment.quantity = quantity;
            [[SKPaymentQueue defaultQueue] addPayment:payment];
            return YES;
        }
        else {
            return NO;
        }
    }
    else {
        return NO;
    }
}

- (BOOL) purchaseTrampolineWithQuantity:(NSUInteger)quantity;
{
    if ([self readyToPurchases]) {
        SKProduct* product = [self getTrampolineProduct];
        if (product && quantity > 0) {
            SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
            payment.quantity = quantity;
            [[SKPaymentQueue defaultQueue] addPayment:payment];
            return YES;
        }
        else {
            return NO;
        }
    }
    else {
        return NO;
    }
}

- (BOOL) purchaseComboPackWithQuantity:(NSUInteger)quantity;
{
    if ([self readyToPurchases]) {
        SKProduct* product = [self getComboPackProduct];
        if (product && quantity > 0) {
            SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
            payment.quantity = quantity;
            [[SKPaymentQueue defaultQueue] addPayment:payment];
            return YES;
        }
        else {
            return NO;
        }
    }
    else {
        return NO;
    }
}

#pragma mark - LocalStore

- (BOOL) hasLocalStore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *secretValue = [defaults objectForKey:kIAPSecretDefaultsKey];
    
    if (secretValue == nil) {
        NSLog(@"no ZPR IAP local store");
        return NO;
    }
    else {
        return [self checkSecret];
    }
}

- (void) restoreLocalStore
{
    [self initLocalStore];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    NSLog(@"ZPR IAP restore local store start");
}

- (void) initLocalStore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kIAPComicDefaultKey];
    [defaults removeObjectForKey:kIAPRunnerModeDefaultKey];
    [defaults removeObjectForKey:kIAPTrampolineDefaultKey];
    [defaults synchronize];
    NSLog(@"ZPR IAP init local store");
}

- (BOOL) hasUnlockComicInLocalStore
{
#ifdef CHEAT_BUYLOCK
    return YES;
#else
    if ([self checkSecret]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        BOOL unlocked = [[defaults objectForKey:kIAPComicDefaultKey] boolValue];
        return unlocked;
    }
    else {
        return NO;
    }
#endif
}

- (NSUInteger) quantityRunnerModeInLocalStore
{
    if ([self checkSecret]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSUInteger quantity = [[defaults objectForKey:kIAPRunnerModeDefaultKey] unsignedIntegerValue];
        return quantity;
    }
    else {
        return 0;
    }    
}

- (NSUInteger) reduceRunnerModeInLocalStoreWithQuantity:(NSUInteger)quantity
{
    if ([self checkSecret]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSUInteger quantityValue = [[defaults objectForKey:kIAPRunnerModeDefaultKey] unsignedIntegerValue];
        NSInteger tmp = (NSInteger)quantityValue - (NSInteger)quantity;
        if (tmp < 0)
            quantityValue = 0;
        else
            quantityValue -= quantity;
        [defaults setValue:[NSNumber numberWithUnsignedInteger:quantityValue] forKey:kIAPRunnerModeDefaultKey];
        [defaults synchronize];
        return quantityValue;
    }
    else {
        return 0;
    }    
}

- (NSUInteger) quantityTrampolineInLocalStore
{
    if ([self checkSecret]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSUInteger quantity = [[defaults objectForKey:kIAPTrampolineDefaultKey] unsignedIntegerValue];
        return quantity;
    }
    else {
        return 0;
    }
}

- (NSUInteger) reduceTrampolineInLocalStoreWithQuantity:(NSUInteger)quantity
{
    if ([self checkSecret]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSUInteger quantityValue = [[defaults objectForKey:kIAPTrampolineDefaultKey] unsignedIntegerValue];
        NSInteger tmp = (NSInteger)quantityValue - (NSInteger)quantity;
        if (tmp < 0)
            quantityValue = 0;
        else
            quantityValue -= quantity;
        [defaults setValue:[NSNumber numberWithUnsignedInteger:quantityValue] forKey:kIAPTrampolineDefaultKey];
        [defaults synchronize];
        return quantityValue;
    }
    else {
        return 0;
    }
}

#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"ZPR IAP received products response");
    
    if (response.products.count > 0) {
        validProducts = [[NSMutableDictionary alloc] init];
        for (SKProduct* product in response.products) {
            [validProducts setObject:product forKey:product.productIdentifier];
            NSLog(@"ZPR IAP received product id:%@", product.productIdentifier);
        }
    }
    
    if (response.invalidProductIdentifiers.count > 0) {
        for (NSString* invalidProductID in response.invalidProductIdentifiers) {
            NSLog(@"ZPR IAP received INVALID product id:%@", invalidProductID);
        }
    }
    
    [request autorelease];
    productsRequest = nil;
    
    requestedProducts = YES;
}

#pragma  mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchasing:
                
                break;
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    } 
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    NSLog(@"ZPR IAP restore comleted transactions failed with message %@", [error localizedDescription]);
    
    if (restoreFailedCallback)
        restoreFailedCallback();
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    [self writeSecret];
    NSLog(@"ZPR IAP restore local store finished");
    
    if (restoreSuccessCallback)
        restoreSuccessCallback();
}

#pragma mark - ZPR_IAP ()

- (void)recordTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"ZPR IAP record %@", transaction.payment.productIdentifier);
    
    if ([transaction.payment.productIdentifier isEqualToString:kIAPComicProductId]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:[NSNumber numberWithBool:YES] forKey:kIAPComicDefaultKey];
        [defaults synchronize];
    }
    else if ([transaction.payment.productIdentifier isEqualToString:kIAPRunnerModeProductId]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSUInteger quantity = [[defaults objectForKey:kIAPRunnerModeDefaultKey] unsignedIntegerValue];
        quantity += transaction.payment.quantity * ZPR_IAP_RUNNER_MODE_QUANTITY_IN_ONE_PURCHASE;
        [defaults setValue:[NSNumber numberWithUnsignedInteger:quantity] forKey:kIAPRunnerModeDefaultKey];
        [defaults synchronize];
    }
    else if ([transaction.payment.productIdentifier isEqualToString:kIAPTrampolineProductId]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSUInteger quantity = [[defaults objectForKey:kIAPTrampolineDefaultKey] unsignedIntegerValue];
        quantity += transaction.payment.quantity * ZPR_IAP_TRAMPOLINE_QUANTITY_IN_ONE_PURCHASE;
        [defaults setValue:[NSNumber numberWithUnsignedInteger:quantity] forKey:kIAPTrampolineDefaultKey];
        [defaults synchronize];
    }
    else if ([transaction.payment.productIdentifier isEqualToString:kIAPComboPackProductId]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSUInteger quantity = [[defaults objectForKey:kIAPRunnerModeDefaultKey] unsignedIntegerValue];
        quantity += transaction.payment.quantity * ZPR_IAP_RUNNER_MODE_QUANTITY_IN_ONE_COMBO_PACK_PURCHASE;
        [defaults setValue:[NSNumber numberWithUnsignedInteger:quantity] forKey:kIAPRunnerModeDefaultKey];
        
        quantity = [[defaults objectForKey:kIAPTrampolineDefaultKey] unsignedIntegerValue];
        quantity += transaction.payment.quantity * ZPR_IAP_TRAMPOLINE_QUANTITY_IN_ONE_COMBO_PACK_PURCHASE;
        [defaults setValue:[NSNumber numberWithUnsignedInteger:quantity] forKey:kIAPTrampolineDefaultKey];
        
        [defaults synchronize];
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void) completeTransaction:(SKPaymentTransaction*) transaction
{
    NSLog(@"ZPR IAP payment (%@) transactions complete", transaction.payment.productIdentifier);
    
    if ([self checkSecret] == NO) {
        [self writeSecret];
        [self initLocalStore];
    }
    
    [self recordTransaction:transaction];
    
    if (purchaseSuccessCallback)
        purchaseSuccessCallback(transaction);
}

- (void) failedTransaction:(SKPaymentTransaction*) transaction
{
    NSLog(@"ZPR IAP payment (%@) transactions failed with message %@ code %i", transaction.payment.productIdentifier, transaction.error.localizedDescription,transaction.error.code);
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    if (purchaseFailedCallback)
        purchaseFailedCallback(transaction);
}

- (void) restoreTransaction:(SKPaymentTransaction*) transaction
{
    NSLog(@"ZPR IAP payment (%@) transactions restore", transaction.payment.productIdentifier);
    [self recordTransaction:transaction];
}

- (BOOL) checkSecret
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *secretValue = [defaults objectForKey:kIAPSecretDefaultsKey];
    
    if (secretValue) {
        NSString* secret = [[[UIDevice currentDevice] uniqueDeviceIdentifier] stringFromMD5];
        if ([secretValue isEqualToString:secret]) {
            NSLog(@"ZPR IAP secret check success");
            return YES;
        }
        else {
            NSLog(@"ZPR IAP secret check fail");
            return NO;
        }
    }
    else {
        NSLog(@"no ZPR IAP secret");
        return NO;
    }
}

- (void) writeSecret
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* secret = [[[UIDevice currentDevice] uniqueDeviceIdentifier] stringFromMD5];
    [defaults setObject:secret forKey:kIAPSecretDefaultsKey];
    [defaults synchronize];
    NSLog(@"write ZPR IAP secret");
}

@end
