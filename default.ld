GNU ld (GNU Binutils) 2.25.2
  Supported emulations:
   i386pe
using internal linker script:
==================================================
/* Default linker script, for normal executables */
/* Copyright (C) 2014 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT(pei-i386)
SEARCH_DIR("/usr/i686-pc-cygwin/lib"); SEARCH_DIR("/usr/lib"); SEARCH_DIR("/usr/lib/w32api");
SECTIONS
{
  /* Make the virtual address and file offset synced if the alignment is
     lower than the target page size. */
  . = SIZEOF_HEADERS;
  . = ALIGN(__section_alignment__);
  .text  __image_base__ + ( __section_alignment__ < 0x1000 ? . : __section_alignment__ ) :
  {
     *(.init)
    *(.text)
    *(SORT(.text$*))
     *(.text.*)
     *(.gnu.linkonce.t.*)
    *(.glue_7t)
    *(.glue_7)
     ___CTOR_LIST__ = .; __CTOR_LIST__ = . ;
			LONG (-1);*(.ctors); *(.ctor); *(SORT(.ctors.*));  LONG (0);
     ___DTOR_LIST__ = .; __DTOR_LIST__ = . ;
			LONG (-1); *(.dtors); *(.dtor); *(SORT(.dtors.*));  LONG (0);
     *(.fini)
    /* ??? Why is .gcc_exc here?  */
     *(.gcc_exc)
    PROVIDE (etext = .);
    PROVIDE (_etext = .);
     *(.gcc_except_table)
  }
  /* The Cygwin32 library uses a section to avoid copying certain data
     on fork.  This used to be named ".data".  The linker used
     to include this between __data_start__ and __data_end__, but that
     breaks building the cygwin32 dll.  Instead, we name the section
     ".data_cygwin_nocopy" and explicitly include it after __data_end__. */
  .data BLOCK(__section_alignment__) :
  {
    __data_start__ = . ;
    *(.data)
    *(.data2)
    *(SORT(.data$*))
    *(.jcr)
    __data_end__ = . ;
    *(.data_cygwin_nocopy)
  }
  .rdata BLOCK(__section_alignment__) :
  {
    *(.rdata)
             *(SORT(.rdata$*))
    __rt_psrelocs_start = .;
    *(.rdata_runtime_pseudo_reloc)
    __rt_psrelocs_end = .;
  }
  __rt_psrelocs_size = __rt_psrelocs_end - __rt_psrelocs_start;
  ___RUNTIME_PSEUDO_RELOC_LIST_END__ = .;
  __RUNTIME_PSEUDO_RELOC_LIST_END__ = .;
  ___RUNTIME_PSEUDO_RELOC_LIST__ = . - __rt_psrelocs_size;
  __RUNTIME_PSEUDO_RELOC_LIST__ = . - __rt_psrelocs_size;
  .eh_frame BLOCK(__section_alignment__) :
  {
    *(.eh_frame*)
  }
  .pdata BLOCK(__section_alignment__) :
  {
    *(.pdata)
  }
  .bss BLOCK(__section_alignment__) :
  {
    __bss_start__ = . ;
    *(.bss)
    *(COMMON)
    __bss_end__ = . ;
  }
  .edata BLOCK(__section_alignment__) :
  {
    *(.edata)
  }
  /DISCARD/ :
  {
    *(.debug$S)
    *(.debug$T)
    *(.debug$F)
    *(.drectve)
     *(.note.GNU-stack)
     *(.gnu.lto_*)
  }
  .idata BLOCK(__section_alignment__) :
  {
    /* This cannot currently be handled with grouped sections.
	See pe.em:sort_sections.  */
    SORT(*)(.idata$2)
    SORT(*)(.idata$3)
    /* These zeroes mark the end of the import list.  */
    LONG (0); LONG (0); LONG (0); LONG (0); LONG (0);
    SORT(*)(.idata$4)
    __IAT_start__ = .;
    SORT(*)(.idata$5)
    __IAT_end__ = .;
    SORT(*)(.idata$6)
    SORT(*)(.idata$7)
  }
  .CRT BLOCK(__section_alignment__) :
  {
    ___crt_xc_start__ = . ;
    *(SORT(.CRT$XC*))  /* C initialization */
    ___crt_xc_end__ = . ;
    ___crt_xi_start__ = . ;
    *(SORT(.CRT$XI*))  /* C++ initialization */
    ___crt_xi_end__ = . ;
    ___crt_xl_start__ = . ;
    *(SORT(.CRT$XL*))  /* TLS callbacks */
    /* ___crt_xl_end__ is defined in the TLS Directory support code */
    ___crt_xp_start__ = . ;
    *(SORT(.CRT$XP*))  /* Pre-termination */
    ___crt_xp_end__ = . ;
    ___crt_xt_start__ = . ;
    *(SORT(.CRT$XT*))  /* Termination */
    ___crt_xt_end__ = . ;
  }
  /* Windows TLS expects .tls$AAA to be at the start and .tls$ZZZ to be
     at the end of section.  This is important because _tls_start MUST
     be at the beginning of the section to enable SECREL32 relocations with TLS
     data.  */
  .tls BLOCK(__section_alignment__) :
  {
    ___tls_start__ = . ;
    *(.tls$AAA)
    *(.tls)
    *(.tls$)
    *(SORT(.tls$*))
    *(.tls$ZZZ)
    ___tls_end__ = . ;
  }
  .endjunk BLOCK(__section_alignment__) :
  {
    /* end is deprecated, don't use it */
    PROVIDE (end = .);
    PROVIDE ( _end = .);
     __end__ = .;
  }
  .rsrc BLOCK(__section_alignment__) : SUBALIGN(4)
  {
    *(.rsrc)
    *(.rsrc$*)
  }
  .reloc BLOCK(__section_alignment__) :
  {
    *(.reloc)
  }
  .stab BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.stab)
  }
  .stabstr BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.stabstr)
  }
  /* DWARF debug sections.
     Symbols in the DWARF debugging sections are relative to the beginning
     of the section.  Unlike other targets that fake this by putting the
     section VMA at 0, the PE format will not allow it.  */
  /* DWARF 1.1 and DWARF 2.  */
  .debug_aranges BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_aranges)
  }
  .zdebug_aranges BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_aranges)
  }
  .debug_pubnames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_pubnames)
  }
  .zdebug_pubnames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_pubnames)
  }
  .debug_pubtypes BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_pubtypes)
  }
  .zdebug_pubtypes BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_pubtypes)
  }
  /* DWARF 2.  */
  .debug_info BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_info .gnu.linkonce.wi.*)
  }
  .zdebug_info BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_info .zdebug.gnu.linkonce.wi.*)
  }
  .debug_abbrev BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_abbrev)
  }
  .zdebug_abbrev BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_abbrev)
  }
  .debug_line BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_line)
  }
  .zdebug_line BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_line)
  }
  .debug_frame BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_frame*)
  }
  .zdebug_frame BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_frame*)
  }
  .debug_str BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_str)
  }
  .zdebug_str BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_str)
  }
  .debug_loc BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_loc)
  }
  .zdebug_loc BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_loc)
  }
  .debug_macinfo BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_macinfo)
  }
  .zdebug_macinfo BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_macinfo)
  }
  /* SGI/MIPS DWARF 2 extensions.  */
  .debug_weaknames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_weaknames)
  }
  .zdebug_weaknames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_weaknames)
  }
  .debug_funcnames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_funcnames)
  }
  .zdebug_funcnames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_funcnames)
  }
  .debug_typenames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_typenames)
  }
  .zdebug_typenames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_typenames)
  }
  .debug_varnames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_varnames)
  }
  .zdebug_varnames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_varnames)
  }
  .debug_macro BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_macro)
  }
  .zdebug_macro BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_macro)
  }
  /* DWARF 3.  */
  .debug_ranges BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_ranges)
  }
  .zdebug_ranges BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_ranges)
  }
  /* DWARF 4.  */
  .debug_types BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_types .gnu.linkonce.wt.*)
  }
  .zdebug_types BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_types .gnu.linkonce.wt.*)
  }
}


==================================================
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../crt0.o succeeded
/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../crt0.o
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/crtbegin.o succeeded
/usr/lib/gcc/i686-pc-cygwin/6.3.0/crtbegin.o
attempt to open /cygdrive/c/Users/CHRIST~1.CHI/AppData/Local/Temp/cclBoN4a.o succeeded
/cygdrive/c/Users/CHRIST~1.CHI/AppData/Local/Temp/cclBoN4a.o
attempt to open /usr/lib/w32api/libgcc_s.dll.a failed
attempt to open /usr/lib/w32api/gcc_s.dll.a failed
attempt to open /usr/lib/w32api/libgcc_s.a failed
attempt to open /usr/lib/w32api/gcc_s.lib failed
attempt to open /usr/lib/w32api/cyggcc_s.dll failed
attempt to open /usr/lib/w32api/libgcc_s.dll failed
attempt to open /usr/lib/w32api/gcc_s.dll failed
attempt to open /usr/lib/w32api/libgcc_s.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/libgcc_s.dll.a succeeded
attempt to open /usr/lib/w32api/libgcc.dll.a failed
attempt to open /usr/lib/w32api/gcc.dll.a failed
attempt to open /usr/lib/w32api/libgcc.a failed
attempt to open /usr/lib/w32api/gcc.lib failed
attempt to open /usr/lib/w32api/cyggcc.dll failed
attempt to open /usr/lib/w32api/libgcc.dll failed
attempt to open /usr/lib/w32api/gcc.dll failed
attempt to open /usr/lib/w32api/libgcc.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/libgcc.dll.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/gcc.dll.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/libgcc.a succeeded
attempt to open /usr/lib/w32api/libcygwin.dll.a failed
attempt to open /usr/lib/w32api/cygwin.dll.a failed
attempt to open /usr/lib/w32api/libcygwin.a failed
attempt to open /usr/lib/w32api/cygwin.lib failed
attempt to open /usr/lib/w32api/cygcygwin.dll failed
attempt to open /usr/lib/w32api/libcygwin.dll failed
attempt to open /usr/lib/w32api/cygwin.dll failed
attempt to open /usr/lib/w32api/libcygwin.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/libcygwin.dll.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/cygwin.dll.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/libcygwin.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/cygwin.lib failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/cygcygwin.dll failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/libcygwin.dll failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/cygwin.dll failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/libcygwin.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../../i686-pc-cygwin/lib/libcygwin.dll.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../../i686-pc-cygwin/lib/cygwin.dll.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../../i686-pc-cygwin/lib/libcygwin.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../../i686-pc-cygwin/lib/cygwin.lib failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../../i686-pc-cygwin/lib/cygcygwin.dll failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../../i686-pc-cygwin/lib/libcygwin.dll failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../../i686-pc-cygwin/lib/cygwin.dll failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../../i686-pc-cygwin/lib/libcygwin.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.dll.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../cygwin.dll.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a succeeded
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d000026.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d000071.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d000081.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d001196.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d001612.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)t-d000026.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)t-d000071.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)t-d000081.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)t-d001196.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)t-d001612.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)cygwin_crt0.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)premain0.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)premain1.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)premain2.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)premain3.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d000000.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d000204.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d002277.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)_cygwin_crt0_common.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)dll_entry.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)dll_main.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)pseudo-reloc-dummy.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d000389.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d000810.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d000940.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d000942.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d001137.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d001470.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d001577.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d001755.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)t-d000810.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)t-d000940.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)t-d000942.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)t-d001137.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)t-d001470.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)t-d001577.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)t-d001755.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)cygwin_attach_dll.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)d000964.o
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../libcygwin.a)t-d000964.o
attempt to open /usr/lib/w32api/libadvapi32.dll.a failed
attempt to open /usr/lib/w32api/advapi32.dll.a failed
attempt to open /usr/lib/w32api/libadvapi32.a succeeded
attempt to open /usr/lib/w32api/libshell32.dll.a failed
attempt to open /usr/lib/w32api/shell32.dll.a failed
attempt to open /usr/lib/w32api/libshell32.a succeeded
attempt to open /usr/lib/w32api/libuser32.dll.a failed
attempt to open /usr/lib/w32api/user32.dll.a failed
attempt to open /usr/lib/w32api/libuser32.a succeeded
attempt to open /usr/lib/w32api/libkernel32.dll.a failed
attempt to open /usr/lib/w32api/kernel32.dll.a failed
attempt to open /usr/lib/w32api/libkernel32.a succeeded
(/usr/lib/w32api/libkernel32.a)dycps00810.o
(/usr/lib/w32api/libkernel32.a)dycps00582.o
(/usr/lib/w32api/libkernel32.a)dycps00534.o
(/usr/lib/w32api/libkernel32.a)dycps00357.o
(/usr/lib/w32api/libkernel32.a)dycph.o
(/usr/lib/w32api/libkernel32.a)dycpt.o
attempt to open /usr/lib/w32api/libgcc_s.dll.a failed
attempt to open /usr/lib/w32api/gcc_s.dll.a failed
attempt to open /usr/lib/w32api/libgcc_s.a failed
attempt to open /usr/lib/w32api/gcc_s.lib failed
attempt to open /usr/lib/w32api/cyggcc_s.dll failed
attempt to open /usr/lib/w32api/libgcc_s.dll failed
attempt to open /usr/lib/w32api/gcc_s.dll failed
attempt to open /usr/lib/w32api/libgcc_s.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/libgcc_s.dll.a succeeded
attempt to open /usr/lib/w32api/libgcc.dll.a failed
attempt to open /usr/lib/w32api/gcc.dll.a failed
attempt to open /usr/lib/w32api/libgcc.a failed
attempt to open /usr/lib/w32api/gcc.lib failed
attempt to open /usr/lib/w32api/cyggcc.dll failed
attempt to open /usr/lib/w32api/libgcc.dll failed
attempt to open /usr/lib/w32api/gcc.dll failed
attempt to open /usr/lib/w32api/libgcc.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/libgcc.dll.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/gcc.dll.a failed
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/libgcc.a succeeded
(/usr/lib/gcc/i686-pc-cygwin/6.3.0/libgcc.a)_ctors.o
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../default-manifest.o succeeded
/usr/lib/gcc/i686-pc-cygwin/6.3.0/../../../default-manifest.o
attempt to open /usr/lib/gcc/i686-pc-cygwin/6.3.0/crtend.o succeeded
/usr/lib/gcc/i686-pc-cygwin/6.3.0/crtend.o
