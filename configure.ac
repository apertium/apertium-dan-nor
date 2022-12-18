AC_PREREQ(2.52)

AC_INIT([Apertium Danish-Norwegian], [1.5.0], [apertium-stuff@lists.sourceforge.net], [apertium-dan-nor], [https://wiki.apertium.org/wiki/Apertium-dan-nor])
AM_INIT_AUTOMAKE
AC_PROG_AWK

PKG_CHECK_MODULES(APERTIUM, apertium >= 3.6.0)
PKG_CHECK_MODULES(LTTOOLBOX, lttoolbox >= 3.5.0)
PKG_CHECK_MODULES(CG3, cg3 >= 1.3.0)
PKG_CHECK_MODULES(APERTIUM_LEX_TOOLS, apertium-lex-tools >= 0.2.2)
PKG_CHECK_MODULES(APERTIUM_RECURSIVE, apertium-recursive >= 1.0.0)
PKG_CHECK_MODULES(APERTIUM_SEPARABLE, apertium-separable >= 0.5.0)

m4_ifdef([AP_CHECK_LING],[],[AC_MSG_ERROR([AP_CHECK_LING not defined, is apertium.m4 in ACLOCAL_PATH? See: https://wiki.apertium.org/wiki/Installation_troubleshooting])])

AP_CHECK_LING([1], [apertium-dan], [0.7.0])
AP_CHECK_LING([2n], [apertium-nno], [1.4.0])
AP_CHECK_LING([2b], [apertium-nob], [1.4.0])

PKG_CHECK_MODULES(REGTEST, apertium-regtest >= 0.0.1, [],
                  [AC_MSG_WARN([Running tests requires apertium-regtest])])

AP_MKINCLUDE

AC_OUTPUT([Makefile])
