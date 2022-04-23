/**************************************************************************/
/*                                                                        */
/*  Module:  RTKernel                              Copyright (c) 1989,94  */
/*  Version: 4.0                                 On Time Informatik GmbH  */
/*                                                                        */
/*                                                                        */
/*                                      On Time        /úúúúúúúúúúú/ÄÄÄÄÄ */
/*                                    Informatik GmbH /úúúúúúúúúúú/       */
/* ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ/úúúúúúúúúúú/        */
/*                                  Echtzeit- und Systemsoftware          */
/*                                                                        */
/**************************************************************************/

/* This include file defines some compiler and memory model dependent macros
*/

#ifdef __DPMI16__
   #define DPMI
#elif defined(DPMI)
   #define __DPMI16__
#endif

#ifndef _COMPILER_H
#define _COMPILER_H

#ifdef _MSC_VER

   #ifdef M_I86TM
      #define LCODE 0
      #define LDATA 0
   #elif M_I86SM
      #define LCODE 0
      #define LDATA 0
   #elif M_I86MM
      #define LCODE 1
      #define LDATA 0
   #elif M_I86CM
      #define LCODE 0
      #define LDATA 1
   #elif M_I86LM
      #define LCODE 1
      #define LDATA 1
   #elif M_I86HM
      #define LCODE 1
      #define LDATA 1
   #else
      #error RTKernel error: Unable to determine memory model
   #endif

   #include <conio.h>
   #define ASM      _asm
   #define IN(P)    inp(P)
   #define OUT(P,V) outp(P,V)
   #define SETVECT  _dos_setvect
   #define GETVECT  _dos_getvect
   #pragma intrinsic(inp, outp)        /* required for protected mode */

   typedef union {
      struct { unsigned int  es, ds, di, si, bp, sp;
	       unsigned int  bx, dx, cx, ax;
	       unsigned int  ip, cs, flags; } X;
      struct { unsigned int  es, ds, di, si, bp, sp;
	       unsigned char bl, bh, dl, dh, cl, ch, al, ah;
	       unsigned int  ip, cs, flags; } x;
   } Regs;

#elif defined __TURBOC__

   #if __TINY__
      #define LCODE 0
      #define LDATA 0
   #elif __SMALL__
      #define LCODE 0
      #define LDATA 0
   #elif __MEDIUM__
      #define LCODE 1
      #define LDATA 0
   #elif __COMPACT__
      #define LCODE 0
      #define LDATA 1
   #elif __LARGE__
      #define LCODE 1
      #define LDATA 1
   #elif __HUGE__
      #define LCODE 1
      #define LDATA 1
   #else
      #error RTKernel error: Unable to determine memory model
   #endif

   #define ASM      asm
   #define IN(P)    inportb(P)
   #define OUT(P,V) outportb(P,V)
   #define SETVECT  setvect
   #define GETVECT  getvect

   typedef union {
      struct { unsigned int  bp, di, si, ds, es;
	       unsigned int  dx, cx, bx, ax;
	       unsigned int  ip, cs, flags; } X;
      struct { unsigned int  bp, di, si, ds, es;
	       unsigned char dl, dh, cl, ch, bl, bh, al, ah;
	       unsigned int  ip, cs, flags; } x;
   } Regs;
#else
   #error RTKernel error: Unsupported compiler
#endif

#include <dos.h>

#ifndef MK_FP
   #define MK_FP(seg, ofs)  (void far *) (((long) seg << 16) + ofs)
#endif
#ifndef FP_SEG
   #define FP_SEG(fp) ((unsigned) (((long) (fp)) >> 16))
#endif
#ifndef FP_OFF
   #define FP_OFF(fp)  ((unsigned) fp)
#endif

/* the following symbols ease writting memory model independent assember code
*/

#if LDATA
   #define mLES les        /* memory model dependent LES     */
   #define mES  es:        /* memory model dependent ES (ds) */
#else
   #define mLES mov
   #define mES
#endif

#define IntFunc(Name) void far interrupt Name(Regs R)

#if defined(__cplusplus) && defined(__TURBOC__)
   typedef void interrupt (far * ISRPtr)(...);
#else
   typedef void (interrupt far * ISRPtr)();
#endif

typedef void (interrupt far * IRQHandler)(void);

#if !defined( __TTYPES_H) && !defined (__TCOLLECT_H)
   typedef enum     { False, True } bool;
#else
   typedef int      bool;
#endif

#ifdef DRIVER // En el driver se usan otras funciones de vectores
#undef SETVECT
#define SETVECT(IntNo, ptr) \
{ \
	VECTOR far *p = MK_FP(0, IntNo*4); \
	*p = ptr; \
} 
#undef GETVECT
#define GETVECT(IntNo) (*(VECTOR far *) MK_FP(0, IntNo*4))
typedef void interrupt (*VECTOR)();
#endif

#endif
