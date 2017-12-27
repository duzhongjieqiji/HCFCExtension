//
//  NSData+MD5Digest.m
//  NSData+MD5Digest
//
//  Created by Francis Chong on 12年6月5日.
//

#import "NSData+MD5Digest.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (MD5Digest)

+(NSData *)MD5Digest:(NSData *)input {
    
    // NOTE: CC_MD5只支持32bit长度，如果input长度超出，返回nil
    //       一个NSData的长度超过UINT32_MAX，那也是醉了。。。
    if (input.length > UINT32_MAX) {
        assert(0);
        return nil;
    }
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];

    CC_MD5(input.bytes, (CC_LONG)input.length, result);
    return [[NSData alloc] initWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

-(NSData *)MD5Digest {
    return [NSData MD5Digest:self];
}

+(NSString *)MD5HexDigest:(NSData *)input {
    
    // NOTE: CC_MD5只支持32bit长度，如果input长度超出，返回nil
    //       一个NSData的长度超过UINT32_MAX，那也是醉了。。。
    if (input.length > UINT32_MAX) {
        assert(0);
        return nil;
    }
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];

    CC_MD5(input.bytes, (CC_LONG)input.length, result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

-(NSString *)MD5HexDigest {
    return [NSData MD5HexDigest:self];
}

@end
