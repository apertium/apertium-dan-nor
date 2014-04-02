#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.


AC_PREREQ(2.52)

m4_define([required_apertium_version], [3.2.0])
m4_define([required_lttoolbox_version], [3.2.0])

AC_INIT([apertium-dan-nor], [1.0.0], [Jonas Fromseier Mortensen <lst190@alumni.ku.dk>])
AM_INIT_AUTOMAKE([apertium-dan-nor], [1.0.0], no-define)
AC_PROG_LN_S
AC_PROG_AWK
#AC_CONFIG_HEADER([config])

PKG_CHECK_MODULES(APERTIUM,   apertium >= required_apertium_version, [], [PKG_CHECK_MODULES(APERTIUM,   apertium-3.2 >= required_apertium_version)])
PKG_CHECK_MODULES(LTTOOLBOX,   lttoolbox >= required_lttoolbox_version, [], [PKG_CHECK_MODULES(LTTOOLBOX,   lttoolbox-3.2 >= required_lttoolbox_version)])

AC_PATH_PROG(CGCOMP, cg-comp, no)
if test x$ac_cv_path_CGCOMP = x
then
  AC_MSG_ERROR([You don't have cg-comp installed.])
fi
if test x$ac_cv_path_CGPROC = xno
then
  AC_MSG_ERROR([You don't have cg-comp installed.])
fi

AC_PATH_PROG(CGPROC, cg-proc, no)
if test x$ac_cv_path_CGPROC = x
then
  AC_MSG_ERROR([You don't have cg-proc installed.])
fi
if test x$ac_cv_path_CGPROC = xno
then
  AC_MSG_ERROR([You don't have cg-proc installed.])
fi

AC_PATH_PROG(LRXCOMP, lrx-comp, no)
if test x$ac_cv_path_LRXCOMP = x
then
  AC_MSG_ERROR([You don't have lrx-comp installed.])
fi
if test x$ac_cv_path_LRXCOMP = xno
then
  AC_MSG_ERROR([You don't have lrx-comp installed.])
fi

AC_PATH_PROG(LRXPROC, lrx-proc, no)
if test x$ac_cv_path_LRXPROC = x
then
  AC_MSG_ERROR([You don't have lrx-proc installed.])
fi
if test x$ac_cv_path_LRXPROC = xno
then
  AC_MSG_ERROR([You don't have lrx-proc installed.])
fi

AC_PATH_PROG(XSLTPROC, xsltproc, no)
if test x$ac_cv_path_XSLTPROC = x
then
  AC_MSG_ERROR([You don't have xsltproc installed.])
fi
if test x$ac_cv_path_XSLTPROC = xno
then
  AC_MSG_ERROR([You don't have xsltproc installed.])
fi




m4_ifdef([AP_CHECK_LING],[],[AC_MSG_ERROR([AP_CHECK_LING not defined, is apertium.m4 in ACLOCAL_PATH? See: http://wiki.apertium.org/wiki/Installation_troubleshooting])])

AP_CHECK_LING([1], [apertium-dan])
AP_CHECK_LING([2n], [apertium-nno])
AP_CHECK_LING([2b], [apertium-nob])




AC_OUTPUT([Makefile])
