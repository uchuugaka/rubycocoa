#import <LibRuby/cocoa_ruby.h>
#import "ocdata_conv.h"
#import <Foundation/Foundation.h>

extern void rbarg_to_nsarg(VALUE rbarg, int octype, void* nsarg, id pool, int index);
extern VALUE nsresult_to_rbresult(int octype, const void* nsresult, id pool);


  /**** constants ****/
// NSString * const NSConnectionReplyMode;
static VALUE
osx_NSConnectionReplyMode(VALUE mdl)
{
  rb_notimplement();
}

// NSString * const NSConnectionDidDieNotification;
static VALUE
osx_NSConnectionDidDieNotification(VALUE mdl)
{
  rb_notimplement();
}

// NSString * const NSFailedAuthenticationException;
static VALUE
osx_NSFailedAuthenticationException(VALUE mdl)
{
  rb_notimplement();
}

// NSString * const NSConnectionDidInitializeNotification;
static VALUE
osx_NSConnectionDidInitializeNotification(VALUE mdl)
{
  rb_notimplement();
}

void init_NSConnection(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSConnectionReplyMode", osx_NSConnectionReplyMode, 0);
  rb_define_module_function(mOSX, "NSConnectionDidDieNotification", osx_NSConnectionDidDieNotification, 0);
  rb_define_module_function(mOSX, "NSFailedAuthenticationException", osx_NSFailedAuthenticationException, 0);
  rb_define_module_function(mOSX, "NSConnectionDidInitializeNotification", osx_NSConnectionDidInitializeNotification, 0);
}
