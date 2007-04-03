/** -*- mode:objc; indent-tabs-mode:nil; coding:utf-8 -*-
 *
 *  internal_macros.h
 *  RubyCocoa
 *
 *  Copyright (c) 2007 Fujimoto Hisa
 *
 *  $Id$
 *
 **/

#ifndef _INTERNAL_MACROS_H_
#define _INTERNAL_MACROS_H_

#import <Foundation/NSAutoreleasePool.h>
#import <Foundation/NSString.h>

#define RUBYCOCOA_SUPPRESS_EXCEPTION_LOGGING_P \
  RTEST(rb_gv_get("RUBYCOCOA_SUPPRESS_EXCEPTION_LOGGING"))

extern VALUE rubycocoa_debug;

#define RUBY_DEBUG_P      RTEST(ruby_debug)
#define RUBYCOCOA_DEBUG_P RTEST(rubycocoa_debug)
#define DEBUG_P           (RUBY_DEBUG_P || RUBYCOCOA_DEBUG_P)

#define ASSERT_ALLOC(x) do { if (x == NULL) rb_fatal("can't allocate memory"); } while (0)

#define DLOG(mod, fmt, args...)                  \
  do {                                           \
    if (DEBUG_P) {                             \
      NSAutoreleasePool * pool;                  \
      NSString *          nsfmt;                 \
                                                 \
      pool = [[NSAutoreleasePool alloc] init];   \
      nsfmt = [NSString stringWithFormat:        \
        [NSString stringWithFormat:@"%s : %s",   \
          mod, fmt], ##args];                    \
      NSLog(nsfmt);                              \
      [pool release];                            \
    }                                            \
  }                                              \
  while (0)

/* syntax: POOL_DO(the_pool) { ... } END_POOL(the_pool); */
#define POOL_DO(POOL)   { id POOL = [[NSAutoreleasePool alloc] init];
#define END_POOL(POOL)  [(POOL) release]; }

/* flag for calling Init_stack frequently */
extern int rubycocoa_frequently_init_stack();
#define FREQUENTLY_INIT_STACK_FLAG rubycocoa_frequently_init_stack()

#endif	// _INTERNAL_MACROS_H_