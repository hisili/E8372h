

#ifndef __DRV_OTHERS_H__
#define __DRV_OTHERS_H__

#include "drv_comm.h"
#include "drv_others.h"


/*************************Build优化 START*****************************/




/*************************OAM组件新增接口 START***********************/













/*产线版本写SDT信息的文件系统的分区名*/
#define MANUFACTURE_ROOT_PATH "/manufacture"






/*************************OAM组件新增接口 END*************************/

/************************ Build优化 END*******************************/


#if defined(BSP_CORE_MODEM)
/*****************************************************************************
 函 数 名  : BSP_DMB_INSTRUCTION
 功能描述  : DMB接口，DSP调用
 输入参数  : 无
 输出参数  : 无
 返 回 值  : 无
*****************************************************************************/
#define BSP_DMB_INSTRUCTION \
{\
    __asm("STMFD r13!, {r0}");\
    __asm("MOV r0, #0");\
    __asm("MCR p15, 0, r0, c7, c10, 5");\
    __asm("LDMIA r13!, {r0}");\
}
#define DRV_DMB_INSTRUCTION() BSP_DMB_INSTRUCTION
#endif

#endif

