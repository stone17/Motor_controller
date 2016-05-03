//---------------------------------------------------------------------------
//    condefs.h - defines needed by Borland C++ Builder console apps
//---------------------------------------------------------------------------
// 1.1
//-------------------------------------------------------------------------
// Copyright (c) 1997, 2002 Borland Software Corporation 
//----------------------------------------------------------------------------
#ifndef CONDEFS_H
#define CONDEFS_H
// CS160 modifications - Curt Hill - This is for CBuilder 2007

//  Permanent fstream inclusion - this also guarantees iostream and iomanip

 #ifndef __FSTREAM_H

   #include <fstream.h>

   #include <iostream.h>

   #include <iomanip.h>

   #endif

//  Permanent AnsiString inclusion

 #ifndef DSTRING_H

   // //#include <vcl\system.hpp>

   #endif

/* getline

     this cannot be a member of istream without that header being modified

     thus make it standalone function

*/
/*

inline void getline(istream & inf, AnsiString & s, int len=256, char delim='\n'){

  char * line;

  line = new char [len+10];

  inf.getline(line,len,delim);

  s = line;

  delete [] line;

  }    
*/

//  Definition of delay function so console apps do not disappear so fast

#include <stdio.h>

inline void __fastcall delay(){

  char c[100];
  _flushall(); 

  printf("\nPress return to continue...\n");

  gets(c);

  return;

  }

// end of CS160 modifications


//---------------------------------------------------------------------------
#if defined(_NO_VCL)

#define USEUNIT(ModName) \
   extern DummyThatIsNeverReferenced
//-----------------------------------------------------------------------
#define USEOBJ(FileName) \
   extern DummyThatIsNeverReferenced
//-----------------------------------------------------------------------
#define USERC(FileName) \
   extern DummyThatIsNeverReferenced
//-----------------------------------------------------------------------
#define USEASM(FileName) \
   extern DummyThatIsNeverReferenced
//-----------------------------------------------------------------------
#define USEDEF(FileName) \
   extern DummyThatIsNeverReferenced
//-----------------------------------------------------------------------
#define USERES(FileName) \
   extern DummyThatIsNeverReferenced
//-----------------------------------------------------------------------
#define USETLB(FileName) \
   extern DummyThatIsNeverReferenced
//-----------------------------------------------------------------------
#define USELIB(FileName) \
   extern DummyThatIsNeverReferenced
//-----------------------------------------------------------------------
#define USEFILE(FileName) \
   extern DummyThatIsNeverReferenced
//-----------------------------------------------------------------------
#define USEIDL(FileName) \
   extern DummyThatIsNeverReferenced
//-----------------------------------------------------------------------
#define USE(FileName, ContainerID) \
   extern DummyThatIsNeverReferenced
//-----------------------------------------------------------------------
#else // _NO_VCL
 // # include <vcl.h>
#endif // _NO_VCL

#endif // CONDEFS_H
