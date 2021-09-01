//
//  NSData+AES256.h
//  ZJTSSRMYY
//
//  Created by czc on 2021/8/9.
//  Copyright © 2021 zjjk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)
//NSString *aesKey = @"XwKsGlMcdPMEhR1B";
- (NSData *)aes256_encrypt:(NSString *)key AESKey:(NSString *)aesKey;//加密
- (NSData *)aes256_decrypt:(NSString *)key AESKey:(NSString *)aesKey;//解密


@end
