//
//  JLJBIGEnCoder.c
//  JLPay
//
//  Created by jielian on 16/7/26.
//  Copyright © 2016年 ShenzhenJielian. All rights reserved.
//

#include "JLJBIGEnCoder.h"

#include "jbig.h"

#include <stdlib.h>
#include <string.h>
#include <assert.h>

/* used for determining output file length */
unsigned long total_length = 0;
unsigned char* pbmJbigEncoded = NULL;

// 编码完成标志
static int hasBeenEncoded = 0;

unsigned char* pbmTransferFromBmp(unsigned char* bitmapStr, size_t width, size_t height, size_t totalSize);
void jbigEncode(unsigned char* pbmStr, size_t width, size_t height);


static void data_out(unsigned char *start, size_t len, void *file)
{
    if (len == 1) {
        printf("\n-------------------=len[%ld]--------=buf[0]=[%x]\n",len, start[0]);
    } else {
        printf("\n-------------------=len[%ld]--------=buf[0]=[%x],buf[1]=[%x]\n",len, start[0], start[1]);
    }
    
    if (len == 1 && start[0] == 0xee) {
        hasBeenEncoded = 1;
        printf("--=--=-== 已接收到编码结束符:0xee\n");
        return;
    }
    
    total_length += len;

    if (pbmJbigEncoded == NULL) {
        pbmJbigEncoded = malloc(total_length);
    } else {
        pbmJbigEncoded = realloc(pbmJbigEncoded, total_length);
    }
    memcpy(pbmJbigEncoded + total_length - len, start, len);
    return;
}


/* 对 bmp 进行 jbig 编码
 1. bmp 转为 pbm
 2. 对 pbm 进行编码
 */
unsigned char* JLJBIGEncode(unsigned char* bitmapStr, size_t width, size_t height, size_t totalSize, size_t* encodedLen) {

    total_length = 0;
    hasBeenEncoded = 0;
    pbmJbigEncoded = NULL;
    unsigned char* pbmStr = pbmTransferFromBmp(bitmapStr, width, height, totalSize);
    printf("-----已转换好了pbm文件数据:[%s]\n", pbmStr);
    printf("-----正在准备编码jbig文件\n");
//    jbigEncode(pbmStr, width, height);
    printf("-----jbig文件完毕\n");
    free(pbmStr);
    *encodedLen = total_length;
    return pbmJbigEncoded;
}


/* bmp 转为 pbm */
unsigned char* pbmTransferFromBmp(unsigned char* bitmapStr, size_t width, size_t height, size_t totalSize) {
    
    /* 保存转换后的 pbm 串 */
    printf("- - - - - - - - - pbmTransferFromBmp : 0，totalSize / 4 / 8 = [%ld] \n", totalSize / 4 / 8);
    
    unsigned char* pbmStr = (unsigned char*)malloc(totalSize / 4 / 8);
    memset(pbmStr, 0x00, totalSize / 4 / 8);
    
    /* 已转换的字节数 */
    size_t countTransed = 0;
    
    for (int h = 0; h < (int)height; h++) {
        unsigned char pbmChar = 0;
        // 每 4*8 个字节一取,转为 pbm 的一个字节
        for (int w = 0; w < width * 4; w += 4 * 8) {
            pbmChar = 0;
            int start = w;
            // 将 8 个字节转换为 0|1 ，并填充到 pbm 的单字节
            for (int i = 0; i < 8; i++) {
                if (h * width * 4 + start + i * 4 >= totalSize) {
                    break;
                }
                unsigned char curBmpBitChar = *(bitmapStr + h * width * 4 + start + i * 4);
                int tmp = (curBmpBitChar & 0xc0/*0xc0~0xff*/) ? (0/*0xff*/) : (1/*0x00*/);
                if (tmp) {
                    pbmChar = pbmChar | (0x80 >> i);
                }
            }
            memcpy(pbmStr + countTransed, &pbmChar, 1);
            countTransed ++;
        }
    }
    
    return pbmStr;
}

//static struct jbg_enc_state s;


void jbigEncode(unsigned char* pbmStr, size_t width, size_t height) {
    struct jbg_enc_state s;

    printf("0- - - [jbg_enc_init]\n");
    jbg_enc_init(&s, width, height, 1, &pbmStr, data_out, NULL);
    printf("1- - - [jbg_enc_lrlmax]\n");
    jbg_enc_lrlmax(&s, 600, 300);
    printf("2- - - [jbg_enc_lrange]\n");
    jbg_enc_lrange(&s, -1, -1);
    printf("3- - - [jbg_enc_options]\n");
    int options = JBG_TPDON | JBG_TPBON | JBG_DPON;
    int order = JBG_ILEAVE | JBG_SMID;
    jbg_enc_options(&s, order, options, 0, -1, -1);
    printf("4- - - [jbg_enc_out]\n");
    jbg_enc_out(&s);
    printf("5- - - [jbg_enc_free]\n");
    jbg_enc_free(&s);
    return;
}


