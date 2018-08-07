//
//  FuctionTools.m
//  taojiamao
//
//  Created by yueyu on 2018/8/7.
//  Copyright © 2018年 yueyu. All rights reserved.
//

#import <Foundation/Foundation.h>






char *formattedLogDate(void)
{
    time_t rawtime;
    struct tm *timeinfo;
    static char buffer [128];
    time (&rawtime);
    timeinfo = localtime (&rawtime);
    strftime (buffer,sizeof(buffer),"%Y-%m-%d %H:%M:%S",timeinfo);
    return buffer;
}
