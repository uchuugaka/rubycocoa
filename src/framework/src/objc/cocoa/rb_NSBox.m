#import "osx_ruby.h"
#import "ocdata_conv.h"
#import <AppKit/AppKit.h>

extern VALUE oc_err_new (const char* fname, NSException* nsexcp);
extern void rbarg_to_nsarg(VALUE rbarg, int octype, void* nsarg, const char* fname, id pool, int index);
extern VALUE nsresult_to_rbresult(int octype, const void* nsresult, const char* fname, id pool);
static const int VA_MAX = 4;


void init_NSBox(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSNoTitle", INT2NUM(NSNoTitle));
  rb_define_const(mOSX, "NSAboveTop", INT2NUM(NSAboveTop));
  rb_define_const(mOSX, "NSAtTop", INT2NUM(NSAtTop));
  rb_define_const(mOSX, "NSBelowTop", INT2NUM(NSBelowTop));
  rb_define_const(mOSX, "NSAboveBottom", INT2NUM(NSAboveBottom));
  rb_define_const(mOSX, "NSAtBottom", INT2NUM(NSAtBottom));
  rb_define_const(mOSX, "NSBelowBottom", INT2NUM(NSBelowBottom));
  rb_define_const(mOSX, "NSBoxPrimary", INT2NUM(NSBoxPrimary));
  rb_define_const(mOSX, "NSBoxSecondary", INT2NUM(NSBoxSecondary));
  rb_define_const(mOSX, "NSBoxSeparator", INT2NUM(NSBoxSeparator));
  rb_define_const(mOSX, "NSBoxOldStyle", INT2NUM(NSBoxOldStyle));

}