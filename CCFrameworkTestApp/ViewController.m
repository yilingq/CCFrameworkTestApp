//
//  ViewController.m
//  CCFrameworkTestApp
//
//  Created by Rodrigo Curiel on 3/17/15.
//  Copyright (c) 2015 Rodrigo Curiel. All rights reserved.
//

#import "ViewController.h"
#import <CreditCardHandler/CreditCardHandler.h>

@interface ViewController () {
  IJCreditCardHandler *_handler;
}

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  _handler = [IJCreditCardHandler alloc];
  [_handler initializeSDK:(int)LEVEL_TRACE];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)startSwipe:(id)sender
{
    NSString *deviceId = [UIDevice currentDevice].identifierForVendor.UUIDString;
    GeneralInfoVO *gi = [[GeneralInfoVO alloc] initWithName :1006 crewId:104 deviceId:deviceId depTime:[NSDate date] fltNum:@"101" origAiport:@"DXB" destAirport:@"YXU"];
//test insert to file
//        double amount = 88.88;
//        TransactionVO *tranemv = nil;
//        tranemv = [[TransactionVO alloc] init];
//        tranemv.itemId = 1002;
//        tranemv.amount = [[NSDecimalNumber alloc] initWithDouble:amount];
//        tranemv.currency = @"GBP";
//        tranemv.paymentType = @"Charge";
//        tranemv.track = @"by4xs9FoObddMGQW2Ri8224WmyxoqzuATPyArbGOSHPHg3gUUIZBbyF8040zhGCBnHX97tRIsxiqPN0/UGR+k+C3aodIA7ficTTS0DPE2D0d4ownWTy5coctCkPZR3op911wsLTg3Ck4gyWz2AkyAtrrCotVSzaWHLAhcP8fQp0sLAVkTiTVCpm3aRREfaDdQ97Ptrf38YE3CdM/SiDq5MCSRxjH0sj2ykLk8RBlEGgj797MbW21FvaDi5W8pBU3QNTQPri/qiVwslUoqXrX66WrqNcZfP9pKDWSHTeHKr7cYOaz7iV2pQGTgSFO1qCT0XzyzIqC+m4hONHiv1IeVw=="; //this data should be from Injenico device by calling Ingenico API
//        tranemv.uniqueTransactionId = [[NSUUID UUID] UUIDString];
//
//        [[PaymentService alloc] InsertTransaction :tranemv :gi];
//end of test insert to file
    
    _handler.GeneralInfomation = gi;
    _handler.SaveTransaction = true;
    if (![_handler StartSwipedTransaction:1
                                                         amt:@"88.88"
                                                    currency:@"USD"
                                                      itemId:1069
                                                     seatNum:@"21C"
                                                   fareClass:@"first"
                                                    ffStatus:@"status"])
    {
        self.txtLog.text = [self.txtLog.text
         stringByAppendingString:@"Device is not connect or time out!\n"];
    }
    if(_handler.IsChipPinCard )
    {
        self.txtLog.text = [self.txtLog.text
         stringByAppendingString:@"Chip/Pin card cannot be swiped!\n"];
    }
    else if(!_handler.IsValidCreditCard)
    {
        [self.txtLog.text
         stringByAppendingString:@"Please use valid credit card!\n"];
    }
    else
    {
        NSString *track = _handler.TrackData3;
        self.txtLog.text = [self.txtLog.text
         stringByAppendingString:
         [NSString stringWithFormat:@"%@\n", track]];
    }
    
}
- (IBAction)startNFC:(id)sender
{
    NSString *deviceId = [UIDevice currentDevice].identifierForVendor.UUIDString;
    GeneralInfoVO *gi = [[GeneralInfoVO alloc] initWithName :1006 crewId:104 deviceId:deviceId depTime:[NSDate date] fltNum:@"101" origAiport:@"DXB" destAirport:@"YXU"];
    
    _handler.GeneralInfomation = gi;
    _handler.SaveTransaction = true;
    if (![_handler StartNFCTransaction:1
                                                      amt:@"88.88"
                                                 currency:@"USD"
                                                   itemId:1069
                                                  seatNum:@"21C"
                                                fareClass:@"first"
                                                 ffStatus:@"status"])
    {
        self.txtLog.text = [self.txtLog.text
         stringByAppendingString:@"Device is not connect or time out!\n"];
    }
    if(_handler.IsChipPinCard )
    {
        self.txtLog.text = [self.txtLog.text
         stringByAppendingString:@"Chip/Pin card cannot be swiped!\n"];
    }
    else if(!_handler.IsValidCreditCard)
    {
        self.txtLog.text = [self.txtLog.text
         stringByAppendingString:@"Please use valid credit card!\n"];
    }
    else
    {
        self.txtLog.text = [self.txtLog.text
         stringByAppendingString:
         [NSString stringWithFormat:@"%@\n", _handler.TrackData3]];
    }
}

- (IBAction)startEMV:(id)sender
{
    NSString *deviceId = [UIDevice currentDevice].identifierForVendor.UUIDString;
    GeneralInfoVO *gi = [[GeneralInfoVO alloc] initWithName :1006 crewId:104 deviceId:deviceId depTime:[NSDate date] fltNum:@"101" origAiport:@"DXB" destAirport:@"YXU"];
    
    _handler.GeneralInfomation = gi;
    _handler.SaveTransaction = true;
    if (![_handler StartEMVTransaction:1
                                                      amt:@"88.88"
                                                 currency:@"USD"
                                                   itemId:1069
                                                  seatNum:@"21C"
                                                fareClass:@"first"
                                                 ffStatus:@"status"])
    {
        [self.txtLog.text
         stringByAppendingString:@"Device is not connect or time out!\n"];
    }
    if ([_handler.EMVInfo.NonEMVConfirmationResponseCode isEqual:@"A"])
    {
        self.txtLog.text = [self.txtLog.text stringByAppendingString:@"Transaction Approved!\n"];
    }
    else if ([_handler.EMVInfo.NonEMVCardPaymentCode isEqual:@"D"])
    {
        self.txtLog.text = [self.txtLog.text
         stringByAppendingString:[_handler GetDeclineReasons:_handler.EMVInfo.EMVCardTerminalVerificationResults]];
    }
    if (_handler.EMVInfo.NonEMVErrorResponseCode.UTF8String > 0)
    {
        self.txtLog.text = [self.txtLog.text
         stringByAppendingString:[_handler GetErrorDescription:_handler.EMVInfo.NonEMVErrorResponseCode]];
    }
}

@end
