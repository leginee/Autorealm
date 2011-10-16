unit UnicodeConv;

// UnicodeConv 3.0.0
// Unicode Converter Library 3.0.0
// Delphi 3/4/5/6 and Kylix Implementation
//
// Copyright (c) 2002 by Dieter Köhler
// ("http://www.philo.de/xml/")
//
// Definitions:
// - "Package" refers to the collection of files distributed by
//   the Copyright Holder, and derivatives of that collection of
//   files created through textual modification.
// - "Standard Version" refers to such a Package if it has not
//   been modified, or has been modified in accordance with the
//   wishes of the Copyright Holder.
// - "Copyright Holder" is whoever is name in the copyright or
//   copyrights for the package.
// - "You" is you, if you're thinking about copying or distributing
//   this Package.
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Package"), to deal in the Package without restriction,
// including without limitation the rights to use, copy, modify,
// merge, publish, distribute, sublicense, and/or sell copies of the
// Package, and to permit persons to whom the Package is furnished
// to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Package.
//
// You may modify your copy of this Package in any way, provided
// that you insert a prominent notice in each changed file stating
// how and when you changed a file, and provided that you do at
// least one of the following:
//
// a) allow the Copyright Holder to include your modifications in
// the Standard Version of the Package.
//
// b) use the modified Package only within your corporation or
// organization.
//
// c) rename any non standard executables, units, and classes so
// the names do not conflict with standard executables, units, and
// classes, and provide a separate manual page that clearly documents
// how it differs from the standard version.
//
// d) make other distribution arrangements with the Copyright Holder.
//
// The name of the Copyright Holder may not be used to endorse or
// promote products derived from this Package without specific prior
// written permission.
//
// THE PACKAGE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// PACKAGE OR THE USE OR OTHER DEALINGS IN THE PACKAGE.

interface

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  SysUtils, Classes;

type
  TdomEncodingType = (etUnknown, etUTF_8, etUTF_16BE, etUTF_16LE,
                      etISO_10646_UCS_2, etUS_ASCII,
                      etIso_8859_1, etIso_8859_2, etIso_8859_3, etIso_8859_4,
                      etIso_8859_5, etIso_8859_6, etIso_8859_7, etIso_8859_8,
                      etIso_8859_9, etIso_8859_10, etIso_8859_13, etIso_8859_14,
                      etIso_8859_15, etKOI8_R, etJIS_X0201, etNextStep,
                      etCp10000_MacRoman, etCp10006_MacGreek,
                      etCp10007_MacCyrillic, etCp10029_MacLatin2,
                      etCp10079_MacIcelandic, etCp10081_MacTurkish,
                      etIBM037, etIBM424, etIBM437,
                      etDOS_437, etIBM500, etDOS_737, etDOS_775, etIBM850,
                      etDOS_850, etIBM852, etDOS_852, etIBM855, etDOS_855,
                      etPC_856, etIBM857, etDOS_857, etIBM860, etDOS_860,
                      etIBM861, etDOS_861, etIBM862, etDOS_862, etIBM863,
                      etDOS_863, etIBM864, etDOS_864, etIBM865, etDOS_865,
                      etIBM866, etDOS_866, etIBM869, etDOS_869, etCp874,
                      etCp875, etCp932, etCp936, etCp949, etCp950, etCp1006,
                      etIBM1026, etWindows_1250, etWindows_1251, etWindows_1252,
                      etWindows_1253, etWindows_1254, etWindows_1255,
                      etWindows_1256, etWindows_1257, etWindows_1258);


  TdomEncodingTypes = set of TdomEncodingType;

const
  SINGLE_BYTE_ENCODINGS: TdomEncodingTypes =
                     [etUS_ASCII, etIso_8859_1, etIso_8859_2, etIso_8859_3,
                      etIso_8859_4, etIso_8859_5, etIso_8859_6,etIso_8859_7,
                      etIso_8859_8, etIso_8859_9, etIso_8859_10, etIso_8859_13,
                      etIso_8859_14, etIso_8859_15, etKOI8_R, etJIS_X0201,
                      etNextStep, etCp10000_MacRoman, etCp10006_MacGreek,
                      etCp10007_MacCyrillic, etCp10029_MacLatin2,
                      etCp10079_MacIcelandic, etCp10081_MacTurkish, etIBM037,
                      etIBM424, etIBM437, etDOS_437, etIBM500, etDOS_737,
                      etDOS_775, etIBM850, etDOS_850, etIBM852, etDOS_852,
                      etIBM855, etDOS_855, etPC_856, etIBM857, etDOS_857,
                      etIBM860, etDOS_860, etIBM861, etDOS_861, etIBM862,
                      etDOS_862, etIBM863, etDOS_863, etIBM864, etDOS_864,
                      etIBM865, etDOS_865, etIBM866, etDOS_866, etIBM869,
                      etDOS_869, etCp874, etCp875, etCp932, etCp936, etCp949,
                      etCp950, etCp1006, etIBM1026, etWindows_1250,
                      etWindows_1251, etWindows_1252, etWindows_1253,
                      etWindows_1254, etWindows_1255, etWindows_1256,
                      etWindows_1257, etWindows_1258];

  MULTI_BYTE_ENCODINGS: TdomEncodingTypes =
                     [etUTF_8, etUTF_16BE, etUTF_16LE, etISO_10646_UCS_2];

type
  TCharToUTF16ConvFunc = function(const W: word): WideChar;
  TUTF16ToCharConvFunc = function(const I: longint): Char;

function GetCharToUTF16ConvFunc(Encoding: TdomEncodingType): TCharToUTF16ConvFunc;
function GetUTF16ToCharConvFunc(Encoding: TdomEncodingType): TUTF16ToCharConvFunc;

{$IFNDEF LINUX}
function GetACPEncodingName: String;
function GetACPEncodingType: TdomEncodingType;
{$ENDIF}

type
  EConversionStream = class(EStreamError);

  TConversionStream = class(TStream)
  private
    FTarget: TStream;
    FConvertCount: longint;
    FConvertBufP: pointer;
    FConvertBufSize: longint;
  protected
    function ConvertReadBuffer(const Buffer; Count: longint): longint; virtual;
    function ConvertWriteBuffer(const Buffer; Count: longint): longint; virtual;
    procedure SetConvertBufSize(NewSize: longint); virtual;
  public
    constructor Create(Target: TStream);
    destructor Destroy; override;
    function Read(var Buffer; Count: longint): longint; override;
    function Write(const Buffer; Count: longint): longint; override;
    function Seek(Offset: longint; Origin: word): longint; override;
    procedure FreeConvertBuffer;
    property Target: TStream read FTarget;
    property ConvertBufP: pointer read FConvertBufP;
    property ConvertCount: longint read FConvertCount;
    property ConvertBufSize: longint read FConvertBufSize;
  end;

  TUTF16BEToUTF8Stream = class(TConversionStream)
  protected
    function ConvertWriteBuffer(const Buffer; Count: longint): longint; override;
  end;

  TUTF16BEToSingleByteCharsetStream = class(TConversionStream)
  private
    FTargetEncoding: TdomEncodingType;
    FUTF16ToCharConvFunc: TUTF16ToCharConvFunc;
  protected
    function ConvertWriteBuffer(const Buffer; Count: longint): longint; override;
  public
    constructor Create(Target: TStream; ATargetEncoding: TdomEncodingType);
    property TargetEncoding: TdomEncodingType read FTargetEncoding;
  end;

function EncodingToStr(const Encoding: TdomEncodingType): String;
function StrToEncoding(const S: String): TdomEncodingType;

function SingleByteEncodingToUTF16Char(const W: word; const Encoding: TdomEncodingType): WideChar;

function US_ASCIIToUTF16Char(const W: word): WideChar;
function Iso8859_1ToUTF16Char(const W: word): WideChar;
function Iso8859_2ToUTF16Char(const W: word): WideChar;
function Iso8859_3ToUTF16Char(const W: word): WideChar;
function Iso8859_4ToUTF16Char(const W: word): WideChar;
function Iso8859_5ToUTF16Char(const W: word): WideChar;
function Iso8859_6ToUTF16Char(const W: word): WideChar;
function Iso8859_7ToUTF16Char(const W: word): WideChar;
function Iso8859_8ToUTF16Char(const W: word): WideChar;
function Iso8859_9ToUTF16Char(const W: word): WideChar;
function Iso8859_10ToUTF16Char(const W: word): WideChar;
function Iso8859_13ToUTF16Char(const W: word): WideChar;
function Iso8859_14ToUTF16Char(const W: word): WideChar;
function Iso8859_15ToUTF16Char(const W: word): WideChar;
function KOI8_RToUTF16Char(const W: word): WideChar;
function JIS_X0201ToUTF16Char(const W: word): WideChar;
function nextStepToUTF16Char(const W: word): WideChar;
function cp10000_MacRomanToUTF16Char(const W: word): WideChar;
function cp10006_MacGreekToUTF16Char(const W: word): WideChar;
function cp10007_MacCyrillicToUTF16Char(const W: word): WideChar;
function cp10029_MacLatin2ToUTF16Char(const W: word): WideChar;
function cp10079_MacIcelandicToUTF16Char(const W: word): WideChar;
function cp10081_MacTurkishToUTF16Char(const W: word): WideChar;
function cp037ToUTF16Char(const W: word): WideChar;
function cp424ToUTF16Char(const W: word): WideChar;
function cp437ToUTF16Char(const W: word): WideChar;
function cp437_DOSLatinUSToUTF16Char(const W: word): WideChar;
function cp500ToUTF16Char(const W: word): WideChar;
function cp737_DOSGreekToUTF16Char(const W: word): WideChar;
function cp775_DOSBaltRimToUTF16Char(const W: word): WideChar;
function cp850ToUTF16Char(const W: word): WideChar;
function cp850_DOSLatin1ToUTF16Char(const W: word): WideChar;
function cp852ToUTF16Char(const W: word): WideChar;
function cp852_DOSLatin2ToUTF16Char(const W: word): WideChar;
function cp855ToUTF16Char(const W: word): WideChar;
function cp855_DOSCyrillicToUTF16Char(const W: word): WideChar;
function cp856_Hebrew_PCToUTF16Char(const W: word): WideChar;
function cp857ToUTF16Char(const W: word): WideChar;
function cp857_DOSTurkishToUTF16Char(const W: word): WideChar;
function cp860ToUTF16Char(const W: word): WideChar;
function cp860_DOSPortugueseToUTF16Char(const W: word): WideChar;
function cp861ToUTF16Char(const W: word): WideChar;
function cp861_DOSIcelandicToUTF16Char(const W: word): WideChar;
function cp862ToUTF16Char(const W: word): WideChar;
function cp862_DOSHebrewToUTF16Char(const W: word): WideChar;
function cp863ToUTF16Char(const W: word): WideChar;
function cp863_DOSCanadaFToUTF16Char(const W: word): WideChar;
function cp864ToUTF16Char(const W: word): WideChar;
function cp864_DOSArabicToUTF16Char(const W: word): WideChar;
function cp865ToUTF16Char(const W: word): WideChar;
function cp865_DOSNordicToUTF16Char(const W: word): WideChar;
function cp866ToUTF16Char(const W: word): WideChar;
function cp866_DOSCyrillicRussianToUTF16Char(const W: word): WideChar;
function cp869ToUTF16Char(const W: word): WideChar;
function cp869_DOSGreek2ToUTF16Char(const W: word): WideChar;
function cp874ToUTF16Char(const W: word): WideChar;
function cp875ToUTF16Char(const W: word): WideChar;
function cp932ToUTF16Char(const W: word): WideChar;
function cp936ToUTF16Char(const W: word): WideChar;
function cp949ToUTF16Char(const W: word): WideChar;
function cp950ToUTF16Char(const W: word): WideChar;
function cp1006ToUTF16Char(const W: word): WideChar;
function cp1026ToUTF16Char(const W: word): WideChar;
function cp1250ToUTF16Char(const W: word): WideChar;
function cp1251ToUTF16Char(const W: word): WideChar;
function cp1252ToUTF16Char(const W: word): WideChar;
function cp1253ToUTF16Char(const W: word): WideChar;
function cp1254ToUTF16Char(const W: word): WideChar;
function cp1255ToUTF16Char(const W: word): WideChar;
function cp1256ToUTF16Char(const W: word): WideChar;
function cp1257ToUTF16Char(const W: word): WideChar;
function cp1258ToUTF16Char(const W: word): WideChar;

function US_ASCIIToUTF16Str(const S: string): WideString;
function Iso8859_1ToUTF16Str(const S: string): WideString;
function Iso8859_2ToUTF16Str(const S: string): WideString;
function Iso8859_3ToUTF16Str(const S: string): WideString;
function Iso8859_4ToUTF16Str(const S: string): WideString;
function Iso8859_5ToUTF16Str(const S: string): WideString;
function Iso8859_6ToUTF16Str(const S: string): WideString;
function Iso8859_7ToUTF16Str(const S: string): WideString;
function Iso8859_8ToUTF16Str(const S: string): WideString;
function Iso8859_9ToUTF16Str(const S: string): WideString;
function Iso8859_10ToUTF16Str(const S: string): WideString;
function Iso8859_13ToUTF16Str(const S: string): WideString;
function Iso8859_14ToUTF16Str(const S: string): WideString;
function Iso8859_15ToUTF16Str(const S: string): WideString;
function KOI8_RToUTF16Str(const S: string): WideString;
function JIS_X0201ToUTF16Str(const S: string): WideString;
function nextStepToUTF16Str(const S: string): WideString;
function cp10000_MacRomanToUTF16Str(const S: string): WideString;
function cp10006_MacGreekToUTF16Str(const S: string): WideString;
function cp10007_MacCyrillicToUTF16Str(const S: string): WideString;
function cp10029_MacLatin2ToUTF16Str(const S: string): WideString;
function cp10079_MacIcelandicToUTF16Str(const S: string): WideString;
function cp10081_MacTurkishToUTF16Str(const S: string): WideString;
function cp037ToUTF16Str(const S: string): WideString;
function cp424ToUTF16Str(const S: string): WideString;
function cp437ToUTF16Str(const S: string): WideString;
function cp437_DOSLatinUSToUTF16Str(const S: string): WideString;
function cp500ToUTF16Str(const S: string): WideString;
function cp737_DOSGreekToUTF16Str(const S: string): WideString;
function cp775_DOSBaltRimToUTF16Str(const S: string): WideString;
function cp850ToUTF16Str(const S: string): WideString;
function cp850_DOSLatin1ToUTF16Str(const S: string): WideString;
function cp852ToUTF16Str(const S: string): WideString;
function cp852_DOSLatin2ToUTF16Str(const S: string): WideString;
function cp855ToUTF16Str(const S: string): WideString;
function cp855_DOSCyrillicToUTF16Str(const S: string): WideString;
function cp856_Hebrew_PCToUTF16Str(const S: string): WideString;
function cp857ToUTF16Str(const S: string): WideString;
function cp857_DOSTurkishToUTF16Str(const S: string): WideString;
function cp860ToUTF16Str(const S: string): WideString;
function cp860_DOSPortugueseToUTF16Str(const S: string): WideString;
function cp861ToUTF16Str(const S: string): WideString;
function cp861_DOSIcelandicToUTF16Str(const S: string): WideString;
function cp862ToUTF16Str(const S: string): WideString;
function cp862_DOSHebrewToUTF16Str(const S: string): WideString;
function cp863ToUTF16Str(const S: string): WideString;
function cp863_DOSCanadaFToUTF16Str(const S: string): WideString;
function cp864ToUTF16Str(const S: string): WideString;
function cp864_DOSArabicToUTF16Str(const S: string): WideString;
function cp865ToUTF16Str(const S: string): WideString;
function cp865_DOSNordicToUTF16Str(const S: string): WideString;
function cp866ToUTF16Str(const S: string): WideString;
function cp866_DOSCyrillicRussianToUTF16Str(const S: string): WideString;
function cp869ToUTF16Str(const S: string): WideString;
function cp869_DOSGreek2ToUTF16Str(const S: string): WideString;
function cp874ToUTF16Str(const S: string): WideString;
function cp875ToUTF16Str(const S: string): WideString;
function cp932ToUTF16Str(const S: string): WideString;
function cp936ToUTF16Str(const S: string): WideString;
function cp949ToUTF16Str(const S: string): WideString;
function cp950ToUTF16Str(const S: string): WideString;
function cp1006ToUTF16Str(const S: string): WideString;
function cp1026ToUTF16Str(const S: string): WideString;
function cp1250ToUTF16Str(const S: string): WideString;
function cp1251ToUTF16Str(const S: string): WideString;
function cp1252ToUTF16Str(const S: string): WideString;
function cp1253ToUTF16Str(const S: string): WideString;
function cp1254ToUTF16Str(const S: string): WideString;
function cp1255ToUTF16Str(const S: string): WideString;
function cp1256ToUTF16Str(const S: string): WideString;
function cp1257ToUTF16Str(const S: string): WideString;
function cp1258ToUTF16Str(const S: string): WideString;

function UTF8ToUTF16BEStr(const S: string): WideString;
function UTF16BEToUTF8Str(const WS: WideString): string;

function UTF16ToUS_ASCIIChar(const I: longint): Char;
function UTF16ToIso8859_1Char(const I: longint): Char;
function UTF16ToIso8859_2Char(const I: longint): Char;
function UTF16ToIso8859_3Char(const I: longint): Char;
function UTF16ToIso8859_4Char(const I: longint): Char;
function UTF16ToIso8859_5Char(const I: longint): Char;
function UTF16ToIso8859_6Char(const I: longint): Char;
function UTF16ToIso8859_7Char(const I: longint): Char;
function UTF16ToIso8859_8Char(const I: longint): Char;
function UTF16ToIso8859_9Char(const I: longint): Char;
function UTF16ToIso8859_10Char(const I: longint): Char;
function UTF16ToIso8859_13Char(const I: longint): Char;
function UTF16ToIso8859_14Char(const I: longint): Char;
function UTF16ToIso8859_15Char(const I: longint): Char;
function UTF16ToKOI8_RChar(const I: longint): Char;
function UTF16ToJIS_X0201Char(const I: longint): Char;
function UTF16ToNextStepChar(const I: longint): Char;
function UTF16ToCp10000_MacRomanChar(const I: longint): Char;
function UTF16ToCp10006_MacGreekChar(const I: longint): Char;
function UTF16ToCp10007_MacCyrillicChar(const I: longint): Char;
function UTF16ToCp10029_MacLatin2Char(const I: longint): Char;
function UTF16ToCp10079_MacIcelandicChar(const I: longint): Char;
function UTF16ToCp10081_MacTurkishChar(const I: longint): Char;
function UTF16ToCp037Char(const I: longint): Char;
function UTF16ToCp424Char(const I: longint): Char;
function UTF16ToCp437Char(const I: longint): Char;
function UTF16ToCp437_DOSLatinUSChar(const I: longint): Char;
function UTF16ToCp500Char(const I: longint): Char;
function UTF16ToCp737_DOSGreekChar(const I: longint): Char;
function UTF16ToCp775_DOSBaltRimChar(const I: longint): Char;
function UTF16ToCp850Char(const I: longint): Char;
function UTF16ToCp850_DOSLatin1Char(const I: longint): Char;
function UTF16ToCp852Char(const I: longint): Char;
function UTF16ToCp852_DOSLatin2Char(const I: longint): Char;
function UTF16ToCp855Char(const I: longint): Char;
function UTF16ToCp855_DOSCyrillicChar(const I: longint): Char;
function UTF16ToCp856_Hebrew_PCChar(const I: longint): Char;
function UTF16ToCp857Char(const I: longint): Char;
function UTF16ToCp857_DOSTurkishChar(const I: longint): Char;
function UTF16ToCp860Char(const I: longint): Char;
function UTF16ToCp860_DOSPortugueseChar(const I: longint): Char;
function UTF16ToCp861Char(const I: longint): Char;
function UTF16ToCp861_DOSIcelandicChar(const I: longint): Char;
function UTF16ToCp862Char(const I: longint): Char;
function UTF16ToCp862_DOSHebrewChar(const I: longint): Char;
function UTF16ToCp863Char(const I: longint): Char;
function UTF16ToCp863_DOSCanadaFChar(const I: longint): Char;
function UTF16ToCp864Char(const I: longint): Char;
function UTF16ToCp864_DOSArabicChar(const I: longint): Char;
function UTF16ToCp865Char(const I: longint): Char;
function UTF16ToCp865_DOSNordicChar(const I: longint): Char;
function UTF16ToCp866Char(const I: longint): Char;
function UTF16ToCp866_DOSCyrillicRussianChar(const I: longint): Char;
function UTF16ToCp869Char(const I: longint): Char;
function UTF16ToCp869_DOSGreek2Char(const I: longint): Char;
function UTF16ToCp874Char(const I: longint): Char;
function UTF16ToCp875Char(const I: longint): Char;
function UTF16ToCp932Char(const I: longint): Char;
function UTF16ToCp936Char(const I: longint): Char;
function UTF16ToCp949Char(const I: longint): Char;
function UTF16ToCp950Char(const I: longint): Char;
function UTF16ToCp1006Char(const I: longint): Char;
function UTF16ToCp1026Char(const I: longint): Char;
function UTF16ToCp1250Char(const I: longint): Char;
function UTF16ToCp1251Char(const I: longint): Char;
function UTF16ToCp1252Char(const I: longint): Char;
function UTF16ToCp1253Char(const I: longint): Char;
function UTF16ToCp1254Char(const I: longint): Char;
function UTF16ToCp1255Char(const I: longint): Char;
function UTF16ToCp1256Char(const I: longint): Char;
function UTF16ToCp1257Char(const I: longint): Char;
function UTF16ToCp1258Char(const I: longint): Char;

function UTF16ToUS_ASCIIStr(const S: WideString): string;
function UTF16ToIso8859_1Str(const S: WideString): string;
function UTF16ToIso8859_2Str(const S: WideString): string;
function UTF16ToIso8859_3Str(const S: WideString): string;
function UTF16ToIso8859_4Str(const S: WideString): string;
function UTF16ToIso8859_5Str(const S: WideString): string;
function UTF16ToIso8859_6Str(const S: WideString): string;
function UTF16ToIso8859_7Str(const S: WideString): string;
function UTF16ToIso8859_8Str(const S: WideString): string;
function UTF16ToIso8859_9Str(const S: WideString): string;
function UTF16ToIso8859_10Str(const S: WideString): string;
function UTF16ToIso8859_13Str(const S: WideString): string;
function UTF16ToIso8859_14Str(const S: WideString): string;
function UTF16ToIso8859_15Str(const S: WideString): string;
function UTF16ToKOI8_RStr(const S: WideString): string;
function UTF16ToJIS_X0201Str(const S: WideString): string;
function UTF16ToNextStepStr(const S: WideString): string;
function UTF16ToCp10000_MacRomanStr(const S: WideString): string;
function UTF16ToCp10006_MacGreekStr(const S: WideString): string;
function UTF16ToCp10007_MacCyrillicStr(const S: WideString): string;
function UTF16ToCp10029_MacLatin2Str(const S: WideString): string;
function UTF16ToCp10079_MacIcelandicStr(const S: WideString): string;
function UTF16ToCp10081_MacTurkishStr(const S: WideString): string;
function UTF16ToCp037Str(const S: WideString): string;
function UTF16ToCp424Str(const S: WideString): string;
function UTF16ToCp437Str(const S: WideString): string;
function UTF16ToCp437_DOSLatinUSStr(const S: WideString): string;
function UTF16ToCp500Str(const S: WideString): string;
function UTF16ToCp737_DOSGreekStr(const S: WideString): string;
function UTF16ToCp775_DOSBaltRimStr(const S: WideString): string;
function UTF16ToCp850Str(const S: WideString): string;
function UTF16ToCp850_DOSLatin1Str(const S: WideString): string;
function UTF16ToCp852Str(const S: WideString): string;
function UTF16ToCp852_DOSLatin2Str(const S: WideString): string;
function UTF16ToCp855Str(const S: WideString): string;
function UTF16ToCp855_DOSCyrillicStr(const S: WideString): string;
function UTF16ToCp856_Hebrew_PCStr(const S: WideString): string;
function UTF16ToCp857Str(const S: WideString): string;
function UTF16ToCp857_DOSTurkishStr(const S: WideString): string;
function UTF16ToCp860Str(const S: WideString): string;
function UTF16ToCp860_DOSPortugueseStr(const S: WideString): string;
function UTF16ToCp861Str(const S: WideString): string;
function UTF16ToCp861_DOSIcelandicStr(const S: WideString): string;
function UTF16ToCp862Str(const S: WideString): string;
function UTF16ToCp862_DOSHebrewStr(const S: WideString): string;
function UTF16ToCp863Str(const S: WideString): string;
function UTF16ToCp863_DOSCanadaFStr(const S: WideString): string;
function UTF16ToCp864Str(const S: WideString): string;
function UTF16ToCp864_DOSArabicStr(const S: WideString): string;
function UTF16ToCp865Str(const S: WideString): string;
function UTF16ToCp865_DOSNordicStr(const S: WideString): string;
function UTF16ToCp866Str(const S: WideString): string;
function UTF16ToCp866_DOSCyrillicRussianStr(const S: WideString): string;
function UTF16ToCp869Str(const S: WideString): string;
function UTF16ToCp869_DOSGreek2Str(const S: WideString): string;
function UTF16ToCp874Str(const S: WideString): string;
function UTF16ToCp875Str(const S: WideString): string;
function UTF16ToCp932Str(const S: WideString): string;
function UTF16ToCp936Str(const S: WideString): string;
function UTF16ToCp949Str(const S: WideString): string;
function UTF16ToCp950Str(const S: WideString): string;
function UTF16ToCp1006Str(const S: WideString): string;
function UTF16ToCp1026Str(const S: WideString): string;
function UTF16ToCp1250Str(const S: WideString): string;
function UTF16ToCp1251Str(const S: WideString): string;
function UTF16ToCp1252Str(const S: WideString): string;
function UTF16ToCp1253Str(const S: WideString): string;
function UTF16ToCp1254Str(const S: WideString): string;
function UTF16ToCp1255Str(const S: WideString): string;
function UTF16ToCp1256Str(const S: WideString): string;
function UTF16ToCp1257Str(const S: WideString): string;
function UTF16ToCp1258Str(const S: WideString): string;

function UTF16HighSurrogate(const value: integer): WideChar;
function UTF16LowSurrogate(const value: integer): WideChar;
function UTF16SurrogateToInt(const highSurrogate, lowSurrogate: WideChar): integer;
function IsUTF16HighSurrogate(const S: WideChar): boolean;
function IsUTF16LowSurrogate(const S: WideChar): boolean;

type
  ECSMIBException = Exception;

  TCSMIBChangingEvent = procedure (Sender: TObject;
                                   NewEnum: integer;
                                   var AllowChange: Boolean) of object;

  TCSMIB = class (TComponent)
  protected
    FEnum: integer;
    FIgnoreInvalidEnum: boolean;
    FOnChanging: TCSMIBChangingEvent;
    FOnChange: TNotifyEvent;
    procedure DoChange(Sender: TObject); virtual;
    procedure DoChanging(Sender: TObject;
                                 NewEnum: integer;
                                 var AllowChange: Boolean); virtual;
    function GetPrfMIMEName: string; virtual;
    function GetAlias(i: integer): string; virtual;
    function GetAliasCount: integer; virtual;
    procedure SetEnum(const Value: integer); virtual;
    procedure SetOnChange(const Value: TNotifyEvent); virtual;
    procedure SetOnChanging(const Value: TCSMIBChangingEvent); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    function IsValidEnum(const Value: integer): boolean; virtual;
    function SetToAlias(const S: string): boolean; virtual;
    property Alias[i: integer]: string read GetAlias;
    property AliasCount: integer read GetAliasCount;
    property PreferredMIMEName: string read GetPrfMIMEName;
  published
    property OnChange: TNotifyEvent read FOnChange write SetOnChange;
    property OnChanging: TCSMIBChangingEvent read FOnChanging write SetOnChanging;
    property Enum: integer read FEnum write SetEnum;
    property IgnoreInvalidEnum: boolean read FIgnoreInvalidEnum write FIgnoreInvalidEnum;
  end;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('XML', [TCSMIB]);
end;

resourcestring
  SEncodingInvalid = 'Specified encoding not supported';
  SOddSizeInvalid  = 'Odd size not valid for WideString';
  STargetNil       = 'Must have a target stream';

function GetCharToUTF16ConvFunc(Encoding: TdomEncodingType): TCharToUTF16ConvFunc;
begin
  case Encoding of
    etUS_ASCII: Result := US_ASCIIToUTF16Char;
    etIso_8859_1: Result := Iso8859_1ToUTF16Char;
    etIso_8859_2: Result := Iso8859_2ToUTF16Char;
    etIso_8859_3: Result := Iso8859_3ToUTF16Char;
    etIso_8859_4: Result := Iso8859_4ToUTF16Char;
    etIso_8859_5: Result := Iso8859_5ToUTF16Char;
    etIso_8859_6: Result := Iso8859_6ToUTF16Char;
    etIso_8859_7: Result := Iso8859_7ToUTF16Char;
    etIso_8859_8: Result := Iso8859_8ToUTF16Char;
    etIso_8859_9: Result := Iso8859_9ToUTF16Char;
    etIso_8859_10: Result := Iso8859_10ToUTF16Char;
    etIso_8859_13: Result := Iso8859_13ToUTF16Char;
    etIso_8859_14: Result := Iso8859_14ToUTF16Char;
    etIso_8859_15: Result := Iso8859_15ToUTF16Char;
    etKOI8_R: Result := KOI8_RToUTF16Char;
    etJIS_X0201: Result := JIS_X0201ToUTF16Char;
    etNextStep: Result := nextStepToUTF16Char;
    etCp10000_MacRoman: Result:= cp10000_MacRomanToUTF16Char;
    etCp10006_MacGreek: Result := cp10006_MacGreekToUTF16Char;
    etCp10007_MacCyrillic: Result := cp10007_MacCyrillicToUTF16Char;
    etCp10029_MacLatin2: Result := cp10029_MacLatin2ToUTF16Char;
    etCp10079_MacIcelandic: Result := cp10079_MacIcelandicToUTF16Char;
    etCp10081_MacTurkish: Result := cp10081_MacTurkishToUTF16Char;
    etIBM037: Result := cp037ToUTF16Char;
    etIBM424: Result := cp424ToUTF16Char;
    etIBM437: Result := cp437ToUTF16Char;
    etDOS_437: Result := cp437_DOSLatinUSToUTF16Char;
    etIBM500: Result := cp500ToUTF16Char;
    etDOS_737: Result := cp737_DOSGreekToUTF16Char;
    etDOS_775: Result := cp775_DOSBaltRimToUTF16Char;
    etIBM850: Result := cp850ToUTF16Char;
    etDOS_850: Result := cp850_DOSLatin1ToUTF16Char;
    etIBM852: Result := cp852ToUTF16Char;
    etDOS_852: Result := cp852_DOSLatin2ToUTF16Char;
    etIBM855: Result := cp855ToUTF16Char;
    etDOS_855: Result := cp855_DOSCyrillicToUTF16Char;
    etPC_856: Result := cp856_Hebrew_PCToUTF16Char;
    etIBM857: Result := cp857ToUTF16Char;
    etDOS_857: Result := cp857_DOSTurkishToUTF16Char;
    etIBM860: Result := cp860ToUTF16Char;
    etDOS_860: Result := cp860_DOSPortugueseToUTF16Char;
    etIBM861: Result := cp861ToUTF16Char;
    etDOS_861: Result := cp861_DOSIcelandicToUTF16Char;
    etIBM862: Result := cp862ToUTF16Char;
    etDOS_862: Result := cp862_DOSHebrewToUTF16Char;
    etIBM863: Result := cp863ToUTF16Char;
    etDOS_863: Result := cp863_DOSCanadaFToUTF16Char;
    etIBM864: Result := cp864ToUTF16Char;
    etDOS_864: Result := cp864_DOSArabicToUTF16Char;
    etIBM865: Result := cp865ToUTF16Char;
    etDOS_865: Result := cp865_DOSNordicToUTF16Char;
    etIBM866: Result := cp866ToUTF16Char;
    etDOS_866: Result := cp866_DOSCyrillicRussianToUTF16Char;
    etIBM869: Result := cp869ToUTF16Char;
    etDOS_869: Result := cp869_DOSGreek2ToUTF16Char;
    etCp874: Result := cp874ToUTF16Char;
    etCp875: Result := cp875ToUTF16Char;
    etCp932: Result := cp932ToUTF16Char;
    etCp936: Result := cp936ToUTF16Char;
    etCp949: Result := cp949ToUTF16Char;
    etCp950: Result := cp950ToUTF16Char;
    etCp1006: Result := cp1006ToUTF16Char;
    etIBM1026: Result := cp1026ToUTF16Char;
    etWindows_1250: Result := cp1250ToUTF16Char;
    etWindows_1251: Result := cp1251ToUTF16Char;
    etWindows_1252: Result := cp1252ToUTF16Char;
    etWindows_1253: Result := cp1253ToUTF16Char;
    etWindows_1254: Result := cp1254ToUTF16Char;
    etWindows_1255: Result := cp1255ToUTF16Char;
    etWindows_1256: Result := cp1256ToUTF16Char;
    etWindows_1257: Result := cp1257ToUTF16Char;
    etWindows_1258: Result := cp1258ToUTF16Char;
  else
    Result:= nil;
  end;
end;

function GetUTF16ToCharConvFunc(Encoding: TdomEncodingType): TUTF16ToCharConvFunc;
begin
  case Encoding of
    etUS_ASCII: Result := UTF16ToUS_ASCIIChar;
    etIso_8859_1: Result := UTF16ToIso8859_1Char;
    etIso_8859_2: Result := UTF16ToIso8859_2Char;
    etIso_8859_3: Result := UTF16ToIso8859_3Char;
    etIso_8859_4: Result := UTF16ToIso8859_4Char;
    etIso_8859_5: Result := UTF16ToIso8859_5Char;
    etIso_8859_6: Result := UTF16ToIso8859_6Char;
    etIso_8859_7: Result := UTF16ToIso8859_7Char;
    etIso_8859_8: Result := UTF16ToIso8859_8Char;
    etIso_8859_9: Result := UTF16ToIso8859_9Char;
    etIso_8859_10: Result := UTF16ToIso8859_10Char;
    etIso_8859_13: Result := UTF16ToIso8859_13Char;
    etIso_8859_14: Result := UTF16ToIso8859_14Char;
    etIso_8859_15: Result := UTF16ToIso8859_15Char;
    etKOI8_R: Result := UTF16ToKOI8_RChar;
    etJIS_X0201: Result := UTF16ToJIS_X0201Char;
    etNextStep: Result := UTF16ToNextStepChar;
    etCp10000_MacRoman: Result := UTF16ToCp10000_MacRomanChar;
    etCp10006_MacGreek: Result := UTF16ToCp10006_MacGreekChar;
    etCp10007_MacCyrillic: Result := UTF16ToCp10007_MacCyrillicChar;
    etCp10029_MacLatin2: Result := UTF16ToCp10029_MacLatin2Char;
    etCp10079_MacIcelandic: Result := UTF16ToCp10079_MacIcelandicChar;
    etCp10081_MacTurkish: Result := UTF16ToCp10081_MacTurkishChar;
    etIBM037: Result := UTF16ToCp037Char;
    etIBM424: Result := UTF16ToCp424Char;
    etIBM437: Result := UTF16ToCp437Char;
    etDOS_437: Result := UTF16ToCp437_DOSLatinUSChar;
    etIBM500: Result := UTF16ToCp500Char;
    etDOS_737: Result := UTF16ToCp737_DOSGreekChar;
    etDOS_775: Result := UTF16ToCp775_DOSBaltRimChar;
    etIBM850: Result := UTF16ToCp850Char;
    etDOS_850: Result := UTF16ToCp850_DOSLatin1Char;
    etIBM852: Result := UTF16ToCp852Char;
    etDOS_852: Result := UTF16ToCp852_DOSLatin2Char;
    etIBM855: Result := UTF16ToCp855Char;
    etDOS_855: Result := UTF16ToCp855_DOSCyrillicChar;
    etPC_856: Result := UTF16ToCp856_Hebrew_PCChar;
    etIBM857: Result := UTF16ToCp857Char;
    etDOS_857: Result := UTF16ToCp857_DOSTurkishChar;
    etIBM860: Result := UTF16ToCp860Char;
    etDOS_860: Result := UTF16ToCp860_DOSPortugueseChar;
    etIBM861: Result := UTF16ToCp861Char;
    etDOS_861: Result := UTF16ToCp861_DOSIcelandicChar;
    etIBM862: Result := UTF16ToCp862Char;
    etDOS_862: Result := UTF16ToCp862_DOSHebrewChar;
    etIBM863: Result := UTF16ToCp863Char;
    etDOS_863: Result := UTF16ToCp863_DOSCanadaFChar;
    etIBM864: Result := UTF16ToCp864Char;
    etDOS_864: Result := UTF16ToCp864_DOSArabicChar;
    etIBM865: Result := UTF16ToCp865Char;
    etDOS_865: Result := UTF16ToCp865_DOSNordicChar;
    etIBM866: Result := UTF16ToCp866Char;
    etDOS_866: Result := UTF16ToCp866_DOSCyrillicRussianChar;
    etIBM869: Result := UTF16ToCp869Char;
    etDOS_869: Result := UTF16ToCp869_DOSGreek2Char;
    etCp874: Result := UTF16ToCp874Char;
    etCp875: Result := UTF16ToCp875Char;
    etCp932: Result := UTF16ToCp932Char;
    etCp936: Result := UTF16ToCp936Char;
    etCp949: Result := UTF16ToCp949Char;
    etCp950: Result := UTF16ToCp950Char;
    etCp1006: Result := UTF16ToCp1006Char;
    etIBM1026: Result := UTF16ToCp1026Char;
    etWindows_1250: Result := UTF16ToCp1250Char;
    etWindows_1251: Result := UTF16ToCp1251Char;
    etWindows_1252: Result := UTF16ToCp1252Char;
    etWindows_1253: Result := UTF16ToCp1253Char;
    etWindows_1254: Result := UTF16ToCp1254Char;
    etWindows_1255: Result := UTF16ToCp1255Char;
    etWindows_1256: Result := UTF16ToCp1256Char;
    etWindows_1257: Result := UTF16ToCp1257Char;
    etWindows_1258: Result := UTF16ToCp1258Char;
  else
    Result := nil;
  end;
end;

{$IFNDEF LINUX}
function GetACPEncodingName: String;
begin
  case GetACP of
    874: Result := 'cp874';
    932: Result := 'cp932';
    936: Result := 'cp936';
    949: Result := 'cp949';
    950: Result := 'cp950';
    1200: Result := 'ISO-10646-UCS-2';
    1250: Result := 'windows-1250';
    1251: Result := 'windows-1251';
    1252: Result := 'windows-1252';
    1253: Result := 'windows-1253';
    1254: Result := 'windows-1254';
    1255: Result := 'windows-1255';
    1256: Result := 'windows-1256';
    1257: Result := 'windows-1257';
  else
    raise EConvertError.Create('Invalid encoding.');
  end;
end;
{$ENDIF}

{$IFNDEF LINUX}
function GetACPEncodingType: TdomEncodingType;
begin
  case GetACP of
    874: Result := etCp874;
    932: Result := etCp932;
    936: Result := etCp936;
    949: Result := etCp949;
    950: Result := etCp950;
    1200: Result := etISO_10646_UCS_2;
    1250: Result := etWindows_1250;
    1251: Result := etWindows_1251;
    1252: Result := etWindows_1252;
    1253: Result := etWindows_1253;
    1254: Result := etWindows_1254;
    1255: Result := etWindows_1255;
    1256: Result := etWindows_1256;
    1257: Result := etWindows_1257;
  else
    raise EConvertError.Create('Invalid encoding.');
  end;
end;
{$ENDIF}

function StrToUTF16WideStr(S: String;
                              ConversionFunction: TCharToUTF16ConvFunc): WideString;
// Converts a string into an UTF-16 WideString using the
// specified conversion function.
// No special conversions (e.g. on line breaks) are done.
var
  I, J: Integer;
begin
  J := Length(S);
  SetLength(Result, J);
  for I := 1 to J do
    Result[I] := ConversionFunction(ord(S[I]));
end;

function UTF16WideStrToStr(S: WideString;
                           ConversionFunction: TUTF16ToCharConvFunc): String;
// Converts a UTF-16 WideString into a string using the
// specified conversion function.
// No special conversions (e.g. on line breaks) are done.
var
  I, J, Start: Integer;
  EncType: TdomEncodingType;
begin
  J := Length(S);
  Start := 1;
  EncType := etUTF_16BE;
  if J > 0 then begin
    // Byte order mark?
    if S[1] = #$FEFF then Start := 2
    else if S[1] = #$FFFE then begin Start := 2; EncType := etUTF_16LE; end;
  end;
  SetLength(Result, J - Start + 1);
  if EncType = etUTF_16BE
    then for I := start to J do Result[i] := ConversionFunction(ord(S[I]))
    else for I := start to J do Result[i] := ConversionFunction(Swap(Ord(S[I])));
end;


// +++++++++++++++++++++++++ TConversionStream +++++++++++++++++++++++++
//                     - Provided by Karl Waclawek -
// This is an input/output stream for other streams.
// Purpose: transform data as they are written to or read from a target
//          stream.
constructor TConversionStream.create(Target: TStream);
begin
  if Target = nil then raise EConversionStream.create(STargetNil);
  inherited create;
  FTarget := Target;
end;

destructor TConversionStream.destroy;
begin
  FreeMem(FConvertBufP);
  inherited destroy;
end;

function TConversionStream.Seek(Offset: longint; Origin: Word): longint;
begin
  Result := 0;  // Seek makes no sense here
end;

function TConversionStream.ConvertReadBuffer(const Buffer; Count: longint): longint;
// Performs the actual conversion of the data in Buffer (read buffer);
// the result of the conversion must be written to ConvertBufB }
begin
  Result := 0; //do nothing, override in descendants
end;

function TConversionStream.ConvertWriteBuffer(const Buffer; Count: longint): longint;
// Performs the actual conversion of the data in Buffer (write buffer);
// the result of the conversion must be written to ConvertBufB }
begin
  Result := 0; //do nothing, override in descendants
end;

function TConversionStream.Read(var Buffer; Count: longint): longint;
// Reads Count bytes from target stream into Buffer;
// converts those bytes and stores the result in ConvertBufP;
// ConvertCount indicates the amount of bytes converted.
begin
  Result := Target.Read(Buffer, Count);
  FConvertCount := ConvertReadBuffer(Buffer, Result);
end;

function TConversionStream.Write(const Buffer; Count: longint): longint;
// Converts Count bytes from Buffer into ConvertBufP;
// ConvertCount indicates the amount of bytes converted;
// if not all converted bytes could be written to the target stream,
// then this returns the negative of the number of bytes actually written.
begin
  Result := Count;
  FConvertCount := ConvertWriteBuffer(Buffer, Result);
  Count := Target.Write(FConvertBufP^, FConvertCount);
  //if not all converted data could be written, return the negative
  //count of the data actually written. This avoids having Result
  //being the same as Count by coincidence
  if Count <> FConvertCount then Result := -Count;
end;

procedure TConversionStream.FreeConvertBuffer;
begin
  ReallocMem(FConvertBufP, 0);
  FConvertBufSize := 0;
end;

procedure TConversionStream.SetConvertBufSize(NewSize: Integer);
begin
  ReallocMem(FConvertBufP, NewSize);
  FConvertBufSize := NewSize;
end;


// ++++++++++++++++++++++++++ TUTF16BEToUTF8Stream +++++++++++++++++++++++
function TUTF16BEToUTF8Stream.ConvertWriteBuffer(const Buffer;
                                                       Count: Integer): longint;
// Converts an UTF-16BE stream into an UTF-8 encoded stream
//  - This function was provided by Ernst van der Pols -
//  - Converted for stream processing by Karl Waclawek -
//              - Modfied by Dieter Köhler -
type
  TWideCharBuf = array[0..(MaxInt shr 1) - 1] of WideChar;
var
  InIndx, OutIndx: longint;
  Wc: WideChar;
  InBuf: TWideCharBuf absolute Buffer;

  procedure IncBufSize(BufSize: longint);
    var
      Delta: longint;
    begin
    Inc(BufSize);
    Delta := BufSize shr 2;
    if Delta < 8 then Delta := 8;
    BufSize := ((BufSize + Delta) shr 2) shl 2; //make it multiple of 4
    setConvertBufSize(BufSize);
    end;

  procedure UCS4CodeToUTF8String(Code: longint);
    const
      MaxCode: array[0..5] of longint = ($7F,$7FF,$FFFF,$1FFFFF,$3FFFFFF,$7FFFFFFF);
      FirstByte: array[0..5] of Byte = (0,$C0,$E0,$F0,$F8,$FC);
    var
      Mo, Indx, StartIndx: longint;
    begin
    Mo := 0;			// get number of bytes
    while ((Code > MaxCode[Mo]) and (Mo < 5)) do Inc(Mo);
    StartIndx := OutIndx;
    OutIndx := StartIndx + Mo;
    if OutIndx >= ConvertBufSize then IncBufSize(OutIndx);
    for Indx := OutIndx downto StartIndx + 1 do	// fill bytes from rear end
      begin
      PChar(FConvertBufP)[Indx] := Char($80 or (Code and $3F));
      Code := Code shr 6;
      end;
    PChar(FConvertBufP)[StartIndx] := Char(FirstByte[Mo] or Code); // fill first byte
    end;

begin
  Result := 0;
  if Count = 0 then Exit;
  if Odd(Count) then raise EConversionStream.create(SOddSizeInvalid);
  Count := Count shr 1;  //for initial size, assume all low ASCII chars
  if Count > ConvertBufSize then setConvertBufSize(Count);
  OutIndx := -1;	// keep track of end position
  InIndx := 0;
  if InBuf[0] = #$FEFF then Inc(InIndx);  // Test for BOM

  while InIndx < Count do begin
    Wc := InBuf[InIndx];
    case Word(Wc) of
      $0000..$007F:	// US-ASCII
        begin
        Inc(OutIndx);
        if OutIndx >= ConvertBufSize then IncBufSize(OutIndx);
        PChar(FConvertBufP)[OutIndx]:= Char(Wc);
        end;
      $D800..$DBFF:	// high surrogate
        begin
        Inc(InIndx);
        if (InIndx < (Count - 1)) and (Word(InBuf[InIndx]) >= $DC00)
          and (Word(InBuf[InIndx]) <= $DFFF) then
          begin
          Inc(OutIndx);
          UCS4CodeToUTF8String(Utf16SurrogateToInt(Wc, InBuf[InIndx]));
          end
        else
          raise EConvertError.CreateFmt(
            'High surrogate %4.4X without low surrogate.',[Word(Wc)]);
        end;
      $DC00..$DFFF:	// low surrogate
        raise EConvertError.CreateFmt(
          'Low surrogate %4.4X without high surrogate.',[Word(Wc)]);  // Remark: High surrogate must come first!
      else              // the rest
        Inc(OutIndx);
        UCS4CodeToUTF8String(Word(Wc));
    end; {case ...}
    Inc(InIndx);
  end; { while ...}
  Result := OutIndx + 1;
end;



// ++++++++++++++++++++ TUTF16BEToSingleByteCharsetStream +++++++++++++++++
constructor TUTF16BEToSingleByteCharsetStream.Create(Target: TStream;
  ATargetEncoding: TdomEncodingType);
begin
  inherited Create(Target);
  FUTF16ToCharConvFunc:= GetUTF16ToCharConvFunc(ATargetEncoding);
  if not assigned(FUTF16ToCharConvFunc)
    then raise EConversionStream.Create(SEncodingInvalid);
  FTargetEncoding:= ATargetEncoding;
end;

function TUTF16BEToSingleByteCharsetStream.ConvertWriteBuffer(const buffer;
  count: Integer): longint;
// Converts an UTF-16BE stream into a single byte charset stream.
// This function is based on a similar converter from UTF-16BE to UTF-8
// originally provided by Ernst van der Pols and modified for stream
// processing by Karl Waclawek.  The generalization to all supported
// single byte charsets was done by Dieter Köhler.
type
  TWideCharBuf = array[0..(MaxInt shr 1) - 1] of WideChar;
var
  InIndx, OutIndx: longint;
  Wc: WideChar;
  InBuf: TWideCharBuf absolute Buffer;

  procedure IncBufSize(BufSize: longint);
  var
    Delta: longint;
  begin
    Inc(BufSize);
    Delta := BufSize shr 2;
    if Delta < 8 then Delta := 8;
    BufSize := ((BufSize + Delta) shr 2) shl 2; //make it multiple of 4
    setConvertBufSize(BufSize);
  end;

  procedure UCS4CodeToSingleByte(Code: longint);
  begin
    inc(OutIndx);
    if OutIndx >= ConvertBufSize then IncBufSize(OutIndx);
    PChar(FConvertBufP)[OutIndx] := FUTF16ToCharConvFunc(Code);
  end;

begin
  Result := 0;
  if Count = 0 then Exit;
  if Odd(Count) then raise EConversionStream.create(SOddSizeInvalid);
  Count := Count shr 1; // Devide by 2.  This equals exactly the output size,
                        // if no surrogate pairs are used.  If surrogate pairs
                        // are used, it is even greater.
  if Count > ConvertBufSize then setConvertBufSize(Count);
  OutIndx := -1;	// keep track of end position
  InIndx := 0;
  if InBuf[0] = #$FEFF then Inc(InIndx);  // Test for BOM

  while InIndx < Count do begin
    Wc := InBuf[InIndx];
    case Word(Wc) of
      $D800..$DBFF:	// high surrogate
        begin
        Inc(InIndx);
        if (InIndx < (Count - 1)) and (Word(InBuf[InIndx]) >= $DC00)
          and (Word(InBuf[InIndx]) <= $DFFF) then
          begin
          Inc(OutIndx);
          UCS4CodeToSingleByte(Utf16SurrogateToInt(Wc, InBuf[InIndx]));
          end
        else
          raise EConvertError.CreateFmt(
            'High surrogate %4.4X without low surrogate.',[Word(Wc)]);
        end;
      $DC00..$DFFF:	// low surrogate
        raise EConvertError.CreateFmt(
          'Low surrogate %4.4X without high surrogate.',[Word(Wc)]);  // Remark: High surrogate must come first!
      else              // the rest
        Inc(OutIndx);
        UCS4CodeToSingleByte(Word(Wc));
    end; {case ...}
    Inc(InIndx);
  end; { while ...}
  Result := OutIndx + 1;
end;



// +++++++++++++++++++ encoding detection functions +++++++++++++++++++++

function EncodingToStr(const Encoding: TdomEncodingType): String;
begin
  case Encoding of
    etUTF_8: Result := 'UTF-8';
    etUTF_16BE: Result := 'UTF-16BE';
    etUTF_16LE: Result := 'UTF-16LE';
    etISO_10646_UCS_2: Result := 'ISO-10646-UCS-2';
    etUS_ASCII: Result := 'US-ASCII';
    etIso_8859_1: Result := 'ISO-8859-1';
    etIso_8859_2: Result := 'ISO-8859-2';
    etIso_8859_3: Result := 'ISO-8859-3';
    etIso_8859_4: Result := 'ISO-8859-4';
    etIso_8859_5: Result := 'ISO-8859-5';
    etIso_8859_6: Result := 'ISO-8859-6';
    etIso_8859_7: Result := 'ISO-8859-7';
    etIso_8859_8: Result := 'ISO-8859-8';
    etIso_8859_9: Result := 'ISO-8859-9';
    etIso_8859_10: Result := 'ISO_8859-10';  // The underscore is specified in the MIB specification
    etIso_8859_13: Result := 'ISO-8859-11';
    etIso_8859_14: Result := 'ISO-8859-12';
    etIso_8859_15: Result := 'ISO-8859-13';
    etKOI8_R: Result := 'KOI8-R';
    etJIS_X0201: Result := 'JIS_X0201';
    etNextStep: Result := 'NextStep';
    etCp10000_MacRoman: Result := 'cp10000_MacRoman';
    etCp10006_MacGreek: Result := 'cp10006_MacGreek';
    etCp10007_MacCyrillic: Result := 'cp10007_MacCyrillic';
    etCp10029_MacLatin2: Result := 'cp10029_MacLatin2';
    etCp10079_MacIcelandic: Result := 'cp10079_MacIcelandic';
    etCp10081_MacTurkish: Result := 'cp10081_MacTurkish';
    etIBM037: Result := 'IBM037';
    etIBM424: Result := 'IBM424';
    etIBM437: Result := 'IBM437';
    etDOS_437: Result := 'cp437_DOSLatinUS';
    etIBM500: Result := 'IBM500';
    etDOS_737: Result := 'cp737_DOSGreek';
    etDOS_775: Result := 'cp775_DOSBaltRim';
    etIBM850: Result := 'IBM850';
    etDOS_850: Result := 'cp850_DOSLatin1';
    etIBM852: Result := 'IBM852';
    etDOS_852: Result := 'cp852_DOSLatin2';
    etIBM855: Result := 'IBM855';
    etDOS_855: Result := 'cp855_DOSCyrillic';
    etPC_856: Result := 'cp856_Hebrew_PC';
    etIBM857: Result := 'IBM857';
    etDOS_857: Result := 'cp857_DOSTurkish';
    etIBM860: Result := 'IBM860';
    etDOS_860: Result := 'cp860_DOSPortuguese';
    etIBM861: Result := 'IBM861';
    etDOS_861: Result := 'cp861_DOSIcelandic';
    etIBM862: Result := 'IBM862';
    etDOS_862: Result := 'cp862_DOSHebrew';
    etIBM863: Result := 'IBM863';
    etDOS_863: Result := 'cp863_DOSCanadaF';
    etIBM864: Result := 'IBM864';
    etDOS_864: Result := 'cp864_DOSArabic';
    etIBM865: Result := 'IBM865';
    etDOS_865: Result := 'cp865_DOSNordic';
    etIBM866: Result := 'IBM866';
    etDOS_866: Result := 'cp866_DOSCyrillicRussian';
    etIBM869: Result := 'IBM869';
    etDOS_869: Result := 'cp869_DOSGreek2';
    etCp874: Result := 'cp874';
    etCp875: Result := 'cp875_IBMGreek';
    etCp932: Result := 'cp932';
    etCp936: Result := 'cp936';
    etCp949: Result := 'cp949';
    etCp950: Result := 'cp950';
    etCp1006: Result := 'cp1006';
    etIBM1026: Result := 'IBM1026';
    etWindows_1250: Result := 'windows-1250';
    etWindows_1251: Result := 'windows-1251';
    etWindows_1252: Result := 'windows-1252';
    etWindows_1253: Result := 'windows-1253';
    etWindows_1254: Result := 'windows-1254';
    etWindows_1255: Result := 'windows-1255';
    etWindows_1256: Result := 'windows-1256';
    etWindows_1257: Result := 'windows-1257';
    etWindows_1258: Result := 'windows-1258';
  else
    raise EConvertError.Create('Invalid encoding.');
  end; {case ...}
end;

function StrToEncoding(const S: String): TdomEncodingType;
var
  Csmib: TCSMIB;
begin
  if (CompareText(S,'NextStep') = 0)
    then begin Result := etNextStep; exit; end;
  if (CompareText(S,'cp10000_MacRoman') = 0)
    then begin Result := etCp10000_MacRoman; exit; end;
  if (CompareText(S,'cp10006_MacGreek') = 0)
    then begin Result := etCp10006_MacGreek; exit; end;
  if (CompareText(S,'cp10007_MacCyrillic') = 0)
    then begin Result := etCp10007_MacCyrillic; exit; end;
  if (CompareText(S,'cp10029_MacLatin2') = 0)
    then begin Result := etCp10029_MacLatin2; exit; end;
  if (CompareText(S,'cp10079_MacIcelandic') = 0)
    then begin Result := etCp10079_MacIcelandic; exit; end;
  if (CompareText(S,'cp10081_MacTurkish') = 0)
    then begin Result := etCp10081_MacTurkish; exit; end;
  if (CompareText(S,'cp437_DOSLatinUS') = 0)
    then begin Result := etDOS_437; exit; end;
  if (CompareText(S,'cp737_DOSGreek') = 0)
    then begin Result := etDOS_737; exit; end;
  if (CompareText(S,'cp775_DOSBaltRim') = 0)
    then begin Result := etDOS_775; exit; end;
  if (CompareText(S,'cp850_DOSLatin1') = 0)
    then begin Result := etDOS_850; exit; end;
  if (CompareText(S,'cp852_DOSLatin2') = 0)
    then begin Result := etDOS_852; exit; end;
  if (CompareText(S,'cp855_DOSCyrillic') = 0)
    then begin Result := etDOS_855; exit; end;
  if (CompareText(S,'cp856_Hebrew_PC') = 0)
    then begin Result := etPC_856; exit; end;
  if (CompareText(S,'cp857_DOSTurkish') = 0)
    then begin Result := etDOS_857; exit; end;
  if (CompareText(S,'cp860_DOSPortuguese') = 0)
    then begin Result := etDOS_860; exit; end;
  if (CompareText(S,'cp861_DOSIcelandic') = 0)
    then begin Result := etDOS_861; exit; end;
  if (CompareText(S,'cp862_DOSHebrew') = 0)
    then begin Result := etDOS_862; exit; end;
  if (CompareText(S,'cp863_DOSCanadaF') = 0)
    then begin Result := etDOS_863; exit; end;
  if (CompareText(S,'cp864_DOSArabic') = 0)
    then begin Result := etDOS_864; exit; end;
  if (CompareText(S,'cp865_DOSNordic') = 0)
    then begin Result := etDOS_865; exit; end;
  if (CompareText(S,'cp866_DOSCyrillicRussian') = 0)
    then begin Result := etDOS_866; exit; end;
  if (CompareText(S,'cp869_DOSGreek2') = 0)
    then begin Result := etDOS_869; exit; end;
  if (CompareText(S,'cp874') = 0)
    then begin Result := etCp874; exit; end;
  if (CompareText(S,'cp875_IBMGreek') = 0)
    then begin Result := etCp875; exit; end;
  if (CompareText(S,'cp932') = 0)
    then begin Result := etCp932; exit; end;
  if (CompareText(S,'cp936') = 0)
    then begin Result := etCp936; exit; end;
  if (CompareText(S,'cp949') = 0)
    then begin Result := etCp949; exit; end;
  if (CompareText(S,'cp950') = 0)
    then begin Result := etCp950; exit; end;
  if (CompareText(S,'cp1006') = 0)
    then begin Result := etCp1006; exit; end;

  Csmib:= TCSMIB.Create(nil);
  try
    if Csmib.SetToAlias(S) then begin
      case Csmib.Enum of
        3: Result := etUS_ASCII;
        4: Result := etIso_8859_1;
        5: Result := etIso_8859_2;
        6: Result := etIso_8859_3;
        7: Result := etIso_8859_4;
        8: Result := etIso_8859_5;
        9: Result := etIso_8859_6;
        10: Result := etIso_8859_7;
        11: Result := etIso_8859_8;
        12: Result := etIso_8859_9;
        13: Result := etIso_8859_10;
        15: Result := etJIS_X0201;
        106: Result := etUTF_8;
        109: Result := etIso_8859_13;
        110: Result := etIso_8859_14;
        111: Result := etIso_8859_15;
        1000: Result := etISO_10646_UCS_2;
        1013,1015: Result := etUTF_16BE;
        1014: Result := etUTF_16LE;
        2009: Result := etIBM850;
        2010: Result := etIBM852;
        2011: Result := etIBM437;
        2013: Result := etIBM862;
        2028: Result := etIBM037;
        2043: Result := etIBM424;
        2044: Result := etIBM500;
        2046: Result := etIBM855;
        2047: Result := etIBM857;
        2048: Result := etIBM860;
        2049: Result := etIBM861;
        2050: Result := etIBM863;
        2051: Result := etIBM864;
        2052: Result := etIBM865;
        2054: Result := etIBM869;
        2063: Result := etIBM1026;
        2084: Result := etKOI8_R;
        2086: Result := etIBM866;
        2250: Result := etWindows_1250;
        2251: Result := etWindows_1251;
        2252: Result := etWindows_1252;
        2253: Result := etWindows_1253;
        2254: Result := etWindows_1254;
        2255: Result := etWindows_1255;
        2256: Result := etWindows_1256;
        2257: Result := etWindows_1257;
        2258: Result := etWindows_1258;
      else
        Result := etUnknown;
      end;
    end else Result := etUnknown;
  finally
    Csmib.Free;
  end;
end;


// ++++++++++++++++++++++ conversion functions ++++++++++++++++++++++++

function SingleByteEncodingToUTF16Char(const W: word; const Encoding: TdomEncodingType):WideChar;
var
  CharToUTF16ConvFunc: TCharToUTF16ConvFunc;
begin
  CharToUTF16ConvFunc:= GetCharToUTF16ConvFunc(Encoding);
  if not assigned(CharToUTF16ConvFunc)
    then raise EConvertError.Create(SEncodingInvalid);
  result:= CharToUTF16ConvFunc(W);
end;

function US_ASCIIToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$7f: result:= WideChar(W);
  else
    raise EConvertError.CreateFmt('Invalid US-ASCII sequence of code point %d',[W]);
  end;
end;

function Iso8859_1ToUTF16Char(const W: word):WideChar;
begin
  result:= WideChar(W);
end;

function Iso8859_2ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $a1: Result:= #$0104;  // LATIN CAPITAL LETTER A WITH OGONEK
    $a2: Result:= #$02d8;  // BREVE
    $a3: Result:= #$0141;  // LATIN CAPITAL LETTER L WITH STROKE
    $a5: Result:= #$0132;  // LATIN CAPITAL LETTER L WITH CARON
    $a6: Result:= #$015a;  // LATIN CAPITAL LETTER S WITH ACUTE
    $a9: Result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $aa: Result:= #$015e;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $ab: Result:= #$0164;  // LATIN CAPITAL LETTER T WITH CARON
    $ac: Result:= #$0179;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $ae: Result:= #$017d;  // LATIN CAPITAL LETTER Z WITH CARON
    $af: Result:= #$017b;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $b1: Result:= #$0105;  // LATIN SMALL LETTER A WITH OGONEK
    $b2: Result:= #$02db;  // OGONEK
    $b3: Result:= #$0142;  // LATIN SMALL LETTER L WITH STROKE
    $b5: Result:= #$013e;  // LATIN SMALL LETTER L WITH CARON
    $b6: Result:= #$015b;  // LATIN SMALL LETTER S WITH ACUTE
    $b7: Result:= #$02c7;  // CARON
    $b9: Result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $ba: Result:= #$015f;  // LATIN SMALL LETTER S WITH CEDILLA
    $bb: Result:= #$0165;  // LATIN SMALL LETTER T WITH CARON
    $bc: Result:= #$017a;  // LATIN SMALL LETTER Z WITH ACUTE
    $bd: Result:= #$02dd;  // DOUBLE ACUTE ACCENT
    $be: Result:= #$017e;  // LATIN SMALL LETTER Z WITH CARON
    $bf: Result:= #$017c;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $c0: Result:= #$0154;  // LATIN CAPITAL LETTER R WITH ACUTE
    $c3: Result:= #$0102;  // LATIN CAPITAL LETTER A WITH BREVE
    $c5: Result:= #$0139;  // LATIN CAPITAL LETTER L WITH ACUTE
    $c6: Result:= #$0106;  // LATIN CAPITAL LETTER C WITH ACUTE
    $c8: Result:= #$010c;  // LATIN CAPITAL LETTER C WITH CARON
    $ca: Result:= #$0118;  // LATIN CAPITAL LETTER E WITH OGONEK
    $cc: Result:= #$011a;  // LATIN CAPITAL LETTER E WITH CARON
    $cf: Result:= #$010e;  // LATIN CAPITAL LETTER D WITH CARON
    $d0: Result:= #$0110;  // LATIN CAPITAL LETTER D WITH STROKE
    $d1: Result:= #$0143;  // LATIN CAPITAL LETTER N WITH ACUTE
    $d2: Result:= #$0147;  // LATIN CAPITAL LETTER N WITH CARON
    $d5: Result:= #$0150;  // LATIN CAPITAL LETTER O WITH DOUBLE ACUTE
    $d8: Result:= #$0158;  // LATIN CAPITAL LETTER R WITH CARON
    $d9: Result:= #$016e;  // LATIN CAPITAL LETTER U WITH RING ABOVE
    $db: Result:= #$0170;  // LATIN CAPITAL LETTER U WITH WITH DOUBLE ACUTE
    $de: Result:= #$0162;  // LATIN CAPITAL LETTER T WITH CEDILLA
    $e0: Result:= #$0155;  // LATIN SMALL LETTER R WITH ACUTE
    $e3: Result:= #$0103;  // LATIN SMALL LETTER A WITH BREVE
    $e5: Result:= #$013a;  // LATIN SMALL LETTER L WITH ACUTE
    $e6: Result:= #$0107;  // LATIN SMALL LETTER C WITH ACUTE
    $e8: Result:= #$010d;  // LATIN SMALL LETTER C WITH CARON
    $ea: Result:= #$0119;  // LATIN SMALL LETTER E WITH OGONEK
    $ec: Result:= #$011b;  // LATIN SMALL LETTER E WITH CARON
    $ef: Result:= #$010f;  // LATIN SMALL LETTER D WITH CARON
    $f0: Result:= #$0111;  // LATIN SMALL LETTER D WITH STROKE
    $f1: Result:= #$0144;  // LATIN SMALL LETTER N WITH ACUTE
    $f2: Result:= #$0148;  // LATIN SMALL LETTER N WITH CARON
    $f5: Result:= #$0151;  // LATIN SMALL LETTER O WITH DOUBLE ACUTE
    $f8: Result:= #$0159;  // LATIN SMALL LETTER R WITH CARON
    $f9: Result:= #$016f;  // LATIN SMALL LETTER U WITH RING ABOVE
    $fb: Result:= #$0171;  // LATIN SMALL LETTER U WITH WITH DOUBLE ACUTE
    $fe: Result:= #$0163;  // LATIN SMALL LETTER T WITH CEDILLA
    $ff: Result:= #$02d9;  // DOT ABOVE
  else
    Result:= WideChar(W);
  end;
end;

function Iso8859_3ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $a1: Result:= #$0126;  // LATIN CAPITAL LETTER H WITH STROKE
    $a2: Result:= #$02d8;  // BREVE
    $a5: raise EConvertError.CreateFmt('Invalid ISO-8859-3 sequence of code point %d',[W]);
    $a6: Result:= #$0124;  // LATIN CAPITAL LETTER H WITH CIRCUMFLEX
    $a9: Result:= #$0130;  // LATIN CAPITAL LETTER I WITH DOT ABOVE
    $aa: Result:= #$015e;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $ab: Result:= #$011e;  // LATIN CAPITAL LETTER G WITH BREVE
    $ac: Result:= #$0134;  // LATIN CAPITAL LETTER J WITH CIRCUMFLEX
    $ae: raise EConvertError.CreateFmt('Invalid ISO-8859-3 sequence of code point %d',[W]);
    $af: Result:= #$017b;  // LATIN CAPITAL LETTER Z WITH DOT
    $b1: Result:= #$0127;  // LATIN SMALL LETTER H WITH STROKE
    $b6: Result:= #$0125;  // LATIN SMALL LETTER H WITH CIRCUMFLEX
    $b9: Result:= #$0131;  // LATIN SMALL LETTER DOTLESS I
    $ba: Result:= #$015f;  // LATIN SMALL LETTER S WITH CEDILLA
    $bb: Result:= #$011f;  // LATIN SMALL LETTER G WITH BREVE
    $bc: Result:= #$0135;  // LATIN SMALL LETTER J WITH CIRCUMFLEX
    $be: raise EConvertError.CreateFmt('Invalid ISO-8859-3 sequence of code point %d',[W]);
    $bf: Result:= #$017c;  // LATIN SMALL LETTER Z WITH DOT
    $c3: raise EConvertError.CreateFmt('Invalid ISO-8859-3 sequence of code point %d',[W]);
    $c5: Result:= #$010a;  // LATIN CAPITAL LETTER C WITH DOT ABOVE
    $c6: Result:= #$0108;  // LATIN CAPITAL LETTER C WITH CIRCUMFLEX
    $d0: raise EConvertError.CreateFmt('Invalid ISO-8859-3 sequence of code point %d',[W]);
    $d5: Result:= #$0120;  // LATIN CAPITAL LETTER G WITH DOT ABOVE
    $d8: Result:= #$011c;  // LATIN CAPITAL LETTER G WITH CIRCUMFLEX
    $dd: Result:= #$016c;  // LATIN CAPITAL LETTER U WITH BREVE
    $de: Result:= #$015c;  // LATIN CAPITAL LETTER S WITH CIRCUMFLEX
    $e3: raise EConvertError.CreateFmt('Invalid ISO-8859-3 sequence of code point %d',[W]);
    $e5: Result:= #$010b;  // LATIN SMALL LETTER C WITH DOT ABOVE
    $e6: Result:= #$0109;  // LATIN SMALL LETTER C WITH CIRCUMFLEX
    $f0: raise EConvertError.CreateFmt('Invalid ISO-8859-3 sequence of code point %d',[W]);
    $f5: Result:= #$0121;  // LATIN SMALL LETTER G WITH DOT ABOVE
    $f8: Result:= #$011d;  // LATIN SMALL LETTER G WITH CIRCUMFLEX
    $fd: Result:= #$016d;  // LATIN SMALL LETTER U WITH BREVE
    $fe: Result:= #$015d;  // LATIN SMALL LETTER S WITH CIRCUMFLEX
    $ff: Result:= #$02d9;  // DOT ABOVE
  else
    Result:= WideChar(W);
  end;
end;

function Iso8859_4ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $a1: Result:= #$0104;  // LATIN CAPITAL LETTER A WITH OGONEK
    $a2: Result:= #$0138;  // LATIN SMALL LETTER KRA
    $a3: Result:= #$0156;  // LATIN CAPITAL LETTER R WITH CEDILLA
    $a5: Result:= #$0128;  // LATIN CAPITAL LETTER I WITH TILDE
    $a6: Result:= #$013b;  // LATIN CAPITAL LETTER L WITH CEDILLA
    $a9: Result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $aa: Result:= #$0112;  // LATIN CAPITAL LETTER E WITH MACRON
    $ab: Result:= #$0122;  // LATIN CAPITAL LETTER G WITH CEDILLA
    $ac: Result:= #$0166;  // LATIN CAPITAL LETTER T WITH STROKE
    $ae: Result:= #$017d;  // LATIN CAPITAL LETTER Z WITH CARON
    $b1: Result:= #$0105;  // LATIN SMALL LETTER A WITH OGONEK
    $b2: Result:= #$02db;  // OGONEK
    $b3: Result:= #$0157;  // LATIN SMALL LETTER R WITH CEDILLA
    $b5: Result:= #$0129;  // LATIN SMALL LETTER I WITH TILDE
    $b6: Result:= #$013c;  // LATIN SMALL LETTER L WITH CEDILLA
    $b7: Result:= #$02c7;  // CARON
    $b9: Result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $ba: Result:= #$0113;  // LATIN SMALL LETTER E WITH MACRON
    $bb: Result:= #$0123;  // LATIN SMALL LETTER G WITH CEDILLA
    $bc: Result:= #$0167;  // LATIN SMALL LETTER T WITH STROKE
    $bd: Result:= #$014a;  // LATIN CAPITAL LETTER ENG
    $be: Result:= #$017e;  // LATIN SMALL LETTER Z WITH CARON
    $bf: Result:= #$014b;  // LATIN SMALL LETTER ENG
    $c0: Result:= #$0100;  // LATIN CAPITAL LETTER A WITH MACRON
    $c7: Result:= #$012e;  // LATIN CAPITAL LETTER I WITH OGONEK
    $c8: Result:= #$010c;  // LATIN CAPITAL LETTER C WITH CARON
    $ca: Result:= #$0118;  // LATIN CAPITAL LETTER E WITH OGONEK
    $cc: Result:= #$0116;  // LATIN CAPITAL LETTER E WITH DOT ABOVE
    $cf: Result:= #$012a;  // LATIN CAPITAL LETTER I WITH MACRON
    $d0: Result:= #$0110;  // LATIN CAPITAL LETTER D WITH STROKE
    $d1: Result:= #$0145;  // LATIN CAPITAL LETTER N WITH CEDILLA
    $d2: Result:= #$014c;  // LATIN CAPITAL LETTER O WITH MACRON
    $d3: Result:= #$0136;  // LATIN CAPITAL LETTER K WITH CEDILLA
    $d9: Result:= #$0172;  // LATIN CAPITAL LETTER U WITH OGONEK
    $dd: Result:= #$0168;  // LATIN CAPITAL LETTER U WITH TILDE
    $de: Result:= #$016a;  // LATIN CAPITAL LETTER U WITH MACRON
    $e0: Result:= #$0101;  // LATIN SMALL LETTER A WITH MACRON
    $e7: Result:= #$012f;  // LATIN SMALL LETTER I WITH OGONEK
    $e8: Result:= #$010d;  // LATIN SMALL LETTER C WITH CARON
    $ea: Result:= #$0119;  // LATIN SMALL LETTER E WITH OGONEK
    $ec: Result:= #$0117;  // LATIN SMALL LETTER E WITH DOT ABOVE
    $ef: Result:= #$012b;  // LATIN SMALL LETTER I WITH MACRON
    $f0: Result:= #$0111;  // LATIN SMALL LETTER D WITH STROKE
    $f1: Result:= #$0146;  // LATIN SMALL LETTER N WITH CEDILLA
    $f2: Result:= #$014d;  // LATIN SMALL LETTER O WITH MACRON
    $f3: Result:= #$0137;  // LATIN SMALL LETTER K WITH CEDILLA
    $f9: Result:= #$0173;  // LATIN SMALL LETTER U WITH OGONEK
    $fd: Result:= #$0169;  // LATIN SMALL LETTER U WITH TILDE
    $fe: Result:= #$016b;  // LATIN SMALL LETTER U WITH MACRON
    $ff: Result:= #$02d9;  // DOT ABOVE
  else
    Result:= WideChar(W);
  end;
end;

function Iso8859_5ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$a0,$ad:
      Result:= WideChar(W);
    $f0: Result:= #$2116;  // NUMERO SIGN
    $fd: Result:= #$00a7;  // SECTION SIGN
  else
    Result:= WideChar(W+$0360);
  end;
end;

function Iso8859_6ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$a0,$a4,$ad:
      Result:= WideChar(W);
    $ac,$bb,$bf,$c1..$da,$e0..$f2:
      Result:= WideChar(W+$0580);
  else
    raise EConvertError.CreateFmt('Invalid ISO-8859-6 sequence of code point %d',[W]);
  end;
end;

function Iso8859_7ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$a0,$a3,$a6..$a9,$ab..$ad,$b0..$b3,$b7,$bb,$bd:
      Result:= WideChar(W);
    $a1: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $a2: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $af: Result:= #$2015;  // HORIZONTAL BAR
    $d2,$ff: raise EConvertError.CreateFmt('Invalid ISO-8859-7 sequence of code point %d',[W]);
  else
    Result:= WideChar(W+$02d0);
  end;
end;

function Iso8859_8ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$a0,$a2..$a9,$ab..$ae,$b0..$b9,$bb..$be:
      Result:= WideChar(W);
    $aa: Result:= #$00d7;  // MULTIPLICATION SIGN
    $af: Result:= #$203e;  // OVERLINE
    $ba: Result:= #$00f7;  // DIVISION SIGN
    $df: Result:= #$2017;  // DOUBLE LOW LINE
    $e0..$fa:
      Result:= WideChar(W+$04e0);
  else
    raise EConvertError.CreateFmt('Invalid ISO-8859-8 sequence of code point %d',[W]);
  end;
end;

function Iso8859_9ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $d0: Result:= #$011e;  // LATIN CAPITAL LETTER G WITH BREVE
    $dd: Result:= #$0130;  // LATIN CAPITAL LETTER I WITH DOT ABOVE
    $de: Result:= #$015e;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $f0: Result:= #$011f;  // LATIN SMALL LETTER G WITH BREVE
    $fd: Result:= #$0131;  // LATIN SMALL LETTER I WITH DOT ABOVE
    $fe: Result:= #$015f;  // LATIN SMALL LETTER S WITH CEDILLA
  else
    Result:= WideChar(W);
  end;
end;

function Iso8859_10ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $a1: Result:= #$0104;  // LATIN CAPITAL LETTER A WITH OGONEK
    $a2: Result:= #$0112;  // LATIN CAPITAL LETTER E WITH MACRON
    $a3: Result:= #$0122;  // LATIN CAPITAL LETTER G WITH CEDILLA
    $a4: Result:= #$012a;  // LATIN CAPITAL LETTER I WITH MACRON
    $a5: Result:= #$0128;  // LATIN CAPITAL LETTER I WITH TILDE
    $a6: Result:= #$0136;  // LATIN CAPITAL LETTER K WITH CEDILLA
    $a8: Result:= #$013b;  // LATIN CAPITAL LETTER L WITH CEDILLA
    $a9: Result:= #$0110;  // LATIN CAPITAL LETTER D WITH STROKE
    $aa: Result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $ab: Result:= #$0166;  // LATIN CAPITAL LETTER T WITH STROKE
    $ac: Result:= #$017d;  // LATIN CAPITAL LETTER Z WITH CARON
    $ae: Result:= #$016a;  // LATIN CAPITAL LETTER U WITH MACRON
    $af: Result:= #$014a;  // LATIN CAPITAL LETTER ENG
    $b1: Result:= #$0105;  // LATIN SMALL LETTER A WITH OGONEK
    $b2: Result:= #$0113;  // LATIN SMALL LETTER E WITH MACRON
    $b3: Result:= #$0123;  // LATIN SMALL LETTER G WITH CEDILLA
    $b4: Result:= #$012b;  // LATIN SMALL LETTER I WITH MACRON
    $b5: Result:= #$0129;  // LATIN SMALL LETTER I WITH TILDE
    $b6: Result:= #$0137;  // LATIN SMALL LETTER K WITH CEDILLA
    $b8: Result:= #$013c;  // LATIN SMALL LETTER L WITH CEDILLA
    $b9: Result:= #$0111;  // LATIN SMALL LETTER D WITH STROKE
    $ba: Result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $bb: Result:= #$0167;  // LATIN SMALL LETTER T WITH STROKE
    $bc: Result:= #$017e;  // LATIN SMALL LETTER Z WITH CARON
    $bd: Result:= #$2015;  // HORIZONTAL BAR
    $be: Result:= #$016b;  // LATIN SMALL LETTER U WITH MACRON
    $bf: Result:= #$014b;  // LATIN SMALL LETTER ENG
    $c0: Result:= #$0100;  // LATIN CAPITAL LETTER A WITH MACRON
    $c7: Result:= #$012e;  // LATIN CAPITAL LETTER I WITH OGONEK
    $c8: Result:= #$010c;  // LATIN CAPITAL LETTER C WITH CARON
    $ca: Result:= #$0118;  // LATIN CAPITAL LETTER E WITH OGONEK
    $cc: Result:= #$0116;  // LATIN CAPITAL LETTER E WITH DOT ABOVE
    $d1: Result:= #$0145;  // LATIN CAPITAL LETTER N WITH CEDILLA
    $d2: Result:= #$014c;  // LATIN CAPITAL LETTER O WITH MACRON
    $d7: Result:= #$0168;  // LATIN CAPITAL LETTER U WITH TILDE
    $d9: Result:= #$0172;  // LATIN CAPITAL LETTER U WITH OGONEK
    $e0: Result:= #$0101;  // LATIN SMALL LETTER A WITH MACRON
    $e7: Result:= #$012f;  // LATIN SMALL LETTER I WITH OGONEK
    $e8: Result:= #$010d;  // LATIN SMALL LETTER C WITH CARON
    $ea: Result:= #$0119;  // LATIN SMALL LETTER E WITH OGONEK
    $ec: Result:= #$0117;  // LATIN SMALL LETTER E WITH DOT ABOVE
    $f1: Result:= #$0146;  // LATIN SMALL LETTER N WITH CEDILLA
    $f2: Result:= #$014d;  // LATIN SMALL LETTER O WITH MACRON
    $f7: Result:= #$0169;  // LATIN SMALL LETTER U WITH TILDE
    $f9: Result:= #$0173;  // LATIN SMALL LETTER U WITH OGONEK
    $ff: Result:= #$0138;  // LATIN SMALL LETTER KRA
  else
    Result:= WideChar(W);
  end;
end;

function Iso8859_13ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $a1: Result:= #$201d;  // RIGHT DOUBLE QUOTATION MARK
    $a5: Result:= #$201e;  // DOUBLE LOW-9 QUOTATION MARK
    $a8: Result:= #$00d8;  // LATIN CAPITAL LETTER O WITH STROKE
    $aa: Result:= #$0156;  // LATIN CAPITAL LETTER R WITH CEDILLA
    $af: Result:= #$00c6;  // LATIN CAPITAL LETTER AE
    $b4: Result:= #$201c;  // LEFT DOUBLE QUOTATION MARK
    $b8: Result:= #$00f8;  // LATIN SMALL LETTER O WITH STROKE
    $ba: Result:= #$0157;  // LATIN SMALL LETTER R WITH CEDILLA
    $bf: Result:= #$00e6;  // LATIN SMALL LETTER AE
    $c0: Result:= #$0104;  // LATIN CAPITAL LETTER A WITH OGONEK
    $c1: Result:= #$012e;  // LATIN CAPITAL LETTER I WITH OGONEK
    $c2: Result:= #$0100;  // LATIN CAPITAL LETTER A WITH MACRON
    $c3: Result:= #$0106;  // LATIN CAPITAL LETTER C WITH ACUTE
    $c6: Result:= #$0118;  // LATIN CAPITAL LETTER E WITH OGONEK
    $c7: Result:= #$0112;  // LATIN CAPITAL LETTER E WITH MACRON
    $c8: Result:= #$010c;  // LATIN CAPITAL LETTER C WITH CARON
    $ca: Result:= #$0179;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $cb: Result:= #$0116;  // LATIN CAPITAL LETTER E WITH DOT ABOVE
    $cc: Result:= #$0122;  // LATIN CAPITAL LETTER G WITH CEDILLA
    $cd: Result:= #$0136;  // LATIN CAPITAL LETTER K WITH CEDILLA
    $ce: Result:= #$012a;  // LATIN CAPITAL LETTER I WITH MACRON
    $cf: Result:= #$013b;  // LATIN CAPITAL LETTER L WITH CEDILLA
    $d0: Result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $d1: Result:= #$0143;  // LATIN CAPITAL LETTER N WITH ACUTE
    $d2: Result:= #$0145;  // LATIN CAPITAL LETTER N WITH CEDILLA
    $d4: Result:= #$014c;  // LATIN CAPITAL LETTER O WITH MACRON
    $d8: Result:= #$0172;  // LATIN CAPITAL LETTER U WITH OGONEK
    $d9: Result:= #$0141;  // LATIN CAPITAL LETTER L WITH STROKE
    $da: Result:= #$015a;  // LATIN CAPITAL LETTER S WITH ACUTE
    $db: Result:= #$016a;  // LATIN CAPITAL LETTER U WITH MACRON
    $dd: Result:= #$017b;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $de: Result:= #$017d;  // LATIN CAPITAL LETTER Z WITH CARON
    $e0: Result:= #$0105;  // LATIN SMALL LETTER A WITH OGONEK
    $e1: Result:= #$012f;  // LATIN SMALL LETTER I WITH OGONEK
    $e2: Result:= #$0101;  // LATIN SMALL LETTER A WITH MACRON
    $e3: Result:= #$0107;  // LATIN SMALL LETTER C WITH ACUTE
    $e6: Result:= #$0119;  // LATIN SMALL LETTER E WITH OGONEK
    $e7: Result:= #$0113;  // LATIN SMALL LETTER E WITH MACRON
    $e8: Result:= #$010d;  // LATIN SMALL LETTER C WITH CARON
    $ea: Result:= #$017a;  // LATIN SMALL LETTER Z WITH ACUTE
    $eb: Result:= #$0117;  // LATIN SMALL LETTER E WITH DOT ABOVE
    $ec: Result:= #$0123;  // LATIN SMALL LETTER G WITH CEDILLA
    $ed: Result:= #$0137;  // LATIN SMALL LETTER K WITH CEDILLA
    $ee: Result:= #$012b;  // LATIN SMALL LETTER I WITH MACRON
    $ef: Result:= #$013c;  // LATIN SMALL LETTER L WITH CEDILLA
    $f0: Result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $f1: Result:= #$0144;  // LATIN SMALL LETTER N WITH ACUTE
    $f2: Result:= #$0146;  // LATIN SMALL LETTER N WITH CEDILLA
    $f4: Result:= #$014d;  // LATIN SMALL LETTER O WITH MACRON
    $f8: Result:= #$0173;  // LATIN SMALL LETTER U WITH OGONEK
    $f9: Result:= #$0142;  // LATIN SMALL LETTER L WITH STROKE
    $fa: Result:= #$015b;  // LATIN SMALL LETTER S WITH ACUTE
    $fb: Result:= #$016b;  // LATIN SMALL LETTER U WITH MACRON
    $fd: Result:= #$017c;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $fe: Result:= #$017e;  // LATIN SMALL LETTER Z WITH CARON
    $ff: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
  else
    Result:= WideChar(W);
  end;
end;

function Iso8859_14ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $a1: Result:= #$1e02;  // LATIN CAPITAL LETTER B WITH DOT ABOVE
    $a2: Result:= #$1e03;  // LATIN SMALL LETTER B WITH DOT ABOVE
    $a4: Result:= #$010a;  // LATIN CAPITAL LETTER C WITH DOT ABOVE
    $a5: Result:= #$010b;  // LATIN SMALL LETTER C WITH DOT ABOVE
    $a6: Result:= #$1e0a;  // LATIN CAPITAL LETTER D WITH DOT ABOVE
    $a8: Result:= #$1e80;  // LATIN CAPITAL LETTER W WITH GRAVE
    $aa: Result:= #$1e82;  // LATIN CAPITAL LETTER W WITH ACUTE
    $ab: Result:= #$1e0b;  // LATIN SMALL LETTER D WITH DOT ABOVE
    $ac: Result:= #$1ef2;  // LATIN CAPITAL LETTER Y WITH GRAVE
    $af: Result:= #$0178;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
    $b0: Result:= #$1e1e;  // LATIN CAPITAL LETTER F WITH DOT ABOVE
    $b1: Result:= #$1e1f;  // LATIN SMALL LETTER F WITH DOT ABOVE
    $b2: Result:= #$0120;  // LATIN CAPITAL LETTER G WITH DOT ABOVE
    $b3: Result:= #$0121;  // LATIN SMALL LETTER G WITH DOT ABOVE
    $b4: Result:= #$1e40;  // LATIN CAPITAL LETTER M WITH DOT ABOVE
    $b5: Result:= #$1e41;  // LATIN SMALL LETTER M WITH DOT ABOVE
    $b7: Result:= #$1e56;  // LATIN CAPITAL LETTER P WITH DOT ABOVE
    $b8: Result:= #$1e81;  // LATIN SMALL LETTER W WITH GRAVE
    $b9: Result:= #$1e57;  // LATIN SMALL LETTER P WITH DOT ABOVE
    $ba: Result:= #$1e83;  // LATIN SMALL LETTER W WITH ACUTE
    $bb: Result:= #$1e60;  // LATIN CAPITAL LETTER S WITH DOT ABOVE
    $bc: Result:= #$1ef3;  // LATIN SMALL LETTER Y WITH GRAVE
    $bd: Result:= #$1e84;  // LATIN CAPITAL LETTER W WITH DIAERESIS
    $be: Result:= #$1e85;  // LATIN SMALL LETTER W WITH DIAERESIS
    $bf: Result:= #$1e61;  // LATIN SMALL LETTER S WITH DOT ABOVE
    $d0: Result:= #$0174;  // LATIN CAPITAL LETTER W WITH CIRCUMFLEX
    $d7: Result:= #$1e6a;  // LATIN CAPITAL LETTER T WITH DOT ABOVE
    $de: Result:= #$0176;  // LATIN CAPITAL LETTER Y WITH CIRCUMFLEX
    $f0: Result:= #$0175;  // LATIN SMALL LETTER W WITH CIRCUMFLEX
    $f7: Result:= #$1e6b;  // LATIN SMALL LETTER T WITH DOT ABOVE
    $fe: Result:= #$0177;  // LATIN SMALL LETTER Y WITH CIRCUMFLEX
  else
    Result:= WideChar(W);
  end;
end;

function Iso8859_15ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $a4: Result:= #$20ac;  // EURO SIGN
    $a6: Result:= #$00a6;  // LATIN CAPITAL LETTER S WITH CARON
    $a8: Result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $b4: Result:= #$017d;  // LATIN CAPITAL LETTER Z WITH CARON
    $b8: Result:= #$017e;  // LATIN SMALL LETTER Z WITH CARON
    $bc: Result:= #$0152;  // LATIN CAPITAL LIGATURE OE
    $bd: Result:= #$0153;  // LATIN SMALL LIGATURE OE
    $be: Result:= #$0178;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
  else
    Result:= WideChar(W);
  end;
end;

function KOI8_RToUTF16Char(const W: word):WideChar;
begin
  case W of
    $80: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $81: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $82: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $83: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $84: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $85: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $86: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $87: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $88: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $89: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $8a: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $8b: Result:= #$2580;  // UPPER HALF BLOCK
    $8c: Result:= #$2584;  // LOWER HALF BLOCK
    $8d: Result:= #$2588;  // FULL BLOCK
    $8e: Result:= #$258c;  // LEFT HALF BLOCK
    $8f: Result:= #$2590;  // RIGHT HALF BLOCK
    $90: Result:= #$2591;  // LIGHT SHADE
    $91: Result:= #$2592;  // MEDIUM SHADE
    $92: Result:= #$2593;  // DARK SHADE
    $93: Result:= #$2320;  // TOP HALF INTEGRAL
    $94: Result:= #$25a0;  // BLACK SQUARE
    $95: Result:= #$2219;  // BULLET OPERATOR
    $96: Result:= #$221a;  // SQUARE ROOT
    $97: Result:= #$2248;  // ALMOST EQUAL TO
    $98: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $99: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $9a: Result:= #$00a0;  // NO-BREAK SPACE
    $9b: Result:= #$2321;  // BOTTOM HALF INTEGRAL
    $9c: Result:= #$00b0;  // DEGREE SIGN
    $9d: Result:= #$00b2;  // SUPERSCRIPT TWO
    $9e: Result:= #$00b7;  // MIDDLE DOT
    $9f: Result:= #$00f7;  // DIVISION SIGN
    $a0: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $a1: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $a2: Result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $a3: Result:= #$0451;  // CYRILLIC SMALL LETTER IO
    $a4: Result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $a5: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $a6: Result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $a7: Result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $a8: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $a9: Result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $aa: Result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $ab: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $ac: Result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $ad: Result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $ae: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $af: Result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $b0: Result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $b1: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $b2: Result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b3: Result:= #$0401;  // CYRILLIC CAPITAL LETTER IO
    $b4: Result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b5: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $b6: Result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $b7: Result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $b8: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $b9: Result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $ba: Result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $bb: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $bc: Result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $bd: Result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $be: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $bf: Result:= #$00a9;  // COPYRIGHT SIGN
    $c0: Result:= #$044e;  // CYRILLIC SMALL LETTER YU
    $c1: Result:= #$0430;  // CYRILLIC SMALL LETTER A
    $c2: Result:= #$0431;  // CYRILLIC SMALL LETTER BE
    $c3: Result:= #$0446;  // CYRILLIC SMALL LETTER TSE
    $c4: Result:= #$0434;  // CYRILLIC SMALL LETTER DE
    $c5: Result:= #$0435;  // CYRILLIC SMALL LETTER IE
    $c6: Result:= #$0444;  // CYRILLIC SMALL LETTER EF
    $c7: Result:= #$0433;  // CYRILLIC SMALL LETTER GHE
    $c8: Result:= #$0445;  // CYRILLIC SMALL LETTER HA
    $c9: Result:= #$0438;  // CYRILLIC SMALL LETTER I
    $ca: Result:= #$0439;  // CYRILLIC SMALL LETTER SHORT I
    $cb: Result:= #$043a;  // CYRILLIC SMALL LETTER KA
    $cc: Result:= #$043b;  // CYRILLIC SMALL LETTER EL
    $cd: Result:= #$043c;  // CYRILLIC SMALL LETTER EM
    $ce: Result:= #$043d;  // CYRILLIC SMALL LETTER EN
    $cf: Result:= #$043e;  // CYRILLIC SMALL LETTER O
    $d0: Result:= #$043f;  // CYRILLIC SMALL LETTER PE
    $d1: Result:= #$044f;  // CYRILLIC SMALL LETTER YA
    $d2: Result:= #$0440;  // CYRILLIC SMALL LETTER ER
    $d3: Result:= #$0441;  // CYRILLIC SMALL LETTER ES
    $d4: Result:= #$0442;  // CYRILLIC SMALL LETTER TE
    $d5: Result:= #$0443;  // CYRILLIC SMALL LETTER U
    $d6: Result:= #$0436;  // CYRILLIC SMALL LETTER ZHE
    $d7: Result:= #$0432;  // CYRILLIC SMALL LETTER VE
    $d8: Result:= #$044c;  // CYRILLIC SMALL LETTER SOFT SIGN
    $d9: Result:= #$044b;  // CYRILLIC SMALL LETTER YERU
    $da: Result:= #$0437;  // CYRILLIC SMALL LETTER ZE
    $db: Result:= #$0448;  // CYRILLIC SMALL LETTER SHA
    $dc: Result:= #$044d;  // CYRILLIC SMALL LETTER E
    $dd: Result:= #$0449;  // CYRILLIC SMALL LETTER SHCHA
    $de: Result:= #$0447;  // CYRILLIC SMALL LETTER CHE
    $df: Result:= #$044a;  // CYRILLIC SMALL LETTER HARD SIGN
    $e0: Result:= #$042e;  // CYRILLIC CAPITAL LETTER YU
    $e1: Result:= #$0410;  // CYRILLIC CAPITAL LETTER A
    $e2: Result:= #$0411;  // CYRILLIC CAPITAL LETTER BE
    $e3: Result:= #$0426;  // CYRILLIC CAPITAL LETTER TSE
    $e4: Result:= #$0414;  // CYRILLIC CAPITAL LETTER DE
    $e5: Result:= #$0415;  // CYRILLIC CAPITAL LETTER IE
    $e6: Result:= #$0424;  // CYRILLIC CAPITAL LETTER EF
    $e7: Result:= #$0413;  // CYRILLIC CAPITAL LETTER GHE
    $e8: Result:= #$0425;  // CYRILLIC CAPITAL LETTER HA
    $e9: Result:= #$0418;  // CYRILLIC CAPITAL LETTER I
    $ea: Result:= #$0419;  // CYRILLIC CAPITAL LETTER SHORT I
    $eb: Result:= #$041a;  // CYRILLIC CAPITAL LETTER KA
    $ec: Result:= #$041b;  // CYRILLIC CAPITAL LETTER EL
    $ed: Result:= #$041c;  // CYRILLIC CAPITAL LETTER EM
    $ee: Result:= #$041d;  // CYRILLIC CAPITAL LETTER EN
    $ef: Result:= #$041e;  // CYRILLIC CAPITAL LETTER O
    $f0: Result:= #$041f;  // CYRILLIC CAPITAL LETTER PE
    $f1: Result:= #$042f;  // CYRILLIC CAPITAL LETTER YA
    $f2: Result:= #$0420;  // CYRILLIC CAPITAL LETTER ER
    $f3: Result:= #$0421;  // CYRILLIC CAPITAL LETTER ES
    $f4: Result:= #$0422;  // CYRILLIC CAPITAL LETTER TE
    $f5: Result:= #$0423;  // CYRILLIC CAPITAL LETTER U
    $f6: Result:= #$0416;  // CYRILLIC CAPITAL LETTER ZHE
    $f7: Result:= #$0412;  // CYRILLIC CAPITAL LETTER VE
    $f8: Result:= #$042c;  // CYRILLIC CAPITAL LETTER SOFT SIGN
    $f9: Result:= #$042b;  // CYRILLIC CAPITAL LETTER YERU
    $fa: Result:= #$0417;  // CYRILLIC CAPITAL LETTER ZE
    $fb: Result:= #$0428;  // CYRILLIC CAPITAL LETTER SHA
    $fc: Result:= #$042d;  // CYRILLIC CAPITAL LETTER E
    $fd: Result:= #$0429;  // CYRILLIC CAPITAL LETTER SHCHA
    $fe: Result:= #$0427;  // CYRILLIC CAPITAL LETTER CHE
    $ff: Result:= #$042a;  // CYRILLIC CAPITAL LETTER HARD SIGN
  else
    Result:= WideChar(W);
  end;
end;

function JIS_X0201ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $20..$5B,$5D..$7D: Result:= WideChar(W);
    $5C: Result:= #$00A5;  //  YEN SIGN
    $7E: Result:= #$203E;  //  OVERLINE
    $A1..$DF: Result:= WideChar(W+$FEC0);
  else
    raise EConvertError.CreateFmt('Invalid JIS_X0201 sequence of code point %d',[W]);
  end;
end;

function nextStepToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$a1..$a3,$a5,$a7,$ab,$b6,$bb,$bf:
      Result:= WideChar(W);
    $80: Result:= #$00a0;  //  NO-BREAK SPACE
    $81: Result:= #$00c0;  //  LATIN CAPITAL LETTER A WITH GRAVE
    $82: Result:= #$00c1;  //  LATIN CAPITAL LETTER A WITH ACUTE
    $83: Result:= #$00c2;  //  LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00c3;  //  LATIN CAPITAL LETTER A WITH TILDE
    $85: Result:= #$00c4;  //  LATIN CAPITAL LETTER A WITH DIAERESIS
    $86: Result:= #$00c5;  //  LATIN CAPITAL LETTER A WITH RING
    $87: Result:= #$00c7;  //  LATIN CAPITAL LETTER C WITH CEDILLA
    $88: Result:= #$00c8;  //  LATIN CAPITAL LETTER E WITH GRAVE
    $89: Result:= #$00c9;  //  LATIN CAPITAL LETTER E WITH ACUTE
    $8a: Result:= #$00ca;  //  LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $8b: Result:= #$00cb;  //  LATIN CAPITAL LETTER E WITH DIAERESIS
    $8c: Result:= #$00cc;  //  LATIN CAPITAL LETTER I WITH GRAVE
    $8d: Result:= #$00cd;  //  LATIN CAPITAL LETTER I WITH ACUTE
    $8e: Result:= #$00ce;  //  LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $8f: Result:= #$00cf;  //  LATIN CAPITAL LETTER I WITH DIAERESIS
    $90: Result:= #$00d0;  //  LATIN CAPITAL LETTER ETH
    $91: Result:= #$00d1;  //  LATIN CAPITAL LETTER N WITH TILDE
    $92: Result:= #$00d2;  //  LATIN CAPITAL LETTER O WITH GRAVE
    $93: Result:= #$00d3;  //  LATIN CAPITAL LETTER O WITH ACUTE
    $94: Result:= #$00d4;  //  LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $95: Result:= #$00d5;  //  LATIN CAPITAL LETTER O WITH TILDE
    $96: Result:= #$00d6;  //  LATIN CAPITAL LETTER O WITH DIAERESIS
    $97: Result:= #$00d9;  //  LATIN CAPITAL LETTER U WITH GRAVE
    $98: Result:= #$00da;  //  LATIN CAPITAL LETTER U WITH ACUTE
    $99: Result:= #$00db;  //  LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $9a: Result:= #$00dc;  //  LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$00dd;  //  LATIN CAPITAL LETTER Y WITH ACUTE
    $9c: Result:= #$00de;  //  LATIN CAPITAL LETTER THORN
    $9d: Result:= #$00b5;  //  MICRO SIGN
    $9e: Result:= #$00d7;  //  MULTIPLICATION SIGN
    $9f: Result:= #$00f7;  //  DIVISION SIGN
    $a0: Result:= #$00a9;  //  COPYRIGHT SIGN
    $a4: Result:= #$2044;  //  FRACTION SLASH
    $a6: Result:= #$0192;  //  LATIN SMALL LETTER F WITH HOOK
    $a8: Result:= #$00a4;  //  CURRENCY SIGN
    $a9: Result:= #$2019;  //  RIGHT SINGLE QUOTATION MARK
    $aa: Result:= #$201c;  //  LEFT DOUBLE QUOTATION MARK
    $ac: Result:= #$2039;  //  LATIN SMALL LETTER
    $ad: Result:= #$203a;  //  LATIN SMALL LETTER
    $ae: Result:= #$fb01;  //  LATIN SMALL LIGATURE FI
    $af: Result:= #$fb02;  //  LATIN SMALL LIGATURE FL
    $b0: Result:= #$00ae;  //  REGISTERED SIGN
    $b1: Result:= #$2013;  //  EN DASH
    $b2: Result:= #$2020;  //  DAGGER
    $b3: Result:= #$2021;  //  DOUBLE DAGGER
    $b4: Result:= #$00b7;  //  MIDDLE DOT
    $b5: Result:= #$00a6;  //  BROKEN BAR
    $b7: Result:= #$2022;  //  BULLET
    $b8: Result:= #$201a;  //  SINGLE LOW-9 QUOTATION MARK
    $b9: Result:= #$201e;  //  DOUBLE LOW-9 QUOTATION MARK
    $ba: Result:= #$201d;  //  RIGHT DOUBLE QUOTATION MARK
    $bc: Result:= #$2026;  //  HORIZONTAL ELLIPSIS
    $bd: Result:= #$2030;  //  PER MILLE SIGN
    $be: Result:= #$00ac;  //  NOT SIGN
    $c0: Result:= #$00b9;  //  SUPERSCRIPT ONE
    $c1: Result:= #$02cb;  //  MODIFIER LETTER GRAVE ACCENT
    $c2: Result:= #$00b4;  //  ACUTE ACCENT
    $c3: Result:= #$02c6;  //  MODIFIER LETTER CIRCUMFLEX ACCENT
    $c4: Result:= #$02dc;  //  SMALL TILDE
    $c5: Result:= #$00af;  //  MACRON
    $c6: Result:= #$02d8;  //  BREVE
    $c7: Result:= #$02d9;  //  DOT ABOVE
    $c8: Result:= #$00a8;  //  DIAERESIS
    $c9: Result:= #$00b2;  //  SUPERSCRIPT TWO
    $ca: Result:= #$02da;  //  RING ABOVE
    $cb: Result:= #$00b8;  //  CEDILLA
    $cc: Result:= #$00b3;  //  SUPERSCRIPT THREE
    $cd: Result:= #$02dd;  //  DOUBLE ACUTE ACCENT
    $ce: Result:= #$02db;  //  OGONEK
    $cf: Result:= #$02c7;  //  CARON
    $d0: Result:= #$2014;  //  EM DASH
    $d1: Result:= #$00b1;  //  PLUS-MINUS SIGN
    $d2: Result:= #$00bc;  //  VULGAR FRACTION ONE QUARTER
    $d3: Result:= #$00bd;  //  VULGAR FRACTION ONE HALF
    $d4: Result:= #$00be;  //  VULGAR FRACTION THREE QUARTERS
    $d5: Result:= #$00e0;  //  LATIN SMALL LETTER A WITH GRAVE
    $d6: Result:= #$00e1;  //  LATIN SMALL LETTER A WITH ACUTE
    $d7: Result:= #$00e2;  //  LATIN SMALL LETTER A WITH CIRCUMFLEX
    $d8: Result:= #$00e3;  //  LATIN SMALL LETTER A WITH TILDE
    $d9: Result:= #$00e4;  //  LATIN SMALL LETTER A WITH DIAERESIS
    $da: Result:= #$00e5;  //  LATIN SMALL LETTER A WITH RING ABOVE
    $db: Result:= #$00e7;  //  LATIN SMALL LETTER C WITH CEDILLA
    $dc: Result:= #$00e8;  //  LATIN SMALL LETTER E WITH GRAVE
    $dd: Result:= #$00e9;  //  LATIN SMALL LETTER E WITH ACUTE
    $de: Result:= #$00ea;  //  LATIN SMALL LETTER E WITH CIRCUMFLEX
    $df: Result:= #$00eb;  //  LATIN SMALL LETTER E WITH DIAERESIS
    $e0: Result:= #$00ec;  //  LATIN SMALL LETTER I WITH GRAVE
    $e1: Result:= #$00c6;  //  LATIN CAPITAL LETTER AE
    $e2: Result:= #$00ed;  //  LATIN SMALL LETTER I WITH ACUTE
    $e3: Result:= #$00aa;  //  FEMININE ORDINAL INDICATOR
    $e4: Result:= #$00ee;  //  LATIN SMALL LETTER I WITH CIRCUMFLEX
    $e5: Result:= #$00ef;  //  LATIN SMALL LETTER I WITH DIAERESIS
    $e6: Result:= #$00f0;  //  LATIN SMALL LETTER ETH
    $e7: Result:= #$00f1;  //  LATIN SMALL LETTER N WITH TILDE
    $e8: Result:= #$0141;  //  LATIN CAPITAL LETTER L WITH STROKE
    $e9: Result:= #$00d8;  //  LATIN CAPITAL LETTER O WITH STROKE
    $ea: Result:= #$0152;  //  LATIN CAPITAL LIGATURE OE
    $eb: Result:= #$00ba;  //  MASCULINE ORDINAL INDICATOR
    $ec: Result:= #$00f2;  //  LATIN SMALL LETTER O WITH GRAVE
    $ed: Result:= #$00f3;  //  LATIN SMALL LETTER O WITH ACUTE
    $ee: Result:= #$00f4;  //  LATIN SMALL LETTER O WITH CIRCUMFLEX
    $ef: Result:= #$00f5;  //  LATIN SMALL LETTER O WITH TILDE
    $f0: Result:= #$00f6;  //  LATIN SMALL LETTER O WITH DIAERESIS
    $f1: Result:= #$00e6;  //  LATIN SMALL LETTER AE
    $f2: Result:= #$00f9;  //  LATIN SMALL LETTER U WITH GRAVE
    $f3: Result:= #$00fa;  //  LATIN SMALL LETTER U WITH ACUTE
    $f4: Result:= #$00fb;  //  LATIN SMALL LETTER U WITH CIRCUMFLEX
    $f5: Result:= #$0131;  //  LATIN SMALL LETTER DOTLESS I
    $f6: Result:= #$00fc;  //  LATIN SMALL LETTER U WITH DIAERESIS
    $f7: Result:= #$00fd;  //  LATIN SMALL LETTER Y WITH ACUTE
    $f8: Result:= #$0142;  //  LATIN SMALL LETTER L WITH STROKE
    $f9: Result:= #$00f8;  //  LATIN SMALL LETTER O WITH STROKE
    $fa: Result:= #$0153;  //  LATIN SMALL LIGATURE OE
    $fb: Result:= #$00df;  //  LATIN SMALL LETTER SHARP S
    $fc: Result:= #$00fe;  //  LATIN SMALL LETTER THORN
    $fd: Result:= #$00ff;  //  LATIN SMALL LETTER Y WITH DIAERESIS
    $fe: Result:= #$fffd;  //  .notdef, REPLACEMENT CHARACTER
    $ff: Result:= #$fffd;  //  .notdef, REPLACEMENT CHARACTER
  else
    raise EConvertError.CreateFmt('Invalid nextStep sequence of code point %d',[W]);
  end;
end;

function cp10000_MacRomanToUTF16Char(const W: word):WideChar;
begin
  case W of
    $80: Result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $81: Result:= #$00c5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $82: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $83: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $84: Result:= #$00d1;  // LATIN CAPITAL LETTER N WITH TILDE
    $85: Result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $86: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $87: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $88: Result:= #$00e0;  // LATIN SMALL LETTER A WITH GRAVE
    $89: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $8a: Result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $8b: Result:= #$00e3;  // LATIN SMALL LETTER A WITH TILDE
    $8c: Result:= #$00e5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $8d: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $8e: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $8f: Result:= #$00e8;  // LATIN SMALL LETTER E WITH GRAVE
    $90: Result:= #$00ea;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $91: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $92: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $93: Result:= #$00ec;  // LATIN SMALL LETTER I WITH GRAVE
    $94: Result:= #$00ee;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $95: Result:= #$00ef;  // LATIN SMALL LETTER I WITH DIAERESIS
    $96: Result:= #$00f1;  // LATIN SMALL LETTER N WITH TILDE
    $97: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $98: Result:= #$00f2;  // LATIN SMALL LETTER O WITH GRAVE
    $99: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $9a: Result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $9b: Result:= #$00f5;  // LATIN SMALL LETTER O WITH TILDE
    $9c: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $9d: Result:= #$00f9;  // LATIN SMALL LETTER U WITH GRAVE
    $9e: Result:= #$00fb;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $9f: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $a0: Result:= #$2020;  // DAGGER
    $a1: Result:= #$00b0;  // DEGREE SIGN
    $a4: Result:= #$00a7;  // SECTION SIGN
    $a5: Result:= #$2022;  // BULLET
    $a6: Result:= #$00b6;  // PILCROW SIGN
    $a7: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $a8: Result:= #$00ae;  // REGISTERED SIGN
    $aa: Result:= #$2122;  // TRADE MARK SIGN
    $ab: Result:= #$00b4;  // ACUTE ACCENT
    $ac: Result:= #$00a8;  // DIAERESIS
    $ad: Result:= #$2260;  // NOT EQUAL TO
    $ae: Result:= #$00c6;  // LATIN CAPITAL LIGATURE AE
    $af: Result:= #$00d8;  // LATIN CAPITAL LETTER O WITH STROKE
    $b0: Result:= #$221e;  // INFINITY
    $b2: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $b3: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $b4: Result:= #$00a5;  // YEN SIGN
    $b6: Result:= #$2202;  // PARTIAL DIFFERENTIAL
    $b7: Result:= #$2211;  // N-ARY SUMMATION
    $b8: Result:= #$220f;  // N-ARY PRODUCT
    $b9: Result:= #$03c0;  // GREEK SMALL LETTER PI
    $ba: Result:= #$222b;  // INTEGRAL
    $bb: Result:= #$00aa;  // FEMININE ORDINAL INDICATOR
    $bc: Result:= #$00ba;  // MASCULINE ORDINAL INDICATOR
    $bd: Result:= #$2126;  // OHM SIGN
    $be: Result:= #$00e6;  // LATIN SMALL LIGATURE AE
    $bf: Result:= #$00f8;  // LATIN SMALL LETTER O WITH STROKE
    $c0: Result:= #$00bf;  // INVERTED QUESTION MARK
    $c1: Result:= #$00a1;  // INVERTED EXCLAMATION MARK
    $c2: Result:= #$00ac;  // NOT SIGN
    $c3: Result:= #$221a;  // SQUARE ROOT
    $c4: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $c5: Result:= #$2248;  // ALMOST EQUAL TO
    $c6: Result:= #$2206;  // INCREMENT
    $c7: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $c8: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $c9: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $ca: Result:= #$00a0;  // NO-BREAK SPACE
    $cb: Result:= #$00c0;  // LATIN CAPITAL LETTER A WITH GRAVE
    $cc: Result:= #$00c3;  // LATIN CAPITAL LETTER A WITH TILDE
    $cd: Result:= #$00d5;  // LATIN CAPITAL LETTER O WITH TILDE
    $ce: Result:= #$0152;  // LATIN CAPITAL LIGATURE OE
    $cf: Result:= #$0153;  // LATIN SMALL LIGATURE OE
    $d0: Result:= #$2013;  // EN DASH
    $d1: Result:= #$2014;  // EM DASH
    $d2: Result:= #$201c;  // LEFT DOUBLE QUOTATION MARK
    $d3: Result:= #$201d;  // RIGHT DOUBLE QUOTATION MARK
    $d4: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $d5: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $d6: Result:= #$00f7;  // DIVISION SIGN
    $d7: Result:= #$25ca;  // LOZENGE
    $d8: Result:= #$00ff;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $d9: Result:= #$0178;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
    $da: Result:= #$2044;  // FRACTION SLASH
    $db: Result:= #$00a4;  // CURRENCY SIGN
    $dc: Result:= #$2039;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $dd: Result:= #$203a;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $de: Result:= #$fb01;  // LATIN SMALL LIGATURE FI
    $df: Result:= #$fb02;  // LATIN SMALL LIGATURE FL
    $e0: Result:= #$2021;  // DOUBLE DAGGER
    $e1: Result:= #$00b7;  // MIDDLE DOT
    $e2: Result:= #$201a;  // SINGLE LOW-9 QUOTATION MARK
    $e3: Result:= #$201e;  // DOUBLE LOW-9 QUOTATION MARK
    $e4: Result:= #$2030;  // PER MILLE SIGN
    $e5: Result:= #$00c2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $e6: Result:= #$00ca;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $e7: Result:= #$00c1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $e8: Result:= #$00cb;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $e9: Result:= #$00c8;  // LATIN CAPITAL LETTER E WITH GRAVE
    $ea: Result:= #$00cd;  // LATIN CAPITAL LETTER I WITH ACUTE
    $eb: Result:= #$00ce;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $ec: Result:= #$00cf;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $ed: Result:= #$00cc;  // LATIN CAPITAL LETTER I WITH GRAVE
    $ee: Result:= #$00d3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $ef: Result:= #$00d4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $f0: raise EConvertError.CreateFmt('Invalid cp10000_MacRoman sequence of code point %d',[W]);
    $f1: Result:= #$00d2;  // LATIN CAPITAL LETTER O WITH GRAVE
    $f2: Result:= #$00da;  // LATIN CAPITAL LETTER U WITH ACUTE
    $f3: Result:= #$00db;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $f4: Result:= #$00d9;  // LATIN CAPITAL LETTER U WITH GRAVE
    $f5: Result:= #$0131;  // LATIN SMALL LETTER DOTLESS I
    $f6: Result:= #$02c6;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $f7: Result:= #$02dc;  // SMALL TILDE
    $f8: Result:= #$00af;  // MACRON
    $f9: Result:= #$02d8;  // BREVE
    $fa: Result:= #$02d9;  // DOT ABOVE
    $fb: Result:= #$02da;  // RING ABOVE
    $fc: Result:= #$00b8;  // CEDILLA
    $fd: Result:= #$02dd;  // DOUBLE ACUTE ACCENT
    $fe: Result:= #$02db;  // OGONEK
    $ff: Result:= #$02c7;  // CARON
  else
    Result:= WideChar(W);
  end;
end;

function cp10006_MacGreekToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A9,$B1:
      Result:= WideChar(W);
    $80: Result:= #$00C4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $81: Result:= #$00B9;  // SUPERSCRIPT ONE
    $82: Result:= #$00B2;  // SUPERSCRIPT TWO
    $83: Result:= #$00C9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $84: Result:= #$00B3;  // SUPERSCRIPT THREE
    $85: Result:= #$00D6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $86: Result:= #$00DC;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $87: Result:= #$0385;  // GREEK DIALYTIKA TONOS
    $88: Result:= #$00E0;  // LATIN SMALL LETTER A WITH GRAVE
    $89: Result:= #$00E2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $8A: Result:= #$00E4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $8B: Result:= #$0384;  // GREEK TONOS
    $8C: Result:= #$00A8;  // DIAERESIS
    $8D: Result:= #$00E7;  // LATIN SMALL LETTER C WITH CEDILLA
    $8E: Result:= #$00E9;  // LATIN SMALL LETTER E WITH ACUTE
    $8F: Result:= #$00E8;  // LATIN SMALL LETTER E WITH GRAVE
    $90: Result:= #$00EA;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $91: Result:= #$00EB;  // LATIN SMALL LETTER E WITH DIAERESIS
    $92: Result:= #$00A3;  // POUND SIGN
    $93: Result:= #$2122;  // TRADE MARK SIGN
    $94: Result:= #$00EE;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $95: Result:= #$00EF;  // LATIN SMALL LETTER I WITH DIAERESIS
    $96: Result:= #$2022;  // BULLET
    $97: Result:= #$00BD;  // VULGAR FRACTION ONE HALF
    $98: Result:= #$2030;  // PER MILLE SIGN
    $99: Result:= #$00F4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $9A: Result:= #$00F6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $9B: Result:= #$00A6;  // BROKEN BAR
    $9C: Result:= #$00AD;  // SOFT HYPHEN
    $9D: Result:= #$00F9;  // LATIN SMALL LETTER U WITH GRAVE
    $9E: Result:= #$00FB;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $9F: Result:= #$00FC;  // LATIN SMALL LETTER U WITH DIAERESIS
    $A0: Result:= #$2020;  // DAGGER
    $A1: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $A2: Result:= #$0394;  // GREEK CAPITAL LETTER DELTA
    $A3: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $A4: Result:= #$039B;  // GREEK CAPITAL LETTER LAMBDA
    $A5: Result:= #$039E;  // GREEK CAPITAL LETTER XI
    $A6: Result:= #$03A0;  // GREEK CAPITAL LETTER PI
    $A7: Result:= #$00DF;  // LATIN SMALL LETTER SHARP S
    $A8: Result:= #$00AE;  // REGISTERED SIGN
    $AA: Result:= #$03A3;  // GREEK CAPITAL LETTER SIGMA
    $AB: Result:= #$03AA;  // GREEK CAPITAL LETTER IOTA WITH DIALYTIKA
    $AC: Result:= #$00A7;  // SECTION SIGN
    $AD: Result:= #$2260;  // NOT EQUAL TO
    $AE: Result:= #$00B0;  // DEGREE SIGN
    $AF: Result:= #$0387;  // GREEK ANO TELEIA
    $B0: Result:= #$0391;  // GREEK CAPITAL LETTER ALPHA
    $B2: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $B3: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $B4: Result:= #$00A5;  // YEN SIGN
    $B5: Result:= #$0392;  // GREEK CAPITAL LETTER BETA
    $B6: Result:= #$0395;  // GREEK CAPITAL LETTER EPSILON
    $B7: Result:= #$0396;  // GREEK CAPITAL LETTER ZETA
    $B8: Result:= #$0397;  // GREEK CAPITAL LETTER ETA
    $B9: Result:= #$0399;  // GREEK CAPITAL LETTER IOTA
    $BA: Result:= #$039A;  // GREEK CAPITAL LETTER KAPPA
    $BB: Result:= #$039C;  // GREEK CAPITAL LETTER MU
    $BC: Result:= #$03A6;  // GREEK CAPITAL LETTER PHI
    $BD: Result:= #$03AB;  // GREEK CAPITAL LETTER UPSILON WITH DIALYTIKA
    $BE: Result:= #$03A8;  // GREEK CAPITAL LETTER PSI
    $BF: Result:= #$03A9;  // GREEK CAPITAL LETTER OMEGA
    $C0: Result:= #$03AC;  // GREEK SMALL LETTER ALPHA WITH TONOS
    $C1: Result:= #$039D;  // GREEK CAPITAL LETTER NU
    $C2: Result:= #$00AC;  // NOT SIGN
    $C3: Result:= #$039F;  // GREEK CAPITAL LETTER OMICRON
    $C4: Result:= #$03A1;  // GREEK CAPITAL LETTER RHO
    $C5: Result:= #$2248;  // ALMOST EQUAL TO
    $C6: Result:= #$03A4;  // GREEK CAPITAL LETTER TAU
    $C7: Result:= #$00AB;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $C8: Result:= #$00BB;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $C9: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $CA: Result:= #$00A0;  // NO-BREAK SPACE
    $CB: Result:= #$03A5;  // GREEK CAPITAL LETTER UPSILON
    $CC: Result:= #$03A7;  // GREEK CAPITAL LETTER CHI
    $CD: Result:= #$0386;  // GREEK CAPITAL LETTER ALPHA WITH TONOS
    $CE: Result:= #$0388;  // GREEK CAPITAL LETTER EPSILON WITH TONOS
    $CF: Result:= #$0153;  // LATIN SMALL LIGATURE OE
    $D0: Result:= #$2013;  // EN DASH
    $D1: Result:= #$2015;  // HORIZONTAL BAR
    $D2: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $D3: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $D4: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $D5: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $D6: Result:= #$00F7;  // DIVISION SIGN
    $D7: Result:= #$0389;  // GREEK CAPITAL LETTER ETA WITH TONOS
    $D8: Result:= #$038A;  // GREEK CAPITAL LETTER IOTA WITH TONOS
    $D9: Result:= #$038C;  // GREEK CAPITAL LETTER OMICRON WITH TONOS
    $DA: Result:= #$038E;  // GREEK CAPITAL LETTER UPSILON WITH TONOS
    $DB: Result:= #$03AD;  // GREEK SMALL LETTER EPSILON WITH TONOS
    $DC: Result:= #$03AE;  // GREEK SMALL LETTER ETA WITH TONOS
    $DD: Result:= #$03AF;  // GREEK SMALL LETTER IOTA WITH TONOS
    $DE: Result:= #$03CC;  // GREEK SMALL LETTER OMICRON WITH TONOS
    $DF: Result:= #$038F;  // GREEK CAPITAL LETTER OMEGA WITH TONOS
    $E0: Result:= #$03CD;  // GREEK SMALL LETTER UPSILON WITH TONOS
    $E1: Result:= #$03B1;  // GREEK SMALL LETTER ALPHA
    $E2: Result:= #$03B2;  // GREEK SMALL LETTER BETA
    $E3: Result:= #$03C8;  // GREEK SMALL LETTER PSI
    $E4: Result:= #$03B4;  // GREEK SMALL LETTER DELTA
    $E5: Result:= #$03B5;  // GREEK SMALL LETTER EPSILON
    $E6: Result:= #$03C6;  // GREEK SMALL LETTER PHI
    $E7: Result:= #$03B3;  // GREEK SMALL LETTER GAMMA
    $E8: Result:= #$03B7;  // GREEK SMALL LETTER ETA
    $E9: Result:= #$03B9;  // GREEK SMALL LETTER IOTA
    $EA: Result:= #$03BE;  // GREEK SMALL LETTER XI
    $EB: Result:= #$03BA;  // GREEK SMALL LETTER KAPPA
    $EC: Result:= #$03BB;  // GREEK SMALL LETTER LAMBDA
    $ED: Result:= #$03BC;  // GREEK SMALL LETTER MU
    $EE: Result:= #$03BD;  // GREEK SMALL LETTER NU
    $EF: Result:= #$03BF;  // GREEK SMALL LETTER OMICRON
    $F0: Result:= #$03C0;  // GREEK SMALL LETTER PI
    $F1: Result:= #$03CE;  // GREEK SMALL LETTER OMEGA WITH TONOS
    $F2: Result:= #$03C1;  // GREEK SMALL LETTER RHO
    $F3: Result:= #$03C3;  // GREEK SMALL LETTER SIGMA
    $F4: Result:= #$03C4;  // GREEK SMALL LETTER TAU
    $F5: Result:= #$03B8;  // GREEK SMALL LETTER THETA
    $F6: Result:= #$03C9;  // GREEK SMALL LETTER OMEGA
    $F7: Result:= #$03C2;  // GREEK SMALL LETTER FINAL SIGMA
    $F8: Result:= #$03C7;  // GREEK SMALL LETTER CHI
    $F9: Result:= #$03C5;  // GREEK SMALL LETTER UPSILON
    $FA: Result:= #$03B6;  // GREEK SMALL LETTER ZETA
    $FB: Result:= #$03CA;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA
    $FC: Result:= #$03CB;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA
    $FD: Result:= #$0390;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA AND TONOS
    $FE: Result:= #$03B0;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA AND TONOS
  else
    raise EConvertError.CreateFmt('Invalid cp10006_MacGreek sequence of code point %d',[W]);
  end;
end;

function cp10007_MacCyrillicToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A2..$A3,$A9,$B1,$B5:
      Result:= WideChar(W);
    $80: Result:= #$0410;  // CYRILLIC CAPITAL LETTER A
    $81: Result:= #$0411;  // CYRILLIC CAPITAL LETTER BE
    $82: Result:= #$0412;  // CYRILLIC CAPITAL LETTER VE
    $83: Result:= #$0413;  // CYRILLIC CAPITAL LETTER GHE
    $84: Result:= #$0414;  // CYRILLIC CAPITAL LETTER DE
    $85: Result:= #$0415;  // CYRILLIC CAPITAL LETTER IE
    $86: Result:= #$0416;  // CYRILLIC CAPITAL LETTER ZHE
    $87: Result:= #$0417;  // CYRILLIC CAPITAL LETTER ZE
    $88: Result:= #$0418;  // CYRILLIC CAPITAL LETTER I
    $89: Result:= #$0419;  // CYRILLIC CAPITAL LETTER SHORT I
    $8A: Result:= #$041A;  // CYRILLIC CAPITAL LETTER KA
    $8B: Result:= #$041B;  // CYRILLIC CAPITAL LETTER EL
    $8C: Result:= #$041C;  // CYRILLIC CAPITAL LETTER EM
    $8D: Result:= #$041D;  // CYRILLIC CAPITAL LETTER EN
    $8E: Result:= #$041E;  // CYRILLIC CAPITAL LETTER O
    $8F: Result:= #$041F;  // CYRILLIC CAPITAL LETTER PE
    $90: Result:= #$0420;  // CYRILLIC CAPITAL LETTER ER
    $91: Result:= #$0421;  // CYRILLIC CAPITAL LETTER ES
    $92: Result:= #$0422;  // CYRILLIC CAPITAL LETTER TE
    $93: Result:= #$0423;  // CYRILLIC CAPITAL LETTER U
    $94: Result:= #$0424;  // CYRILLIC CAPITAL LETTER EF
    $95: Result:= #$0425;  // CYRILLIC CAPITAL LETTER HA
    $96: Result:= #$0426;  // CYRILLIC CAPITAL LETTER TSE
    $97: Result:= #$0427;  // CYRILLIC CAPITAL LETTER CHE
    $98: Result:= #$0428;  // CYRILLIC CAPITAL LETTER SHA
    $99: Result:= #$0429;  // CYRILLIC CAPITAL LETTER SHCHA
    $9A: Result:= #$042A;  // CYRILLIC CAPITAL LETTER HARD SIGN
    $9B: Result:= #$042B;  // CYRILLIC CAPITAL LETTER YERU
    $9C: Result:= #$042C;  // CYRILLIC CAPITAL LETTER SOFT SIGN
    $9D: Result:= #$042D;  // CYRILLIC CAPITAL LETTER E
    $9E: Result:= #$042E;  // CYRILLIC CAPITAL LETTER YU
    $9F: Result:= #$042F;  // CYRILLIC CAPITAL LETTER YA
    $A0: Result:= #$2020;  // DAGGER
    $A1: Result:= #$00B0;  // DEGREE SIGN
    $A4: Result:= #$00A7;  // SECTION SIGN
    $A5: Result:= #$2022;  // BULLET
    $A6: Result:= #$00B6;  // PILCROW SIGN
    $A7: Result:= #$0406;  // CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I
    $A8: Result:= #$00AE;  // REGISTERED SIGN
    $AA: Result:= #$2122;  // TRADE MARK SIGN
    $AB: Result:= #$0402;  // CYRILLIC CAPITAL LETTER DJE
    $AC: Result:= #$0452;  // CYRILLIC SMALL LETTER DJE
    $AD: Result:= #$2260;  // NOT EQUAL TO
    $AE: Result:= #$0403;  // CYRILLIC CAPITAL LETTER GJE
    $AF: Result:= #$0453;  // CYRILLIC SMALL LETTER GJE
    $B0: Result:= #$221E;  // INFINITY
    $B2: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $B3: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $B4: Result:= #$0456;  // CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I
    $B6: Result:= #$2202;  // PARTIAL DIFFERENTIAL
    $B7: Result:= #$0408;  // CYRILLIC CAPITAL LETTER JE
    $B8: Result:= #$0404;  // CYRILLIC CAPITAL LETTER UKRAINIAN IE
    $B9: Result:= #$0454;  // CYRILLIC SMALL LETTER UKRAINIAN IE
    $BA: Result:= #$0407;  // CYRILLIC CAPITAL LETTER YI
    $BB: Result:= #$0457;  // CYRILLIC SMALL LETTER YI
    $BC: Result:= #$0409;  // CYRILLIC CAPITAL LETTER LJE
    $BD: Result:= #$0459;  // CYRILLIC SMALL LETTER LJE
    $BE: Result:= #$040A;  // CYRILLIC CAPITAL LETTER NJE
    $BF: Result:= #$045A;  // CYRILLIC SMALL LETTER NJE
    $C0: Result:= #$0458;  // CYRILLIC SMALL LETTER JE
    $C1: Result:= #$0405;  // CYRILLIC CAPITAL LETTER DZE
    $C2: Result:= #$00AC;  // NOT SIGN
    $C3: Result:= #$221A;  // SQUARE ROOT
    $C4: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $C5: Result:= #$2248;  // ALMOST EQUAL TO
    $C6: Result:= #$2206;  // INCREMENT
    $C7: Result:= #$00AB;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $C8: Result:= #$00BB;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $C9: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $CA: Result:= #$00A0;  // NO-BREAK SPACE
    $CB: Result:= #$040B;  // CYRILLIC CAPITAL LETTER TSHE
    $CC: Result:= #$045B;  // CYRILLIC SMALL LETTER TSHE
    $CD: Result:= #$040C;  // CYRILLIC CAPITAL LETTER KJE
    $CE: Result:= #$045C;  // CYRILLIC SMALL LETTER KJE
    $CF: Result:= #$0455;  // CYRILLIC SMALL LETTER DZE
    $D0: Result:= #$2013;  // EN DASH
    $D1: Result:= #$2014;  // EM DASH
    $D2: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $D3: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $D4: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $D5: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $D6: Result:= #$00F7;  // DIVISION SIGN
    $D7: Result:= #$201E;  // DOUBLE LOW-9 QUOTATION MARK
    $D8: Result:= #$040E;  // CYRILLIC CAPITAL LETTER SHORT U
    $D9: Result:= #$045E;  // CYRILLIC SMALL LETTER SHORT U
    $DA: Result:= #$040F;  // CYRILLIC CAPITAL LETTER DZHE
    $DB: Result:= #$045F;  // CYRILLIC SMALL LETTER DZHE
    $DC: Result:= #$2116;  // NUMERO SIGN
    $DD: Result:= #$0401;  // CYRILLIC CAPITAL LETTER IO
    $DE: Result:= #$0451;  // CYRILLIC SMALL LETTER IO
    $DF: Result:= #$044F;  // CYRILLIC SMALL LETTER YA
    $E0: Result:= #$0430;  // CYRILLIC SMALL LETTER A
    $E1: Result:= #$0431;  // CYRILLIC SMALL LETTER BE
    $E2: Result:= #$0432;  // CYRILLIC SMALL LETTER VE
    $E3: Result:= #$0433;  // CYRILLIC SMALL LETTER GHE
    $E4: Result:= #$0434;  // CYRILLIC SMALL LETTER DE
    $E5: Result:= #$0435;  // CYRILLIC SMALL LETTER IE
    $E6: Result:= #$0436;  // CYRILLIC SMALL LETTER ZHE
    $E7: Result:= #$0437;  // CYRILLIC SMALL LETTER ZE
    $E8: Result:= #$0438;  // CYRILLIC SMALL LETTER I
    $E9: Result:= #$0439;  // CYRILLIC SMALL LETTER SHORT I
    $EA: Result:= #$043A;  // CYRILLIC SMALL LETTER KA
    $EB: Result:= #$043B;  // CYRILLIC SMALL LETTER EL
    $EC: Result:= #$043C;  // CYRILLIC SMALL LETTER EM
    $ED: Result:= #$043D;  // CYRILLIC SMALL LETTER EN
    $EE: Result:= #$043E;  // CYRILLIC SMALL LETTER O
    $EF: Result:= #$043F;  // CYRILLIC SMALL LETTER PE
    $F0: Result:= #$0440;  // CYRILLIC SMALL LETTER ER
    $F1: Result:= #$0441;  // CYRILLIC SMALL LETTER ES
    $F2: Result:= #$0442;  // CYRILLIC SMALL LETTER TE
    $F3: Result:= #$0443;  // CYRILLIC SMALL LETTER U
    $F4: Result:= #$0444;  // CYRILLIC SMALL LETTER EF
    $F5: Result:= #$0445;  // CYRILLIC SMALL LETTER HA
    $F6: Result:= #$0446;  // CYRILLIC SMALL LETTER TSE
    $F7: Result:= #$0447;  // CYRILLIC SMALL LETTER CHE
    $F8: Result:= #$0448;  // CYRILLIC SMALL LETTER SHA
    $F9: Result:= #$0449;  // CYRILLIC SMALL LETTER SHCHA
    $FA: Result:= #$044A;  // CYRILLIC SMALL LETTER HARD SIGN
    $FB: Result:= #$044B;  // CYRILLIC SMALL LETTER YERU
    $FC: Result:= #$044C;  // CYRILLIC SMALL LETTER SOFT SIGN
    $FD: Result:= #$044D;  // CYRILLIC SMALL LETTER E
    $FE: Result:= #$044E;  // CYRILLIC SMALL LETTER YU
    $FF: Result:= #$00A4;  // CURRENCY SIGN
  else
    raise EConvertError.CreateFmt('Invalid cp10007_MacCyrillic sequence of code point %d',[W]);
  end;
end;

function cp10029_MacLatin2ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A3,$A9:
      Result:= WideChar(W);
    $80: Result:= #$00C4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $81: Result:= #$0100;  // LATIN CAPITAL LETTER A WITH MACRON
    $82: Result:= #$0101;  // LATIN SMALL LETTER A WITH MACRON
    $83: Result:= #$00C9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $84: Result:= #$0104;  // LATIN CAPITAL LETTER A WITH OGONEK
    $85: Result:= #$00D6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $86: Result:= #$00DC;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $87: Result:= #$00E1;  // LATIN SMALL LETTER A WITH ACUTE
    $88: Result:= #$0105;  // LATIN SMALL LETTER A WITH OGONEK
    $89: Result:= #$010C;  // LATIN CAPITAL LETTER C WITH CARON
    $8A: Result:= #$00E4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $8B: Result:= #$010D;  // LATIN SMALL LETTER C WITH CARON
    $8C: Result:= #$0106;  // LATIN CAPITAL LETTER C WITH ACUTE
    $8D: Result:= #$0107;  // LATIN SMALL LETTER C WITH ACUTE
    $8E: Result:= #$00E9;  // LATIN SMALL LETTER E WITH ACUTE
    $8F: Result:= #$0179;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $90: Result:= #$017A;  // LATIN SMALL LETTER Z WITH ACUTE
    $91: Result:= #$010E;  // LATIN CAPITAL LETTER D WITH CARON
    $92: Result:= #$00ED;  // LATIN SMALL LETTER I WITH ACUTE
    $93: Result:= #$010F;  // LATIN SMALL LETTER D WITH CARON
    $94: Result:= #$0112;  // LATIN CAPITAL LETTER E WITH MACRON
    $95: Result:= #$0113;  // LATIN SMALL LETTER E WITH MACRON
    $96: Result:= #$0116;  // LATIN CAPITAL LETTER E WITH DOT ABOVE
    $97: Result:= #$00F3;  // LATIN SMALL LETTER O WITH ACUTE
    $98: Result:= #$0117;  // LATIN SMALL LETTER E WITH DOT ABOVE
    $99: Result:= #$00F4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $9A: Result:= #$00F6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $9B: Result:= #$00F5;  // LATIN SMALL LETTER O WITH TILDE
    $9C: Result:= #$00FA;  // LATIN SMALL LETTER U WITH ACUTE
    $9D: Result:= #$011A;  // LATIN CAPITAL LETTER E WITH CARON
    $9E: Result:= #$011B;  // LATIN SMALL LETTER E WITH CARON
    $9F: Result:= #$00FC;  // LATIN SMALL LETTER U WITH DIAERESIS
    $A0: Result:= #$2020;  // DAGGER
    $A1: Result:= #$00B0;  // DEGREE SIGN
    $A2: Result:= #$0118;  // LATIN CAPITAL LETTER E WITH OGONEK
    $A4: Result:= #$00A7;  // SECTION SIGN
    $A5: Result:= #$2022;  // BULLET
    $A6: Result:= #$00B6;  // PILCROW SIGN
    $A7: Result:= #$00DF;  // LATIN SMALL LETTER SHARP S
    $A8: Result:= #$00AE;  // REGISTERED SIGN
    $AA: Result:= #$2122;  // TRADE MARK SIGN
    $AB: Result:= #$0119;  // LATIN SMALL LETTER E WITH OGONEK
    $AC: Result:= #$00A8;  // DIAERESIS
    $AD: Result:= #$2260;  // NOT EQUAL TO
    $AE: Result:= #$0123;  // LATIN SMALL LETTER G WITH CEDILLA
    $AF: Result:= #$012E;  // LATIN CAPITAL LETTER I WITH OGONEK
    $B0: Result:= #$012F;  // LATIN SMALL LETTER I WITH OGONEK
    $B1: Result:= #$012A;  // LATIN CAPITAL LETTER I WITH MACRON
    $B2: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $B3: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $B4: Result:= #$012B;  // LATIN SMALL LETTER I WITH MACRON
    $B5: Result:= #$0136;  // LATIN CAPITAL LETTER K WITH CEDILLA
    $B6: Result:= #$2202;  // PARTIAL DIFFERENTIAL
    $B7: Result:= #$2211;  // N-ARY SUMMATION
    $B8: Result:= #$0142;  // LATIN SMALL LETTER L WITH STROKE
    $B9: Result:= #$013B;  // LATIN CAPITAL LETTER L WITH CEDILLA
    $BA: Result:= #$013C;  // LATIN SMALL LETTER L WITH CEDILLA
    $BB: Result:= #$013D;  // LATIN CAPITAL LETTER L WITH CARON
    $BC: Result:= #$013E;  // LATIN SMALL LETTER L WITH CARON
    $BD: Result:= #$0139;  // LATIN CAPITAL LETTER L WITH ACUTE
    $BE: Result:= #$013A;  // LATIN SMALL LETTER L WITH ACUTE
    $BF: Result:= #$0145;  // LATIN CAPITAL LETTER N WITH CEDILLA
    $C0: Result:= #$0146;  // LATIN SMALL LETTER N WITH CEDILLA
    $C1: Result:= #$0143;  // LATIN CAPITAL LETTER N WITH ACUTE
    $C2: Result:= #$00AC;  // NOT SIGN
    $C3: Result:= #$221A;  // SQUARE ROOT
    $C4: Result:= #$0144;  // LATIN SMALL LETTER N WITH ACUTE
    $C5: Result:= #$0147;  // LATIN CAPITAL LETTER N WITH CARON
    $C6: Result:= #$2206;  // INCREMENT
    $C7: Result:= #$00AB;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $C8: Result:= #$00BB;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $C9: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $CA: Result:= #$00A0;  // NO-BREAK SPACE
    $CB: Result:= #$0148;  // LATIN SMALL LETTER N WITH CARON
    $CC: Result:= #$0150;  // LATIN CAPITAL LETTER O WITH DOUBLE ACUTE
    $CD: Result:= #$00D5;  // LATIN CAPITAL LETTER O WITH TILDE
    $CE: Result:= #$0151;  // LATIN SMALL LETTER O WITH DOUBLE ACUTE
    $CF: Result:= #$014C;  // LATIN CAPITAL LETTER O WITH MACRON
    $D0: Result:= #$2013;  // EN DASH
    $D1: Result:= #$2014;  // EM DASH
    $D2: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $D3: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $D4: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $D5: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $D6: Result:= #$00F7;  // DIVISION SIGN
    $D7: Result:= #$25CA;  // LOZENGE
    $D8: Result:= #$014D;  // LATIN SMALL LETTER O WITH MACRON
    $D9: Result:= #$0154;  // LATIN CAPITAL LETTER R WITH ACUTE
    $DA: Result:= #$0155;  // LATIN SMALL LETTER R WITH ACUTE
    $DB: Result:= #$0158;  // LATIN CAPITAL LETTER R WITH CARON
    $DC: Result:= #$2039;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $DD: Result:= #$203A;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $DE: Result:= #$0159;  // LATIN SMALL LETTER R WITH CARON
    $DF: Result:= #$0156;  // LATIN CAPITAL LETTER R WITH CEDILLA
    $E0: Result:= #$0157;  // LATIN SMALL LETTER R WITH CEDILLA
    $E1: Result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $E2: Result:= #$201A;  // SINGLE LOW-9 QUOTATION MARK
    $E3: Result:= #$201E;  // DOUBLE LOW-9 QUOTATION MARK
    $E4: Result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $E5: Result:= #$015A;  // LATIN CAPITAL LETTER S WITH ACUTE
    $E6: Result:= #$015B;  // LATIN SMALL LETTER S WITH ACUTE
    $E7: Result:= #$00C1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $E8: Result:= #$0164;  // LATIN CAPITAL LETTER T WITH CARON
    $E9: Result:= #$0165;  // LATIN SMALL LETTER T WITH CARON
    $EA: Result:= #$00CD;  // LATIN CAPITAL LETTER I WITH ACUTE
    $EB: Result:= #$017D;  // LATIN CAPITAL LETTER Z WITH CARON
    $EC: Result:= #$017E;  // LATIN SMALL LETTER Z WITH CARON
    $ED: Result:= #$016A;  // LATIN CAPITAL LETTER U WITH MACRON
    $EE: Result:= #$00D3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $EF: Result:= #$00D4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $F0: Result:= #$016B;  // LATIN SMALL LETTER U WITH MACRON
    $F1: Result:= #$016E;  // LATIN CAPITAL LETTER U WITH RING ABOVE
    $F2: Result:= #$00DA;  // LATIN CAPITAL LETTER U WITH ACUTE
    $F3: Result:= #$016F;  // LATIN SMALL LETTER U WITH RING ABOVE
    $F4: Result:= #$0170;  // LATIN CAPITAL LETTER U WITH DOUBLE ACUTE
    $F5: Result:= #$0171;  // LATIN SMALL LETTER U WITH DOUBLE ACUTE
    $F6: Result:= #$0172;  // LATIN CAPITAL LETTER U WITH OGONEK
    $F7: Result:= #$0173;  // LATIN SMALL LETTER U WITH OGONEK
    $F8: Result:= #$00DD;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $F9: Result:= #$00FD;  // LATIN SMALL LETTER Y WITH ACUTE
    $FA: Result:= #$0137;  // LATIN SMALL LETTER K WITH CEDILLA
    $FB: Result:= #$017B;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $FC: Result:= #$0141;  // LATIN CAPITAL LETTER L WITH STROKE
    $FD: Result:= #$017C;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $FE: Result:= #$0122;  // LATIN CAPITAL LETTER G WITH CEDILLA
    $FF: Result:= #$02C7;  // CARON
  else
    raise EConvertError.CreateFmt('Invalid cp10029_MacLatin2 sequence of code point %d',[W]);
  end;
end;

function cp10079_MacIcelandicToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A2..$A3,$A9,$B1,$B5,$DE:
      Result:= WideChar(W);
    $80: Result:= #$00C4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $81: Result:= #$00C5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $82: Result:= #$00C7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $83: Result:= #$00C9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $84: Result:= #$00D1;  // LATIN CAPITAL LETTER N WITH TILDE
    $85: Result:= #$00D6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $86: Result:= #$00DC;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $87: Result:= #$00E1;  // LATIN SMALL LETTER A WITH ACUTE
    $88: Result:= #$00E0;  // LATIN SMALL LETTER A WITH GRAVE
    $89: Result:= #$00E2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $8A: Result:= #$00E4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $8B: Result:= #$00E3;  // LATIN SMALL LETTER A WITH TILDE
    $8C: Result:= #$00E5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $8D: Result:= #$00E7;  // LATIN SMALL LETTER C WITH CEDILLA
    $8E: Result:= #$00E9;  // LATIN SMALL LETTER E WITH ACUTE
    $8F: Result:= #$00E8;  // LATIN SMALL LETTER E WITH GRAVE
    $90: Result:= #$00EA;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $91: Result:= #$00EB;  // LATIN SMALL LETTER E WITH DIAERESIS
    $92: Result:= #$00ED;  // LATIN SMALL LETTER I WITH ACUTE
    $93: Result:= #$00EC;  // LATIN SMALL LETTER I WITH GRAVE
    $94: Result:= #$00EE;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $95: Result:= #$00EF;  // LATIN SMALL LETTER I WITH DIAERESIS
    $96: Result:= #$00F1;  // LATIN SMALL LETTER N WITH TILDE
    $97: Result:= #$00F3;  // LATIN SMALL LETTER O WITH ACUTE
    $98: Result:= #$00F2;  // LATIN SMALL LETTER O WITH GRAVE
    $99: Result:= #$00F4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $9A: Result:= #$00F6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $9B: Result:= #$00F5;  // LATIN SMALL LETTER O WITH TILDE
    $9C: Result:= #$00FA;  // LATIN SMALL LETTER U WITH ACUTE
    $9D: Result:= #$00F9;  // LATIN SMALL LETTER U WITH GRAVE
    $9E: Result:= #$00FB;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $9F: Result:= #$00FC;  // LATIN SMALL LETTER U WITH DIAERESIS
    $A0: Result:= #$00DD;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $A1: Result:= #$00B0;  // DEGREE SIGN
    $A4: Result:= #$00A7;  // SECTION SIGN
    $A5: Result:= #$2022;  // BULLET
    $A6: Result:= #$00B6;  // PILCROW SIGN
    $A7: Result:= #$00DF;  // LATIN SMALL LETTER SHARP S
    $A8: Result:= #$00AE;  // REGISTERED SIGN
    $AA: Result:= #$2122;  // TRADE MARK SIGN
    $AB: Result:= #$00B4;  // ACUTE ACCENT
    $AC: Result:= #$00A8;  // DIAERESIS
    $AD: Result:= #$2260;  // NOT EQUAL TO
    $AE: Result:= #$00C6;  // LATIN CAPITAL LIGATURE AE
    $AF: Result:= #$00D8;  // LATIN CAPITAL LETTER O WITH STROKE
    $B0: Result:= #$221E;  // INFINITY
    $B2: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $B3: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $B4: Result:= #$00A5;  // YEN SIGN
    $B6: Result:= #$2202;  // PARTIAL DIFFERENTIAL
    $B7: Result:= #$2211;  // N-ARY SUMMATION
    $B8: Result:= #$220F;  // N-ARY PRODUCT
    $B9: Result:= #$03C0;  // GREEK SMALL LETTER PI
    $BA: Result:= #$222B;  // INTEGRAL
    $BB: Result:= #$00AA;  // FEMININE ORDINAL INDICATOR
    $BC: Result:= #$00BA;  // MASCULINE ORDINAL INDICATOR
    $BD: Result:= #$2126;  // OHM SIGN
    $BE: Result:= #$00E6;  // LATIN SMALL LIGATURE AE
    $BF: Result:= #$00F8;  // LATIN SMALL LETTER O WITH STROKE
    $C0: Result:= #$00BF;  // INVERTED QUESTION MARK
    $C1: Result:= #$00A1;  // INVERTED EXCLAMATION MARK
    $C2: Result:= #$00AC;  // NOT SIGN
    $C3: Result:= #$221A;  // SQUARE ROOT
    $C4: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $C5: Result:= #$2248;  // ALMOST EQUAL TO
    $C6: Result:= #$2206;  // INCREMENT
    $C7: Result:= #$00AB;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $C8: Result:= #$00BB;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $C9: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $CA: Result:= #$00A0;  // NO-BREAK SPACE
    $CB: Result:= #$00C0;  // LATIN CAPITAL LETTER A WITH GRAVE
    $CC: Result:= #$00C3;  // LATIN CAPITAL LETTER A WITH TILDE
    $CD: Result:= #$00D5;  // LATIN CAPITAL LETTER O WITH TILDE
    $CE: Result:= #$0152;  // LATIN CAPITAL LIGATURE OE
    $CF: Result:= #$0153;  // LATIN SMALL LIGATURE OE
    $D0: Result:= #$2013;  // EN DASH
    $D1: Result:= #$2014;  // EM DASH
    $D2: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $D3: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $D4: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $D5: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $D6: Result:= #$00F7;  // DIVISION SIGN
    $D7: Result:= #$25CA;  // LOZENGE
    $D8: Result:= #$00FF;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $D9: Result:= #$0178;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
    $DA: Result:= #$2044;  // FRACTION SLASH
    $DB: Result:= #$00A4;  // CURRENCY SIGN
    $DC: Result:= #$00D0;  // LATIN CAPITAL LETTER ETH
    $DD: Result:= #$00F0;  // LATIN SMALL LETTER ETH
    $DF: Result:= #$00FE;  // LATIN SMALL LETTER THORN
    $E0: Result:= #$00FD;  // LATIN SMALL LETTER Y WITH ACUTE
    $E1: Result:= #$00B7;  // MIDDLE DOT
    $E2: Result:= #$201A;  // SINGLE LOW-9 QUOTATION MARK
    $E3: Result:= #$201E;  // DOUBLE LOW-9 QUOTATION MARK
    $E4: Result:= #$2030;  // PER MILLE SIGN
    $E5: Result:= #$00C2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $E6: Result:= #$00CA;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $E7: Result:= #$00C1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $E8: Result:= #$00CB;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $E9: Result:= #$00C8;  // LATIN CAPITAL LETTER E WITH GRAVE
    $EA: Result:= #$00CD;  // LATIN CAPITAL LETTER I WITH ACUTE
    $EB: Result:= #$00CE;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $EC: Result:= #$00CF;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $ED: Result:= #$00CC;  // LATIN CAPITAL LETTER I WITH GRAVE
    $EE: Result:= #$00D3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $EF: Result:= #$00D4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $F1: Result:= #$00D2;  // LATIN CAPITAL LETTER O WITH GRAVE
    $F2: Result:= #$00DA;  // LATIN CAPITAL LETTER U WITH ACUTE
    $F3: Result:= #$00DB;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $F4: Result:= #$00D9;  // LATIN CAPITAL LETTER U WITH GRAVE
    $F5: Result:= #$0131;  // LATIN SMALL LETTER DOTLESS I
    $F6: Result:= #$02C6;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $F7: Result:= #$02DC;  // SMALL TILDE
    $F8: Result:= #$00AF;  // MACRON
    $F9: Result:= #$02D8;  // BREVE
    $FA: Result:= #$02D9;  // DOT ABOVE
    $FB: Result:= #$02DA;  // RING ABOVE
    $FC: Result:= #$00B8;  // CEDILLA
    $FD: Result:= #$02DD;  // DOUBLE ACUTE ACCENT
    $FE: Result:= #$02DB;  // OGONEK
    $FF: Result:= #$02C7;  // CARON
  else
    raise EConvertError.CreateFmt('Invalid cp10079_MacIcelandic sequence of code point %d',[W]);
  end;
end;

function cp10081_MacTurkishToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A2..$A3,$A9,$B1,$B5:
      Result:= WideChar(W);
    $80: Result:= #$00C4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $81: Result:= #$00C5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $82: Result:= #$00C7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $83: Result:= #$00C9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $84: Result:= #$00D1;  // LATIN CAPITAL LETTER N WITH TILDE
    $85: Result:= #$00D6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $86: Result:= #$00DC;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $87: Result:= #$00E1;  // LATIN SMALL LETTER A WITH ACUTE
    $88: Result:= #$00E0;  // LATIN SMALL LETTER A WITH GRAVE
    $89: Result:= #$00E2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $8A: Result:= #$00E4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $8B: Result:= #$00E3;  // LATIN SMALL LETTER A WITH TILDE
    $8C: Result:= #$00E5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $8D: Result:= #$00E7;  // LATIN SMALL LETTER C WITH CEDILLA
    $8E: Result:= #$00E9;  // LATIN SMALL LETTER E WITH ACUTE
    $8F: Result:= #$00E8;  // LATIN SMALL LETTER E WITH GRAVE
    $90: Result:= #$00EA;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $91: Result:= #$00EB;  // LATIN SMALL LETTER E WITH DIAERESIS
    $92: Result:= #$00ED;  // LATIN SMALL LETTER I WITH ACUTE
    $93: Result:= #$00EC;  // LATIN SMALL LETTER I WITH GRAVE
    $94: Result:= #$00EE;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $95: Result:= #$00EF;  // LATIN SMALL LETTER I WITH DIAERESIS
    $96: Result:= #$00F1;  // LATIN SMALL LETTER N WITH TILDE
    $97: Result:= #$00F3;  // LATIN SMALL LETTER O WITH ACUTE
    $98: Result:= #$00F2;  // LATIN SMALL LETTER O WITH GRAVE
    $99: Result:= #$00F4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $9A: Result:= #$00F6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $9B: Result:= #$00F5;  // LATIN SMALL LETTER O WITH TILDE
    $9C: Result:= #$00FA;  // LATIN SMALL LETTER U WITH ACUTE
    $9D: Result:= #$00F9;  // LATIN SMALL LETTER U WITH GRAVE
    $9E: Result:= #$00FB;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $9F: Result:= #$00FC;  // LATIN SMALL LETTER U WITH DIAERESIS
    $A0: Result:= #$2020;  // DAGGER
    $A1: Result:= #$00B0;  // DEGREE SIGN
    $A4: Result:= #$00A7;  // SECTION SIGN
    $A5: Result:= #$2022;  // BULLET
    $A6: Result:= #$00B6;  // PILCROW SIGN
    $A7: Result:= #$00DF;  // LATIN SMALL LETTER SHARP S
    $A8: Result:= #$00AE;  // REGISTERED SIGN
    $AA: Result:= #$2122;  // TRADE MARK SIGN
    $AB: Result:= #$00B4;  // ACUTE ACCENT
    $AC: Result:= #$00A8;  // DIAERESIS
    $AD: Result:= #$2260;  // NOT EQUAL TO
    $AE: Result:= #$00C6;  // LATIN CAPITAL LIGATURE AE
    $AF: Result:= #$00D8;  // LATIN CAPITAL LETTER O WITH STROKE
    $B0: Result:= #$221E;  // INFINITY
    $B2: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $B3: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $B4: Result:= #$00A5;  // YEN SIGN
    $B6: Result:= #$2202;  // PARTIAL DIFFERENTIAL
    $B7: Result:= #$2211;  // N-ARY SUMMATION
    $B8: Result:= #$220F;  // N-ARY PRODUCT
    $B9: Result:= #$03C0;  // GREEK SMALL LETTER PI
    $BA: Result:= #$222B;  // INTEGRAL
    $BB: Result:= #$00AA;  // FEMININE ORDINAL INDICATOR
    $BC: Result:= #$00BA;  // MASCULINE ORDINAL INDICATOR
    $BD: Result:= #$2126;  // OHM SIGN
    $BE: Result:= #$00E6;  // LATIN SMALL LIGATURE AE
    $BF: Result:= #$00F8;  // LATIN SMALL LETTER O WITH STROKE
    $C0: Result:= #$00BF;  // INVERTED QUESTION MARK
    $C1: Result:= #$00A1;  // INVERTED EXCLAMATION MARK
    $C2: Result:= #$00AC;  // NOT SIGN
    $C3: Result:= #$221A;  // SQUARE ROOT
    $C4: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $C5: Result:= #$2248;  // ALMOST EQUAL TO
    $C6: Result:= #$2206;  // INCREMENT
    $C7: Result:= #$00AB;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $C8: Result:= #$00BB;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $C9: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $CA: Result:= #$00A0;  // NO-BREAK SPACE
    $CB: Result:= #$00C0;  // LATIN CAPITAL LETTER A WITH GRAVE
    $CC: Result:= #$00C3;  // LATIN CAPITAL LETTER A WITH TILDE
    $CD: Result:= #$00D5;  // LATIN CAPITAL LETTER O WITH TILDE
    $CE: Result:= #$0152;  // LATIN CAPITAL LIGATURE OE
    $CF: Result:= #$0153;  // LATIN SMALL LIGATURE OE
    $D0: Result:= #$2013;  // EN DASH
    $D1: Result:= #$2014;  // EM DASH
    $D2: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $D3: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $D4: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $D5: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $D6: Result:= #$00F7;  // DIVISION SIGN
    $D7: Result:= #$25CA;  // LOZENGE
    $D8: Result:= #$00FF;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $D9: Result:= #$0178;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
    $DA: Result:= #$011E;  // LATIN CAPITAL LETTER G WITH BREVE
    $DB: Result:= #$011F;  // LATIN SMALL LETTER G WITH BREVE
    $DC: Result:= #$0130;  // LATIN CAPITAL LETTER I WITH DOT ABOVE
    $DD: Result:= #$0131;  // LATIN SMALL LETTER DOTLESS I
    $DE: Result:= #$015E;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $DF: Result:= #$015F;  // LATIN SMALL LETTER S WITH CEDILLA
    $E0: Result:= #$2021;  // DOUBLE DAGGER
    $E1: Result:= #$00B7;  // MIDDLE DOT
    $E2: Result:= #$201A;  // SINGLE LOW-9 QUOTATION MARK
    $E3: Result:= #$201E;  // DOUBLE LOW-9 QUOTATION MARK
    $E4: Result:= #$2030;  // PER MILLE SIGN
    $E5: Result:= #$00C2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $E6: Result:= #$00CA;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $E7: Result:= #$00C1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $E8: Result:= #$00CB;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $E9: Result:= #$00C8;  // LATIN CAPITAL LETTER E WITH GRAVE
    $EA: Result:= #$00CD;  // LATIN CAPITAL LETTER I WITH ACUTE
    $EB: Result:= #$00CE;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $EC: Result:= #$00CF;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $ED: Result:= #$00CC;  // LATIN CAPITAL LETTER I WITH GRAVE
    $EE: Result:= #$00D3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $EF: Result:= #$00D4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $F1: Result:= #$00D2;  // LATIN CAPITAL LETTER O WITH GRAVE
    $F2: Result:= #$00DA;  // LATIN CAPITAL LETTER U WITH ACUTE
    $F3: Result:= #$00DB;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $F4: Result:= #$00D9;  // LATIN CAPITAL LETTER U WITH GRAVE
    $F6: Result:= #$02C6;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $F7: Result:= #$02DC;  // SMALL TILDE
    $F8: Result:= #$00AF;  // MACRON
    $F9: Result:= #$02D8;  // BREVE
    $FA: Result:= #$02D9;  // DOT ABOVE
    $FB: Result:= #$02DA;  // RING ABOVE
    $FC: Result:= #$00B8;  // CEDILLA
    $FD: Result:= #$02DD;  // DOUBLE ACUTE ACCENT
    $FE: Result:= #$02DB;  // OGONEK
    $FF: Result:= #$02C7;  // CARON
  else
    raise EConvertError.CreateFmt('Invalid cp10081_MacTurkish sequence of code point %d',[W]);
  end;
end;

function cp037ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$03,$0B..$13,$18..$19,$1C..$1F,$B6:
      Result:= WideChar(W);
    $04: Result:= #$009C;  // CONTROL
    $05: Result:= #$0009;  // HORIZONTAL TABULATION
    $06: Result:= #$0086;  // CONTROL
    $07: Result:= #$007F;  // DELETE
    $08: Result:= #$0097;  // CONTROL
    $09: Result:= #$008D;  // CONTROL
    $0A: Result:= #$008E;  // CONTROL
    $14: Result:= #$009D;  // CONTROL
    $15: Result:= #$0085;  // CONTROL
    $16: Result:= #$0008;  // BACKSPACE
    $17: Result:= #$0087;  // CONTROL
    $1A: Result:= #$0092;  // CONTROL
    $1B: Result:= #$008F;  // CONTROL
    $20: Result:= #$0080;  // CONTROL
    $21: Result:= #$0081;  // CONTROL
    $22: Result:= #$0082;  // CONTROL
    $23: Result:= #$0083;  // CONTROL
    $24: Result:= #$0084;  // CONTROL
    $25: Result:= #$000A;  // LINE FEED
    $26: Result:= #$0017;  // END OF TRANSMISSION BLOCK
    $27: Result:= #$001B;  // ESCAPE
    $28: Result:= #$0088;  // CONTROL
    $29: Result:= #$0089;  // CONTROL
    $2A: Result:= #$008A;  // CONTROL
    $2B: Result:= #$008B;  // CONTROL
    $2C: Result:= #$008C;  // CONTROL
    $2D: Result:= #$0005;  // ENQUIRY
    $2E: Result:= #$0006;  // ACKNOWLEDGE
    $2F: Result:= #$0007;  // BELL
    $30: Result:= #$0090;  // CONTROL
    $31: Result:= #$0091;  // CONTROL
    $32: Result:= #$0016;  // SYNCHRONOUS IDLE
    $33: Result:= #$0093;  // CONTROL
    $34: Result:= #$0094;  // CONTROL
    $35: Result:= #$0095;  // CONTROL
    $36: Result:= #$0096;  // CONTROL
    $37: Result:= #$0004;  // END OF TRANSMISSION
    $38: Result:= #$0098;  // CONTROL
    $39: Result:= #$0099;  // CONTROL
    $3A: Result:= #$009A;  // CONTROL
    $3B: Result:= #$009B;  // CONTROL
    $3C: Result:= #$0014;  // DEVICE CONTROL FOUR
    $3D: Result:= #$0015;  // NEGATIVE ACKNOWLEDGE
    $3E: Result:= #$009E;  // CONTROL
    $3F: Result:= #$001A;  // SUBSTITUTE
    $40: Result:= #$0020;  // SPACE
    $41: Result:= #$00A0;  // NO-BREAK SPACE
    $42: Result:= #$00E2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $43: Result:= #$00E4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $44: Result:= #$00E0;  // LATIN SMALL LETTER A WITH GRAVE
    $45: Result:= #$00E1;  // LATIN SMALL LETTER A WITH ACUTE
    $46: Result:= #$00E3;  // LATIN SMALL LETTER A WITH TILDE
    $47: Result:= #$00E5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $48: Result:= #$00E7;  // LATIN SMALL LETTER C WITH CEDILLA
    $49: Result:= #$00F1;  // LATIN SMALL LETTER N WITH TILDE
    $4A: Result:= #$00A2;  // CENT SIGN
    $4B: Result:= #$002E;  // FULL STOP
    $4C: Result:= #$003C;  // LESS-THAN SIGN
    $4D: Result:= #$0028;  // LEFT PARENTHESIS
    $4E: Result:= #$002B;  // PLUS SIGN
    $4F: Result:= #$007C;  // VERTICAL LINE
    $50: Result:= #$0026;  // AMPERSAND
    $51: Result:= #$00E9;  // LATIN SMALL LETTER E WITH ACUTE
    $52: Result:= #$00EA;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $53: Result:= #$00EB;  // LATIN SMALL LETTER E WITH DIAERESIS
    $54: Result:= #$00E8;  // LATIN SMALL LETTER E WITH GRAVE
    $55: Result:= #$00ED;  // LATIN SMALL LETTER I WITH ACUTE
    $56: Result:= #$00EE;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $57: Result:= #$00EF;  // LATIN SMALL LETTER I WITH DIAERESIS
    $58: Result:= #$00EC;  // LATIN SMALL LETTER I WITH GRAVE
    $59: Result:= #$00DF;  // LATIN SMALL LETTER SHARP S (GERMAN)
    $5A: Result:= #$0021;  // EXCLAMATION MARK
    $5B: Result:= #$0024;  // DOLLAR SIGN
    $5C: Result:= #$002A;  // ASTERISK
    $5D: Result:= #$0029;  // RIGHT PARENTHESIS
    $5E: Result:= #$003B;  // SEMICOLON
    $5F: Result:= #$00AC;  // NOT SIGN
    $60: Result:= #$002D;  // HYPHEN-MINUS
    $61: Result:= #$002F;  // SOLIDUS
    $62: Result:= #$00C2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $63: Result:= #$00C4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $64: Result:= #$00C0;  // LATIN CAPITAL LETTER A WITH GRAVE
    $65: Result:= #$00C1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $66: Result:= #$00C3;  // LATIN CAPITAL LETTER A WITH TILDE
    $67: Result:= #$00C5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $68: Result:= #$00C7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $69: Result:= #$00D1;  // LATIN CAPITAL LETTER N WITH TILDE
    $6A: Result:= #$00A6;  // BROKEN BAR
    $6B: Result:= #$002C;  // COMMA
    $6C: Result:= #$0025;  // PERCENT SIGN
    $6D: Result:= #$005F;  // LOW LINE
    $6E: Result:= #$003E;  // GREATER-THAN SIGN
    $6F: Result:= #$003F;  // QUESTION MARK
    $70: Result:= #$00F8;  // LATIN SMALL LETTER O WITH STROKE
    $71: Result:= #$00C9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $72: Result:= #$00CA;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $73: Result:= #$00CB;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $74: Result:= #$00C8;  // LATIN CAPITAL LETTER E WITH GRAVE
    $75: Result:= #$00CD;  // LATIN CAPITAL LETTER I WITH ACUTE
    $76: Result:= #$00CE;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $77: Result:= #$00CF;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $78: Result:= #$00CC;  // LATIN CAPITAL LETTER I WITH GRAVE
    $79: Result:= #$0060;  // GRAVE ACCENT
    $7A: Result:= #$003A;  // COLON
    $7B: Result:= #$0023;  // NUMBER SIGN
    $7C: Result:= #$0040;  // COMMERCIAL AT
    $7D: Result:= #$0027;  // APOSTROPHE
    $7E: Result:= #$003D;  // EQUALS SIGN
    $7F: Result:= #$0022;  // QUOTATION MARK
    $80: Result:= #$00D8;  // LATIN CAPITAL LETTER O WITH STROKE
    $81: Result:= #$0061;  // LATIN SMALL LETTER A
    $82: Result:= #$0062;  // LATIN SMALL LETTER B
    $83: Result:= #$0063;  // LATIN SMALL LETTER C
    $84: Result:= #$0064;  // LATIN SMALL LETTER D
    $85: Result:= #$0065;  // LATIN SMALL LETTER E
    $86: Result:= #$0066;  // LATIN SMALL LETTER F
    $87: Result:= #$0067;  // LATIN SMALL LETTER G
    $88: Result:= #$0068;  // LATIN SMALL LETTER H
    $89: Result:= #$0069;  // LATIN SMALL LETTER I
    $8A: Result:= #$00AB;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $8B: Result:= #$00BB;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $8C: Result:= #$00F0;  // LATIN SMALL LETTER ETH (ICELANDIC)
    $8D: Result:= #$00FD;  // LATIN SMALL LETTER Y WITH ACUTE
    $8E: Result:= #$00FE;  // LATIN SMALL LETTER THORN (ICELANDIC)
    $8F: Result:= #$00B1;  // PLUS-MINUS SIGN
    $90: Result:= #$00B0;  // DEGREE SIGN
    $91: Result:= #$006A;  // LATIN SMALL LETTER J
    $92: Result:= #$006B;  // LATIN SMALL LETTER K
    $93: Result:= #$006C;  // LATIN SMALL LETTER L
    $94: Result:= #$006D;  // LATIN SMALL LETTER M
    $95: Result:= #$006E;  // LATIN SMALL LETTER N
    $96: Result:= #$006F;  // LATIN SMALL LETTER O
    $97: Result:= #$0070;  // LATIN SMALL LETTER P
    $98: Result:= #$0071;  // LATIN SMALL LETTER Q
    $99: Result:= #$0072;  // LATIN SMALL LETTER R
    $9A: Result:= #$00AA;  // FEMININE ORDINAL INDICATOR
    $9B: Result:= #$00BA;  // MASCULINE ORDINAL INDICATOR
    $9C: Result:= #$00E6;  // LATIN SMALL LIGATURE AE
    $9D: Result:= #$00B8;  // CEDILLA
    $9E: Result:= #$00C6;  // LATIN CAPITAL LIGATURE AE
    $9F: Result:= #$00A4;  // CURRENCY SIGN
    $A0: Result:= #$00B5;  // MICRO SIGN
    $A1: Result:= #$007E;  // TILDE
    $A2: Result:= #$0073;  // LATIN SMALL LETTER S
    $A3: Result:= #$0074;  // LATIN SMALL LETTER T
    $A4: Result:= #$0075;  // LATIN SMALL LETTER U
    $A5: Result:= #$0076;  // LATIN SMALL LETTER V
    $A6: Result:= #$0077;  // LATIN SMALL LETTER W
    $A7: Result:= #$0078;  // LATIN SMALL LETTER X
    $A8: Result:= #$0079;  // LATIN SMALL LETTER Y
    $A9: Result:= #$007A;  // LATIN SMALL LETTER Z
    $AA: Result:= #$00A1;  // INVERTED EXCLAMATION MARK
    $AB: Result:= #$00BF;  // INVERTED QUESTION MARK
    $AC: Result:= #$00D0;  // LATIN CAPITAL LETTER ETH (ICELANDIC)
    $AD: Result:= #$00DD;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $AE: Result:= #$00DE;  // LATIN CAPITAL LETTER THORN (ICELANDIC)
    $AF: Result:= #$00AE;  // REGISTERED SIGN
    $B0: Result:= #$005E;  // CIRCUMFLEX ACCENT
    $B1: Result:= #$00A3;  // POUND SIGN
    $B2: Result:= #$00A5;  // YEN SIGN
    $B3: Result:= #$00B7;  // MIDDLE DOT
    $B4: Result:= #$00A9;  // COPYRIGHT SIGN
    $B5: Result:= #$00A7;  // SECTION SIGN
    $B7: Result:= #$00BC;  // VULGAR FRACTION ONE QUARTER
    $B8: Result:= #$00BD;  // VULGAR FRACTION ONE HALF
    $B9: Result:= #$00BE;  // VULGAR FRACTION THREE QUARTERS
    $BA: Result:= #$005B;  // LEFT SQUARE BRACKET
    $BB: Result:= #$005D;  // RIGHT SQUARE BRACKET
    $BC: Result:= #$00AF;  // MACRON
    $BD: Result:= #$00A8;  // DIAERESIS
    $BE: Result:= #$00B4;  // ACUTE ACCENT
    $BF: Result:= #$00D7;  // MULTIPLICATION SIGN
    $C0: Result:= #$007B;  // LEFT CURLY BRACKET
    $C1: Result:= #$0041;  // LATIN CAPITAL LETTER A
    $C2: Result:= #$0042;  // LATIN CAPITAL LETTER B
    $C3: Result:= #$0043;  // LATIN CAPITAL LETTER C
    $C4: Result:= #$0044;  // LATIN CAPITAL LETTER D
    $C5: Result:= #$0045;  // LATIN CAPITAL LETTER E
    $C6: Result:= #$0046;  // LATIN CAPITAL LETTER F
    $C7: Result:= #$0047;  // LATIN CAPITAL LETTER G
    $C8: Result:= #$0048;  // LATIN CAPITAL LETTER H
    $C9: Result:= #$0049;  // LATIN CAPITAL LETTER I
    $CA: Result:= #$00AD;  // SOFT HYPHEN
    $CB: Result:= #$00F4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $CC: Result:= #$00F6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $CD: Result:= #$00F2;  // LATIN SMALL LETTER O WITH GRAVE
    $CE: Result:= #$00F3;  // LATIN SMALL LETTER O WITH ACUTE
    $CF: Result:= #$00F5;  // LATIN SMALL LETTER O WITH TILDE
    $D0: Result:= #$007D;  // RIGHT CURLY BRACKET
    $D1: Result:= #$004A;  // LATIN CAPITAL LETTER J
    $D2: Result:= #$004B;  // LATIN CAPITAL LETTER K
    $D3: Result:= #$004C;  // LATIN CAPITAL LETTER L
    $D4: Result:= #$004D;  // LATIN CAPITAL LETTER M
    $D5: Result:= #$004E;  // LATIN CAPITAL LETTER N
    $D6: Result:= #$004F;  // LATIN CAPITAL LETTER O
    $D7: Result:= #$0050;  // LATIN CAPITAL LETTER P
    $D8: Result:= #$0051;  // LATIN CAPITAL LETTER Q
    $D9: Result:= #$0052;  // LATIN CAPITAL LETTER R
    $DA: Result:= #$00B9;  // SUPERSCRIPT ONE
    $DB: Result:= #$00FB;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $DC: Result:= #$00FC;  // LATIN SMALL LETTER U WITH DIAERESIS
    $DD: Result:= #$00F9;  // LATIN SMALL LETTER U WITH GRAVE
    $DE: Result:= #$00FA;  // LATIN SMALL LETTER U WITH ACUTE
    $DF: Result:= #$00FF;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $E0: Result:= #$005C;  // REVERSE SOLIDUS
    $E1: Result:= #$00F7;  // DIVISION SIGN
    $E2: Result:= #$0053;  // LATIN CAPITAL LETTER S
    $E3: Result:= #$0054;  // LATIN CAPITAL LETTER T
    $E4: Result:= #$0055;  // LATIN CAPITAL LETTER U
    $E5: Result:= #$0056;  // LATIN CAPITAL LETTER V
    $E6: Result:= #$0057;  // LATIN CAPITAL LETTER W
    $E7: Result:= #$0058;  // LATIN CAPITAL LETTER X
    $E8: Result:= #$0059;  // LATIN CAPITAL LETTER Y
    $E9: Result:= #$005A;  // LATIN CAPITAL LETTER Z
    $EA: Result:= #$00B2;  // SUPERSCRIPT TWO
    $EB: Result:= #$00D4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $EC: Result:= #$00D6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $ED: Result:= #$00D2;  // LATIN CAPITAL LETTER O WITH GRAVE
    $EE: Result:= #$00D3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $EF: Result:= #$00D5;  // LATIN CAPITAL LETTER O WITH TILDE
    $F0: Result:= #$0030;  // DIGIT ZERO
    $F1: Result:= #$0031;  // DIGIT ONE
    $F2: Result:= #$0032;  // DIGIT TWO
    $F3: Result:= #$0033;  // DIGIT THREE
    $F4: Result:= #$0034;  // DIGIT FOUR
    $F5: Result:= #$0035;  // DIGIT FIVE
    $F6: Result:= #$0036;  // DIGIT SIX
    $F7: Result:= #$0037;  // DIGIT SEVEN
    $F8: Result:= #$0038;  // DIGIT EIGHT
    $F9: Result:= #$0039;  // DIGIT NINE
    $FA: Result:= #$00B3;  // SUPERSCRIPT THREE
    $FB: Result:= #$00DB;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $FC: Result:= #$00DC;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $FD: Result:= #$00D9;  // LATIN CAPITAL LETTER U WITH GRAVE
    $FE: Result:= #$00DA;  // LATIN CAPITAL LETTER U WITH ACUTE
    $FF: Result:= #$009F;  // CONTROL
  else
    raise EConvertError.CreateFmt('Invalid cp037 sequence of code point %d',[W]);
  end;
end;

function cp424ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$03,$0B..$13,$18..$19,$1C..$1F,$B6:
      Result:= WideChar(W);
    $04: Result:= #$009C;  // SELECT
    $05: Result:= #$0009;  // HORIZONTAL TABULATION
    $06: Result:= #$0086;  // REQUIRED NEW LINE
    $07: Result:= #$007F;  // DELETE
    $08: Result:= #$0097;  // GRAPHIC ESCAPE
    $09: Result:= #$008D;  // SUPERSCRIPT
    $0A: Result:= #$008E;  // REPEAT
    $14: Result:= #$009D;  // RESTORE/ENABLE PRESENTATION
    $15: Result:= #$0085;  // NEW LINE
    $16: Result:= #$0008;  // BACKSPACE
    $17: Result:= #$0087;  // PROGRAM OPERATOR COMMUNICATION
    $1A: Result:= #$0092;  // UNIT BACK SPACE
    $1B: Result:= #$008F;  // CUSTOMER USE ONE
    $20: Result:= #$0080;  // DIGIT SELECT
    $21: Result:= #$0081;  // START OF SIGNIFICANCE
    $22: Result:= #$0082;  // FIELD SEPARATOR
    $23: Result:= #$0083;  // WORD UNDERSCORE
    $24: Result:= #$0084;  // BYPASS OR INHIBIT PRESENTATION
    $25: Result:= #$000A;  // LINE FEED
    $26: Result:= #$0017;  // END OF TRANSMISSION BLOCK
    $27: Result:= #$001B;  // ESCAPE
    $28: Result:= #$0088;  // SET ATTRIBUTE
    $29: Result:= #$0089;  // START FIELD EXTENDED
    $2A: Result:= #$008A;  // SET MODE OR SWITCH
    $2B: Result:= #$008B;  // CONTROL SEQUENCE PREFIX
    $2C: Result:= #$008C;  // MODIFY FIELD ATTRIBUTE
    $2D: Result:= #$0005;  // ENQUIRY
    $2E: Result:= #$0006;  // ACKNOWLEDGE
    $2F: Result:= #$0007;  // BELL
    $30: Result:= #$0090;  // <reserved>
    $31: Result:= #$0091;  // <reserved>
    $32: Result:= #$0016;  // SYNCHRONOUS IDLE
    $33: Result:= #$0093;  // INDEX RETURN
    $34: Result:= #$0094;  // PRESENTATION POSITION
    $35: Result:= #$0095;  // TRANSPARENT
    $36: Result:= #$0096;  // NUMERIC BACKSPACE
    $37: Result:= #$0004;  // END OF TRANSMISSION
    $38: Result:= #$0098;  // SUBSCRIPT
    $39: Result:= #$0099;  // INDENT TABULATION
    $3A: Result:= #$009A;  // REVERSE FORM FEED
    $3B: Result:= #$009B;  // CUSTOMER USE THREE
    $3C: Result:= #$0014;  // DEVICE CONTROL FOUR
    $3D: Result:= #$0015;  // NEGATIVE ACKNOWLEDGE
    $3E: Result:= #$009E;  // <reserved>
    $3F: Result:= #$001A;  // SUBSTITUTE
    $40: Result:= #$0020;  // SPACE
    $41: Result:= #$05D0;  // HEBREW LETTER ALEF
    $42: Result:= #$05D1;  // HEBREW LETTER BET
    $43: Result:= #$05D2;  // HEBREW LETTER GIMEL
    $44: Result:= #$05D3;  // HEBREW LETTER DALET
    $45: Result:= #$05D4;  // HEBREW LETTER HE
    $46: Result:= #$05D5;  // HEBREW LETTER VAV
    $47: Result:= #$05D6;  // HEBREW LETTER ZAYIN
    $48: Result:= #$05D7;  // HEBREW LETTER HET
    $49: Result:= #$05D8;  // HEBREW LETTER TET
    $4A: Result:= #$00A2;  // CENT SIGN
    $4B: Result:= #$002E;  // FULL STOP
    $4C: Result:= #$003C;  // LESS-THAN SIGN
    $4D: Result:= #$0028;  // LEFT PARENTHESIS
    $4E: Result:= #$002B;  // PLUS SIGN
    $4F: Result:= #$007C;  // VERTICAL LINE
    $50: Result:= #$0026;  // AMPERSAND
    $51: Result:= #$05D9;  // HEBREW LETTER YOD
    $52: Result:= #$05DA;  // HEBREW LETTER FINAL KAF
    $53: Result:= #$05DB;  // HEBREW LETTER KAF
    $54: Result:= #$05DC;  // HEBREW LETTER LAMED
    $55: Result:= #$05DD;  // HEBREW LETTER FINAL MEM
    $56: Result:= #$05DE;  // HEBREW LETTER MEM
    $57: Result:= #$05DF;  // HEBREW LETTER FINAL NUN
    $58: Result:= #$05E0;  // HEBREW LETTER NUN
    $59: Result:= #$05E1;  // HEBREW LETTER SAMEKH
    $5A: Result:= #$0021;  // EXCLAMATION MARK
    $5B: Result:= #$0024;  // DOLLAR SIGN
    $5C: Result:= #$002A;  // ASTERISK
    $5D: Result:= #$0029;  // RIGHT PARENTHESIS
    $5E: Result:= #$003B;  // SEMICOLON
    $5F: Result:= #$00AC;  // NOT SIGN
    $60: Result:= #$002D;  // HYPHEN-MINUS
    $61: Result:= #$002F;  // SOLIDUS
    $62: Result:= #$05E2;  // HEBREW LETTER AYIN
    $63: Result:= #$05E3;  // HEBREW LETTER FINAL PE
    $64: Result:= #$05E4;  // HEBREW LETTER PE
    $65: Result:= #$05E5;  // HEBREW LETTER FINAL TSADI
    $66: Result:= #$05E6;  // HEBREW LETTER TSADI
    $67: Result:= #$05E7;  // HEBREW LETTER QOF
    $68: Result:= #$05E8;  // HEBREW LETTER RESH
    $69: Result:= #$05E9;  // HEBREW LETTER SHIN
    $6A: Result:= #$00A6;  // BROKEN BAR
    $6B: Result:= #$002C;  // COMMA
    $6C: Result:= #$0025;  // PERCENT SIGN
    $6D: Result:= #$005F;  // LOW LINE
    $6E: Result:= #$003E;  // GREATER-THAN SIGN
    $6F: Result:= #$003F;  // QUESTION MARK
    $71: Result:= #$05EA;  // HEBREW LETTER TAV
    $74: Result:= #$00A0;  // NO-BREAK SPACE
    $78: Result:= #$2017;  // DOUBLE LOW LINE
    $79: Result:= #$0060;  // GRAVE ACCENT
    $7A: Result:= #$003A;  // COLON
    $7B: Result:= #$0023;  // NUMBER SIGN
    $7C: Result:= #$0040;  // COMMERCIAL AT
    $7D: Result:= #$0027;  // APOSTROPHE
    $7E: Result:= #$003D;  // EQUALS SIGN
    $7F: Result:= #$0022;  // QUOTATION MARK
    $81: Result:= #$0061;  // LATIN SMALL LETTER A
    $82: Result:= #$0062;  // LATIN SMALL LETTER B
    $83: Result:= #$0063;  // LATIN SMALL LETTER C
    $84: Result:= #$0064;  // LATIN SMALL LETTER D
    $85: Result:= #$0065;  // LATIN SMALL LETTER E
    $86: Result:= #$0066;  // LATIN SMALL LETTER F
    $87: Result:= #$0067;  // LATIN SMALL LETTER G
    $88: Result:= #$0068;  // LATIN SMALL LETTER H
    $89: Result:= #$0069;  // LATIN SMALL LETTER I
    $8A: Result:= #$00AB;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $8B: Result:= #$00BB;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $8F: Result:= #$00B1;  // PLUS-MINUS SIGN
    $90: Result:= #$00B0;  // DEGREE SIGN
    $91: Result:= #$006A;  // LATIN SMALL LETTER J
    $92: Result:= #$006B;  // LATIN SMALL LETTER K
    $93: Result:= #$006C;  // LATIN SMALL LETTER L
    $94: Result:= #$006D;  // LATIN SMALL LETTER M
    $95: Result:= #$006E;  // LATIN SMALL LETTER N
    $96: Result:= #$006F;  // LATIN SMALL LETTER O
    $97: Result:= #$0070;  // LATIN SMALL LETTER P
    $98: Result:= #$0071;  // LATIN SMALL LETTER Q
    $99: Result:= #$0072;  // LATIN SMALL LETTER R
    $9D: Result:= #$00B8;  // CEDILLA
    $9F: Result:= #$00A4;  // CURRENCY SIGN
    $A0: Result:= #$00B5;  // MICRO SIGN
    $A1: Result:= #$007E;  // TILDE
    $A2: Result:= #$0073;  // LATIN SMALL LETTER S
    $A3: Result:= #$0074;  // LATIN SMALL LETTER T
    $A4: Result:= #$0075;  // LATIN SMALL LETTER U
    $A5: Result:= #$0076;  // LATIN SMALL LETTER V
    $A6: Result:= #$0077;  // LATIN SMALL LETTER W
    $A7: Result:= #$0078;  // LATIN SMALL LETTER X
    $A8: Result:= #$0079;  // LATIN SMALL LETTER Y
    $A9: Result:= #$007A;  // LATIN SMALL LETTER Z
    $AF: Result:= #$00AE;  // REGISTERED SIGN
    $B0: Result:= #$005E;  // CIRCUMFLEX ACCENT
    $B1: Result:= #$00A3;  // POUND SIGN
    $B2: Result:= #$00A5;  // YEN SIGN
    $B3: Result:= #$00B7;  // MIDDLE DOT
    $B4: Result:= #$00A9;  // COPYRIGHT SIGN
    $B5: Result:= #$00A7;  // SECTION SIGN
    $B7: Result:= #$00BC;  // VULGAR FRACTION ONE QUARTER
    $B8: Result:= #$00BD;  // VULGAR FRACTION ONE HALF
    $B9: Result:= #$00BE;  // VULGAR FRACTION THREE QUARTERS
    $BA: Result:= #$005B;  // LEFT SQUARE BRACKET
    $BB: Result:= #$005D;  // RIGHT SQUARE BRACKET
    $BC: Result:= #$00AF;  // MACRON
    $BD: Result:= #$00A8;  // DIAERESIS
    $BE: Result:= #$00B4;  // ACUTE ACCENT
    $BF: Result:= #$00D7;  // MULTIPLICATION SIGN
    $C0: Result:= #$007B;  // LEFT CURLY BRACKET
    $C1: Result:= #$0041;  // LATIN CAPITAL LETTER A
    $C2: Result:= #$0042;  // LATIN CAPITAL LETTER B
    $C3: Result:= #$0043;  // LATIN CAPITAL LETTER C
    $C4: Result:= #$0044;  // LATIN CAPITAL LETTER D
    $C5: Result:= #$0045;  // LATIN CAPITAL LETTER E
    $C6: Result:= #$0046;  // LATIN CAPITAL LETTER F
    $C7: Result:= #$0047;  // LATIN CAPITAL LETTER G
    $C8: Result:= #$0048;  // LATIN CAPITAL LETTER H
    $C9: Result:= #$0049;  // LATIN CAPITAL LETTER I
    $CA: Result:= #$00AD;  // SOFT HYPHEN
    $D0: Result:= #$007D;  // RIGHT CURLY BRACKET
    $D1: Result:= #$004A;  // LATIN CAPITAL LETTER J
    $D2: Result:= #$004B;  // LATIN CAPITAL LETTER K
    $D3: Result:= #$004C;  // LATIN CAPITAL LETTER L
    $D4: Result:= #$004D;  // LATIN CAPITAL LETTER M
    $D5: Result:= #$004E;  // LATIN CAPITAL LETTER N
    $D6: Result:= #$004F;  // LATIN CAPITAL LETTER O
    $D7: Result:= #$0050;  // LATIN CAPITAL LETTER P
    $D8: Result:= #$0051;  // LATIN CAPITAL LETTER Q
    $D9: Result:= #$0052;  // LATIN CAPITAL LETTER R
    $DA: Result:= #$00B9;  // SUPERSCRIPT ONE
    $E0: Result:= #$005C;  // REVERSE SOLIDUS
    $E1: Result:= #$00F7;  // DIVISION SIGN
    $E2: Result:= #$0053;  // LATIN CAPITAL LETTER S
    $E3: Result:= #$0054;  // LATIN CAPITAL LETTER T
    $E4: Result:= #$0055;  // LATIN CAPITAL LETTER U
    $E5: Result:= #$0056;  // LATIN CAPITAL LETTER V
    $E6: Result:= #$0057;  // LATIN CAPITAL LETTER W
    $E7: Result:= #$0058;  // LATIN CAPITAL LETTER X
    $E8: Result:= #$0059;  // LATIN CAPITAL LETTER Y
    $E9: Result:= #$005A;  // LATIN CAPITAL LETTER Z
    $EA: Result:= #$00B2;  // SUPERSCRIPT TWO
    $F0: Result:= #$0030;  // DIGIT ZERO
    $F1: Result:= #$0031;  // DIGIT ONE
    $F2: Result:= #$0032;  // DIGIT TWO
    $F3: Result:= #$0033;  // DIGIT THREE
    $F4: Result:= #$0034;  // DIGIT FOUR
    $F5: Result:= #$0035;  // DIGIT FIVE
    $F6: Result:= #$0036;  // DIGIT SIX
    $F7: Result:= #$0037;  // DIGIT SEVEN
    $F8: Result:= #$0038;  // DIGIT EIGHT
    $F9: Result:= #$0039;  // DIGIT NINE
    $FA: Result:= #$00B3;  // SUPERSCRIPT THREE
    $FF: Result:= #$009F;  // EIGHT ONES
  else
    raise EConvertError.CreateFmt('Invalid cp424 sequence of code point %d',[W]);
  end;
end;

function cp437ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$19,$1b,$1d..$7e: Result:= WideChar(W);
    $1a: Result:= #$001c;
    $1c: Result:= #$007f;
    $7f: Result:= #$001a;
    $80: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $85: Result:= #$00e0;  // LATIN SMALL LETTER A WITH GRAVE
    $86: Result:= #$00e5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $87: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $88: Result:= #$00ea;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $89: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $8a: Result:= #$00e8;  // LATIN SMALL LETTER E WITH GRAVE
    $8b: Result:= #$00ef;  // LATIN SMALL LETTER I WITH DIAERESIS
    $8c: Result:= #$00ee;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $8d: Result:= #$00ec;  // LATIN SMALL LETTER I WITH GRAVE
    $8e: Result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $8f: Result:= #$00c5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$00e6;  // LATIN SMALL LIGATURE AE
    $92: Result:= #$00c6;  // LATIN CAPITAL LIGATURE AE
    $93: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $94: Result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $95: Result:= #$00f2;  // LATIN SMALL LETTER O WITH GRAVE
    $96: Result:= #$00fb;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $97: Result:= #$00f9;  // LATIN SMALL LETTER U WITH GRAVE
    $98: Result:= #$00ff;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $99: Result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$00a2;  // CENT SIGN
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00a5;  // YEN SIGN
    $9e: Result:= #$20a7;  // PESETA SIGN
    $9f: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $a0: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $a1: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$00f1;  // LATIN SMALL LETTER N WITH TILDE
    $a5: Result:= #$00d1;  // LATIN CAPITAL LETTER N WITH TILDE
    $a6: Result:= #$00aa;  // FEMININE ORDINAL INDICATOR
    $a7: Result:= #$00ba;  // MASCULINE ORDINAL INDICATOR
    $a8: Result:= #$00bf;  // INVERTED QUESTION MARK
    $a9: Result:= #$2310;  // REVERSED NOT SIGN
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$00a1;  // INVERTED EXCLAMATION MARK
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b6: Result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b7: Result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $b8: Result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $be: Result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $c7: Result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $d0: Result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $d1: Result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $d2: Result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $d3: Result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $d4: Result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $d5: Result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $d6: Result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $d7: Result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $d8: Result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$258c;  // LEFT HALF BLOCK
    $de: Result:= #$2590;  // RIGHT HALF BLOCK
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$03b1;  // GREEK SMALL LETTER ALPHA
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e2: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $e3: Result:= #$03c0;  // GREEK SMALL LETTER PI
    $e4: Result:= #$03a3;  // GREEK CAPITAL LETTER SIGMA
    $e5: Result:= #$03c3;  // GREEK SMALL LETTER SIGMA
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e7: Result:= #$03c4;  // GREEK SMALL LETTER TAU
    $e8: Result:= #$03a6;  // GREEK CAPITAL LETTER PHI
    $e9: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $ea: Result:= #$03a9;  // GREEK CAPITAL LETTER OMEGA
    $eb: Result:= #$03b4;  // GREEK SMALL LETTER DELTA
    $ec: Result:= #$221e;  // INFINITY
    $ed: Result:= #$03c6;  // GREEK SMALL LETTER PHI
    $ee: Result:= #$03b5;  // GREEK SMALL LETTER EPSILON
    $ef: Result:= #$2229;  // INTERSECTION
    $f0: Result:= #$2261;  // IDENTICAL TO
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $f3: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $f4: Result:= #$2320;  // TOP HALF INTEGRAL
    $f5: Result:= #$2321;  // BOTTOM HALF INTEGRAL
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$2248;  // ALMOST EQUAL TO
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$2219;  // BULLET OPERATOR
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$221a;  // SQUARE ROOT
    $fc: Result:= #$207f;  // SUPERSCRIPT LATIN SMALL LETTER N
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp437 sequence of code point %d',[W]);
  end;
end;

function cp437_DOSLatinUSToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$7f: Result:= WideChar(W);
    $80: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $85: Result:= #$00e0;  // LATIN SMALL LETTER A WITH GRAVE
    $86: Result:= #$00e5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $87: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $88: Result:= #$00ea;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $89: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $8a: Result:= #$00e8;  // LATIN SMALL LETTER E WITH GRAVE
    $8b: Result:= #$00ef;  // LATIN SMALL LETTER I WITH DIAERESIS
    $8c: Result:= #$00ee;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $8d: Result:= #$00ec;  // LATIN SMALL LETTER I WITH GRAVE
    $8e: Result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $8f: Result:= #$00c5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$00e6;  // LATIN SMALL LIGATURE AE
    $92: Result:= #$00c6;  // LATIN CAPITAL LIGATURE AE
    $93: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $94: Result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $95: Result:= #$00f2;  // LATIN SMALL LETTER O WITH GRAVE
    $96: Result:= #$00fb;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $97: Result:= #$00f9;  // LATIN SMALL LETTER U WITH GRAVE
    $98: Result:= #$00ff;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $99: Result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$00a2;  // CENT SIGN
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00a5;  // YEN SIGN
    $9e: Result:= #$20a7;  // PESETA SIGN
    $9f: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $a0: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $a1: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$00f1;  // LATIN SMALL LETTER N WITH TILDE
    $a5: Result:= #$00d1;  // LATIN CAPITAL LETTER N WITH TILDE
    $a6: Result:= #$00aa;  // FEMININE ORDINAL INDICATOR
    $a7: Result:= #$00ba;  // MASCULINE ORDINAL INDICATOR
    $a8: Result:= #$00bf;  // INVERTED QUESTION MARK
    $a9: Result:= #$2310;  // REVERSED NOT SIGN
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$00a1;  // INVERTED EXCLAMATION MARK
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b6: Result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b7: Result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $b8: Result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $be: Result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $c7: Result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $d0: Result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $d1: Result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $d2: Result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $d3: Result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $d4: Result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $d5: Result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $d6: Result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $d7: Result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $d8: Result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$258c;  // LEFT HALF BLOCK
    $de: Result:= #$2590;  // RIGHT HALF BLOCK
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$03b1;  // GREEK SMALL LETTER ALPHA
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e2: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $e3: Result:= #$03c0;  // GREEK SMALL LETTER PI
    $e4: Result:= #$03a3;  // GREEK CAPITAL LETTER SIGMA
    $e5: Result:= #$03c3;  // GREEK SMALL LETTER SIGMA
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e7: Result:= #$03c4;  // GREEK SMALL LETTER TAU
    $e8: Result:= #$03a6;  // GREEK CAPITAL LETTER PHI
    $e9: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $ea: Result:= #$03a9;  // GREEK CAPITAL LETTER OMEGA
    $eb: Result:= #$03b4;  // GREEK SMALL LETTER DELTA
    $ec: Result:= #$221e;  // INFINITY
    $ed: Result:= #$03c6;  // GREEK SMALL LETTER PHI
    $ee: Result:= #$03b5;  // GREEK SMALL LETTER EPSILON
    $ef: Result:= #$2229;  // INTERSECTION
    $f0: Result:= #$2261;  // IDENTICAL TO
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $f3: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $f4: Result:= #$2320;  // TOP HALF INTEGRAL
    $f5: Result:= #$2321;  // BOTTOM HALF INTEGRAL
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$2248;  // ALMOST EQUAL TO
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$2219;  // BULLET OPERATOR
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$221a;  // SQUARE ROOT
    $fc: Result:= #$207f;  // SUPERSCRIPT LATIN SMALL LETTER N
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp437_DOSLatinUS sequence of code point %d',[W]);
  end;
end;

function cp500ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$03,$0B..$13,$18..$19,$1C..$1F,$B6:
      Result:= WideChar(W);
    $04: Result:= #$009C;  // CONTROL
    $05: Result:= #$0009;  // HORIZONTAL TABULATION
    $06: Result:= #$0086;  // CONTROL
    $07: Result:= #$007F;  // DELETE
    $08: Result:= #$0097;  // CONTROL
    $09: Result:= #$008D;  // CONTROL
    $0A: Result:= #$008E;  // CONTROL
    $14: Result:= #$009D;  // CONTROL
    $15: Result:= #$0085;  // CONTROL
    $16: Result:= #$0008;  // BACKSPACE
    $17: Result:= #$0087;  // CONTROL
    $1A: Result:= #$0092;  // CONTROL
    $1B: Result:= #$008F;  // CONTROL
    $20: Result:= #$0080;  // CONTROL
    $21: Result:= #$0081;  // CONTROL
    $22: Result:= #$0082;  // CONTROL
    $23: Result:= #$0083;  // CONTROL
    $24: Result:= #$0084;  // CONTROL
    $25: Result:= #$000A;  // LINE FEED
    $26: Result:= #$0017;  // END OF TRANSMISSION BLOCK
    $27: Result:= #$001B;  // ESCAPE
    $28: Result:= #$0088;  // CONTROL
    $29: Result:= #$0089;  // CONTROL
    $2A: Result:= #$008A;  // CONTROL
    $2B: Result:= #$008B;  // CONTROL
    $2C: Result:= #$008C;  // CONTROL
    $2D: Result:= #$0005;  // ENQUIRY
    $2E: Result:= #$0006;  // ACKNOWLEDGE
    $2F: Result:= #$0007;  // BELL
    $30: Result:= #$0090;  // CONTROL
    $31: Result:= #$0091;  // CONTROL
    $32: Result:= #$0016;  // SYNCHRONOUS IDLE
    $33: Result:= #$0093;  // CONTROL
    $34: Result:= #$0094;  // CONTROL
    $35: Result:= #$0095;  // CONTROL
    $36: Result:= #$0096;  // CONTROL
    $37: Result:= #$0004;  // END OF TRANSMISSION
    $38: Result:= #$0098;  // CONTROL
    $39: Result:= #$0099;  // CONTROL
    $3A: Result:= #$009A;  // CONTROL
    $3B: Result:= #$009B;  // CONTROL
    $3C: Result:= #$0014;  // DEVICE CONTROL FOUR
    $3D: Result:= #$0015;  // NEGATIVE ACKNOWLEDGE
    $3E: Result:= #$009E;  // CONTROL
    $3F: Result:= #$001A;  // SUBSTITUTE
    $40: Result:= #$0020;  // SPACE
    $41: Result:= #$00A0;  // NO-BREAK SPACE
    $42: Result:= #$00E2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $43: Result:= #$00E4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $44: Result:= #$00E0;  // LATIN SMALL LETTER A WITH GRAVE
    $45: Result:= #$00E1;  // LATIN SMALL LETTER A WITH ACUTE
    $46: Result:= #$00E3;  // LATIN SMALL LETTER A WITH TILDE
    $47: Result:= #$00E5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $48: Result:= #$00E7;  // LATIN SMALL LETTER C WITH CEDILLA
    $49: Result:= #$00F1;  // LATIN SMALL LETTER N WITH TILDE
    $4A: Result:= #$005B;  // LEFT SQUARE BRACKET
    $4B: Result:= #$002E;  // FULL STOP
    $4C: Result:= #$003C;  // LESS-THAN SIGN
    $4D: Result:= #$0028;  // LEFT PARENTHESIS
    $4E: Result:= #$002B;  // PLUS SIGN
    $4F: Result:= #$0021;  // EXCLAMATION MARK
    $50: Result:= #$0026;  // AMPERSAND
    $51: Result:= #$00E9;  // LATIN SMALL LETTER E WITH ACUTE
    $52: Result:= #$00EA;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $53: Result:= #$00EB;  // LATIN SMALL LETTER E WITH DIAERESIS
    $54: Result:= #$00E8;  // LATIN SMALL LETTER E WITH GRAVE
    $55: Result:= #$00ED;  // LATIN SMALL LETTER I WITH ACUTE
    $56: Result:= #$00EE;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $57: Result:= #$00EF;  // LATIN SMALL LETTER I WITH DIAERESIS
    $58: Result:= #$00EC;  // LATIN SMALL LETTER I WITH GRAVE
    $59: Result:= #$00DF;  // LATIN SMALL LETTER SHARP S (GERMAN)
    $5A: Result:= #$005D;  // RIGHT SQUARE BRACKET
    $5B: Result:= #$0024;  // DOLLAR SIGN
    $5C: Result:= #$002A;  // ASTERISK
    $5D: Result:= #$0029;  // RIGHT PARENTHESIS
    $5E: Result:= #$003B;  // SEMICOLON
    $5F: Result:= #$005E;  // CIRCUMFLEX ACCENT
    $60: Result:= #$002D;  // HYPHEN-MINUS
    $61: Result:= #$002F;  // SOLIDUS
    $62: Result:= #$00C2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $63: Result:= #$00C4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $64: Result:= #$00C0;  // LATIN CAPITAL LETTER A WITH GRAVE
    $65: Result:= #$00C1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $66: Result:= #$00C3;  // LATIN CAPITAL LETTER A WITH TILDE
    $67: Result:= #$00C5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $68: Result:= #$00C7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $69: Result:= #$00D1;  // LATIN CAPITAL LETTER N WITH TILDE
    $6A: Result:= #$00A6;  // BROKEN BAR
    $6B: Result:= #$002C;  // COMMA
    $6C: Result:= #$0025;  // PERCENT SIGN
    $6D: Result:= #$005F;  // LOW LINE
    $6E: Result:= #$003E;  // GREATER-THAN SIGN
    $6F: Result:= #$003F;  // QUESTION MARK
    $70: Result:= #$00F8;  // LATIN SMALL LETTER O WITH STROKE
    $71: Result:= #$00C9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $72: Result:= #$00CA;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $73: Result:= #$00CB;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $74: Result:= #$00C8;  // LATIN CAPITAL LETTER E WITH GRAVE
    $75: Result:= #$00CD;  // LATIN CAPITAL LETTER I WITH ACUTE
    $76: Result:= #$00CE;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $77: Result:= #$00CF;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $78: Result:= #$00CC;  // LATIN CAPITAL LETTER I WITH GRAVE
    $79: Result:= #$0060;  // GRAVE ACCENT
    $7A: Result:= #$003A;  // COLON
    $7B: Result:= #$0023;  // NUMBER SIGN
    $7C: Result:= #$0040;  // COMMERCIAL AT
    $7D: Result:= #$0027;  // APOSTROPHE
    $7E: Result:= #$003D;  // EQUALS SIGN
    $7F: Result:= #$0022;  // QUOTATION MARK
    $80: Result:= #$00D8;  // LATIN CAPITAL LETTER O WITH STROKE
    $81: Result:= #$0061;  // LATIN SMALL LETTER A
    $82: Result:= #$0062;  // LATIN SMALL LETTER B
    $83: Result:= #$0063;  // LATIN SMALL LETTER C
    $84: Result:= #$0064;  // LATIN SMALL LETTER D
    $85: Result:= #$0065;  // LATIN SMALL LETTER E
    $86: Result:= #$0066;  // LATIN SMALL LETTER F
    $87: Result:= #$0067;  // LATIN SMALL LETTER G
    $88: Result:= #$0068;  // LATIN SMALL LETTER H
    $89: Result:= #$0069;  // LATIN SMALL LETTER I
    $8A: Result:= #$00AB;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $8B: Result:= #$00BB;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $8C: Result:= #$00F0;  // LATIN SMALL LETTER ETH (ICELANDIC)
    $8D: Result:= #$00FD;  // LATIN SMALL LETTER Y WITH ACUTE
    $8E: Result:= #$00FE;  // LATIN SMALL LETTER THORN (ICELANDIC)
    $8F: Result:= #$00B1;  // PLUS-MINUS SIGN
    $90: Result:= #$00B0;  // DEGREE SIGN
    $91: Result:= #$006A;  // LATIN SMALL LETTER J
    $92: Result:= #$006B;  // LATIN SMALL LETTER K
    $93: Result:= #$006C;  // LATIN SMALL LETTER L
    $94: Result:= #$006D;  // LATIN SMALL LETTER M
    $95: Result:= #$006E;  // LATIN SMALL LETTER N
    $96: Result:= #$006F;  // LATIN SMALL LETTER O
    $97: Result:= #$0070;  // LATIN SMALL LETTER P
    $98: Result:= #$0071;  // LATIN SMALL LETTER Q
    $99: Result:= #$0072;  // LATIN SMALL LETTER R
    $9A: Result:= #$00AA;  // FEMININE ORDINAL INDICATOR
    $9B: Result:= #$00BA;  // MASCULINE ORDINAL INDICATOR
    $9C: Result:= #$00E6;  // LATIN SMALL LIGATURE AE
    $9D: Result:= #$00B8;  // CEDILLA
    $9E: Result:= #$00C6;  // LATIN CAPITAL LIGATURE AE
    $9F: Result:= #$00A4;  // CURRENCY SIGN
    $A0: Result:= #$00B5;  // MICRO SIGN
    $A1: Result:= #$007E;  // TILDE
    $A2: Result:= #$0073;  // LATIN SMALL LETTER S
    $A3: Result:= #$0074;  // LATIN SMALL LETTER T
    $A4: Result:= #$0075;  // LATIN SMALL LETTER U
    $A5: Result:= #$0076;  // LATIN SMALL LETTER V
    $A6: Result:= #$0077;  // LATIN SMALL LETTER W
    $A7: Result:= #$0078;  // LATIN SMALL LETTER X
    $A8: Result:= #$0079;  // LATIN SMALL LETTER Y
    $A9: Result:= #$007A;  // LATIN SMALL LETTER Z
    $AA: Result:= #$00A1;  // INVERTED EXCLAMATION MARK
    $AB: Result:= #$00BF;  // INVERTED QUESTION MARK
    $AC: Result:= #$00D0;  // LATIN CAPITAL LETTER ETH (ICELANDIC)
    $AD: Result:= #$00DD;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $AE: Result:= #$00DE;  // LATIN CAPITAL LETTER THORN (ICELANDIC)
    $AF: Result:= #$00AE;  // REGISTERED SIGN
    $B0: Result:= #$00A2;  // CENT SIGN
    $B1: Result:= #$00A3;  // POUND SIGN
    $B2: Result:= #$00A5;  // YEN SIGN
    $B3: Result:= #$00B7;  // MIDDLE DOT
    $B4: Result:= #$00A9;  // COPYRIGHT SIGN
    $B5: Result:= #$00A7;  // SECTION SIGN
    $B7: Result:= #$00BC;  // VULGAR FRACTION ONE QUARTER
    $B8: Result:= #$00BD;  // VULGAR FRACTION ONE HALF
    $B9: Result:= #$00BE;  // VULGAR FRACTION THREE QUARTERS
    $BA: Result:= #$00AC;  // NOT SIGN
    $BB: Result:= #$007C;  // VERTICAL LINE
    $BC: Result:= #$00AF;  // MACRON
    $BD: Result:= #$00A8;  // DIAERESIS
    $BE: Result:= #$00B4;  // ACUTE ACCENT
    $BF: Result:= #$00D7;  // MULTIPLICATION SIGN
    $C0: Result:= #$007B;  // LEFT CURLY BRACKET
    $C1: Result:= #$0041;  // LATIN CAPITAL LETTER A
    $C2: Result:= #$0042;  // LATIN CAPITAL LETTER B
    $C3: Result:= #$0043;  // LATIN CAPITAL LETTER C
    $C4: Result:= #$0044;  // LATIN CAPITAL LETTER D
    $C5: Result:= #$0045;  // LATIN CAPITAL LETTER E
    $C6: Result:= #$0046;  // LATIN CAPITAL LETTER F
    $C7: Result:= #$0047;  // LATIN CAPITAL LETTER G
    $C8: Result:= #$0048;  // LATIN CAPITAL LETTER H
    $C9: Result:= #$0049;  // LATIN CAPITAL LETTER I
    $CA: Result:= #$00AD;  // SOFT HYPHEN
    $CB: Result:= #$00F4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $CC: Result:= #$00F6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $CD: Result:= #$00F2;  // LATIN SMALL LETTER O WITH GRAVE
    $CE: Result:= #$00F3;  // LATIN SMALL LETTER O WITH ACUTE
    $CF: Result:= #$00F5;  // LATIN SMALL LETTER O WITH TILDE
    $D0: Result:= #$007D;  // RIGHT CURLY BRACKET
    $D1: Result:= #$004A;  // LATIN CAPITAL LETTER J
    $D2: Result:= #$004B;  // LATIN CAPITAL LETTER K
    $D3: Result:= #$004C;  // LATIN CAPITAL LETTER L
    $D4: Result:= #$004D;  // LATIN CAPITAL LETTER M
    $D5: Result:= #$004E;  // LATIN CAPITAL LETTER N
    $D6: Result:= #$004F;  // LATIN CAPITAL LETTER O
    $D7: Result:= #$0050;  // LATIN CAPITAL LETTER P
    $D8: Result:= #$0051;  // LATIN CAPITAL LETTER Q
    $D9: Result:= #$0052;  // LATIN CAPITAL LETTER R
    $DA: Result:= #$00B9;  // SUPERSCRIPT ONE
    $DB: Result:= #$00FB;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $DC: Result:= #$00FC;  // LATIN SMALL LETTER U WITH DIAERESIS
    $DD: Result:= #$00F9;  // LATIN SMALL LETTER U WITH GRAVE
    $DE: Result:= #$00FA;  // LATIN SMALL LETTER U WITH ACUTE
    $DF: Result:= #$00FF;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $E0: Result:= #$005C;  // REVERSE SOLIDUS
    $E1: Result:= #$00F7;  // DIVISION SIGN
    $E2: Result:= #$0053;  // LATIN CAPITAL LETTER S
    $E3: Result:= #$0054;  // LATIN CAPITAL LETTER T
    $E4: Result:= #$0055;  // LATIN CAPITAL LETTER U
    $E5: Result:= #$0056;  // LATIN CAPITAL LETTER V
    $E6: Result:= #$0057;  // LATIN CAPITAL LETTER W
    $E7: Result:= #$0058;  // LATIN CAPITAL LETTER X
    $E8: Result:= #$0059;  // LATIN CAPITAL LETTER Y
    $E9: Result:= #$005A;  // LATIN CAPITAL LETTER Z
    $EA: Result:= #$00B2;  // SUPERSCRIPT TWO
    $EB: Result:= #$00D4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $EC: Result:= #$00D6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $ED: Result:= #$00D2;  // LATIN CAPITAL LETTER O WITH GRAVE
    $EE: Result:= #$00D3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $EF: Result:= #$00D5;  // LATIN CAPITAL LETTER O WITH TILDE
    $F0: Result:= #$0030;  // DIGIT ZERO
    $F1: Result:= #$0031;  // DIGIT ONE
    $F2: Result:= #$0032;  // DIGIT TWO
    $F3: Result:= #$0033;  // DIGIT THREE
    $F4: Result:= #$0034;  // DIGIT FOUR
    $F5: Result:= #$0035;  // DIGIT FIVE
    $F6: Result:= #$0036;  // DIGIT SIX
    $F7: Result:= #$0037;  // DIGIT SEVEN
    $F8: Result:= #$0038;  // DIGIT EIGHT
    $F9: Result:= #$0039;  // DIGIT NINE
    $FA: Result:= #$00B3;  // SUPERSCRIPT THREE
    $FB: Result:= #$00DB;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $FC: Result:= #$00DC;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $FD: Result:= #$00D9;  // LATIN CAPITAL LETTER U WITH GRAVE
    $FE: Result:= #$00DA;  // LATIN CAPITAL LETTER U WITH ACUTE
    $FF: Result:= #$009F;  // CONTROL
  else
    raise EConvertError.CreateFmt('Invalid cp500 sequence of code point %d',[W]);
  end;
end;

function cp737_DOSGreekToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$7f: Result:= WideChar(W);
    $80: Result:= #$0391;  // GREEK CAPITAL LETTER ALPHA
    $81: Result:= #$0392;  // GREEK CAPITAL LETTER BETA
    $82: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $83: Result:= #$0394;  // GREEK CAPITAL LETTER DELTA
    $84: Result:= #$0395;  // GREEK CAPITAL LETTER EPSILON
    $85: Result:= #$0396;  // GREEK CAPITAL LETTER ZETA
    $86: Result:= #$0397;  // GREEK CAPITAL LETTER ETA
    $87: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $88: Result:= #$0399;  // GREEK CAPITAL LETTER IOTA
    $89: Result:= #$039a;  // GREEK CAPITAL LETTER KAPPA
    $8a: Result:= #$039b;  // GREEK CAPITAL LETTER LAMDA
    $8b: Result:= #$039c;  // GREEK CAPITAL LETTER MU
    $8c: Result:= #$039d;  // GREEK CAPITAL LETTER NU
    $8d: Result:= #$039e;  // GREEK CAPITAL LETTER XI
    $8e: Result:= #$039f;  // GREEK CAPITAL LETTER OMICRON
    $8f: Result:= #$03a0;  // GREEK CAPITAL LETTER PI
    $90: Result:= #$03a1;  // GREEK CAPITAL LETTER RHO
    $91: Result:= #$03a3;  // GREEK CAPITAL LETTER SIGMA
    $92: Result:= #$03a4;  // GREEK CAPITAL LETTER TAU
    $93: Result:= #$03a5;  // GREEK CAPITAL LETTER UPSILON
    $94: Result:= #$03a6;  // GREEK CAPITAL LETTER PHI
    $95: Result:= #$03a7;  // GREEK CAPITAL LETTER CHI
    $96: Result:= #$03a8;  // GREEK CAPITAL LETTER PSI
    $97: Result:= #$03a9;  // GREEK CAPITAL LETTER OMEGA
    $98: Result:= #$03b1;  // GREEK SMALL LETTER ALPHA
    $99: Result:= #$03b2;  // GREEK SMALL LETTER BETA
    $9a: Result:= #$03b3;  // GREEK SMALL LETTER GAMMA
    $9b: Result:= #$03b4;  // GREEK SMALL LETTER DELTA
    $9c: Result:= #$03b5;  // GREEK SMALL LETTER EPSILON
    $9d: Result:= #$03b6;  // GREEK SMALL LETTER ZETA
    $9e: Result:= #$03b7;  // GREEK SMALL LETTER ETA
    $9f: Result:= #$03b8;  // GREEK SMALL LETTER THETA
    $a0: Result:= #$03b9;  // GREEK SMALL LETTER IOTA
    $a1: Result:= #$03ba;  // GREEK SMALL LETTER KAPPA
    $a2: Result:= #$03bb;  // GREEK SMALL LETTER LAMDA
    $a3: Result:= #$03bc;  // GREEK SMALL LETTER MU
    $a4: Result:= #$03bd;  // GREEK SMALL LETTER NU
    $a5: Result:= #$03be;  // GREEK SMALL LETTER XI
    $a6: Result:= #$03bf;  // GREEK SMALL LETTER OMICRON
    $a7: Result:= #$03c0;  // GREEK SMALL LETTER PI
    $a8: Result:= #$03c1;  // GREEK SMALL LETTER RHO
    $a9: Result:= #$03c3;  // GREEK SMALL LETTER SIGMA
    $aa: Result:= #$03c2;  // GREEK SMALL LETTER FINAL SIGMA
    $ab: Result:= #$03c4;  // GREEK SMALL LETTER TAU
    $ac: Result:= #$03c5;  // GREEK SMALL LETTER UPSILON
    $ad: Result:= #$03c6;  // GREEK SMALL LETTER PHI
    $ae: Result:= #$03c7;  // GREEK SMALL LETTER CHI
    $af: Result:= #$03c8;  // GREEK SMALL LETTER PSI
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b6: Result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b7: Result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $b8: Result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $be: Result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $c7: Result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $d0: Result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $d1: Result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $d2: Result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $d3: Result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $d4: Result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $d5: Result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $d6: Result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $d7: Result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $d8: Result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$258c;  // LEFT HALF BLOCK
    $de: Result:= #$2590;  // RIGHT HALF BLOCK
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$03c9;  // GREEK SMALL LETTER OMEGA
    $e1: Result:= #$03ac;  // GREEK SMALL LETTER ALPHA WITH TONOS
    $e2: Result:= #$03ad;  // GREEK SMALL LETTER EPSILON WITH TONOS
    $e3: Result:= #$03ae;  // GREEK SMALL LETTER ETA WITH TONOS
    $e4: Result:= #$03ca;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA
    $e5: Result:= #$03af;  // GREEK SMALL LETTER IOTA WITH TONOS
    $e6: Result:= #$03cc;  // GREEK SMALL LETTER OMICRON WITH TONOS
    $e7: Result:= #$03cd;  // GREEK SMALL LETTER UPSILON WITH TONOS
    $e8: Result:= #$03cb;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA
    $e9: Result:= #$03ce;  // GREEK SMALL LETTER OMEGA WITH TONOS
    $ea: Result:= #$0386;  // GREEK CAPITAL LETTER ALPHA WITH TONOS
    $eb: Result:= #$0388;  // GREEK CAPITAL LETTER EPSILON WITH TONOS
    $ec: Result:= #$0389;  // GREEK CAPITAL LETTER ETA WITH TONOS
    $ed: Result:= #$038a;  // GREEK CAPITAL LETTER IOTA WITH TONOS
    $ee: Result:= #$038c;  // GREEK CAPITAL LETTER OMICRON WITH TONOS
    $ef: Result:= #$038e;  // GREEK CAPITAL LETTER UPSILON WITH TONOS
    $f0: Result:= #$038f;  // GREEK CAPITAL LETTER OMEGA WITH TONOS
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $f3: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $f4: Result:= #$03aa;  // GREEK CAPITAL LETTER IOTA WITH DIALYTIKA
    $f5: Result:= #$03ab;  // GREEK CAPITAL LETTER UPSILON WITH DIALYTIKA
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$2248;  // ALMOST EQUAL TO
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$2219;  // BULLET OPERATOR
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$221a;  // SQUARE ROOT
    $fc: Result:= #$207f;  // SUPERSCRIPT LATIN SMALL LETTER N
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp737_DOSGreek sequence of code point %d',[W]);
  end;
end;

function cp775_DOSBaltRimToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$7f: Result:= WideChar(W);
    $80: Result:= #$0106;  // LATIN CAPITAL LETTER C WITH ACUTE
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$0101;  // LATIN SMALL LETTER A WITH MACRON
    $84: Result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $85: Result:= #$0123;  // LATIN SMALL LETTER G WITH CEDILLA
    $86: Result:= #$00e5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $87: Result:= #$0107;  // LATIN SMALL LETTER C WITH ACUTE
    $88: Result:= #$0142;  // LATIN SMALL LETTER L WITH STROKE
    $89: Result:= #$0113;  // LATIN SMALL LETTER E WITH MACRON
    $8a: Result:= #$0156;  // LATIN CAPITAL LETTER R WITH CEDILLA
    $8b: Result:= #$0157;  // LATIN SMALL LETTER R WITH CEDILLA
    $8c: Result:= #$012b;  // LATIN SMALL LETTER I WITH MACRON
    $8d: Result:= #$0179;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $8e: Result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $8f: Result:= #$00c5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$00e6;  // LATIN SMALL LIGATURE AE
    $92: Result:= #$00c6;  // LATIN CAPITAL LIGATURE AE
    $93: Result:= #$014d;  // LATIN SMALL LETTER O WITH MACRON
    $94: Result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $95: Result:= #$0122;  // LATIN CAPITAL LETTER G WITH CEDILLA
    $96: Result:= #$00a2;  // CENT SIGN
    $97: Result:= #$015a;  // LATIN CAPITAL LETTER S WITH ACUTE
    $98: Result:= #$015b;  // LATIN SMALL LETTER S WITH ACUTE
    $99: Result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$00f8;  // LATIN SMALL LETTER O WITH STROKE
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00d8;  // LATIN CAPITAL LETTER O WITH STROKE
    $9e: Result:= #$00d7;  // MULTIPLICATION SIGN
    $9f: Result:= #$00a4;  // CURRENCY SIGN
    $a0: Result:= #$0100;  // LATIN CAPITAL LETTER A WITH MACRON
    $a1: Result:= #$012a;  // LATIN CAPITAL LETTER I WITH MACRON
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$017b;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $a4: Result:= #$017c;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $a5: Result:= #$017a;  // LATIN SMALL LETTER Z WITH ACUTE
    $a6: Result:= #$201d;  // RIGHT DOUBLE QUOTATION MARK
    $a7: Result:= #$00a6;  // BROKEN BAR
    $a8: Result:= #$00a9;  // COPYRIGHT SIGN
    $a9: Result:= #$00ae;  // REGISTERED SIGN
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$0141;  // LATIN CAPITAL LETTER L WITH STROKE
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$0104;  // LATIN CAPITAL LETTER A WITH OGONEK
    $b6: Result:= #$010c;  // LATIN CAPITAL LETTER C WITH CARON
    $b7: Result:= #$0118;  // LATIN CAPITAL LETTER E WITH OGONEK
    $b8: Result:= #$0116;  // LATIN CAPITAL LETTER E WITH DOT ABOVE
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$012e;  // LATIN CAPITAL LETTER I WITH OGONEK
    $be: Result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$0172;  // LATIN CAPITAL LETTER U WITH OGONEK
    $c7: Result:= #$016a;  // LATIN CAPITAL LETTER U WITH MACRON
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$017d;  // LATIN CAPITAL LETTER Z WITH CARON
    $d0: Result:= #$0105;  // LATIN SMALL LETTER A WITH OGONEK
    $d1: Result:= #$010d;  // LATIN SMALL LETTER C WITH CARON
    $d2: Result:= #$0119;  // LATIN SMALL LETTER E WITH OGONEK
    $d3: Result:= #$0117;  // LATIN SMALL LETTER E WITH DOT ABOVE
    $d4: Result:= #$012f;  // LATIN SMALL LETTER I WITH OGONEK
    $d5: Result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $d6: Result:= #$0173;  // LATIN SMALL LETTER U WITH OGONEK
    $d7: Result:= #$016b;  // LATIN SMALL LETTER U WITH MACRON
    $d8: Result:= #$017e;  // LATIN SMALL LETTER Z WITH CARON
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$258c;  // LEFT HALF BLOCK
    $de: Result:= #$2590;  // RIGHT HALF BLOCK
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$00d3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S (GERMAN)
    $e2: Result:= #$014c;  // LATIN CAPITAL LETTER O WITH MACRON
    $e3: Result:= #$0143;  // LATIN CAPITAL LETTER N WITH ACUTE
    $e4: Result:= #$00f5;  // LATIN SMALL LETTER O WITH TILDE
    $e5: Result:= #$00d5;  // LATIN CAPITAL LETTER O WITH TILDE
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e7: Result:= #$0144;  // LATIN SMALL LETTER N WITH ACUTE
    $e8: Result:= #$0136;  // LATIN CAPITAL LETTER K WITH CEDILLA
    $e9: Result:= #$0137;  // LATIN SMALL LETTER K WITH CEDILLA
    $ea: Result:= #$013b;  // LATIN CAPITAL LETTER L WITH CEDILLA
    $eb: Result:= #$013c;  // LATIN SMALL LETTER L WITH CEDILLA
    $ec: Result:= #$0146;  // LATIN SMALL LETTER N WITH CEDILLA
    $ed: Result:= #$0112;  // LATIN CAPITAL LETTER E WITH MACRON
    $ee: Result:= #$0145;  // LATIN CAPITAL LETTER N WITH CEDILLA
    $ef: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $f0: Result:= #$00ad;  // SOFT HYPHEN
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$201c;  // LEFT DOUBLE QUOTATION MARK
    $f3: Result:= #$00be;  // VULGAR FRACTION THREE QUARTERS
    $f4: Result:= #$00b6;  // PILCROW SIGN
    $f5: Result:= #$00a7;  // SECTION SIGN
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$201e;  // DOUBLE LOW-9 QUOTATION MARK
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$2219;  // BULLET OPERATOR
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$00b9;  // SUPERSCRIPT ONE
    $fc: Result:= #$00b3;  // SUPERSCRIPT THREE
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp775_DOSBaltRim sequence of code point %d',[W]);
  end;
end;

function cp850ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$19,$1b,$1d..$7e: Result:= WideChar(W);
    $1a: Result:= #$001c;
    $1c: Result:= #$007f;
    $7f: Result:= #$001a;
    $80: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $85: Result:= #$00e0;  // LATIN SMALL LETTER A WITH GRAVE
    $86: Result:= #$00e5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $87: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $88: Result:= #$00ea;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $89: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $8a: Result:= #$00e8;  // LATIN SMALL LETTER E WITH GRAVE
    $8b: Result:= #$00ef;  // LATIN SMALL LETTER I WITH DIAERESIS
    $8c: Result:= #$00ee;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $8d: Result:= #$00ec;  // LATIN SMALL LETTER I WITH GRAVE
    $8e: Result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $8f: Result:= #$00c5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$00e6;  // LATIN SMALL LIGATURE AE
    $92: Result:= #$00c6;  // LATIN CAPITAL LIGATURE AE
    $93: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $94: Result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $95: Result:= #$00f2;  // LATIN SMALL LETTER O WITH GRAVE
    $96: Result:= #$00fb;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $97: Result:= #$00f9;  // LATIN SMALL LETTER U WITH GRAVE
    $98: Result:= #$00ff;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $99: Result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$00f8;  // LATIN SMALL LETTER O WITH STROKE
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00d8;  // LATIN CAPITAL LETTER O WITH STROKE
    $9e: Result:= #$00d7;  // MULTIPLICATION SIGN
    $9f: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $a0: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $a1: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$00f1;  // LATIN SMALL LETTER N WITH TILDE
    $a5: Result:= #$00d1;  // LATIN CAPITAL LETTER N WITH TILDE
    $a6: Result:= #$00aa;  // FEMININE ORDINAL INDICATOR
    $a7: Result:= #$00ba;  // MASCULINE ORDINAL INDICATOR
    $a8: Result:= #$00bf;  // INVERTED QUESTION MARK
    $a9: Result:= #$00ae;  // REGISTERED SIGN
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$00a1;  // INVERTED EXCLAMATION MARK
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$00c1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $b6: Result:= #$00c2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $b7: Result:= #$00c0;  // LATIN CAPITAL LETTER A WITH GRAVE
    $b8: Result:= #$00a9;  // COPYRIGHT SIGN
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$00a2;  // CENT SIGN
    $be: Result:= #$00a5;  // YEN SIGN
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$00e3;  // LATIN SMALL LETTER A WITH TILDE
    $c7: Result:= #$00c3;  // LATIN CAPITAL LETTER A WITH TILDE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$00a4;  // CURRENCY SIGN
    $d0: Result:= #$00f0;  // LATIN SMALL LETTER ETH
    $d1: Result:= #$00d0;  // LATIN CAPITAL LETTER ETH
    $d2: Result:= #$00ca;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $d3: Result:= #$00cb;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $d4: Result:= #$00c8;  // LATIN CAPITAL LETTER E WITH GRAVE
    $d5: Result:= #$0131;  // LATIN SMALL LETTER DOTLESS I
    $d6: Result:= #$00cd;  // LATIN CAPITAL LETTER I WITH ACUTE
    $d7: Result:= #$00ce;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $d8: Result:= #$00cf;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$00a6;  // BROKEN BAR
    $de: Result:= #$00cc;  // LATIN CAPITAL LETTER I WITH GRAVE
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$00d3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e2: Result:= #$00d4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $e3: Result:= #$00d2;  // LATIN CAPITAL LETTER O WITH GRAVE
    $e4: Result:= #$00f5;  // LATIN SMALL LETTER O WITH TILDE
    $e5: Result:= #$00d5;  // LATIN CAPITAL LETTER O WITH TILDE
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e7: Result:= #$00fe;  // LATIN SMALL LETTER THORN
    $e8: Result:= #$00de;  // LATIN CAPITAL LETTER THORN
    $e9: Result:= #$00da;  // LATIN CAPITAL LETTER U WITH ACUTE
    $ea: Result:= #$00db;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $eb: Result:= #$00d9;  // LATIN CAPITAL LETTER U WITH GRAVE
    $ec: Result:= #$00fd;  // LATIN SMALL LETTER Y WITH ACUTE
    $ed: Result:= #$00dd;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $ee: Result:= #$00af;  // MACRON
    $ef: Result:= #$00b4;  // ACUTE ACCENT
    $f0: Result:= #$00ad;  // SOFT HYPHEN
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$2017;  // DOUBLE LOW LINE
    $f3: Result:= #$00be;  // VULGAR FRACTION THREE QUARTERS
    $f4: Result:= #$00b6;  // PILCROW SIGN
    $f5: Result:= #$00a7;  // SECTION SIGN
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$00b8;  // CEDILLA
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$00a8;  // DIAERESIS
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$00b9;  // SUPERSCRIPT ONE
    $fc: Result:= #$00b3;  // SUPERSCRIPT THREE
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp850 sequence of code point %d',[W]);
  end;
end;

function cp850_DOSLatin1ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$7f: Result:= WideChar(W);
    $80: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $85: Result:= #$00e0;  // LATIN SMALL LETTER A WITH GRAVE
    $86: Result:= #$00e5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $87: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $88: Result:= #$00ea;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $89: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $8a: Result:= #$00e8;  // LATIN SMALL LETTER E WITH GRAVE
    $8b: Result:= #$00ef;  // LATIN SMALL LETTER I WITH DIAERESIS
    $8c: Result:= #$00ee;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $8d: Result:= #$00ec;  // LATIN SMALL LETTER I WITH GRAVE
    $8e: Result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $8f: Result:= #$00c5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$00e6;  // LATIN SMALL LIGATURE AE
    $92: Result:= #$00c6;  // LATIN CAPITAL LIGATURE AE
    $93: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $94: Result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $95: Result:= #$00f2;  // LATIN SMALL LETTER O WITH GRAVE
    $96: Result:= #$00fb;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $97: Result:= #$00f9;  // LATIN SMALL LETTER U WITH GRAVE
    $98: Result:= #$00ff;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $99: Result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$00f8;  // LATIN SMALL LETTER O WITH STROKE
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00d8;  // LATIN CAPITAL LETTER O WITH STROKE
    $9e: Result:= #$00d7;  // MULTIPLICATION SIGN
    $9f: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $a0: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $a1: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$00f1;  // LATIN SMALL LETTER N WITH TILDE
    $a5: Result:= #$00d1;  // LATIN CAPITAL LETTER N WITH TILDE
    $a6: Result:= #$00aa;  // FEMININE ORDINAL INDICATOR
    $a7: Result:= #$00ba;  // MASCULINE ORDINAL INDICATOR
    $a8: Result:= #$00bf;  // INVERTED QUESTION MARK
    $a9: Result:= #$00ae;  // REGISTERED SIGN
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$00a1;  // INVERTED EXCLAMATION MARK
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$00c1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $b6: Result:= #$00c2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $b7: Result:= #$00c0;  // LATIN CAPITAL LETTER A WITH GRAVE
    $b8: Result:= #$00a9;  // COPYRIGHT SIGN
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$00a2;  // CENT SIGN
    $be: Result:= #$00a5;  // YEN SIGN
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$00e3;  // LATIN SMALL LETTER A WITH TILDE
    $c7: Result:= #$00c3;  // LATIN CAPITAL LETTER A WITH TILDE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$00a4;  // CURRENCY SIGN
    $d0: Result:= #$00f0;  // LATIN SMALL LETTER ETH
    $d1: Result:= #$00d0;  // LATIN CAPITAL LETTER ETH
    $d2: Result:= #$00ca;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $d3: Result:= #$00cb;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $d4: Result:= #$00c8;  // LATIN CAPITAL LETTER E WITH GRAVE
    $d5: Result:= #$0131;  // LATIN SMALL LETTER DOTLESS I
    $d6: Result:= #$00cd;  // LATIN CAPITAL LETTER I WITH ACUTE
    $d7: Result:= #$00ce;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $d8: Result:= #$00cf;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$00a6;  // BROKEN BAR
    $de: Result:= #$00cc;  // LATIN CAPITAL LETTER I WITH GRAVE
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$00d3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e2: Result:= #$00d4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $e3: Result:= #$00d2;  // LATIN CAPITAL LETTER O WITH GRAVE
    $e4: Result:= #$00f5;  // LATIN SMALL LETTER O WITH TILDE
    $e5: Result:= #$00d5;  // LATIN CAPITAL LETTER O WITH TILDE
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e7: Result:= #$00fe;  // LATIN SMALL LETTER THORN
    $e8: Result:= #$00de;  // LATIN CAPITAL LETTER THORN
    $e9: Result:= #$00da;  // LATIN CAPITAL LETTER U WITH ACUTE
    $ea: Result:= #$00db;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $eb: Result:= #$00d9;  // LATIN CAPITAL LETTER U WITH GRAVE
    $ec: Result:= #$00fd;  // LATIN SMALL LETTER Y WITH ACUTE
    $ed: Result:= #$00dd;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $ee: Result:= #$00af;  // MACRON
    $ef: Result:= #$00b4;  // ACUTE ACCENT
    $f0: Result:= #$00ad;  // SOFT HYPHEN
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$2017;  // DOUBLE LOW LINE
    $f3: Result:= #$00be;  // VULGAR FRACTION THREE QUARTERS
    $f4: Result:= #$00b6;  // PILCROW SIGN
    $f5: Result:= #$00a7;  // SECTION SIGN
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$00b8;  // CEDILLA
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$00a8;  // DIAERESIS
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$00b9;  // SUPERSCRIPT ONE
    $fc: Result:= #$00b3;  // SUPERSCRIPT THREE
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp850_DOSLatin1 sequence of code point %d',[W]);
  end;
end;

function cp852ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$19,$1b,$1d..$7e: Result:= WideChar(W);
    $1a: Result:= #$001c;
    $1c: Result:= #$007f;
    $7f: Result:= #$001a;
    $80: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $85: Result:= #$016f;  // LATIN SMALL LETTER U WITH RING ABOVE
    $86: Result:= #$0107;  // LATIN SMALL LETTER C WITH ACUTE
    $87: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $88: Result:= #$0142;  // LATIN SMALL LETTER L WITH STROKE
    $89: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $8a: Result:= #$0150;  // LATIN CAPITAL LETTER O WITH DOUBLE ACUTE
    $8b: Result:= #$0151;  // LATIN SMALL LETTER O WITH DOUBLE ACUTE
    $8c: Result:= #$00ee;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $8d: Result:= #$0179;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $8e: Result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $8f: Result:= #$0106;  // LATIN CAPITAL LETTER C WITH ACUTE
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$0139;  // LATIN CAPITAL LETTER L WITH ACUTE
    $92: Result:= #$013a;  // LATIN SMALL LETTER L WITH ACUTE
    $93: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $94: Result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $95: Result:= #$013d;  // LATIN CAPITAL LETTER L WITH CARON
    $96: Result:= #$013e;  // LATIN SMALL LETTER L WITH CARON
    $97: Result:= #$015a;  // LATIN CAPITAL LETTER S WITH ACUTE
    $98: Result:= #$015b;  // LATIN SMALL LETTER S WITH ACUTE
    $99: Result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$0164;  // LATIN CAPITAL LETTER T WITH CARON
    $9c: Result:= #$0165;  // LATIN SMALL LETTER T WITH CARON
    $9d: Result:= #$0141;  // LATIN CAPITAL LETTER L WITH STROKE
    $9e: Result:= #$00d7;  // MULTIPLICATION SIGN
    $9f: Result:= #$010d;  // LATIN SMALL LETTER C WITH CARON
    $a0: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $a1: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$0104;  // LATIN CAPITAL LETTER A WITH OGONEK
    $a5: Result:= #$0105;  // LATIN SMALL LETTER A WITH OGONEK
    $a6: Result:= #$017d;  // LATIN CAPITAL LETTER Z WITH CARON
    $a7: Result:= #$017e;  // LATIN SMALL LETTER Z WITH CARON
    $a8: Result:= #$0118;  // LATIN CAPITAL LETTER E WITH OGONEK
    $a9: Result:= #$0119;  // LATIN SMALL LETTER E WITH OGONEK
    $ab: Result:= #$017a;  // LATIN SMALL LETTER Z WITH ACUTE
    $ac: Result:= #$010c;  // LATIN CAPITAL LETTER C WITH CARON
    $ad: Result:= #$015f;  // LATIN SMALL LETTER S WITH CEDILLA
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$00c1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $b6: Result:= #$00c2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $b7: Result:= #$011a;  // LATIN CAPITAL LETTER E WITH CARON
    $b8: Result:= #$015e;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$017b;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $be: Result:= #$017c;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$0102;  // LATIN CAPITAL LETTER A WITH BREVE
    $c7: Result:= #$0103;  // LATIN SMALL LETTER A WITH BREVE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$00a4;  // CURRENCY SIGN
    $d0: Result:= #$0111;  // LATIN SMALL LETTER D WITH STROKE
    $d1: Result:= #$0110;  // LATIN CAPITAL LETTER D WITH STROKE
    $d2: Result:= #$010e;  // LATIN CAPITAL LETTER D WITH CARON
    $d3: Result:= #$00cb;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $d4: Result:= #$010f;  // LATIN SMALL LETTER D WITH CARON
    $d5: Result:= #$0147;  // LATIN CAPITAL LETTER N WITH CARON
    $d6: Result:= #$00cd;  // LATIN CAPITAL LETTER I WITH ACUTE
    $d7: Result:= #$00ce;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $d8: Result:= #$011b;  // LATIN SMALL LETTER E WITH CARON
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$0162;  // LATIN CAPITAL LETTER T WITH CEDILLA
    $de: Result:= #$016e;  // LATIN CAPITAL LETTER U WITH RING ABOVE
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$00d3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e2: Result:= #$00d4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $e3: Result:= #$0143;  // LATIN CAPITAL LETTER N WITH ACUTE
    $e4: Result:= #$0144;  // LATIN SMALL LETTER N WITH ACUTE
    $e5: Result:= #$0148;  // LATIN SMALL LETTER N WITH CARON
    $e6: Result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $e7: Result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $e8: Result:= #$0154;  // LATIN CAPITAL LETTER R WITH ACUTE
    $e9: Result:= #$00da;  // LATIN CAPITAL LETTER U WITH ACUTE
    $ea: Result:= #$0155;  // LATIN SMALL LETTER R WITH ACUTE
    $eb: Result:= #$0170;  // LATIN CAPITAL LETTER U WITH DOUBLE ACUTE
    $ec: Result:= #$00fd;  // LATIN SMALL LETTER Y WITH ACUTE
    $ed: Result:= #$00dd;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $ee: Result:= #$0163;  // LATIN SMALL LETTER T WITH CEDILLA
    $ef: Result:= #$00b4;  // ACUTE ACCENT
    $f0: Result:= #$00ad;  // SOFT HYPHEN
    $f1: Result:= #$02dd;  // DOUBLE ACUTE ACCENT
    $f2: Result:= #$02db;  // OGONEK
    $f3: Result:= #$02c7;  // CARON
    $f4: Result:= #$02d8;  // BREVE
    $f5: Result:= #$00a7;  // SECTION SIGN
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$00b8;  // CEDILLA
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$00a8;  // DIAERESIS
    $fa: Result:= #$02d9;  // DOT ABOVE
    $fb: Result:= #$0171;  // LATIN SMALL LETTER U WITH DOUBLE ACUTE
    $fc: Result:= #$0158;  // LATIN CAPITAL LETTER R WITH CARON
    $fd: Result:= #$0159;  // LATIN SMALL LETTER R WITH CARON
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp852 sequence of code point %d',[W]);
  end;
end;

function cp852_DOSLatin2ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$7f: Result:= WideChar(W);
    $80: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $85: Result:= #$016f;  // LATIN SMALL LETTER U WITH RING ABOVE
    $86: Result:= #$0107;  // LATIN SMALL LETTER C WITH ACUTE
    $87: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $88: Result:= #$0142;  // LATIN SMALL LETTER L WITH STROKE
    $89: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $8a: Result:= #$0150;  // LATIN CAPITAL LETTER O WITH DOUBLE ACUTE
    $8b: Result:= #$0151;  // LATIN SMALL LETTER O WITH DOUBLE ACUTE
    $8c: Result:= #$00ee;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $8d: Result:= #$0179;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $8e: Result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $8f: Result:= #$0106;  // LATIN CAPITAL LETTER C WITH ACUTE
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$0139;  // LATIN CAPITAL LETTER L WITH ACUTE
    $92: Result:= #$013a;  // LATIN SMALL LETTER L WITH ACUTE
    $93: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $94: Result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $95: Result:= #$013d;  // LATIN CAPITAL LETTER L WITH CARON
    $96: Result:= #$013e;  // LATIN SMALL LETTER L WITH CARON
    $97: Result:= #$015a;  // LATIN CAPITAL LETTER S WITH ACUTE
    $98: Result:= #$015b;  // LATIN SMALL LETTER S WITH ACUTE
    $99: Result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$0164;  // LATIN CAPITAL LETTER T WITH CARON
    $9c: Result:= #$0165;  // LATIN SMALL LETTER T WITH CARON
    $9d: Result:= #$0141;  // LATIN CAPITAL LETTER L WITH STROKE
    $9e: Result:= #$00d7;  // MULTIPLICATION SIGN
    $9f: Result:= #$010d;  // LATIN SMALL LETTER C WITH CARON
    $a0: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $a1: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$0104;  // LATIN CAPITAL LETTER A WITH OGONEK
    $a5: Result:= #$0105;  // LATIN SMALL LETTER A WITH OGONEK
    $a6: Result:= #$017d;  // LATIN CAPITAL LETTER Z WITH CARON
    $a7: Result:= #$017e;  // LATIN SMALL LETTER Z WITH CARON
    $a8: Result:= #$0118;  // LATIN CAPITAL LETTER E WITH OGONEK
    $a9: Result:= #$0119;  // LATIN SMALL LETTER E WITH OGONEK
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$017a;  // LATIN SMALL LETTER Z WITH ACUTE
    $ac: Result:= #$010c;  // LATIN CAPITAL LETTER C WITH CARON
    $ad: Result:= #$015f;  // LATIN SMALL LETTER S WITH CEDILLA
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$00c1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $b6: Result:= #$00c2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $b7: Result:= #$011a;  // LATIN CAPITAL LETTER E WITH CARON
    $b8: Result:= #$015e;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$017b;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $be: Result:= #$017c;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$0102;  // LATIN CAPITAL LETTER A WITH BREVE
    $c7: Result:= #$0103;  // LATIN SMALL LETTER A WITH BREVE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$00a4;  // CURRENCY SIGN
    $d0: Result:= #$0111;  // LATIN SMALL LETTER D WITH STROKE
    $d1: Result:= #$0110;  // LATIN CAPITAL LETTER D WITH STROKE
    $d2: Result:= #$010e;  // LATIN CAPITAL LETTER D WITH CARON
    $d3: Result:= #$00cb;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $d4: Result:= #$010f;  // LATIN SMALL LETTER D WITH CARON
    $d5: Result:= #$0147;  // LATIN CAPITAL LETTER N WITH CARON
    $d6: Result:= #$00cd;  // LATIN CAPITAL LETTER I WITH ACUTE
    $d7: Result:= #$00ce;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $d8: Result:= #$011b;  // LATIN SMALL LETTER E WITH CARON
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$0162;  // LATIN CAPITAL LETTER T WITH CEDILLA
    $de: Result:= #$016e;  // LATIN CAPITAL LETTER U WITH RING ABOVE
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$00d3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e2: Result:= #$00d4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $e3: Result:= #$0143;  // LATIN CAPITAL LETTER N WITH ACUTE
    $e4: Result:= #$0144;  // LATIN SMALL LETTER N WITH ACUTE
    $e5: Result:= #$0148;  // LATIN SMALL LETTER N WITH CARON
    $e6: Result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $e7: Result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $e8: Result:= #$0154;  // LATIN CAPITAL LETTER R WITH ACUTE
    $e9: Result:= #$00da;  // LATIN CAPITAL LETTER U WITH ACUTE
    $ea: Result:= #$0155;  // LATIN SMALL LETTER R WITH ACUTE
    $eb: Result:= #$0170;  // LATIN CAPITAL LETTER U WITH DOUBLE ACUTE
    $ec: Result:= #$00fd;  // LATIN SMALL LETTER Y WITH ACUTE
    $ed: Result:= #$00dd;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $ee: Result:= #$0163;  // LATIN SMALL LETTER T WITH CEDILLA
    $ef: Result:= #$00b4;  // ACUTE ACCENT
    $f0: Result:= #$00ad;  // SOFT HYPHEN
    $f1: Result:= #$02dd;  // DOUBLE ACUTE ACCENT
    $f2: Result:= #$02db;  // OGONEK
    $f3: Result:= #$02c7;  // CARON
    $f4: Result:= #$02d8;  // BREVE
    $f5: Result:= #$00a7;  // SECTION SIGN
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$00b8;  // CEDILLA
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$00a8;  // DIAERESIS
    $fa: Result:= #$02d9;  // DOT ABOVE
    $fb: Result:= #$0171;  // LATIN SMALL LETTER U WITH DOUBLE ACUTE
    $fc: Result:= #$0158;  // LATIN CAPITAL LETTER R WITH CARON
    $fd: Result:= #$0159;  // LATIN SMALL LETTER R WITH CARON
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp852_DOSLatin2 sequence of code point %d',[W]);
  end;
end;

function cp855ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$19,$1b,$1d..$7e: Result:= WideChar(W);
    $1a: Result:= #$001c;
    $1c: Result:= #$007f;
    $7f: Result:= #$001a;
    $80: Result:= #$0452;  // CYRILLIC SMALL LETTER DJE
    $81: Result:= #$0402;  // CYRILLIC CAPITAL LETTER DJE
    $82: Result:= #$0453;  // CYRILLIC SMALL LETTER GJE
    $83: Result:= #$0403;  // CYRILLIC CAPITAL LETTER GJE
    $84: Result:= #$0451;  // CYRILLIC SMALL LETTER IO
    $85: Result:= #$0401;  // CYRILLIC CAPITAL LETTER IO
    $86: Result:= #$0454;  // CYRILLIC SMALL LETTER UKRAINIAN IE
    $87: Result:= #$0404;  // CYRILLIC CAPITAL LETTER UKRAINIAN IE
    $88: Result:= #$0455;  // CYRILLIC SMALL LETTER DZE
    $89: Result:= #$0405;  // CYRILLIC CAPITAL LETTER DZE
    $8a: Result:= #$0456;  // CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I
    $8b: Result:= #$0406;  // CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I
    $8c: Result:= #$0457;  // CYRILLIC SMALL LETTER YI
    $8d: Result:= #$0407;  // CYRILLIC CAPITAL LETTER YI
    $8e: Result:= #$0458;  // CYRILLIC SMALL LETTER JE
    $8f: Result:= #$0408;  // CYRILLIC CAPITAL LETTER JE
    $90: Result:= #$0459;  // CYRILLIC SMALL LETTER LJE
    $91: Result:= #$0409;  // CYRILLIC CAPITAL LETTER LJE
    $92: Result:= #$045a;  // CYRILLIC SMALL LETTER NJE
    $93: Result:= #$040a;  // CYRILLIC CAPITAL LETTER NJE
    $94: Result:= #$045b;  // CYRILLIC SMALL LETTER TSHE
    $95: Result:= #$040b;  // CYRILLIC CAPITAL LETTER TSHE
    $96: Result:= #$045c;  // CYRILLIC SMALL LETTER KJE
    $97: Result:= #$040c;  // CYRILLIC CAPITAL LETTER KJE
    $98: Result:= #$045e;  // CYRILLIC SMALL LETTER SHORT U
    $99: Result:= #$040e;  // CYRILLIC CAPITAL LETTER SHORT U
    $9a: Result:= #$045f;  // CYRILLIC SMALL LETTER DZHE
    $9b: Result:= #$040f;  // CYRILLIC CAPITAL LETTER DZHE
    $9c: Result:= #$044e;  // CYRILLIC SMALL LETTER YU
    $9d: Result:= #$042e;  // CYRILLIC CAPITAL LETTER YU
    $9e: Result:= #$044a;  // CYRILLIC SMALL LETTER HARD SIGN
    $9f: Result:= #$042a;  // CYRILLIC CAPITAL LETTER HARD SIGN
    $a0: Result:= #$0430;  // CYRILLIC SMALL LETTER A
    $a1: Result:= #$0410;  // CYRILLIC CAPITAL LETTER A
    $a2: Result:= #$0431;  // CYRILLIC SMALL LETTER BE
    $a3: Result:= #$0411;  // CYRILLIC CAPITAL LETTER BE
    $a4: Result:= #$0446;  // CYRILLIC SMALL LETTER TSE
    $a5: Result:= #$0426;  // CYRILLIC CAPITAL LETTER TSE
    $a6: Result:= #$0434;  // CYRILLIC SMALL LETTER DE
    $a7: Result:= #$0414;  // CYRILLIC CAPITAL LETTER DE
    $a8: Result:= #$0435;  // CYRILLIC SMALL LETTER IE
    $a9: Result:= #$0415;  // CYRILLIC CAPITAL LETTER IE
    $aa: Result:= #$0444;  // CYRILLIC SMALL LETTER EF
    $ab: Result:= #$0424;  // CYRILLIC CAPITAL LETTER EF
    $ac: Result:= #$0433;  // CYRILLIC SMALL LETTER GHE
    $ad: Result:= #$0413;  // CYRILLIC CAPITAL LETTER GHE
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$0445;  // CYRILLIC SMALL LETTER HA
    $b6: Result:= #$0425;  // CYRILLIC CAPITAL LETTER HA
    $b7: Result:= #$0438;  // CYRILLIC SMALL LETTER I
    $b8: Result:= #$0418;  // CYRILLIC CAPITAL LETTER I
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$0439;  // CYRILLIC SMALL LETTER SHORT I
    $be: Result:= #$0419;  // CYRILLIC CAPITAL LETTER SHORT I
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$043a;  // CYRILLIC SMALL LETTER KA
    $c7: Result:= #$041a;  // CYRILLIC CAPITAL LETTER KA
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$00a4;  // CURRENCY SIGN
    $d0: Result:= #$043b;  // CYRILLIC SMALL LETTER EL
    $d1: Result:= #$041b;  // CYRILLIC CAPITAL LETTER EL
    $d2: Result:= #$043c;  // CYRILLIC SMALL LETTER EM
    $d3: Result:= #$041c;  // CYRILLIC CAPITAL LETTER EM
    $d4: Result:= #$043d;  // CYRILLIC SMALL LETTER EN
    $d5: Result:= #$041d;  // CYRILLIC CAPITAL LETTER EN
    $d6: Result:= #$043e;  // CYRILLIC SMALL LETTER O
    $d7: Result:= #$041e;  // CYRILLIC CAPITAL LETTER O
    $d8: Result:= #$043f;  // CYRILLIC SMALL LETTER PE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$041f;  // CYRILLIC CAPITAL LETTER PE
    $de: Result:= #$044f;  // CYRILLIC SMALL LETTER YA
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$042f;  // CYRILLIC CAPITAL LETTER YA
    $e1: Result:= #$0440;  // CYRILLIC SMALL LETTER ER
    $e2: Result:= #$0420;  // CYRILLIC CAPITAL LETTER ER
    $e3: Result:= #$0441;  // CYRILLIC SMALL LETTER ES
    $e4: Result:= #$0421;  // CYRILLIC CAPITAL LETTER ES
    $e5: Result:= #$0442;  // CYRILLIC SMALL LETTER TE
    $e6: Result:= #$0422;  // CYRILLIC CAPITAL LETTER TE
    $e7: Result:= #$0443;  // CYRILLIC SMALL LETTER U
    $e8: Result:= #$0423;  // CYRILLIC CAPITAL LETTER U
    $e9: Result:= #$0436;  // CYRILLIC SMALL LETTER ZHE
    $ea: Result:= #$0416;  // CYRILLIC CAPITAL LETTER ZHE
    $eb: Result:= #$0432;  // CYRILLIC SMALL LETTER VE
    $ec: Result:= #$0412;  // CYRILLIC CAPITAL LETTER VE
    $ed: Result:= #$044c;  // CYRILLIC SMALL LETTER SOFT SIGN
    $ee: Result:= #$042c;  // CYRILLIC CAPITAL LETTER SOFT SIGN
    $ef: Result:= #$2116;  // NUMERO SIGN
    $f0: Result:= #$00ad;  // SOFT HYPHEN
    $f1: Result:= #$044b;  // CYRILLIC SMALL LETTER YERU
    $f2: Result:= #$042b;  // CYRILLIC CAPITAL LETTER YERU
    $f3: Result:= #$0437;  // CYRILLIC SMALL LETTER ZE
    $f4: Result:= #$0417;  // CYRILLIC CAPITAL LETTER ZE
    $f5: Result:= #$0448;  // CYRILLIC SMALL LETTER SHA
    $f6: Result:= #$0428;  // CYRILLIC CAPITAL LETTER SHA
    $f7: Result:= #$044d;  // CYRILLIC SMALL LETTER E
    $f8: Result:= #$042d;  // CYRILLIC CAPITAL LETTER E
    $f9: Result:= #$0449;  // CYRILLIC SMALL LETTER SHCHA
    $fa: Result:= #$0429;  // CYRILLIC CAPITAL LETTER SHCHA
    $fb: Result:= #$0447;  // CYRILLIC SMALL LETTER CHE
    $fc: Result:= #$0427;  // CYRILLIC CAPITAL LETTER CHE
    $fd: Result:= #$00a7;  // SECTION SIGN
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp855 sequence of code point %d',[W]);
  end;
end;

function cp855_DOSCyrillicToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$7f: Result:= WideChar(W);
    $80: Result:= #$0452;  // CYRILLIC SMALL LETTER DJE
    $81: Result:= #$0402;  // CYRILLIC CAPITAL LETTER DJE
    $82: Result:= #$0453;  // CYRILLIC SMALL LETTER GJE
    $83: Result:= #$0403;  // CYRILLIC CAPITAL LETTER GJE
    $84: Result:= #$0451;  // CYRILLIC SMALL LETTER IO
    $85: Result:= #$0401;  // CYRILLIC CAPITAL LETTER IO
    $86: Result:= #$0454;  // CYRILLIC SMALL LETTER UKRAINIAN IE
    $87: Result:= #$0404;  // CYRILLIC CAPITAL LETTER UKRAINIAN IE
    $88: Result:= #$0455;  // CYRILLIC SMALL LETTER DZE
    $89: Result:= #$0405;  // CYRILLIC CAPITAL LETTER DZE
    $8a: Result:= #$0456;  // CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I
    $8b: Result:= #$0406;  // CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I
    $8c: Result:= #$0457;  // CYRILLIC SMALL LETTER YI
    $8d: Result:= #$0407;  // CYRILLIC CAPITAL LETTER YI
    $8e: Result:= #$0458;  // CYRILLIC SMALL LETTER JE
    $8f: Result:= #$0408;  // CYRILLIC CAPITAL LETTER JE
    $90: Result:= #$0459;  // CYRILLIC SMALL LETTER LJE
    $91: Result:= #$0409;  // CYRILLIC CAPITAL LETTER LJE
    $92: Result:= #$045a;  // CYRILLIC SMALL LETTER NJE
    $93: Result:= #$040a;  // CYRILLIC CAPITAL LETTER NJE
    $94: Result:= #$045b;  // CYRILLIC SMALL LETTER TSHE
    $95: Result:= #$040b;  // CYRILLIC CAPITAL LETTER TSHE
    $96: Result:= #$045c;  // CYRILLIC SMALL LETTER KJE
    $97: Result:= #$040c;  // CYRILLIC CAPITAL LETTER KJE
    $98: Result:= #$045e;  // CYRILLIC SMALL LETTER SHORT U
    $99: Result:= #$040e;  // CYRILLIC CAPITAL LETTER SHORT U
    $9a: Result:= #$045f;  // CYRILLIC SMALL LETTER DZHE
    $9b: Result:= #$040f;  // CYRILLIC CAPITAL LETTER DZHE
    $9c: Result:= #$044e;  // CYRILLIC SMALL LETTER YU
    $9d: Result:= #$042e;  // CYRILLIC CAPITAL LETTER YU
    $9e: Result:= #$044a;  // CYRILLIC SMALL LETTER HARD SIGN
    $9f: Result:= #$042a;  // CYRILLIC CAPITAL LETTER HARD SIGN
    $a0: Result:= #$0430;  // CYRILLIC SMALL LETTER A
    $a1: Result:= #$0410;  // CYRILLIC CAPITAL LETTER A
    $a2: Result:= #$0431;  // CYRILLIC SMALL LETTER BE
    $a3: Result:= #$0411;  // CYRILLIC CAPITAL LETTER BE
    $a4: Result:= #$0446;  // CYRILLIC SMALL LETTER TSE
    $a5: Result:= #$0426;  // CYRILLIC CAPITAL LETTER TSE
    $a6: Result:= #$0434;  // CYRILLIC SMALL LETTER DE
    $a7: Result:= #$0414;  // CYRILLIC CAPITAL LETTER DE
    $a8: Result:= #$0435;  // CYRILLIC SMALL LETTER IE
    $a9: Result:= #$0415;  // CYRILLIC CAPITAL LETTER IE
    $aa: Result:= #$0444;  // CYRILLIC SMALL LETTER EF
    $ab: Result:= #$0424;  // CYRILLIC CAPITAL LETTER EF
    $ac: Result:= #$0433;  // CYRILLIC SMALL LETTER GHE
    $ad: Result:= #$0413;  // CYRILLIC CAPITAL LETTER GHE
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$0445;  // CYRILLIC SMALL LETTER HA
    $b6: Result:= #$0425;  // CYRILLIC CAPITAL LETTER HA
    $b7: Result:= #$0438;  // CYRILLIC SMALL LETTER I
    $b8: Result:= #$0418;  // CYRILLIC CAPITAL LETTER I
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$0439;  // CYRILLIC SMALL LETTER SHORT I
    $be: Result:= #$0419;  // CYRILLIC CAPITAL LETTER SHORT I
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$043a;  // CYRILLIC SMALL LETTER KA
    $c7: Result:= #$041a;  // CYRILLIC CAPITAL LETTER KA
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$00a4;  // CURRENCY SIGN
    $d0: Result:= #$043b;  // CYRILLIC SMALL LETTER EL
    $d1: Result:= #$041b;  // CYRILLIC CAPITAL LETTER EL
    $d2: Result:= #$043c;  // CYRILLIC SMALL LETTER EM
    $d3: Result:= #$041c;  // CYRILLIC CAPITAL LETTER EM
    $d4: Result:= #$043d;  // CYRILLIC SMALL LETTER EN
    $d5: Result:= #$041d;  // CYRILLIC CAPITAL LETTER EN
    $d6: Result:= #$043e;  // CYRILLIC SMALL LETTER O
    $d7: Result:= #$041e;  // CYRILLIC CAPITAL LETTER O
    $d8: Result:= #$043f;  // CYRILLIC SMALL LETTER PE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$041f;  // CYRILLIC CAPITAL LETTER PE
    $de: Result:= #$044f;  // CYRILLIC SMALL LETTER YA
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$042f;  // CYRILLIC CAPITAL LETTER YA
    $e1: Result:= #$0440;  // CYRILLIC SMALL LETTER ER
    $e2: Result:= #$0420;  // CYRILLIC CAPITAL LETTER ER
    $e3: Result:= #$0441;  // CYRILLIC SMALL LETTER ES
    $e4: Result:= #$0421;  // CYRILLIC CAPITAL LETTER ES
    $e5: Result:= #$0442;  // CYRILLIC SMALL LETTER TE
    $e6: Result:= #$0422;  // CYRILLIC CAPITAL LETTER TE
    $e7: Result:= #$0443;  // CYRILLIC SMALL LETTER U
    $e8: Result:= #$0423;  // CYRILLIC CAPITAL LETTER U
    $e9: Result:= #$0436;  // CYRILLIC SMALL LETTER ZHE
    $ea: Result:= #$0416;  // CYRILLIC CAPITAL LETTER ZHE
    $eb: Result:= #$0432;  // CYRILLIC SMALL LETTER VE
    $ec: Result:= #$0412;  // CYRILLIC CAPITAL LETTER VE
    $ed: Result:= #$044c;  // CYRILLIC SMALL LETTER SOFT SIGN
    $ee: Result:= #$042c;  // CYRILLIC CAPITAL LETTER SOFT SIGN
    $ef: Result:= #$2116;  // NUMERO SIGN
    $f0: Result:= #$00ad;  // SOFT HYPHEN
    $f1: Result:= #$044b;  // CYRILLIC SMALL LETTER YERU
    $f2: Result:= #$042b;  // CYRILLIC CAPITAL LETTER YERU
    $f3: Result:= #$0437;  // CYRILLIC SMALL LETTER ZE
    $f4: Result:= #$0417;  // CYRILLIC CAPITAL LETTER ZE
    $f5: Result:= #$0448;  // CYRILLIC SMALL LETTER SHA
    $f6: Result:= #$0428;  // CYRILLIC CAPITAL LETTER SHA
    $f7: Result:= #$044d;  // CYRILLIC SMALL LETTER E
    $f8: Result:= #$042d;  // CYRILLIC CAPITAL LETTER E
    $f9: Result:= #$0449;  // CYRILLIC SMALL LETTER SHCHA
    $fa: Result:= #$0429;  // CYRILLIC CAPITAL LETTER SHCHA
    $fb: Result:= #$0447;  // CYRILLIC SMALL LETTER CHE
    $fc: Result:= #$0427;  // CYRILLIC CAPITAL LETTER CHE
    $fd: Result:= #$00a7;  // SECTION SIGN
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp855_DOSCyrillic sequence of code point %d',[W]);
  end;
end;

function cp856_Hebrew_PCToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$7F: Result:= WideChar(W);
    $80: Result:= #$05D0;  // HEBREW LETTER ALEF
    $81: Result:= #$05D1;  // HEBREW LETTER BET
    $82: Result:= #$05D2;  // HEBREW LETTER GIMEL
    $83: Result:= #$05D3;  // HEBREW LETTER DALET
    $84: Result:= #$05D4;  // HEBREW LETTER HE
    $85: Result:= #$05D5;  // HEBREW LETTER VAV
    $86: Result:= #$05D6;  // HEBREW LETTER ZAYIN
    $87: Result:= #$05D7;  // HEBREW LETTER HET
    $88: Result:= #$05D8;  // HEBREW LETTER TET
    $89: Result:= #$05D9;  // HEBREW LETTER YOD
    $8A: Result:= #$05DA;  // HEBREW LETTER FINAL KAF
    $8B: Result:= #$05DB;  // HEBREW LETTER KAF
    $8C: Result:= #$05DC;  // HEBREW LETTER LAMED
    $8D: Result:= #$05DD;  // HEBREW LETTER FINAL MEM
    $8E: Result:= #$05DE;  // HEBREW LETTER MEM
    $8F: Result:= #$05DF;  // HEBREW LETTER FINAL NUN
    $90: Result:= #$05E0;  // HEBREW LETTER NUN
    $91: Result:= #$05E1;  // HEBREW LETTER SAMEKH
    $92: Result:= #$05E2;  // HEBREW LETTER AYIN
    $93: Result:= #$05E3;  // HEBREW LETTER FINAL PE
    $94: Result:= #$05E4;  // HEBREW LETTER PE
    $95: Result:= #$05E5;  // HEBREW LETTER FINAL TSADI
    $96: Result:= #$05E6;  // HEBREW LETTER TSADI
    $97: Result:= #$05E7;  // HEBREW LETTER QOF
    $98: Result:= #$05E8;  // HEBREW LETTER RESH
    $99: Result:= #$05E9;  // HEBREW LETTER SHIN
    $9A: Result:= #$05EA;  // HEBREW LETTER TAV
    $9C: Result:= #$00A3;  // POUND SIGN
    $9E: Result:= #$00D7;  // MULTIPLICATION SIGN
    $A9: Result:= #$00AE;  // REGISTERED SIGN
    $AA: Result:= #$00AC;  // NOT SIGN
    $AB: Result:= #$00BD;  // VULGAR FRACTION ONE HALF
    $AC: Result:= #$00BC;  // VULGAR FRACTION ONE QUARTER
    $AE: Result:= #$00AB;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $AF: Result:= #$00BB;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $B0: Result:= #$2591;  // LIGHT SHADE
    $B1: Result:= #$2592;  // MEDIUM SHADE
    $B2: Result:= #$2593;  // DARK SHADE
    $B3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $B4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $B8: Result:= #$00A9;  // COPYRIGHT SIGN
    $B9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $BA: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $BB: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $BC: Result:= #$255D;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $BD: Result:= #$00A2;  // CENT SIGN
    $BE: Result:= #$00A5;  // YEN SIGN
    $BF: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $C0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $C1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $C2: Result:= #$252C;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $C3: Result:= #$251C;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $C4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $C5: Result:= #$253C;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $C8: Result:= #$255A;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $C9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $CA: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $CB: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $CC: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $CD: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $CE: Result:= #$256C;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $CF: Result:= #$00A4;  // CURRENCY SIGN
    $D9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $DA: Result:= #$250C;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $DB: Result:= #$2588;  // FULL BLOCK
    $DC: Result:= #$2584;  // LOWER HALF BLOCK
    $DD: Result:= #$00A6;  // BROKEN BAR
    $DF: Result:= #$2580;  // UPPER HALF BLOCK
    $E6: Result:= #$00B5;  // MICRO SIGN
    $EE: Result:= #$00AF;  // MACRON
    $EF: Result:= #$00B4;  // ACUTE ACCENT
    $F0: Result:= #$00AD;  // SOFT HYPHEN
    $F1: Result:= #$00B1;  // PLUS-MINUS SIGN
    $F2: Result:= #$2017;  // DOUBLE LOW LINE
    $F3: Result:= #$00BE;  // VULGAR FRACTION THREE QUARTERS
    $F4: Result:= #$00B6;  // PILCROW SIGN
    $F5: Result:= #$00A7;  // SECTION SIGN
    $F6: Result:= #$00F7;  // DIVISION SIGN
    $F7: Result:= #$00B8;  // CEDILLA
    $F8: Result:= #$00B0;  // DEGREE SIGN
    $F9: Result:= #$00A8;  // DIAERESIS
    $FA: Result:= #$00B7;  // MIDDLE DOT
    $FB: Result:= #$00B9;  // SUPERSCRIPT ONE
    $FC: Result:= #$00B3;  // SUPERSCRIPT THREE
    $FD: Result:= #$00B2;  // SUPERSCRIPT TWO
    $FE: Result:= #$25A0;  // BLACK SQUARE
    $FF: Result:= #$00A0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp856_Hebrew_PC sequence of code point %d',[W]);
  end;
end;

function cp857ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$19,$1b,$1d..$7e,$ec: Result:= WideChar(W);
    $1a: Result:= #$001c;
    $1c: Result:= #$007f;
    $7f: Result:= #$001a;
    $80: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $85: Result:= #$00e0;  // LATIN SMALL LETTER A WITH GRAVE
    $86: Result:= #$00e5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $87: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $88: Result:= #$00ea;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $89: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $8a: Result:= #$00e8;  // LATIN SMALL LETTER E WITH GRAVE
    $8b: Result:= #$00ef;  // LATIN SMALL LETTER I WITH DIAERESIS
    $8c: Result:= #$00ee;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $8d: Result:= #$0131;  // LATIN SMALL LETTER DOTLESS I
    $8e: Result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $8f: Result:= #$00c5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$00e6;  // LATIN SMALL LIGATURE AE
    $92: Result:= #$00c6;  // LATIN CAPITAL LIGATURE AE
    $93: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $94: Result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $95: Result:= #$00f2;  // LATIN SMALL LETTER O WITH GRAVE
    $96: Result:= #$00fb;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $97: Result:= #$00f9;  // LATIN SMALL LETTER U WITH GRAVE
    $98: Result:= #$0130;  // LATIN CAPITAL LETTER I WITH DOT ABOVE
    $99: Result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$00f8;  // LATIN SMALL LETTER O WITH STROKE
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00d8;  // LATIN CAPITAL LETTER O WITH STROKE
    $9e: Result:= #$015e;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $9f: Result:= #$015f;  // LATIN SMALL LETTER S WITH CEDILLA
    $a0: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $a1: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$00f1;  // LATIN SMALL LETTER N WITH TILDE
    $a5: Result:= #$00d1;  // LATIN CAPITAL LETTER N WITH TILDE
    $a6: Result:= #$011e;  // LATIN CAPITAL LETTER G WITH BREVE
    $a7: Result:= #$011f;  // LATIN SMALL LETTER G WITH BREVE
    $a8: Result:= #$00bf;  // INVERTED QUESTION MARK
    $a9: Result:= #$00ae;  // REGISTERED SIGN
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$00a1;  // INVERTED EXCLAMATION MARK
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$00c1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $b6: Result:= #$00c2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $b7: Result:= #$00c0;  // LATIN CAPITAL LETTER A WITH GRAVE
    $b8: Result:= #$00a9;  // COPYRIGHT SIGN
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$00a2;  // CENT SIGN
    $be: Result:= #$00a5;  // YEN SIGN
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$00e3;  // LATIN SMALL LETTER A WITH TILDE
    $c7: Result:= #$00c3;  // LATIN CAPITAL LETTER A WITH TILDE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$00a4;  // CURRENCY SIGN
    $d0: Result:= #$00ba;  // MASCULINE ORDINAL INDICATOR
    $d1: Result:= #$00aa;  // FEMININE ORDINAL INDICATOR
    $d2: Result:= #$00ca;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $d3: Result:= #$00cb;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $d4: Result:= #$00c8;  // LATIN CAPITAL LETTER E WITH GRAVE
    $d6: Result:= #$00cd;  // LATIN CAPITAL LETTER I WITH ACUTE
    $d7: Result:= #$00ce;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $d8: Result:= #$00cf;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$00a6;  // BROKEN BAR
    $de: Result:= #$00cc;  // LATIN CAPITAL LETTER I WITH GRAVE
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$00d3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e2: Result:= #$00d4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $e3: Result:= #$00d2;  // LATIN CAPITAL LETTER O WITH GRAVE
    $e4: Result:= #$00f5;  // LATIN SMALL LETTER O WITH TILDE
    $e5: Result:= #$00d5;  // LATIN CAPITAL LETTER O WITH TILDE
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e8: Result:= #$00d7;  // MULTIPLICATION SIGN
    $e9: Result:= #$00da;  // LATIN CAPITAL LETTER U WITH ACUTE
    $ea: Result:= #$00db;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $eb: Result:= #$00d9;  // LATIN CAPITAL LETTER U WITH GRAVE
    $ed: Result:= #$00ff;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $ee: Result:= #$00af;  // MACRON
    $ef: Result:= #$00b4;  // ACUTE ACCENT
    $f0: Result:= #$00ad;  // SOFT HYPHEN
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f3: Result:= #$00be;  // VULGAR FRACTION THREE QUARTERS
    $f4: Result:= #$00b6;  // PILCROW SIGN
    $f5: Result:= #$00a7;  // SECTION SIGN
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$00b8;  // CEDILLA
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$00a8;  // DIAERESIS
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$00b9;  // SUPERSCRIPT ONE
    $fc: Result:= #$00b3;  // SUPERSCRIPT THREE
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp857 sequence of code point %d',[W]);
  end;
end;

function cp857_DOSTurkishToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$7f,$ec: Result:= WideChar(W);
    $80: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $85: Result:= #$00e0;  // LATIN SMALL LETTER A WITH GRAVE
    $86: Result:= #$00e5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $87: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $88: Result:= #$00ea;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $89: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $8a: Result:= #$00e8;  // LATIN SMALL LETTER E WITH GRAVE
    $8b: Result:= #$00ef;  // LATIN SMALL LETTER I WITH DIAERESIS
    $8c: Result:= #$00ee;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $8d: Result:= #$0131;  // LATIN SMALL LETTER DOTLESS I
    $8e: Result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $8f: Result:= #$00c5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$00e6;  // LATIN SMALL LIGATURE AE
    $92: Result:= #$00c6;  // LATIN CAPITAL LIGATURE AE
    $93: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $94: Result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $95: Result:= #$00f2;  // LATIN SMALL LETTER O WITH GRAVE
    $96: Result:= #$00fb;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $97: Result:= #$00f9;  // LATIN SMALL LETTER U WITH GRAVE
    $98: Result:= #$0130;  // LATIN CAPITAL LETTER I WITH DOT ABOVE
    $99: Result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$00f8;  // LATIN SMALL LETTER O WITH STROKE
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00d8;  // LATIN CAPITAL LETTER O WITH STROKE
    $9e: Result:= #$015e;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $9f: Result:= #$015f;  // LATIN SMALL LETTER S WITH CEDILLA
    $a0: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $a1: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$00f1;  // LATIN SMALL LETTER N WITH TILDE
    $a5: Result:= #$00d1;  // LATIN CAPITAL LETTER N WITH TILDE
    $a6: Result:= #$011e;  // LATIN CAPITAL LETTER G WITH BREVE
    $a7: Result:= #$011f;  // LATIN SMALL LETTER G WITH BREVE
    $a8: Result:= #$00bf;  // INVERTED QUESTION MARK
    $a9: Result:= #$00ae;  // REGISTERED SIGN
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$00a1;  // INVERTED EXCLAMATION MARK
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$00c1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $b6: Result:= #$00c2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $b7: Result:= #$00c0;  // LATIN CAPITAL LETTER A WITH GRAVE
    $b8: Result:= #$00a9;  // COPYRIGHT SIGN
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$00a2;  // CENT SIGN
    $be: Result:= #$00a5;  // YEN SIGN
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$00e3;  // LATIN SMALL LETTER A WITH TILDE
    $c7: Result:= #$00c3;  // LATIN CAPITAL LETTER A WITH TILDE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$00a4;  // CURRENCY SIGN
    $d0: Result:= #$00ba;  // MASCULINE ORDINAL INDICATOR
    $d1: Result:= #$00aa;  // FEMININE ORDINAL INDICATOR
    $d2: Result:= #$00ca;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $d3: Result:= #$00cb;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $d4: Result:= #$00c8;  // LATIN CAPITAL LETTER E WITH GRAVE
    $d6: Result:= #$00cd;  // LATIN CAPITAL LETTER I WITH ACUTE
    $d7: Result:= #$00ce;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $d8: Result:= #$00cf;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$00a6;  // BROKEN BAR
    $de: Result:= #$00cc;  // LATIN CAPITAL LETTER I WITH GRAVE
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$00d3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e2: Result:= #$00d4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $e3: Result:= #$00d2;  // LATIN CAPITAL LETTER O WITH GRAVE
    $e4: Result:= #$00f5;  // LATIN SMALL LETTER O WITH TILDE
    $e5: Result:= #$00d5;  // LATIN CAPITAL LETTER O WITH TILDE
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e8: Result:= #$00d7;  // MULTIPLICATION SIGN
    $e9: Result:= #$00da;  // LATIN CAPITAL LETTER U WITH ACUTE
    $ea: Result:= #$00db;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $eb: Result:= #$00d9;  // LATIN CAPITAL LETTER U WITH GRAVE
    $ed: Result:= #$00ff;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $ee: Result:= #$00af;  // MACRON
    $ef: Result:= #$00b4;  // ACUTE ACCENT
    $f0: Result:= #$00ad;  // SOFT HYPHEN
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f3: Result:= #$00be;  // VULGAR FRACTION THREE QUARTERS
    $f4: Result:= #$00b6;  // PILCROW SIGN
    $f5: Result:= #$00a7;  // SECTION SIGN
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$00b8;  // CEDILLA
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$00a8;  // DIAERESIS
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$00b9;  // SUPERSCRIPT ONE
    $fc: Result:= #$00b3;  // SUPERSCRIPT THREE
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp857_DOSTurkish sequence of code point %d',[W]);
  end;
end;

function cp860ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$19,$1b,$1d..$7e: Result:= WideChar(W);
    $1a: Result:= #$001c;
    $1c: Result:= #$007f;
    $7f: Result:= #$001a;
    $80: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00e3;  // LATIN SMALL LETTER A WITH TILDE
    $85: Result:= #$00e0;  // LATIN SMALL LETTER A WITH GRAVE
    $86: Result:= #$00c1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $87: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $88: Result:= #$00ea;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $89: Result:= #$00ca;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $8a: Result:= #$00e8;  // LATIN SMALL LETTER E WITH GRAVE
    $8b: Result:= #$00cd;  // LATIN CAPITAL LETTER I WITH ACUTE
    $8c: Result:= #$00d4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $8d: Result:= #$00ec;  // LATIN SMALL LETTER I WITH GRAVE
    $8e: Result:= #$00c3;  // LATIN CAPITAL LETTER A WITH TILDE
    $8f: Result:= #$00c2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$00c0;  // LATIN CAPITAL LETTER A WITH GRAVE
    $92: Result:= #$00c8;  // LATIN CAPITAL LETTER E WITH GRAVE
    $93: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $94: Result:= #$00f5;  // LATIN SMALL LETTER O WITH TILDE
    $95: Result:= #$00f2;  // LATIN SMALL LETTER O WITH GRAVE
    $96: Result:= #$00da;  // LATIN CAPITAL LETTER U WITH ACUTE
    $97: Result:= #$00f9;  // LATIN SMALL LETTER U WITH GRAVE
    $98: Result:= #$00cc;  // LATIN CAPITAL LETTER I WITH GRAVE
    $99: Result:= #$00d5;  // LATIN CAPITAL LETTER O WITH TILDE
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$00a2;  // CENT SIGN
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00d9;  // LATIN CAPITAL LETTER U WITH GRAVE
    $9e: Result:= #$20a7;  // PESETA SIGN
    $9f: Result:= #$00d3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $a0: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $a1: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$00f1;  // LATIN SMALL LETTER N WITH TILDE
    $a5: Result:= #$00d1;  // LATIN CAPITAL LETTER N WITH TILDE
    $a6: Result:= #$00aa;  // FEMININE ORDINAL INDICATOR
    $a7: Result:= #$00ba;  // MASCULINE ORDINAL INDICATOR
    $a8: Result:= #$00bf;  // INVERTED QUESTION MARK
    $a9: Result:= #$00d2;  // LATIN CAPITAL LETTER O WITH GRAVE
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$00a1;  // INVERTED EXCLAMATION MARK
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b6: Result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b7: Result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $b8: Result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $be: Result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $c7: Result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $d0: Result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $d1: Result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $d2: Result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $d3: Result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $d4: Result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $d5: Result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $d6: Result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $d7: Result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $d8: Result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$258c;  // LEFT HALF BLOCK
    $de: Result:= #$2590;  // RIGHT HALF BLOCK
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$03b1;  // GREEK SMALL LETTER ALPHA
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e2: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $e3: Result:= #$03c0;  // GREEK SMALL LETTER PI
    $e4: Result:= #$03a3;  // GREEK CAPITAL LETTER SIGMA
    $e5: Result:= #$03c3;  // GREEK SMALL LETTER SIGMA
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e7: Result:= #$03c4;  // GREEK SMALL LETTER TAU
    $e8: Result:= #$03a6;  // GREEK CAPITAL LETTER PHI
    $e9: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $ea: Result:= #$03a9;  // GREEK CAPITAL LETTER OMEGA
    $eb: Result:= #$03b4;  // GREEK SMALL LETTER DELTA
    $ec: Result:= #$221e;  // INFINITY
    $ed: Result:= #$03c6;  // GREEK SMALL LETTER PHI
    $ee: Result:= #$03b5;  // GREEK SMALL LETTER EPSILON
    $ef: Result:= #$2229;  // INTERSECTION
    $f0: Result:= #$2261;  // IDENTICAL TO
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $f3: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $f4: Result:= #$2320;  // TOP HALF INTEGRAL
    $f5: Result:= #$2321;  // BOTTOM HALF INTEGRAL
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$2248;  // ALMOST EQUAL TO
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$2219;  // BULLET OPERATOR
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$221a;  // SQUARE ROOT
    $fc: Result:= #$207f;  // SUPERSCRIPT LATIN SMALL LETTER N
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp860 sequence of code point %d',[W]);
  end;
end;

function cp860_DOSPortugueseToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$7f: Result:= WideChar(W);
    $80: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00e3;  // LATIN SMALL LETTER A WITH TILDE
    $85: Result:= #$00e0;  // LATIN SMALL LETTER A WITH GRAVE
    $86: Result:= #$00c1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $87: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $88: Result:= #$00ea;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $89: Result:= #$00ca;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $8a: Result:= #$00e8;  // LATIN SMALL LETTER E WITH GRAVE
    $8b: Result:= #$00cd;  // LATIN CAPITAL LETTER I WITH ACUTE
    $8c: Result:= #$00d4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $8d: Result:= #$00ec;  // LATIN SMALL LETTER I WITH GRAVE
    $8e: Result:= #$00c3;  // LATIN CAPITAL LETTER A WITH TILDE
    $8f: Result:= #$00c2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$00c0;  // LATIN CAPITAL LETTER A WITH GRAVE
    $92: Result:= #$00c8;  // LATIN CAPITAL LETTER E WITH GRAVE
    $93: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $94: Result:= #$00f5;  // LATIN SMALL LETTER O WITH TILDE
    $95: Result:= #$00f2;  // LATIN SMALL LETTER O WITH GRAVE
    $96: Result:= #$00da;  // LATIN CAPITAL LETTER U WITH ACUTE
    $97: Result:= #$00f9;  // LATIN SMALL LETTER U WITH GRAVE
    $98: Result:= #$00cc;  // LATIN CAPITAL LETTER I WITH GRAVE
    $99: Result:= #$00d5;  // LATIN CAPITAL LETTER O WITH TILDE
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$00a2;  // CENT SIGN
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00d9;  // LATIN CAPITAL LETTER U WITH GRAVE
    $9e: Result:= #$20a7;  // PESETA SIGN
    $9f: Result:= #$00d3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $a0: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $a1: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$00f1;  // LATIN SMALL LETTER N WITH TILDE
    $a5: Result:= #$00d1;  // LATIN CAPITAL LETTER N WITH TILDE
    $a6: Result:= #$00aa;  // FEMININE ORDINAL INDICATOR
    $a7: Result:= #$00ba;  // MASCULINE ORDINAL INDICATOR
    $a8: Result:= #$00bf;  // INVERTED QUESTION MARK
    $a9: Result:= #$00d2;  // LATIN CAPITAL LETTER O WITH GRAVE
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$00a1;  // INVERTED EXCLAMATION MARK
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b6: Result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b7: Result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $b8: Result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $be: Result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $c7: Result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $d0: Result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $d1: Result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $d2: Result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $d3: Result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $d4: Result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $d5: Result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $d6: Result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $d7: Result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $d8: Result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$258c;  // LEFT HALF BLOCK
    $de: Result:= #$2590;  // RIGHT HALF BLOCK
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$03b1;  // GREEK SMALL LETTER ALPHA
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e2: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $e3: Result:= #$03c0;  // GREEK SMALL LETTER PI
    $e4: Result:= #$03a3;  // GREEK CAPITAL LETTER SIGMA
    $e5: Result:= #$03c3;  // GREEK SMALL LETTER SIGMA
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e7: Result:= #$03c4;  // GREEK SMALL LETTER TAU
    $e8: Result:= #$03a6;  // GREEK CAPITAL LETTER PHI
    $e9: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $ea: Result:= #$03a9;  // GREEK CAPITAL LETTER OMEGA
    $eb: Result:= #$03b4;  // GREEK SMALL LETTER DELTA
    $ec: Result:= #$221e;  // INFINITY
    $ed: Result:= #$03c6;  // GREEK SMALL LETTER PHI
    $ee: Result:= #$03b5;  // GREEK SMALL LETTER EPSILON
    $ef: Result:= #$2229;  // INTERSECTION
    $f0: Result:= #$2261;  // IDENTICAL TO
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $f3: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $f4: Result:= #$2320;  // TOP HALF INTEGRAL
    $f5: Result:= #$2321;  // BOTTOM HALF INTEGRAL
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$2248;  // ALMOST EQUAL TO
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$2219;  // BULLET OPERATOR
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$221a;  // SQUARE ROOT
    $fc: Result:= #$207f;  // SUPERSCRIPT LATIN SMALL LETTER N
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp860_DOSPortuguese sequence of code point %d',[W]);
  end;
end;

function cp861ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$19,$1b,$1d..$7e: Result:= WideChar(W);
    $1a: Result:= #$001c;
    $1c: Result:= #$007f;
    $7f: Result:= #$001a;
    $80: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $85: Result:= #$00e0;  // LATIN SMALL LETTER A WITH GRAVE
    $86: Result:= #$00e5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $87: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $88: Result:= #$00ea;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $89: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $8a: Result:= #$00e8;  // LATIN SMALL LETTER E WITH GRAVE
    $8b: Result:= #$00d0;  // LATIN CAPITAL LETTER ETH
    $8c: Result:= #$00f0;  // LATIN SMALL LETTER ETH
    $8d: Result:= #$00de;  // LATIN CAPITAL LETTER THORN
    $8e: Result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $8f: Result:= #$00c5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$00e6;  // LATIN SMALL LIGATURE AE
    $92: Result:= #$00c6;  // LATIN CAPITAL LIGATURE AE
    $93: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $94: Result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $95: Result:= #$00fe;  // LATIN SMALL LETTER THORN
    $96: Result:= #$00fb;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $97: Result:= #$00dd;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $98: Result:= #$00fd;  // LATIN SMALL LETTER Y WITH ACUTE
    $99: Result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$00f8;  // LATIN SMALL LETTER O WITH STROKE
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00d8;  // LATIN CAPITAL LETTER O WITH STROKE
    $9e: Result:= #$20a7;  // PESETA SIGN
    $9f: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $a0: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $a1: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$00c1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $a5: Result:= #$00cd;  // LATIN CAPITAL LETTER I WITH ACUTE
    $a6: Result:= #$00d3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $a7: Result:= #$00da;  // LATIN CAPITAL LETTER U WITH ACUTE
    $a8: Result:= #$00bf;  // INVERTED QUESTION MARK
    $a9: Result:= #$2310;  // REVERSED NOT SIGN
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$00a1;  // INVERTED EXCLAMATION MARK
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b6: Result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b7: Result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $b8: Result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $be: Result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $c7: Result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $d0: Result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $d1: Result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $d2: Result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $d3: Result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $d4: Result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $d5: Result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $d6: Result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $d7: Result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $d8: Result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$258c;  // LEFT HALF BLOCK
    $de: Result:= #$2590;  // RIGHT HALF BLOCK
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$03b1;  // GREEK SMALL LETTER ALPHA
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e2: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $e3: Result:= #$03c0;  // GREEK SMALL LETTER PI
    $e4: Result:= #$03a3;  // GREEK CAPITAL LETTER SIGMA
    $e5: Result:= #$03c3;  // GREEK SMALL LETTER SIGMA
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e7: Result:= #$03c4;  // GREEK SMALL LETTER TAU
    $e8: Result:= #$03a6;  // GREEK CAPITAL LETTER PHI
    $e9: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $ea: Result:= #$03a9;  // GREEK CAPITAL LETTER OMEGA
    $eb: Result:= #$03b4;  // GREEK SMALL LETTER DELTA
    $ec: Result:= #$221e;  // INFINITY
    $ed: Result:= #$03c6;  // GREEK SMALL LETTER PHI
    $ee: Result:= #$03b5;  // GREEK SMALL LETTER EPSILON
    $ef: Result:= #$2229;  // INTERSECTION
    $f0: Result:= #$2261;  // IDENTICAL TO
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $f3: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $f4: Result:= #$2320;  // TOP HALF INTEGRAL
    $f5: Result:= #$2321;  // BOTTOM HALF INTEGRAL
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$2248;  // ALMOST EQUAL TO
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$2219;  // BULLET OPERATOR
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$221a;  // SQUARE ROOT
    $fc: Result:= #$207f;  // SUPERSCRIPT LATIN SMALL LETTER N
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp861 sequence of code point %d',[W]);
  end;
end;

function cp861_DOSIcelandicToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$7f: Result:= WideChar(W);
    $80: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $85: Result:= #$00e0;  // LATIN SMALL LETTER A WITH GRAVE
    $86: Result:= #$00e5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $87: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $88: Result:= #$00ea;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $89: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $8a: Result:= #$00e8;  // LATIN SMALL LETTER E WITH GRAVE
    $8b: Result:= #$00d0;  // LATIN CAPITAL LETTER ETH
    $8c: Result:= #$00f0;  // LATIN SMALL LETTER ETH
    $8d: Result:= #$00de;  // LATIN CAPITAL LETTER THORN
    $8e: Result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $8f: Result:= #$00c5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$00e6;  // LATIN SMALL LIGATURE AE
    $92: Result:= #$00c6;  // LATIN CAPITAL LIGATURE AE
    $93: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $94: Result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $95: Result:= #$00fe;  // LATIN SMALL LETTER THORN
    $96: Result:= #$00fb;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $97: Result:= #$00dd;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $98: Result:= #$00fd;  // LATIN SMALL LETTER Y WITH ACUTE
    $99: Result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$00f8;  // LATIN SMALL LETTER O WITH STROKE
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00d8;  // LATIN CAPITAL LETTER O WITH STROKE
    $9e: Result:= #$20a7;  // PESETA SIGN
    $9f: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $a0: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $a1: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$00c1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $a5: Result:= #$00cd;  // LATIN CAPITAL LETTER I WITH ACUTE
    $a6: Result:= #$00d3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $a7: Result:= #$00da;  // LATIN CAPITAL LETTER U WITH ACUTE
    $a8: Result:= #$00bf;  // INVERTED QUESTION MARK
    $a9: Result:= #$2310;  // REVERSED NOT SIGN
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$00a1;  // INVERTED EXCLAMATION MARK
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b6: Result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b7: Result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $b8: Result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $be: Result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $c7: Result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $d0: Result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $d1: Result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $d2: Result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $d3: Result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $d4: Result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $d5: Result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $d6: Result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $d7: Result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $d8: Result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$258c;  // LEFT HALF BLOCK
    $de: Result:= #$2590;  // RIGHT HALF BLOCK
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$03b1;  // GREEK SMALL LETTER ALPHA
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e2: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $e3: Result:= #$03c0;  // GREEK SMALL LETTER PI
    $e4: Result:= #$03a3;  // GREEK CAPITAL LETTER SIGMA
    $e5: Result:= #$03c3;  // GREEK SMALL LETTER SIGMA
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e7: Result:= #$03c4;  // GREEK SMALL LETTER TAU
    $e8: Result:= #$03a6;  // GREEK CAPITAL LETTER PHI
    $e9: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $ea: Result:= #$03a9;  // GREEK CAPITAL LETTER OMEGA
    $eb: Result:= #$03b4;  // GREEK SMALL LETTER DELTA
    $ec: Result:= #$221e;  // INFINITY
    $ed: Result:= #$03c6;  // GREEK SMALL LETTER PHI
    $ee: Result:= #$03b5;  // GREEK SMALL LETTER EPSILON
    $ef: Result:= #$2229;  // INTERSECTION
    $f0: Result:= #$2261;  // IDENTICAL TO
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $f3: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $f4: Result:= #$2320;  // TOP HALF INTEGRAL
    $f5: Result:= #$2321;  // BOTTOM HALF INTEGRAL
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$2248;  // ALMOST EQUAL TO
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$2219;  // BULLET OPERATOR
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$221a;  // SQUARE ROOT
    $fc: Result:= #$207f;  // SUPERSCRIPT LATIN SMALL LETTER N
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp861_DOSIcelandic sequence of code point %d',[W]);
  end;
end;

function cp862ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$19,$1b,$1d..$7e: Result:= WideChar(W);
    $1a: Result:= #$001c;
    $1c: Result:= #$007f;
    $7f: Result:= #$001a;
    $80: Result:= #$05d0;  // HEBREW LETTER ALEF
    $81: Result:= #$05d1;  // HEBREW LETTER BET
    $82: Result:= #$05d2;  // HEBREW LETTER GIMEL
    $83: Result:= #$05d3;  // HEBREW LETTER DALET
    $84: Result:= #$05d4;  // HEBREW LETTER HE
    $85: Result:= #$05d5;  // HEBREW LETTER VAV
    $86: Result:= #$05d6;  // HEBREW LETTER ZAYIN
    $87: Result:= #$05d7;  // HEBREW LETTER HET
    $88: Result:= #$05d8;  // HEBREW LETTER TET
    $89: Result:= #$05d9;  // HEBREW LETTER YOD
    $8a: Result:= #$05da;  // HEBREW LETTER FINAL KAF
    $8b: Result:= #$05db;  // HEBREW LETTER KAF
    $8c: Result:= #$05dc;  // HEBREW LETTER LAMED
    $8d: Result:= #$05dd;  // HEBREW LETTER FINAL MEM
    $8e: Result:= #$05de;  // HEBREW LETTER MEM
    $8f: Result:= #$05df;  // HEBREW LETTER FINAL NUN
    $90: Result:= #$05e0;  // HEBREW LETTER NUN
    $91: Result:= #$05e1;  // HEBREW LETTER SAMEKH
    $92: Result:= #$05e2;  // HEBREW LETTER AYIN
    $93: Result:= #$05e3;  // HEBREW LETTER FINAL PE
    $94: Result:= #$05e4;  // HEBREW LETTER PE
    $95: Result:= #$05e5;  // HEBREW LETTER FINAL TSADI
    $96: Result:= #$05e6;  // HEBREW LETTER TSADI
    $97: Result:= #$05e7;  // HEBREW LETTER QOF
    $98: Result:= #$05e8;  // HEBREW LETTER RESH
    $99: Result:= #$05e9;  // HEBREW LETTER SHIN
    $9a: Result:= #$05ea;  // HEBREW LETTER TAV
    $9b: Result:= #$00a2;  // CENT SIGN
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00a5;  // YEN SIGN
    $9e: Result:= #$20a7;  // PESETA SIGN
    $9f: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $a0: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $a1: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$00f1;  // LATIN SMALL LETTER N WITH TILDE
    $a5: Result:= #$00d1;  // LATIN CAPITAL LETTER N WITH TILDE
    $a6: Result:= #$00aa;  // FEMININE ORDINAL INDICATOR
    $a7: Result:= #$00ba;  // MASCULINE ORDINAL INDICATOR
    $a8: Result:= #$00bf;  // INVERTED QUESTION MARK
    $a9: Result:= #$2310;  // REVERSED NOT SIGN
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$00a1;  // INVERTED EXCLAMATION MARK
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b6: Result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b7: Result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $b8: Result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $be: Result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $c7: Result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $d0: Result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $d1: Result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $d2: Result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $d3: Result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $d4: Result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $d5: Result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $d6: Result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $d7: Result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $d8: Result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$258c;  // LEFT HALF BLOCK
    $de: Result:= #$2590;  // RIGHT HALF BLOCK
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$03b1;  // GREEK SMALL LETTER ALPHA
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S (GERMAN)
    $e2: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $e3: Result:= #$03c0;  // GREEK SMALL LETTER PI
    $e4: Result:= #$03a3;  // GREEK CAPITAL LETTER SIGMA
    $e5: Result:= #$03c3;  // GREEK SMALL LETTER SIGMA
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e7: Result:= #$03c4;  // GREEK SMALL LETTER TAU
    $e8: Result:= #$03a6;  // GREEK CAPITAL LETTER PHI
    $e9: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $ea: Result:= #$03a9;  // GREEK CAPITAL LETTER OMEGA
    $eb: Result:= #$03b4;  // GREEK SMALL LETTER DELTA
    $ec: Result:= #$221e;  // INFINITY
    $ed: Result:= #$03c6;  // GREEK SMALL LETTER PHI
    $ee: Result:= #$03b5;  // GREEK SMALL LETTER EPSILON
    $ef: Result:= #$2229;  // INTERSECTION
    $f0: Result:= #$2261;  // IDENTICAL TO
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $f3: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $f4: Result:= #$2320;  // TOP HALF INTEGRAL
    $f5: Result:= #$2321;  // BOTTOM HALF INTEGRAL
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$2248;  // ALMOST EQUAL TO
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$2219;  // BULLET OPERATOR
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$221a;  // SQUARE ROOT
    $fc: Result:= #$207f;  // SUPERSCRIPT LATIN SMALL LETTER N
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp862 sequence of code point %d',[W]);
  end;
end;

function cp862_DOSHebrewToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$7f: Result:= WideChar(W);
    $80: Result:= #$05d0;  // HEBREW LETTER ALEF
    $81: Result:= #$05d1;  // HEBREW LETTER BET
    $82: Result:= #$05d2;  // HEBREW LETTER GIMEL
    $83: Result:= #$05d3;  // HEBREW LETTER DALET
    $84: Result:= #$05d4;  // HEBREW LETTER HE
    $85: Result:= #$05d5;  // HEBREW LETTER VAV
    $86: Result:= #$05d6;  // HEBREW LETTER ZAYIN
    $87: Result:= #$05d7;  // HEBREW LETTER HET
    $88: Result:= #$05d8;  // HEBREW LETTER TET
    $89: Result:= #$05d9;  // HEBREW LETTER YOD
    $8a: Result:= #$05da;  // HEBREW LETTER FINAL KAF
    $8b: Result:= #$05db;  // HEBREW LETTER KAF
    $8c: Result:= #$05dc;  // HEBREW LETTER LAMED
    $8d: Result:= #$05dd;  // HEBREW LETTER FINAL MEM
    $8e: Result:= #$05de;  // HEBREW LETTER MEM
    $8f: Result:= #$05df;  // HEBREW LETTER FINAL NUN
    $90: Result:= #$05e0;  // HEBREW LETTER NUN
    $91: Result:= #$05e1;  // HEBREW LETTER SAMEKH
    $92: Result:= #$05e2;  // HEBREW LETTER AYIN
    $93: Result:= #$05e3;  // HEBREW LETTER FINAL PE
    $94: Result:= #$05e4;  // HEBREW LETTER PE
    $95: Result:= #$05e5;  // HEBREW LETTER FINAL TSADI
    $96: Result:= #$05e6;  // HEBREW LETTER TSADI
    $97: Result:= #$05e7;  // HEBREW LETTER QOF
    $98: Result:= #$05e8;  // HEBREW LETTER RESH
    $99: Result:= #$05e9;  // HEBREW LETTER SHIN
    $9a: Result:= #$05ea;  // HEBREW LETTER TAV
    $9b: Result:= #$00a2;  // CENT SIGN
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00a5;  // YEN SIGN
    $9e: Result:= #$20a7;  // PESETA SIGN
    $9f: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $a0: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $a1: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$00f1;  // LATIN SMALL LETTER N WITH TILDE
    $a5: Result:= #$00d1;  // LATIN CAPITAL LETTER N WITH TILDE
    $a6: Result:= #$00aa;  // FEMININE ORDINAL INDICATOR
    $a7: Result:= #$00ba;  // MASCULINE ORDINAL INDICATOR
    $a8: Result:= #$00bf;  // INVERTED QUESTION MARK
    $a9: Result:= #$2310;  // REVERSED NOT SIGN
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$00a1;  // INVERTED EXCLAMATION MARK
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b6: Result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b7: Result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $b8: Result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $be: Result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $c7: Result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $d0: Result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $d1: Result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $d2: Result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $d3: Result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $d4: Result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $d5: Result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $d6: Result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $d7: Result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $d8: Result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$258c;  // LEFT HALF BLOCK
    $de: Result:= #$2590;  // RIGHT HALF BLOCK
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$03b1;  // GREEK SMALL LETTER ALPHA
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S (GERMAN)
    $e2: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $e3: Result:= #$03c0;  // GREEK SMALL LETTER PI
    $e4: Result:= #$03a3;  // GREEK CAPITAL LETTER SIGMA
    $e5: Result:= #$03c3;  // GREEK SMALL LETTER SIGMA
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e7: Result:= #$03c4;  // GREEK SMALL LETTER TAU
    $e8: Result:= #$03a6;  // GREEK CAPITAL LETTER PHI
    $e9: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $ea: Result:= #$03a9;  // GREEK CAPITAL LETTER OMEGA
    $eb: Result:= #$03b4;  // GREEK SMALL LETTER DELTA
    $ec: Result:= #$221e;  // INFINITY
    $ed: Result:= #$03c6;  // GREEK SMALL LETTER PHI
    $ee: Result:= #$03b5;  // GREEK SMALL LETTER EPSILON
    $ef: Result:= #$2229;  // INTERSECTION
    $f0: Result:= #$2261;  // IDENTICAL TO
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $f3: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $f4: Result:= #$2320;  // TOP HALF INTEGRAL
    $f5: Result:= #$2321;  // BOTTOM HALF INTEGRAL
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$2248;  // ALMOST EQUAL TO
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$2219;  // BULLET OPERATOR
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$221a;  // SQUARE ROOT
    $fc: Result:= #$207f;  // SUPERSCRIPT LATIN SMALL LETTER N
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp862_DOSHebrew sequence of code point %d',[W]);
  end;
end;

function cp863ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$19,$1b,$1d..$7e: Result:= WideChar(W);
    $1a: Result:= #$001c;
    $1c: Result:= #$007f;
    $7f: Result:= #$001a;
    $80: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00c2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $85: Result:= #$00e0;  // LATIN SMALL LETTER A WITH GRAVE
    $86: Result:= #$00b6;  // PILCROW SIGN
    $87: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $88: Result:= #$00ea;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $89: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $8a: Result:= #$00e8;  // LATIN SMALL LETTER E WITH GRAVE
    $8b: Result:= #$00ef;  // LATIN SMALL LETTER I WITH DIAERESIS
    $8c: Result:= #$00ee;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $8d: Result:= #$2017;  // DOUBLE LOW LINE
    $8e: Result:= #$00c0;  // LATIN CAPITAL LETTER A WITH GRAVE
    $8f: Result:= #$00a7;  // SECTION SIGN
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$00c8;  // LATIN CAPITAL LETTER E WITH GRAVE
    $92: Result:= #$00ca;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $93: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $94: Result:= #$00cb;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $95: Result:= #$00cf;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $96: Result:= #$00fb;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $97: Result:= #$00f9;  // LATIN SMALL LETTER U WITH GRAVE
    $98: Result:= #$00a4;  // CURRENCY SIGN
    $99: Result:= #$00d4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$00a2;  // CENT SIGN
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00d9;  // LATIN CAPITAL LETTER U WITH GRAVE
    $9e: Result:= #$00db;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $9f: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $a0: Result:= #$00a6;  // BROKEN BAR
    $a1: Result:= #$00b4;  // ACUTE ACCENT
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$00a8;  // DIAERESIS
    $a5: Result:= #$00b8;  // CEDILLA
    $a6: Result:= #$00b3;  // SUPERSCRIPT THREE
    $a7: Result:= #$00af;  // MACRON
    $a8: Result:= #$00ce;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $a9: Result:= #$2310;  // REVERSED NOT SIGN
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$00be;  // VULGAR FRACTION THREE QUARTERS
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b6: Result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b7: Result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $b8: Result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $be: Result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $c7: Result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $d0: Result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $d1: Result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $d2: Result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $d3: Result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $d4: Result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $d5: Result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $d6: Result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $d7: Result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $d8: Result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$258c;  // LEFT HALF BLOCK
    $de: Result:= #$2590;  // RIGHT HALF BLOCK
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$03b1;  // GREEK SMALL LETTER ALPHA
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e2: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $e3: Result:= #$03c0;  // GREEK SMALL LETTER PI
    $e4: Result:= #$03a3;  // GREEK CAPITAL LETTER SIGMA
    $e5: Result:= #$03c3;  // GREEK SMALL LETTER SIGMA
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e7: Result:= #$03c4;  // GREEK SMALL LETTER TAU
    $e8: Result:= #$03a6;  // GREEK CAPITAL LETTER PHI
    $e9: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $ea: Result:= #$03a9;  // GREEK CAPITAL LETTER OMEGA
    $eb: Result:= #$03b4;  // GREEK SMALL LETTER DELTA
    $ec: Result:= #$221e;  // INFINITY
    $ed: Result:= #$03c6;  // GREEK SMALL LETTER PHI
    $ee: Result:= #$03b5;  // GREEK SMALL LETTER EPSILON
    $ef: Result:= #$2229;  // INTERSECTION
    $f0: Result:= #$2261;  // IDENTICAL TO
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $f3: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $f4: Result:= #$2320;  // TOP HALF INTEGRAL
    $f5: Result:= #$2321;  // BOTTOM HALF INTEGRAL
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$2248;  // ALMOST EQUAL TO
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$2219;  // BULLET OPERATOR
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$221a;  // SQUARE ROOT
    $fc: Result:= #$207f;  // SUPERSCRIPT LATIN SMALL LETTER N
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp863 sequence of code point %d',[W]);
  end;
end;

function cp863_DOSCanadaFToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$7f: Result:= WideChar(W);
    $80: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00c2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $85: Result:= #$00e0;  // LATIN SMALL LETTER A WITH GRAVE
    $86: Result:= #$00b6;  // PILCROW SIGN
    $87: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $88: Result:= #$00ea;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $89: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $8a: Result:= #$00e8;  // LATIN SMALL LETTER E WITH GRAVE
    $8b: Result:= #$00ef;  // LATIN SMALL LETTER I WITH DIAERESIS
    $8c: Result:= #$00ee;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $8d: Result:= #$2017;  // DOUBLE LOW LINE
    $8e: Result:= #$00c0;  // LATIN CAPITAL LETTER A WITH GRAVE
    $8f: Result:= #$00a7;  // SECTION SIGN
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$00c8;  // LATIN CAPITAL LETTER E WITH GRAVE
    $92: Result:= #$00ca;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $93: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $94: Result:= #$00cb;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $95: Result:= #$00cf;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $96: Result:= #$00fb;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $97: Result:= #$00f9;  // LATIN SMALL LETTER U WITH GRAVE
    $98: Result:= #$00a4;  // CURRENCY SIGN
    $99: Result:= #$00d4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$00a2;  // CENT SIGN
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00d9;  // LATIN CAPITAL LETTER U WITH GRAVE
    $9e: Result:= #$00db;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $9f: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $a0: Result:= #$00a6;  // BROKEN BAR
    $a1: Result:= #$00b4;  // ACUTE ACCENT
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$00a8;  // DIAERESIS
    $a5: Result:= #$00b8;  // CEDILLA
    $a6: Result:= #$00b3;  // SUPERSCRIPT THREE
    $a7: Result:= #$00af;  // MACRON
    $a8: Result:= #$00ce;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $a9: Result:= #$2310;  // REVERSED NOT SIGN
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$00be;  // VULGAR FRACTION THREE QUARTERS
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b6: Result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b7: Result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $b8: Result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $be: Result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $c7: Result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $d0: Result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $d1: Result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $d2: Result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $d3: Result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $d4: Result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $d5: Result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $d6: Result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $d7: Result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $d8: Result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$258c;  // LEFT HALF BLOCK
    $de: Result:= #$2590;  // RIGHT HALF BLOCK
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$03b1;  // GREEK SMALL LETTER ALPHA
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e2: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $e3: Result:= #$03c0;  // GREEK SMALL LETTER PI
    $e4: Result:= #$03a3;  // GREEK CAPITAL LETTER SIGMA
    $e5: Result:= #$03c3;  // GREEK SMALL LETTER SIGMA
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e7: Result:= #$03c4;  // GREEK SMALL LETTER TAU
    $e8: Result:= #$03a6;  // GREEK CAPITAL LETTER PHI
    $e9: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $ea: Result:= #$03a9;  // GREEK CAPITAL LETTER OMEGA
    $eb: Result:= #$03b4;  // GREEK SMALL LETTER DELTA
    $ec: Result:= #$221e;  // INFINITY
    $ed: Result:= #$03c6;  // GREEK SMALL LETTER PHI
    $ee: Result:= #$03b5;  // GREEK SMALL LETTER EPSILON
    $ef: Result:= #$2229;  // INTERSECTION
    $f0: Result:= #$2261;  // IDENTICAL TO
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $f3: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $f4: Result:= #$2320;  // TOP HALF INTEGRAL
    $f5: Result:= #$2321;  // BOTTOM HALF INTEGRAL
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$2248;  // ALMOST EQUAL TO
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$2219;  // BULLET OPERATOR
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$221a;  // SQUARE ROOT
    $fc: Result:= #$207f;  // SUPERSCRIPT LATIN SMALL LETTER N
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp863_DOSCanadaF sequence of code point %d',[W]);
  end;
end;

function cp864ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$19,$1b,$1d..$24,$26..$7e,$a0,$a3..$a4:
      Result:= WideChar(W);
    $1a: Result:= #$001c;
    $1c: Result:= #$007f;
    $7f: Result:= #$001a;
    $25: Result:= #$066a;  // ARABIC PERCENT SIGN
    $80: Result:= #$00b0;  // DEGREE SIGN
    $81: Result:= #$00b7;  // MIDDLE DOT
    $82: Result:= #$2219;  // BULLET OPERATOR
    $83: Result:= #$221a;  // SQUARE ROOT
    $84: Result:= #$2592;  // MEDIUM SHADE
    $85: Result:= #$2500;  // FORMS LIGHT HORIZONTAL
    $86: Result:= #$2502;  // FORMS LIGHT VERTICAL
    $87: Result:= #$253c;  // FORMS LIGHT VERTICAL AND HORIZONTAL
    $88: Result:= #$2524;  // FORMS LIGHT VERTICAL AND LEFT
    $89: Result:= #$252c;  // FORMS LIGHT DOWN AND HORIZONTAL
    $8a: Result:= #$251c;  // FORMS LIGHT VERTICAL AND RIGHT
    $8b: Result:= #$2534;  // FORMS LIGHT UP AND HORIZONTAL
    $8c: Result:= #$2510;  // FORMS LIGHT DOWN AND LEFT
    $8d: Result:= #$250c;  // FORMS LIGHT DOWN AND RIGHT
    $8e: Result:= #$2514;  // FORMS LIGHT UP AND RIGHT
    $8f: Result:= #$2518;  // FORMS LIGHT UP AND LEFT
    $90: Result:= #$03b2;  // GREEK SMALL BETA
    $91: Result:= #$221e;  // INFINITY
    $92: Result:= #$03c6;  // GREEK SMALL PHI
    $93: Result:= #$00b1;  // PLUS-OR-MINUS SIGN
    $94: Result:= #$00bd;  // FRACTION 1/2
    $95: Result:= #$00bc;  // FRACTION 1/4
    $96: Result:= #$2248;  // ALMOST EQUAL TO
    $97: Result:= #$00ab;  // LEFT POINTING GUILLEMET
    $98: Result:= #$00bb;  // RIGHT POINTING GUILLEMET
    $99: Result:= #$fef7;  // ARABIC LIGATURE LAM WITH ALEF WITH HAMZA ABOVE ISOLATED FORM
    $9a: Result:= #$fef8;  // ARABIC LIGATURE LAM WITH ALEF WITH HAMZA ABOVE FINAL FORM
    $9d: Result:= #$fefb;  // ARABIC LIGATURE LAM WITH ALEF ISOLATED FORM
    $9e: Result:= #$fefc;  // ARABIC LIGATURE LAM WITH ALEF FINAL FORM
    $9f: Result:= #$200c;  // ZERO WIDTH NON-JOINER
    $a1: Result:= #$00ad;  // SOFT HYPHEN
    $a2: Result:= #$fe82;  // ARABIC LETTER ALEF WITH MADDA ABOVE FINAL FORM
    $a5: Result:= #$fe84;  // ARABIC LETTER ALEF WITH HAMZA ABOVE FINAL FORM
    $a8: Result:= #$fe8e;  // ARABIC LETTER ALEF FINAL FORM
    $a9: Result:= #$fe8f;  // ARABIC LETTER BEH ISOLATED FORM
    $aa: Result:= #$fe95;  // ARABIC LETTER TEH ISOLATED FORM
    $ab: Result:= #$fe99;  // ARABIC LETTER THEH ISOLATED FORM
    $ac: Result:= #$060c;  // ARABIC COMMA
    $ad: Result:= #$fe9d;  // ARABIC LETTER JEEM ISOLATED FORM
    $ae: Result:= #$fea1;  // ARABIC LETTER HAH ISOLATED FORM
    $af: Result:= #$fea5;  // ARABIC LETTER KHAH ISOLATED FORM
    $b0: Result:= #$0660;  // ARABIC-INDIC DIGIT ZERO
    $b1: Result:= #$0661;  // ARABIC-INDIC DIGIT ONE
    $b2: Result:= #$0662;  // ARABIC-INDIC DIGIT TWO
    $b3: Result:= #$0663;  // ARABIC-INDIC DIGIT THREE
    $b4: Result:= #$0664;  // ARABIC-INDIC DIGIT FOUR
    $b5: Result:= #$0665;  // ARABIC-INDIC DIGIT FIVE
    $b6: Result:= #$0666;  // ARABIC-INDIC DIGIT SIX
    $b7: Result:= #$0667;  // ARABIC-INDIC DIGIT SEVEN
    $b8: Result:= #$0668;  // ARABIC-INDIC DIGIT EIGHT
    $b9: Result:= #$0669;  // ARABIC-INDIC DIGIT NINE
    $ba: Result:= #$fed1;  // ARABIC LETTER FEH ISOLATED FORM
    $bb: Result:= #$061b;  // ARABIC SEMICOLON
    $bc: Result:= #$feb1;  // ARABIC LETTER SEEN ISOLATED FORM
    $bd: Result:= #$feb5;  // ARABIC LETTER SHEEN ISOLATED FORM
    $be: Result:= #$feb9;  // ARABIC LETTER SAD ISOLATED FORM
    $bf: Result:= #$061f;  // ARABIC QUESTION MARK
    $c0: Result:= #$00a2;  // CENT SIGN
    $c1: Result:= #$fe80;  // ARABIC LETTER HAMZA ISOLATED FORM
    $c2: Result:= #$fe81;  // ARABIC LETTER ALEF WITH MADDA ABOVE ISOLATED FORM
    $c3: Result:= #$fe83;  // ARABIC LETTER ALEF WITH HAMZA ABOVE ISOLATED FORM
    $c4: Result:= #$fe85;  // ARABIC LETTER WAW WITH HAMZA ABOVE ISOLATED FORM
    $c5: Result:= #$feca;  // ARABIC LETTER AIN FINAL FORM
    $c6: Result:= #$fe8b;  // ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM
    $c7: Result:= #$fe8d;  // ARABIC LETTER ALEF ISOLATED FORM
    $c8: Result:= #$fe91;  // ARABIC LETTER BEH INITIAL FORM
    $c9: Result:= #$fe93;  // ARABIC LETTER TEH MARBUTA ISOLATED FORM
    $ca: Result:= #$fe97;  // ARABIC LETTER TEH INITIAL FORM
    $cb: Result:= #$fe9b;  // ARABIC LETTER THEH INITIAL FORM
    $cc: Result:= #$fe9f;  // ARABIC LETTER JEEM INITIAL FORM
    $cd: Result:= #$fea3;  // ARABIC LETTER HAH INITIAL FORM
    $ce: Result:= #$fea7;  // ARABIC LETTER KHAH INITIAL FORM
    $cf: Result:= #$fea9;  // ARABIC LETTER DAL ISOLATED FORM
    $d0: Result:= #$feab;  // ARABIC LETTER THAL ISOLATED FORM
    $d1: Result:= #$fead;  // ARABIC LETTER REH ISOLATED FORM
    $d2: Result:= #$feaf;  // ARABIC LETTER ZAIN ISOLATED FORM
    $d3: Result:= #$feb3;  // ARABIC LETTER SEEN INITIAL FORM
    $d4: Result:= #$feb7;  // ARABIC LETTER SHEEN INITIAL FORM
    $d5: Result:= #$febb;  // ARABIC LETTER SAD INITIAL FORM
    $d6: Result:= #$febf;  // ARABIC LETTER DAD INITIAL FORM
    $d7: Result:= #$fec3;  // ARABIC LETTER TAH MEDIAL FORM
    $d8: Result:= #$fec7;  // ARABIC LETTER ZAH MEDIAL FORM
    $d9: Result:= #$fecb;  // ARABIC LETTER AIN INITIAL FORM
    $da: Result:= #$fecf;  // ARABIC LETTER GHAIN INITIAL FORM
    $db: Result:= #$00a6;  // BROKEN VERTICAL BAR
    $dc: Result:= #$00ac;  // NOT SIGN
    $dd: Result:= #$00f7;  // DIVISION SIGN
    $de: Result:= #$00d7;  // MULTIPLICATION SIGN
    $df: Result:= #$fec9;  // ARABIC LETTER AIN ISOLATED FORM
    $e0: Result:= #$0640;  // ARABIC TATWEEL
    $e1: Result:= #$fed3;  // ARABIC LETTER FEH INITIAL FORM
    $e2: Result:= #$fed7;  // ARABIC LETTER QAF INITIAL FORM
    $e3: Result:= #$fedb;  // ARABIC LETTER KAF INITIAL FORM
    $e4: Result:= #$fedf;  // ARABIC LETTER LAM INITIAL FORM
    $e5: Result:= #$fee3;  // ARABIC LETTER MEEM INITIAL FORM
    $e6: Result:= #$fee7;  // ARABIC LETTER NOON INITIAL FORM
    $e7: Result:= #$feeb;  // ARABIC LETTER HEH INITIAL FORM
    $e8: Result:= #$feed;  // ARABIC LETTER WAW ISOLATED FORM
    $e9: Result:= #$feef;  // ARABIC LETTER ALEF MAKSURA ISOLATED FORM
    $ea: Result:= #$fef3;  // ARABIC LETTER YEH INITIAL FORM
    $eb: Result:= #$febd;  // ARABIC LETTER DAD ISOLATED FORM
    $ec: Result:= #$fecc;  // ARABIC LETTER AIN MEDIAL FORM
    $ed: Result:= #$fece;  // ARABIC LETTER GHAIN FINAL FORM
    $ee: Result:= #$fecd;  // ARABIC LETTER GHAIN ISOLATED FORM
    $ef: Result:= #$fee1;  // ARABIC LETTER MEEM ISOLATED FORM
    $f0: Result:= #$fe7d;  // ARABIC SHADDA MEDIAL FORM
    $f1: Result:= #$fe7c;  // ARABIC SPACING SHADDAH
    $f2: Result:= #$fee5;  // ARABIC LETTER NOON ISOLATED FORM
    $f3: Result:= #$fee9;  // ARABIC LETTER HEH ISOLATED FORM
    $f4: Result:= #$feec;  // ARABIC LETTER HEH MEDIAL FORM
    $f5: Result:= #$fef0;  // ARABIC LETTER ALEF MAKSURA FINAL FORM
    $f6: Result:= #$fef2;  // ARABIC LETTER YEH FINAL FORM
    $f7: Result:= #$fed0;  // ARABIC LETTER GHAIN MEDIAL FORM
    $f8: Result:= #$fed5;  // ARABIC LETTER QAF ISOLATED FORM
    $f9: Result:= #$fef5;  // ARABIC LIGATURE LAM WITH ALEF WITH MADDA ABOVE ISOLATED FORM
    $fa: Result:= #$fef6;  // ARABIC LIGATURE LAM WITH ALEF WITH MADDA ABOVE FINAL FORM
    $fb: Result:= #$fedd;  // ARABIC LETTER LAM ISOLATED FORM
    $fc: Result:= #$fed9;  // ARABIC LETTER KAF ISOLATED FORM
    $fd: Result:= #$fef1;  // ARABIC LETTER YEH ISOLATED FORM
    $fe: Result:= #$25a0;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp864 sequence of code point %d',[W]);
  end;
end;

function cp864_DOSArabicToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$24,$26..$7f,$9b..$9c,$9f,$a0,$a3..$a4: Result:= WideChar(W);
    $25: Result:= #$066a;  // ARABIC PERCENT SIGN
    $80: Result:= #$00b0;  // DEGREE SIGN
    $81: Result:= #$00b7;  // MIDDLE DOT
    $82: Result:= #$2219;  // BULLET OPERATOR
    $83: Result:= #$221a;  // SQUARE ROOT
    $84: Result:= #$2592;  // MEDIUM SHADE
    $85: Result:= #$2500;  // FORMS LIGHT HORIZONTAL
    $86: Result:= #$2502;  // FORMS LIGHT VERTICAL
    $87: Result:= #$253c;  // FORMS LIGHT VERTICAL AND HORIZONTAL
    $88: Result:= #$2524;  // FORMS LIGHT VERTICAL AND LEFT
    $89: Result:= #$252c;  // FORMS LIGHT DOWN AND HORIZONTAL
    $8a: Result:= #$251c;  // FORMS LIGHT VERTICAL AND RIGHT
    $8b: Result:= #$2534;  // FORMS LIGHT UP AND HORIZONTAL
    $8c: Result:= #$2510;  // FORMS LIGHT DOWN AND LEFT
    $8d: Result:= #$250c;  // FORMS LIGHT DOWN AND RIGHT
    $8e: Result:= #$2514;  // FORMS LIGHT UP AND RIGHT
    $8f: Result:= #$2518;  // FORMS LIGHT UP AND LEFT
    $90: Result:= #$03b2;  // GREEK SMALL BETA
    $91: Result:= #$221e;  // INFINITY
    $92: Result:= #$03c6;  // GREEK SMALL PHI
    $93: Result:= #$00b1;  // PLUS-OR-MINUS SIGN
    $94: Result:= #$00bd;  // FRACTION 1/2
    $95: Result:= #$00bc;  // FRACTION 1/4
    $96: Result:= #$2248;  // ALMOST EQUAL TO
    $97: Result:= #$00ab;  // LEFT POINTING GUILLEMET
    $98: Result:= #$00bb;  // RIGHT POINTING GUILLEMET
    $99: Result:= #$fef7;  // ARABIC LIGATURE LAM WITH ALEF WITH HAMZA ABOVE ISOLATED FORM
    $9a: Result:= #$fef8;  // ARABIC LIGATURE LAM WITH ALEF WITH HAMZA ABOVE FINAL FORM
    $9d: Result:= #$fefb;  // ARABIC LIGATURE LAM WITH ALEF ISOLATED FORM
    $9e: Result:= #$fefc;  // ARABIC LIGATURE LAM WITH ALEF FINAL FORM
    $a1: Result:= #$00ad;  // SOFT HYPHEN
    $a2: Result:= #$fe82;  // ARABIC LETTER ALEF WITH MADDA ABOVE FINAL FORM
    $a5: Result:= #$fe84;  // ARABIC LETTER ALEF WITH HAMZA ABOVE FINAL FORM
    $a6: Result:= #$F8BE;
    $a7: Result:= #$F8BF;
    $a8: Result:= #$fe8e;  // ARABIC LETTER ALEF FINAL FORM
    $a9: Result:= #$fe8f;  // ARABIC LETTER BEH ISOLATED FORM
    $aa: Result:= #$fe95;  // ARABIC LETTER TEH ISOLATED FORM
    $ab: Result:= #$fe99;  // ARABIC LETTER THEH ISOLATED FORM
    $ac: Result:= #$060c;  // ARABIC COMMA
    $ad: Result:= #$fe9d;  // ARABIC LETTER JEEM ISOLATED FORM
    $ae: Result:= #$fea1;  // ARABIC LETTER HAH ISOLATED FORM
    $af: Result:= #$fea5;  // ARABIC LETTER KHAH ISOLATED FORM
    $b0: Result:= #$0660;  // ARABIC-INDIC DIGIT ZERO
    $b1: Result:= #$0661;  // ARABIC-INDIC DIGIT ONE
    $b2: Result:= #$0662;  // ARABIC-INDIC DIGIT TWO
    $b3: Result:= #$0663;  // ARABIC-INDIC DIGIT THREE
    $b4: Result:= #$0664;  // ARABIC-INDIC DIGIT FOUR
    $b5: Result:= #$0665;  // ARABIC-INDIC DIGIT FIVE
    $b6: Result:= #$0666;  // ARABIC-INDIC DIGIT SIX
    $b7: Result:= #$0667;  // ARABIC-INDIC DIGIT SEVEN
    $b8: Result:= #$0668;  // ARABIC-INDIC DIGIT EIGHT
    $b9: Result:= #$0669;  // ARABIC-INDIC DIGIT NINE
    $ba: Result:= #$fed1;  // ARABIC LETTER FEH ISOLATED FORM
    $bb: Result:= #$061b;  // ARABIC SEMICOLON
    $bc: Result:= #$feb1;  // ARABIC LETTER SEEN ISOLATED FORM
    $bd: Result:= #$feb5;  // ARABIC LETTER SHEEN ISOLATED FORM
    $be: Result:= #$feb9;  // ARABIC LETTER SAD ISOLATED FORM
    $bf: Result:= #$061f;  // ARABIC QUESTION MARK
    $c0: Result:= #$00a2;  // CENT SIGN
    $c1: Result:= #$fe80;  // ARABIC LETTER HAMZA ISOLATED FORM
    $c2: Result:= #$fe81;  // ARABIC LETTER ALEF WITH MADDA ABOVE ISOLATED FORM
    $c3: Result:= #$fe83;  // ARABIC LETTER ALEF WITH HAMZA ABOVE ISOLATED FORM
    $c4: Result:= #$fe85;  // ARABIC LETTER WAW WITH HAMZA ABOVE ISOLATED FORM
    $c5: Result:= #$feca;  // ARABIC LETTER AIN FINAL FORM
    $c6: Result:= #$fe8b;  // ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM
    $c7: Result:= #$fe8d;  // ARABIC LETTER ALEF ISOLATED FORM
    $c8: Result:= #$fe91;  // ARABIC LETTER BEH INITIAL FORM
    $c9: Result:= #$fe93;  // ARABIC LETTER TEH MARBUTA ISOLATED FORM
    $ca: Result:= #$fe97;  // ARABIC LETTER TEH INITIAL FORM
    $cb: Result:= #$fe9b;  // ARABIC LETTER THEH INITIAL FORM
    $cc: Result:= #$fe9f;  // ARABIC LETTER JEEM INITIAL FORM
    $cd: Result:= #$fea3;  // ARABIC LETTER HAH INITIAL FORM
    $ce: Result:= #$fea7;  // ARABIC LETTER KHAH INITIAL FORM
    $cf: Result:= #$fea9;  // ARABIC LETTER DAL ISOLATED FORM
    $d0: Result:= #$feab;  // ARABIC LETTER THAL ISOLATED FORM
    $d1: Result:= #$fead;  // ARABIC LETTER REH ISOLATED FORM
    $d2: Result:= #$feaf;  // ARABIC LETTER ZAIN ISOLATED FORM
    $d3: Result:= #$feb3;  // ARABIC LETTER SEEN INITIAL FORM
    $d4: Result:= #$feb7;  // ARABIC LETTER SHEEN INITIAL FORM
    $d5: Result:= #$febb;  // ARABIC LETTER SAD INITIAL FORM
    $d6: Result:= #$febf;  // ARABIC LETTER DAD INITIAL FORM
    $d7: Result:= #$fec1;  // ARABIC LETTER TAH ISOLATED FORM
    $d8: Result:= #$fec5;  // ARABIC LETTER ZAH ISOLATED FORM
    $d9: Result:= #$fecb;  // ARABIC LETTER AIN INITIAL FORM
    $da: Result:= #$fecf;  // ARABIC LETTER GHAIN INITIAL FORM
    $db: Result:= #$00a6;  // BROKEN VERTICAL BAR
    $dc: Result:= #$00ac;  // NOT SIGN
    $dd: Result:= #$00f7;  // DIVISION SIGN
    $de: Result:= #$00d7;  // MULTIPLICATION SIGN
    $df: Result:= #$fec9;  // ARABIC LETTER AIN ISOLATED FORM
    $e0: Result:= #$0640;  // ARABIC TATWEEL
    $e1: Result:= #$fed3;  // ARABIC LETTER FEH INITIAL FORM
    $e2: Result:= #$fed7;  // ARABIC LETTER QAF INITIAL FORM
    $e3: Result:= #$fedb;  // ARABIC LETTER KAF INITIAL FORM
    $e4: Result:= #$fedf;  // ARABIC LETTER LAM INITIAL FORM
    $e5: Result:= #$fee3;  // ARABIC LETTER MEEM INITIAL FORM
    $e6: Result:= #$fee7;  // ARABIC LETTER NOON INITIAL FORM
    $e7: Result:= #$feeb;  // ARABIC LETTER HEH INITIAL FORM
    $e8: Result:= #$feed;  // ARABIC LETTER WAW ISOLATED FORM
    $e9: Result:= #$feef;  // ARABIC LETTER ALEF MAKSURA ISOLATED FORM
    $ea: Result:= #$fef3;  // ARABIC LETTER YEH INITIAL FORM
    $eb: Result:= #$febd;  // ARABIC LETTER DAD ISOLATED FORM
    $ec: Result:= #$fecc;  // ARABIC LETTER AIN MEDIAL FORM
    $ed: Result:= #$fece;  // ARABIC LETTER GHAIN FINAL FORM
    $ee: Result:= #$fecd;  // ARABIC LETTER GHAIN ISOLATED FORM
    $ef: Result:= #$fee1;  // ARABIC LETTER MEEM ISOLATED FORM
    $f0: Result:= #$fe7d;  // ARABIC SHADDA MEDIAL FORM
    $f1: Result:= #$0651;  // ARABIC SHADDAH
    $f2: Result:= #$fee5;  // ARABIC LETTER NOON ISOLATED FORM
    $f3: Result:= #$fee9;  // ARABIC LETTER HEH ISOLATED FORM
    $f4: Result:= #$feec;  // ARABIC LETTER HEH MEDIAL FORM
    $f5: Result:= #$fef0;  // ARABIC LETTER ALEF MAKSURA FINAL FORM
    $f6: Result:= #$fef2;  // ARABIC LETTER YEH FINAL FORM
    $f7: Result:= #$fed0;  // ARABIC LETTER GHAIN MEDIAL FORM
    $f8: Result:= #$fed5;  // ARABIC LETTER QAF ISOLATED FORM
    $f9: Result:= #$fef5;  // ARABIC LIGATURE LAM WITH ALEF WITH MADDA ABOVE ISOLATED FORM
    $fa: Result:= #$fef6;  // ARABIC LIGATURE LAM WITH ALEF WITH MADDA ABOVE FINAL FORM
    $fb: Result:= #$fedd;  // ARABIC LETTER LAM ISOLATED FORM
    $fc: Result:= #$fed9;  // ARABIC LETTER KAF ISOLATED FORM
    $fd: Result:= #$fef1;  // ARABIC LETTER YEH ISOLATED FORM
    $fe: Result:= #$25a0;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp864_DOSArabic sequence of code point %d',[W]);
  end;
end;

function cp865ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$19,$1b,$1d..$7e: Result:= WideChar(W);
    $1a: Result:= #$001c;
    $1c: Result:= #$007f;
    $7f: Result:= #$001a;
    $80: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $85: Result:= #$00e0;  // LATIN SMALL LETTER A WITH GRAVE
    $86: Result:= #$00e5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $87: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $88: Result:= #$00ea;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $89: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $8a: Result:= #$00e8;  // LATIN SMALL LETTER E WITH GRAVE
    $8b: Result:= #$00ef;  // LATIN SMALL LETTER I WITH DIAERESIS
    $8c: Result:= #$00ee;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $8d: Result:= #$00ec;  // LATIN SMALL LETTER I WITH GRAVE
    $8e: Result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $8f: Result:= #$00c5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$00e6;  // LATIN SMALL LIGATURE AE
    $92: Result:= #$00c6;  // LATIN CAPITAL LIGATURE AE
    $93: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $94: Result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $95: Result:= #$00f2;  // LATIN SMALL LETTER O WITH GRAVE
    $96: Result:= #$00fb;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $97: Result:= #$00f9;  // LATIN SMALL LETTER U WITH GRAVE
    $98: Result:= #$00ff;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $99: Result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$00f8;  // LATIN SMALL LETTER O WITH STROKE
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00d8;  // LATIN CAPITAL LETTER O WITH STROKE
    $9e: Result:= #$20a7;  // PESETA SIGN
    $9f: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $a0: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $a1: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$00f1;  // LATIN SMALL LETTER N WITH TILDE
    $a5: Result:= #$00d1;  // LATIN CAPITAL LETTER N WITH TILDE
    $a6: Result:= #$00aa;  // FEMININE ORDINAL INDICATOR
    $a7: Result:= #$00ba;  // MASCULINE ORDINAL INDICATOR
    $a8: Result:= #$00bf;  // INVERTED QUESTION MARK
    $a9: Result:= #$2310;  // REVERSED NOT SIGN
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$00a1;  // INVERTED EXCLAMATION MARK
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00a4;  // CURRENCY SIGN
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b6: Result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b7: Result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $b8: Result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $be: Result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $c7: Result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $d0: Result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $d1: Result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $d2: Result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $d3: Result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $d4: Result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $d5: Result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $d6: Result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $d7: Result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $d8: Result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$258c;  // LEFT HALF BLOCK
    $de: Result:= #$2590;  // RIGHT HALF BLOCK
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$03b1;  // GREEK SMALL LETTER ALPHA
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e2: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $e3: Result:= #$03c0;  // GREEK SMALL LETTER PI
    $e4: Result:= #$03a3;  // GREEK CAPITAL LETTER SIGMA
    $e5: Result:= #$03c3;  // GREEK SMALL LETTER SIGMA
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e7: Result:= #$03c4;  // GREEK SMALL LETTER TAU
    $e8: Result:= #$03a6;  // GREEK CAPITAL LETTER PHI
    $e9: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $ea: Result:= #$03a9;  // GREEK CAPITAL LETTER OMEGA
    $eb: Result:= #$03b4;  // GREEK SMALL LETTER DELTA
    $ec: Result:= #$221e;  // INFINITY
    $ed: Result:= #$03c6;  // GREEK SMALL LETTER PHI
    $ee: Result:= #$03b5;  // GREEK SMALL LETTER EPSILON
    $ef: Result:= #$2229;  // INTERSECTION
    $f0: Result:= #$2261;  // IDENTICAL TO
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $f3: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $f4: Result:= #$2320;  // TOP HALF INTEGRAL
    $f5: Result:= #$2321;  // BOTTOM HALF INTEGRAL
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$2248;  // ALMOST EQUAL TO
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$2219;  // BULLET OPERATOR
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$221a;  // SQUARE ROOT
    $fc: Result:= #$207f;  // SUPERSCRIPT LATIN SMALL LETTER N
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp865 sequence of code point %d',[W]);
  end;
end;

function cp865_DOSNordicToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$7f: Result:= WideChar(W);
    $80: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $81: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $82: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $83: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $84: Result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $85: Result:= #$00e0;  // LATIN SMALL LETTER A WITH GRAVE
    $86: Result:= #$00e5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $87: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $88: Result:= #$00ea;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $89: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $8a: Result:= #$00e8;  // LATIN SMALL LETTER E WITH GRAVE
    $8b: Result:= #$00ef;  // LATIN SMALL LETTER I WITH DIAERESIS
    $8c: Result:= #$00ee;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $8d: Result:= #$00ec;  // LATIN SMALL LETTER I WITH GRAVE
    $8e: Result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $8f: Result:= #$00c5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $90: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $91: Result:= #$00e6;  // LATIN SMALL LIGATURE AE
    $92: Result:= #$00c6;  // LATIN CAPITAL LIGATURE AE
    $93: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $94: Result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $95: Result:= #$00f2;  // LATIN SMALL LETTER O WITH GRAVE
    $96: Result:= #$00fb;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $97: Result:= #$00f9;  // LATIN SMALL LETTER U WITH GRAVE
    $98: Result:= #$00ff;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $99: Result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $9a: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $9b: Result:= #$00f8;  // LATIN SMALL LETTER O WITH STROKE
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$00d8;  // LATIN CAPITAL LETTER O WITH STROKE
    $9e: Result:= #$20a7;  // PESETA SIGN
    $9f: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $a0: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $a1: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $a2: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $a3: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $a4: Result:= #$00f1;  // LATIN SMALL LETTER N WITH TILDE
    $a5: Result:= #$00d1;  // LATIN CAPITAL LETTER N WITH TILDE
    $a6: Result:= #$00aa;  // FEMININE ORDINAL INDICATOR
    $a7: Result:= #$00ba;  // MASCULINE ORDINAL INDICATOR
    $a8: Result:= #$00bf;  // INVERTED QUESTION MARK
    $a9: Result:= #$2310;  // REVERSED NOT SIGN
    $aa: Result:= #$00ac;  // NOT SIGN
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$00bc;  // VULGAR FRACTION ONE QUARTER
    $ad: Result:= #$00a1;  // INVERTED EXCLAMATION MARK
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00a4;  // CURRENCY SIGN
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b6: Result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b7: Result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $b8: Result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $be: Result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $c7: Result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $d0: Result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $d1: Result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $d2: Result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $d3: Result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $d4: Result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $d5: Result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $d6: Result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $d7: Result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $d8: Result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$258c;  // LEFT HALF BLOCK
    $de: Result:= #$2590;  // RIGHT HALF BLOCK
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$03b1;  // GREEK SMALL LETTER ALPHA
    $e1: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e2: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $e3: Result:= #$03c0;  // GREEK SMALL LETTER PI
    $e4: Result:= #$03a3;  // GREEK CAPITAL LETTER SIGMA
    $e5: Result:= #$03c3;  // GREEK SMALL LETTER SIGMA
    $e6: Result:= #$00b5;  // MICRO SIGN
    $e7: Result:= #$03c4;  // GREEK SMALL LETTER TAU
    $e8: Result:= #$03a6;  // GREEK CAPITAL LETTER PHI
    $e9: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $ea: Result:= #$03a9;  // GREEK CAPITAL LETTER OMEGA
    $eb: Result:= #$03b4;  // GREEK SMALL LETTER DELTA
    $ec: Result:= #$221e;  // INFINITY
    $ed: Result:= #$03c6;  // GREEK SMALL LETTER PHI
    $ee: Result:= #$03b5;  // GREEK SMALL LETTER EPSILON
    $ef: Result:= #$2229;  // INTERSECTION
    $f0: Result:= #$2261;  // IDENTICAL TO
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $f3: Result:= #$2264;  // LESS-THAN OR EQUAL TO
    $f4: Result:= #$2320;  // TOP HALF INTEGRAL
    $f5: Result:= #$2321;  // BOTTOM HALF INTEGRAL
    $f6: Result:= #$00f7;  // DIVISION SIGN
    $f7: Result:= #$2248;  // ALMOST EQUAL TO
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$2219;  // BULLET OPERATOR
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$221a;  // SQUARE ROOT
    $fc: Result:= #$207f;  // SUPERSCRIPT LATIN SMALL LETTER N
    $fd: Result:= #$00b2;  // SUPERSCRIPT TWO
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp865_DOSNordic sequence of code point %d',[W]);
  end;
end;

function cp866ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$19,$1b,$1d..$7e: Result:= WideChar(W);
    $1a: Result:= #$001c;
    $1c: Result:= #$007f;
    $7f: Result:= #$001a;
    $80: Result:= #$0410;  // CYRILLIC CAPITAL LETTER A
    $81: Result:= #$0411;  // CYRILLIC CAPITAL LETTER BE
    $82: Result:= #$0412;  // CYRILLIC CAPITAL LETTER VE
    $83: Result:= #$0413;  // CYRILLIC CAPITAL LETTER GHE
    $84: Result:= #$0414;  // CYRILLIC CAPITAL LETTER DE
    $85: Result:= #$0415;  // CYRILLIC CAPITAL LETTER IE
    $86: Result:= #$0416;  // CYRILLIC CAPITAL LETTER ZHE
    $87: Result:= #$0417;  // CYRILLIC CAPITAL LETTER ZE
    $88: Result:= #$0418;  // CYRILLIC CAPITAL LETTER I
    $89: Result:= #$0419;  // CYRILLIC CAPITAL LETTER SHORT I
    $8a: Result:= #$041a;  // CYRILLIC CAPITAL LETTER KA
    $8b: Result:= #$041b;  // CYRILLIC CAPITAL LETTER EL
    $8c: Result:= #$041c;  // CYRILLIC CAPITAL LETTER EM
    $8d: Result:= #$041d;  // CYRILLIC CAPITAL LETTER EN
    $8e: Result:= #$041e;  // CYRILLIC CAPITAL LETTER O
    $8f: Result:= #$041f;  // CYRILLIC CAPITAL LETTER PE
    $90: Result:= #$0420;  // CYRILLIC CAPITAL LETTER ER
    $91: Result:= #$0421;  // CYRILLIC CAPITAL LETTER ES
    $92: Result:= #$0422;  // CYRILLIC CAPITAL LETTER TE
    $93: Result:= #$0423;  // CYRILLIC CAPITAL LETTER U
    $94: Result:= #$0424;  // CYRILLIC CAPITAL LETTER EF
    $95: Result:= #$0425;  // CYRILLIC CAPITAL LETTER HA
    $96: Result:= #$0426;  // CYRILLIC CAPITAL LETTER TSE
    $97: Result:= #$0427;  // CYRILLIC CAPITAL LETTER CHE
    $98: Result:= #$0428;  // CYRILLIC CAPITAL LETTER SHA
    $99: Result:= #$0429;  // CYRILLIC CAPITAL LETTER SHCHA
    $9a: Result:= #$042a;  // CYRILLIC CAPITAL LETTER HARD SIGN
    $9b: Result:= #$042b;  // CYRILLIC CAPITAL LETTER YERU
    $9c: Result:= #$042c;  // CYRILLIC CAPITAL LETTER SOFT SIGN
    $9d: Result:= #$042d;  // CYRILLIC CAPITAL LETTER E
    $9e: Result:= #$042e;  // CYRILLIC CAPITAL LETTER YU
    $9f: Result:= #$042f;  // CYRILLIC CAPITAL LETTER YA
    $a0: Result:= #$0430;  // CYRILLIC SMALL LETTER A
    $a1: Result:= #$0431;  // CYRILLIC SMALL LETTER BE
    $a2: Result:= #$0432;  // CYRILLIC SMALL LETTER VE
    $a3: Result:= #$0433;  // CYRILLIC SMALL LETTER GHE
    $a4: Result:= #$0434;  // CYRILLIC SMALL LETTER DE
    $a5: Result:= #$0435;  // CYRILLIC SMALL LETTER IE
    $a6: Result:= #$0436;  // CYRILLIC SMALL LETTER ZHE
    $a7: Result:= #$0437;  // CYRILLIC SMALL LETTER ZE
    $a8: Result:= #$0438;  // CYRILLIC SMALL LETTER I
    $a9: Result:= #$0439;  // CYRILLIC SMALL LETTER SHORT I
    $aa: Result:= #$043a;  // CYRILLIC SMALL LETTER KA
    $ab: Result:= #$043b;  // CYRILLIC SMALL LETTER EL
    $ac: Result:= #$043c;  // CYRILLIC SMALL LETTER EM
    $ad: Result:= #$043d;  // CYRILLIC SMALL LETTER EN
    $ae: Result:= #$043e;  // CYRILLIC SMALL LETTER O
    $af: Result:= #$043f;  // CYRILLIC SMALL LETTER PE
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b6: Result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b7: Result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $b8: Result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $be: Result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $c7: Result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $d0: Result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $d1: Result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $d2: Result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $d3: Result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $d4: Result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $d5: Result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $d6: Result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $d7: Result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $d8: Result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$258c;  // LEFT HALF BLOCK
    $de: Result:= #$2590;  // RIGHT HALF BLOCK
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$0440;  // CYRILLIC SMALL LETTER ER
    $e1: Result:= #$0441;  // CYRILLIC SMALL LETTER ES
    $e2: Result:= #$0442;  // CYRILLIC SMALL LETTER TE
    $e3: Result:= #$0443;  // CYRILLIC SMALL LETTER U
    $e4: Result:= #$0444;  // CYRILLIC SMALL LETTER EF
    $e5: Result:= #$0445;  // CYRILLIC SMALL LETTER HA
    $e6: Result:= #$0446;  // CYRILLIC SMALL LETTER TSE
    $e7: Result:= #$0447;  // CYRILLIC SMALL LETTER CHE
    $e8: Result:= #$0448;  // CYRILLIC SMALL LETTER SHA
    $e9: Result:= #$0449;  // CYRILLIC SMALL LETTER SHCHA
    $ea: Result:= #$044a;  // CYRILLIC SMALL LETTER HARD SIGN
    $eb: Result:= #$044b;  // CYRILLIC SMALL LETTER YERU
    $ec: Result:= #$044c;  // CYRILLIC SMALL LETTER SOFT SIGN
    $ed: Result:= #$044d;  // CYRILLIC SMALL LETTER E
    $ee: Result:= #$044e;  // CYRILLIC SMALL LETTER YU
    $ef: Result:= #$044f;  // CYRILLIC SMALL LETTER YA
    $f0: Result:= #$0401;  // CYRILLIC CAPITAL LETTER IO
    $f1: Result:= #$0451;  // CYRILLIC SMALL LETTER IO
    $f2: Result:= #$0404;  // CYRILLIC CAPITAL LETTER UKRAINIAN IE
    $f3: Result:= #$0454;  // CYRILLIC SMALL LETTER UKRAINIAN IE
    $f4: Result:= #$0407;  // CYRILLIC CAPITAL LETTER YI
    $f5: Result:= #$0457;  // CYRILLIC SMALL LETTER YI
    $f6: Result:= #$040e;  // CYRILLIC CAPITAL LETTER SHORT U
    $f7: Result:= #$045e;  // CYRILLIC SMALL LETTER SHORT U
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$2219;  // BULLET OPERATOR
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$221a;  // SQUARE ROOT
    $fc: Result:= #$2116;  // NUMERO SIGN
    $fd: Result:= #$00a4;  // CURRENCY SIGN
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp866 sequence of code point %d',[W]);
  end;
end;

function cp866_DOSCyrillicRussianToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$7f: Result:= WideChar(W);
    $80: Result:= #$0410;  // CYRILLIC CAPITAL LETTER A
    $81: Result:= #$0411;  // CYRILLIC CAPITAL LETTER BE
    $82: Result:= #$0412;  // CYRILLIC CAPITAL LETTER VE
    $83: Result:= #$0413;  // CYRILLIC CAPITAL LETTER GHE
    $84: Result:= #$0414;  // CYRILLIC CAPITAL LETTER DE
    $85: Result:= #$0415;  // CYRILLIC CAPITAL LETTER IE
    $86: Result:= #$0416;  // CYRILLIC CAPITAL LETTER ZHE
    $87: Result:= #$0417;  // CYRILLIC CAPITAL LETTER ZE
    $88: Result:= #$0418;  // CYRILLIC CAPITAL LETTER I
    $89: Result:= #$0419;  // CYRILLIC CAPITAL LETTER SHORT I
    $8a: Result:= #$041a;  // CYRILLIC CAPITAL LETTER KA
    $8b: Result:= #$041b;  // CYRILLIC CAPITAL LETTER EL
    $8c: Result:= #$041c;  // CYRILLIC CAPITAL LETTER EM
    $8d: Result:= #$041d;  // CYRILLIC CAPITAL LETTER EN
    $8e: Result:= #$041e;  // CYRILLIC CAPITAL LETTER O
    $8f: Result:= #$041f;  // CYRILLIC CAPITAL LETTER PE
    $90: Result:= #$0420;  // CYRILLIC CAPITAL LETTER ER
    $91: Result:= #$0421;  // CYRILLIC CAPITAL LETTER ES
    $92: Result:= #$0422;  // CYRILLIC CAPITAL LETTER TE
    $93: Result:= #$0423;  // CYRILLIC CAPITAL LETTER U
    $94: Result:= #$0424;  // CYRILLIC CAPITAL LETTER EF
    $95: Result:= #$0425;  // CYRILLIC CAPITAL LETTER HA
    $96: Result:= #$0426;  // CYRILLIC CAPITAL LETTER TSE
    $97: Result:= #$0427;  // CYRILLIC CAPITAL LETTER CHE
    $98: Result:= #$0428;  // CYRILLIC CAPITAL LETTER SHA
    $99: Result:= #$0429;  // CYRILLIC CAPITAL LETTER SHCHA
    $9a: Result:= #$042a;  // CYRILLIC CAPITAL LETTER HARD SIGN
    $9b: Result:= #$042b;  // CYRILLIC CAPITAL LETTER YERU
    $9c: Result:= #$042c;  // CYRILLIC CAPITAL LETTER SOFT SIGN
    $9d: Result:= #$042d;  // CYRILLIC CAPITAL LETTER E
    $9e: Result:= #$042e;  // CYRILLIC CAPITAL LETTER YU
    $9f: Result:= #$042f;  // CYRILLIC CAPITAL LETTER YA
    $a0: Result:= #$0430;  // CYRILLIC SMALL LETTER A
    $a1: Result:= #$0431;  // CYRILLIC SMALL LETTER BE
    $a2: Result:= #$0432;  // CYRILLIC SMALL LETTER VE
    $a3: Result:= #$0433;  // CYRILLIC SMALL LETTER GHE
    $a4: Result:= #$0434;  // CYRILLIC SMALL LETTER DE
    $a5: Result:= #$0435;  // CYRILLIC SMALL LETTER IE
    $a6: Result:= #$0436;  // CYRILLIC SMALL LETTER ZHE
    $a7: Result:= #$0437;  // CYRILLIC SMALL LETTER ZE
    $a8: Result:= #$0438;  // CYRILLIC SMALL LETTER I
    $a9: Result:= #$0439;  // CYRILLIC SMALL LETTER SHORT I
    $aa: Result:= #$043a;  // CYRILLIC SMALL LETTER KA
    $ab: Result:= #$043b;  // CYRILLIC SMALL LETTER EL
    $ac: Result:= #$043c;  // CYRILLIC SMALL LETTER EM
    $ad: Result:= #$043d;  // CYRILLIC SMALL LETTER EN
    $ae: Result:= #$043e;  // CYRILLIC SMALL LETTER O
    $af: Result:= #$043f;  // CYRILLIC SMALL LETTER PE
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b6: Result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b7: Result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $b8: Result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $be: Result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $c7: Result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $d0: Result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $d1: Result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $d2: Result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $d3: Result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $d4: Result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $d5: Result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $d6: Result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $d7: Result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $d8: Result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$258c;  // LEFT HALF BLOCK
    $de: Result:= #$2590;  // RIGHT HALF BLOCK
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$0440;  // CYRILLIC SMALL LETTER ER
    $e1: Result:= #$0441;  // CYRILLIC SMALL LETTER ES
    $e2: Result:= #$0442;  // CYRILLIC SMALL LETTER TE
    $e3: Result:= #$0443;  // CYRILLIC SMALL LETTER U
    $e4: Result:= #$0444;  // CYRILLIC SMALL LETTER EF
    $e5: Result:= #$0445;  // CYRILLIC SMALL LETTER HA
    $e6: Result:= #$0446;  // CYRILLIC SMALL LETTER TSE
    $e7: Result:= #$0447;  // CYRILLIC SMALL LETTER CHE
    $e8: Result:= #$0448;  // CYRILLIC SMALL LETTER SHA
    $e9: Result:= #$0449;  // CYRILLIC SMALL LETTER SHCHA
    $ea: Result:= #$044a;  // CYRILLIC SMALL LETTER HARD SIGN
    $eb: Result:= #$044b;  // CYRILLIC SMALL LETTER YERU
    $ec: Result:= #$044c;  // CYRILLIC SMALL LETTER SOFT SIGN
    $ed: Result:= #$044d;  // CYRILLIC SMALL LETTER E
    $ee: Result:= #$044e;  // CYRILLIC SMALL LETTER YU
    $ef: Result:= #$044f;  // CYRILLIC SMALL LETTER YA
    $f0: Result:= #$0401;  // CYRILLIC CAPITAL LETTER IO
    $f1: Result:= #$0451;  // CYRILLIC SMALL LETTER IO
    $f2: Result:= #$0404;  // CYRILLIC CAPITAL LETTER UKRAINIAN IE
    $f3: Result:= #$0454;  // CYRILLIC SMALL LETTER UKRAINIAN IE
    $f4: Result:= #$0407;  // CYRILLIC CAPITAL LETTER YI
    $f5: Result:= #$0457;  // CYRILLIC SMALL LETTER YI
    $f6: Result:= #$040e;  // CYRILLIC CAPITAL LETTER SHORT U
    $f7: Result:= #$045e;  // CYRILLIC SMALL LETTER SHORT U
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$2219;  // BULLET OPERATOR
    $fa: Result:= #$00b7;  // MIDDLE DOT
    $fb: Result:= #$221a;  // SQUARE ROOT
    $fc: Result:= #$2116;  // NUMERO SIGN
    $fd: Result:= #$00a4;  // CURRENCY SIGN
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp866_DOSCyrillicRussian sequence of code point %d',[W]);
  end;
end;

function cp869ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$19,$1b,$1d..$7e: Result:= WideChar(W);
    $1a: Result:= #$001c;
    $1c: Result:= #$007f;
    $7f: Result:= #$001a;
    $86: Result:= #$0386;  // GREEK CAPITAL LETTER ALPHA WITH TONOS
    $88: Result:= #$0387;  // GREEK ANO TELEIA
    $89: Result:= #$00ac;  // NOT SIGN
    $8a: Result:= #$00a6;  // BROKEN BAR
    $8b: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $8c: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $8d: Result:= #$0388;  // GREEK CAPITAL LETTER EPSILON WITH TONOS
    $8e: Result:= #$2015;  // HORIZONTAL BAR
    $8f: Result:= #$0389;  // GREEK CAPITAL LETTER ETA WITH TONOS
    $90: Result:= #$038a;  // GREEK CAPITAL LETTER IOTA WITH TONOS
    $91: Result:= #$03aa;  // GREEK CAPITAL LETTER IOTA WITH DIALYTIKA
    $92: Result:= #$038c;  // GREEK CAPITAL LETTER OMICRON WITH TONOS
    $95: Result:= #$038e;  // GREEK CAPITAL LETTER UPSILON WITH TONOS
    $96: Result:= #$03ab;  // GREEK CAPITAL LETTER UPSILON WITH DIALYTIKA
    $97: Result:= #$00a9;  // COPYRIGHT SIGN
    $98: Result:= #$038f;  // GREEK CAPITAL LETTER OMEGA WITH TONOS
    $99: Result:= #$00b2;  // SUPERSCRIPT TWO
    $9a: Result:= #$00b3;  // SUPERSCRIPT THREE
    $9b: Result:= #$03ac;  // GREEK SMALL LETTER ALPHA WITH TONOS
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$03ad;  // GREEK SMALL LETTER EPSILON WITH TONOS
    $9e: Result:= #$03ae;  // GREEK SMALL LETTER ETA WITH TONOS
    $9f: Result:= #$03af;  // GREEK SMALL LETTER IOTA WITH TONOS
    $a0: Result:= #$03ca;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA
    $a1: Result:= #$0390;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA AND TONOS
    $a2: Result:= #$03cc;  // GREEK SMALL LETTER OMICRON WITH TONOS
    $a3: Result:= #$03cd;  // GREEK SMALL LETTER UPSILON WITH TONOS
    $a4: Result:= #$0391;  // GREEK CAPITAL LETTER ALPHA
    $a5: Result:= #$0392;  // GREEK CAPITAL LETTER BETA
    $a6: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $a7: Result:= #$0394;  // GREEK CAPITAL LETTER DELTA
    $a8: Result:= #$0395;  // GREEK CAPITAL LETTER EPSILON
    $a9: Result:= #$0396;  // GREEK CAPITAL LETTER ZETA
    $aa: Result:= #$0397;  // GREEK CAPITAL LETTER ETA
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $ad: Result:= #$0399;  // GREEK CAPITAL LETTER IOTA
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$039a;  // GREEK CAPITAL LETTER KAPPA
    $b6: Result:= #$039b;  // GREEK CAPITAL LETTER LAMDA
    $b7: Result:= #$039c;  // GREEK CAPITAL LETTER MU
    $b8: Result:= #$039d;  // GREEK CAPITAL LETTER NU
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$039e;  // GREEK CAPITAL LETTER XI
    $be: Result:= #$039f;  // GREEK CAPITAL LETTER OMICRON
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$03a0;  // GREEK CAPITAL LETTER PI
    $c7: Result:= #$03a1;  // GREEK CAPITAL LETTER RHO
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$03a3;  // GREEK CAPITAL LETTER SIGMA
    $d0: Result:= #$03a4;  // GREEK CAPITAL LETTER TAU
    $d1: Result:= #$03a5;  // GREEK CAPITAL LETTER UPSILON
    $d2: Result:= #$03a6;  // GREEK CAPITAL LETTER PHI
    $d3: Result:= #$03a7;  // GREEK CAPITAL LETTER CHI
    $d4: Result:= #$03a8;  // GREEK CAPITAL LETTER PSI
    $d5: Result:= #$03a9;  // GREEK CAPITAL LETTER OMEGA
    $d6: Result:= #$03b1;  // GREEK SMALL LETTER ALPHA
    $d7: Result:= #$03b2;  // GREEK SMALL LETTER BETA
    $d8: Result:= #$03b3;  // GREEK SMALL LETTER GAMMA
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$03b4;  // GREEK SMALL LETTER DELTA
    $de: Result:= #$03b5;  // GREEK SMALL LETTER EPSILON
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$03b6;  // GREEK SMALL LETTER ZETA
    $e1: Result:= #$03b7;  // GREEK SMALL LETTER ETA
    $e2: Result:= #$03b8;  // GREEK SMALL LETTER THETA
    $e3: Result:= #$03b9;  // GREEK SMALL LETTER IOTA
    $e4: Result:= #$03ba;  // GREEK SMALL LETTER KAPPA
    $e5: Result:= #$03bb;  // GREEK SMALL LETTER LAMDA
    $e6: Result:= #$03bc;  // GREEK SMALL LETTER MU
    $e7: Result:= #$03bd;  // GREEK SMALL LETTER NU
    $e8: Result:= #$03be;  // GREEK SMALL LETTER XI
    $e9: Result:= #$03bf;  // GREEK SMALL LETTER OMICRON
    $ea: Result:= #$03c0;  // GREEK SMALL LETTER PI
    $eb: Result:= #$03c1;  // GREEK SMALL LETTER RHO
    $ec: Result:= #$03c3;  // GREEK SMALL LETTER SIGMA
    $ed: Result:= #$03c2;  // GREEK SMALL LETTER FINAL SIGMA
    $ee: Result:= #$03c4;  // GREEK SMALL LETTER TAU
    $ef: Result:= #$00b4;  // ACUTE ACCENT
    $f0: Result:= #$00ad;  // SOFT HYPHEN
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$03c5;  // GREEK SMALL LETTER UPSILON
    $f3: Result:= #$03c6;  // GREEK SMALL LETTER PHI
    $f4: Result:= #$03c7;  // GREEK SMALL LETTER CHI
    $f5: Result:= #$00a7;  // SECTION SIGN
    $f6: Result:= #$03c8;  // GREEK SMALL LETTER PSI
    $f7: Result:= #$0385;  // GREEK DIALYTIKA TONOS
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$00a8;  // DIAERESIS
    $fa: Result:= #$03c9;  // GREEK SMALL LETTER OMEGA
    $fb: Result:= #$03cb;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA
    $fc: Result:= #$03b0;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA AND TONOS
    $fd: Result:= #$03ce;  // GREEK SMALL LETTER OMEGA WITH TONOS
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp869 sequence of code point %d',[W]);
  end;
end;

function cp869_DOSGreek2ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$7f: Result:= WideChar(W);
    $86: Result:= #$0386;  // GREEK CAPITAL LETTER ALPHA WITH TONOS
    $88: Result:= #$00b7;  // MIDDLE DOT
    $89: Result:= #$00ac;  // NOT SIGN
    $8a: Result:= #$00a6;  // BROKEN BAR
    $8b: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $8c: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $8d: Result:= #$0388;  // GREEK CAPITAL LETTER EPSILON WITH TONOS
    $8e: Result:= #$2015;  // HORIZONTAL BAR
    $8f: Result:= #$0389;  // GREEK CAPITAL LETTER ETA WITH TONOS
    $90: Result:= #$038a;  // GREEK CAPITAL LETTER IOTA WITH TONOS
    $91: Result:= #$03aa;  // GREEK CAPITAL LETTER IOTA WITH DIALYTIKA
    $92: Result:= #$038c;  // GREEK CAPITAL LETTER OMICRON WITH TONOS
    $95: Result:= #$038e;  // GREEK CAPITAL LETTER UPSILON WITH TONOS
    $96: Result:= #$03ab;  // GREEK CAPITAL LETTER UPSILON WITH DIALYTIKA
    $97: Result:= #$00a9;  // COPYRIGHT SIGN
    $98: Result:= #$038f;  // GREEK CAPITAL LETTER OMEGA WITH TONOS
    $99: Result:= #$00b2;  // SUPERSCRIPT TWO
    $9a: Result:= #$00b3;  // SUPERSCRIPT THREE
    $9b: Result:= #$03ac;  // GREEK SMALL LETTER ALPHA WITH TONOS
    $9c: Result:= #$00a3;  // POUND SIGN
    $9d: Result:= #$03ad;  // GREEK SMALL LETTER EPSILON WITH TONOS
    $9e: Result:= #$03ae;  // GREEK SMALL LETTER ETA WITH TONOS
    $9f: Result:= #$03af;  // GREEK SMALL LETTER IOTA WITH TONOS
    $a0: Result:= #$03ca;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA
    $a1: Result:= #$0390;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA AND TONOS
    $a2: Result:= #$03cc;  // GREEK SMALL LETTER OMICRON WITH TONOS
    $a3: Result:= #$03cd;  // GREEK SMALL LETTER UPSILON WITH TONOS
    $a4: Result:= #$0391;  // GREEK CAPITAL LETTER ALPHA
    $a5: Result:= #$0392;  // GREEK CAPITAL LETTER BETA
    $a6: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $a7: Result:= #$0394;  // GREEK CAPITAL LETTER DELTA
    $a8: Result:= #$0395;  // GREEK CAPITAL LETTER EPSILON
    $a9: Result:= #$0396;  // GREEK CAPITAL LETTER ZETA
    $aa: Result:= #$0397;  // GREEK CAPITAL LETTER ETA
    $ab: Result:= #$00bd;  // VULGAR FRACTION ONE HALF
    $ac: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $ad: Result:= #$0399;  // GREEK CAPITAL LETTER IOTA
    $ae: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $af: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $b0: Result:= #$2591;  // LIGHT SHADE
    $b1: Result:= #$2592;  // MEDIUM SHADE
    $b2: Result:= #$2593;  // DARK SHADE
    $b3: Result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $b4: Result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $b5: Result:= #$039a;  // GREEK CAPITAL LETTER KAPPA
    $b6: Result:= #$039b;  // GREEK CAPITAL LETTER LAMDA
    $b7: Result:= #$039c;  // GREEK CAPITAL LETTER MU
    $b8: Result:= #$039d;  // GREEK CAPITAL LETTER NU
    $b9: Result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $ba: Result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $bb: Result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $bc: Result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $bd: Result:= #$039e;  // GREEK CAPITAL LETTER XI
    $be: Result:= #$039f;  // GREEK CAPITAL LETTER OMICRON
    $bf: Result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $c0: Result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $c1: Result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $c2: Result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $c3: Result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $c4: Result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $c5: Result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $c6: Result:= #$03a0;  // GREEK CAPITAL LETTER PI
    $c7: Result:= #$03a1;  // GREEK CAPITAL LETTER RHO
    $c8: Result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $c9: Result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $ca: Result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $cb: Result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $cc: Result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $cd: Result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $ce: Result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $cf: Result:= #$03a3;  // GREEK CAPITAL LETTER SIGMA
    $d0: Result:= #$03a4;  // GREEK CAPITAL LETTER TAU
    $d1: Result:= #$03a5;  // GREEK CAPITAL LETTER UPSILON
    $d2: Result:= #$03a6;  // GREEK CAPITAL LETTER PHI
    $d3: Result:= #$03a7;  // GREEK CAPITAL LETTER CHI
    $d4: Result:= #$03a8;  // GREEK CAPITAL LETTER PSI
    $d5: Result:= #$03a9;  // GREEK CAPITAL LETTER OMEGA
    $d6: Result:= #$03b1;  // GREEK SMALL LETTER ALPHA
    $d7: Result:= #$03b2;  // GREEK SMALL LETTER BETA
    $d8: Result:= #$03b3;  // GREEK SMALL LETTER GAMMA
    $d9: Result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $da: Result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $db: Result:= #$2588;  // FULL BLOCK
    $dc: Result:= #$2584;  // LOWER HALF BLOCK
    $dd: Result:= #$03b4;  // GREEK SMALL LETTER DELTA
    $de: Result:= #$03b5;  // GREEK SMALL LETTER EPSILON
    $df: Result:= #$2580;  // UPPER HALF BLOCK
    $e0: Result:= #$03b6;  // GREEK SMALL LETTER ZETA
    $e1: Result:= #$03b7;  // GREEK SMALL LETTER ETA
    $e2: Result:= #$03b8;  // GREEK SMALL LETTER THETA
    $e3: Result:= #$03b9;  // GREEK SMALL LETTER IOTA
    $e4: Result:= #$03ba;  // GREEK SMALL LETTER KAPPA
    $e5: Result:= #$03bb;  // GREEK SMALL LETTER LAMDA
    $e6: Result:= #$03bc;  // GREEK SMALL LETTER MU
    $e7: Result:= #$03bd;  // GREEK SMALL LETTER NU
    $e8: Result:= #$03be;  // GREEK SMALL LETTER XI
    $e9: Result:= #$03bf;  // GREEK SMALL LETTER OMICRON
    $ea: Result:= #$03c0;  // GREEK SMALL LETTER PI
    $eb: Result:= #$03c1;  // GREEK SMALL LETTER RHO
    $ec: Result:= #$03c3;  // GREEK SMALL LETTER SIGMA
    $ed: Result:= #$03c2;  // GREEK SMALL LETTER FINAL SIGMA
    $ee: Result:= #$03c4;  // GREEK SMALL LETTER TAU
    $ef: Result:= #$0384;  // GREEK TONOS
    $f0: Result:= #$00ad;  // SOFT HYPHEN
    $f1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $f2: Result:= #$03c5;  // GREEK SMALL LETTER UPSILON
    $f3: Result:= #$03c6;  // GREEK SMALL LETTER PHI
    $f4: Result:= #$03c7;  // GREEK SMALL LETTER CHI
    $f5: Result:= #$00a7;  // SECTION SIGN
    $f6: Result:= #$03c8;  // GREEK SMALL LETTER PSI
    $f7: Result:= #$0385;  // GREEK DIALYTIKA TONOS
    $f8: Result:= #$00b0;  // DEGREE SIGN
    $f9: Result:= #$00a8;  // DIAERESIS
    $fa: Result:= #$03c9;  // GREEK SMALL LETTER OMEGA
    $fb: Result:= #$03cb;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA
    $fc: Result:= #$03b0;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA AND TONOS
    $fd: Result:= #$03ce;  // GREEK SMALL LETTER OMEGA WITH TONOS
    $fe: Result:= #$25a0;  // BLACK SQUARE
    $ff: Result:= #$00a0;  // NO-BREAK SPACE
  else
    raise EConvertError.CreateFmt('Invalid cp869_DOSGreek2 sequence of code point %d',[W]);
  end;
end;

function cp874ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A0: Result:= WideChar(W);
    $80: Result:= #$20AC;  // EURO SIGN
    $85: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $91: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $94: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $95: Result:= #$2022;  // BULLET
    $96: Result:= #$2013;  // EN DASH
    $97: Result:= #$2014;  // EM DASH
    $A1: Result:= #$0E01;  // THAI CHARACTER KO KAI
    $A2: Result:= #$0E02;  // THAI CHARACTER KHO KHAI
    $A3: Result:= #$0E03;  // THAI CHARACTER KHO KHUAT
    $A4: Result:= #$0E04;  // THAI CHARACTER KHO KHWAI
    $A5: Result:= #$0E05;  // THAI CHARACTER KHO KHON
    $A6: Result:= #$0E06;  // THAI CHARACTER KHO RAKHANG
    $A7: Result:= #$0E07;  // THAI CHARACTER NGO NGU
    $A8: Result:= #$0E08;  // THAI CHARACTER CHO CHAN
    $A9: Result:= #$0E09;  // THAI CHARACTER CHO CHING
    $AA: Result:= #$0E0A;  // THAI CHARACTER CHO CHANG
    $AB: Result:= #$0E0B;  // THAI CHARACTER SO SO
    $AC: Result:= #$0E0C;  // THAI CHARACTER CHO CHOE
    $AD: Result:= #$0E0D;  // THAI CHARACTER YO YING
    $AE: Result:= #$0E0E;  // THAI CHARACTER DO CHADA
    $AF: Result:= #$0E0F;  // THAI CHARACTER TO PATAK
    $B0: Result:= #$0E10;  // THAI CHARACTER THO THAN
    $B1: Result:= #$0E11;  // THAI CHARACTER THO NANGMONTHO
    $B2: Result:= #$0E12;  // THAI CHARACTER THO PHUTHAO
    $B3: Result:= #$0E13;  // THAI CHARACTER NO NEN
    $B4: Result:= #$0E14;  // THAI CHARACTER DO DEK
    $B5: Result:= #$0E15;  // THAI CHARACTER TO TAO
    $B6: Result:= #$0E16;  // THAI CHARACTER THO THUNG
    $B7: Result:= #$0E17;  // THAI CHARACTER THO THAHAN
    $B8: Result:= #$0E18;  // THAI CHARACTER THO THONG
    $B9: Result:= #$0E19;  // THAI CHARACTER NO NU
    $BA: Result:= #$0E1A;  // THAI CHARACTER BO BAIMAI
    $BB: Result:= #$0E1B;  // THAI CHARACTER PO PLA
    $BC: Result:= #$0E1C;  // THAI CHARACTER PHO PHUNG
    $BD: Result:= #$0E1D;  // THAI CHARACTER FO FA
    $BE: Result:= #$0E1E;  // THAI CHARACTER PHO PHAN
    $BF: Result:= #$0E1F;  // THAI CHARACTER FO FAN
    $C0: Result:= #$0E20;  // THAI CHARACTER PHO SAMPHAO
    $C1: Result:= #$0E21;  // THAI CHARACTER MO MA
    $C2: Result:= #$0E22;  // THAI CHARACTER YO YAK
    $C3: Result:= #$0E23;  // THAI CHARACTER RO RUA
    $C4: Result:= #$0E24;  // THAI CHARACTER RU
    $C5: Result:= #$0E25;  // THAI CHARACTER LO LING
    $C6: Result:= #$0E26;  // THAI CHARACTER LU
    $C7: Result:= #$0E27;  // THAI CHARACTER WO WAEN
    $C8: Result:= #$0E28;  // THAI CHARACTER SO SALA
    $C9: Result:= #$0E29;  // THAI CHARACTER SO RUSI
    $CA: Result:= #$0E2A;  // THAI CHARACTER SO SUA
    $CB: Result:= #$0E2B;  // THAI CHARACTER HO HIP
    $CC: Result:= #$0E2C;  // THAI CHARACTER LO CHULA
    $CD: Result:= #$0E2D;  // THAI CHARACTER O ANG
    $CE: Result:= #$0E2E;  // THAI CHARACTER HO NOKHUK
    $CF: Result:= #$0E2F;  // THAI CHARACTER PAIYANNOI
    $D0: Result:= #$0E30;  // THAI CHARACTER SARA A
    $D1: Result:= #$0E31;  // THAI CHARACTER MAI HAN-AKAT
    $D2: Result:= #$0E32;  // THAI CHARACTER SARA AA
    $D3: Result:= #$0E33;  // THAI CHARACTER SARA AM
    $D4: Result:= #$0E34;  // THAI CHARACTER SARA I
    $D5: Result:= #$0E35;  // THAI CHARACTER SARA II
    $D6: Result:= #$0E36;  // THAI CHARACTER SARA UE
    $D7: Result:= #$0E37;  // THAI CHARACTER SARA UEE
    $D8: Result:= #$0E38;  // THAI CHARACTER SARA U
    $D9: Result:= #$0E39;  // THAI CHARACTER SARA UU
    $DA: Result:= #$0E3A;  // THAI CHARACTER PHINTHU
    $DF: Result:= #$0E3F;  // THAI CURRENCY SYMBOL BAHT
    $E0: Result:= #$0E40;  // THAI CHARACTER SARA E
    $E1: Result:= #$0E41;  // THAI CHARACTER SARA AE
    $E2: Result:= #$0E42;  // THAI CHARACTER SARA O
    $E3: Result:= #$0E43;  // THAI CHARACTER SARA AI MAIMUAN
    $E4: Result:= #$0E44;  // THAI CHARACTER SARA AI MAIMALAI
    $E5: Result:= #$0E45;  // THAI CHARACTER LAKKHANGYAO
    $E6: Result:= #$0E46;  // THAI CHARACTER MAIYAMOK
    $E7: Result:= #$0E47;  // THAI CHARACTER MAITAIKHU
    $E8: Result:= #$0E48;  // THAI CHARACTER MAI EK
    $E9: Result:= #$0E49;  // THAI CHARACTER MAI THO
    $EA: Result:= #$0E4A;  // THAI CHARACTER MAI TRI
    $EB: Result:= #$0E4B;  // THAI CHARACTER MAI CHATTAWA
    $EC: Result:= #$0E4C;  // THAI CHARACTER THANTHAKHAT
    $ED: Result:= #$0E4D;  // THAI CHARACTER NIKHAHIT
    $EE: Result:= #$0E4E;  // THAI CHARACTER YAMAKKAN
    $EF: Result:= #$0E4F;  // THAI CHARACTER FONGMAN
    $F0: Result:= #$0E50;  // THAI DIGIT ZERO
    $F1: Result:= #$0E51;  // THAI DIGIT ONE
    $F2: Result:= #$0E52;  // THAI DIGIT TWO
    $F3: Result:= #$0E53;  // THAI DIGIT THREE
    $F4: Result:= #$0E54;  // THAI DIGIT FOUR
    $F5: Result:= #$0E55;  // THAI DIGIT FIVE
    $F6: Result:= #$0E56;  // THAI DIGIT SIX
    $F7: Result:= #$0E57;  // THAI DIGIT SEVEN
    $F8: Result:= #$0E58;  // THAI DIGIT EIGHT
    $F9: Result:= #$0E59;  // THAI DIGIT NINE
    $FA: Result:= #$0E5A;  // THAI CHARACTER ANGKHANKHU
    $FB: Result:= #$0E5B;  // THAI CHARACTER KHOMUT
  else
    raise EConvertError.CreateFmt('Invalid Windows-874 sequence of code point %d',[W]);
  end;
end;

function cp875ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$03,$0B..$13,$18..$19,$1C..$1F:
      Result:= WideChar(W);
    $04: Result:= #$009C;  // CONTROL
    $05: Result:= #$0009;  // HORIZONTAL TABULATION
    $06: Result:= #$0086;  // CONTROL
    $07: Result:= #$007F;  // DELETE
    $08: Result:= #$0097;  // CONTROL
    $09: Result:= #$008D;  // CONTROL
    $0A: Result:= #$008E;  // CONTROL
    $14: Result:= #$009D;  // CONTROL
    $15: Result:= #$0085;  // CONTROL
    $16: Result:= #$0008;  // BACKSPACE
    $17: Result:= #$0087;  // CONTROL
    $1A: Result:= #$0092;  // CONTROL
    $1B: Result:= #$008F;  // CONTROL
    $20: Result:= #$0080;  // CONTROL
    $21: Result:= #$0081;  // CONTROL
    $22: Result:= #$0082;  // CONTROL
    $23: Result:= #$0083;  // CONTROL
    $24: Result:= #$0084;  // CONTROL
    $25: Result:= #$000A;  // LINE FEED
    $26: Result:= #$0017;  // END OF TRANSMISSION BLOCK
    $27: Result:= #$001B;  // ESCAPE
    $28: Result:= #$0088;  // CONTROL
    $29: Result:= #$0089;  // CONTROL
    $2A: Result:= #$008A;  // CONTROL
    $2B: Result:= #$008B;  // CONTROL
    $2C: Result:= #$008C;  // CONTROL
    $2D: Result:= #$0005;  // ENQUIRY
    $2E: Result:= #$0006;  // ACKNOWLEDGE
    $2F: Result:= #$0007;  // BELL
    $30: Result:= #$0090;  // CONTROL
    $31: Result:= #$0091;  // CONTROL
    $32: Result:= #$0016;  // SYNCHRONOUS IDLE
    $33: Result:= #$0093;  // CONTROL
    $34: Result:= #$0094;  // CONTROL
    $35: Result:= #$0095;  // CONTROL
    $36: Result:= #$0096;  // CONTROL
    $37: Result:= #$0004;  // END OF TRANSMISSION
    $38: Result:= #$0098;  // CONTROL
    $39: Result:= #$0099;  // CONTROL
    $3A: Result:= #$009A;  // CONTROL
    $3B: Result:= #$009B;  // CONTROL
    $3C: Result:= #$0014;  // DEVICE CONTROL FOUR
    $3D: Result:= #$0015;  // NEGATIVE ACKNOWLEDGE
    $3E: Result:= #$009E;  // CONTROL
    $3F: Result:= #$001A;  // SUBSTITUTE
    $40: Result:= #$0020;  // SPACE
    $41: Result:= #$0391;  // GREEK CAPITAL LETTER ALPHA
    $42: Result:= #$0392;  // GREEK CAPITAL LETTER BETA
    $43: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $44: Result:= #$0394;  // GREEK CAPITAL LETTER DELTA
    $45: Result:= #$0395;  // GREEK CAPITAL LETTER EPSILON
    $46: Result:= #$0396;  // GREEK CAPITAL LETTER ZETA
    $47: Result:= #$0397;  // GREEK CAPITAL LETTER ETA
    $48: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $49: Result:= #$0399;  // GREEK CAPITAL LETTER IOTA
    $4A: Result:= #$005B;  // LEFT SQUARE BRACKET
    $4B: Result:= #$002E;  // FULL STOP
    $4C: Result:= #$003C;  // LESS-THAN SIGN
    $4D: Result:= #$0028;  // LEFT PARENTHESIS
    $4E: Result:= #$002B;  // PLUS SIGN
    $4F: Result:= #$0021;  // EXCLAMATION MARK
    $50: Result:= #$0026;  // AMPERSAND
    $51: Result:= #$039A;  // GREEK CAPITAL LETTER KAPPA
    $52: Result:= #$039B;  // GREEK CAPITAL LETTER LAMDA
    $53: Result:= #$039C;  // GREEK CAPITAL LETTER MU
    $54: Result:= #$039D;  // GREEK CAPITAL LETTER NU
    $55: Result:= #$039E;  // GREEK CAPITAL LETTER XI
    $56: Result:= #$039F;  // GREEK CAPITAL LETTER OMICRON
    $57: Result:= #$03A0;  // GREEK CAPITAL LETTER PI
    $58: Result:= #$03A1;  // GREEK CAPITAL LETTER RHO
    $59: Result:= #$03A3;  // GREEK CAPITAL LETTER SIGMA
    $5A: Result:= #$005D;  // RIGHT SQUARE BRACKET
    $5B: Result:= #$0024;  // DOLLAR SIGN
    $5C: Result:= #$002A;  // ASTERISK
    $5D: Result:= #$0029;  // RIGHT PARENTHESIS
    $5E: Result:= #$003B;  // SEMICOLON
    $5F: Result:= #$005E;  // CIRCUMFLEX ACCENT
    $60: Result:= #$002D;  // HYPHEN-MINUS
    $61: Result:= #$002F;  // SOLIDUS
    $62: Result:= #$03A4;  // GREEK CAPITAL LETTER TAU
    $63: Result:= #$03A5;  // GREEK CAPITAL LETTER UPSILON
    $64: Result:= #$03A6;  // GREEK CAPITAL LETTER PHI
    $65: Result:= #$03A7;  // GREEK CAPITAL LETTER CHI
    $66: Result:= #$03A8;  // GREEK CAPITAL LETTER PSI
    $67: Result:= #$03A9;  // GREEK CAPITAL LETTER OMEGA
    $68: Result:= #$03AA;  // GREEK CAPITAL LETTER IOTA WITH DIALYTIKA
    $69: Result:= #$03AB;  // GREEK CAPITAL LETTER UPSILON WITH DIALYTIKA
    $6A: Result:= #$007C;  // VERTICAL LINE
    $6B: Result:= #$002C;  // COMMA
    $6C: Result:= #$0025;  // PERCENT SIGN
    $6D: Result:= #$005F;  // LOW LINE
    $6E: Result:= #$003E;  // GREATER-THAN SIGN
    $6F: Result:= #$003F;  // QUESTION MARK
    $70: Result:= #$00A8;  // DIAERESIS
    $71: Result:= #$0386;  // GREEK CAPITAL LETTER ALPHA WITH TONOS
    $72: Result:= #$0388;  // GREEK CAPITAL LETTER EPSILON WITH TONOS
    $73: Result:= #$0389;  // GREEK CAPITAL LETTER ETA WITH TONOS
    $74: Result:= #$00A0;  // NO-BREAK SPACE
    $75: Result:= #$038A;  // GREEK CAPITAL LETTER IOTA WITH TONOS
    $76: Result:= #$038C;  // GREEK CAPITAL LETTER OMICRON WITH TONOS
    $77: Result:= #$038E;  // GREEK CAPITAL LETTER UPSILON WITH TONOS
    $78: Result:= #$038F;  // GREEK CAPITAL LETTER OMEGA WITH TONOS
    $79: Result:= #$0060;  // GRAVE ACCENT
    $7A: Result:= #$003A;  // COLON
    $7B: Result:= #$0023;  // NUMBER SIGN
    $7C: Result:= #$0040;  // COMMERCIAL AT
    $7D: Result:= #$0027;  // APOSTROPHE
    $7E: Result:= #$003D;  // EQUALS SIGN
    $7F: Result:= #$0022;  // QUOTATION MARK
    $80: Result:= #$0385;  // GREEK DIALYTIKA TONOS
    $81: Result:= #$0061;  // LATIN SMALL LETTER A
    $82: Result:= #$0062;  // LATIN SMALL LETTER B
    $83: Result:= #$0063;  // LATIN SMALL LETTER C
    $84: Result:= #$0064;  // LATIN SMALL LETTER D
    $85: Result:= #$0065;  // LATIN SMALL LETTER E
    $86: Result:= #$0066;  // LATIN SMALL LETTER F
    $87: Result:= #$0067;  // LATIN SMALL LETTER G
    $88: Result:= #$0068;  // LATIN SMALL LETTER H
    $89: Result:= #$0069;  // LATIN SMALL LETTER I
    $8A: Result:= #$03B1;  // GREEK SMALL LETTER ALPHA
    $8B: Result:= #$03B2;  // GREEK SMALL LETTER BETA
    $8C: Result:= #$03B3;  // GREEK SMALL LETTER GAMMA
    $8D: Result:= #$03B4;  // GREEK SMALL LETTER DELTA
    $8E: Result:= #$03B5;  // GREEK SMALL LETTER EPSILON
    $8F: Result:= #$03B6;  // GREEK SMALL LETTER ZETA
    $90: Result:= #$00B0;  // DEGREE SIGN
    $91: Result:= #$006A;  // LATIN SMALL LETTER J
    $92: Result:= #$006B;  // LATIN SMALL LETTER K
    $93: Result:= #$006C;  // LATIN SMALL LETTER L
    $94: Result:= #$006D;  // LATIN SMALL LETTER M
    $95: Result:= #$006E;  // LATIN SMALL LETTER N
    $96: Result:= #$006F;  // LATIN SMALL LETTER O
    $97: Result:= #$0070;  // LATIN SMALL LETTER P
    $98: Result:= #$0071;  // LATIN SMALL LETTER Q
    $99: Result:= #$0072;  // LATIN SMALL LETTER R
    $9A: Result:= #$03B7;  // GREEK SMALL LETTER ETA
    $9B: Result:= #$03B8;  // GREEK SMALL LETTER THETA
    $9C: Result:= #$03B9;  // GREEK SMALL LETTER IOTA
    $9D: Result:= #$03BA;  // GREEK SMALL LETTER KAPPA
    $9E: Result:= #$03BB;  // GREEK SMALL LETTER LAMDA
    $9F: Result:= #$03BC;  // GREEK SMALL LETTER MU
    $A0: Result:= #$00B4;  // ACUTE ACCENT
    $A1: Result:= #$007E;  // TILDE
    $A2: Result:= #$0073;  // LATIN SMALL LETTER S
    $A3: Result:= #$0074;  // LATIN SMALL LETTER T
    $A4: Result:= #$0075;  // LATIN SMALL LETTER U
    $A5: Result:= #$0076;  // LATIN SMALL LETTER V
    $A6: Result:= #$0077;  // LATIN SMALL LETTER W
    $A7: Result:= #$0078;  // LATIN SMALL LETTER X
    $A8: Result:= #$0079;  // LATIN SMALL LETTER Y
    $A9: Result:= #$007A;  // LATIN SMALL LETTER Z
    $AA: Result:= #$03BD;  // GREEK SMALL LETTER NU
    $AB: Result:= #$03BE;  // GREEK SMALL LETTER XI
    $AC: Result:= #$03BF;  // GREEK SMALL LETTER OMICRON
    $AD: Result:= #$03C0;  // GREEK SMALL LETTER PI
    $AE: Result:= #$03C1;  // GREEK SMALL LETTER RHO
    $AF: Result:= #$03C3;  // GREEK SMALL LETTER SIGMA
    $B0: Result:= #$00A3;  // POUND SIGN
    $B1: Result:= #$03AC;  // GREEK SMALL LETTER ALPHA WITH TONOS
    $B2: Result:= #$03AD;  // GREEK SMALL LETTER EPSILON WITH TONOS
    $B3: Result:= #$03AE;  // GREEK SMALL LETTER ETA WITH TONOS
    $B4: Result:= #$03CA;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA
    $B5: Result:= #$03AF;  // GREEK SMALL LETTER IOTA WITH TONOS
    $B6: Result:= #$03CC;  // GREEK SMALL LETTER OMICRON WITH TONOS
    $B7: Result:= #$03CD;  // GREEK SMALL LETTER UPSILON WITH TONOS
    $B8: Result:= #$03CB;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA
    $B9: Result:= #$03CE;  // GREEK SMALL LETTER OMEGA WITH TONOS
    $BA: Result:= #$03C2;  // GREEK SMALL LETTER FINAL SIGMA
    $BB: Result:= #$03C4;  // GREEK SMALL LETTER TAU
    $BC: Result:= #$03C5;  // GREEK SMALL LETTER UPSILON
    $BD: Result:= #$03C6;  // GREEK SMALL LETTER PHI
    $BE: Result:= #$03C7;  // GREEK SMALL LETTER CHI
    $BF: Result:= #$03C8;  // GREEK SMALL LETTER PSI
    $C0: Result:= #$007B;  // LEFT CURLY BRACKET
    $C1: Result:= #$0041;  // LATIN CAPITAL LETTER A
    $C2: Result:= #$0042;  // LATIN CAPITAL LETTER B
    $C3: Result:= #$0043;  // LATIN CAPITAL LETTER C
    $C4: Result:= #$0044;  // LATIN CAPITAL LETTER D
    $C5: Result:= #$0045;  // LATIN CAPITAL LETTER E
    $C6: Result:= #$0046;  // LATIN CAPITAL LETTER F
    $C7: Result:= #$0047;  // LATIN CAPITAL LETTER G
    $C8: Result:= #$0048;  // LATIN CAPITAL LETTER H
    $C9: Result:= #$0049;  // LATIN CAPITAL LETTER I
    $CA: Result:= #$00AD;  // SOFT HYPHEN
    $CB: Result:= #$03C9;  // GREEK SMALL LETTER OMEGA
    $CC: Result:= #$0390;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA AND TONOS
    $CD: Result:= #$03B0;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA AND TONOS
    $CE: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $CF: Result:= #$2015;  // HORIZONTAL BAR
    $D0: Result:= #$007D;  // RIGHT CURLY BRACKET
    $D1: Result:= #$004A;  // LATIN CAPITAL LETTER J
    $D2: Result:= #$004B;  // LATIN CAPITAL LETTER K
    $D3: Result:= #$004C;  // LATIN CAPITAL LETTER L
    $D4: Result:= #$004D;  // LATIN CAPITAL LETTER M
    $D5: Result:= #$004E;  // LATIN CAPITAL LETTER N
    $D6: Result:= #$004F;  // LATIN CAPITAL LETTER O
    $D7: Result:= #$0050;  // LATIN CAPITAL LETTER P
    $D8: Result:= #$0051;  // LATIN CAPITAL LETTER Q
    $D9: Result:= #$0052;  // LATIN CAPITAL LETTER R
    $DA: Result:= #$00B1;  // PLUS-MINUS SIGN
    $DB: Result:= #$00BD;  // VULGAR FRACTION ONE HALF
    $DC: Result:= #$001A;  // SUBSTITUTE
    $DD: Result:= #$0387;  // GREEK ANO TELEIA
    $DE: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $DF: Result:= #$00A6;  // BROKEN BAR
    $E0: Result:= #$005C;  // REVERSE SOLIDUS
    $E1: Result:= #$001A;  // SUBSTITUTE
    $E2: Result:= #$0053;  // LATIN CAPITAL LETTER S
    $E3: Result:= #$0054;  // LATIN CAPITAL LETTER T
    $E4: Result:= #$0055;  // LATIN CAPITAL LETTER U
    $E5: Result:= #$0056;  // LATIN CAPITAL LETTER V
    $E6: Result:= #$0057;  // LATIN CAPITAL LETTER W
    $E7: Result:= #$0058;  // LATIN CAPITAL LETTER X
    $E8: Result:= #$0059;  // LATIN CAPITAL LETTER Y
    $E9: Result:= #$005A;  // LATIN CAPITAL LETTER Z
    $EA: Result:= #$00B2;  // SUPERSCRIPT TWO
    $EB: Result:= #$00A7;  // SECTION SIGN
    $EC: Result:= #$001A;  // SUBSTITUTE
    $ED: Result:= #$001A;  // SUBSTITUTE
    $EE: Result:= #$00AB;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $EF: Result:= #$00AC;  // NOT SIGN
    $F0: Result:= #$0030;  // DIGIT ZERO
    $F1: Result:= #$0031;  // DIGIT ONE
    $F2: Result:= #$0032;  // DIGIT TWO
    $F3: Result:= #$0033;  // DIGIT THREE
    $F4: Result:= #$0034;  // DIGIT FOUR
    $F5: Result:= #$0035;  // DIGIT FIVE
    $F6: Result:= #$0036;  // DIGIT SIX
    $F7: Result:= #$0037;  // DIGIT SEVEN
    $F8: Result:= #$0038;  // DIGIT EIGHT
    $F9: Result:= #$0039;  // DIGIT NINE
    $FA: Result:= #$00B3;  // SUPERSCRIPT THREE
    $FB: Result:= #$00A9;  // COPYRIGHT SIGN
    $FC: Result:= #$001A;  // SUBSTITUTE
    $FD: Result:= #$001A;  // SUBSTITUTE
    $FE: Result:= #$00BB;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $FF: Result:= #$009F;  // CONTROL
  else
    raise EConvertError.CreateFmt('Invalid Windows-875 sequence of code point %d',[W]);
  end;
end;

function cp932ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A0: Result:= WideChar(W);
    $80: Result:= #$20AC;  // EURO SIGN
    $85: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $91: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $94: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $95: Result:= #$2022;  // BULLET
    $96: Result:= #$2013;  // EN DASH
    $97: Result:= #$2014;  // EM DASH
    $A1: Result:= #$0E01;  // THAI CHARACTER KO KAI
    $A2: Result:= #$0E02;  // THAI CHARACTER KHO KHAI
    $A3: Result:= #$0E03;  // THAI CHARACTER KHO KHUAT
    $A4: Result:= #$0E04;  // THAI CHARACTER KHO KHWAI
    $A5: Result:= #$0E05;  // THAI CHARACTER KHO KHON
    $A6: Result:= #$0E06;  // THAI CHARACTER KHO RAKHANG
    $A7: Result:= #$0E07;  // THAI CHARACTER NGO NGU
    $A8: Result:= #$0E08;  // THAI CHARACTER CHO CHAN
    $A9: Result:= #$0E09;  // THAI CHARACTER CHO CHING
    $AA: Result:= #$0E0A;  // THAI CHARACTER CHO CHANG
    $AB: Result:= #$0E0B;  // THAI CHARACTER SO SO
    $AC: Result:= #$0E0C;  // THAI CHARACTER CHO CHOE
    $AD: Result:= #$0E0D;  // THAI CHARACTER YO YING
    $AE: Result:= #$0E0E;  // THAI CHARACTER DO CHADA
    $AF: Result:= #$0E0F;  // THAI CHARACTER TO PATAK
    $B0: Result:= #$0E10;  // THAI CHARACTER THO THAN
    $B1: Result:= #$0E11;  // THAI CHARACTER THO NANGMONTHO
    $B2: Result:= #$0E12;  // THAI CHARACTER THO PHUTHAO
    $B3: Result:= #$0E13;  // THAI CHARACTER NO NEN
    $B4: Result:= #$0E14;  // THAI CHARACTER DO DEK
    $B5: Result:= #$0E15;  // THAI CHARACTER TO TAO
    $B6: Result:= #$0E16;  // THAI CHARACTER THO THUNG
    $B7: Result:= #$0E17;  // THAI CHARACTER THO THAHAN
    $B8: Result:= #$0E18;  // THAI CHARACTER THO THONG
    $B9: Result:= #$0E19;  // THAI CHARACTER NO NU
    $BA: Result:= #$0E1A;  // THAI CHARACTER BO BAIMAI
    $BB: Result:= #$0E1B;  // THAI CHARACTER PO PLA
    $BC: Result:= #$0E1C;  // THAI CHARACTER PHO PHUNG
    $BD: Result:= #$0E1D;  // THAI CHARACTER FO FA
    $BE: Result:= #$0E1E;  // THAI CHARACTER PHO PHAN
    $BF: Result:= #$0E1F;  // THAI CHARACTER FO FAN
    $C0: Result:= #$0E20;  // THAI CHARACTER PHO SAMPHAO
    $C1: Result:= #$0E21;  // THAI CHARACTER MO MA
    $C2: Result:= #$0E22;  // THAI CHARACTER YO YAK
    $C3: Result:= #$0E23;  // THAI CHARACTER RO RUA
    $C4: Result:= #$0E24;  // THAI CHARACTER RU
    $C5: Result:= #$0E25;  // THAI CHARACTER LO LING
    $C6: Result:= #$0E26;  // THAI CHARACTER LU
    $C7: Result:= #$0E27;  // THAI CHARACTER WO WAEN
    $C8: Result:= #$0E28;  // THAI CHARACTER SO SALA
    $C9: Result:= #$0E29;  // THAI CHARACTER SO RUSI
    $CA: Result:= #$0E2A;  // THAI CHARACTER SO SUA
    $CB: Result:= #$0E2B;  // THAI CHARACTER HO HIP
    $CC: Result:= #$0E2C;  // THAI CHARACTER LO CHULA
    $CD: Result:= #$0E2D;  // THAI CHARACTER O ANG
    $CE: Result:= #$0E2E;  // THAI CHARACTER HO NOKHUK
    $CF: Result:= #$0E2F;  // THAI CHARACTER PAIYANNOI
    $D0: Result:= #$0E30;  // THAI CHARACTER SARA A
    $D1: Result:= #$0E31;  // THAI CHARACTER MAI HAN-AKAT
    $D2: Result:= #$0E32;  // THAI CHARACTER SARA AA
    $D3: Result:= #$0E33;  // THAI CHARACTER SARA AM
    $D4: Result:= #$0E34;  // THAI CHARACTER SARA I
    $D5: Result:= #$0E35;  // THAI CHARACTER SARA II
    $D6: Result:= #$0E36;  // THAI CHARACTER SARA UE
    $D7: Result:= #$0E37;  // THAI CHARACTER SARA UEE
    $D8: Result:= #$0E38;  // THAI CHARACTER SARA U
    $D9: Result:= #$0E39;  // THAI CHARACTER SARA UU
    $DA: Result:= #$0E3A;  // THAI CHARACTER PHINTHU
    $DF: Result:= #$0E3F;  // THAI CURRENCY SYMBOL BAHT
    $E0: Result:= #$0E40;  // THAI CHARACTER SARA E
    $E1: Result:= #$0E41;  // THAI CHARACTER SARA AE
    $E2: Result:= #$0E42;  // THAI CHARACTER SARA O
    $E3: Result:= #$0E43;  // THAI CHARACTER SARA AI MAIMUAN
    $E4: Result:= #$0E44;  // THAI CHARACTER SARA AI MAIMALAI
    $E5: Result:= #$0E45;  // THAI CHARACTER LAKKHANGYAO
    $E6: Result:= #$0E46;  // THAI CHARACTER MAIYAMOK
    $E7: Result:= #$0E47;  // THAI CHARACTER MAITAIKHU
    $E8: Result:= #$0E48;  // THAI CHARACTER MAI EK
    $E9: Result:= #$0E49;  // THAI CHARACTER MAI THO
    $EA: Result:= #$0E4A;  // THAI CHARACTER MAI TRI
    $EB: Result:= #$0E4B;  // THAI CHARACTER MAI CHATTAWA
    $EC: Result:= #$0E4C;  // THAI CHARACTER THANTHAKHAT
    $ED: Result:= #$0E4D;  // THAI CHARACTER NIKHAHIT
    $EE: Result:= #$0E4E;  // THAI CHARACTER YAMAKKAN
    $EF: Result:= #$0E4F;  // THAI CHARACTER FONGMAN
    $F0: Result:= #$0E50;  // THAI DIGIT ZERO
    $F1: Result:= #$0E51;  // THAI DIGIT ONE
    $F2: Result:= #$0E52;  // THAI DIGIT TWO
    $F3: Result:= #$0E53;  // THAI DIGIT THREE
    $F4: Result:= #$0E54;  // THAI DIGIT FOUR
    $F5: Result:= #$0E55;  // THAI DIGIT FIVE
    $F6: Result:= #$0E56;  // THAI DIGIT SIX
    $F7: Result:= #$0E57;  // THAI DIGIT SEVEN
    $F8: Result:= #$0E58;  // THAI DIGIT EIGHT
    $F9: Result:= #$0E59;  // THAI DIGIT NINE
    $FA: Result:= #$0E5A;  // THAI CHARACTER ANGKHANKHU
    $FB: Result:= #$0E5B;  // THAI CHARACTER KHOMUT
  else
    raise EConvertError.CreateFmt('Invalid Windows-932 sequence of code point %d',[W]);
  end;
end;

function cp936ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A0: Result:= WideChar(W);
    $80: Result:= #$20AC;  // EURO SIGN
    $85: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $91: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $94: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $95: Result:= #$2022;  // BULLET
    $96: Result:= #$2013;  // EN DASH
    $97: Result:= #$2014;  // EM DASH
    $A1: Result:= #$0E01;  // THAI CHARACTER KO KAI
    $A2: Result:= #$0E02;  // THAI CHARACTER KHO KHAI
    $A3: Result:= #$0E03;  // THAI CHARACTER KHO KHUAT
    $A4: Result:= #$0E04;  // THAI CHARACTER KHO KHWAI
    $A5: Result:= #$0E05;  // THAI CHARACTER KHO KHON
    $A6: Result:= #$0E06;  // THAI CHARACTER KHO RAKHANG
    $A7: Result:= #$0E07;  // THAI CHARACTER NGO NGU
    $A8: Result:= #$0E08;  // THAI CHARACTER CHO CHAN
    $A9: Result:= #$0E09;  // THAI CHARACTER CHO CHING
    $AA: Result:= #$0E0A;  // THAI CHARACTER CHO CHANG
    $AB: Result:= #$0E0B;  // THAI CHARACTER SO SO
    $AC: Result:= #$0E0C;  // THAI CHARACTER CHO CHOE
    $AD: Result:= #$0E0D;  // THAI CHARACTER YO YING
    $AE: Result:= #$0E0E;  // THAI CHARACTER DO CHADA
    $AF: Result:= #$0E0F;  // THAI CHARACTER TO PATAK
    $B0: Result:= #$0E10;  // THAI CHARACTER THO THAN
    $B1: Result:= #$0E11;  // THAI CHARACTER THO NANGMONTHO
    $B2: Result:= #$0E12;  // THAI CHARACTER THO PHUTHAO
    $B3: Result:= #$0E13;  // THAI CHARACTER NO NEN
    $B4: Result:= #$0E14;  // THAI CHARACTER DO DEK
    $B5: Result:= #$0E15;  // THAI CHARACTER TO TAO
    $B6: Result:= #$0E16;  // THAI CHARACTER THO THUNG
    $B7: Result:= #$0E17;  // THAI CHARACTER THO THAHAN
    $B8: Result:= #$0E18;  // THAI CHARACTER THO THONG
    $B9: Result:= #$0E19;  // THAI CHARACTER NO NU
    $BA: Result:= #$0E1A;  // THAI CHARACTER BO BAIMAI
    $BB: Result:= #$0E1B;  // THAI CHARACTER PO PLA
    $BC: Result:= #$0E1C;  // THAI CHARACTER PHO PHUNG
    $BD: Result:= #$0E1D;  // THAI CHARACTER FO FA
    $BE: Result:= #$0E1E;  // THAI CHARACTER PHO PHAN
    $BF: Result:= #$0E1F;  // THAI CHARACTER FO FAN
    $C0: Result:= #$0E20;  // THAI CHARACTER PHO SAMPHAO
    $C1: Result:= #$0E21;  // THAI CHARACTER MO MA
    $C2: Result:= #$0E22;  // THAI CHARACTER YO YAK
    $C3: Result:= #$0E23;  // THAI CHARACTER RO RUA
    $C4: Result:= #$0E24;  // THAI CHARACTER RU
    $C5: Result:= #$0E25;  // THAI CHARACTER LO LING
    $C6: Result:= #$0E26;  // THAI CHARACTER LU
    $C7: Result:= #$0E27;  // THAI CHARACTER WO WAEN
    $C8: Result:= #$0E28;  // THAI CHARACTER SO SALA
    $C9: Result:= #$0E29;  // THAI CHARACTER SO RUSI
    $CA: Result:= #$0E2A;  // THAI CHARACTER SO SUA
    $CB: Result:= #$0E2B;  // THAI CHARACTER HO HIP
    $CC: Result:= #$0E2C;  // THAI CHARACTER LO CHULA
    $CD: Result:= #$0E2D;  // THAI CHARACTER O ANG
    $CE: Result:= #$0E2E;  // THAI CHARACTER HO NOKHUK
    $CF: Result:= #$0E2F;  // THAI CHARACTER PAIYANNOI
    $D0: Result:= #$0E30;  // THAI CHARACTER SARA A
    $D1: Result:= #$0E31;  // THAI CHARACTER MAI HAN-AKAT
    $D2: Result:= #$0E32;  // THAI CHARACTER SARA AA
    $D3: Result:= #$0E33;  // THAI CHARACTER SARA AM
    $D4: Result:= #$0E34;  // THAI CHARACTER SARA I
    $D5: Result:= #$0E35;  // THAI CHARACTER SARA II
    $D6: Result:= #$0E36;  // THAI CHARACTER SARA UE
    $D7: Result:= #$0E37;  // THAI CHARACTER SARA UEE
    $D8: Result:= #$0E38;  // THAI CHARACTER SARA U
    $D9: Result:= #$0E39;  // THAI CHARACTER SARA UU
    $DA: Result:= #$0E3A;  // THAI CHARACTER PHINTHU
    $DF: Result:= #$0E3F;  // THAI CURRENCY SYMBOL BAHT
    $E0: Result:= #$0E40;  // THAI CHARACTER SARA E
    $E1: Result:= #$0E41;  // THAI CHARACTER SARA AE
    $E2: Result:= #$0E42;  // THAI CHARACTER SARA O
    $E3: Result:= #$0E43;  // THAI CHARACTER SARA AI MAIMUAN
    $E4: Result:= #$0E44;  // THAI CHARACTER SARA AI MAIMALAI
    $E5: Result:= #$0E45;  // THAI CHARACTER LAKKHANGYAO
    $E6: Result:= #$0E46;  // THAI CHARACTER MAIYAMOK
    $E7: Result:= #$0E47;  // THAI CHARACTER MAITAIKHU
    $E8: Result:= #$0E48;  // THAI CHARACTER MAI EK
    $E9: Result:= #$0E49;  // THAI CHARACTER MAI THO
    $EA: Result:= #$0E4A;  // THAI CHARACTER MAI TRI
    $EB: Result:= #$0E4B;  // THAI CHARACTER MAI CHATTAWA
    $EC: Result:= #$0E4C;  // THAI CHARACTER THANTHAKHAT
    $ED: Result:= #$0E4D;  // THAI CHARACTER NIKHAHIT
    $EE: Result:= #$0E4E;  // THAI CHARACTER YAMAKKAN
    $EF: Result:= #$0E4F;  // THAI CHARACTER FONGMAN
    $F0: Result:= #$0E50;  // THAI DIGIT ZERO
    $F1: Result:= #$0E51;  // THAI DIGIT ONE
    $F2: Result:= #$0E52;  // THAI DIGIT TWO
    $F3: Result:= #$0E53;  // THAI DIGIT THREE
    $F4: Result:= #$0E54;  // THAI DIGIT FOUR
    $F5: Result:= #$0E55;  // THAI DIGIT FIVE
    $F6: Result:= #$0E56;  // THAI DIGIT SIX
    $F7: Result:= #$0E57;  // THAI DIGIT SEVEN
    $F8: Result:= #$0E58;  // THAI DIGIT EIGHT
    $F9: Result:= #$0E59;  // THAI DIGIT NINE
    $FA: Result:= #$0E5A;  // THAI CHARACTER ANGKHANKHU
    $FB: Result:= #$0E5B;  // THAI CHARACTER KHOMUT
  else
    raise EConvertError.CreateFmt('Invalid Windows-936 sequence of code point %d',[W]);
  end;
end;

function cp949ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A0: Result:= WideChar(W);
    $80: Result:= #$20AC;  // EURO SIGN
    $85: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $91: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $94: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $95: Result:= #$2022;  // BULLET
    $96: Result:= #$2013;  // EN DASH
    $97: Result:= #$2014;  // EM DASH
    $A1: Result:= #$0E01;  // THAI CHARACTER KO KAI
    $A2: Result:= #$0E02;  // THAI CHARACTER KHO KHAI
    $A3: Result:= #$0E03;  // THAI CHARACTER KHO KHUAT
    $A4: Result:= #$0E04;  // THAI CHARACTER KHO KHWAI
    $A5: Result:= #$0E05;  // THAI CHARACTER KHO KHON
    $A6: Result:= #$0E06;  // THAI CHARACTER KHO RAKHANG
    $A7: Result:= #$0E07;  // THAI CHARACTER NGO NGU
    $A8: Result:= #$0E08;  // THAI CHARACTER CHO CHAN
    $A9: Result:= #$0E09;  // THAI CHARACTER CHO CHING
    $AA: Result:= #$0E0A;  // THAI CHARACTER CHO CHANG
    $AB: Result:= #$0E0B;  // THAI CHARACTER SO SO
    $AC: Result:= #$0E0C;  // THAI CHARACTER CHO CHOE
    $AD: Result:= #$0E0D;  // THAI CHARACTER YO YING
    $AE: Result:= #$0E0E;  // THAI CHARACTER DO CHADA
    $AF: Result:= #$0E0F;  // THAI CHARACTER TO PATAK
    $B0: Result:= #$0E10;  // THAI CHARACTER THO THAN
    $B1: Result:= #$0E11;  // THAI CHARACTER THO NANGMONTHO
    $B2: Result:= #$0E12;  // THAI CHARACTER THO PHUTHAO
    $B3: Result:= #$0E13;  // THAI CHARACTER NO NEN
    $B4: Result:= #$0E14;  // THAI CHARACTER DO DEK
    $B5: Result:= #$0E15;  // THAI CHARACTER TO TAO
    $B6: Result:= #$0E16;  // THAI CHARACTER THO THUNG
    $B7: Result:= #$0E17;  // THAI CHARACTER THO THAHAN
    $B8: Result:= #$0E18;  // THAI CHARACTER THO THONG
    $B9: Result:= #$0E19;  // THAI CHARACTER NO NU
    $BA: Result:= #$0E1A;  // THAI CHARACTER BO BAIMAI
    $BB: Result:= #$0E1B;  // THAI CHARACTER PO PLA
    $BC: Result:= #$0E1C;  // THAI CHARACTER PHO PHUNG
    $BD: Result:= #$0E1D;  // THAI CHARACTER FO FA
    $BE: Result:= #$0E1E;  // THAI CHARACTER PHO PHAN
    $BF: Result:= #$0E1F;  // THAI CHARACTER FO FAN
    $C0: Result:= #$0E20;  // THAI CHARACTER PHO SAMPHAO
    $C1: Result:= #$0E21;  // THAI CHARACTER MO MA
    $C2: Result:= #$0E22;  // THAI CHARACTER YO YAK
    $C3: Result:= #$0E23;  // THAI CHARACTER RO RUA
    $C4: Result:= #$0E24;  // THAI CHARACTER RU
    $C5: Result:= #$0E25;  // THAI CHARACTER LO LING
    $C6: Result:= #$0E26;  // THAI CHARACTER LU
    $C7: Result:= #$0E27;  // THAI CHARACTER WO WAEN
    $C8: Result:= #$0E28;  // THAI CHARACTER SO SALA
    $C9: Result:= #$0E29;  // THAI CHARACTER SO RUSI
    $CA: Result:= #$0E2A;  // THAI CHARACTER SO SUA
    $CB: Result:= #$0E2B;  // THAI CHARACTER HO HIP
    $CC: Result:= #$0E2C;  // THAI CHARACTER LO CHULA
    $CD: Result:= #$0E2D;  // THAI CHARACTER O ANG
    $CE: Result:= #$0E2E;  // THAI CHARACTER HO NOKHUK
    $CF: Result:= #$0E2F;  // THAI CHARACTER PAIYANNOI
    $D0: Result:= #$0E30;  // THAI CHARACTER SARA A
    $D1: Result:= #$0E31;  // THAI CHARACTER MAI HAN-AKAT
    $D2: Result:= #$0E32;  // THAI CHARACTER SARA AA
    $D3: Result:= #$0E33;  // THAI CHARACTER SARA AM
    $D4: Result:= #$0E34;  // THAI CHARACTER SARA I
    $D5: Result:= #$0E35;  // THAI CHARACTER SARA II
    $D6: Result:= #$0E36;  // THAI CHARACTER SARA UE
    $D7: Result:= #$0E37;  // THAI CHARACTER SARA UEE
    $D8: Result:= #$0E38;  // THAI CHARACTER SARA U
    $D9: Result:= #$0E39;  // THAI CHARACTER SARA UU
    $DA: Result:= #$0E3A;  // THAI CHARACTER PHINTHU
    $DF: Result:= #$0E3F;  // THAI CURRENCY SYMBOL BAHT
    $E0: Result:= #$0E40;  // THAI CHARACTER SARA E
    $E1: Result:= #$0E41;  // THAI CHARACTER SARA AE
    $E2: Result:= #$0E42;  // THAI CHARACTER SARA O
    $E3: Result:= #$0E43;  // THAI CHARACTER SARA AI MAIMUAN
    $E4: Result:= #$0E44;  // THAI CHARACTER SARA AI MAIMALAI
    $E5: Result:= #$0E45;  // THAI CHARACTER LAKKHANGYAO
    $E6: Result:= #$0E46;  // THAI CHARACTER MAIYAMOK
    $E7: Result:= #$0E47;  // THAI CHARACTER MAITAIKHU
    $E8: Result:= #$0E48;  // THAI CHARACTER MAI EK
    $E9: Result:= #$0E49;  // THAI CHARACTER MAI THO
    $EA: Result:= #$0E4A;  // THAI CHARACTER MAI TRI
    $EB: Result:= #$0E4B;  // THAI CHARACTER MAI CHATTAWA
    $EC: Result:= #$0E4C;  // THAI CHARACTER THANTHAKHAT
    $ED: Result:= #$0E4D;  // THAI CHARACTER NIKHAHIT
    $EE: Result:= #$0E4E;  // THAI CHARACTER YAMAKKAN
    $EF: Result:= #$0E4F;  // THAI CHARACTER FONGMAN
    $F0: Result:= #$0E50;  // THAI DIGIT ZERO
    $F1: Result:= #$0E51;  // THAI DIGIT ONE
    $F2: Result:= #$0E52;  // THAI DIGIT TWO
    $F3: Result:= #$0E53;  // THAI DIGIT THREE
    $F4: Result:= #$0E54;  // THAI DIGIT FOUR
    $F5: Result:= #$0E55;  // THAI DIGIT FIVE
    $F6: Result:= #$0E56;  // THAI DIGIT SIX
    $F7: Result:= #$0E57;  // THAI DIGIT SEVEN
    $F8: Result:= #$0E58;  // THAI DIGIT EIGHT
    $F9: Result:= #$0E59;  // THAI DIGIT NINE
    $FA: Result:= #$0E5A;  // THAI CHARACTER ANGKHANKHU
    $FB: Result:= #$0E5B;  // THAI CHARACTER KHOMUT
  else
    raise EConvertError.CreateFmt('Invalid Windows-949 sequence of code point %d',[W]);
  end;
end;

function cp950ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A0: Result:= WideChar(W);
    $80: Result:= #$20AC;  // EURO SIGN
    $85: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $91: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $94: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $95: Result:= #$2022;  // BULLET
    $96: Result:= #$2013;  // EN DASH
    $97: Result:= #$2014;  // EM DASH
    $A1: Result:= #$0E01;  // THAI CHARACTER KO KAI
    $A2: Result:= #$0E02;  // THAI CHARACTER KHO KHAI
    $A3: Result:= #$0E03;  // THAI CHARACTER KHO KHUAT
    $A4: Result:= #$0E04;  // THAI CHARACTER KHO KHWAI
    $A5: Result:= #$0E05;  // THAI CHARACTER KHO KHON
    $A6: Result:= #$0E06;  // THAI CHARACTER KHO RAKHANG
    $A7: Result:= #$0E07;  // THAI CHARACTER NGO NGU
    $A8: Result:= #$0E08;  // THAI CHARACTER CHO CHAN
    $A9: Result:= #$0E09;  // THAI CHARACTER CHO CHING
    $AA: Result:= #$0E0A;  // THAI CHARACTER CHO CHANG
    $AB: Result:= #$0E0B;  // THAI CHARACTER SO SO
    $AC: Result:= #$0E0C;  // THAI CHARACTER CHO CHOE
    $AD: Result:= #$0E0D;  // THAI CHARACTER YO YING
    $AE: Result:= #$0E0E;  // THAI CHARACTER DO CHADA
    $AF: Result:= #$0E0F;  // THAI CHARACTER TO PATAK
    $B0: Result:= #$0E10;  // THAI CHARACTER THO THAN
    $B1: Result:= #$0E11;  // THAI CHARACTER THO NANGMONTHO
    $B2: Result:= #$0E12;  // THAI CHARACTER THO PHUTHAO
    $B3: Result:= #$0E13;  // THAI CHARACTER NO NEN
    $B4: Result:= #$0E14;  // THAI CHARACTER DO DEK
    $B5: Result:= #$0E15;  // THAI CHARACTER TO TAO
    $B6: Result:= #$0E16;  // THAI CHARACTER THO THUNG
    $B7: Result:= #$0E17;  // THAI CHARACTER THO THAHAN
    $B8: Result:= #$0E18;  // THAI CHARACTER THO THONG
    $B9: Result:= #$0E19;  // THAI CHARACTER NO NU
    $BA: Result:= #$0E1A;  // THAI CHARACTER BO BAIMAI
    $BB: Result:= #$0E1B;  // THAI CHARACTER PO PLA
    $BC: Result:= #$0E1C;  // THAI CHARACTER PHO PHUNG
    $BD: Result:= #$0E1D;  // THAI CHARACTER FO FA
    $BE: Result:= #$0E1E;  // THAI CHARACTER PHO PHAN
    $BF: Result:= #$0E1F;  // THAI CHARACTER FO FAN
    $C0: Result:= #$0E20;  // THAI CHARACTER PHO SAMPHAO
    $C1: Result:= #$0E21;  // THAI CHARACTER MO MA
    $C2: Result:= #$0E22;  // THAI CHARACTER YO YAK
    $C3: Result:= #$0E23;  // THAI CHARACTER RO RUA
    $C4: Result:= #$0E24;  // THAI CHARACTER RU
    $C5: Result:= #$0E25;  // THAI CHARACTER LO LING
    $C6: Result:= #$0E26;  // THAI CHARACTER LU
    $C7: Result:= #$0E27;  // THAI CHARACTER WO WAEN
    $C8: Result:= #$0E28;  // THAI CHARACTER SO SALA
    $C9: Result:= #$0E29;  // THAI CHARACTER SO RUSI
    $CA: Result:= #$0E2A;  // THAI CHARACTER SO SUA
    $CB: Result:= #$0E2B;  // THAI CHARACTER HO HIP
    $CC: Result:= #$0E2C;  // THAI CHARACTER LO CHULA
    $CD: Result:= #$0E2D;  // THAI CHARACTER O ANG
    $CE: Result:= #$0E2E;  // THAI CHARACTER HO NOKHUK
    $CF: Result:= #$0E2F;  // THAI CHARACTER PAIYANNOI
    $D0: Result:= #$0E30;  // THAI CHARACTER SARA A
    $D1: Result:= #$0E31;  // THAI CHARACTER MAI HAN-AKAT
    $D2: Result:= #$0E32;  // THAI CHARACTER SARA AA
    $D3: Result:= #$0E33;  // THAI CHARACTER SARA AM
    $D4: Result:= #$0E34;  // THAI CHARACTER SARA I
    $D5: Result:= #$0E35;  // THAI CHARACTER SARA II
    $D6: Result:= #$0E36;  // THAI CHARACTER SARA UE
    $D7: Result:= #$0E37;  // THAI CHARACTER SARA UEE
    $D8: Result:= #$0E38;  // THAI CHARACTER SARA U
    $D9: Result:= #$0E39;  // THAI CHARACTER SARA UU
    $DA: Result:= #$0E3A;  // THAI CHARACTER PHINTHU
    $DF: Result:= #$0E3F;  // THAI CURRENCY SYMBOL BAHT
    $E0: Result:= #$0E40;  // THAI CHARACTER SARA E
    $E1: Result:= #$0E41;  // THAI CHARACTER SARA AE
    $E2: Result:= #$0E42;  // THAI CHARACTER SARA O
    $E3: Result:= #$0E43;  // THAI CHARACTER SARA AI MAIMUAN
    $E4: Result:= #$0E44;  // THAI CHARACTER SARA AI MAIMALAI
    $E5: Result:= #$0E45;  // THAI CHARACTER LAKKHANGYAO
    $E6: Result:= #$0E46;  // THAI CHARACTER MAIYAMOK
    $E7: Result:= #$0E47;  // THAI CHARACTER MAITAIKHU
    $E8: Result:= #$0E48;  // THAI CHARACTER MAI EK
    $E9: Result:= #$0E49;  // THAI CHARACTER MAI THO
    $EA: Result:= #$0E4A;  // THAI CHARACTER MAI TRI
    $EB: Result:= #$0E4B;  // THAI CHARACTER MAI CHATTAWA
    $EC: Result:= #$0E4C;  // THAI CHARACTER THANTHAKHAT
    $ED: Result:= #$0E4D;  // THAI CHARACTER NIKHAHIT
    $EE: Result:= #$0E4E;  // THAI CHARACTER YAMAKKAN
    $EF: Result:= #$0E4F;  // THAI CHARACTER FONGMAN
    $F0: Result:= #$0E50;  // THAI DIGIT ZERO
    $F1: Result:= #$0E51;  // THAI DIGIT ONE
    $F2: Result:= #$0E52;  // THAI DIGIT TWO
    $F3: Result:= #$0E53;  // THAI DIGIT THREE
    $F4: Result:= #$0E54;  // THAI DIGIT FOUR
    $F5: Result:= #$0E55;  // THAI DIGIT FIVE
    $F6: Result:= #$0E56;  // THAI DIGIT SIX
    $F7: Result:= #$0E57;  // THAI DIGIT SEVEN
    $F8: Result:= #$0E58;  // THAI DIGIT EIGHT
    $F9: Result:= #$0E59;  // THAI DIGIT NINE
    $FA: Result:= #$0E5A;  // THAI CHARACTER ANGKHANKHU
    $FB: Result:= #$0E5B;  // THAI CHARACTER KHOMUT
  else
    raise EConvertError.CreateFmt('Invalid Windows-950 sequence of code point %d',[W]);
  end;
end;

function cp1006ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$A0,$AD: Result:= WideChar(W);
    $A1: Result:= #$06F0;  // EXTENDED ARABIC-INDIC DIGIT ZERO
    $A2: Result:= #$06F1;  // EXTENDED ARABIC-INDIC DIGIT ONE
    $A3: Result:= #$06F2;  // EXTENDED ARABIC-INDIC DIGIT TWO
    $A4: Result:= #$06F3;  // EXTENDED ARABIC-INDIC DIGIT THREE
    $A5: Result:= #$06F4;  // EXTENDED ARABIC-INDIC DIGIT FOUR
    $A6: Result:= #$06F5;  // EXTENDED ARABIC-INDIC DIGIT FIVE
    $A7: Result:= #$06F6;  // EXTENDED ARABIC-INDIC DIGIT SIX
    $A8: Result:= #$06F7;  // EXTENDED ARABIC-INDIC DIGIT SEVEN
    $A9: Result:= #$06F8;  // EXTENDED ARABIC-INDIC DIGIT EIGHT
    $AA: Result:= #$06F9;  // EXTENDED ARABIC-INDIC DIGIT NINE
    $AB: Result:= #$060C;  // ARABIC COMMA
    $AC: Result:= #$061B;  // ARABIC SEMICOLON
    $AE: Result:= #$061F;  // ARABIC QUESTION MARK
    $AF: Result:= #$FE81;  // ARABIC LETTER ALEF WITH MADDA ABOVE ISOLATED FORM
    $B0: Result:= #$FE8D;  // ARABIC LETTER ALEF ISOLATED FORM
    $B1: Result:= #$FE8E;  // ARABIC LETTER ALEF FINAL FORM
    $B2: Result:= #$FE8E;  // ARABIC LETTER ALEF FINAL FORM
    $B3: Result:= #$FE8F;  // ARABIC LETTER BEH ISOLATED FORM
    $B4: Result:= #$FE91;  // ARABIC LETTER BEH INITIAL FORM
    $B5: Result:= #$FB56;  // ARABIC LETTER PEH ISOLATED FORM
    $B6: Result:= #$FB58;  // ARABIC LETTER PEH INITIAL FORM
    $B7: Result:= #$FE93;  // ARABIC LETTER TEH MARBUTA ISOLATED FORM
    $B8: Result:= #$FE95;  // ARABIC LETTER TEH ISOLATED FORM
    $B9: Result:= #$FE97;  // ARABIC LETTER TEH INITIAL FORM
    $BA: Result:= #$FB66;  // ARABIC LETTER TTEH ISOLATED FORM
    $BB: Result:= #$FB68;  // ARABIC LETTER TTEH INITIAL FORM
    $BC: Result:= #$FE99;  // ARABIC LETTER THEH ISOLATED FORM
    $BD: Result:= #$FE9B;  // ARABIC LETTER THEH INITIAL FORM
    $BE: Result:= #$FE9D;  // ARABIC LETTER JEEM ISOLATED FORM
    $BF: Result:= #$FE9F;  // ARABIC LETTER JEEM INITIAL FORM
    $C0: Result:= #$FB7A;  // ARABIC LETTER TCHEH ISOLATED FORM
    $C1: Result:= #$FB7C;  // ARABIC LETTER TCHEH INITIAL FORM
    $C2: Result:= #$FEA1;  // ARABIC LETTER HAH ISOLATED FORM
    $C3: Result:= #$FEA3;  // ARABIC LETTER HAH INITIAL FORM
    $C4: Result:= #$FEA5;  // ARABIC LETTER KHAH ISOLATED FORM
    $C5: Result:= #$FEA7;  // ARABIC LETTER KHAH INITIAL FORM
    $C6: Result:= #$FEA9;  // ARABIC LETTER DAL ISOLATED FORM
    $C7: Result:= #$FB84;  // ARABIC LETTER DAHAL ISOLATED FORMN
    $C8: Result:= #$FEAB;  // ARABIC LETTER THAL ISOLATED FORM
    $C9: Result:= #$FEAD;  // ARABIC LETTER REH ISOLATED FORM
    $CA: Result:= #$FB8C;  // ARABIC LETTER RREH ISOLATED FORM
    $CB: Result:= #$FEAF;  // ARABIC LETTER ZAIN ISOLATED FORM
    $CC: Result:= #$FB8A;  // ARABIC LETTER JEH ISOLATED FORM
    $CD: Result:= #$FEB1;  // ARABIC LETTER SEEN ISOLATED FORM
    $CE: Result:= #$FEB3;  // ARABIC LETTER SEEN INITIAL FORM
    $CF: Result:= #$FEB5;  // ARABIC LETTER SHEEN ISOLATED FORM
    $D0: Result:= #$FEB7;  // ARABIC LETTER SHEEN INITIAL FORM
    $D1: Result:= #$FEB9;  // ARABIC LETTER SAD ISOLATED FORM
    $D2: Result:= #$FEBB;  // ARABIC LETTER SAD INITIAL FORM
    $D3: Result:= #$FEBD;  // ARABIC LETTER DAD ISOLATED FORM
    $D4: Result:= #$FEBF;  // ARABIC LETTER DAD INITIAL FORM
    $D5: Result:= #$FEC1;  // ARABIC LETTER TAH ISOLATED FORM
    $D6: Result:= #$FEC5;  // ARABIC LETTER ZAH ISOLATED FORM
    $D7: Result:= #$FEC9;  // ARABIC LETTER AIN ISOLATED FORM
    $D8: Result:= #$FECA;  // ARABIC LETTER AIN FINAL FORM
    $D9: Result:= #$FECB;  // ARABIC LETTER AIN INITIAL FORM
    $DA: Result:= #$FECC;  // ARABIC LETTER AIN MEDIAL FORM
    $DB: Result:= #$FECD;  // ARABIC LETTER GHAIN ISOLATED FORM
    $DC: Result:= #$FECE;  // ARABIC LETTER GHAIN FINAL FORM
    $DD: Result:= #$FECF;  // ARABIC LETTER GHAIN INITIAL FORM
    $DE: Result:= #$FED0;  // ARABIC LETTER GHAIN MEDIAL FORM
    $DF: Result:= #$FED1;  // ARABIC LETTER FEH ISOLATED FORM
    $E0: Result:= #$FED3;  // ARABIC LETTER FEH INITIAL FORM
    $E1: Result:= #$FED5;  // ARABIC LETTER QAF ISOLATED FORM
    $E2: Result:= #$FED7;  // ARABIC LETTER QAF INITIAL FORM
    $E3: Result:= #$FED9;  // ARABIC LETTER KAF ISOLATED FORM
    $E4: Result:= #$FEDB;  // ARABIC LETTER KAF INITIAL FORM
    $E5: Result:= #$FB92;  // ARABIC LETTER GAF ISOLATED FORM
    $E6: Result:= #$FB94;  // ARABIC LETTER GAF INITIAL FORM
    $E7: Result:= #$FEDD;  // ARABIC LETTER LAM ISOLATED FORM
    $E8: Result:= #$FEDF;  // ARABIC LETTER LAM INITIAL FORM
    $E9: Result:= #$FEE0;  // ARABIC LETTER LAM MEDIAL FORM
    $EA: Result:= #$FEE1;  // ARABIC LETTER MEEM ISOLATED FORM
    $EB: Result:= #$FEE3;  // ARABIC LETTER MEEM INITIAL FORM
    $EC: Result:= #$FB9E;  // ARABIC LETTER NOON GHUNNA ISOLATED FORM
    $ED: Result:= #$FEE5;  // ARABIC LETTER NOON ISOLATED FORM
    $EE: Result:= #$FEE7;  // ARABIC LETTER NOON INITIAL FORM
    $EF: Result:= #$FE85;  // ARABIC LETTER WAW WITH HAMZA ABOVE ISOLATED FORM
    $F0: Result:= #$FEED;  // ARABIC LETTER WAW ISOLATED FORM
    $F1: Result:= #$FBA6;  // ARABIC LETTER HEH GOAL ISOLATED FORM
    $F2: Result:= #$FBA8;  // ARABIC LETTER HEH GOAL INITIAL FORM
    $F3: Result:= #$FBA9;  // ARABIC LETTER HEH GOAL MEDIAL FORM
    $F4: Result:= #$FBAA;  // ARABIC LETTER HEH DOACHASHMEE ISOLATED FORM
    $F5: Result:= #$FE80;  // ARABIC LETTER HAMZA ISOLATED FORM
    $F6: Result:= #$FE89;  // ARABIC LETTER YEH WITH HAMZA ABOVE ISOLATED FORM
    $F7: Result:= #$FE8A;  // ARABIC LETTER YEH WITH HAMZA ABOVE FINAL FORM
    $F8: Result:= #$FE8B;  // ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM
    $F9: Result:= #$FEF1;  // ARABIC LETTER YEH ISOLATED FORM
    $FA: Result:= #$FEF2;  // ARABIC LETTER YEH FINAL FORM
    $FB: Result:= #$FEF3;  // ARABIC LETTER YEH INITIAL FORM
    $FC: Result:= #$FBB0;  // ARABIC LETTER YEH BARREE WITH HAMZA ABOVE ISOLATED FORM
    $FD: Result:= #$FBAE;  // ARABIC LETTER YEH BARREE ISOLATED FORM
    $FE: Result:= #$FE7C;  // ARABIC SHADDA ISOLATED FORM
    $FF: Result:= #$FE7D;  // ARABIC SHADDA MEDIAL FORM
  else
    raise EConvertError.CreateFmt('Invalid cp1006 sequence of code point %d',[W]);
  end;
end;

function cp1026ToUTF16Char(const W: word): WideChar;
begin
  case W of
    $00..$03,$0B..$13,$18..$19,$1C..$1F,$B6:
      Result:= WideChar(W);
    $04: Result:= #$009C;  // CONTROL
    $05: Result:= #$0009;  // HORIZONTAL TABULATION
    $06: Result:= #$0086;  // CONTROL
    $07: Result:= #$007F;  // DELETE
    $08: Result:= #$0097;  // CONTROL
    $09: Result:= #$008D;  // CONTROL
    $0A: Result:= #$008E;  // CONTROL
    $14: Result:= #$009D;  // CONTROL
    $15: Result:= #$0085;  // CONTROL
    $16: Result:= #$0008;  // BACKSPACE
    $17: Result:= #$0087;  // CONTROL
    $1A: Result:= #$0092;  // CONTROL
    $1B: Result:= #$008F;  // CONTROL
    $20: Result:= #$0080;  // CONTROL
    $21: Result:= #$0081;  // CONTROL
    $22: Result:= #$0082;  // CONTROL
    $23: Result:= #$0083;  // CONTROL
    $24: Result:= #$0084;  // CONTROL
    $25: Result:= #$000A;  // LINE FEED
    $26: Result:= #$0017;  // END OF TRANSMISSION BLOCK
    $27: Result:= #$001B;  // ESCAPE
    $28: Result:= #$0088;  // CONTROL
    $29: Result:= #$0089;  // CONTROL
    $2A: Result:= #$008A;  // CONTROL
    $2B: Result:= #$008B;  // CONTROL
    $2C: Result:= #$008C;  // CONTROL
    $2D: Result:= #$0005;  // ENQUIRY
    $2E: Result:= #$0006;  // ACKNOWLEDGE
    $2F: Result:= #$0007;  // BELL
    $30: Result:= #$0090;  // CONTROL
    $31: Result:= #$0091;  // CONTROL
    $32: Result:= #$0016;  // SYNCHRONOUS IDLE
    $33: Result:= #$0093;  // CONTROL
    $34: Result:= #$0094;  // CONTROL
    $35: Result:= #$0095;  // CONTROL
    $36: Result:= #$0096;  // CONTROL
    $37: Result:= #$0004;  // END OF TRANSMISSION
    $38: Result:= #$0098;  // CONTROL
    $39: Result:= #$0099;  // CONTROL
    $3A: Result:= #$009A;  // CONTROL
    $3B: Result:= #$009B;  // CONTROL
    $3C: Result:= #$0014;  // DEVICE CONTROL FOUR
    $3D: Result:= #$0015;  // NEGATIVE ACKNOWLEDGE
    $3E: Result:= #$009E;  // CONTROL
    $3F: Result:= #$001A;  // SUBSTITUTE
    $40: Result:= #$0020;  // SPACE
    $41: Result:= #$00A0;  // NO-BREAK SPACE
    $42: Result:= #$00E2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $43: Result:= #$00E4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $44: Result:= #$00E0;  // LATIN SMALL LETTER A WITH GRAVE
    $45: Result:= #$00E1;  // LATIN SMALL LETTER A WITH ACUTE
    $46: Result:= #$00E3;  // LATIN SMALL LETTER A WITH TILDE
    $47: Result:= #$00E5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $48: Result:= #$007B;  // LEFT CURLY BRACKET
    $49: Result:= #$00F1;  // LATIN SMALL LETTER N WITH TILDE
    $4A: Result:= #$00C7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $4B: Result:= #$002E;  // FULL STOP
    $4C: Result:= #$003C;  // LESS-THAN SIGN
    $4D: Result:= #$0028;  // LEFT PARENTHESIS
    $4E: Result:= #$002B;  // PLUS SIGN
    $4F: Result:= #$0021;  // EXCLAMATION MARK
    $50: Result:= #$0026;  // AMPERSAND
    $51: Result:= #$00E9;  // LATIN SMALL LETTER E WITH ACUTE
    $52: Result:= #$00EA;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $53: Result:= #$00EB;  // LATIN SMALL LETTER E WITH DIAERESIS
    $54: Result:= #$00E8;  // LATIN SMALL LETTER E WITH GRAVE
    $55: Result:= #$00ED;  // LATIN SMALL LETTER I WITH ACUTE
    $56: Result:= #$00EE;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $57: Result:= #$00EF;  // LATIN SMALL LETTER I WITH DIAERESIS
    $58: Result:= #$00EC;  // LATIN SMALL LETTER I WITH GRAVE
    $59: Result:= #$00DF;  // LATIN SMALL LETTER SHARP S (GERMAN)
    $5A: Result:= #$011E;  // LATIN CAPITAL LETTER G WITH BREVE
    $5B: Result:= #$0130;  // LATIN CAPITAL LETTER I WITH DOT ABOVE
    $5C: Result:= #$002A;  // ASTERISK
    $5D: Result:= #$0029;  // RIGHT PARENTHESIS
    $5E: Result:= #$003B;  // SEMICOLON
    $5F: Result:= #$005E;  // CIRCUMFLEX ACCENT
    $60: Result:= #$002D;  // HYPHEN-MINUS
    $61: Result:= #$002F;  // SOLIDUS
    $62: Result:= #$00C2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $63: Result:= #$00C4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $64: Result:= #$00C0;  // LATIN CAPITAL LETTER A WITH GRAVE
    $65: Result:= #$00C1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $66: Result:= #$00C3;  // LATIN CAPITAL LETTER A WITH TILDE
    $67: Result:= #$00C5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $68: Result:= #$005B;  // LEFT SQUARE BRACKET
    $69: Result:= #$00D1;  // LATIN CAPITAL LETTER N WITH TILDE
    $6A: Result:= #$015F;  // LATIN SMALL LETTER S WITH CEDILLA
    $6B: Result:= #$002C;  // COMMA
    $6C: Result:= #$0025;  // PERCENT SIGN
    $6D: Result:= #$005F;  // LOW LINE
    $6E: Result:= #$003E;  // GREATER-THAN SIGN
    $6F: Result:= #$003F;  // QUESTION MARK
    $70: Result:= #$00F8;  // LATIN SMALL LETTER O WITH STROKE
    $71: Result:= #$00C9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $72: Result:= #$00CA;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $73: Result:= #$00CB;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $74: Result:= #$00C8;  // LATIN CAPITAL LETTER E WITH GRAVE
    $75: Result:= #$00CD;  // LATIN CAPITAL LETTER I WITH ACUTE
    $76: Result:= #$00CE;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $77: Result:= #$00CF;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $78: Result:= #$00CC;  // LATIN CAPITAL LETTER I WITH GRAVE
    $79: Result:= #$0131;  // LATIN SMALL LETTER DOTLESS I
    $7A: Result:= #$003A;  // COLON
    $7B: Result:= #$00D6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $7C: Result:= #$015E;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $7D: Result:= #$0027;  // APOSTROPHE
    $7E: Result:= #$003D;  // EQUALS SIGN
    $7F: Result:= #$00DC;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $80: Result:= #$00D8;  // LATIN CAPITAL LETTER O WITH STROKE
    $81: Result:= #$0061;  // LATIN SMALL LETTER A
    $82: Result:= #$0062;  // LATIN SMALL LETTER B
    $83: Result:= #$0063;  // LATIN SMALL LETTER C
    $84: Result:= #$0064;  // LATIN SMALL LETTER D
    $85: Result:= #$0065;  // LATIN SMALL LETTER E
    $86: Result:= #$0066;  // LATIN SMALL LETTER F
    $87: Result:= #$0067;  // LATIN SMALL LETTER G
    $88: Result:= #$0068;  // LATIN SMALL LETTER H
    $89: Result:= #$0069;  // LATIN SMALL LETTER I
    $8A: Result:= #$00AB;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $8B: Result:= #$00BB;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $8C: Result:= #$007D;  // RIGHT CURLY BRACKET
    $8D: Result:= #$0060;  // GRAVE ACCENT
    $8E: Result:= #$00A6;  // BROKEN BAR
    $8F: Result:= #$00B1;  // PLUS-MINUS SIGN
    $90: Result:= #$00B0;  // DEGREE SIGN
    $91: Result:= #$006A;  // LATIN SMALL LETTER J
    $92: Result:= #$006B;  // LATIN SMALL LETTER K
    $93: Result:= #$006C;  // LATIN SMALL LETTER L
    $94: Result:= #$006D;  // LATIN SMALL LETTER M
    $95: Result:= #$006E;  // LATIN SMALL LETTER N
    $96: Result:= #$006F;  // LATIN SMALL LETTER O
    $97: Result:= #$0070;  // LATIN SMALL LETTER P
    $98: Result:= #$0071;  // LATIN SMALL LETTER Q
    $99: Result:= #$0072;  // LATIN SMALL LETTER R
    $9A: Result:= #$00AA;  // FEMININE ORDINAL INDICATOR
    $9B: Result:= #$00BA;  // MASCULINE ORDINAL INDICATOR
    $9C: Result:= #$00E6;  // LATIN SMALL LIGATURE AE
    $9D: Result:= #$00B8;  // CEDILLA
    $9E: Result:= #$00C6;  // LATIN CAPITAL LIGATURE AE
    $9F: Result:= #$00A4;  // CURRENCY SIGN
    $A0: Result:= #$00B5;  // MICRO SIGN
    $A1: Result:= #$00F6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $A2: Result:= #$0073;  // LATIN SMALL LETTER S
    $A3: Result:= #$0074;  // LATIN SMALL LETTER T
    $A4: Result:= #$0075;  // LATIN SMALL LETTER U
    $A5: Result:= #$0076;  // LATIN SMALL LETTER V
    $A6: Result:= #$0077;  // LATIN SMALL LETTER W
    $A7: Result:= #$0078;  // LATIN SMALL LETTER X
    $A8: Result:= #$0079;  // LATIN SMALL LETTER Y
    $A9: Result:= #$007A;  // LATIN SMALL LETTER Z
    $AA: Result:= #$00A1;  // INVERTED EXCLAMATION MARK
    $AB: Result:= #$00BF;  // INVERTED QUESTION MARK
    $AC: Result:= #$005D;  // RIGHT SQUARE BRACKET
    $AD: Result:= #$0024;  // DOLLAR SIGN
    $AE: Result:= #$0040;  // COMMERCIAL AT
    $AF: Result:= #$00AE;  // REGISTERED SIGN
    $B0: Result:= #$00A2;  // CENT SIGN
    $B1: Result:= #$00A3;  // POUND SIGN
    $B2: Result:= #$00A5;  // YEN SIGN
    $B3: Result:= #$00B7;  // MIDDLE DOT
    $B4: Result:= #$00A9;  // COPYRIGHT SIGN
    $B5: Result:= #$00A7;  // SECTION SIGN
    $B7: Result:= #$00BC;  // VULGAR FRACTION ONE QUARTER
    $B8: Result:= #$00BD;  // VULGAR FRACTION ONE HALF
    $B9: Result:= #$00BE;  // VULGAR FRACTION THREE QUARTERS
    $BA: Result:= #$00AC;  // NOT SIGN
    $BB: Result:= #$007C;  // VERTICAL LINE
    $BC: Result:= #$00AF;  // MACRON
    $BD: Result:= #$00A8;  // DIAERESIS
    $BE: Result:= #$00B4;  // ACUTE ACCENT
    $BF: Result:= #$00D7;  // MULTIPLICATION SIGN
    $C0: Result:= #$00E7;  // LATIN SMALL LETTER C WITH CEDILLA
    $C1: Result:= #$0041;  // LATIN CAPITAL LETTER A
    $C2: Result:= #$0042;  // LATIN CAPITAL LETTER B
    $C3: Result:= #$0043;  // LATIN CAPITAL LETTER C
    $C4: Result:= #$0044;  // LATIN CAPITAL LETTER D
    $C5: Result:= #$0045;  // LATIN CAPITAL LETTER E
    $C6: Result:= #$0046;  // LATIN CAPITAL LETTER F
    $C7: Result:= #$0047;  // LATIN CAPITAL LETTER G
    $C8: Result:= #$0048;  // LATIN CAPITAL LETTER H
    $C9: Result:= #$0049;  // LATIN CAPITAL LETTER I
    $CA: Result:= #$00AD;  // SOFT HYPHEN
    $CB: Result:= #$00F4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $CC: Result:= #$007E;  // TILDE
    $CD: Result:= #$00F2;  // LATIN SMALL LETTER O WITH GRAVE
    $CE: Result:= #$00F3;  // LATIN SMALL LETTER O WITH ACUTE
    $CF: Result:= #$00F5;  // LATIN SMALL LETTER O WITH TILDE
    $D0: Result:= #$011F;  // LATIN SMALL LETTER G WITH BREVE
    $D1: Result:= #$004A;  // LATIN CAPITAL LETTER J
    $D2: Result:= #$004B;  // LATIN CAPITAL LETTER K
    $D3: Result:= #$004C;  // LATIN CAPITAL LETTER L
    $D4: Result:= #$004D;  // LATIN CAPITAL LETTER M
    $D5: Result:= #$004E;  // LATIN CAPITAL LETTER N
    $D6: Result:= #$004F;  // LATIN CAPITAL LETTER O
    $D7: Result:= #$0050;  // LATIN CAPITAL LETTER P
    $D8: Result:= #$0051;  // LATIN CAPITAL LETTER Q
    $D9: Result:= #$0052;  // LATIN CAPITAL LETTER R
    $DA: Result:= #$00B9;  // SUPERSCRIPT ONE
    $DB: Result:= #$00FB;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $DC: Result:= #$005C;  // REVERSE SOLIDUS
    $DD: Result:= #$00F9;  // LATIN SMALL LETTER U WITH GRAVE
    $DE: Result:= #$00FA;  // LATIN SMALL LETTER U WITH ACUTE
    $DF: Result:= #$00FF;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $E0: Result:= #$00FC;  // LATIN SMALL LETTER U WITH DIAERESIS
    $E1: Result:= #$00F7;  // DIVISION SIGN
    $E2: Result:= #$0053;  // LATIN CAPITAL LETTER S
    $E3: Result:= #$0054;  // LATIN CAPITAL LETTER T
    $E4: Result:= #$0055;  // LATIN CAPITAL LETTER U
    $E5: Result:= #$0056;  // LATIN CAPITAL LETTER V
    $E6: Result:= #$0057;  // LATIN CAPITAL LETTER W
    $E7: Result:= #$0058;  // LATIN CAPITAL LETTER X
    $E8: Result:= #$0059;  // LATIN CAPITAL LETTER Y
    $E9: Result:= #$005A;  // LATIN CAPITAL LETTER Z
    $EA: Result:= #$00B2;  // SUPERSCRIPT TWO
    $EB: Result:= #$00D4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $EC: Result:= #$0023;  // NUMBER SIGN
    $ED: Result:= #$00D2;  // LATIN CAPITAL LETTER O WITH GRAVE
    $EE: Result:= #$00D3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $EF: Result:= #$00D5;  // LATIN CAPITAL LETTER O WITH TILDE
    $F0: Result:= #$0030;  // DIGIT ZERO
    $F1: Result:= #$0031;  // DIGIT ONE
    $F2: Result:= #$0032;  // DIGIT TWO
    $F3: Result:= #$0033;  // DIGIT THREE
    $F4: Result:= #$0034;  // DIGIT FOUR
    $F5: Result:= #$0035;  // DIGIT FIVE
    $F6: Result:= #$0036;  // DIGIT SIX
    $F7: Result:= #$0037;  // DIGIT SEVEN
    $F8: Result:= #$0038;  // DIGIT EIGHT
    $F9: Result:= #$0039;  // DIGIT NINE
    $FA: Result:= #$00B3;  // SUPERSCRIPT THREE
    $FB: Result:= #$00DB;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $FC: Result:= #$0022;  // QUOTATION MARK
    $FD: Result:= #$00D9;  // LATIN CAPITAL LETTER U WITH GRAVE
    $FE: Result:= #$00DA;  // LATIN CAPITAL LETTER U WITH ACUTE
    $FF: Result:= #$009F;  // CONTROL
  else
    raise EConvertError.CreateFmt('Invalid cp1026 sequence of code point %d',[W]);
  end;
end;

function cp1250ToUTF16Char(const W: word):WideChar;
// This function was provided by Miloslav Skácel
const
  sInvalidWindows1250Sequence = 'Invalid Windows-1250 sequence of code point %d';
begin
  case W of
    // NOT USED
    $81,$83,$88,$90,$98:
      raise EConvertError.CreateFmt(sInvalidWindows1250Sequence,[W]);
    $80: Result:= #$20ac;  // EURO SIGN
    $82: Result:= #$201a;  // SINGLE LOW-9 QUOTATION MARK
    $84: Result:= #$201e;  // DOUBLE LOW-9 QUOTATION MARK
    $85: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $86: Result:= #$2020;  // DAGGER
    $87: Result:= #$2021;  // DOUBLE DAGGER
    $89: Result:= #$2030;  // PER MILLE SIGN
    $8a: Result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $8b: Result:= #$2039;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $8c: Result:= #$015a;  // LATIN CAPITAL LETTER S WITH ACUTE
    $8d: Result:= #$0164;  // LATIN CAPITAL LETTER T WITH CARON
    $8e: Result:= #$017d;  // LATIN CAPITAL LETTER Z WITH CARON
    $8f: Result:= #$0179;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $91: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: Result:= #$201c;  // LEFT DOUBLE QUOTATION MARK
    $94: Result:= #$201d;  // RIGHT DOUBLE QUOTATION MARK
    $95: Result:= #$2022;  // BULLET
    $96: Result:= #$2013;  // EN-DASH
    $97: Result:= #$2014;  // EM-DASH
    $99: Result:= #$2122;  // TRADE MARK SIGN
    $9a: Result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $9b: Result:= #$203a;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $9c: Result:= #$015b;  // LATIN SMALL LETTER S WITH ACUTE
    $9d: Result:= #$0165;  // LATIN SMALL LETTER T WITH CARON
    $9e: Result:= #$017e;  // LATIN SMALL LETTER Z WITH CARON
    $9f: Result:= #$017a;  // LATIN SMALL LETTER Z WITH ACUTE
    $a0: Result:= #$00a0;  // NO-BREAK SPACE
    $a1: Result:= #$02c7;  // CARON
    $a2: Result:= #$02d8;  // BREVE
    $a3: Result:= #$0141;  // LATIN CAPITAL LETTER L WITH STROKE
    $a4: Result:= #$00a4;  // CURRENCY SIGN
    $a5: Result:= #$0104;  // LATIN CAPITAL LETTER A WITH OGONEK
    $a6: Result:= #$00a6;  // BROKEN BAR
    $a7: Result:= #$00a7;  // SECTION SIGN
    $a8: Result:= #$00a8;  // DIAERESIS
    $a9: Result:= #$00a9;  // COPYRIGHT SIGN
    $aa: Result:= #$015e;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $ab: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $ac: Result:= #$00ac;  // NOT SIGN
    $ad: Result:= #$00ad;  // SOFT HYPHEN
    $ae: Result:= #$00ae;  // REGISTERED SIGN
    $af: Result:= #$017b;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $b0: Result:= #$00b0;  // DEGREE SIGN
    $b1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $b2: Result:= #$02db;  // OGONEK
    $b3: Result:= #$0142;  // LATIN SMALL LETTER L WITH STROKE
    $b4: Result:= #$00b4;  // ACUTE ACCENT
    $b5: Result:= #$00b5;  // MIKRO SIGN
    $b6: Result:= #$00b6;  // PILCROW SIGN
    $b7: Result:= #$00b7;  // MIDDLE DOT
    $b8: Result:= #$00b8;  // CEDILLA
    $b9: Result:= #$0105;  // LATIN SMALL LETTER A WITH OGONEK
    $ba: Result:= #$015f;  // LATIN SMALL LETTER S WITH CEDILLA
    $bb: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $bc: Result:= #$013d;  // LATIN CAPITAL LETTER L WITH CARON
    $bd: Result:= #$02dd;  // DOUBLE ACUTE ACCENT
    $be: Result:= #$013e;  // LATIN SMALL LETTER L WITH CARON
    $bf: Result:= #$017c;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $c0: Result:= #$0154;  // LATIN CAPITAL LETTER R WITH ACUTE
    $c1: Result:= #$00c1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $c2: Result:= #$00c2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $c3: Result:= #$0102;  // LATIN CAPITAL LETTER A WITH BREVE
    $c4: Result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $c5: Result:= #$0139;  // LATIN CAPITAL LETTER L WITH ACUTE
    $c6: Result:= #$0106;  // LATIN CAPITAL LETTER C WITH ACUTE
    $c7: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $c8: Result:= #$010c;  // LATIN CAPITAL LETTER C WITH CARON
    $c9: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $ca: Result:= #$0118;  // LATIN CAPITAL LETTER E WITH OGONEK
    $cb: Result:= #$00cb;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $cc: Result:= #$011a;  // LATIN CAPITAL LETTER E WITH CARON
    $cd: Result:= #$00cd;  // LATIN CAPITAL LETTER I WITH ACUTE
    $ce: Result:= #$00ce;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $cf: Result:= #$010e;  // LATIN CAPITAL LETTER D WITH CARON
    $d0: Result:= #$0110;  // LATIN CAPITAL LETTER D WITH STROKE
    $d1: Result:= #$0143;  // LATIN CAPITAL LETTER N WITH ACUTE
    $d2: Result:= #$0147;  // LATIN CAPITAL LETTER N WITH CARON
    $d3: Result:= #$00d3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $d4: Result:= #$00d4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $d5: Result:= #$0150;  // LATIN CAPITAL LETTER O WITH DOUBLE ACUTE
    $d6: Result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $d7: Result:= #$00d7;  // MULTIPLICATION SIGN
    $d8: Result:= #$0158;  // LATIN CAPITAL LETTER R WITH CARON
    $d9: Result:= #$016e;  // LATIN CAPITAL LETTER U WITH RING ABOVE
    $da: Result:= #$00da;  // LATIN CAPITAL LETTER U WITH ACUTE
    $db: Result:= #$0170;  // LATIN CAPITAL LETTER U WITH WITH DOUBLE ACUTE
    $dc: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $dd: Result:= #$00dd;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $de: Result:= #$0162;  // LATIN CAPITAL LETTER T WITH CEDILLA
    $df: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e0: Result:= #$0155;  // LATIN SMALL LETTER R WITH ACUTE
    $e1: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $e2: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $e3: Result:= #$0103;  // LATIN SMALL LETTER A WITH BREVE
    $e4: Result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $e5: Result:= #$013a;  // LATIN SMALL LETTER L WITH ACUTE
    $e6: Result:= #$0107;  // LATIN SMALL LETTER C WITH ACUTE
    $e7: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $e8: Result:= #$010d;  // LATIN SMALL LETTER C WITH CARON 100D
    $e9: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $ea: Result:= #$0119;  // LATIN SMALL LETTER E WITH OGONEK
    $eb: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $ec: Result:= #$011b;  // LATIN SMALL LETTER E WITH CARON
    $ed: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $ee: Result:= #$00ee;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $ef: Result:= #$010f;  // LATIN SMALL LETTER D WITH CARON
    $f0: Result:= #$0111;  // LATIN SMALL LETTER D WITH STROKE
    $f1: Result:= #$0144;  // LATIN SMALL LETTER N WITH ACUTE
    $f2: Result:= #$0148;  // LATIN SMALL LETTER N WITH CARON
    $f3: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $f4: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $f5: Result:= #$0151;  // LATIN SMALL LETTER O WITH DOUBLE ACUTE
    $f6: Result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $f7: Result:= #$00f7;  // DIVISION SIGN
    $f8: Result:= #$0159;  // LATIN SMALL LETTER R WITH CARON
    $f9: Result:= #$016f;  // LATIN SMALL LETTER U WITH RING ABOVE
    $fa: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $fb: Result:= #$0171;  // LATIN SMALL LETTER U WITH WITH DOUBLE ACUTE
    $fc: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $fd: Result:= #$00fd;  // LATIN SMALL LETTER Y WITH ACUTE
    $fe: Result:= #$0163;  // LATIN SMALL LETTER T WITH CEDILLA
    $ff: Result:= #$02d9;  // DOT ABOVE
  else
    Result:= WideChar(W);
  end;
end;

function cp1251ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $80: Result:= #$0402;  // CYRILLIC CAPITAL LETTER DJE
    $81: Result:= #$0403;  // CYRILLIC CAPITAL LETTER GJE
    $82: Result:= #$201a;  // SINGLE LOW-9 QUOTATION MARK
    $83: Result:= #$0453;  // CYRILLIC SMALL LETTER GJE
    $84: Result:= #$201e;  // DOUBLE LOW-9 QUOTATION MARK
    $85: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $86: Result:= #$2020;  // DAGGER
    $87: Result:= #$2021;  // DOUBLE DAGGER
    $88: Result:= #$20ac;  // EURO SIGN
    $89: Result:= #$2030;  // PER MILLE SIGN
    $8a: Result:= #$0409;  // CYRILLIC CAPITAL LETTER LJE
    $8b: Result:= #$2039;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $8c: Result:= #$040a;  // CYRILLIC CAPITAL LETTER NJE
    $8d: Result:= #$040c;  // CYRILLIC CAPITAL LETTER KJE
    $8e: Result:= #$040b;  // CYRILLIC CAPITAL LETTER TSHE
    $8f: Result:= #$040f;  // CYRILLIC CAPITAL LETTER DZHE
    $90: Result:= #$0452;  // CYRILLIC SMALL LETTER DJE
    $91: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: Result:= #$201c;  // LEFT DOUBLE QUOTATION MARK
    $94: Result:= #$201d;  // RIGHT DOUBLE QUOTATION MARK
    $95: Result:= #$2022;  // BULLET
    $96: Result:= #$2013;  // EN DASH
    $97: Result:= #$2014;  // EM DASH
    $98: raise EConvertError.CreateFmt('Invalid cp1251 sequence of code point %d',[W]);
    $99: Result:= #$2122;  // TRADE MARK SIGN
    $9a: Result:= #$0459;  // CYRILLIC SMALL LETTER LJE
    $9b: Result:= #$203a;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $9c: Result:= #$045a;  // CYRILLIC SMALL LETTER NJE
    $9d: Result:= #$045c;  // CYRILLIC SMALL LETTER KJE
    $9e: Result:= #$045b;  // CYRILLIC SMALL LETTER TSHE
    $9f: Result:= #$045f;  // CYRILLIC SMALL LETTER DZHE
    $a0: Result:= #$00a0;  // NO-BREAK SPACE
    $a1: Result:= #$040e;  // CYRILLIC CAPITAL LETTER SHORT U
    $a2: Result:= #$045e;  // CYRILLIC SMALL LETTER SHORT U
    $a3: Result:= #$0408;  // CYRILLIC CAPITAL LETTER JE
    $a4: Result:= #$00a4;  // CURRENCY SIGN
    $a5: Result:= #$0490;  // CYRILLIC CAPITAL LETTER GHE WITH UPTURN
    $a8: Result:= #$0401;  // CYRILLIC CAPITAL LETTER IO
    $aa: Result:= #$0404;  // CYRILLIC CAPITAL LETTER UKRAINIAN IE
    $af: Result:= #$0407;  // CYRILLIC CAPITAL LETTER YI
    $b2: Result:= #$0406;  // CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I
    $b3: Result:= #$0456;  // CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I
    $b4: Result:= #$0491;  // CYRILLIC SMALL LETTER GHE WITH UPTURN
    $b8: Result:= #$0451;  // CYRILLIC SMALL LETTER IO
    $b9: Result:= #$2116;  // NUMERO SIGN
    $ba: Result:= #$0454;  // CYRILLIC SMALL LETTER UKRAINIAN IE
    $bc: Result:= #$0458;  // CYRILLIC SMALL LETTER JE
    $bd: Result:= #$0405;  // CYRILLIC CAPITAL LETTER DZE
    $be: Result:= #$0455;  // CYRILLIC SMALL LETTER DZE
    $bf: Result:= #$0457;  // CYRILLIC SMALL LETTER YI
    $c0..$ff:
      Result:= WideChar(W+$350);
  else
    Result:= WideChar(W);
  end;
end;

function cp1252ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A0..$FF:
      Result:= WideChar(W);
    $80: Result:= #$20AC;  // EURO SIGN
    $82: Result:= #$201A;  // SINGLE LOW-9 QUOTATION MARK
    $83: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $84: Result:= #$201E;  // DOUBLE LOW-9 QUOTATION MARK
    $85: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $86: Result:= #$2020;  // DAGGER
    $87: Result:= #$2021;  // DOUBLE DAGGER
    $88: Result:= #$02C6;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $89: Result:= #$2030;  // PER MILLE SIGN
    $8A: Result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $8B: Result:= #$2039;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $8C: Result:= #$0152;  // LATIN CAPITAL LIGATURE OE
    $8E: Result:= #$017D;  // LATIN CAPITAL LETTER Z WITH CARON
    $91: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $94: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $95: Result:= #$2022;  // BULLET
    $96: Result:= #$2013;  // EN DASH
    $97: Result:= #$2014;  // EM DASH
    $98: Result:= #$02DC;  // SMALL TILDE
    $99: Result:= #$2122;  // TRADE MARK SIGN
    $9A: Result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $9B: Result:= #$203A;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $9C: Result:= #$0153;  // LATIN SMALL LIGATURE OE
    $9E: Result:= #$017E;  // LATIN SMALL LETTER Z WITH CARON
    $9F: Result:= #$0178;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
  else
    raise EConvertError.CreateFmt('Invalid Windows-1252 sequence of code point %d',[W]);
  end;
end;

function cp1253ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A0,$A3..$A9,$AB..$AE,$B0..$B3,$B5..$B7,$BB,$BD:
      Result:= WideChar(W);
    $80: Result:= #$20AC;  // EURO SIGN
    $82: Result:= #$201A;  // SINGLE LOW-9 QUOTATION MARK
    $83: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $84: Result:= #$201E;  // DOUBLE LOW-9 QUOTATION MARK
    $85: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $86: Result:= #$2020;  // DAGGER
    $87: Result:= #$2021;  // DOUBLE DAGGER
    $89: Result:= #$2030;  // PER MILLE SIGN
    $8B: Result:= #$2039;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $91: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $94: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $95: Result:= #$2022;  // BULLET
    $96: Result:= #$2013;  // EN DASH
    $97: Result:= #$2014;  // EM DASH
    $99: Result:= #$2122;  // TRADE MARK SIGN
    $9B: Result:= #$203A;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $A1: Result:= #$0385;  // GREEK DIALYTIKA TONOS
    $A2: Result:= #$0386;  // GREEK CAPITAL LETTER ALPHA WITH TONOS
    $AF: Result:= #$2015;  // HORIZONTAL BAR
    $B4: Result:= #$0384;  // GREEK TONOS
    $B8: Result:= #$0388;  // GREEK CAPITAL LETTER EPSILON WITH TONOS
    $B9: Result:= #$0389;  // GREEK CAPITAL LETTER ETA WITH TONOS
    $BA: Result:= #$038A;  // GREEK CAPITAL LETTER IOTA WITH TONOS
    $BC: Result:= #$038C;  // GREEK CAPITAL LETTER OMICRON WITH TONOS
    $BE: Result:= #$038E;  // GREEK CAPITAL LETTER UPSILON WITH TONOS
    $BF: Result:= #$038F;  // GREEK CAPITAL LETTER OMEGA WITH TONOS
    $C0: Result:= #$0390;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA AND TONOS
    $C1: Result:= #$0391;  // GREEK CAPITAL LETTER ALPHA
    $C2: Result:= #$0392;  // GREEK CAPITAL LETTER BETA
    $C3: Result:= #$0393;  // GREEK CAPITAL LETTER GAMMA
    $C4: Result:= #$0394;  // GREEK CAPITAL LETTER DELTA
    $C5: Result:= #$0395;  // GREEK CAPITAL LETTER EPSILON
    $C6: Result:= #$0396;  // GREEK CAPITAL LETTER ZETA
    $C7: Result:= #$0397;  // GREEK CAPITAL LETTER ETA
    $C8: Result:= #$0398;  // GREEK CAPITAL LETTER THETA
    $C9: Result:= #$0399;  // GREEK CAPITAL LETTER IOTA
    $CA: Result:= #$039A;  // GREEK CAPITAL LETTER KAPPA
    $CB: Result:= #$039B;  // GREEK CAPITAL LETTER LAMDA
    $CC: Result:= #$039C;  // GREEK CAPITAL LETTER MU
    $CD: Result:= #$039D;  // GREEK CAPITAL LETTER NU
    $CE: Result:= #$039E;  // GREEK CAPITAL LETTER XI
    $CF: Result:= #$039F;  // GREEK CAPITAL LETTER OMICRON
    $D0: Result:= #$03A0;  // GREEK CAPITAL LETTER PI
    $D1: Result:= #$03A1;  // GREEK CAPITAL LETTER RHO
    $D3: Result:= #$03A3;  // GREEK CAPITAL LETTER SIGMA
    $D4: Result:= #$03A4;  // GREEK CAPITAL LETTER TAU
    $D5: Result:= #$03A5;  // GREEK CAPITAL LETTER UPSILON
    $D6: Result:= #$03A6;  // GREEK CAPITAL LETTER PHI
    $D7: Result:= #$03A7;  // GREEK CAPITAL LETTER CHI
    $D8: Result:= #$03A8;  // GREEK CAPITAL LETTER PSI
    $D9: Result:= #$03A9;  // GREEK CAPITAL LETTER OMEGA
    $DA: Result:= #$03AA;  // GREEK CAPITAL LETTER IOTA WITH DIALYTIKA
    $DB: Result:= #$03AB;  // GREEK CAPITAL LETTER UPSILON WITH DIALYTIKA
    $DC: Result:= #$03AC;  // GREEK SMALL LETTER ALPHA WITH TONOS
    $DD: Result:= #$03AD;  // GREEK SMALL LETTER EPSILON WITH TONOS
    $DE: Result:= #$03AE;  // GREEK SMALL LETTER ETA WITH TONOS
    $DF: Result:= #$03AF;  // GREEK SMALL LETTER IOTA WITH TONOS
    $E0: Result:= #$03B0;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA AND TONOS
    $E1: Result:= #$03B1;  // GREEK SMALL LETTER ALPHA
    $E2: Result:= #$03B2;  // GREEK SMALL LETTER BETA
    $E3: Result:= #$03B3;  // GREEK SMALL LETTER GAMMA
    $E4: Result:= #$03B4;  // GREEK SMALL LETTER DELTA
    $E5: Result:= #$03B5;  // GREEK SMALL LETTER EPSILON
    $E6: Result:= #$03B6;  // GREEK SMALL LETTER ZETA
    $E7: Result:= #$03B7;  // GREEK SMALL LETTER ETA
    $E8: Result:= #$03B8;  // GREEK SMALL LETTER THETA
    $E9: Result:= #$03B9;  // GREEK SMALL LETTER IOTA
    $EA: Result:= #$03BA;  // GREEK SMALL LETTER KAPPA
    $EB: Result:= #$03BB;  // GREEK SMALL LETTER LAMDA
    $EC: Result:= #$03BC;  // GREEK SMALL LETTER MU
    $ED: Result:= #$03BD;  // GREEK SMALL LETTER NU
    $EE: Result:= #$03BE;  // GREEK SMALL LETTER XI
    $EF: Result:= #$03BF;  // GREEK SMALL LETTER OMICRON
    $F0: Result:= #$03C0;  // GREEK SMALL LETTER PI
    $F1: Result:= #$03C1;  // GREEK SMALL LETTER RHO
    $F2: Result:= #$03C2;  // GREEK SMALL LETTER FINAL SIGMA
    $F3: Result:= #$03C3;  // GREEK SMALL LETTER SIGMA
    $F4: Result:= #$03C4;  // GREEK SMALL LETTER TAU
    $F5: Result:= #$03C5;  // GREEK SMALL LETTER UPSILON
    $F6: Result:= #$03C6;  // GREEK SMALL LETTER PHI
    $F7: Result:= #$03C7;  // GREEK SMALL LETTER CHI
    $F8: Result:= #$03C8;  // GREEK SMALL LETTER PSI
    $F9: Result:= #$03C9;  // GREEK SMALL LETTER OMEGA
    $FA: Result:= #$03CA;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA
    $FB: Result:= #$03CB;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA
    $FC: Result:= #$03CC;  // GREEK SMALL LETTER OMICRON WITH TONOS
    $FD: Result:= #$03CD;  // GREEK SMALL LETTER UPSILON WITH TONOS
    $FE: Result:= #$03CE;  // GREEK SMALL LETTER OMEGA WITH TONOS
  else
    raise EConvertError.CreateFmt('Invalid Windows-1253 sequence of code point %d',[W]);
  end;
end;

function cp1254ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A0..$CF,$D1..$DC,$DF..$EF,$F1..$FC,$FF:
      Result:= WideChar(W);
    $80: Result:= #$20AC;  // EURO SIGN
    $82: Result:= #$201A;  // SINGLE LOW-9 QUOTATION MARK
    $83: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $84: Result:= #$201E;  // DOUBLE LOW-9 QUOTATION MARK
    $85: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $86: Result:= #$2020;  // DAGGER
    $87: Result:= #$2021;  // DOUBLE DAGGER
    $88: Result:= #$02C6;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $89: Result:= #$2030;  // PER MILLE SIGN
    $8A: Result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $8B: Result:= #$2039;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $8C: Result:= #$0152;  // LATIN CAPITAL LIGATURE OE
    $91: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $94: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $95: Result:= #$2022;  // BULLET
    $96: Result:= #$2013;  // EN DASH
    $97: Result:= #$2014;  // EM DASH
    $98: Result:= #$02DC;  // SMALL TILDE
    $99: Result:= #$2122;  // TRADE MARK SIGN
    $9A: Result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $9B: Result:= #$203A;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $9C: Result:= #$0153;  // LATIN SMALL LIGATURE OE
    $9F: Result:= #$0178;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
    $D0: Result:= #$011E;  // LATIN CAPITAL LETTER G WITH BREVE
    $DD: Result:= #$0130;  // LATIN CAPITAL LETTER I WITH DOT ABOVE
    $DE: Result:= #$015E;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $F0: Result:= #$011F;  // LATIN SMALL LETTER G WITH BREVE
    $FD: Result:= #$0131;  // LATIN SMALL LETTER DOTLESS I
    $FE: Result:= #$015F;  // LATIN SMALL LETTER S WITH CEDILLA
  else
    raise EConvertError.CreateFmt('Invalid Windows-1254 sequence of code point %d',[W]);
  end;
end;

function cp1255ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A0..$A3,$A5..$A9,$AB..$B9,$BB..$BF:
      Result:= WideChar(W);
    $80: Result:= #$20AC;  // EURO SIGN
    $82: Result:= #$201A;  // SINGLE LOW-9 QUOTATION MARK
    $83: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $84: Result:= #$201E;  // DOUBLE LOW-9 QUOTATION MARK
    $85: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $86: Result:= #$2020;  // DAGGER
    $87: Result:= #$2021;  // DOUBLE DAGGER
    $88: Result:= #$02C6;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $89: Result:= #$2030;  // PER MILLE SIGN
    $8B: Result:= #$2039;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $91: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $94: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $95: Result:= #$2022;  // BULLET
    $96: Result:= #$2013;  // EN DASH
    $97: Result:= #$2014;  // EM DASH
    $98: Result:= #$02DC;  // SMALL TILDE
    $99: Result:= #$2122;  // TRADE MARK SIGN
    $9B: Result:= #$203A;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $A4: Result:= #$20AA;  // NEW SHEQEL SIGN
    $AA: Result:= #$00D7;  // MULTIPLICATION SIGN
    $BA: Result:= #$00F7;  // DIVISION SIGN
    $C0: Result:= #$05B0;  // HEBREW POINT SHEVA
    $C1: Result:= #$05B1;  // HEBREW POINT HATAF SEGOL
    $C2: Result:= #$05B2;  // HEBREW POINT HATAF PATAH
    $C3: Result:= #$05B3;  // HEBREW POINT HATAF QAMATS
    $C4: Result:= #$05B4;  // HEBREW POINT HIRIQ
    $C5: Result:= #$05B5;  // HEBREW POINT TSERE
    $C6: Result:= #$05B6;  // HEBREW POINT SEGOL
    $C7: Result:= #$05B7;  // HEBREW POINT PATAH
    $C8: Result:= #$05B8;  // HEBREW POINT QAMATS
    $C9: Result:= #$05B9;  // HEBREW POINT HOLAM
    $CB: Result:= #$05BB;  // HEBREW POINT QUBUTS
    $CC: Result:= #$05BC;  // HEBREW POINT DAGESH OR MAPIQ
    $CD: Result:= #$05BD;  // HEBREW POINT METEG
    $CE: Result:= #$05BE;  // HEBREW PUNCTUATION MAQAF
    $CF: Result:= #$05BF;  // HEBREW POINT RAFE
    $D0: Result:= #$05C0;  // HEBREW PUNCTUATION PASEQ
    $D1: Result:= #$05C1;  // HEBREW POINT SHIN DOT
    $D2: Result:= #$05C2;  // HEBREW POINT SIN DOT
    $D3: Result:= #$05C3;  // HEBREW PUNCTUATION SOF PASUQ
    $D4: Result:= #$05F0;  // HEBREW LIGATURE YIDDISH DOUBLE VAV
    $D5: Result:= #$05F1;  // HEBREW LIGATURE YIDDISH VAV YOD
    $D6: Result:= #$05F2;  // HEBREW LIGATURE YIDDISH DOUBLE YOD
    $D7: Result:= #$05F3;  // HEBREW PUNCTUATION GERESH
    $D8: Result:= #$05F4;  // HEBREW PUNCTUATION GERSHAYIM
    $E0: Result:= #$05D0;  // HEBREW LETTER ALEF
    $E1: Result:= #$05D1;  // HEBREW LETTER BET
    $E2: Result:= #$05D2;  // HEBREW LETTER GIMEL
    $E3: Result:= #$05D3;  // HEBREW LETTER DALET
    $E4: Result:= #$05D4;  // HEBREW LETTER HE
    $E5: Result:= #$05D5;  // HEBREW LETTER VAV
    $E6: Result:= #$05D6;  // HEBREW LETTER ZAYIN
    $E7: Result:= #$05D7;  // HEBREW LETTER HET
    $E8: Result:= #$05D8;  // HEBREW LETTER TET
    $E9: Result:= #$05D9;  // HEBREW LETTER YOD
    $EA: Result:= #$05DA;  // HEBREW LETTER FINAL KAF
    $EB: Result:= #$05DB;  // HEBREW LETTER KAF
    $EC: Result:= #$05DC;  // HEBREW LETTER LAMED
    $ED: Result:= #$05DD;  // HEBREW LETTER FINAL MEM
    $EE: Result:= #$05DE;  // HEBREW LETTER MEM
    $EF: Result:= #$05DF;  // HEBREW LETTER FINAL NUN
    $F0: Result:= #$05E0;  // HEBREW LETTER NUN
    $F1: Result:= #$05E1;  // HEBREW LETTER SAMEKH
    $F2: Result:= #$05E2;  // HEBREW LETTER AYIN
    $F3: Result:= #$05E3;  // HEBREW LETTER FINAL PE
    $F4: Result:= #$05E4;  // HEBREW LETTER PE
    $F5: Result:= #$05E5;  // HEBREW LETTER FINAL TSADI
    $F6: Result:= #$05E6;  // HEBREW LETTER TSADI
    $F7: Result:= #$05E7;  // HEBREW LETTER QOF
    $F8: Result:= #$05E8;  // HEBREW LETTER RESH
    $F9: Result:= #$05E9;  // HEBREW LETTER SHIN
    $FA: Result:= #$05EA;  // HEBREW LETTER TAV
    $FD: Result:= #$200E;  // LEFT-TO-RIGHT MARK
    $FE: Result:= #$200F;  // RIGHT-TO-LEFT MARK
  else
    raise EConvertError.CreateFmt('Invalid Windows-1255 sequence of code point %d',[W]);
  end;
end;

function cp1256ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A0,$A2..$A9,$AB..$B9,$BB..$BE,$D7,$E0,$E2,$E7..$EB,$EE..$EF,$F4,
    $F7,$F9,$FB..$FC:
      Result:= WideChar(W);
    $80: Result:= #$20AC;  // EURO SIGN
    $81: Result:= #$067E;  // ARABIC LETTER PEH
    $82: Result:= #$201A;  // SINGLE LOW-9 QUOTATION MARK
    $83: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $84: Result:= #$201E;  // DOUBLE LOW-9 QUOTATION MARK
    $85: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $86: Result:= #$2020;  // DAGGER
    $87: Result:= #$2021;  // DOUBLE DAGGER
    $88: Result:= #$02C6;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $89: Result:= #$2030;  // PER MILLE SIGN
    $8A: Result:= #$0679;  // ARABIC LETTER TTEH
    $8B: Result:= #$2039;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $8C: Result:= #$0152;  // LATIN CAPITAL LIGATURE OE
    $8D: Result:= #$0686;  // ARABIC LETTER TCHEH
    $8E: Result:= #$0698;  // ARABIC LETTER JEH
    $8F: Result:= #$0688;  // ARABIC LETTER DDAL
    $90: Result:= #$06AF;  // ARABIC LETTER GAF
    $91: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $94: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $95: Result:= #$2022;  // BULLET
    $96: Result:= #$2013;  // EN DASH
    $97: Result:= #$2014;  // EM DASH
    $98: Result:= #$06A9;  // ARABIC LETTER KEHEH
    $99: Result:= #$2122;  // TRADE MARK SIGN
    $9A: Result:= #$0691;  // ARABIC LETTER RREH
    $9B: Result:= #$203A;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $9C: Result:= #$0153;  // LATIN SMALL LIGATURE OE
    $9D: Result:= #$200C;  // ZERO WIDTH NON-JOINER
    $9E: Result:= #$200D;  // ZERO WIDTH JOINER
    $9F: Result:= #$06BA;  // ARABIC LETTER NOON GHUNNA
    $A1: Result:= #$060C;  // ARABIC COMMA
    $AA: Result:= #$06BE;  // ARABIC LETTER HEH DOACHASHMEE
    $BA: Result:= #$061B;  // ARABIC SEMICOLON
    $BF: Result:= #$061F;  // ARABIC QUESTION MARK
    $C0: Result:= #$06C1;  // ARABIC LETTER HEH GOAL
    $C1: Result:= #$0621;  // ARABIC LETTER HAMZA
    $C2: Result:= #$0622;  // ARABIC LETTER ALEF WITH MADDA ABOVE
    $C3: Result:= #$0623;  // ARABIC LETTER ALEF WITH HAMZA ABOVE
    $C4: Result:= #$0624;  // ARABIC LETTER WAW WITH HAMZA ABOVE
    $C5: Result:= #$0625;  // ARABIC LETTER ALEF WITH HAMZA BELOW
    $C6: Result:= #$0626;  // ARABIC LETTER YEH WITH HAMZA ABOVE
    $C7: Result:= #$0627;  // ARABIC LETTER ALEF
    $C8: Result:= #$0628;  // ARABIC LETTER BEH
    $C9: Result:= #$0629;  // ARABIC LETTER TEH MARBUTA
    $CA: Result:= #$062A;  // ARABIC LETTER TEH
    $CB: Result:= #$062B;  // ARABIC LETTER THEH
    $CC: Result:= #$062C;  // ARABIC LETTER JEEM
    $CD: Result:= #$062D;  // ARABIC LETTER HAH
    $CE: Result:= #$062E;  // ARABIC LETTER KHAH
    $CF: Result:= #$062F;  // ARABIC LETTER DAL
    $D0: Result:= #$0630;  // ARABIC LETTER THAL
    $D1: Result:= #$0631;  // ARABIC LETTER REH
    $D2: Result:= #$0632;  // ARABIC LETTER ZAIN
    $D3: Result:= #$0633;  // ARABIC LETTER SEEN
    $D4: Result:= #$0634;  // ARABIC LETTER SHEEN
    $D5: Result:= #$0635;  // ARABIC LETTER SAD
    $D6: Result:= #$0636;  // ARABIC LETTER DAD
    $D8: Result:= #$0637;  // ARABIC LETTER TAH
    $D9: Result:= #$0638;  // ARABIC LETTER ZAH
    $DA: Result:= #$0639;  // ARABIC LETTER AIN
    $DB: Result:= #$063A;  // ARABIC LETTER GHAIN
    $DC: Result:= #$0640;  // ARABIC TATWEEL
    $DD: Result:= #$0641;  // ARABIC LETTER FEH
    $DE: Result:= #$0642;  // ARABIC LETTER QAF
    $DF: Result:= #$0643;  // ARABIC LETTER KAF
    $E1: Result:= #$0644;  // ARABIC LETTER LAM
    $E3: Result:= #$0645;  // ARABIC LETTER MEEM
    $E4: Result:= #$0646;  // ARABIC LETTER NOON
    $E5: Result:= #$0647;  // ARABIC LETTER HEH
    $E6: Result:= #$0648;  // ARABIC LETTER WAW
    $EC: Result:= #$0649;  // ARABIC LETTER ALEF MAKSURA
    $ED: Result:= #$064A;  // ARABIC LETTER YEH
    $F0: Result:= #$064B;  // ARABIC FATHATAN
    $F1: Result:= #$064C;  // ARABIC DAMMATAN
    $F2: Result:= #$064D;  // ARABIC KASRATAN
    $F3: Result:= #$064E;  // ARABIC FATHA
    $F5: Result:= #$064F;  // ARABIC DAMMA
    $F6: Result:= #$0650;  // ARABIC KASRA
    $F8: Result:= #$0651;  // ARABIC SHADDA
    $FA: Result:= #$0652;  // ARABIC SUKUN
    $FD: Result:= #$200E;  // LEFT-TO-RIGHT MARK
    $FE: Result:= #$200F;  // RIGHT-TO-LEFT MARK
    $FF: Result:= #$06D2;  // ARABIC LETTER YEH BARREE
  else
    raise EConvertError.CreateFmt('Invalid Windows-1256 sequence of code point %d',[W]);
  end;
end;

function cp1257ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A0,$A2..$A4,$A6..$A7,$A9,$AB..$AE,$B0..$B7,$B9,$BB..$BE,
    $C4..$C5,$C9,$D3,$D5..$D7,$DC,$DF,$E4..$E5,$E9,$F3,$F5..$F7,$FC:
      Result:= WideChar(W);
    $80: Result:= #$20AC;  // EURO SIGN
    $82: Result:= #$201A;  // SINGLE LOW-9 QUOTATION MARK
    $84: Result:= #$201E;  // DOUBLE LOW-9 QUOTATION MARK
    $85: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $86: Result:= #$2020;  // DAGGER
    $87: Result:= #$2021;  // DOUBLE DAGGER
    $89: Result:= #$2030;  // PER MILLE SIGN
    $8B: Result:= #$2039;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $8D: Result:= #$00A8;  // DIAERESIS
    $8E: Result:= #$02C7;  // CARON
    $8F: Result:= #$00B8;  // CEDILLA
    $91: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $94: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $95: Result:= #$2022;  // BULLET
    $96: Result:= #$2013;  // EN DASH
    $97: Result:= #$2014;  // EM DASH
    $99: Result:= #$2122;  // TRADE MARK SIGN
    $9B: Result:= #$203A;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $9D: Result:= #$00AF;  // MACRON
    $9E: Result:= #$02DB;  // OGONEK
    $A8: Result:= #$00D8;  // LATIN CAPITAL LETTER O WITH STROKE
    $AA: Result:= #$0156;  // LATIN CAPITAL LETTER R WITH CEDILLA
    $AF: Result:= #$00C6;  // LATIN CAPITAL LETTER AE
    $B8: Result:= #$00F8;  // LATIN SMALL LETTER O WITH STROKE
    $BA: Result:= #$0157;  // LATIN SMALL LETTER R WITH CEDILLA
    $BF: Result:= #$00E6;  // LATIN SMALL LETTER AE
    $C0: Result:= #$0104;  // LATIN CAPITAL LETTER A WITH OGONEK
    $C1: Result:= #$012E;  // LATIN CAPITAL LETTER I WITH OGONEK
    $C2: Result:= #$0100;  // LATIN CAPITAL LETTER A WITH MACRON
    $C3: Result:= #$0106;  // LATIN CAPITAL LETTER C WITH ACUTE
    $C6: Result:= #$0118;  // LATIN CAPITAL LETTER E WITH OGONEK
    $C7: Result:= #$0112;  // LATIN CAPITAL LETTER E WITH MACRON
    $C8: Result:= #$010C;  // LATIN CAPITAL LETTER C WITH CARON
    $CA: Result:= #$0179;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $CB: Result:= #$0116;  // LATIN CAPITAL LETTER E WITH DOT ABOVE
    $CC: Result:= #$0122;  // LATIN CAPITAL LETTER G WITH CEDILLA
    $CD: Result:= #$0136;  // LATIN CAPITAL LETTER K WITH CEDILLA
    $CE: Result:= #$012A;  // LATIN CAPITAL LETTER I WITH MACRON
    $CF: Result:= #$013B;  // LATIN CAPITAL LETTER L WITH CEDILLA
    $D0: Result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $D1: Result:= #$0143;  // LATIN CAPITAL LETTER N WITH ACUTE
    $D2: Result:= #$0145;  // LATIN CAPITAL LETTER N WITH CEDILLA
    $D4: Result:= #$014C;  // LATIN CAPITAL LETTER O WITH MACRON
    $D8: Result:= #$0172;  // LATIN CAPITAL LETTER U WITH OGONEK
    $D9: Result:= #$0141;  // LATIN CAPITAL LETTER L WITH STROKE
    $DA: Result:= #$015A;  // LATIN CAPITAL LETTER S WITH ACUTE
    $DB: Result:= #$016A;  // LATIN CAPITAL LETTER U WITH MACRON
    $DD: Result:= #$017B;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $DE: Result:= #$017D;  // LATIN CAPITAL LETTER Z WITH CARON
    $E0: Result:= #$0105;  // LATIN SMALL LETTER A WITH OGONEK
    $E1: Result:= #$012F;  // LATIN SMALL LETTER I WITH OGONEK
    $E2: Result:= #$0101;  // LATIN SMALL LETTER A WITH MACRON
    $E3: Result:= #$0107;  // LATIN SMALL LETTER C WITH ACUTE
    $E6: Result:= #$0119;  // LATIN SMALL LETTER E WITH OGONEK
    $E7: Result:= #$0113;  // LATIN SMALL LETTER E WITH MACRON
    $E8: Result:= #$010D;  // LATIN SMALL LETTER C WITH CARON
    $EA: Result:= #$017A;  // LATIN SMALL LETTER Z WITH ACUTE
    $EB: Result:= #$0117;  // LATIN SMALL LETTER E WITH DOT ABOVE
    $EC: Result:= #$0123;  // LATIN SMALL LETTER G WITH CEDILLA
    $ED: Result:= #$0137;  // LATIN SMALL LETTER K WITH CEDILLA
    $EE: Result:= #$012B;  // LATIN SMALL LETTER I WITH MACRON
    $EF: Result:= #$013C;  // LATIN SMALL LETTER L WITH CEDILLA
    $F0: Result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $F1: Result:= #$0144;  // LATIN SMALL LETTER N WITH ACUTE
    $F2: Result:= #$0146;  // LATIN SMALL LETTER N WITH CEDILLA
    $F4: Result:= #$014D;  // LATIN SMALL LETTER O WITH MACRON
    $F8: Result:= #$0173;  // LATIN SMALL LETTER U WITH OGONEK
    $F9: Result:= #$0142;  // LATIN SMALL LETTER L WITH STROKE
    $FA: Result:= #$015B;  // LATIN SMALL LETTER S WITH ACUTE
    $FB: Result:= #$016B;  // LATIN SMALL LETTER U WITH MACRON
    $FD: Result:= #$017C;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $FE: Result:= #$017E;  // LATIN SMALL LETTER Z WITH CARON
    $FF: Result:= #$02D9;  // DOT ABOVE
  else
    raise EConvertError.CreateFmt('Invalid Windows-1257 sequence of code point %d',[W]);
  end;
end;

function cp1258ToUTF16Char(const W: word):WideChar;
begin
  case W of
    $00..$7F,$A0..$C2,$C4..$CB,$CD..$CF,$D1,$D3..$D4,$D6..$DC,$DF..$E2,
    $E4..$EB,$ED..$EF,$F1,$F3..$F4,$F6..$FC,$FF:
      Result:= WideChar(W);
    $80: Result:= #$20AC;  // EURO SIGN
    $82: Result:= #$201A;  // SINGLE LOW-9 QUOTATION MARK
    $83: Result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $84: Result:= #$201E;  // DOUBLE LOW-9 QUOTATION MARK
    $85: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $86: Result:= #$2020;  // DAGGER
    $87: Result:= #$2021;  // DOUBLE DAGGER
    $88: Result:= #$02C6;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $89: Result:= #$2030;  // PER MILLE SIGN
    $8B: Result:= #$2039;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $8C: Result:= #$0152;  // LATIN CAPITAL LIGATURE OE
    $91: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: Result:= #$201C;  // LEFT DOUBLE QUOTATION MARK
    $94: Result:= #$201D;  // RIGHT DOUBLE QUOTATION MARK
    $95: Result:= #$2022;  // BULLET
    $96: Result:= #$2013;  // EN DASH
    $97: Result:= #$2014;  // EM DASH
    $98: Result:= #$02DC;  // SMALL TILDE
    $99: Result:= #$2122;  // TRADE MARK SIGN
    $9B: Result:= #$203A;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $9C: Result:= #$0153;  // LATIN SMALL LIGATURE OE
    $9F: Result:= #$0178;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
    $C3: Result:= #$0102;  // LATIN CAPITAL LETTER A WITH BREVE
    $CC: Result:= #$0300;  // COMBINING GRAVE ACCENT
    $D0: Result:= #$0110;  // LATIN CAPITAL LETTER D WITH STROKE
    $D2: Result:= #$0309;  // COMBINING HOOK ABOVE
    $D5: Result:= #$01A0;  // LATIN CAPITAL LETTER O WITH HORN
    $DD: Result:= #$01AF;  // LATIN CAPITAL LETTER U WITH HORN
    $DE: Result:= #$0303;  // COMBINING TILDE
    $E3: Result:= #$0103;  // LATIN SMALL LETTER A WITH BREVE
    $EC: Result:= #$0301;  // COMBINING ACUTE ACCENT
    $F0: Result:= #$0111;  // LATIN SMALL LETTER D WITH STROKE
    $F2: Result:= #$0323;  // COMBINING DOT BELOW
    $F5: Result:= #$01A1;  // LATIN SMALL LETTER O WITH HORN
    $FD: Result:= #$01B0;  // LATIN SMALL LETTER U WITH HORN
    $FE: Result:= #$20AB;  // DONG SIGN
  else
    raise EConvertError.CreateFmt('Invalid Windows-1258 sequence of code point %d',[W]);
  end;
end;

function US_ASCIIToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, US_ASCIIToUTF16Char);
end;

function Iso8859_1ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, Iso8859_1ToUTF16Char);
end;

function Iso8859_2ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, Iso8859_2ToUTF16Char);
end;

function Iso8859_3ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, Iso8859_3ToUTF16Char);
end;

function Iso8859_4ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, Iso8859_4ToUTF16Char);
end;

function Iso8859_5ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, Iso8859_5ToUTF16Char);
end;

function Iso8859_6ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, Iso8859_6ToUTF16Char);
end;

function Iso8859_7ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, Iso8859_7ToUTF16Char);
end;

function Iso8859_8ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, Iso8859_8ToUTF16Char);
end;

function Iso8859_9ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, Iso8859_9ToUTF16Char);
end;

function Iso8859_10ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, Iso8859_10ToUTF16Char);
end;

function Iso8859_13ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, Iso8859_13ToUTF16Char);
end;

function Iso8859_14ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, Iso8859_14ToUTF16Char);
end;

function Iso8859_15ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, Iso8859_15ToUTF16Char);
end;

function KOI8_RToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, KOI8_RToUTF16Char);
end;

function JIS_X0201ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, JIS_X0201ToUTF16Char);
end;

function nextStepToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, nextStepToUTF16Char);
end;

function cp10000_MacRomanToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp10000_MacRomanToUTF16Char);
end;

function cp10006_MacGreekToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp10006_MacGreekToUTF16Char);
end;

function cp10007_MacCyrillicToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp10007_MacCyrillicToUTF16Char);
end;

function cp10029_MacLatin2ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp10029_MacLatin2ToUTF16Char);
end;

function cp10079_MacIcelandicToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp10079_MacIcelandicToUTF16Char);
end;

function cp10081_MacTurkishToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp10081_MacTurkishToUTF16Char);
end;

function cp037ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp037ToUTF16Char);
end;

function cp424ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp424ToUTF16Char);
end;

function cp437ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp437ToUTF16Char);
end;

function cp437_DOSLatinUSToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp437_DOSLatinUSToUTF16Char);
end;

function cp500ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp500ToUTF16Char);
end;

function cp737_DOSGreekToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp737_DOSGreekToUTF16Char);
end;

function cp775_DOSBaltRimToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp775_DOSBaltRimToUTF16Char);
end;

function cp850ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp850ToUTF16Char);
end;

function cp850_DOSLatin1ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp850_DOSLatin1ToUTF16Char);
end;

function cp852_DOSLatin2ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp852_DOSLatin2ToUTF16Char);
end;

function cp852ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp852ToUTF16Char);
end;

function cp855ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp855ToUTF16Char);
end;

function cp855_DOSCyrillicToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp855_DOSCyrillicToUTF16Char);
end;

function cp856_Hebrew_PCToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp856_Hebrew_PCToUTF16Char);
end;

function cp857ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp857ToUTF16Char);
end;

function cp857_DOSTurkishToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp857_DOSTurkishToUTF16Char);
end;

function cp860ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp860ToUTF16Char);
end;

function cp860_DOSPortugueseToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp860_DOSPortugueseToUTF16Char);
end;

function cp861ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp861ToUTF16Char);
end;

function cp861_DOSIcelandicToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp861_DOSIcelandicToUTF16Char);
end;

function cp862ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp862ToUTF16Char);
end;

function cp862_DOSHebrewToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp862_DOSHebrewToUTF16Char);
end;

function cp863ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp863ToUTF16Char);
end;

function cp863_DOSCanadaFToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp863_DOSCanadaFToUTF16Char);
end;

function cp864_DOSArabicToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp864_DOSArabicToUTF16Char);
end;

function cp864ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp864ToUTF16Char);
end;

function cp865ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp865ToUTF16Char);
end;

function cp865_DOSNordicToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp865_DOSNordicToUTF16Char);
end;

function cp866ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp866ToUTF16Char);
end;

function cp866_DOSCyrillicRussianToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp866_DOSCyrillicRussianToUTF16Char);
end;

function cp869ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp869ToUTF16Char);
end;

function cp869_DOSGreek2ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp869_DOSGreek2ToUTF16Char);
end;

function cp874ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp874ToUTF16Char);
end;

function cp875ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp875ToUTF16Char);
end;

function cp932ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp932ToUTF16Char);
end;

function cp936ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp936ToUTF16Char);
end;

function cp949ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp949ToUTF16Char);
end;

function cp950ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp950ToUTF16Char);
end;

function cp1006ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp1006ToUTF16Char);
end;

function cp1026ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp1026ToUTF16Char);
end;

function cp1250ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp1250ToUTF16Char);
end;

function cp1251ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp1251ToUTF16Char);
end;

function cp1252ToUTF16Str(const s: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp1252ToUTF16Char);
end;

function cp1253ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp1253ToUTF16Char);
end;

function cp1254ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp1254ToUTF16Char);
end;

function cp1255ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp1255ToUTF16Char);
end;

function cp1256ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp1256ToUTF16Char);
end;

function cp1257ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp1257ToUTF16Char);
end;

function cp1258ToUTF16Str(const S: string): WideString;
begin
  Result:= StrToUTF16WideStr(S, cp1258ToUTF16Char);
end;

function UTF8ToUTF16BEStr(const S: string): WideString;
// Converts an UTF-8 string into an UTF-16 WideString.
// No special conversions (e.g. on line breaks) and
// no XML-char checking are done.
// - This function was provided by Ernst van der Pols -
// - and slightly modified by Dieter Köhler -
const
  MaxCode: array[1..6] of integer = ($7F,$7FF,$FFFF,$1FFFFF,$3FFFFFF,$7FFFFFFF);
var
  i, j, CharSize, mask, ucs4: integer;
  c, first: char;
begin
  setLength(Result, Length(S)+1); // assume no or little above-ASCII-chars
  j := 0;                         // keep track of actual length
  i := 0;

  // Skip byte order mark:
  if Length(S) >= 3
    then if S[1] = #$EF
      then if S[2] = #$BB
        then if S[3] = #$BF
          then i := 3;

  while i < Length(S) do
  begin
    Inc(i); c:=S[i];
    if ord(c) >= $80 then       // UTF-8 sequence
    begin
      if (ord(c) and $C0) <> $C0 then
        raise EConvertError.CreateFmt('Invalid UTF-8 sequence %2.2X',[ord(c)]);

      CharSize:=1;
      first:= c; mask:= $40; ucs4:= ord(c);
      while (mask and ord(first)) <> 0 do
      begin
        // read next character of stream
        if i=length(S) then
          raise EConvertError.CreateFmt('Aborted UTF-8 sequence "%s"',[Copy(S,i-CharSize,CharSize)]);
        Inc(i); c:=S[i];
        if (ord(c) and $C0<>$80) then
          raise EConvertError.CreateFmt('Invalid UTF-8 sequence $%2.2X',[ord(c)]);
        ucs4:= (ucs4 shl 6) or (ord(c) and $3F); // add bits to Result
        Inc(CharSize);     // increase sequence length
        mask:= mask shr 1; // adjust mask
      end;
      if (CharSize>6) then // no 0 bit in sequence header 'first'
        raise EConvertError.CreateFmt('Invalid UTF-8 sequence "%s"',[Copy(S,i-CharSize,CharSize)]);
      ucs4:= ucs4 and MaxCode[CharSize]; // dispose of header bits
      // check for invalid sequence as suggested by RFC2279
      if ((CharSize>1) and (ucs4<=MaxCode[CharSize-1])) then
        raise EConvertError.CreateFmt('Invalid UTF-8 encoding "%s"',[Copy(S,i-CharSize,CharSize)]);
      // convert non-ASCII UCS-4 to UTF-16 if possible
      case ucs4 of
      $00000080..$0000D7FF,$0000E000..$0000FFFD:
        begin
          Inc(j); Result[j]:= WideChar(ucs4);
        end;
      $0000D800..$0000DFFF,$0000FFFE,$0000FFFF:
        raise EConvertError.CreateFmt('Invalid UCS-4 character $%8.8X',[ucs4]);
      $00010000..$0010FFFF:
        begin
          // add high surrogate to content as if it was processed earlier
          Inc(j); Result[j]:= Utf16HighSurrogate(ucs4);  // assign high surrogate
          Inc(j); Result[j]:= Utf16LowSurrogate(ucs4);   // assign low surrogate
        end;
      else // out of UTF-16 range
        raise EConvertError.CreateFmt('Cannot convert $%8.8X to UTF-16',[ucs4]);
      end;
    end
    else   // ASCII char
    begin
      Inc(j); Result[j]:= WideChar(ord(c));
    end;
  end;
  setLength(Result,j); // set to correct length
end;

function UTF16BEToUTF8Str(const WS: WideString): string;
var
  StringStream: TStringStream;
  UTF16To8: TUTF16BEToUTF8Stream;
begin
  StringStream := TStringStream.create('');
  try
    UTF16To8 := TUTF16BEToUTF8Stream.create(StringStream);
    try
      UTF16To8.WriteBuffer(pointer(WS)^, Length(WS) shl 1);
    finally
      UTF16To8.Free;
    end;
    Result := StringStream.DataString;
  finally
    StringStream.Free;
  end;
end;

function UTF16ToUS_ASCIIChar(const I: longint): char;
begin
  case I of
    $00..$7f: Result:= Char(I);
  else
    raise EConvertError.CreateFmt('Invalid US-ASCII sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToIso8859_1Char(const I: longint): char;
begin
  case I of
    $0000..$00ff: Result:= Char(I);
  else
   raise EConvertError.CreateFmt('Invalid ISO-8859-1 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToIso8859_2Char(const I: longint): char;
begin
  case I of
    $0000..$00a0: Result:= Char(I);
    $0102: Result:= #$c3;  // LATIN CAPITAL LETTER A WITH BREVE
    $0103: Result:= #$e3;  // LATIN SMALL LETTER A WITH BREVE
    $0104: Result:= #$a1;  // LATIN CAPITAL LETTER A WITH OGONEK
    $0105: Result:= #$b1;  // LATIN SMALL LETTER A WITH OGONEK
    $0106: Result:= #$c6;  // LATIN CAPITAL LETTER C WITH ACUTE
    $0107: Result:= #$e6;  // LATIN SMALL LETTER C WITH ACUTE
    $010c: Result:= #$c8;  // LATIN CAPITAL LETTER C WITH CARON
    $010d: Result:= #$e8;  // LATIN SMALL LETTER C WITH CARON
    $010e: Result:= #$cf;  // LATIN CAPITAL LETTER D WITH CARON
    $010f: Result:= #$ef;  // LATIN SMALL LETTER D WITH CARON
    $0110: Result:= #$d0;  // LATIN CAPITAL LETTER D WITH STROKE
    $0111: Result:= #$f0;  // LATIN SMALL LETTER D WITH STROKE
    $0118: Result:= #$ca;  // LATIN CAPITAL LETTER E WITH OGONEK
    $0119: Result:= #$ea;  // LATIN SMALL LETTER E WITH OGONEK
    $011a: Result:= #$cc;  // LATIN CAPITAL LETTER E WITH CARON
    $011b: Result:= #$ec;  // LATIN SMALL LETTER E WITH CARON
    $0132: Result:= #$a5;  // LATIN CAPITAL LETTER L WITH CARON
    $0139: Result:= #$c5;  // LATIN CAPITAL LETTER L WITH ACUTE
    $013a: Result:= #$e5;  // LATIN SMALL LETTER L WITH ACUTE
    $013e: Result:= #$b5;  // LATIN SMALL LETTER L WITH CARON
    $0141: Result:= #$a3;  // LATIN CAPITAL LETTER L WITH STROKE
    $0142: Result:= #$b3;  // LATIN SMALL LETTER L WITH STROKE
    $0143: Result:= #$d1;  // LATIN CAPITAL LETTER N WITH ACUTE
    $0144: Result:= #$f1;  // LATIN SMALL LETTER N WITH ACUTE
    $0147: Result:= #$d2;  // LATIN CAPITAL LETTER N WITH CARON
    $0148: Result:= #$f2;  // LATIN SMALL LETTER N WITH CARON
    $0150: Result:= #$d5;  // LATIN CAPITAL LETTER O WITH DOUBLE ACUTE
    $0151: Result:= #$f5;  // LATIN SMALL LETTER O WITH DOUBLE ACUTE
    $0154: Result:= #$c0;  // LATIN CAPITAL LETTER R WITH ACUTE
    $0155: Result:= #$e0;  // LATIN SMALL LETTER R WITH ACUTE
    $0158: Result:= #$d8;  // LATIN CAPITAL LETTER R WITH CARON
    $0159: Result:= #$f8;  // LATIN SMALL LETTER R WITH CARON
    $015a: Result:= #$a6;  // LATIN CAPITAL LETTER S WITH ACUTE
    $015b: Result:= #$b6;  // LATIN SMALL LETTER S WITH ACUTE
    $015e: Result:= #$aa;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $015f: Result:= #$ba;  // LATIN SMALL LETTER S WITH CEDILLA
    $0160: Result:= #$a9;  // LATIN CAPITAL LETTER S WITH CARON
    $0161: Result:= #$b9;  // LATIN SMALL LETTER S WITH CARON
    $0162: Result:= #$de;  // LATIN CAPITAL LETTER T WITH CEDILLA
    $0163: Result:= #$fe;  // LATIN SMALL LETTER T WITH CEDILLA
    $0164: Result:= #$ab;  // LATIN CAPITAL LETTER T WITH CARON
    $0165: Result:= #$bb;  // LATIN SMALL LETTER T WITH CARON
    $016e: Result:= #$d9;  // LATIN CAPITAL LETTER U WITH RING ABOVE
    $016f: Result:= #$f9;  // LATIN SMALL LETTER U WITH RING ABOVE
    $0170: Result:= #$db;  // LATIN CAPITAL LETTER U WITH WITH DOUBLE ACUTE
    $0171: Result:= #$fb;  // LATIN SMALL LETTER U WITH WITH DOUBLE ACUTE
    $0179: Result:= #$ac;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $017a: Result:= #$bc;  // LATIN SMALL LETTER Z WITH ACUTE
    $017b: Result:= #$af;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $017c: Result:= #$bf;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $017d: Result:= #$ae;  // LATIN CAPITAL LETTER Z WITH CARON
    $017e: Result:= #$be;  // LATIN SMALL LETTER Z WITH CARON
    $02c7: Result:= #$b7;  // CARON
    $02d8: Result:= #$a2;  // BREVE
    $02d9: Result:= #$ff;  // DOT ABOVE
    $02db: Result:= #$b2;  // OGONEK
    $02dd: Result:= #$bd;  // DOUBLE ACUTE ACCENT
  else
   raise EConvertError.CreateFmt('Invalid ISO-8859-2 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToIso8859_3Char(const I: longint): char;
begin
  case I of
    $0000..$00a0,$00a3..$00a4,$00a7..$00a8,$00ad,$00b0,$00b2..$00b5,$00b7..$00b8,
    $00bd,$00c0..$00c2,$00c4,$00c7..$00cf,$00d1..$00d7,$00d9..$00dc,$00df..$00e2,
    $00e4,$00e7..$00ef,$00f1..$00f7,$00f9..$00fc:
           Result:= Char(I);
    $0108: Result:= #$C6;  // LATIN CAPITAL LETTER C WITH CIRCUMFLEX
    $0109: Result:= #$E6;  // LATIN SMALL LETTER C WITH CIRCUMFLEX
    $010A: Result:= #$C5;  // LATIN CAPITAL LETTER C WITH DOT ABOVE
    $010B: Result:= #$E5;  // LATIN SMALL LETTER C WITH DOT ABOVE
    $011C: Result:= #$D8;  // LATIN CAPITAL LETTER G WITH CIRCUMFLEX
    $011D: Result:= #$F8;  // LATIN SMALL LETTER G WITH CIRCUMFLEX
    $011E: Result:= #$AB;  // LATIN CAPITAL LETTER G WITH BREVE
    $011F: Result:= #$BB;  // LATIN SMALL LETTER G WITH BREVE
    $0120: Result:= #$D5;  // LATIN CAPITAL LETTER G WITH DOT ABOVE
    $0121: Result:= #$F5;  // LATIN SMALL LETTER G WITH DOT ABOVE
    $0124: Result:= #$A6;  // LATIN CAPITAL LETTER H WITH CIRCUMFLEX
    $0125: Result:= #$B6;  // LATIN SMALL LETTER H WITH CIRCUMFLEX
    $0126: Result:= #$A1;  // LATIN CAPITAL LETTER H WITH STROKE
    $0127: Result:= #$B1;  // LATIN SMALL LETTER H WITH STROKE
    $0130: Result:= #$A9;  // LATIN CAPITAL LETTER I WITH DOT ABOVE
    $0131: Result:= #$B9;  // LATIN SMALL LETTER DOTLESS I
    $0134: Result:= #$AC;  // LATIN CAPITAL LETTER J WITH CIRCUMFLEX
    $0135: Result:= #$BC;  // LATIN SMALL LETTER J WITH CIRCUMFLEX
    $015C: Result:= #$DE;  // LATIN CAPITAL LETTER S WITH CIRCUMFLEX
    $015D: Result:= #$FE;  // LATIN SMALL LETTER S WITH CIRCUMFLEX
    $015E: Result:= #$AA;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $015F: Result:= #$BA;  // LATIN SMALL LETTER S WITH CEDILLA
    $016C: Result:= #$DD;  // LATIN CAPITAL LETTER U WITH BREVE
    $016D: Result:= #$FD;  // LATIN SMALL LETTER U WITH BREVE
    $017B: Result:= #$AF;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $017C: Result:= #$BF;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $02D8: Result:= #$A2;  // BREVE
    $02D9: Result:= #$FF;  // DOT ABOVE
  else
   raise EConvertError.CreateFmt('Invalid ISO-8859-3 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToIso8859_4Char(const I: longint): char;
begin
  case I of
    $0000..$00a0,$00a4,$00a7..$00a8,$00ad,$00af..$00b0,$00b4,$00b8,$00c1..$00c6,
    $00c9,$00cb,$00cd..$00ce,$00d4..$00d8,$00da..$00dc,$00df,$00e1..$00e6,$00e9,
    $00eb,$00ed..$00ee,$00f4..$00f8,$00fa..$00fc:
           Result:= Char(I);
    $0100: Result:= #$C0;  // LATIN CAPITAL LETTER A WITH MACRON
    $0101: Result:= #$E0;  // LATIN SMALL LETTER A WITH MACRON
    $0104: Result:= #$A1;  // LATIN CAPITAL LETTER A WITH OGONEK
    $0105: Result:= #$B1;  // LATIN SMALL LETTER A WITH OGONEK
    $010C: Result:= #$C8;  // LATIN CAPITAL LETTER C WITH CARON
    $010D: Result:= #$E8;  // LATIN SMALL LETTER C WITH CARON
    $0110: Result:= #$D0;  // LATIN CAPITAL LETTER D WITH STROKE
    $0111: Result:= #$F0;  // LATIN SMALL LETTER D WITH STROKE
    $0112: Result:= #$AA;  // LATIN CAPITAL LETTER E WITH MACRON
    $0113: Result:= #$BA;  // LATIN SMALL LETTER E WITH MACRON
    $0116: Result:= #$CC;  // LATIN CAPITAL LETTER E WITH DOT ABOVE
    $0117: Result:= #$EC;  // LATIN SMALL LETTER E WITH DOT ABOVE
    $0118: Result:= #$CA;  // LATIN CAPITAL LETTER E WITH OGONEK
    $0119: Result:= #$EA;  // LATIN SMALL LETTER E WITH OGONEK
    $0122: Result:= #$AB;  // LATIN CAPITAL LETTER G WITH CEDILLA
    $0123: Result:= #$BB;  // LATIN SMALL LETTER G WITH CEDILLA
    $0128: Result:= #$A5;  // LATIN CAPITAL LETTER I WITH TILDE
    $0129: Result:= #$B5;  // LATIN SMALL LETTER I WITH TILDE
    $012A: Result:= #$CF;  // LATIN CAPITAL LETTER I WITH MACRON
    $012B: Result:= #$EF;  // LATIN SMALL LETTER I WITH MACRON
    $012E: Result:= #$C7;  // LATIN CAPITAL LETTER I WITH OGONEK
    $012F: Result:= #$E7;  // LATIN SMALL LETTER I WITH OGONEK
    $0136: Result:= #$D3;  // LATIN CAPITAL LETTER K WITH CEDILLA
    $0137: Result:= #$F3;  // LATIN SMALL LETTER K WITH CEDILLA
    $0138: Result:= #$A2;  // LATIN SMALL LETTER KRA
    $013B: Result:= #$A6;  // LATIN CAPITAL LETTER L WITH CEDILLA
    $013C: Result:= #$B6;  // LATIN SMALL LETTER L WITH CEDILLA
    $0145: Result:= #$D1;  // LATIN CAPITAL LETTER N WITH CEDILLA
    $0146: Result:= #$F1;  // LATIN SMALL LETTER N WITH CEDILLA
    $014A: Result:= #$BD;  // LATIN CAPITAL LETTER ENG
    $014B: Result:= #$BF;  // LATIN SMALL LETTER ENG
    $014C: Result:= #$D2;  // LATIN CAPITAL LETTER O WITH MACRON
    $014D: Result:= #$F2;  // LATIN SMALL LETTER O WITH MACRON
    $0156: Result:= #$A3;  // LATIN CAPITAL LETTER R WITH CEDILLA
    $0157: Result:= #$B3;  // LATIN SMALL LETTER R WITH CEDILLA
    $0160: Result:= #$A9;  // LATIN CAPITAL LETTER S WITH CARON
    $0161: Result:= #$B9;  // LATIN SMALL LETTER S WITH CARON
    $0166: Result:= #$AC;  // LATIN CAPITAL LETTER T WITH STROKE
    $0167: Result:= #$BC;  // LATIN SMALL LETTER T WITH STROKE
    $0168: Result:= #$DD;  // LATIN CAPITAL LETTER U WITH TILDE
    $0169: Result:= #$FD;  // LATIN SMALL LETTER U WITH TILDE
    $016A: Result:= #$DE;  // LATIN CAPITAL LETTER U WITH MACRON
    $016B: Result:= #$FE;  // LATIN SMALL LETTER U WITH MACRON
    $0172: Result:= #$D9;  // LATIN CAPITAL LETTER U WITH OGONEK
    $0173: Result:= #$F9;  // LATIN SMALL LETTER U WITH OGONEK
    $017D: Result:= #$AE;  // LATIN CAPITAL LETTER Z WITH CARON
    $017E: Result:= #$BE;  // LATIN SMALL LETTER Z WITH CARON
    $02C7: Result:= #$B7;  // CARON
    $02D9: Result:= #$FF;  // DOT ABOVE
    $02DB: Result:= #$B2;  // OGONEK
  else
   raise EConvertError.CreateFmt('Invalid ISO-8859-4 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToIso8859_5Char(const I: longint): char;
begin
  case I of
    $0000..$00a0,$00ad: Result:= Char(I);
    $00a7: Result:= #$fd;  // SECTION SIGN
    $0401..$045f: Result:= char(I-$0360);
    $2116: Result:= #$f0;  // NUMERO SIGN
  else
   raise EConvertError.CreateFmt('Invalid ISO-8859-5 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToIso8859_6Char(const I: longint): char;
begin
  case I of
    $0000..$00a0,$00a4,$00ad: Result:= Char(I);
    $060c,$061b,$061f,$0621..$063a,$0640..$0652:
      Result:= char(I-$0580);
  else
   raise EConvertError.CreateFmt('Invalid ISO-8859-6 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToIso8859_7Char(const I: longint): char;
begin
  case I of
    $00..$00a0,$00a3,$00a6..$00a9,$00ab..$00ad,$00b0..$00b3,$00b7,$00bb,$00bd:
      Result:= Char(I);
    $0384..$0386,$0388..$038a,$038c,$038e..$03a1,$03a3..$03ce:
      Result:= char(I-$02d0);
    $2015: Result:= #$af;  // HORIZONTAL BAR
    $2018: Result:= #$a1;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$a2;  // RIGHT SINGLE QUOTATION MARK
  else
   raise EConvertError.CreateFmt('Invalid ISO-8859-7 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToIso8859_8Char(const I: longint): char;
begin
  case I of
    $0000..$00a0,$00a2..$00a9,$00ab..$00ae,$00b0..$00b9,$00bb..$00be:
      Result:= Char(I);
    $00d7: Result:= #$aa;  // MULTIPLICATION SIGN
    $00f7: Result:= #$ba;  // DIVISION SIGN
    $05d0..$05ea: Result:= char(I-$04e0);
    $2017: Result:= #$df;  // DOUBLE LOW LINE
    $203e: Result:= #$af;  // OVERLINE
  else
   raise EConvertError.CreateFmt('Invalid ISO-8859-8 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToIso8859_9Char(const I: longint): char;
begin
  case I of
    $0000..$00cf,$00d1..$00dc,$00df..$00ef,$00f1..$00fc,$00ff:
      Result:= Char(I);
    $011E: Result:= #$D0;  // LATIN CAPITAL LETTER G WITH BREVE
    $011F: Result:= #$F0;  // LATIN SMALL LETTER G WITH BREVE
    $0130: Result:= #$DD;  // LATIN CAPITAL LETTER I WITH DOT ABOVE
    $0131: Result:= #$FD;  // LATIN SMALL LETTER DOTLESS I
    $015E: Result:= #$DE;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $015F: Result:= #$FE;  // LATIN SMALL LETTER S WITH CEDILLA
  else
   raise EConvertError.CreateFmt('Invalid ISO-8859-9 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToIso8859_10Char(const I: longint): char;
begin
  case I of
    $0000..$00a0,$00a7,$00ad,$00b0,$00b7,$00c1..$00c6,$00c9,$00cb,$00cd..$00d0,
    $00d3..$00d6,$00d8,$00da..$00df,$00e1..$00e6,$00e9,$00eb,$00ed..$00f0,
    $00f3..$00f6,$00f8,$00fa..$00fe:
           Result:= Char(I);
    $0100: Result:= #$C0;  // LATIN CAPITAL LETTER A WITH MACRON
    $0101: Result:= #$E0;  // LATIN SMALL LETTER A WITH MACRON
    $0104: Result:= #$A1;  // LATIN CAPITAL LETTER A WITH OGONEK
    $0105: Result:= #$B1;  // LATIN SMALL LETTER A WITH OGONEK
    $010C: Result:= #$C8;  // LATIN CAPITAL LETTER C WITH CARON
    $010D: Result:= #$E8;  // LATIN SMALL LETTER C WITH CARON
    $0110: Result:= #$A9;  // LATIN CAPITAL LETTER D WITH STROKE
    $0111: Result:= #$B9;  // LATIN SMALL LETTER D WITH STROKE
    $0112: Result:= #$A2;  // LATIN CAPITAL LETTER E WITH MACRON
    $0113: Result:= #$B2;  // LATIN SMALL LETTER E WITH MACRON
    $0116: Result:= #$CC;  // LATIN CAPITAL LETTER E WITH DOT ABOVE
    $0117: Result:= #$EC;  // LATIN SMALL LETTER E WITH DOT ABOVE
    $0118: Result:= #$CA;  // LATIN CAPITAL LETTER E WITH OGONEK
    $0119: Result:= #$EA;  // LATIN SMALL LETTER E WITH OGONEK
    $0122: Result:= #$A3;  // LATIN CAPITAL LETTER G WITH CEDILLA
    $0123: Result:= #$B3;  // LATIN SMALL LETTER G WITH CEDILLA
    $0128: Result:= #$A5;  // LATIN CAPITAL LETTER I WITH TILDE
    $0129: Result:= #$B5;  // LATIN SMALL LETTER I WITH TILDE
    $012A: Result:= #$A4;  // LATIN CAPITAL LETTER I WITH MACRON
    $012B: Result:= #$B4;  // LATIN SMALL LETTER I WITH MACRON
    $012E: Result:= #$C7;  // LATIN CAPITAL LETTER I WITH OGONEK
    $012F: Result:= #$E7;  // LATIN SMALL LETTER I WITH OGONEK
    $0136: Result:= #$A6;  // LATIN CAPITAL LETTER K WITH CEDILLA
    $0137: Result:= #$B6;  // LATIN SMALL LETTER K WITH CEDILLA
    $0138: Result:= #$FF;  // LATIN SMALL LETTER KRA
    $013B: Result:= #$A8;  // LATIN CAPITAL LETTER L WITH CEDILLA
    $013C: Result:= #$B8;  // LATIN SMALL LETTER L WITH CEDILLA
    $0145: Result:= #$D1;  // LATIN CAPITAL LETTER N WITH CEDILLA
    $0146: Result:= #$F1;  // LATIN SMALL LETTER N WITH CEDILLA
    $014A: Result:= #$AF;  // LATIN CAPITAL LETTER ENG
    $014B: Result:= #$BF;  // LATIN SMALL LETTER ENG
    $014C: Result:= #$D2;  // LATIN CAPITAL LETTER O WITH MACRON
    $014D: Result:= #$F2;  // LATIN SMALL LETTER O WITH MACRON
    $0160: Result:= #$AA;  // LATIN CAPITAL LETTER S WITH CARON
    $0161: Result:= #$BA;  // LATIN SMALL LETTER S WITH CARON
    $0166: Result:= #$AB;  // LATIN CAPITAL LETTER T WITH STROKE
    $0167: Result:= #$BB;  // LATIN SMALL LETTER T WITH STROKE
    $0168: Result:= #$D7;  // LATIN CAPITAL LETTER U WITH TILDE
    $0169: Result:= #$F7;  // LATIN SMALL LETTER U WITH TILDE
    $016A: Result:= #$AE;  // LATIN CAPITAL LETTER U WITH MACRON
    $016B: Result:= #$BE;  // LATIN SMALL LETTER U WITH MACRON
    $0172: Result:= #$D9;  // LATIN CAPITAL LETTER U WITH OGONEK
    $0173: Result:= #$F9;  // LATIN SMALL LETTER U WITH OGONEK
    $017D: Result:= #$AC;  // LATIN CAPITAL LETTER Z WITH CARON
    $017E: Result:= #$BC;  // LATIN SMALL LETTER Z WITH CARON
    $2015: Result:= #$BD;  // HORIZONTAL BAR
  else
   raise EConvertError.CreateFmt('Invalid ISO-8859-10 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToIso8859_13Char(const I: longint): char;
begin
  case I of
    $0000..$00a0,$00a2..$00a4,$00a6..$00a7,$00a9,$00ab..$00ae,$00b0..$00b3,
    $00b5..$00b7,$00b9,$00bb..$00be,$00c4..$00c6,$00c9,$00d3,$00d5..$00d8,
    $00dc,$00df,$00e4..$00e6,$00f3,$00f5..$00f8,$00fc:
           Result:= Char(I);
    $0100: Result:= #$C2;  // LATIN CAPITAL LETTER A WITH MACRON
    $0101: Result:= #$E2;  // LATIN SMALL LETTER A WITH MACRON
    $0104: Result:= #$C0;  // LATIN CAPITAL LETTER A WITH OGONEK
    $0105: Result:= #$E0;  // LATIN SMALL LETTER A WITH OGONEK
    $0106: Result:= #$C3;  // LATIN CAPITAL LETTER C WITH ACUTE
    $0107: Result:= #$E3;  // LATIN SMALL LETTER C WITH ACUTE
    $010C: Result:= #$C8;  // LATIN CAPITAL LETTER C WITH CARON
    $010D: Result:= #$E8;  // LATIN SMALL LETTER C WITH CARON
    $0112: Result:= #$C7;  // LATIN CAPITAL LETTER E WITH MACRON
    $0113: Result:= #$E7;  // LATIN SMALL LETTER E WITH MACRON
    $0116: Result:= #$CB;  // LATIN CAPITAL LETTER E WITH DOT ABOVE
    $0117: Result:= #$EB;  // LATIN SMALL LETTER E WITH DOT ABOVE
    $0118: Result:= #$C6;  // LATIN CAPITAL LETTER E WITH OGONEK
    $0119: Result:= #$E6;  // LATIN SMALL LETTER E WITH OGONEK
    $0122: Result:= #$CC;  // LATIN CAPITAL LETTER G WITH CEDILLA
    $0123: Result:= #$EC;  // LATIN SMALL LETTER G WITH CEDILLA
    $012A: Result:= #$CE;  // LATIN CAPITAL LETTER I WITH MACRON
    $012B: Result:= #$EE;  // LATIN SMALL LETTER I WITH MACRON
    $012E: Result:= #$C1;  // LATIN CAPITAL LETTER I WITH OGONEK
    $012F: Result:= #$E1;  // LATIN SMALL LETTER I WITH OGONEK
    $0136: Result:= #$CD;  // LATIN CAPITAL LETTER K WITH CEDILLA
    $0137: Result:= #$ED;  // LATIN SMALL LETTER K WITH CEDILLA
    $013B: Result:= #$CF;  // LATIN CAPITAL LETTER L WITH CEDILLA
    $013C: Result:= #$EF;  // LATIN SMALL LETTER L WITH CEDILLA
    $0141: Result:= #$D9;  // LATIN CAPITAL LETTER L WITH STROKE
    $0142: Result:= #$F9;  // LATIN SMALL LETTER L WITH STROKE
    $0143: Result:= #$D1;  // LATIN CAPITAL LETTER N WITH ACUTE
    $0144: Result:= #$F1;  // LATIN SMALL LETTER N WITH ACUTE
    $0145: Result:= #$D2;  // LATIN CAPITAL LETTER N WITH CEDILLA
    $0146: Result:= #$F2;  // LATIN SMALL LETTER N WITH CEDILLA
    $014C: Result:= #$D4;  // LATIN CAPITAL LETTER O WITH MACRON
    $014D: Result:= #$F4;  // LATIN SMALL LETTER O WITH MACRON
    $0156: Result:= #$AA;  // LATIN CAPITAL LETTER R WITH CEDILLA
    $0157: Result:= #$BA;  // LATIN SMALL LETTER R WITH CEDILLA
    $015A: Result:= #$DA;  // LATIN CAPITAL LETTER S WITH ACUTE
    $015B: Result:= #$FA;  // LATIN SMALL LETTER S WITH ACUTE
    $0160: Result:= #$D0;  // LATIN CAPITAL LETTER S WITH CARON
    $0161: Result:= #$F0;  // LATIN SMALL LETTER S WITH CARON
    $016A: Result:= #$DB;  // LATIN CAPITAL LETTER U WITH MACRON
    $016B: Result:= #$FB;  // LATIN SMALL LETTER U WITH MACRON
    $0172: Result:= #$D8;  // LATIN CAPITAL LETTER U WITH OGONEK
    $0173: Result:= #$F8;  // LATIN SMALL LETTER U WITH OGONEK
    $0179: Result:= #$CA;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $017A: Result:= #$EA;  // LATIN SMALL LETTER Z WITH ACUTE
    $017B: Result:= #$DD;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $017C: Result:= #$FD;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $017D: Result:= #$DE;  // LATIN CAPITAL LETTER Z WITH CARON
    $017E: Result:= #$FE;  // LATIN SMALL LETTER Z WITH CARON
    $2019: Result:= #$FF;  // RIGHT SINGLE QUOTATION MARK
    $201C: Result:= #$B4;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$A1;  // RIGHT DOUBLE QUOTATION MARK
    $201E: Result:= #$A5;  // DOUBLE LOW-9 QUOTATION MARK
  else
   raise EConvertError.CreateFmt('Invalid ISO-8859-13 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToIso8859_14Char(const I: longint): char;
begin
  case I of
    $0000..$00a0,$00a3,$00a7,$00a9,$00ad..$00ae,$00b6,$00c0..$00cf,$00d1..$00d6,
    $00d8..$00dd,$00df..$00ef,$00f1..$00f6,$00f8..$00fd,$00ff:
           Result:= Char(I);
    $010A: Result:= #$A4;  // LATIN CAPITAL LETTER C WITH DOT ABOVE
    $010B: Result:= #$A5;  // LATIN SMALL LETTER C WITH DOT ABOVE
    $0120: Result:= #$B2;  // LATIN CAPITAL LETTER G WITH DOT ABOVE
    $0121: Result:= #$B3;  // LATIN SMALL LETTER G WITH DOT ABOVE
    $0174: Result:= #$D0;  // LATIN CAPITAL LETTER W WITH CIRCUMFLEX
    $0175: Result:= #$F0;  // LATIN SMALL LETTER W WITH CIRCUMFLEX
    $0176: Result:= #$DE;  // LATIN CAPITAL LETTER Y WITH CIRCUMFLEX
    $0177: Result:= #$FE;  // LATIN SMALL LETTER Y WITH CIRCUMFLEX
    $0178: Result:= #$AF;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
    $1E02: Result:= #$A1;  // LATIN CAPITAL LETTER B WITH DOT ABOVE
    $1E03: Result:= #$A2;  // LATIN SMALL LETTER B WITH DOT ABOVE
    $1E0A: Result:= #$A6;  // LATIN CAPITAL LETTER D WITH DOT ABOVE
    $1E0B: Result:= #$AB;  // LATIN SMALL LETTER D WITH DOT ABOVE
    $1E1E: Result:= #$B0;  // LATIN CAPITAL LETTER F WITH DOT ABOVE
    $1E1F: Result:= #$B1;  // LATIN SMALL LETTER F WITH DOT ABOVE
    $1E40: Result:= #$B4;  // LATIN CAPITAL LETTER M WITH DOT ABOVE
    $1E41: Result:= #$B5;  // LATIN SMALL LETTER M WITH DOT ABOVE
    $1E56: Result:= #$B7;  // LATIN CAPITAL LETTER P WITH DOT ABOVE
    $1E57: Result:= #$B9;  // LATIN SMALL LETTER P WITH DOT ABOVE
    $1E60: Result:= #$BB;  // LATIN CAPITAL LETTER S WITH DOT ABOVE
    $1E61: Result:= #$BF;  // LATIN SMALL LETTER S WITH DOT ABOVE
    $1E6A: Result:= #$D7;  // LATIN CAPITAL LETTER T WITH DOT ABOVE
    $1E6B: Result:= #$F7;  // LATIN SMALL LETTER T WITH DOT ABOVE
    $1E80: Result:= #$A8;  // LATIN CAPITAL LETTER W WITH GRAVE
    $1E81: Result:= #$B8;  // LATIN SMALL LETTER W WITH GRAVE
    $1E82: Result:= #$AA;  // LATIN CAPITAL LETTER W WITH ACUTE
    $1E83: Result:= #$BA;  // LATIN SMALL LETTER W WITH ACUTE
    $1E84: Result:= #$BD;  // LATIN CAPITAL LETTER W WITH DIAERESIS
    $1E85: Result:= #$BE;  // LATIN SMALL LETTER W WITH DIAERESIS
    $1EF2: Result:= #$AC;  // LATIN CAPITAL LETTER Y WITH GRAVE
    $1EF3: Result:= #$BC;  // LATIN SMALL LETTER Y WITH GRAVE
  else
   raise EConvertError.CreateFmt('Invalid ISO-8859-14 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToIso8859_15Char(const I: longint): char;
begin
  case I of
    $0000..$00a3,$00a5,$00a7,$00a9..$00b3,$00b5..$00b7,$00b9..$00bb,$00bf..$00ff:
           Result:= Char(I);
    $0152: Result:= #$BC;  // LATIN CAPITAL LIGATURE OE
    $0153: Result:= #$BD;  // LATIN SMALL LIGATURE OE
    $0160: Result:= #$A6;  // LATIN CAPITAL LETTER S WITH CARON
    $0161: Result:= #$A8;  // LATIN SMALL LETTER S WITH CARON
    $0178: Result:= #$BE;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
    $017D: Result:= #$B4;  // LATIN CAPITAL LETTER Z WITH CARON
    $017E: Result:= #$B8;  // LATIN SMALL LETTER Z WITH CARON
    $20AC: Result:= #$A4;  // EURO SIGN
  else
   raise EConvertError.CreateFmt('Invalid ISO-8859-15 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToKOI8_RChar(const I: longint): char;
begin
  case I of
    $0000..$007f: Result:= Char(I);
    $00A0: Result:= #$9A;  // NO-BREAK SPACE
    $00A9: Result:= #$BF;  // COPYRIGHT SIGN
    $00B0: Result:= #$9C;  // DEGREE SIGN
    $00B2: Result:= #$9D;  // SUPERSCRIPT TWO
    $00B7: Result:= #$9E;  // MIDDLE DOT
    $00F7: Result:= #$9F;  // DIVISION SIGN
    $0401: Result:= #$B3;  // CYRILLIC CAPITAL LETTER IO
    $0410: Result:= #$E1;  // CYRILLIC CAPITAL LETTER A
    $0411: Result:= #$E2;  // CYRILLIC CAPITAL LETTER BE
    $0412: Result:= #$F7;  // CYRILLIC CAPITAL LETTER VE
    $0413: Result:= #$E7;  // CYRILLIC CAPITAL LETTER GHE
    $0414: Result:= #$E4;  // CYRILLIC CAPITAL LETTER DE
    $0415: Result:= #$E5;  // CYRILLIC CAPITAL LETTER IE
    $0416: Result:= #$F6;  // CYRILLIC CAPITAL LETTER ZHE
    $0417: Result:= #$FA;  // CYRILLIC CAPITAL LETTER ZE
    $0418: Result:= #$E9;  // CYRILLIC CAPITAL LETTER I
    $0419: Result:= #$EA;  // CYRILLIC CAPITAL LETTER SHORT I
    $041A: Result:= #$EB;  // CYRILLIC CAPITAL LETTER KA
    $041B: Result:= #$EC;  // CYRILLIC CAPITAL LETTER EL
    $041C: Result:= #$ED;  // CYRILLIC CAPITAL LETTER EM
    $041D: Result:= #$EE;  // CYRILLIC CAPITAL LETTER EN
    $041E: Result:= #$EF;  // CYRILLIC CAPITAL LETTER O
    $041F: Result:= #$F0;  // CYRILLIC CAPITAL LETTER PE
    $0420: Result:= #$F2;  // CYRILLIC CAPITAL LETTER ER
    $0421: Result:= #$F3;  // CYRILLIC CAPITAL LETTER ES
    $0422: Result:= #$F4;  // CYRILLIC CAPITAL LETTER TE
    $0423: Result:= #$F5;  // CYRILLIC CAPITAL LETTER U
    $0424: Result:= #$E6;  // CYRILLIC CAPITAL LETTER EF
    $0425: Result:= #$E8;  // CYRILLIC CAPITAL LETTER HA
    $0426: Result:= #$E3;  // CYRILLIC CAPITAL LETTER TSE
    $0427: Result:= #$FE;  // CYRILLIC CAPITAL LETTER CHE
    $0428: Result:= #$FB;  // CYRILLIC CAPITAL LETTER SHA
    $0429: Result:= #$FD;  // CYRILLIC CAPITAL LETTER SHCHA
    $042A: Result:= #$FF;  // CYRILLIC CAPITAL LETTER HARD SIGN
    $042B: Result:= #$F9;  // CYRILLIC CAPITAL LETTER YERU
    $042C: Result:= #$F8;  // CYRILLIC CAPITAL LETTER SOFT SIGN
    $042D: Result:= #$FC;  // CYRILLIC CAPITAL LETTER E
    $042E: Result:= #$E0;  // CYRILLIC CAPITAL LETTER YU
    $042F: Result:= #$F1;  // CYRILLIC CAPITAL LETTER YA
    $0430: Result:= #$C1;  // CYRILLIC SMALL LETTER A
    $0431: Result:= #$C2;  // CYRILLIC SMALL LETTER BE
    $0432: Result:= #$D7;  // CYRILLIC SMALL LETTER VE
    $0433: Result:= #$C7;  // CYRILLIC SMALL LETTER GHE
    $0434: Result:= #$C4;  // CYRILLIC SMALL LETTER DE
    $0435: Result:= #$C5;  // CYRILLIC SMALL LETTER IE
    $0436: Result:= #$D6;  // CYRILLIC SMALL LETTER ZHE
    $0437: Result:= #$DA;  // CYRILLIC SMALL LETTER ZE
    $0438: Result:= #$C9;  // CYRILLIC SMALL LETTER I
    $0439: Result:= #$CA;  // CYRILLIC SMALL LETTER SHORT I
    $043A: Result:= #$CB;  // CYRILLIC SMALL LETTER KA
    $043B: Result:= #$CC;  // CYRILLIC SMALL LETTER EL
    $043C: Result:= #$CD;  // CYRILLIC SMALL LETTER EM
    $043D: Result:= #$CE;  // CYRILLIC SMALL LETTER EN
    $043E: Result:= #$CF;  // CYRILLIC SMALL LETTER O
    $043F: Result:= #$D0;  // CYRILLIC SMALL LETTER PE
    $0440: Result:= #$D2;  // CYRILLIC SMALL LETTER ER
    $0441: Result:= #$D3;  // CYRILLIC SMALL LETTER ES
    $0442: Result:= #$D4;  // CYRILLIC SMALL LETTER TE
    $0443: Result:= #$D5;  // CYRILLIC SMALL LETTER U
    $0444: Result:= #$C6;  // CYRILLIC SMALL LETTER EF
    $0445: Result:= #$C8;  // CYRILLIC SMALL LETTER HA
    $0446: Result:= #$C3;  // CYRILLIC SMALL LETTER TSE
    $0447: Result:= #$DE;  // CYRILLIC SMALL LETTER CHE
    $0448: Result:= #$DB;  // CYRILLIC SMALL LETTER SHA
    $0449: Result:= #$DD;  // CYRILLIC SMALL LETTER SHCHA
    $044A: Result:= #$DF;  // CYRILLIC SMALL LETTER HARD SIGN
    $044B: Result:= #$D9;  // CYRILLIC SMALL LETTER YERU
    $044C: Result:= #$D8;  // CYRILLIC SMALL LETTER SOFT SIGN
    $044D: Result:= #$DC;  // CYRILLIC SMALL LETTER E
    $044E: Result:= #$C0;  // CYRILLIC SMALL LETTER YU
    $044F: Result:= #$D1;  // CYRILLIC SMALL LETTER YA
    $0451: Result:= #$A3;  // CYRILLIC SMALL LETTER IO
    $2219: Result:= #$95;  // BULLET OPERATOR
    $221A: Result:= #$96;  // SQUARE ROOT
    $2248: Result:= #$97;  // ALMOST EQUAL TO
    $2264: Result:= #$98;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$99;  // GREATER-THAN OR EQUAL TO
    $2320: Result:= #$93;  // TOP HALF INTEGRAL
    $2321: Result:= #$9B;  // BOTTOM HALF INTEGRAL
    $2500: Result:= #$80;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$81;  // BOX DRAWINGS LIGHT VERTICAL
    $250C: Result:= #$82;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$83;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$84;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$85;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251C: Result:= #$86;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$87;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252C: Result:= #$88;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$89;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253C: Result:= #$8A;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$A0;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$A1;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: Result:= #$A2;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $2553: Result:= #$A4;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: Result:= #$A5;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: Result:= #$A6;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: Result:= #$A7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: Result:= #$A8;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: Result:= #$A9;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: Result:= #$AA;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255A: Result:= #$AB;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255B: Result:= #$AC;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255C: Result:= #$AD;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255D: Result:= #$AE;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255E: Result:= #$AF;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255F: Result:= #$B0;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: Result:= #$B1;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: Result:= #$B2;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $2562: Result:= #$B4;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: Result:= #$B5;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: Result:= #$B6;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: Result:= #$B7;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: Result:= #$B8;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: Result:= #$B9;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: Result:= #$BA;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: Result:= #$BB;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256A: Result:= #$BC;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256B: Result:= #$BD;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256C: Result:= #$BE;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$8B;  // UPPER HALF BLOCK
    $2584: Result:= #$8C;  // LOWER HALF BLOCK
    $2588: Result:= #$8D;  // FULL BLOCK
    $258C: Result:= #$8E;  // LEFT HALF BLOCK
    $2590: Result:= #$8F;  // RIGHT HALF BLOCK
    $2591: Result:= #$90;  // LIGHT SHADE
    $2592: Result:= #$91;  // MEDIUM SHADE
    $2593: Result:= #$92;  // DARK SHADE
    $25A0: Result:= #$94;  // BLACK SQUARE
  else
   raise EConvertError.CreateFmt('Invalid KOI8-R sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToJIS_X0201Char(const I: longint): char;
begin
  case I of
    $0020..$005B,$005D..$007D:
      Result:= Char(I);
    $00A5: Result:= #$5C;  //  YEN SIGN
    $203E: Result:= #$7E;  //  OVERLINE
    $FF61..$FF9F: Result:= Char(I-$FEC0);
  else
    raise EConvertError.CreateFmt('Invalid JIS_X0201 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToNextStepChar(const I: longint): char;
begin
  case I of
    $0000..$007F,$00a1..$00a3,$00a5,$00a7,$00ab,$00b6,$00bb,$00bf:
      Result:= Char(I);
    $00a0: Result:= #$80;  //  NO-BREAK SPACE
    $00a4: Result:= #$a8;  //  CURRENCY SIGN
    $00a6: Result:= #$b5;  //  BROKEN BAR
    $00a8: Result:= #$c8;  //  DIAERESIS
    $00a9: Result:= #$a0;  //  COPYRIGHT SIGN
    $00aa: Result:= #$e3;  //  FEMININE ORDINAL INDICATOR
    $00ac: Result:= #$be;  //  NOT SIGN
    $00ae: Result:= #$b0;  //  REGISTERED SIGN
    $00af: Result:= #$c5;  //  MACRON
    $00b1: Result:= #$d1;  //  PLUS-MINUS SIGN
    $00b2: Result:= #$c9;  //  SUPERSCRIPT TWO
    $00b3: Result:= #$cc;  //  SUPERSCRIPT THREE
    $00b4: Result:= #$c2;  //  ACUTE ACCENT
    $00b5: Result:= #$9d;  //  MICRO SIGN
    $00b7: Result:= #$b4;  //  MIDDLE DOT
    $00b8: Result:= #$cb;  //  CEDILLA
    $00b9: Result:= #$c0;  //  SUPERSCRIPT ONE
    $00ba: Result:= #$eb;  //  MASCULINE ORDINAL INDICATOR
    $00bc: Result:= #$d2;  //  VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$d3;  //  VULGAR FRACTION ONE HALF
    $00be: Result:= #$d4;  //  VULGAR FRACTION THREE QUARTERS
    $00c0: Result:= #$81;  //  LATIN CAPITAL LETTER A WITH GRAVE
    $00c1: Result:= #$82;  //  LATIN CAPITAL LETTER A WITH ACUTE
    $00c2: Result:= #$83;  //  LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00c3: Result:= #$84;  //  LATIN CAPITAL LETTER A WITH TILDE
    $00c4: Result:= #$85;  //  LATIN CAPITAL LETTER A WITH DIAERESIS
    $00c5: Result:= #$86;  //  LATIN CAPITAL LETTER A WITH RING
    $00c6: Result:= #$e1;  //  LATIN CAPITAL LETTER AE
    $00c7: Result:= #$87;  //  LATIN CAPITAL LETTER C WITH CEDILLA
    $00c8: Result:= #$88;  //  LATIN CAPITAL LETTER E WITH GRAVE
    $00c9: Result:= #$89;  //  LATIN CAPITAL LETTER E WITH ACUTE
    $00ca: Result:= #$8a;  //  LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $00cb: Result:= #$8b;  //  LATIN CAPITAL LETTER E WITH DIAERESIS
    $00cc: Result:= #$8c;  //  LATIN CAPITAL LETTER I WITH GRAVE
    $00cd: Result:= #$8d;  //  LATIN CAPITAL LETTER I WITH ACUTE
    $00ce: Result:= #$8e;  //  LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $00cf: Result:= #$8f;  //  LATIN CAPITAL LETTER I WITH DIAERESIS
    $00d0: Result:= #$90;  //  LATIN CAPITAL LETTER ETH
    $00d1: Result:= #$91;  //  LATIN CAPITAL LETTER N WITH TILDE
    $00d2: Result:= #$92;  //  LATIN CAPITAL LETTER O WITH GRAVE
    $00d3: Result:= #$93;  //  LATIN CAPITAL LETTER O WITH ACUTE
    $00d4: Result:= #$94;  //  LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00d5: Result:= #$95;  //  LATIN CAPITAL LETTER O WITH TILDE
    $00d6: Result:= #$96;  //  LATIN CAPITAL LETTER O WITH DIAERESIS
    $00d7: Result:= #$9e;  //  MULTIPLICATION SIGN
    $00d8: Result:= #$e9;  //  LATIN CAPITAL LETTER O WITH STROKE
    $00d9: Result:= #$97;  //  LATIN CAPITAL LETTER U WITH GRAVE
    $00da: Result:= #$98;  //  LATIN CAPITAL LETTER U WITH ACUTE
    $00db: Result:= #$99;  //  LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $00dc: Result:= #$9a;  //  LATIN CAPITAL LETTER U WITH DIAERESIS
    $00dd: Result:= #$9b;  //  LATIN CAPITAL LETTER Y WITH ACUTE
    $00de: Result:= #$9c;  //  LATIN CAPITAL LETTER THORN
    $00df: Result:= #$fb;  //  LATIN SMALL LETTER SHARP S
    $00e0: Result:= #$d5;  //  LATIN SMALL LETTER A WITH GRAVE
    $00e1: Result:= #$d6;  //  LATIN SMALL LETTER A WITH ACUTE
    $00e2: Result:= #$d7;  //  LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e3: Result:= #$d8;  //  LATIN SMALL LETTER A WITH TILDE
    $00e4: Result:= #$d9;  //  LATIN SMALL LETTER A WITH DIAERESIS
    $00e5: Result:= #$da;  //  LATIN SMALL LETTER A WITH RING ABOVE
    $00e6: Result:= #$f1;  //  LATIN SMALL LETTER AE
    $00e7: Result:= #$db;  //  LATIN SMALL LETTER C WITH CEDILLA
    $00e8: Result:= #$dc;  //  LATIN SMALL LETTER E WITH GRAVE
    $00e9: Result:= #$dd;  //  LATIN SMALL LETTER E WITH ACUTE
    $00ea: Result:= #$de;  //  LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00eb: Result:= #$df;  //  LATIN SMALL LETTER E WITH DIAERESIS
    $00ec: Result:= #$e0;  //  LATIN SMALL LETTER I WITH GRAVE
    $00ed: Result:= #$e2;  //  LATIN SMALL LETTER I WITH ACUTE
    $00ee: Result:= #$e4;  //  LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00ef: Result:= #$e5;  //  LATIN SMALL LETTER I WITH DIAERESIS
    $00f0: Result:= #$e6;  //  LATIN SMALL LETTER ETH
    $00f1: Result:= #$e7;  //  LATIN SMALL LETTER N WITH TILDE
    $00f2: Result:= #$ec;  //  LATIN SMALL LETTER O WITH GRAVE
    $00f3: Result:= #$ed;  //  LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$ee;  //  LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f5: Result:= #$ef;  //  LATIN SMALL LETTER O WITH TILDE
    $00f6: Result:= #$f0;  //  LATIN SMALL LETTER O WITH DIAERESIS
    $00f7: Result:= #$9f;  //  DIVISION SIGN
    $00f8: Result:= #$f9;  //  LATIN SMALL LETTER O WITH STROKE
    $00f9: Result:= #$f2;  //  LATIN SMALL LETTER U WITH GRAVE
    $00fa: Result:= #$f3;  //  LATIN SMALL LETTER U WITH ACUTE
    $00fb: Result:= #$f4;  //  LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00fc: Result:= #$f6;  //  LATIN SMALL LETTER U WITH DIAERESIS
    $00fd: Result:= #$f7;  //  LATIN SMALL LETTER Y WITH ACUTE
    $00fe: Result:= #$fc;  //  LATIN SMALL LETTER THORN
    $00ff: Result:= #$fd;  //  LATIN SMALL LETTER Y WITH DIAERESIS
    $0131: Result:= #$f5;  //  LATIN SMALL LETTER DOTLESS I
    $0141: Result:= #$e8;  //  LATIN CAPITAL LETTER L WITH STROKE
    $0142: Result:= #$f8;  //  LATIN SMALL LETTER L WITH STROKE
    $0152: Result:= #$ea;  //  LATIN CAPITAL LIGATURE OE
    $0153: Result:= #$fa;  //  LATIN SMALL LIGATURE OE
    $0192: Result:= #$a6;  //  LATIN SMALL LETTER F WITH HOOK
    $02c6: Result:= #$c3;  //  MODIFIER LETTER CIRCUMFLEX ACCENT
    $02c7: Result:= #$cf;  //  CARON
    $02cb: Result:= #$c1;  //  MODIFIER LETTER GRAVE ACCENT
    $02d8: Result:= #$c6;  //  BREVE
    $02d9: Result:= #$c7;  //  DOT ABOVE
    $02da: Result:= #$ca;  //  RING ABOVE
    $02db: Result:= #$ce;  //  OGONEK
    $02dc: Result:= #$c4;  //  SMALL TILDE
    $02dd: Result:= #$cd;  //  DOUBLE ACUTE ACCENT
    $2013: Result:= #$b1;  //  EN DASH
    $2014: Result:= #$d0;  //  EM DASH
    $2019: Result:= #$a9;  //  RIGHT SINGLE QUOTATION MARK
    $201a: Result:= #$b8;  //  SINGLE LOW-9 QUOTATION MARK
    $201c: Result:= #$aa;  //  LEFT DOUBLE QUOTATION MARK
    $201d: Result:= #$ba;  //  RIGHT DOUBLE QUOTATION MARK
    $201e: Result:= #$b9;  //  DOUBLE LOW-9 QUOTATION MARK
    $2020: Result:= #$b2;  //  DAGGER
    $2021: Result:= #$b3;  //  DOUBLE DAGGER
    $2022: Result:= #$b7;  //  BULLET
    $2026: Result:= #$bc;  //  HORIZONTAL ELLIPSIS
    $2030: Result:= #$bd;  //  PER MILLE SIGN
    $2039: Result:= #$ac;  //  LATIN SMALL LETTER
    $203a: Result:= #$ad;  //  LATIN SMALL LETTER
    $2044: Result:= #$a4;  //  FRACTION SLASH
    $fb01: Result:= #$ae;  //  LATIN SMALL LIGATURE FI
    $fb02: Result:= #$af;  //  LATIN SMALL LIGATURE FL
    $fffd: Result:= #$fe;  //  .notdef, REPLACEMENT CHARACTER
//    $fffd: Result:= #$ff;  //  .notdef, REPLACEMENT CHARACTER
  else
    raise EConvertError.CreateFmt('Invalid NextStep sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp10000_MacRomanChar(const I: longint): char;
begin
  case I of
    $0000..$007f: Result:= Char(I);
    $00A0: Result:= #$CA;  // NO-BREAK SPACE
    $00A1: Result:= #$C1;  // INVERTED EXCLAMATION MARK
    $00A2: Result:= #$A2;  // CENT SIGN
    $00A3: Result:= #$A3;  // POUND SIGN
    $00A4: Result:= #$DB;  // CURRENCY SIGN
    $00A5: Result:= #$B4;  // YEN SIGN
    $00A7: Result:= #$A4;  // SECTION SIGN
    $00A8: Result:= #$AC;  // DIAERESIS
    $00A9: Result:= #$A9;  // COPYRIGHT SIGN
    $00AA: Result:= #$BB;  // FEMININE ORDINAL INDICATOR
    $00AB: Result:= #$C7;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00AC: Result:= #$C2;  // NOT SIGN
    $00AE: Result:= #$A8;  // REGISTERED SIGN
    $00AF: Result:= #$F8;  // MACRON
    $00B0: Result:= #$A1;  // DEGREE SIGN
    $00B1: Result:= #$B1;  // PLUS-MINUS SIGN
    $00B4: Result:= #$AB;  // ACUTE ACCENT
    $00B5: Result:= #$B5;  // MICRO SIGN
    $00B6: Result:= #$A6;  // PILCROW SIGN
    $00B7: Result:= #$E1;  // MIDDLE DOT
    $00B8: Result:= #$FC;  // CEDILLA
    $00BA: Result:= #$BC;  // MASCULINE ORDINAL INDICATOR
    $00BB: Result:= #$C8;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00BF: Result:= #$C0;  // INVERTED QUESTION MARK
    $00C0: Result:= #$CB;  // LATIN CAPITAL LETTER A WITH GRAVE
    $00C1: Result:= #$E7;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00C2: Result:= #$E5;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00C3: Result:= #$CC;  // LATIN CAPITAL LETTER A WITH TILDE
    $00C4: Result:= #$80;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00C5: Result:= #$81;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00C6: Result:= #$AE;  // LATIN CAPITAL LIGATURE AE
    $00C7: Result:= #$82;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00C8: Result:= #$E9;  // LATIN CAPITAL LETTER E WITH GRAVE
    $00C9: Result:= #$83;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00CA: Result:= #$E6;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $00CB: Result:= #$E8;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $00CC: Result:= #$ED;  // LATIN CAPITAL LETTER I WITH GRAVE
    $00CD: Result:= #$EA;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00CE: Result:= #$EB;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $00CF: Result:= #$EC;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $00D1: Result:= #$84;  // LATIN CAPITAL LETTER N WITH TILDE
    $00D2: Result:= #$F1;  // LATIN CAPITAL LETTER O WITH GRAVE
    $00D3: Result:= #$EE;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00D4: Result:= #$EF;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00D5: Result:= #$CD;  // LATIN CAPITAL LETTER O WITH TILDE
    $00D6: Result:= #$85;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00D8: Result:= #$AF;  // LATIN CAPITAL LETTER O WITH STROKE
    $00D9: Result:= #$F4;  // LATIN CAPITAL LETTER U WITH GRAVE
    $00DA: Result:= #$F2;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00DB: Result:= #$F3;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $00DC: Result:= #$86;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00DF: Result:= #$A7;  // LATIN SMALL LETTER SHARP S
    $00E0: Result:= #$88;  // LATIN SMALL LETTER A WITH GRAVE
    $00E1: Result:= #$87;  // LATIN SMALL LETTER A WITH ACUTE
    $00E2: Result:= #$89;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00E3: Result:= #$8B;  // LATIN SMALL LETTER A WITH TILDE
    $00E4: Result:= #$8A;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00E5: Result:= #$8C;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00E6: Result:= #$BE;  // LATIN SMALL LIGATURE AE
    $00E7: Result:= #$8D;  // LATIN SMALL LETTER C WITH CEDILLA
    $00E8: Result:= #$8F;  // LATIN SMALL LETTER E WITH GRAVE
    $00E9: Result:= #$8E;  // LATIN SMALL LETTER E WITH ACUTE
    $00EA: Result:= #$90;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00EB: Result:= #$91;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00EC: Result:= #$93;  // LATIN SMALL LETTER I WITH GRAVE
    $00ED: Result:= #$92;  // LATIN SMALL LETTER I WITH ACUTE
    $00EE: Result:= #$94;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00EF: Result:= #$95;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00F1: Result:= #$96;  // LATIN SMALL LETTER N WITH TILDE
    $00F2: Result:= #$98;  // LATIN SMALL LETTER O WITH GRAVE
    $00F3: Result:= #$97;  // LATIN SMALL LETTER O WITH ACUTE
    $00F4: Result:= #$99;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00F5: Result:= #$9B;  // LATIN SMALL LETTER O WITH TILDE
    $00F6: Result:= #$9A;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00F7: Result:= #$D6;  // DIVISION SIGN
    $00F8: Result:= #$BF;  // LATIN SMALL LETTER O WITH STROKE
    $00F9: Result:= #$9D;  // LATIN SMALL LETTER U WITH GRAVE
    $00FA: Result:= #$9C;  // LATIN SMALL LETTER U WITH ACUTE
    $00FB: Result:= #$9E;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00FC: Result:= #$9F;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00FF: Result:= #$D8;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $0131: Result:= #$F5;  // LATIN SMALL LETTER DOTLESS I
    $0152: Result:= #$CE;  // LATIN CAPITAL LIGATURE OE
    $0153: Result:= #$CF;  // LATIN SMALL LIGATURE OE
    $0178: Result:= #$D9;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
    $0192: Result:= #$C4;  // LATIN SMALL LETTER F WITH HOOK
    $02C6: Result:= #$F6;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $02C7: Result:= #$FF;  // CARON
    $02D8: Result:= #$F9;  // BREVE
    $02D9: Result:= #$FA;  // DOT ABOVE
    $02DA: Result:= #$FB;  // RING ABOVE
    $02DB: Result:= #$FE;  // OGONEK
    $02DC: Result:= #$F7;  // SMALL TILDE
    $02DD: Result:= #$FD;  // DOUBLE ACUTE ACCENT
    $03C0: Result:= #$B9;  // GREEK SMALL LETTER PI
    $2013: Result:= #$D0;  // EN DASH
    $2014: Result:= #$D1;  // EM DASH
    $2018: Result:= #$D4;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$D5;  // RIGHT SINGLE QUOTATION MARK
    $201A: Result:= #$E2;  // SINGLE LOW-9 QUOTATION MARK
    $201C: Result:= #$D2;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$D3;  // RIGHT DOUBLE QUOTATION MARK
    $201E: Result:= #$E3;  // DOUBLE LOW-9 QUOTATION MARK
    $2020: Result:= #$A0;  // DAGGER
    $2021: Result:= #$E0;  // DOUBLE DAGGER
    $2022: Result:= #$A5;  // BULLET
    $2026: Result:= #$C9;  // HORIZONTAL ELLIPSIS
    $2030: Result:= #$E4;  // PER MILLE SIGN
    $2039: Result:= #$DC;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $203A: Result:= #$DD;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $2044: Result:= #$DA;  // FRACTION SLASH
    $2122: Result:= #$AA;  // TRADE MARK SIGN
    $2126: Result:= #$BD;  // OHM SIGN
    $2202: Result:= #$B6;  // PARTIAL DIFFERENTIAL
    $2206: Result:= #$C6;  // INCREMENT
    $220F: Result:= #$B8;  // N-ARY PRODUCT
    $2211: Result:= #$B7;  // N-ARY SUMMATION
    $221A: Result:= #$C3;  // SQUARE ROOT
    $221E: Result:= #$B0;  // INFINITY
    $222B: Result:= #$BA;  // INTEGRAL
    $2248: Result:= #$C5;  // ALMOST EQUAL TO
    $2260: Result:= #$AD;  // NOT EQUAL TO
    $2264: Result:= #$B2;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$B3;  // GREATER-THAN OR EQUAL TO
    $25CA: Result:= #$D7;  // LOZENGE
    $FB01: Result:= #$DE;  // LATIN SMALL LIGATURE FI
    $FB02: Result:= #$DF;  // LATIN SMALL LIGATURE FL
  else
    raise EConvertError.CreateFmt('Invalid cp10000_MacRoman sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp10006_MacGreekChar(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A9,$00B1:
      Result:= Char(I);
    $00A0: Result:= #$CA;  // NO-BREAK SPACE
    $00A3: Result:= #$92;  // POUND SIGN
    $00A5: Result:= #$B4;  // YEN SIGN
    $00A6: Result:= #$9B;  // BROKEN BAR
    $00A7: Result:= #$AC;  // SECTION SIGN
    $00A8: Result:= #$8C;  // DIAERESIS
    $00AB: Result:= #$C7;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00AC: Result:= #$C2;  // NOT SIGN
    $00AD: Result:= #$9C;  // SOFT HYPHEN
    $00AE: Result:= #$A8;  // REGISTERED SIGN
    $00B0: Result:= #$AE;  // DEGREE SIGN
    $00B2: Result:= #$82;  // SUPERSCRIPT TWO
    $00B3: Result:= #$84;  // SUPERSCRIPT THREE
    $00B9: Result:= #$81;  // SUPERSCRIPT ONE
    $00BB: Result:= #$C8;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00BD: Result:= #$97;  // VULGAR FRACTION ONE HALF
    $00C4: Result:= #$80;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00C9: Result:= #$83;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00D6: Result:= #$85;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00DC: Result:= #$86;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00DF: Result:= #$A7;  // LATIN SMALL LETTER SHARP S
    $00E0: Result:= #$88;  // LATIN SMALL LETTER A WITH GRAVE
    $00E2: Result:= #$89;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00E4: Result:= #$8A;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00E7: Result:= #$8D;  // LATIN SMALL LETTER C WITH CEDILLA
    $00E8: Result:= #$8F;  // LATIN SMALL LETTER E WITH GRAVE
    $00E9: Result:= #$8E;  // LATIN SMALL LETTER E WITH ACUTE
    $00EA: Result:= #$90;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00EB: Result:= #$91;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00EE: Result:= #$94;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00EF: Result:= #$95;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00F4: Result:= #$99;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00F6: Result:= #$9A;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00F7: Result:= #$D6;  // DIVISION SIGN
    $00F9: Result:= #$9D;  // LATIN SMALL LETTER U WITH GRAVE
    $00FB: Result:= #$9E;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00FC: Result:= #$9F;  // LATIN SMALL LETTER U WITH DIAERESIS
    $0153: Result:= #$CF;  // LATIN SMALL LIGATURE OE
    $0384: Result:= #$8B;  // GREEK TONOS
    $0385: Result:= #$87;  // GREEK DIALYTIKA TONOS
    $0386: Result:= #$CD;  // GREEK CAPITAL LETTER ALPHA WITH TONOS
    $0387: Result:= #$AF;  // GREEK ANO TELEIA
    $0388: Result:= #$CE;  // GREEK CAPITAL LETTER EPSILON WITH TONOS
    $0389: Result:= #$D7;  // GREEK CAPITAL LETTER ETA WITH TONOS
    $038A: Result:= #$D8;  // GREEK CAPITAL LETTER IOTA WITH TONOS
    $038C: Result:= #$D9;  // GREEK CAPITAL LETTER OMICRON WITH TONOS
    $038E: Result:= #$DA;  // GREEK CAPITAL LETTER UPSILON WITH TONOS
    $038F: Result:= #$DF;  // GREEK CAPITAL LETTER OMEGA WITH TONOS
    $0390: Result:= #$FD;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA AND TONOS
    $0391: Result:= #$B0;  // GREEK CAPITAL LETTER ALPHA
    $0392: Result:= #$B5;  // GREEK CAPITAL LETTER BETA
    $0393: Result:= #$A1;  // GREEK CAPITAL LETTER GAMMA
    $0394: Result:= #$A2;  // GREEK CAPITAL LETTER DELTA
    $0395: Result:= #$B6;  // GREEK CAPITAL LETTER EPSILON
    $0396: Result:= #$B7;  // GREEK CAPITAL LETTER ZETA
    $0397: Result:= #$B8;  // GREEK CAPITAL LETTER ETA
    $0398: Result:= #$A3;  // GREEK CAPITAL LETTER THETA
    $0399: Result:= #$B9;  // GREEK CAPITAL LETTER IOTA
    $039A: Result:= #$BA;  // GREEK CAPITAL LETTER KAPPA
    $039B: Result:= #$A4;  // GREEK CAPITAL LETTER LAMBDA
    $039C: Result:= #$BB;  // GREEK CAPITAL LETTER MU
    $039D: Result:= #$C1;  // GREEK CAPITAL LETTER NU
    $039E: Result:= #$A5;  // GREEK CAPITAL LETTER XI
    $039F: Result:= #$C3;  // GREEK CAPITAL LETTER OMICRON
    $03A0: Result:= #$A6;  // GREEK CAPITAL LETTER PI
    $03A1: Result:= #$C4;  // GREEK CAPITAL LETTER RHO
    $03A3: Result:= #$AA;  // GREEK CAPITAL LETTER SIGMA
    $03A4: Result:= #$C6;  // GREEK CAPITAL LETTER TAU
    $03A5: Result:= #$CB;  // GREEK CAPITAL LETTER UPSILON
    $03A6: Result:= #$BC;  // GREEK CAPITAL LETTER PHI
    $03A7: Result:= #$CC;  // GREEK CAPITAL LETTER CHI
    $03A8: Result:= #$BE;  // GREEK CAPITAL LETTER PSI
    $03A9: Result:= #$BF;  // GREEK CAPITAL LETTER OMEGA
    $03AA: Result:= #$AB;  // GREEK CAPITAL LETTER IOTA WITH DIALYTIKA
    $03AB: Result:= #$BD;  // GREEK CAPITAL LETTER UPSILON WITH DIALYTIKA
    $03AC: Result:= #$C0;  // GREEK SMALL LETTER ALPHA WITH TONOS
    $03AD: Result:= #$DB;  // GREEK SMALL LETTER EPSILON WITH TONOS
    $03AE: Result:= #$DC;  // GREEK SMALL LETTER ETA WITH TONOS
    $03AF: Result:= #$DD;  // GREEK SMALL LETTER IOTA WITH TONOS
    $03B0: Result:= #$FE;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA AND TONOS
    $03B1: Result:= #$E1;  // GREEK SMALL LETTER ALPHA
    $03B2: Result:= #$E2;  // GREEK SMALL LETTER BETA
    $03B3: Result:= #$E7;  // GREEK SMALL LETTER GAMMA
    $03B4: Result:= #$E4;  // GREEK SMALL LETTER DELTA
    $03B5: Result:= #$E5;  // GREEK SMALL LETTER EPSILON
    $03B6: Result:= #$FA;  // GREEK SMALL LETTER ZETA
    $03B7: Result:= #$E8;  // GREEK SMALL LETTER ETA
    $03B8: Result:= #$F5;  // GREEK SMALL LETTER THETA
    $03B9: Result:= #$E9;  // GREEK SMALL LETTER IOTA
    $03BA: Result:= #$EB;  // GREEK SMALL LETTER KAPPA
    $03BB: Result:= #$EC;  // GREEK SMALL LETTER LAMBDA
    $03BC: Result:= #$ED;  // GREEK SMALL LETTER MU
    $03BD: Result:= #$EE;  // GREEK SMALL LETTER NU
    $03BE: Result:= #$EA;  // GREEK SMALL LETTER XI
    $03BF: Result:= #$EF;  // GREEK SMALL LETTER OMICRON
    $03C0: Result:= #$F0;  // GREEK SMALL LETTER PI
    $03C1: Result:= #$F2;  // GREEK SMALL LETTER RHO
    $03C2: Result:= #$F7;  // GREEK SMALL LETTER FINAL SIGMA
    $03C3: Result:= #$F3;  // GREEK SMALL LETTER SIGMA
    $03C4: Result:= #$F4;  // GREEK SMALL LETTER TAU
    $03C5: Result:= #$F9;  // GREEK SMALL LETTER UPSILON
    $03C6: Result:= #$E6;  // GREEK SMALL LETTER PHI
    $03C7: Result:= #$F8;  // GREEK SMALL LETTER CHI
    $03C8: Result:= #$E3;  // GREEK SMALL LETTER PSI
    $03C9: Result:= #$F6;  // GREEK SMALL LETTER OMEGA
    $03CA: Result:= #$FB;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA
    $03CB: Result:= #$FC;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA
    $03CC: Result:= #$DE;  // GREEK SMALL LETTER OMICRON WITH TONOS
    $03CD: Result:= #$E0;  // GREEK SMALL LETTER UPSILON WITH TONOS
    $03CE: Result:= #$F1;  // GREEK SMALL LETTER OMEGA WITH TONOS
    $2013: Result:= #$D0;  // EN DASH
    $2015: Result:= #$D1;  // HORIZONTAL BAR
    $2018: Result:= #$D4;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$D5;  // RIGHT SINGLE QUOTATION MARK
    $201C: Result:= #$D2;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$D3;  // RIGHT DOUBLE QUOTATION MARK
    $2020: Result:= #$A0;  // DAGGER
    $2022: Result:= #$96;  // BULLET
    $2026: Result:= #$C9;  // HORIZONTAL ELLIPSIS
    $2030: Result:= #$98;  // PER MILLE SIGN
    $2122: Result:= #$93;  // TRADE MARK SIGN
    $2248: Result:= #$C5;  // ALMOST EQUAL TO
    $2260: Result:= #$AD;  // NOT EQUAL TO
    $2264: Result:= #$B2;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$B3;  // GREATER-THAN OR EQUAL TO
  else
    raise EConvertError.CreateFmt('Invalid cp10006_MacGreek sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp10007_MacCyrillicChar(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A2..$00A3,$00A9,$00B1,$00B5:
      Result:= Char(I);
    $00A0: Result:= #$CA;  // NO-BREAK SPACE
    $00A4: Result:= #$FF;  // CURRENCY SIGN
    $00A7: Result:= #$A4;  // SECTION SIGN
    $00AB: Result:= #$C7;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00AC: Result:= #$C2;  // NOT SIGN
    $00AE: Result:= #$A8;  // REGISTERED SIGN
    $00B0: Result:= #$A1;  // DEGREE SIGN
    $00B6: Result:= #$A6;  // PILCROW SIGN
    $00BB: Result:= #$C8;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00F7: Result:= #$D6;  // DIVISION SIGN
    $0192: Result:= #$C4;  // LATIN SMALL LETTER F WITH HOOK
    $0401: Result:= #$DD;  // CYRILLIC CAPITAL LETTER IO
    $0402: Result:= #$AB;  // CYRILLIC CAPITAL LETTER DJE
    $0403: Result:= #$AE;  // CYRILLIC CAPITAL LETTER GJE
    $0404: Result:= #$B8;  // CYRILLIC CAPITAL LETTER UKRAINIAN IE
    $0405: Result:= #$C1;  // CYRILLIC CAPITAL LETTER DZE
    $0406: Result:= #$A7;  // CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I
    $0407: Result:= #$BA;  // CYRILLIC CAPITAL LETTER YI
    $0408: Result:= #$B7;  // CYRILLIC CAPITAL LETTER JE
    $0409: Result:= #$BC;  // CYRILLIC CAPITAL LETTER LJE
    $040A: Result:= #$BE;  // CYRILLIC CAPITAL LETTER NJE
    $040B: Result:= #$CB;  // CYRILLIC CAPITAL LETTER TSHE
    $040C: Result:= #$CD;  // CYRILLIC CAPITAL LETTER KJE
    $040E: Result:= #$D8;  // CYRILLIC CAPITAL LETTER SHORT U
    $040F: Result:= #$DA;  // CYRILLIC CAPITAL LETTER DZHE
    $0410: Result:= #$80;  // CYRILLIC CAPITAL LETTER A
    $0411: Result:= #$81;  // CYRILLIC CAPITAL LETTER BE
    $0412: Result:= #$82;  // CYRILLIC CAPITAL LETTER VE
    $0413: Result:= #$83;  // CYRILLIC CAPITAL LETTER GHE
    $0414: Result:= #$84;  // CYRILLIC CAPITAL LETTER DE
    $0415: Result:= #$85;  // CYRILLIC CAPITAL LETTER IE
    $0416: Result:= #$86;  // CYRILLIC CAPITAL LETTER ZHE
    $0417: Result:= #$87;  // CYRILLIC CAPITAL LETTER ZE
    $0418: Result:= #$88;  // CYRILLIC CAPITAL LETTER I
    $0419: Result:= #$89;  // CYRILLIC CAPITAL LETTER SHORT I
    $041A: Result:= #$8A;  // CYRILLIC CAPITAL LETTER KA
    $041B: Result:= #$8B;  // CYRILLIC CAPITAL LETTER EL
    $041C: Result:= #$8C;  // CYRILLIC CAPITAL LETTER EM
    $041D: Result:= #$8D;  // CYRILLIC CAPITAL LETTER EN
    $041E: Result:= #$8E;  // CYRILLIC CAPITAL LETTER O
    $041F: Result:= #$8F;  // CYRILLIC CAPITAL LETTER PE
    $0420: Result:= #$90;  // CYRILLIC CAPITAL LETTER ER
    $0421: Result:= #$91;  // CYRILLIC CAPITAL LETTER ES
    $0422: Result:= #$92;  // CYRILLIC CAPITAL LETTER TE
    $0423: Result:= #$93;  // CYRILLIC CAPITAL LETTER U
    $0424: Result:= #$94;  // CYRILLIC CAPITAL LETTER EF
    $0425: Result:= #$95;  // CYRILLIC CAPITAL LETTER HA
    $0426: Result:= #$96;  // CYRILLIC CAPITAL LETTER TSE
    $0427: Result:= #$97;  // CYRILLIC CAPITAL LETTER CHE
    $0428: Result:= #$98;  // CYRILLIC CAPITAL LETTER SHA
    $0429: Result:= #$99;  // CYRILLIC CAPITAL LETTER SHCHA
    $042A: Result:= #$9A;  // CYRILLIC CAPITAL LETTER HARD SIGN
    $042B: Result:= #$9B;  // CYRILLIC CAPITAL LETTER YERU
    $042C: Result:= #$9C;  // CYRILLIC CAPITAL LETTER SOFT SIGN
    $042D: Result:= #$9D;  // CYRILLIC CAPITAL LETTER E
    $042E: Result:= #$9E;  // CYRILLIC CAPITAL LETTER YU
    $042F: Result:= #$9F;  // CYRILLIC CAPITAL LETTER YA
    $0430: Result:= #$E0;  // CYRILLIC SMALL LETTER A
    $0431: Result:= #$E1;  // CYRILLIC SMALL LETTER BE
    $0432: Result:= #$E2;  // CYRILLIC SMALL LETTER VE
    $0433: Result:= #$E3;  // CYRILLIC SMALL LETTER GHE
    $0434: Result:= #$E4;  // CYRILLIC SMALL LETTER DE
    $0435: Result:= #$E5;  // CYRILLIC SMALL LETTER IE
    $0436: Result:= #$E6;  // CYRILLIC SMALL LETTER ZHE
    $0437: Result:= #$E7;  // CYRILLIC SMALL LETTER ZE
    $0438: Result:= #$E8;  // CYRILLIC SMALL LETTER I
    $0439: Result:= #$E9;  // CYRILLIC SMALL LETTER SHORT I
    $043A: Result:= #$EA;  // CYRILLIC SMALL LETTER KA
    $043B: Result:= #$EB;  // CYRILLIC SMALL LETTER EL
    $043C: Result:= #$EC;  // CYRILLIC SMALL LETTER EM
    $043D: Result:= #$ED;  // CYRILLIC SMALL LETTER EN
    $043E: Result:= #$EE;  // CYRILLIC SMALL LETTER O
    $043F: Result:= #$EF;  // CYRILLIC SMALL LETTER PE
    $0440: Result:= #$F0;  // CYRILLIC SMALL LETTER ER
    $0441: Result:= #$F1;  // CYRILLIC SMALL LETTER ES
    $0442: Result:= #$F2;  // CYRILLIC SMALL LETTER TE
    $0443: Result:= #$F3;  // CYRILLIC SMALL LETTER U
    $0444: Result:= #$F4;  // CYRILLIC SMALL LETTER EF
    $0445: Result:= #$F5;  // CYRILLIC SMALL LETTER HA
    $0446: Result:= #$F6;  // CYRILLIC SMALL LETTER TSE
    $0447: Result:= #$F7;  // CYRILLIC SMALL LETTER CHE
    $0448: Result:= #$F8;  // CYRILLIC SMALL LETTER SHA
    $0449: Result:= #$F9;  // CYRILLIC SMALL LETTER SHCHA
    $044A: Result:= #$FA;  // CYRILLIC SMALL LETTER HARD SIGN
    $044B: Result:= #$FB;  // CYRILLIC SMALL LETTER YERU
    $044C: Result:= #$FC;  // CYRILLIC SMALL LETTER SOFT SIGN
    $044D: Result:= #$FD;  // CYRILLIC SMALL LETTER E
    $044E: Result:= #$FE;  // CYRILLIC SMALL LETTER YU
    $044F: Result:= #$DF;  // CYRILLIC SMALL LETTER YA
    $0451: Result:= #$DE;  // CYRILLIC SMALL LETTER IO
    $0452: Result:= #$AC;  // CYRILLIC SMALL LETTER DJE
    $0453: Result:= #$AF;  // CYRILLIC SMALL LETTER GJE
    $0454: Result:= #$B9;  // CYRILLIC SMALL LETTER UKRAINIAN IE
    $0455: Result:= #$CF;  // CYRILLIC SMALL LETTER DZE
    $0456: Result:= #$B4;  // CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I
    $0457: Result:= #$BB;  // CYRILLIC SMALL LETTER YI
    $0458: Result:= #$C0;  // CYRILLIC SMALL LETTER JE
    $0459: Result:= #$BD;  // CYRILLIC SMALL LETTER LJE
    $045A: Result:= #$BF;  // CYRILLIC SMALL LETTER NJE
    $045B: Result:= #$CC;  // CYRILLIC SMALL LETTER TSHE
    $045C: Result:= #$CE;  // CYRILLIC SMALL LETTER KJE
    $045E: Result:= #$D9;  // CYRILLIC SMALL LETTER SHORT U
    $045F: Result:= #$DB;  // CYRILLIC SMALL LETTER DZHE
    $2013: Result:= #$D0;  // EN DASH
    $2014: Result:= #$D1;  // EM DASH
    $2018: Result:= #$D4;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$D5;  // RIGHT SINGLE QUOTATION MARK
    $201C: Result:= #$D2;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$D3;  // RIGHT DOUBLE QUOTATION MARK
    $201E: Result:= #$D7;  // DOUBLE LOW-9 QUOTATION MARK
    $2020: Result:= #$A0;  // DAGGER
    $2022: Result:= #$A5;  // BULLET
    $2026: Result:= #$C9;  // HORIZONTAL ELLIPSIS
    $2116: Result:= #$DC;  // NUMERO SIGN
    $2122: Result:= #$AA;  // TRADE MARK SIGN
    $2202: Result:= #$B6;  // PARTIAL DIFFERENTIAL
    $2206: Result:= #$C6;  // INCREMENT
    $221A: Result:= #$C3;  // SQUARE ROOT
    $221E: Result:= #$B0;  // INFINITY
    $2248: Result:= #$C5;  // ALMOST EQUAL TO
    $2260: Result:= #$AD;  // NOT EQUAL TO
    $2264: Result:= #$B2;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$B3;  // GREATER-THAN OR EQUAL TO
  else
    raise EConvertError.CreateFmt('Invalid cp10007_MacCyrillic sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp10029_MacLatin2Char(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A3,$00A9:
      Result:= Char(I);
    $00A0: Result:= #$CA;  // NO-BREAK SPACE
    $00A7: Result:= #$A4;  // SECTION SIGN
    $00A8: Result:= #$AC;  // DIAERESIS
    $00AB: Result:= #$C7;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00AC: Result:= #$C2;  // NOT SIGN
    $00AE: Result:= #$A8;  // REGISTERED SIGN
    $00B0: Result:= #$A1;  // DEGREE SIGN
    $00B6: Result:= #$A6;  // PILCROW SIGN
    $00BB: Result:= #$C8;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00C1: Result:= #$E7;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00C4: Result:= #$80;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00C9: Result:= #$83;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00CD: Result:= #$EA;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00D3: Result:= #$EE;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00D4: Result:= #$EF;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00D5: Result:= #$CD;  // LATIN CAPITAL LETTER O WITH TILDE
    $00D6: Result:= #$85;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00DA: Result:= #$F2;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00DC: Result:= #$86;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00DD: Result:= #$F8;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $00DF: Result:= #$A7;  // LATIN SMALL LETTER SHARP S
    $00E1: Result:= #$87;  // LATIN SMALL LETTER A WITH ACUTE
    $00E4: Result:= #$8A;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00E9: Result:= #$8E;  // LATIN SMALL LETTER E WITH ACUTE
    $00ED: Result:= #$92;  // LATIN SMALL LETTER I WITH ACUTE
    $00F3: Result:= #$97;  // LATIN SMALL LETTER O WITH ACUTE
    $00F4: Result:= #$99;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00F5: Result:= #$9B;  // LATIN SMALL LETTER O WITH TILDE
    $00F6: Result:= #$9A;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00F7: Result:= #$D6;  // DIVISION SIGN
    $00FA: Result:= #$9C;  // LATIN SMALL LETTER U WITH ACUTE
    $00FC: Result:= #$9F;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00FD: Result:= #$F9;  // LATIN SMALL LETTER Y WITH ACUTE
    $0100: Result:= #$81;  // LATIN CAPITAL LETTER A WITH MACRON
    $0101: Result:= #$82;  // LATIN SMALL LETTER A WITH MACRON
    $0104: Result:= #$84;  // LATIN CAPITAL LETTER A WITH OGONEK
    $0105: Result:= #$88;  // LATIN SMALL LETTER A WITH OGONEK
    $0106: Result:= #$8C;  // LATIN CAPITAL LETTER C WITH ACUTE
    $0107: Result:= #$8D;  // LATIN SMALL LETTER C WITH ACUTE
    $010C: Result:= #$89;  // LATIN CAPITAL LETTER C WITH CARON
    $010D: Result:= #$8B;  // LATIN SMALL LETTER C WITH CARON
    $010E: Result:= #$91;  // LATIN CAPITAL LETTER D WITH CARON
    $010F: Result:= #$93;  // LATIN SMALL LETTER D WITH CARON
    $0112: Result:= #$94;  // LATIN CAPITAL LETTER E WITH MACRON
    $0113: Result:= #$95;  // LATIN SMALL LETTER E WITH MACRON
    $0116: Result:= #$96;  // LATIN CAPITAL LETTER E WITH DOT ABOVE
    $0117: Result:= #$98;  // LATIN SMALL LETTER E WITH DOT ABOVE
    $0118: Result:= #$A2;  // LATIN CAPITAL LETTER E WITH OGONEK
    $0119: Result:= #$AB;  // LATIN SMALL LETTER E WITH OGONEK
    $011A: Result:= #$9D;  // LATIN CAPITAL LETTER E WITH CARON
    $011B: Result:= #$9E;  // LATIN SMALL LETTER E WITH CARON
    $0122: Result:= #$FE;  // LATIN CAPITAL LETTER G WITH CEDILLA
    $0123: Result:= #$AE;  // LATIN SMALL LETTER G WITH CEDILLA
    $012A: Result:= #$B1;  // LATIN CAPITAL LETTER I WITH MACRON
    $012B: Result:= #$B4;  // LATIN SMALL LETTER I WITH MACRON
    $012E: Result:= #$AF;  // LATIN CAPITAL LETTER I WITH OGONEK
    $012F: Result:= #$B0;  // LATIN SMALL LETTER I WITH OGONEK
    $0136: Result:= #$B5;  // LATIN CAPITAL LETTER K WITH CEDILLA
    $0137: Result:= #$FA;  // LATIN SMALL LETTER K WITH CEDILLA
    $0139: Result:= #$BD;  // LATIN CAPITAL LETTER L WITH ACUTE
    $013A: Result:= #$BE;  // LATIN SMALL LETTER L WITH ACUTE
    $013B: Result:= #$B9;  // LATIN CAPITAL LETTER L WITH CEDILLA
    $013C: Result:= #$BA;  // LATIN SMALL LETTER L WITH CEDILLA
    $013D: Result:= #$BB;  // LATIN CAPITAL LETTER L WITH CARON
    $013E: Result:= #$BC;  // LATIN SMALL LETTER L WITH CARON
    $0141: Result:= #$FC;  // LATIN CAPITAL LETTER L WITH STROKE
    $0142: Result:= #$B8;  // LATIN SMALL LETTER L WITH STROKE
    $0143: Result:= #$C1;  // LATIN CAPITAL LETTER N WITH ACUTE
    $0144: Result:= #$C4;  // LATIN SMALL LETTER N WITH ACUTE
    $0145: Result:= #$BF;  // LATIN CAPITAL LETTER N WITH CEDILLA
    $0146: Result:= #$C0;  // LATIN SMALL LETTER N WITH CEDILLA
    $0147: Result:= #$C5;  // LATIN CAPITAL LETTER N WITH CARON
    $0148: Result:= #$CB;  // LATIN SMALL LETTER N WITH CARON
    $014C: Result:= #$CF;  // LATIN CAPITAL LETTER O WITH MACRON
    $014D: Result:= #$D8;  // LATIN SMALL LETTER O WITH MACRON
    $0150: Result:= #$CC;  // LATIN CAPITAL LETTER O WITH DOUBLE ACUTE
    $0151: Result:= #$CE;  // LATIN SMALL LETTER O WITH DOUBLE ACUTE
    $0154: Result:= #$D9;  // LATIN CAPITAL LETTER R WITH ACUTE
    $0155: Result:= #$DA;  // LATIN SMALL LETTER R WITH ACUTE
    $0156: Result:= #$DF;  // LATIN CAPITAL LETTER R WITH CEDILLA
    $0157: Result:= #$E0;  // LATIN SMALL LETTER R WITH CEDILLA
    $0158: Result:= #$DB;  // LATIN CAPITAL LETTER R WITH CARON
    $0159: Result:= #$DE;  // LATIN SMALL LETTER R WITH CARON
    $015A: Result:= #$E5;  // LATIN CAPITAL LETTER S WITH ACUTE
    $015B: Result:= #$E6;  // LATIN SMALL LETTER S WITH ACUTE
    $0160: Result:= #$E1;  // LATIN CAPITAL LETTER S WITH CARON
    $0161: Result:= #$E4;  // LATIN SMALL LETTER S WITH CARON
    $0164: Result:= #$E8;  // LATIN CAPITAL LETTER T WITH CARON
    $0165: Result:= #$E9;  // LATIN SMALL LETTER T WITH CARON
    $016A: Result:= #$ED;  // LATIN CAPITAL LETTER U WITH MACRON
    $016B: Result:= #$F0;  // LATIN SMALL LETTER U WITH MACRON
    $016E: Result:= #$F1;  // LATIN CAPITAL LETTER U WITH RING ABOVE
    $016F: Result:= #$F3;  // LATIN SMALL LETTER U WITH RING ABOVE
    $0170: Result:= #$F4;  // LATIN CAPITAL LETTER U WITH DOUBLE ACUTE
    $0171: Result:= #$F5;  // LATIN SMALL LETTER U WITH DOUBLE ACUTE
    $0172: Result:= #$F6;  // LATIN CAPITAL LETTER U WITH OGONEK
    $0173: Result:= #$F7;  // LATIN SMALL LETTER U WITH OGONEK
    $0179: Result:= #$8F;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $017A: Result:= #$90;  // LATIN SMALL LETTER Z WITH ACUTE
    $017B: Result:= #$FB;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $017C: Result:= #$FD;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $017D: Result:= #$EB;  // LATIN CAPITAL LETTER Z WITH CARON
    $017E: Result:= #$EC;  // LATIN SMALL LETTER Z WITH CARON
    $02C7: Result:= #$FF;  // CARON
    $2013: Result:= #$D0;  // EN DASH
    $2014: Result:= #$D1;  // EM DASH
    $2018: Result:= #$D4;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$D5;  // RIGHT SINGLE QUOTATION MARK
    $201A: Result:= #$E2;  // SINGLE LOW-9 QUOTATION MARK
    $201C: Result:= #$D2;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$D3;  // RIGHT DOUBLE QUOTATION MARK
    $201E: Result:= #$E3;  // DOUBLE LOW-9 QUOTATION MARK
    $2020: Result:= #$A0;  // DAGGER
    $2022: Result:= #$A5;  // BULLET
    $2026: Result:= #$C9;  // HORIZONTAL ELLIPSIS
    $2039: Result:= #$DC;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $203A: Result:= #$DD;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $2122: Result:= #$AA;  // TRADE MARK SIGN
    $2202: Result:= #$B6;  // PARTIAL DIFFERENTIAL
    $2206: Result:= #$C6;  // INCREMENT
    $2211: Result:= #$B7;  // N-ARY SUMMATION
    $221A: Result:= #$C3;  // SQUARE ROOT
    $2260: Result:= #$AD;  // NOT EQUAL TO
    $2264: Result:= #$B2;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$B3;  // GREATER-THAN OR EQUAL TO
    $25CA: Result:= #$D7;  // LOZENGE
  else
    raise EConvertError.CreateFmt('Invalid cp10029_MacLatin2 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp10079_MacIcelandicChar(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A2..$00A3,$00A9,$00B1,$00B5,$00DE:
      Result:= Char(I);
    $00A0: Result:= #$CA;  // NO-BREAK SPACE
    $00A1: Result:= #$C1;  // INVERTED EXCLAMATION MARK
    $00A4: Result:= #$DB;  // CURRENCY SIGN
    $00A5: Result:= #$B4;  // YEN SIGN
    $00A7: Result:= #$A4;  // SECTION SIGN
    $00A8: Result:= #$AC;  // DIAERESIS
    $00AA: Result:= #$BB;  // FEMININE ORDINAL INDICATOR
    $00AB: Result:= #$C7;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00AC: Result:= #$C2;  // NOT SIGN
    $00AE: Result:= #$A8;  // REGISTERED SIGN
    $00AF: Result:= #$F8;  // MACRON
    $00B0: Result:= #$A1;  // DEGREE SIGN
    $00B4: Result:= #$AB;  // ACUTE ACCENT
    $00B6: Result:= #$A6;  // PILCROW SIGN
    $00B7: Result:= #$E1;  // MIDDLE DOT
    $00B8: Result:= #$FC;  // CEDILLA
    $00BA: Result:= #$BC;  // MASCULINE ORDINAL INDICATOR
    $00BB: Result:= #$C8;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00BF: Result:= #$C0;  // INVERTED QUESTION MARK
    $00C0: Result:= #$CB;  // LATIN CAPITAL LETTER A WITH GRAVE
    $00C1: Result:= #$E7;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00C2: Result:= #$E5;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00C3: Result:= #$CC;  // LATIN CAPITAL LETTER A WITH TILDE
    $00C4: Result:= #$80;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00C5: Result:= #$81;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00C6: Result:= #$AE;  // LATIN CAPITAL LIGATURE AE
    $00C7: Result:= #$82;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00C8: Result:= #$E9;  // LATIN CAPITAL LETTER E WITH GRAVE
    $00C9: Result:= #$83;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00CA: Result:= #$E6;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $00CB: Result:= #$E8;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $00CC: Result:= #$ED;  // LATIN CAPITAL LETTER I WITH GRAVE
    $00CD: Result:= #$EA;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00CE: Result:= #$EB;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $00CF: Result:= #$EC;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $00D0: Result:= #$DC;  // LATIN CAPITAL LETTER ETH
    $00D1: Result:= #$84;  // LATIN CAPITAL LETTER N WITH TILDE
    $00D2: Result:= #$F1;  // LATIN CAPITAL LETTER O WITH GRAVE
    $00D3: Result:= #$EE;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00D4: Result:= #$EF;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00D5: Result:= #$CD;  // LATIN CAPITAL LETTER O WITH TILDE
    $00D6: Result:= #$85;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00D8: Result:= #$AF;  // LATIN CAPITAL LETTER O WITH STROKE
    $00D9: Result:= #$F4;  // LATIN CAPITAL LETTER U WITH GRAVE
    $00DA: Result:= #$F2;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00DB: Result:= #$F3;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $00DC: Result:= #$86;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00DD: Result:= #$A0;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $00DF: Result:= #$A7;  // LATIN SMALL LETTER SHARP S
    $00E0: Result:= #$88;  // LATIN SMALL LETTER A WITH GRAVE
    $00E1: Result:= #$87;  // LATIN SMALL LETTER A WITH ACUTE
    $00E2: Result:= #$89;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00E3: Result:= #$8B;  // LATIN SMALL LETTER A WITH TILDE
    $00E4: Result:= #$8A;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00E5: Result:= #$8C;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00E6: Result:= #$BE;  // LATIN SMALL LIGATURE AE
    $00E7: Result:= #$8D;  // LATIN SMALL LETTER C WITH CEDILLA
    $00E8: Result:= #$8F;  // LATIN SMALL LETTER E WITH GRAVE
    $00E9: Result:= #$8E;  // LATIN SMALL LETTER E WITH ACUTE
    $00EA: Result:= #$90;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00EB: Result:= #$91;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00EC: Result:= #$93;  // LATIN SMALL LETTER I WITH GRAVE
    $00ED: Result:= #$92;  // LATIN SMALL LETTER I WITH ACUTE
    $00EE: Result:= #$94;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00EF: Result:= #$95;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00F0: Result:= #$DD;  // LATIN SMALL LETTER ETH
    $00F1: Result:= #$96;  // LATIN SMALL LETTER N WITH TILDE
    $00F2: Result:= #$98;  // LATIN SMALL LETTER O WITH GRAVE
    $00F3: Result:= #$97;  // LATIN SMALL LETTER O WITH ACUTE
    $00F4: Result:= #$99;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00F5: Result:= #$9B;  // LATIN SMALL LETTER O WITH TILDE
    $00F6: Result:= #$9A;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00F7: Result:= #$D6;  // DIVISION SIGN
    $00F8: Result:= #$BF;  // LATIN SMALL LETTER O WITH STROKE
    $00F9: Result:= #$9D;  // LATIN SMALL LETTER U WITH GRAVE
    $00FA: Result:= #$9C;  // LATIN SMALL LETTER U WITH ACUTE
    $00FB: Result:= #$9E;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00FC: Result:= #$9F;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00FD: Result:= #$E0;  // LATIN SMALL LETTER Y WITH ACUTE
    $00FE: Result:= #$DF;  // LATIN SMALL LETTER THORN
    $00FF: Result:= #$D8;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $0131: Result:= #$F5;  // LATIN SMALL LETTER DOTLESS I
    $0152: Result:= #$CE;  // LATIN CAPITAL LIGATURE OE
    $0153: Result:= #$CF;  // LATIN SMALL LIGATURE OE
    $0178: Result:= #$D9;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
    $0192: Result:= #$C4;  // LATIN SMALL LETTER F WITH HOOK
    $02C6: Result:= #$F6;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $02C7: Result:= #$FF;  // CARON
    $02D8: Result:= #$F9;  // BREVE
    $02D9: Result:= #$FA;  // DOT ABOVE
    $02DA: Result:= #$FB;  // RING ABOVE
    $02DB: Result:= #$FE;  // OGONEK
    $02DC: Result:= #$F7;  // SMALL TILDE
    $02DD: Result:= #$FD;  // DOUBLE ACUTE ACCENT
    $03C0: Result:= #$B9;  // GREEK SMALL LETTER PI
    $2013: Result:= #$D0;  // EN DASH
    $2014: Result:= #$D1;  // EM DASH
    $2018: Result:= #$D4;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$D5;  // RIGHT SINGLE QUOTATION MARK
    $201A: Result:= #$E2;  // SINGLE LOW-9 QUOTATION MARK
    $201C: Result:= #$D2;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$D3;  // RIGHT DOUBLE QUOTATION MARK
    $201E: Result:= #$E3;  // DOUBLE LOW-9 QUOTATION MARK
    $2022: Result:= #$A5;  // BULLET
    $2026: Result:= #$C9;  // HORIZONTAL ELLIPSIS
    $2030: Result:= #$E4;  // PER MILLE SIGN
    $2044: Result:= #$DA;  // FRACTION SLASH
    $2122: Result:= #$AA;  // TRADE MARK SIGN
    $2126: Result:= #$BD;  // OHM SIGN
    $2202: Result:= #$B6;  // PARTIAL DIFFERENTIAL
    $2206: Result:= #$C6;  // INCREMENT
    $220F: Result:= #$B8;  // N-ARY PRODUCT
    $2211: Result:= #$B7;  // N-ARY SUMMATION
    $221A: Result:= #$C3;  // SQUARE ROOT
    $221E: Result:= #$B0;  // INFINITY
    $222B: Result:= #$BA;  // INTEGRAL
    $2248: Result:= #$C5;  // ALMOST EQUAL TO
    $2260: Result:= #$AD;  // NOT EQUAL TO
    $2264: Result:= #$B2;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$B3;  // GREATER-THAN OR EQUAL TO
    $25CA: Result:= #$D7;  // LOZENGE
  else
    raise EConvertError.CreateFmt('Invalid cp10079_MacIcelandic sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp10081_MacTurkishChar(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A2..$00A3,$00A9,$00B1,$00B5:
      Result:= Char(I);
    $00A0: Result:= #$CA;  // NO-BREAK SPACE
    $00A1: Result:= #$C1;  // INVERTED EXCLAMATION MARK
    $00A5: Result:= #$B4;  // YEN SIGN
    $00A7: Result:= #$A4;  // SECTION SIGN
    $00A8: Result:= #$AC;  // DIAERESIS
    $00AA: Result:= #$BB;  // FEMININE ORDINAL INDICATOR
    $00AB: Result:= #$C7;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00AC: Result:= #$C2;  // NOT SIGN
    $00AE: Result:= #$A8;  // REGISTERED SIGN
    $00AF: Result:= #$F8;  // MACRON
    $00B0: Result:= #$A1;  // DEGREE SIGN
    $00B4: Result:= #$AB;  // ACUTE ACCENT
    $00B6: Result:= #$A6;  // PILCROW SIGN
    $00B7: Result:= #$E1;  // MIDDLE DOT
    $00B8: Result:= #$FC;  // CEDILLA
    $00BA: Result:= #$BC;  // MASCULINE ORDINAL INDICATOR
    $00BB: Result:= #$C8;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00BF: Result:= #$C0;  // INVERTED QUESTION MARK
    $00C0: Result:= #$CB;  // LATIN CAPITAL LETTER A WITH GRAVE
    $00C1: Result:= #$E7;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00C2: Result:= #$E5;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00C3: Result:= #$CC;  // LATIN CAPITAL LETTER A WITH TILDE
    $00C4: Result:= #$80;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00C5: Result:= #$81;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00C6: Result:= #$AE;  // LATIN CAPITAL LIGATURE AE
    $00C7: Result:= #$82;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00C8: Result:= #$E9;  // LATIN CAPITAL LETTER E WITH GRAVE
    $00C9: Result:= #$83;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00CA: Result:= #$E6;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $00CB: Result:= #$E8;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $00CC: Result:= #$ED;  // LATIN CAPITAL LETTER I WITH GRAVE
    $00CD: Result:= #$EA;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00CE: Result:= #$EB;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $00CF: Result:= #$EC;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $00D1: Result:= #$84;  // LATIN CAPITAL LETTER N WITH TILDE
    $00D2: Result:= #$F1;  // LATIN CAPITAL LETTER O WITH GRAVE
    $00D3: Result:= #$EE;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00D4: Result:= #$EF;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00D5: Result:= #$CD;  // LATIN CAPITAL LETTER O WITH TILDE
    $00D6: Result:= #$85;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00D8: Result:= #$AF;  // LATIN CAPITAL LETTER O WITH STROKE
    $00D9: Result:= #$F4;  // LATIN CAPITAL LETTER U WITH GRAVE
    $00DA: Result:= #$F2;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00DB: Result:= #$F3;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $00DC: Result:= #$86;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00DF: Result:= #$A7;  // LATIN SMALL LETTER SHARP S
    $00E0: Result:= #$88;  // LATIN SMALL LETTER A WITH GRAVE
    $00E1: Result:= #$87;  // LATIN SMALL LETTER A WITH ACUTE
    $00E2: Result:= #$89;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00E3: Result:= #$8B;  // LATIN SMALL LETTER A WITH TILDE
    $00E4: Result:= #$8A;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00E5: Result:= #$8C;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00E6: Result:= #$BE;  // LATIN SMALL LIGATURE AE
    $00E7: Result:= #$8D;  // LATIN SMALL LETTER C WITH CEDILLA
    $00E8: Result:= #$8F;  // LATIN SMALL LETTER E WITH GRAVE
    $00E9: Result:= #$8E;  // LATIN SMALL LETTER E WITH ACUTE
    $00EA: Result:= #$90;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00EB: Result:= #$91;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00EC: Result:= #$93;  // LATIN SMALL LETTER I WITH GRAVE
    $00ED: Result:= #$92;  // LATIN SMALL LETTER I WITH ACUTE
    $00EE: Result:= #$94;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00EF: Result:= #$95;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00F1: Result:= #$96;  // LATIN SMALL LETTER N WITH TILDE
    $00F2: Result:= #$98;  // LATIN SMALL LETTER O WITH GRAVE
    $00F3: Result:= #$97;  // LATIN SMALL LETTER O WITH ACUTE
    $00F4: Result:= #$99;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00F5: Result:= #$9B;  // LATIN SMALL LETTER O WITH TILDE
    $00F6: Result:= #$9A;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00F7: Result:= #$D6;  // DIVISION SIGN
    $00F8: Result:= #$BF;  // LATIN SMALL LETTER O WITH STROKE
    $00F9: Result:= #$9D;  // LATIN SMALL LETTER U WITH GRAVE
    $00FA: Result:= #$9C;  // LATIN SMALL LETTER U WITH ACUTE
    $00FB: Result:= #$9E;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00FC: Result:= #$9F;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00FF: Result:= #$D8;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $011E: Result:= #$DA;  // LATIN CAPITAL LETTER G WITH BREVE
    $011F: Result:= #$DB;  // LATIN SMALL LETTER G WITH BREVE
    $0130: Result:= #$DC;  // LATIN CAPITAL LETTER I WITH DOT ABOVE
    $0131: Result:= #$DD;  // LATIN SMALL LETTER DOTLESS I
    $0152: Result:= #$CE;  // LATIN CAPITAL LIGATURE OE
    $0153: Result:= #$CF;  // LATIN SMALL LIGATURE OE
    $015E: Result:= #$DE;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $015F: Result:= #$DF;  // LATIN SMALL LETTER S WITH CEDILLA
    $0178: Result:= #$D9;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
    $0192: Result:= #$C4;  // LATIN SMALL LETTER F WITH HOOK
    $02C6: Result:= #$F6;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $02C7: Result:= #$FF;  // CARON
    $02D8: Result:= #$F9;  // BREVE
    $02D9: Result:= #$FA;  // DOT ABOVE
    $02DA: Result:= #$FB;  // RING ABOVE
    $02DB: Result:= #$FE;  // OGONEK
    $02DC: Result:= #$F7;  // SMALL TILDE
    $02DD: Result:= #$FD;  // DOUBLE ACUTE ACCENT
    $03C0: Result:= #$B9;  // GREEK SMALL LETTER PI
    $2013: Result:= #$D0;  // EN DASH
    $2014: Result:= #$D1;  // EM DASH
    $2018: Result:= #$D4;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$D5;  // RIGHT SINGLE QUOTATION MARK
    $201A: Result:= #$E2;  // SINGLE LOW-9 QUOTATION MARK
    $201C: Result:= #$D2;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$D3;  // RIGHT DOUBLE QUOTATION MARK
    $201E: Result:= #$E3;  // DOUBLE LOW-9 QUOTATION MARK
    $2020: Result:= #$A0;  // DAGGER
    $2021: Result:= #$E0;  // DOUBLE DAGGER
    $2022: Result:= #$A5;  // BULLET
    $2026: Result:= #$C9;  // HORIZONTAL ELLIPSIS
    $2030: Result:= #$E4;  // PER MILLE SIGN
    $2122: Result:= #$AA;  // TRADE MARK SIGN
    $2126: Result:= #$BD;  // OHM SIGN
    $2202: Result:= #$B6;  // PARTIAL DIFFERENTIAL
    $2206: Result:= #$C6;  // INCREMENT
    $220F: Result:= #$B8;  // N-ARY PRODUCT
    $2211: Result:= #$B7;  // N-ARY SUMMATION
    $221A: Result:= #$C3;  // SQUARE ROOT
    $221E: Result:= #$B0;  // INFINITY
    $222B: Result:= #$BA;  // INTEGRAL
    $2248: Result:= #$C5;  // ALMOST EQUAL TO
    $2260: Result:= #$AD;  // NOT EQUAL TO
    $2264: Result:= #$B2;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$B3;  // GREATER-THAN OR EQUAL TO
    $25CA: Result:= #$D7;  // LOZENGE
  else
    raise EConvertError.CreateFmt('Invalid cp10081_MacTurkish sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp037Char(const I: longint): char;
begin
  case I of
    $0000..$0003,$000B..$0013,$0018..$0019,$001C..$001F,$00B6:
      Result:= Char(I);
    $0004: Result:= #$37;  // END OF TRANSMISSION
    $0005: Result:= #$2D;  // ENQUIRY
    $0006: Result:= #$2E;  // ACKNOWLEDGE
    $0007: Result:= #$2F;  // BELL
    $0008: Result:= #$16;  // BACKSPACE
    $0009: Result:= #$05;  // HORIZONTAL TABULATION
    $000A: Result:= #$25;  // LINE FEED
    $0014: Result:= #$3C;  // DEVICE CONTROL FOUR
    $0015: Result:= #$3D;  // NEGATIVE ACKNOWLEDGE
    $0016: Result:= #$32;  // SYNCHRONOUS IDLE
    $0017: Result:= #$26;  // END OF TRANSMISSION BLOCK
    $001A: Result:= #$3F;  // SUBSTITUTE
    $001B: Result:= #$27;  // ESCAPE
    $0020: Result:= #$40;  // SPACE
    $0021: Result:= #$5A;  // EXCLAMATION MARK
    $0022: Result:= #$7F;  // QUOTATION MARK
    $0023: Result:= #$7B;  // NUMBER SIGN
    $0024: Result:= #$5B;  // DOLLAR SIGN
    $0025: Result:= #$6C;  // PERCENT SIGN
    $0026: Result:= #$50;  // AMPERSAND
    $0027: Result:= #$7D;  // APOSTROPHE
    $0028: Result:= #$4D;  // LEFT PARENTHESIS
    $0029: Result:= #$5D;  // RIGHT PARENTHESIS
    $002A: Result:= #$5C;  // ASTERISK
    $002B: Result:= #$4E;  // PLUS SIGN
    $002C: Result:= #$6B;  // COMMA
    $002D: Result:= #$60;  // HYPHEN-MINUS
    $002E: Result:= #$4B;  // FULL STOP
    $002F: Result:= #$61;  // SOLIDUS
    $0030: Result:= #$F0;  // DIGIT ZERO
    $0031: Result:= #$F1;  // DIGIT ONE
    $0032: Result:= #$F2;  // DIGIT TWO
    $0033: Result:= #$F3;  // DIGIT THREE
    $0034: Result:= #$F4;  // DIGIT FOUR
    $0035: Result:= #$F5;  // DIGIT FIVE
    $0036: Result:= #$F6;  // DIGIT SIX
    $0037: Result:= #$F7;  // DIGIT SEVEN
    $0038: Result:= #$F8;  // DIGIT EIGHT
    $0039: Result:= #$F9;  // DIGIT NINE
    $003A: Result:= #$7A;  // COLON
    $003B: Result:= #$5E;  // SEMICOLON
    $003C: Result:= #$4C;  // LESS-THAN SIGN
    $003D: Result:= #$7E;  // EQUALS SIGN
    $003E: Result:= #$6E;  // GREATER-THAN SIGN
    $003F: Result:= #$6F;  // QUESTION MARK
    $0040: Result:= #$7C;  // COMMERCIAL AT
    $0041: Result:= #$C1;  // LATIN CAPITAL LETTER A
    $0042: Result:= #$C2;  // LATIN CAPITAL LETTER B
    $0043: Result:= #$C3;  // LATIN CAPITAL LETTER C
    $0044: Result:= #$C4;  // LATIN CAPITAL LETTER D
    $0045: Result:= #$C5;  // LATIN CAPITAL LETTER E
    $0046: Result:= #$C6;  // LATIN CAPITAL LETTER F
    $0047: Result:= #$C7;  // LATIN CAPITAL LETTER G
    $0048: Result:= #$C8;  // LATIN CAPITAL LETTER H
    $0049: Result:= #$C9;  // LATIN CAPITAL LETTER I
    $004A: Result:= #$D1;  // LATIN CAPITAL LETTER J
    $004B: Result:= #$D2;  // LATIN CAPITAL LETTER K
    $004C: Result:= #$D3;  // LATIN CAPITAL LETTER L
    $004D: Result:= #$D4;  // LATIN CAPITAL LETTER M
    $004E: Result:= #$D5;  // LATIN CAPITAL LETTER N
    $004F: Result:= #$D6;  // LATIN CAPITAL LETTER O
    $0050: Result:= #$D7;  // LATIN CAPITAL LETTER P
    $0051: Result:= #$D8;  // LATIN CAPITAL LETTER Q
    $0052: Result:= #$D9;  // LATIN CAPITAL LETTER R
    $0053: Result:= #$E2;  // LATIN CAPITAL LETTER S
    $0054: Result:= #$E3;  // LATIN CAPITAL LETTER T
    $0055: Result:= #$E4;  // LATIN CAPITAL LETTER U
    $0056: Result:= #$E5;  // LATIN CAPITAL LETTER V
    $0057: Result:= #$E6;  // LATIN CAPITAL LETTER W
    $0058: Result:= #$E7;  // LATIN CAPITAL LETTER X
    $0059: Result:= #$E8;  // LATIN CAPITAL LETTER Y
    $005A: Result:= #$E9;  // LATIN CAPITAL LETTER Z
    $005B: Result:= #$BA;  // LEFT SQUARE BRACKET
    $005C: Result:= #$E0;  // REVERSE SOLIDUS
    $005D: Result:= #$BB;  // RIGHT SQUARE BRACKET
    $005E: Result:= #$B0;  // CIRCUMFLEX ACCENT
    $005F: Result:= #$6D;  // LOW LINE
    $0060: Result:= #$79;  // GRAVE ACCENT
    $0061: Result:= #$81;  // LATIN SMALL LETTER A
    $0062: Result:= #$82;  // LATIN SMALL LETTER B
    $0063: Result:= #$83;  // LATIN SMALL LETTER C
    $0064: Result:= #$84;  // LATIN SMALL LETTER D
    $0065: Result:= #$85;  // LATIN SMALL LETTER E
    $0066: Result:= #$86;  // LATIN SMALL LETTER F
    $0067: Result:= #$87;  // LATIN SMALL LETTER G
    $0068: Result:= #$88;  // LATIN SMALL LETTER H
    $0069: Result:= #$89;  // LATIN SMALL LETTER I
    $006A: Result:= #$91;  // LATIN SMALL LETTER J
    $006B: Result:= #$92;  // LATIN SMALL LETTER K
    $006C: Result:= #$93;  // LATIN SMALL LETTER L
    $006D: Result:= #$94;  // LATIN SMALL LETTER M
    $006E: Result:= #$95;  // LATIN SMALL LETTER N
    $006F: Result:= #$96;  // LATIN SMALL LETTER O
    $0070: Result:= #$97;  // LATIN SMALL LETTER P
    $0071: Result:= #$98;  // LATIN SMALL LETTER Q
    $0072: Result:= #$99;  // LATIN SMALL LETTER R
    $0073: Result:= #$A2;  // LATIN SMALL LETTER S
    $0074: Result:= #$A3;  // LATIN SMALL LETTER T
    $0075: Result:= #$A4;  // LATIN SMALL LETTER U
    $0076: Result:= #$A5;  // LATIN SMALL LETTER V
    $0077: Result:= #$A6;  // LATIN SMALL LETTER W
    $0078: Result:= #$A7;  // LATIN SMALL LETTER X
    $0079: Result:= #$A8;  // LATIN SMALL LETTER Y
    $007A: Result:= #$A9;  // LATIN SMALL LETTER Z
    $007B: Result:= #$C0;  // LEFT CURLY BRACKET
    $007C: Result:= #$4F;  // VERTICAL LINE
    $007D: Result:= #$D0;  // RIGHT CURLY BRACKET
    $007E: Result:= #$A1;  // TILDE
    $007F: Result:= #$07;  // DELETE
    $0080: Result:= #$20;  // CONTROL
    $0081: Result:= #$21;  // CONTROL
    $0082: Result:= #$22;  // CONTROL
    $0083: Result:= #$23;  // CONTROL
    $0084: Result:= #$24;  // CONTROL
    $0085: Result:= #$15;  // CONTROL
    $0086: Result:= #$06;  // CONTROL
    $0087: Result:= #$17;  // CONTROL
    $0088: Result:= #$28;  // CONTROL
    $0089: Result:= #$29;  // CONTROL
    $008A: Result:= #$2A;  // CONTROL
    $008B: Result:= #$2B;  // CONTROL
    $008C: Result:= #$2C;  // CONTROL
    $008D: Result:= #$09;  // CONTROL
    $008E: Result:= #$0A;  // CONTROL
    $008F: Result:= #$1B;  // CONTROL
    $0090: Result:= #$30;  // CONTROL
    $0091: Result:= #$31;  // CONTROL
    $0092: Result:= #$1A;  // CONTROL
    $0093: Result:= #$33;  // CONTROL
    $0094: Result:= #$34;  // CONTROL
    $0095: Result:= #$35;  // CONTROL
    $0096: Result:= #$36;  // CONTROL
    $0097: Result:= #$08;  // CONTROL
    $0098: Result:= #$38;  // CONTROL
    $0099: Result:= #$39;  // CONTROL
    $009A: Result:= #$3A;  // CONTROL
    $009B: Result:= #$3B;  // CONTROL
    $009C: Result:= #$04;  // CONTROL
    $009D: Result:= #$14;  // CONTROL
    $009E: Result:= #$3E;  // CONTROL
    $009F: Result:= #$FF;  // CONTROL
    $00A0: Result:= #$41;  // NO-BREAK SPACE
    $00A1: Result:= #$AA;  // INVERTED EXCLAMATION MARK
    $00A2: Result:= #$4A;  // CENT SIGN
    $00A3: Result:= #$B1;  // POUND SIGN
    $00A4: Result:= #$9F;  // CURRENCY SIGN
    $00A5: Result:= #$B2;  // YEN SIGN
    $00A6: Result:= #$6A;  // BROKEN BAR
    $00A7: Result:= #$B5;  // SECTION SIGN
    $00A8: Result:= #$BD;  // DIAERESIS
    $00A9: Result:= #$B4;  // COPYRIGHT SIGN
    $00AA: Result:= #$9A;  // FEMININE ORDINAL INDICATOR
    $00AB: Result:= #$8A;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00AC: Result:= #$5F;  // NOT SIGN
    $00AD: Result:= #$CA;  // SOFT HYPHEN
    $00AE: Result:= #$AF;  // REGISTERED SIGN
    $00AF: Result:= #$BC;  // MACRON
    $00B0: Result:= #$90;  // DEGREE SIGN
    $00B1: Result:= #$8F;  // PLUS-MINUS SIGN
    $00B2: Result:= #$EA;  // SUPERSCRIPT TWO
    $00B3: Result:= #$FA;  // SUPERSCRIPT THREE
    $00B4: Result:= #$BE;  // ACUTE ACCENT
    $00B5: Result:= #$A0;  // MICRO SIGN
    $00B7: Result:= #$B3;  // MIDDLE DOT
    $00B8: Result:= #$9D;  // CEDILLA
    $00B9: Result:= #$DA;  // SUPERSCRIPT ONE
    $00BA: Result:= #$9B;  // MASCULINE ORDINAL INDICATOR
    $00BB: Result:= #$8B;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00BC: Result:= #$B7;  // VULGAR FRACTION ONE QUARTER
    $00BD: Result:= #$B8;  // VULGAR FRACTION ONE HALF
    $00BE: Result:= #$B9;  // VULGAR FRACTION THREE QUARTERS
    $00BF: Result:= #$AB;  // INVERTED QUESTION MARK
    $00C0: Result:= #$64;  // LATIN CAPITAL LETTER A WITH GRAVE
    $00C1: Result:= #$65;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00C2: Result:= #$62;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00C3: Result:= #$66;  // LATIN CAPITAL LETTER A WITH TILDE
    $00C4: Result:= #$63;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00C5: Result:= #$67;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00C6: Result:= #$9E;  // LATIN CAPITAL LIGATURE AE
    $00C7: Result:= #$68;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00C8: Result:= #$74;  // LATIN CAPITAL LETTER E WITH GRAVE
    $00C9: Result:= #$71;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00CA: Result:= #$72;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $00CB: Result:= #$73;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $00CC: Result:= #$78;  // LATIN CAPITAL LETTER I WITH GRAVE
    $00CD: Result:= #$75;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00CE: Result:= #$76;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $00CF: Result:= #$77;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $00D0: Result:= #$AC;  // LATIN CAPITAL LETTER ETH (ICELANDIC)
    $00D1: Result:= #$69;  // LATIN CAPITAL LETTER N WITH TILDE
    $00D2: Result:= #$ED;  // LATIN CAPITAL LETTER O WITH GRAVE
    $00D3: Result:= #$EE;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00D4: Result:= #$EB;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00D5: Result:= #$EF;  // LATIN CAPITAL LETTER O WITH TILDE
    $00D6: Result:= #$EC;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00D7: Result:= #$BF;  // MULTIPLICATION SIGN
    $00D8: Result:= #$80;  // LATIN CAPITAL LETTER O WITH STROKE
    $00D9: Result:= #$FD;  // LATIN CAPITAL LETTER U WITH GRAVE
    $00DA: Result:= #$FE;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00DB: Result:= #$FB;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $00DC: Result:= #$FC;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00DD: Result:= #$AD;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $00DE: Result:= #$AE;  // LATIN CAPITAL LETTER THORN (ICELANDIC)
    $00DF: Result:= #$59;  // LATIN SMALL LETTER SHARP S (GERMAN)
    $00E0: Result:= #$44;  // LATIN SMALL LETTER A WITH GRAVE
    $00E1: Result:= #$45;  // LATIN SMALL LETTER A WITH ACUTE
    $00E2: Result:= #$42;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00E3: Result:= #$46;  // LATIN SMALL LETTER A WITH TILDE
    $00E4: Result:= #$43;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00E5: Result:= #$47;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00E6: Result:= #$9C;  // LATIN SMALL LIGATURE AE
    $00E7: Result:= #$48;  // LATIN SMALL LETTER C WITH CEDILLA
    $00E8: Result:= #$54;  // LATIN SMALL LETTER E WITH GRAVE
    $00E9: Result:= #$51;  // LATIN SMALL LETTER E WITH ACUTE
    $00EA: Result:= #$52;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00EB: Result:= #$53;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00EC: Result:= #$58;  // LATIN SMALL LETTER I WITH GRAVE
    $00ED: Result:= #$55;  // LATIN SMALL LETTER I WITH ACUTE
    $00EE: Result:= #$56;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00EF: Result:= #$57;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00F0: Result:= #$8C;  // LATIN SMALL LETTER ETH (ICELANDIC)
    $00F1: Result:= #$49;  // LATIN SMALL LETTER N WITH TILDE
    $00F2: Result:= #$CD;  // LATIN SMALL LETTER O WITH GRAVE
    $00F3: Result:= #$CE;  // LATIN SMALL LETTER O WITH ACUTE
    $00F4: Result:= #$CB;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00F5: Result:= #$CF;  // LATIN SMALL LETTER O WITH TILDE
    $00F6: Result:= #$CC;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00F7: Result:= #$E1;  // DIVISION SIGN
    $00F8: Result:= #$70;  // LATIN SMALL LETTER O WITH STROKE
    $00F9: Result:= #$DD;  // LATIN SMALL LETTER U WITH GRAVE
    $00FA: Result:= #$DE;  // LATIN SMALL LETTER U WITH ACUTE
    $00FB: Result:= #$DB;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00FC: Result:= #$DC;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00FD: Result:= #$8D;  // LATIN SMALL LETTER Y WITH ACUTE
    $00FE: Result:= #$8E;  // LATIN SMALL LETTER THORN (ICELANDIC)
    $00FF: Result:= #$DF;  // LATIN SMALL LETTER Y WITH DIAERESIS
  else
    raise EConvertError.CreateFmt('Invalid cp037 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp424Char(const I: longint): char;
begin
  case I of
    $0000..$0003,$000B..$0013,$0018..$0019,$001C..$001F,$00B6:
      Result:= Char(I);
    $0004: Result:= #$37;  // END OF TRANSMISSION
    $0005: Result:= #$2D;  // ENQUIRY
    $0006: Result:= #$2E;  // ACKNOWLEDGE
    $0007: Result:= #$2F;  // BELL
    $0008: Result:= #$16;  // BACKSPACE
    $0009: Result:= #$05;  // HORIZONTAL TABULATION
    $000A: Result:= #$25;  // LINE FEED
    $0014: Result:= #$3C;  // DEVICE CONTROL FOUR
    $0015: Result:= #$3D;  // NEGATIVE ACKNOWLEDGE
    $0016: Result:= #$32;  // SYNCHRONOUS IDLE
    $0017: Result:= #$26;  // END OF TRANSMISSION BLOCK
    $001A: Result:= #$3F;  // SUBSTITUTE
    $001B: Result:= #$27;  // ESCAPE
    $0020: Result:= #$40;  // SPACE
    $0021: Result:= #$5A;  // EXCLAMATION MARK
    $0022: Result:= #$7F;  // QUOTATION MARK
    $0023: Result:= #$7B;  // NUMBER SIGN
    $0024: Result:= #$5B;  // DOLLAR SIGN
    $0025: Result:= #$6C;  // PERCENT SIGN
    $0026: Result:= #$50;  // AMPERSAND
    $0027: Result:= #$7D;  // APOSTROPHE
    $0028: Result:= #$4D;  // LEFT PARENTHESIS
    $0029: Result:= #$5D;  // RIGHT PARENTHESIS
    $002A: Result:= #$5C;  // ASTERISK
    $002B: Result:= #$4E;  // PLUS SIGN
    $002C: Result:= #$6B;  // COMMA
    $002D: Result:= #$60;  // HYPHEN-MINUS
    $002E: Result:= #$4B;  // FULL STOP
    $002F: Result:= #$61;  // SOLIDUS
    $0030: Result:= #$F0;  // DIGIT ZERO
    $0031: Result:= #$F1;  // DIGIT ONE
    $0032: Result:= #$F2;  // DIGIT TWO
    $0033: Result:= #$F3;  // DIGIT THREE
    $0034: Result:= #$F4;  // DIGIT FOUR
    $0035: Result:= #$F5;  // DIGIT FIVE
    $0036: Result:= #$F6;  // DIGIT SIX
    $0037: Result:= #$F7;  // DIGIT SEVEN
    $0038: Result:= #$F8;  // DIGIT EIGHT
    $0039: Result:= #$F9;  // DIGIT NINE
    $003A: Result:= #$7A;  // COLON
    $003B: Result:= #$5E;  // SEMICOLON
    $003C: Result:= #$4C;  // LESS-THAN SIGN
    $003D: Result:= #$7E;  // EQUALS SIGN
    $003E: Result:= #$6E;  // GREATER-THAN SIGN
    $003F: Result:= #$6F;  // QUESTION MARK
    $0040: Result:= #$7C;  // COMMERCIAL AT
    $0041: Result:= #$C1;  // LATIN CAPITAL LETTER A
    $0042: Result:= #$C2;  // LATIN CAPITAL LETTER B
    $0043: Result:= #$C3;  // LATIN CAPITAL LETTER C
    $0044: Result:= #$C4;  // LATIN CAPITAL LETTER D
    $0045: Result:= #$C5;  // LATIN CAPITAL LETTER E
    $0046: Result:= #$C6;  // LATIN CAPITAL LETTER F
    $0047: Result:= #$C7;  // LATIN CAPITAL LETTER G
    $0048: Result:= #$C8;  // LATIN CAPITAL LETTER H
    $0049: Result:= #$C9;  // LATIN CAPITAL LETTER I
    $004A: Result:= #$D1;  // LATIN CAPITAL LETTER J
    $004B: Result:= #$D2;  // LATIN CAPITAL LETTER K
    $004C: Result:= #$D3;  // LATIN CAPITAL LETTER L
    $004D: Result:= #$D4;  // LATIN CAPITAL LETTER M
    $004E: Result:= #$D5;  // LATIN CAPITAL LETTER N
    $004F: Result:= #$D6;  // LATIN CAPITAL LETTER O
    $0050: Result:= #$D7;  // LATIN CAPITAL LETTER P
    $0051: Result:= #$D8;  // LATIN CAPITAL LETTER Q
    $0052: Result:= #$D9;  // LATIN CAPITAL LETTER R
    $0053: Result:= #$E2;  // LATIN CAPITAL LETTER S
    $0054: Result:= #$E3;  // LATIN CAPITAL LETTER T
    $0055: Result:= #$E4;  // LATIN CAPITAL LETTER U
    $0056: Result:= #$E5;  // LATIN CAPITAL LETTER V
    $0057: Result:= #$E6;  // LATIN CAPITAL LETTER W
    $0058: Result:= #$E7;  // LATIN CAPITAL LETTER X
    $0059: Result:= #$E8;  // LATIN CAPITAL LETTER Y
    $005A: Result:= #$E9;  // LATIN CAPITAL LETTER Z
    $005B: Result:= #$BA;  // LEFT SQUARE BRACKET
    $005C: Result:= #$E0;  // REVERSE SOLIDUS
    $005D: Result:= #$BB;  // RIGHT SQUARE BRACKET
    $005E: Result:= #$B0;  // CIRCUMFLEX ACCENT
    $005F: Result:= #$6D;  // LOW LINE
    $0060: Result:= #$79;  // GRAVE ACCENT
    $0061: Result:= #$81;  // LATIN SMALL LETTER A
    $0062: Result:= #$82;  // LATIN SMALL LETTER B
    $0063: Result:= #$83;  // LATIN SMALL LETTER C
    $0064: Result:= #$84;  // LATIN SMALL LETTER D
    $0065: Result:= #$85;  // LATIN SMALL LETTER E
    $0066: Result:= #$86;  // LATIN SMALL LETTER F
    $0067: Result:= #$87;  // LATIN SMALL LETTER G
    $0068: Result:= #$88;  // LATIN SMALL LETTER H
    $0069: Result:= #$89;  // LATIN SMALL LETTER I
    $006A: Result:= #$91;  // LATIN SMALL LETTER J
    $006B: Result:= #$92;  // LATIN SMALL LETTER K
    $006C: Result:= #$93;  // LATIN SMALL LETTER L
    $006D: Result:= #$94;  // LATIN SMALL LETTER M
    $006E: Result:= #$95;  // LATIN SMALL LETTER N
    $006F: Result:= #$96;  // LATIN SMALL LETTER O
    $0070: Result:= #$97;  // LATIN SMALL LETTER P
    $0071: Result:= #$98;  // LATIN SMALL LETTER Q
    $0072: Result:= #$99;  // LATIN SMALL LETTER R
    $0073: Result:= #$A2;  // LATIN SMALL LETTER S
    $0074: Result:= #$A3;  // LATIN SMALL LETTER T
    $0075: Result:= #$A4;  // LATIN SMALL LETTER U
    $0076: Result:= #$A5;  // LATIN SMALL LETTER V
    $0077: Result:= #$A6;  // LATIN SMALL LETTER W
    $0078: Result:= #$A7;  // LATIN SMALL LETTER X
    $0079: Result:= #$A8;  // LATIN SMALL LETTER Y
    $007A: Result:= #$A9;  // LATIN SMALL LETTER Z
    $007B: Result:= #$C0;  // LEFT CURLY BRACKET
    $007C: Result:= #$4F;  // VERTICAL LINE
    $007D: Result:= #$D0;  // RIGHT CURLY BRACKET
    $007E: Result:= #$A1;  // TILDE
    $007F: Result:= #$07;  // DELETE
    $0080: Result:= #$20;  // DIGIT SELECT
    $0081: Result:= #$21;  // START OF SIGNIFICANCE
    $0082: Result:= #$22;  // FIELD SEPARATOR
    $0083: Result:= #$23;  // WORD UNDERSCORE
    $0084: Result:= #$24;  // BYPASS OR INHIBIT PRESENTATION
    $0085: Result:= #$15;  // NEW LINE
    $0086: Result:= #$06;  // REQUIRED NEW LINE
    $0087: Result:= #$17;  // PROGRAM OPERATOR COMMUNICATION
    $0088: Result:= #$28;  // SET ATTRIBUTE
    $0089: Result:= #$29;  // START FIELD EXTENDED
    $008A: Result:= #$2A;  // SET MODE OR SWITCH
    $008B: Result:= #$2B;  // CONTROL SEQUENCE PREFIX
    $008C: Result:= #$2C;  // MODIFY FIELD ATTRIBUTE
    $008D: Result:= #$09;  // SUPERSCRIPT
    $008E: Result:= #$0A;  // REPEAT
    $008F: Result:= #$1B;  // CUSTOMER USE ONE
    $0090: Result:= #$30;  // <reserved>
    $0091: Result:= #$31;  // <reserved>
    $0092: Result:= #$1A;  // UNIT BACK SPACE
    $0093: Result:= #$33;  // INDEX RETURN
    $0094: Result:= #$34;  // PRESENTATION POSITION
    $0095: Result:= #$35;  // TRANSPARENT
    $0096: Result:= #$36;  // NUMERIC BACKSPACE
    $0097: Result:= #$08;  // GRAPHIC ESCAPE
    $0098: Result:= #$38;  // SUBSCRIPT
    $0099: Result:= #$39;  // INDENT TABULATION
    $009A: Result:= #$3A;  // REVERSE FORM FEED
    $009B: Result:= #$3B;  // CUSTOMER USE THREE
    $009C: Result:= #$04;  // SELECT
    $009D: Result:= #$14;  // RESTORE/ENABLE PRESENTATION
    $009E: Result:= #$3E;  // <reserved>
    $009F: Result:= #$FF;  // EIGHT ONES
    $00A0: Result:= #$74;  // NO-BREAK SPACE
    $00A2: Result:= #$4A;  // CENT SIGN
    $00A3: Result:= #$B1;  // POUND SIGN
    $00A4: Result:= #$9F;  // CURRENCY SIGN
    $00A5: Result:= #$B2;  // YEN SIGN
    $00A6: Result:= #$6A;  // BROKEN BAR
    $00A7: Result:= #$B5;  // SECTION SIGN
    $00A8: Result:= #$BD;  // DIAERESIS
    $00A9: Result:= #$B4;  // COPYRIGHT SIGN
    $00AB: Result:= #$8A;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00AC: Result:= #$5F;  // NOT SIGN
    $00AD: Result:= #$CA;  // SOFT HYPHEN
    $00AE: Result:= #$AF;  // REGISTERED SIGN
    $00AF: Result:= #$BC;  // MACRON
    $00B0: Result:= #$90;  // DEGREE SIGN
    $00B1: Result:= #$8F;  // PLUS-MINUS SIGN
    $00B2: Result:= #$EA;  // SUPERSCRIPT TWO
    $00B3: Result:= #$FA;  // SUPERSCRIPT THREE
    $00B4: Result:= #$BE;  // ACUTE ACCENT
    $00B5: Result:= #$A0;  // MICRO SIGN
    $00B7: Result:= #$B3;  // MIDDLE DOT
    $00B8: Result:= #$9D;  // CEDILLA
    $00B9: Result:= #$DA;  // SUPERSCRIPT ONE
    $00BB: Result:= #$8B;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00BC: Result:= #$B7;  // VULGAR FRACTION ONE QUARTER
    $00BD: Result:= #$B8;  // VULGAR FRACTION ONE HALF
    $00BE: Result:= #$B9;  // VULGAR FRACTION THREE QUARTERS
    $00D7: Result:= #$BF;  // MULTIPLICATION SIGN
    $00F7: Result:= #$E1;  // DIVISION SIGN
    $05D0: Result:= #$41;  // HEBREW LETTER ALEF
    $05D1: Result:= #$42;  // HEBREW LETTER BET
    $05D2: Result:= #$43;  // HEBREW LETTER GIMEL
    $05D3: Result:= #$44;  // HEBREW LETTER DALET
    $05D4: Result:= #$45;  // HEBREW LETTER HE
    $05D5: Result:= #$46;  // HEBREW LETTER VAV
    $05D6: Result:= #$47;  // HEBREW LETTER ZAYIN
    $05D7: Result:= #$48;  // HEBREW LETTER HET
    $05D8: Result:= #$49;  // HEBREW LETTER TET
    $05D9: Result:= #$51;  // HEBREW LETTER YOD
    $05DA: Result:= #$52;  // HEBREW LETTER FINAL KAF
    $05DB: Result:= #$53;  // HEBREW LETTER KAF
    $05DC: Result:= #$54;  // HEBREW LETTER LAMED
    $05DD: Result:= #$55;  // HEBREW LETTER FINAL MEM
    $05DE: Result:= #$56;  // HEBREW LETTER MEM
    $05DF: Result:= #$57;  // HEBREW LETTER FINAL NUN
    $05E0: Result:= #$58;  // HEBREW LETTER NUN
    $05E1: Result:= #$59;  // HEBREW LETTER SAMEKH
    $05E2: Result:= #$62;  // HEBREW LETTER AYIN
    $05E3: Result:= #$63;  // HEBREW LETTER FINAL PE
    $05E4: Result:= #$64;  // HEBREW LETTER PE
    $05E5: Result:= #$65;  // HEBREW LETTER FINAL TSADI
    $05E6: Result:= #$66;  // HEBREW LETTER TSADI
    $05E7: Result:= #$67;  // HEBREW LETTER QOF
    $05E8: Result:= #$68;  // HEBREW LETTER RESH
    $05E9: Result:= #$69;  // HEBREW LETTER SHIN
    $05EA: Result:= #$71;  // HEBREW LETTER TAV
    $2017: Result:= #$78;  // DOUBLE LOW LINE
  else
    raise EConvertError.CreateFmt('Invalid cp424 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp437Char(const I: longint): char;
begin
  case I of
    $0000..$0019,$001b,$001d..$007e:
      Result:= Char(I);
    $001a: Result:= #$7f;
    $001c: Result:= #$1a;
    $007f: Result:= #$1c;
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a1: Result:= #$ad;  // INVERTED EXCLAMATION MARK
    $00a2: Result:= #$9b;  // CENT SIGN
    $00a3: Result:= #$9c;  // POUND SIGN
    $00a5: Result:= #$9d;  // YEN SIGN
    $00aa: Result:= #$a6;  // FEMININE ORDINAL INDICATOR
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00ba: Result:= #$a7;  // MASCULINE ORDINAL INDICATOR
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00bf: Result:= #$a8;  // INVERTED QUESTION MARK
    $00c4: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00c5: Result:= #$8f;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00c6: Result:= #$92;  // LATIN CAPITAL LIGATURE AE
    $00c7: Result:= #$80;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00d1: Result:= #$a5;  // LATIN CAPITAL LETTER N WITH TILDE
    $00d6: Result:= #$99;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S
    $00e0: Result:= #$85;  // LATIN SMALL LETTER A WITH GRAVE
    $00e1: Result:= #$a0;  // LATIN SMALL LETTER A WITH ACUTE
    $00e2: Result:= #$83;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e4: Result:= #$84;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00e5: Result:= #$86;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00e6: Result:= #$91;  // LATIN SMALL LIGATURE AE
    $00e7: Result:= #$87;  // LATIN SMALL LETTER C WITH CEDILLA
    $00e8: Result:= #$8a;  // LATIN SMALL LETTER E WITH GRAVE
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00ea: Result:= #$88;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00eb: Result:= #$89;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00ec: Result:= #$8d;  // LATIN SMALL LETTER I WITH GRAVE
    $00ed: Result:= #$a1;  // LATIN SMALL LETTER I WITH ACUTE
    $00ee: Result:= #$8c;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00ef: Result:= #$8b;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00f1: Result:= #$a4;  // LATIN SMALL LETTER N WITH TILDE
    $00f2: Result:= #$95;  // LATIN SMALL LETTER O WITH GRAVE
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$93;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f6: Result:= #$94;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00f9: Result:= #$97;  // LATIN SMALL LETTER U WITH GRAVE
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $00fb: Result:= #$96;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00ff: Result:= #$98;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $0192: Result:= #$9f;  // LATIN SMALL LETTER F WITH HOOK
    $0393: Result:= #$e2;  // GREEK CAPITAL LETTER GAMMA
    $0398: Result:= #$e9;  // GREEK CAPITAL LETTER THETA
    $03a3: Result:= #$e4;  // GREEK CAPITAL LETTER SIGMA
    $03a6: Result:= #$e8;  // GREEK CAPITAL LETTER PHI
    $03a9: Result:= #$ea;  // GREEK CAPITAL LETTER OMEGA
    $03b1: Result:= #$e0;  // GREEK SMALL LETTER ALPHA
    $03b4: Result:= #$eb;  // GREEK SMALL LETTER DELTA
    $03b5: Result:= #$ee;  // GREEK SMALL LETTER EPSILON
    $03c0: Result:= #$e3;  // GREEK SMALL LETTER PI
    $03c3: Result:= #$e5;  // GREEK SMALL LETTER SIGMA
    $03c4: Result:= #$e7;  // GREEK SMALL LETTER TAU
    $03c6: Result:= #$ed;  // GREEK SMALL LETTER PHI
    $207f: Result:= #$fc;  // SUPERSCRIPT LATIN SMALL LETTER N
    $20a7: Result:= #$9e;  // PESETA SIGN
    $2219: Result:= #$f9;  // BULLET OPERATOR
    $221a: Result:= #$fb;  // SQUARE ROOT
    $221e: Result:= #$ec;  // INFINITY
    $2229: Result:= #$ef;  // INTERSECTION
    $2248: Result:= #$f7;  // ALMOST EQUAL TO
    $2261: Result:= #$f0;  // IDENTICAL TO
    $2264: Result:= #$f3;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$f2;  // GREATER-THAN OR EQUAL TO
    $2310: Result:= #$a9;  // REVERSED NOT SIGN
    $2320: Result:= #$f4;  // TOP HALF INTEGRAL
    $2321: Result:= #$f5;  // BOTTOM HALF INTEGRAL
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: Result:= #$d5;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $2553: Result:= #$d6;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: Result:= #$b8;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: Result:= #$b7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: Result:= #$d4;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: Result:= #$d3;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255b: Result:= #$be;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255c: Result:= #$bd;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255e: Result:= #$c6;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255f: Result:= #$c7;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: Result:= #$b5;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $2562: Result:= #$b6;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: Result:= #$d1;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: Result:= #$d2;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: Result:= #$cf;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: Result:= #$d0;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256a: Result:= #$d8;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256b: Result:= #$d7;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $258c: Result:= #$dd;  // LEFT HALF BLOCK
    $2590: Result:= #$de;  // RIGHT HALF BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp437 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp437_DOSLatinUSChar(const I: longint): char;
begin
  case I of
    $0000..$007f: Result:= Char(I);
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a1: Result:= #$ad;  // INVERTED EXCLAMATION MARK
    $00a2: Result:= #$9b;  // CENT SIGN
    $00a3: Result:= #$9c;  // POUND SIGN
    $00a5: Result:= #$9d;  // YEN SIGN
    $00aa: Result:= #$a6;  // FEMININE ORDINAL INDICATOR
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00ba: Result:= #$a7;  // MASCULINE ORDINAL INDICATOR
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00bf: Result:= #$a8;  // INVERTED QUESTION MARK
    $00c4: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00c5: Result:= #$8f;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00c6: Result:= #$92;  // LATIN CAPITAL LIGATURE AE
    $00c7: Result:= #$80;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00d1: Result:= #$a5;  // LATIN CAPITAL LETTER N WITH TILDE
    $00d6: Result:= #$99;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S
    $00e0: Result:= #$85;  // LATIN SMALL LETTER A WITH GRAVE
    $00e1: Result:= #$a0;  // LATIN SMALL LETTER A WITH ACUTE
    $00e2: Result:= #$83;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e4: Result:= #$84;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00e5: Result:= #$86;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00e6: Result:= #$91;  // LATIN SMALL LIGATURE AE
    $00e7: Result:= #$87;  // LATIN SMALL LETTER C WITH CEDILLA
    $00e8: Result:= #$8a;  // LATIN SMALL LETTER E WITH GRAVE
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00ea: Result:= #$88;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00eb: Result:= #$89;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00ec: Result:= #$8d;  // LATIN SMALL LETTER I WITH GRAVE
    $00ed: Result:= #$a1;  // LATIN SMALL LETTER I WITH ACUTE
    $00ee: Result:= #$8c;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00ef: Result:= #$8b;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00f1: Result:= #$a4;  // LATIN SMALL LETTER N WITH TILDE
    $00f2: Result:= #$95;  // LATIN SMALL LETTER O WITH GRAVE
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$93;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f6: Result:= #$94;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00f9: Result:= #$97;  // LATIN SMALL LETTER U WITH GRAVE
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $00fb: Result:= #$96;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00ff: Result:= #$98;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $0192: Result:= #$9f;  // LATIN SMALL LETTER F WITH HOOK
    $0393: Result:= #$e2;  // GREEK CAPITAL LETTER GAMMA
    $0398: Result:= #$e9;  // GREEK CAPITAL LETTER THETA
    $03a3: Result:= #$e4;  // GREEK CAPITAL LETTER SIGMA
    $03a6: Result:= #$e8;  // GREEK CAPITAL LETTER PHI
    $03a9: Result:= #$ea;  // GREEK CAPITAL LETTER OMEGA
    $03b1: Result:= #$e0;  // GREEK SMALL LETTER ALPHA
    $03b4: Result:= #$eb;  // GREEK SMALL LETTER DELTA
    $03b5: Result:= #$ee;  // GREEK SMALL LETTER EPSILON
    $03c0: Result:= #$e3;  // GREEK SMALL LETTER PI
    $03c3: Result:= #$e5;  // GREEK SMALL LETTER SIGMA
    $03c4: Result:= #$e7;  // GREEK SMALL LETTER TAU
    $03c6: Result:= #$ed;  // GREEK SMALL LETTER PHI
    $207f: Result:= #$fc;  // SUPERSCRIPT LATIN SMALL LETTER N
    $20a7: Result:= #$9e;  // PESETA SIGN
    $2219: Result:= #$f9;  // BULLET OPERATOR
    $221a: Result:= #$fb;  // SQUARE ROOT
    $221e: Result:= #$ec;  // INFINITY
    $2229: Result:= #$ef;  // INTERSECTION
    $2248: Result:= #$f7;  // ALMOST EQUAL TO
    $2261: Result:= #$f0;  // IDENTICAL TO
    $2264: Result:= #$f3;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$f2;  // GREATER-THAN OR EQUAL TO
    $2310: Result:= #$a9;  // REVERSED NOT SIGN
    $2320: Result:= #$f4;  // TOP HALF INTEGRAL
    $2321: Result:= #$f5;  // BOTTOM HALF INTEGRAL
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: Result:= #$d5;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $2553: Result:= #$d6;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: Result:= #$b8;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: Result:= #$b7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: Result:= #$d4;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: Result:= #$d3;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255b: Result:= #$be;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255c: Result:= #$bd;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255e: Result:= #$c6;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255f: Result:= #$c7;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: Result:= #$b5;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $2562: Result:= #$b6;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: Result:= #$d1;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: Result:= #$d2;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: Result:= #$cf;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: Result:= #$d0;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256a: Result:= #$d8;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256b: Result:= #$d7;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $258c: Result:= #$dd;  // LEFT HALF BLOCK
    $2590: Result:= #$de;  // RIGHT HALF BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp437_DOSLatinUS sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp500Char(const I: longint): char;
begin
  case I of
    $0000..$0003,$000B..$0013,$0018..$0019,$001C..$001F,$00B6: Result:= Char(I);
    $0004: Result:= #$37;  // END OF TRANSMISSION
    $0005: Result:= #$2D;  // ENQUIRY
    $0006: Result:= #$2E;  // ACKNOWLEDGE
    $0007: Result:= #$2F;  // BELL
    $0008: Result:= #$16;  // BACKSPACE
    $0009: Result:= #$05;  // HORIZONTAL TABULATION
    $000A: Result:= #$25;  // LINE FEED
    $0014: Result:= #$3C;  // DEVICE CONTROL FOUR
    $0015: Result:= #$3D;  // NEGATIVE ACKNOWLEDGE
    $0016: Result:= #$32;  // SYNCHRONOUS IDLE
    $0017: Result:= #$26;  // END OF TRANSMISSION BLOCK
    $001A: Result:= #$3F;  // SUBSTITUTE
    $001B: Result:= #$27;  // ESCAPE
    $0020: Result:= #$40;  // SPACE
    $0021: Result:= #$4F;  // EXCLAMATION MARK
    $0022: Result:= #$7F;  // QUOTATION MARK
    $0023: Result:= #$7B;  // NUMBER SIGN
    $0024: Result:= #$5B;  // DOLLAR SIGN
    $0025: Result:= #$6C;  // PERCENT SIGN
    $0026: Result:= #$50;  // AMPERSAND
    $0027: Result:= #$7D;  // APOSTROPHE
    $0028: Result:= #$4D;  // LEFT PARENTHESIS
    $0029: Result:= #$5D;  // RIGHT PARENTHESIS
    $002A: Result:= #$5C;  // ASTERISK
    $002B: Result:= #$4E;  // PLUS SIGN
    $002C: Result:= #$6B;  // COMMA
    $002D: Result:= #$60;  // HYPHEN-MINUS
    $002E: Result:= #$4B;  // FULL STOP
    $002F: Result:= #$61;  // SOLIDUS
    $0030: Result:= #$F0;  // DIGIT ZERO
    $0031: Result:= #$F1;  // DIGIT ONE
    $0032: Result:= #$F2;  // DIGIT TWO
    $0033: Result:= #$F3;  // DIGIT THREE
    $0034: Result:= #$F4;  // DIGIT FOUR
    $0035: Result:= #$F5;  // DIGIT FIVE
    $0036: Result:= #$F6;  // DIGIT SIX
    $0037: Result:= #$F7;  // DIGIT SEVEN
    $0038: Result:= #$F8;  // DIGIT EIGHT
    $0039: Result:= #$F9;  // DIGIT NINE
    $003A: Result:= #$7A;  // COLON
    $003B: Result:= #$5E;  // SEMICOLON
    $003C: Result:= #$4C;  // LESS-THAN SIGN
    $003D: Result:= #$7E;  // EQUALS SIGN
    $003E: Result:= #$6E;  // GREATER-THAN SIGN
    $003F: Result:= #$6F;  // QUESTION MARK
    $0040: Result:= #$7C;  // COMMERCIAL AT
    $0041: Result:= #$C1;  // LATIN CAPITAL LETTER A
    $0042: Result:= #$C2;  // LATIN CAPITAL LETTER B
    $0043: Result:= #$C3;  // LATIN CAPITAL LETTER C
    $0044: Result:= #$C4;  // LATIN CAPITAL LETTER D
    $0045: Result:= #$C5;  // LATIN CAPITAL LETTER E
    $0046: Result:= #$C6;  // LATIN CAPITAL LETTER F
    $0047: Result:= #$C7;  // LATIN CAPITAL LETTER G
    $0048: Result:= #$C8;  // LATIN CAPITAL LETTER H
    $0049: Result:= #$C9;  // LATIN CAPITAL LETTER I
    $004A: Result:= #$D1;  // LATIN CAPITAL LETTER J
    $004B: Result:= #$D2;  // LATIN CAPITAL LETTER K
    $004C: Result:= #$D3;  // LATIN CAPITAL LETTER L
    $004D: Result:= #$D4;  // LATIN CAPITAL LETTER M
    $004E: Result:= #$D5;  // LATIN CAPITAL LETTER N
    $004F: Result:= #$D6;  // LATIN CAPITAL LETTER O
    $0050: Result:= #$D7;  // LATIN CAPITAL LETTER P
    $0051: Result:= #$D8;  // LATIN CAPITAL LETTER Q
    $0052: Result:= #$D9;  // LATIN CAPITAL LETTER R
    $0053: Result:= #$E2;  // LATIN CAPITAL LETTER S
    $0054: Result:= #$E3;  // LATIN CAPITAL LETTER T
    $0055: Result:= #$E4;  // LATIN CAPITAL LETTER U
    $0056: Result:= #$E5;  // LATIN CAPITAL LETTER V
    $0057: Result:= #$E6;  // LATIN CAPITAL LETTER W
    $0058: Result:= #$E7;  // LATIN CAPITAL LETTER X
    $0059: Result:= #$E8;  // LATIN CAPITAL LETTER Y
    $005A: Result:= #$E9;  // LATIN CAPITAL LETTER Z
    $005B: Result:= #$4A;  // LEFT SQUARE BRACKET
    $005C: Result:= #$E0;  // REVERSE SOLIDUS
    $005D: Result:= #$5A;  // RIGHT SQUARE BRACKET
    $005E: Result:= #$5F;  // CIRCUMFLEX ACCENT
    $005F: Result:= #$6D;  // LOW LINE
    $0060: Result:= #$79;  // GRAVE ACCENT
    $0061: Result:= #$81;  // LATIN SMALL LETTER A
    $0062: Result:= #$82;  // LATIN SMALL LETTER B
    $0063: Result:= #$83;  // LATIN SMALL LETTER C
    $0064: Result:= #$84;  // LATIN SMALL LETTER D
    $0065: Result:= #$85;  // LATIN SMALL LETTER E
    $0066: Result:= #$86;  // LATIN SMALL LETTER F
    $0067: Result:= #$87;  // LATIN SMALL LETTER G
    $0068: Result:= #$88;  // LATIN SMALL LETTER H
    $0069: Result:= #$89;  // LATIN SMALL LETTER I
    $006A: Result:= #$91;  // LATIN SMALL LETTER J
    $006B: Result:= #$92;  // LATIN SMALL LETTER K
    $006C: Result:= #$93;  // LATIN SMALL LETTER L
    $006D: Result:= #$94;  // LATIN SMALL LETTER M
    $006E: Result:= #$95;  // LATIN SMALL LETTER N
    $006F: Result:= #$96;  // LATIN SMALL LETTER O
    $0070: Result:= #$97;  // LATIN SMALL LETTER P
    $0071: Result:= #$98;  // LATIN SMALL LETTER Q
    $0072: Result:= #$99;  // LATIN SMALL LETTER R
    $0073: Result:= #$A2;  // LATIN SMALL LETTER S
    $0074: Result:= #$A3;  // LATIN SMALL LETTER T
    $0075: Result:= #$A4;  // LATIN SMALL LETTER U
    $0076: Result:= #$A5;  // LATIN SMALL LETTER V
    $0077: Result:= #$A6;  // LATIN SMALL LETTER W
    $0078: Result:= #$A7;  // LATIN SMALL LETTER X
    $0079: Result:= #$A8;  // LATIN SMALL LETTER Y
    $007A: Result:= #$A9;  // LATIN SMALL LETTER Z
    $007B: Result:= #$C0;  // LEFT CURLY BRACKET
    $007C: Result:= #$BB;  // VERTICAL LINE
    $007D: Result:= #$D0;  // RIGHT CURLY BRACKET
    $007E: Result:= #$A1;  // TILDE
    $007F: Result:= #$07;  // DELETE
    $0080: Result:= #$20;  // CONTROL
    $0081: Result:= #$21;  // CONTROL
    $0082: Result:= #$22;  // CONTROL
    $0083: Result:= #$23;  // CONTROL
    $0084: Result:= #$24;  // CONTROL
    $0085: Result:= #$15;  // CONTROL
    $0086: Result:= #$06;  // CONTROL
    $0087: Result:= #$17;  // CONTROL
    $0088: Result:= #$28;  // CONTROL
    $0089: Result:= #$29;  // CONTROL
    $008A: Result:= #$2A;  // CONTROL
    $008B: Result:= #$2B;  // CONTROL
    $008C: Result:= #$2C;  // CONTROL
    $008D: Result:= #$09;  // CONTROL
    $008E: Result:= #$0A;  // CONTROL
    $008F: Result:= #$1B;  // CONTROL
    $0090: Result:= #$30;  // CONTROL
    $0091: Result:= #$31;  // CONTROL
    $0092: Result:= #$1A;  // CONTROL
    $0093: Result:= #$33;  // CONTROL
    $0094: Result:= #$34;  // CONTROL
    $0095: Result:= #$35;  // CONTROL
    $0096: Result:= #$36;  // CONTROL
    $0097: Result:= #$08;  // CONTROL
    $0098: Result:= #$38;  // CONTROL
    $0099: Result:= #$39;  // CONTROL
    $009A: Result:= #$3A;  // CONTROL
    $009B: Result:= #$3B;  // CONTROL
    $009C: Result:= #$04;  // CONTROL
    $009D: Result:= #$14;  // CONTROL
    $009E: Result:= #$3E;  // CONTROL
    $009F: Result:= #$FF;  // CONTROL
    $00A0: Result:= #$41;  // NO-BREAK SPACE
    $00A1: Result:= #$AA;  // INVERTED EXCLAMATION MARK
    $00A2: Result:= #$B0;  // CENT SIGN
    $00A3: Result:= #$B1;  // POUND SIGN
    $00A4: Result:= #$9F;  // CURRENCY SIGN
    $00A5: Result:= #$B2;  // YEN SIGN
    $00A6: Result:= #$6A;  // BROKEN BAR
    $00A7: Result:= #$B5;  // SECTION SIGN
    $00A8: Result:= #$BD;  // DIAERESIS
    $00A9: Result:= #$B4;  // COPYRIGHT SIGN
    $00AA: Result:= #$9A;  // FEMININE ORDINAL INDICATOR
    $00AB: Result:= #$8A;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00AC: Result:= #$BA;  // NOT SIGN
    $00AD: Result:= #$CA;  // SOFT HYPHEN
    $00AE: Result:= #$AF;  // REGISTERED SIGN
    $00AF: Result:= #$BC;  // MACRON
    $00B0: Result:= #$90;  // DEGREE SIGN
    $00B1: Result:= #$8F;  // PLUS-MINUS SIGN
    $00B2: Result:= #$EA;  // SUPERSCRIPT TWO
    $00B3: Result:= #$FA;  // SUPERSCRIPT THREE
    $00B4: Result:= #$BE;  // ACUTE ACCENT
    $00B5: Result:= #$A0;  // MICRO SIGN
    $00B7: Result:= #$B3;  // MIDDLE DOT
    $00B8: Result:= #$9D;  // CEDILLA
    $00B9: Result:= #$DA;  // SUPERSCRIPT ONE
    $00BA: Result:= #$9B;  // MASCULINE ORDINAL INDICATOR
    $00BB: Result:= #$8B;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00BC: Result:= #$B7;  // VULGAR FRACTION ONE QUARTER
    $00BD: Result:= #$B8;  // VULGAR FRACTION ONE HALF
    $00BE: Result:= #$B9;  // VULGAR FRACTION THREE QUARTERS
    $00BF: Result:= #$AB;  // INVERTED QUESTION MARK
    $00C0: Result:= #$64;  // LATIN CAPITAL LETTER A WITH GRAVE
    $00C1: Result:= #$65;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00C2: Result:= #$62;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00C3: Result:= #$66;  // LATIN CAPITAL LETTER A WITH TILDE
    $00C4: Result:= #$63;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00C5: Result:= #$67;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00C6: Result:= #$9E;  // LATIN CAPITAL LIGATURE AE
    $00C7: Result:= #$68;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00C8: Result:= #$74;  // LATIN CAPITAL LETTER E WITH GRAVE
    $00C9: Result:= #$71;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00CA: Result:= #$72;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $00CB: Result:= #$73;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $00CC: Result:= #$78;  // LATIN CAPITAL LETTER I WITH GRAVE
    $00CD: Result:= #$75;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00CE: Result:= #$76;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $00CF: Result:= #$77;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $00D0: Result:= #$AC;  // LATIN CAPITAL LETTER ETH (ICELANDIC)
    $00D1: Result:= #$69;  // LATIN CAPITAL LETTER N WITH TILDE
    $00D2: Result:= #$ED;  // LATIN CAPITAL LETTER O WITH GRAVE
    $00D3: Result:= #$EE;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00D4: Result:= #$EB;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00D5: Result:= #$EF;  // LATIN CAPITAL LETTER O WITH TILDE
    $00D6: Result:= #$EC;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00D7: Result:= #$BF;  // MULTIPLICATION SIGN
    $00D8: Result:= #$80;  // LATIN CAPITAL LETTER O WITH STROKE
    $00D9: Result:= #$FD;  // LATIN CAPITAL LETTER U WITH GRAVE
    $00DA: Result:= #$FE;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00DB: Result:= #$FB;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $00DC: Result:= #$FC;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00DD: Result:= #$AD;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $00DE: Result:= #$AE;  // LATIN CAPITAL LETTER THORN (ICELANDIC)
    $00DF: Result:= #$59;  // LATIN SMALL LETTER SHARP S (GERMAN)
    $00E0: Result:= #$44;  // LATIN SMALL LETTER A WITH GRAVE
    $00E1: Result:= #$45;  // LATIN SMALL LETTER A WITH ACUTE
    $00E2: Result:= #$42;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00E3: Result:= #$46;  // LATIN SMALL LETTER A WITH TILDE
    $00E4: Result:= #$43;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00E5: Result:= #$47;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00E6: Result:= #$9C;  // LATIN SMALL LIGATURE AE
    $00E7: Result:= #$48;  // LATIN SMALL LETTER C WITH CEDILLA
    $00E8: Result:= #$54;  // LATIN SMALL LETTER E WITH GRAVE
    $00E9: Result:= #$51;  // LATIN SMALL LETTER E WITH ACUTE
    $00EA: Result:= #$52;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00EB: Result:= #$53;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00EC: Result:= #$58;  // LATIN SMALL LETTER I WITH GRAVE
    $00ED: Result:= #$55;  // LATIN SMALL LETTER I WITH ACUTE
    $00EE: Result:= #$56;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00EF: Result:= #$57;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00F0: Result:= #$8C;  // LATIN SMALL LETTER ETH (ICELANDIC)
    $00F1: Result:= #$49;  // LATIN SMALL LETTER N WITH TILDE
    $00F2: Result:= #$CD;  // LATIN SMALL LETTER O WITH GRAVE
    $00F3: Result:= #$CE;  // LATIN SMALL LETTER O WITH ACUTE
    $00F4: Result:= #$CB;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00F5: Result:= #$CF;  // LATIN SMALL LETTER O WITH TILDE
    $00F6: Result:= #$CC;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00F7: Result:= #$E1;  // DIVISION SIGN
    $00F8: Result:= #$70;  // LATIN SMALL LETTER O WITH STROKE
    $00F9: Result:= #$DD;  // LATIN SMALL LETTER U WITH GRAVE
    $00FA: Result:= #$DE;  // LATIN SMALL LETTER U WITH ACUTE
    $00FB: Result:= #$DB;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00FC: Result:= #$DC;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00FD: Result:= #$8D;  // LATIN SMALL LETTER Y WITH ACUTE
    $00FE: Result:= #$8E;  // LATIN SMALL LETTER THORN (ICELANDIC)
    $00FF: Result:= #$DF;  // LATIN SMALL LETTER Y WITH DIAERESIS
  else
    raise EConvertError.CreateFmt('Invalid cp500 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp737_DOSGreekChar(const I: longint): char;
begin
  case I of
    $0000..$007f: Result:= Char(I);
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $0386: Result:= #$ea;  // GREEK CAPITAL LETTER ALPHA WITH TONOS
    $0388: Result:= #$eb;  // GREEK CAPITAL LETTER EPSILON WITH TONOS
    $0389: Result:= #$ec;  // GREEK CAPITAL LETTER ETA WITH TONOS
    $038a: Result:= #$ed;  // GREEK CAPITAL LETTER IOTA WITH TONOS
    $038c: Result:= #$ee;  // GREEK CAPITAL LETTER OMICRON WITH TONOS
    $038e: Result:= #$ef;  // GREEK CAPITAL LETTER UPSILON WITH TONOS
    $038f: Result:= #$f0;  // GREEK CAPITAL LETTER OMEGA WITH TONOS
    $0391: Result:= #$80;  // GREEK CAPITAL LETTER ALPHA
    $0392: Result:= #$81;  // GREEK CAPITAL LETTER BETA
    $0393: Result:= #$82;  // GREEK CAPITAL LETTER GAMMA
    $0394: Result:= #$83;  // GREEK CAPITAL LETTER DELTA
    $0395: Result:= #$84;  // GREEK CAPITAL LETTER EPSILON
    $0396: Result:= #$85;  // GREEK CAPITAL LETTER ZETA
    $0397: Result:= #$86;  // GREEK CAPITAL LETTER ETA
    $0398: Result:= #$87;  // GREEK CAPITAL LETTER THETA
    $0399: Result:= #$88;  // GREEK CAPITAL LETTER IOTA
    $039a: Result:= #$89;  // GREEK CAPITAL LETTER KAPPA
    $039b: Result:= #$8a;  // GREEK CAPITAL LETTER LAMDA
    $039c: Result:= #$8b;  // GREEK CAPITAL LETTER MU
    $039d: Result:= #$8c;  // GREEK CAPITAL LETTER NU
    $039e: Result:= #$8d;  // GREEK CAPITAL LETTER XI
    $039f: Result:= #$8e;  // GREEK CAPITAL LETTER OMICRON
    $03a0: Result:= #$8f;  // GREEK CAPITAL LETTER PI
    $03a1: Result:= #$90;  // GREEK CAPITAL LETTER RHO
    $03a3: Result:= #$91;  // GREEK CAPITAL LETTER SIGMA
    $03a4: Result:= #$92;  // GREEK CAPITAL LETTER TAU
    $03a5: Result:= #$93;  // GREEK CAPITAL LETTER UPSILON
    $03a6: Result:= #$94;  // GREEK CAPITAL LETTER PHI
    $03a7: Result:= #$95;  // GREEK CAPITAL LETTER CHI
    $03a8: Result:= #$96;  // GREEK CAPITAL LETTER PSI
    $03a9: Result:= #$97;  // GREEK CAPITAL LETTER OMEGA
    $03aa: Result:= #$f4;  // GREEK CAPITAL LETTER IOTA WITH DIALYTIKA
    $03ab: Result:= #$f5;  // GREEK CAPITAL LETTER UPSILON WITH DIALYTIKA
    $03ac: Result:= #$e1;  // GREEK SMALL LETTER ALPHA WITH TONOS
    $03ad: Result:= #$e2;  // GREEK SMALL LETTER EPSILON WITH TONOS
    $03ae: Result:= #$e3;  // GREEK SMALL LETTER ETA WITH TONOS
    $03af: Result:= #$e5;  // GREEK SMALL LETTER IOTA WITH TONOS
    $03b1: Result:= #$98;  // GREEK SMALL LETTER ALPHA
    $03b2: Result:= #$99;  // GREEK SMALL LETTER BETA
    $03b3: Result:= #$9a;  // GREEK SMALL LETTER GAMMA
    $03b4: Result:= #$9b;  // GREEK SMALL LETTER DELTA
    $03b5: Result:= #$9c;  // GREEK SMALL LETTER EPSILON
    $03b6: Result:= #$9d;  // GREEK SMALL LETTER ZETA
    $03b7: Result:= #$9e;  // GREEK SMALL LETTER ETA
    $03b8: Result:= #$9f;  // GREEK SMALL LETTER THETA
    $03b9: Result:= #$a0;  // GREEK SMALL LETTER IOTA
    $03ba: Result:= #$a1;  // GREEK SMALL LETTER KAPPA
    $03bb: Result:= #$a2;  // GREEK SMALL LETTER LAMDA
    $03bc: Result:= #$a3;  // GREEK SMALL LETTER MU
    $03bd: Result:= #$a4;  // GREEK SMALL LETTER NU
    $03be: Result:= #$a5;  // GREEK SMALL LETTER XI
    $03bf: Result:= #$a6;  // GREEK SMALL LETTER OMICRON
    $03c0: Result:= #$a7;  // GREEK SMALL LETTER PI
    $03c1: Result:= #$a8;  // GREEK SMALL LETTER RHO
    $03c2: Result:= #$aa;  // GREEK SMALL LETTER FINAL SIGMA
    $03c3: Result:= #$a9;  // GREEK SMALL LETTER SIGMA
    $03c4: Result:= #$ab;  // GREEK SMALL LETTER TAU
    $03c5: Result:= #$ac;  // GREEK SMALL LETTER UPSILON
    $03c6: Result:= #$ad;  // GREEK SMALL LETTER PHI
    $03c7: Result:= #$ae;  // GREEK SMALL LETTER CHI
    $03c8: Result:= #$af;  // GREEK SMALL LETTER PSI
    $03c9: Result:= #$e0;  // GREEK SMALL LETTER OMEGA
    $03ca: Result:= #$e4;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA
    $03cb: Result:= #$e8;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA
    $03cc: Result:= #$e6;  // GREEK SMALL LETTER OMICRON WITH TONOS
    $03cd: Result:= #$e7;  // GREEK SMALL LETTER UPSILON WITH TONOS
    $03ce: Result:= #$e9;  // GREEK SMALL LETTER OMEGA WITH TONOS
    $207f: Result:= #$fc;  // SUPERSCRIPT LATIN SMALL LETTER N
    $2219: Result:= #$f9;  // BULLET OPERATOR
    $221a: Result:= #$fb;  // SQUARE ROOT
    $2248: Result:= #$f7;  // ALMOST EQUAL TO
    $2264: Result:= #$f3;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$f2;  // GREATER-THAN OR EQUAL TO
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: Result:= #$d5;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $2553: Result:= #$d6;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: Result:= #$b8;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: Result:= #$b7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: Result:= #$d4;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: Result:= #$d3;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255b: Result:= #$be;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255c: Result:= #$bd;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255e: Result:= #$c6;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255f: Result:= #$c7;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: Result:= #$b5;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $2562: Result:= #$b6;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: Result:= #$d1;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: Result:= #$d2;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: Result:= #$cf;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: Result:= #$d0;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256a: Result:= #$d8;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256b: Result:= #$d7;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $258c: Result:= #$dd;  // LEFT HALF BLOCK
    $2590: Result:= #$de;  // RIGHT HALF BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp737_DOSGreek sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp775_DOSBaltRimChar(const I: longint): char;
begin
  case I of
    $0000..$007f: Result:= Char(I);
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a2: Result:= #$96;  // CENT SIGN
    $00a3: Result:= #$9c;  // POUND SIGN
    $00a4: Result:= #$9f;  // CURRENCY SIGN
    $00a6: Result:= #$a7;  // BROKEN BAR
    $00a7: Result:= #$f5;  // SECTION SIGN
    $00a9: Result:= #$a8;  // COPYRIGHT SIGN
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00ad: Result:= #$f0;  // SOFT HYPHEN
    $00ae: Result:= #$a9;  // REGISTERED SIGN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b3: Result:= #$fc;  // SUPERSCRIPT THREE
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b6: Result:= #$f4;  // PILCROW SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00b9: Result:= #$fb;  // SUPERSCRIPT ONE
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00be: Result:= #$f3;  // VULGAR FRACTION THREE QUARTERS
    $00c4: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00c5: Result:= #$8f;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00c6: Result:= #$92;  // LATIN CAPITAL LIGATURE AE
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00d3: Result:= #$e0;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00d5: Result:= #$e5;  // LATIN CAPITAL LETTER O WITH TILDE
    $00d6: Result:= #$99;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00d7: Result:= #$9e;  // MULTIPLICATION SIGN
    $00d8: Result:= #$9d;  // LATIN CAPITAL LETTER O WITH STROKE
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S (GERMAN)
    $00e4: Result:= #$84;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00e5: Result:= #$86;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00e6: Result:= #$91;  // LATIN SMALL LIGATURE AE
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f5: Result:= #$e4;  // LATIN SMALL LETTER O WITH TILDE
    $00f6: Result:= #$94;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00f8: Result:= #$9b;  // LATIN SMALL LETTER O WITH STROKE
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $0100: Result:= #$a0;  // LATIN CAPITAL LETTER A WITH MACRON
    $0101: Result:= #$83;  // LATIN SMALL LETTER A WITH MACRON
    $0104: Result:= #$b5;  // LATIN CAPITAL LETTER A WITH OGONEK
    $0105: Result:= #$d0;  // LATIN SMALL LETTER A WITH OGONEK
    $0106: Result:= #$80;  // LATIN CAPITAL LETTER C WITH ACUTE
    $0107: Result:= #$87;  // LATIN SMALL LETTER C WITH ACUTE
    $010c: Result:= #$b6;  // LATIN CAPITAL LETTER C WITH CARON
    $010d: Result:= #$d1;  // LATIN SMALL LETTER C WITH CARON
    $0112: Result:= #$ed;  // LATIN CAPITAL LETTER E WITH MACRON
    $0113: Result:= #$89;  // LATIN SMALL LETTER E WITH MACRON
    $0116: Result:= #$b8;  // LATIN CAPITAL LETTER E WITH DOT ABOVE
    $0117: Result:= #$d3;  // LATIN SMALL LETTER E WITH DOT ABOVE
    $0118: Result:= #$b7;  // LATIN CAPITAL LETTER E WITH OGONEK
    $0119: Result:= #$d2;  // LATIN SMALL LETTER E WITH OGONEK
    $0122: Result:= #$95;  // LATIN CAPITAL LETTER G WITH CEDILLA
    $0123: Result:= #$85;  // LATIN SMALL LETTER G WITH CEDILLA
    $012a: Result:= #$a1;  // LATIN CAPITAL LETTER I WITH MACRON
    $012b: Result:= #$8c;  // LATIN SMALL LETTER I WITH MACRON
    $012e: Result:= #$bd;  // LATIN CAPITAL LETTER I WITH OGONEK
    $012f: Result:= #$d4;  // LATIN SMALL LETTER I WITH OGONEK
    $0136: Result:= #$e8;  // LATIN CAPITAL LETTER K WITH CEDILLA
    $0137: Result:= #$e9;  // LATIN SMALL LETTER K WITH CEDILLA
    $013b: Result:= #$ea;  // LATIN CAPITAL LETTER L WITH CEDILLA
    $013c: Result:= #$eb;  // LATIN SMALL LETTER L WITH CEDILLA
    $0141: Result:= #$ad;  // LATIN CAPITAL LETTER L WITH STROKE
    $0142: Result:= #$88;  // LATIN SMALL LETTER L WITH STROKE
    $0143: Result:= #$e3;  // LATIN CAPITAL LETTER N WITH ACUTE
    $0144: Result:= #$e7;  // LATIN SMALL LETTER N WITH ACUTE
    $0145: Result:= #$ee;  // LATIN CAPITAL LETTER N WITH CEDILLA
    $0146: Result:= #$ec;  // LATIN SMALL LETTER N WITH CEDILLA
    $014c: Result:= #$e2;  // LATIN CAPITAL LETTER O WITH MACRON
    $014d: Result:= #$93;  // LATIN SMALL LETTER O WITH MACRON
    $0156: Result:= #$8a;  // LATIN CAPITAL LETTER R WITH CEDILLA
    $0157: Result:= #$8b;  // LATIN SMALL LETTER R WITH CEDILLA
    $015a: Result:= #$97;  // LATIN CAPITAL LETTER S WITH ACUTE
    $015b: Result:= #$98;  // LATIN SMALL LETTER S WITH ACUTE
    $0160: Result:= #$be;  // LATIN CAPITAL LETTER S WITH CARON
    $0161: Result:= #$d5;  // LATIN SMALL LETTER S WITH CARON
    $016a: Result:= #$c7;  // LATIN CAPITAL LETTER U WITH MACRON
    $016b: Result:= #$d7;  // LATIN SMALL LETTER U WITH MACRON
    $0172: Result:= #$c6;  // LATIN CAPITAL LETTER U WITH OGONEK
    $0173: Result:= #$d6;  // LATIN SMALL LETTER U WITH OGONEK
    $0179: Result:= #$8d;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $017a: Result:= #$a5;  // LATIN SMALL LETTER Z WITH ACUTE
    $017b: Result:= #$a3;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $017c: Result:= #$a4;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $017d: Result:= #$cf;  // LATIN CAPITAL LETTER Z WITH CARON
    $017e: Result:= #$d8;  // LATIN SMALL LETTER Z WITH CARON
    $2019: Result:= #$ef;  // RIGHT SINGLE QUOTATION MARK
    $201c: Result:= #$f2;  // LEFT DOUBLE QUOTATION MARK
    $201d: Result:= #$a6;  // RIGHT DOUBLE QUOTATION MARK
    $201e: Result:= #$f7;  // DOUBLE LOW-9 QUOTATION MARK
    $2219: Result:= #$f9;  // BULLET OPERATOR
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $258c: Result:= #$dd;  // LEFT HALF BLOCK
    $2590: Result:= #$de;  // RIGHT HALF BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp775_DOSBaltRim sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp850Char(const I: longint): char;
begin
  case I of
    $0000..$0019,$001b,$001d..$007e:
      Result:= Char(I);
    $001a: Result:= #$7f;
    $001c: Result:= #$1a;
    $007f: Result:= #$1c;
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a1: Result:= #$ad;  // INVERTED EXCLAMATION MARK
    $00a2: Result:= #$bd;  // CENT SIGN
    $00a3: Result:= #$9c;  // POUND SIGN
    $00a4: Result:= #$cf;  // CURRENCY SIGN
    $00a5: Result:= #$be;  // YEN SIGN
    $00a6: Result:= #$dd;  // BROKEN BAR
    $00a7: Result:= #$f5;  // SECTION SIGN
    $00a8: Result:= #$f9;  // DIAERESIS
    $00a9: Result:= #$b8;  // COPYRIGHT SIGN
    $00aa: Result:= #$a6;  // FEMININE ORDINAL INDICATOR
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00ad: Result:= #$f0;  // SOFT HYPHEN
    $00ae: Result:= #$a9;  // REGISTERED SIGN
    $00af: Result:= #$ee;  // MACRON
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b3: Result:= #$fc;  // SUPERSCRIPT THREE
    $00b4: Result:= #$ef;  // ACUTE ACCENT
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b6: Result:= #$f4;  // PILCROW SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00b8: Result:= #$f7;  // CEDILLA
    $00b9: Result:= #$fb;  // SUPERSCRIPT ONE
    $00ba: Result:= #$a7;  // MASCULINE ORDINAL INDICATOR
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00be: Result:= #$f3;  // VULGAR FRACTION THREE QUARTERS
    $00bf: Result:= #$a8;  // INVERTED QUESTION MARK
    $00c0: Result:= #$b7;  // LATIN CAPITAL LETTER A WITH GRAVE
    $00c1: Result:= #$b5;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00c2: Result:= #$b6;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00c3: Result:= #$c7;  // LATIN CAPITAL LETTER A WITH TILDE
    $00c4: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00c5: Result:= #$8f;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00c6: Result:= #$92;  // LATIN CAPITAL LIGATURE AE
    $00c7: Result:= #$80;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00c8: Result:= #$d4;  // LATIN CAPITAL LETTER E WITH GRAVE
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00ca: Result:= #$d2;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $00cb: Result:= #$d3;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $00cc: Result:= #$de;  // LATIN CAPITAL LETTER I WITH GRAVE
    $00cd: Result:= #$d6;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00ce: Result:= #$d7;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $00cf: Result:= #$d8;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $00d0: Result:= #$d1;  // LATIN CAPITAL LETTER ETH
    $00d1: Result:= #$a5;  // LATIN CAPITAL LETTER N WITH TILDE
    $00d2: Result:= #$e3;  // LATIN CAPITAL LETTER O WITH GRAVE
    $00d3: Result:= #$e0;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00d4: Result:= #$e2;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00d5: Result:= #$e5;  // LATIN CAPITAL LETTER O WITH TILDE
    $00d6: Result:= #$99;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00d7: Result:= #$9e;  // MULTIPLICATION SIGN
    $00d8: Result:= #$9d;  // LATIN CAPITAL LETTER O WITH STROKE
    $00d9: Result:= #$eb;  // LATIN CAPITAL LETTER U WITH GRAVE
    $00da: Result:= #$e9;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00db: Result:= #$ea;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00dd: Result:= #$ed;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $00de: Result:= #$e8;  // LATIN CAPITAL LETTER THORN
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S
    $00e0: Result:= #$85;  // LATIN SMALL LETTER A WITH GRAVE
    $00e1: Result:= #$a0;  // LATIN SMALL LETTER A WITH ACUTE
    $00e2: Result:= #$83;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e3: Result:= #$c6;  // LATIN SMALL LETTER A WITH TILDE
    $00e4: Result:= #$84;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00e5: Result:= #$86;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00e6: Result:= #$91;  // LATIN SMALL LIGATURE AE
    $00e7: Result:= #$87;  // LATIN SMALL LETTER C WITH CEDILLA
    $00e8: Result:= #$8a;  // LATIN SMALL LETTER E WITH GRAVE
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00ea: Result:= #$88;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00eb: Result:= #$89;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00ec: Result:= #$8d;  // LATIN SMALL LETTER I WITH GRAVE
    $00ed: Result:= #$a1;  // LATIN SMALL LETTER I WITH ACUTE
    $00ee: Result:= #$8c;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00ef: Result:= #$8b;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00f0: Result:= #$d0;  // LATIN SMALL LETTER ETH
    $00f1: Result:= #$a4;  // LATIN SMALL LETTER N WITH TILDE
    $00f2: Result:= #$95;  // LATIN SMALL LETTER O WITH GRAVE
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$93;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f5: Result:= #$e4;  // LATIN SMALL LETTER O WITH TILDE
    $00f6: Result:= #$94;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00f8: Result:= #$9b;  // LATIN SMALL LETTER O WITH STROKE
    $00f9: Result:= #$97;  // LATIN SMALL LETTER U WITH GRAVE
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $00fb: Result:= #$96;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00fd: Result:= #$ec;  // LATIN SMALL LETTER Y WITH ACUTE
    $00fe: Result:= #$e7;  // LATIN SMALL LETTER THORN
    $00ff: Result:= #$98;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $0131: Result:= #$d5;  // LATIN SMALL LETTER DOTLESS I
    $0192: Result:= #$9f;  // LATIN SMALL LETTER F WITH HOOK
    $2017: Result:= #$f2;  // DOUBLE LOW LINE
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp850 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp850_DOSLatin1Char(const I: longint): char;
begin
  case I of
    $0000..$007f: Result:= Char(I);
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a1: Result:= #$ad;  // INVERTED EXCLAMATION MARK
    $00a2: Result:= #$bd;  // CENT SIGN
    $00a3: Result:= #$9c;  // POUND SIGN
    $00a4: Result:= #$cf;  // CURRENCY SIGN
    $00a5: Result:= #$be;  // YEN SIGN
    $00a6: Result:= #$dd;  // BROKEN BAR
    $00a7: Result:= #$f5;  // SECTION SIGN
    $00a8: Result:= #$f9;  // DIAERESIS
    $00a9: Result:= #$b8;  // COPYRIGHT SIGN
    $00aa: Result:= #$a6;  // FEMININE ORDINAL INDICATOR
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00ad: Result:= #$f0;  // SOFT HYPHEN
    $00ae: Result:= #$a9;  // REGISTERED SIGN
    $00af: Result:= #$ee;  // MACRON
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b3: Result:= #$fc;  // SUPERSCRIPT THREE
    $00b4: Result:= #$ef;  // ACUTE ACCENT
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b6: Result:= #$f4;  // PILCROW SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00b8: Result:= #$f7;  // CEDILLA
    $00b9: Result:= #$fb;  // SUPERSCRIPT ONE
    $00ba: Result:= #$a7;  // MASCULINE ORDINAL INDICATOR
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00be: Result:= #$f3;  // VULGAR FRACTION THREE QUARTERS
    $00bf: Result:= #$a8;  // INVERTED QUESTION MARK
    $00c0: Result:= #$b7;  // LATIN CAPITAL LETTER A WITH GRAVE
    $00c1: Result:= #$b5;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00c2: Result:= #$b6;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00c3: Result:= #$c7;  // LATIN CAPITAL LETTER A WITH TILDE
    $00c4: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00c5: Result:= #$8f;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00c6: Result:= #$92;  // LATIN CAPITAL LIGATURE AE
    $00c7: Result:= #$80;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00c8: Result:= #$d4;  // LATIN CAPITAL LETTER E WITH GRAVE
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00ca: Result:= #$d2;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $00cb: Result:= #$d3;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $00cc: Result:= #$de;  // LATIN CAPITAL LETTER I WITH GRAVE
    $00cd: Result:= #$d6;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00ce: Result:= #$d7;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $00cf: Result:= #$d8;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $00d0: Result:= #$d1;  // LATIN CAPITAL LETTER ETH
    $00d1: Result:= #$a5;  // LATIN CAPITAL LETTER N WITH TILDE
    $00d2: Result:= #$e3;  // LATIN CAPITAL LETTER O WITH GRAVE
    $00d3: Result:= #$e0;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00d4: Result:= #$e2;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00d5: Result:= #$e5;  // LATIN CAPITAL LETTER O WITH TILDE
    $00d6: Result:= #$99;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00d7: Result:= #$9e;  // MULTIPLICATION SIGN
    $00d8: Result:= #$9d;  // LATIN CAPITAL LETTER O WITH STROKE
    $00d9: Result:= #$eb;  // LATIN CAPITAL LETTER U WITH GRAVE
    $00da: Result:= #$e9;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00db: Result:= #$ea;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00dd: Result:= #$ed;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $00de: Result:= #$e8;  // LATIN CAPITAL LETTER THORN
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S
    $00e0: Result:= #$85;  // LATIN SMALL LETTER A WITH GRAVE
    $00e1: Result:= #$a0;  // LATIN SMALL LETTER A WITH ACUTE
    $00e2: Result:= #$83;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e3: Result:= #$c6;  // LATIN SMALL LETTER A WITH TILDE
    $00e4: Result:= #$84;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00e5: Result:= #$86;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00e6: Result:= #$91;  // LATIN SMALL LIGATURE AE
    $00e7: Result:= #$87;  // LATIN SMALL LETTER C WITH CEDILLA
    $00e8: Result:= #$8a;  // LATIN SMALL LETTER E WITH GRAVE
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00ea: Result:= #$88;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00eb: Result:= #$89;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00ec: Result:= #$8d;  // LATIN SMALL LETTER I WITH GRAVE
    $00ed: Result:= #$a1;  // LATIN SMALL LETTER I WITH ACUTE
    $00ee: Result:= #$8c;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00ef: Result:= #$8b;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00f0: Result:= #$d0;  // LATIN SMALL LETTER ETH
    $00f1: Result:= #$a4;  // LATIN SMALL LETTER N WITH TILDE
    $00f2: Result:= #$95;  // LATIN SMALL LETTER O WITH GRAVE
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$93;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f5: Result:= #$e4;  // LATIN SMALL LETTER O WITH TILDE
    $00f6: Result:= #$94;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00f8: Result:= #$9b;  // LATIN SMALL LETTER O WITH STROKE
    $00f9: Result:= #$97;  // LATIN SMALL LETTER U WITH GRAVE
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $00fb: Result:= #$96;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00fd: Result:= #$ec;  // LATIN SMALL LETTER Y WITH ACUTE
    $00fe: Result:= #$e7;  // LATIN SMALL LETTER THORN
    $00ff: Result:= #$98;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $0131: Result:= #$d5;  // LATIN SMALL LETTER DOTLESS I
    $0192: Result:= #$9f;  // LATIN SMALL LETTER F WITH HOOK
    $2017: Result:= #$f2;  // DOUBLE LOW LINE
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp850_DOSLatin1 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp852Char(const I: longint): char;
begin
  case I of
    $0000..$0019,$001b,$001d..$007e:
      Result:= Char(I);
    $001a: Result:= #$7f;
    $001c: Result:= #$1a;
    $007f: Result:= #$1c;
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a4: Result:= #$cf;  // CURRENCY SIGN
    $00a7: Result:= #$f5;  // SECTION SIGN
    $00a8: Result:= #$f9;  // DIAERESIS
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ad: Result:= #$f0;  // SOFT HYPHEN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b4: Result:= #$ef;  // ACUTE ACCENT
    $00b8: Result:= #$f7;  // CEDILLA
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00c1: Result:= #$b5;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00c2: Result:= #$b6;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00c4: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00c7: Result:= #$80;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00cb: Result:= #$d3;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $00cd: Result:= #$d6;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00ce: Result:= #$d7;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $00d3: Result:= #$e0;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00d4: Result:= #$e2;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00d6: Result:= #$99;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00d7: Result:= #$9e;  // MULTIPLICATION SIGN
    $00da: Result:= #$e9;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00dd: Result:= #$ed;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S
    $00e1: Result:= #$a0;  // LATIN SMALL LETTER A WITH ACUTE
    $00e2: Result:= #$83;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e4: Result:= #$84;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00e7: Result:= #$87;  // LATIN SMALL LETTER C WITH CEDILLA
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00eb: Result:= #$89;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00ed: Result:= #$a1;  // LATIN SMALL LETTER I WITH ACUTE
    $00ee: Result:= #$8c;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$93;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f6: Result:= #$94;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00fd: Result:= #$ec;  // LATIN SMALL LETTER Y WITH ACUTE
    $0102: Result:= #$c6;  // LATIN CAPITAL LETTER A WITH BREVE
    $0103: Result:= #$c7;  // LATIN SMALL LETTER A WITH BREVE
    $0104: Result:= #$a4;  // LATIN CAPITAL LETTER A WITH OGONEK
    $0105: Result:= #$a5;  // LATIN SMALL LETTER A WITH OGONEK
    $0106: Result:= #$8f;  // LATIN CAPITAL LETTER C WITH ACUTE
    $0107: Result:= #$86;  // LATIN SMALL LETTER C WITH ACUTE
    $010c: Result:= #$ac;  // LATIN CAPITAL LETTER C WITH CARON
    $010d: Result:= #$9f;  // LATIN SMALL LETTER C WITH CARON
    $010e: Result:= #$d2;  // LATIN CAPITAL LETTER D WITH CARON
    $010f: Result:= #$d4;  // LATIN SMALL LETTER D WITH CARON
    $0110: Result:= #$d1;  // LATIN CAPITAL LETTER D WITH STROKE
    $0111: Result:= #$d0;  // LATIN SMALL LETTER D WITH STROKE
    $0118: Result:= #$a8;  // LATIN CAPITAL LETTER E WITH OGONEK
    $0119: Result:= #$a9;  // LATIN SMALL LETTER E WITH OGONEK
    $011a: Result:= #$b7;  // LATIN CAPITAL LETTER E WITH CARON
    $011b: Result:= #$d8;  // LATIN SMALL LETTER E WITH CARON
    $0139: Result:= #$91;  // LATIN CAPITAL LETTER L WITH ACUTE
    $013a: Result:= #$92;  // LATIN SMALL LETTER L WITH ACUTE
    $013d: Result:= #$95;  // LATIN CAPITAL LETTER L WITH CARON
    $013e: Result:= #$96;  // LATIN SMALL LETTER L WITH CARON
    $0141: Result:= #$9d;  // LATIN CAPITAL LETTER L WITH STROKE
    $0142: Result:= #$88;  // LATIN SMALL LETTER L WITH STROKE
    $0143: Result:= #$e3;  // LATIN CAPITAL LETTER N WITH ACUTE
    $0144: Result:= #$e4;  // LATIN SMALL LETTER N WITH ACUTE
    $0147: Result:= #$d5;  // LATIN CAPITAL LETTER N WITH CARON
    $0148: Result:= #$e5;  // LATIN SMALL LETTER N WITH CARON
    $0150: Result:= #$8a;  // LATIN CAPITAL LETTER O WITH DOUBLE ACUTE
    $0151: Result:= #$8b;  // LATIN SMALL LETTER O WITH DOUBLE ACUTE
    $0154: Result:= #$e8;  // LATIN CAPITAL LETTER R WITH ACUTE
    $0155: Result:= #$ea;  // LATIN SMALL LETTER R WITH ACUTE
    $0158: Result:= #$fc;  // LATIN CAPITAL LETTER R WITH CARON
    $0159: Result:= #$fd;  // LATIN SMALL LETTER R WITH CARON
    $015a: Result:= #$97;  // LATIN CAPITAL LETTER S WITH ACUTE
    $015b: Result:= #$98;  // LATIN SMALL LETTER S WITH ACUTE
    $015e: Result:= #$b8;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $015f: Result:= #$ad;  // LATIN SMALL LETTER S WITH CEDILLA
    $0160: Result:= #$e6;  // LATIN CAPITAL LETTER S WITH CARON
    $0161: Result:= #$e7;  // LATIN SMALL LETTER S WITH CARON
    $0162: Result:= #$dd;  // LATIN CAPITAL LETTER T WITH CEDILLA
    $0163: Result:= #$ee;  // LATIN SMALL LETTER T WITH CEDILLA
    $0164: Result:= #$9b;  // LATIN CAPITAL LETTER T WITH CARON
    $0165: Result:= #$9c;  // LATIN SMALL LETTER T WITH CARON
    $016e: Result:= #$de;  // LATIN CAPITAL LETTER U WITH RING ABOVE
    $016f: Result:= #$85;  // LATIN SMALL LETTER U WITH RING ABOVE
    $0170: Result:= #$eb;  // LATIN CAPITAL LETTER U WITH DOUBLE ACUTE
    $0171: Result:= #$fb;  // LATIN SMALL LETTER U WITH DOUBLE ACUTE
    $0179: Result:= #$8d;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $017a: Result:= #$ab;  // LATIN SMALL LETTER Z WITH ACUTE
    $017b: Result:= #$bd;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $017c: Result:= #$be;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $017d: Result:= #$a6;  // LATIN CAPITAL LETTER Z WITH CARON
    $017e: Result:= #$a7;  // LATIN SMALL LETTER Z WITH CARON
    $02c7: Result:= #$f3;  // CARON
    $02d8: Result:= #$f4;  // BREVE
    $02d9: Result:= #$fa;  // DOT ABOVE
    $02db: Result:= #$f2;  // OGONEK
    $02dd: Result:= #$f1;  // DOUBLE ACUTE ACCENT
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp852 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp852_DOSLatin2Char(const I: longint): char;
begin
  case I of
    $0000..$007f: Result:= Char(I);
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a4: Result:= #$cf;  // CURRENCY SIGN
    $00a7: Result:= #$f5;  // SECTION SIGN
    $00a8: Result:= #$f9;  // DIAERESIS
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00ad: Result:= #$f0;  // SOFT HYPHEN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b4: Result:= #$ef;  // ACUTE ACCENT
    $00b8: Result:= #$f7;  // CEDILLA
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00c1: Result:= #$b5;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00c2: Result:= #$b6;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00c4: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00c7: Result:= #$80;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00cb: Result:= #$d3;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $00cd: Result:= #$d6;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00ce: Result:= #$d7;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $00d3: Result:= #$e0;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00d4: Result:= #$e2;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00d6: Result:= #$99;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00d7: Result:= #$9e;  // MULTIPLICATION SIGN
    $00da: Result:= #$e9;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00dd: Result:= #$ed;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S
    $00e1: Result:= #$a0;  // LATIN SMALL LETTER A WITH ACUTE
    $00e2: Result:= #$83;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e4: Result:= #$84;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00e7: Result:= #$87;  // LATIN SMALL LETTER C WITH CEDILLA
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00eb: Result:= #$89;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00ed: Result:= #$a1;  // LATIN SMALL LETTER I WITH ACUTE
    $00ee: Result:= #$8c;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$93;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f6: Result:= #$94;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00fd: Result:= #$ec;  // LATIN SMALL LETTER Y WITH ACUTE
    $0102: Result:= #$c6;  // LATIN CAPITAL LETTER A WITH BREVE
    $0103: Result:= #$c7;  // LATIN SMALL LETTER A WITH BREVE
    $0104: Result:= #$a4;  // LATIN CAPITAL LETTER A WITH OGONEK
    $0105: Result:= #$a5;  // LATIN SMALL LETTER A WITH OGONEK
    $0106: Result:= #$8f;  // LATIN CAPITAL LETTER C WITH ACUTE
    $0107: Result:= #$86;  // LATIN SMALL LETTER C WITH ACUTE
    $010c: Result:= #$ac;  // LATIN CAPITAL LETTER C WITH CARON
    $010d: Result:= #$9f;  // LATIN SMALL LETTER C WITH CARON
    $010e: Result:= #$d2;  // LATIN CAPITAL LETTER D WITH CARON
    $010f: Result:= #$d4;  // LATIN SMALL LETTER D WITH CARON
    $0110: Result:= #$d1;  // LATIN CAPITAL LETTER D WITH STROKE
    $0111: Result:= #$d0;  // LATIN SMALL LETTER D WITH STROKE
    $0118: Result:= #$a8;  // LATIN CAPITAL LETTER E WITH OGONEK
    $0119: Result:= #$a9;  // LATIN SMALL LETTER E WITH OGONEK
    $011a: Result:= #$b7;  // LATIN CAPITAL LETTER E WITH CARON
    $011b: Result:= #$d8;  // LATIN SMALL LETTER E WITH CARON
    $0139: Result:= #$91;  // LATIN CAPITAL LETTER L WITH ACUTE
    $013a: Result:= #$92;  // LATIN SMALL LETTER L WITH ACUTE
    $013d: Result:= #$95;  // LATIN CAPITAL LETTER L WITH CARON
    $013e: Result:= #$96;  // LATIN SMALL LETTER L WITH CARON
    $0141: Result:= #$9d;  // LATIN CAPITAL LETTER L WITH STROKE
    $0142: Result:= #$88;  // LATIN SMALL LETTER L WITH STROKE
    $0143: Result:= #$e3;  // LATIN CAPITAL LETTER N WITH ACUTE
    $0144: Result:= #$e4;  // LATIN SMALL LETTER N WITH ACUTE
    $0147: Result:= #$d5;  // LATIN CAPITAL LETTER N WITH CARON
    $0148: Result:= #$e5;  // LATIN SMALL LETTER N WITH CARON
    $0150: Result:= #$8a;  // LATIN CAPITAL LETTER O WITH DOUBLE ACUTE
    $0151: Result:= #$8b;  // LATIN SMALL LETTER O WITH DOUBLE ACUTE
    $0154: Result:= #$e8;  // LATIN CAPITAL LETTER R WITH ACUTE
    $0155: Result:= #$ea;  // LATIN SMALL LETTER R WITH ACUTE
    $0158: Result:= #$fc;  // LATIN CAPITAL LETTER R WITH CARON
    $0159: Result:= #$fd;  // LATIN SMALL LETTER R WITH CARON
    $015a: Result:= #$97;  // LATIN CAPITAL LETTER S WITH ACUTE
    $015b: Result:= #$98;  // LATIN SMALL LETTER S WITH ACUTE
    $015e: Result:= #$b8;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $015f: Result:= #$ad;  // LATIN SMALL LETTER S WITH CEDILLA
    $0160: Result:= #$e6;  // LATIN CAPITAL LETTER S WITH CARON
    $0161: Result:= #$e7;  // LATIN SMALL LETTER S WITH CARON
    $0162: Result:= #$dd;  // LATIN CAPITAL LETTER T WITH CEDILLA
    $0163: Result:= #$ee;  // LATIN SMALL LETTER T WITH CEDILLA
    $0164: Result:= #$9b;  // LATIN CAPITAL LETTER T WITH CARON
    $0165: Result:= #$9c;  // LATIN SMALL LETTER T WITH CARON
    $016e: Result:= #$de;  // LATIN CAPITAL LETTER U WITH RING ABOVE
    $016f: Result:= #$85;  // LATIN SMALL LETTER U WITH RING ABOVE
    $0170: Result:= #$eb;  // LATIN CAPITAL LETTER U WITH DOUBLE ACUTE
    $0171: Result:= #$fb;  // LATIN SMALL LETTER U WITH DOUBLE ACUTE
    $0179: Result:= #$8d;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $017a: Result:= #$ab;  // LATIN SMALL LETTER Z WITH ACUTE
    $017b: Result:= #$bd;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $017c: Result:= #$be;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $017d: Result:= #$a6;  // LATIN CAPITAL LETTER Z WITH CARON
    $017e: Result:= #$a7;  // LATIN SMALL LETTER Z WITH CARON
    $02c7: Result:= #$f3;  // CARON
    $02d8: Result:= #$f4;  // BREVE
    $02d9: Result:= #$fa;  // DOT ABOVE
    $02db: Result:= #$f2;  // OGONEK
    $02dd: Result:= #$f1;  // DOUBLE ACUTE ACCENT
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp852_DOSLatin2 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp855Char(const I: longint): char;
begin
  case I of
    $0000..$0019,$001b,$001d..$007e:
      Result:= Char(I);
    $001a: Result:= #$7f;
    $001c: Result:= #$1a;
    $007f: Result:= #$1c;
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a4: Result:= #$cf;  // CURRENCY SIGN
    $00a7: Result:= #$fd;  // SECTION SIGN
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ad: Result:= #$f0;  // SOFT HYPHEN
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $0401: Result:= #$85;  // CYRILLIC CAPITAL LETTER IO
    $0402: Result:= #$81;  // CYRILLIC CAPITAL LETTER DJE
    $0403: Result:= #$83;  // CYRILLIC CAPITAL LETTER GJE
    $0404: Result:= #$87;  // CYRILLIC CAPITAL LETTER UKRAINIAN IE
    $0405: Result:= #$89;  // CYRILLIC CAPITAL LETTER DZE
    $0406: Result:= #$8b;  // CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I
    $0407: Result:= #$8d;  // CYRILLIC CAPITAL LETTER YI
    $0408: Result:= #$8f;  // CYRILLIC CAPITAL LETTER JE
    $0409: Result:= #$91;  // CYRILLIC CAPITAL LETTER LJE
    $040a: Result:= #$93;  // CYRILLIC CAPITAL LETTER NJE
    $040b: Result:= #$95;  // CYRILLIC CAPITAL LETTER TSHE
    $040c: Result:= #$97;  // CYRILLIC CAPITAL LETTER KJE
    $040e: Result:= #$99;  // CYRILLIC CAPITAL LETTER SHORT U
    $040f: Result:= #$9b;  // CYRILLIC CAPITAL LETTER DZHE
    $0410: Result:= #$a1;  // CYRILLIC CAPITAL LETTER A
    $0411: Result:= #$a3;  // CYRILLIC CAPITAL LETTER BE
    $0412: Result:= #$ec;  // CYRILLIC CAPITAL LETTER VE
    $0413: Result:= #$ad;  // CYRILLIC CAPITAL LETTER GHE
    $0414: Result:= #$a7;  // CYRILLIC CAPITAL LETTER DE
    $0415: Result:= #$a9;  // CYRILLIC CAPITAL LETTER IE
    $0416: Result:= #$ea;  // CYRILLIC CAPITAL LETTER ZHE
    $0417: Result:= #$f4;  // CYRILLIC CAPITAL LETTER ZE
    $0418: Result:= #$b8;  // CYRILLIC CAPITAL LETTER I
    $0419: Result:= #$be;  // CYRILLIC CAPITAL LETTER SHORT I
    $041a: Result:= #$c7;  // CYRILLIC CAPITAL LETTER KA
    $041b: Result:= #$d1;  // CYRILLIC CAPITAL LETTER EL
    $041c: Result:= #$d3;  // CYRILLIC CAPITAL LETTER EM
    $041d: Result:= #$d5;  // CYRILLIC CAPITAL LETTER EN
    $041e: Result:= #$d7;  // CYRILLIC CAPITAL LETTER O
    $041f: Result:= #$dd;  // CYRILLIC CAPITAL LETTER PE
    $0420: Result:= #$e2;  // CYRILLIC CAPITAL LETTER ER
    $0421: Result:= #$e4;  // CYRILLIC CAPITAL LETTER ES
    $0422: Result:= #$e6;  // CYRILLIC CAPITAL LETTER TE
    $0423: Result:= #$e8;  // CYRILLIC CAPITAL LETTER U
    $0424: Result:= #$ab;  // CYRILLIC CAPITAL LETTER EF
    $0425: Result:= #$b6;  // CYRILLIC CAPITAL LETTER HA
    $0426: Result:= #$a5;  // CYRILLIC CAPITAL LETTER TSE
    $0427: Result:= #$fc;  // CYRILLIC CAPITAL LETTER CHE
    $0428: Result:= #$f6;  // CYRILLIC CAPITAL LETTER SHA
    $0429: Result:= #$fa;  // CYRILLIC CAPITAL LETTER SHCHA
    $042a: Result:= #$9f;  // CYRILLIC CAPITAL LETTER HARD SIGN
    $042b: Result:= #$f2;  // CYRILLIC CAPITAL LETTER YERU
    $042c: Result:= #$ee;  // CYRILLIC CAPITAL LETTER SOFT SIGN
    $042d: Result:= #$f8;  // CYRILLIC CAPITAL LETTER E
    $042e: Result:= #$9d;  // CYRILLIC CAPITAL LETTER YU
    $042f: Result:= #$e0;  // CYRILLIC CAPITAL LETTER YA
    $0430: Result:= #$a0;  // CYRILLIC SMALL LETTER A
    $0431: Result:= #$a2;  // CYRILLIC SMALL LETTER BE
    $0432: Result:= #$eb;  // CYRILLIC SMALL LETTER VE
    $0433: Result:= #$ac;  // CYRILLIC SMALL LETTER GHE
    $0434: Result:= #$a6;  // CYRILLIC SMALL LETTER DE
    $0435: Result:= #$a8;  // CYRILLIC SMALL LETTER IE
    $0436: Result:= #$e9;  // CYRILLIC SMALL LETTER ZHE
    $0437: Result:= #$f3;  // CYRILLIC SMALL LETTER ZE
    $0438: Result:= #$b7;  // CYRILLIC SMALL LETTER I
    $0439: Result:= #$bd;  // CYRILLIC SMALL LETTER SHORT I
    $043a: Result:= #$c6;  // CYRILLIC SMALL LETTER KA
    $043b: Result:= #$d0;  // CYRILLIC SMALL LETTER EL
    $043c: Result:= #$d2;  // CYRILLIC SMALL LETTER EM
    $043d: Result:= #$d4;  // CYRILLIC SMALL LETTER EN
    $043e: Result:= #$d6;  // CYRILLIC SMALL LETTER O
    $043f: Result:= #$d8;  // CYRILLIC SMALL LETTER PE
    $0440: Result:= #$e1;  // CYRILLIC SMALL LETTER ER
    $0441: Result:= #$e3;  // CYRILLIC SMALL LETTER ES
    $0442: Result:= #$e5;  // CYRILLIC SMALL LETTER TE
    $0443: Result:= #$e7;  // CYRILLIC SMALL LETTER U
    $0444: Result:= #$aa;  // CYRILLIC SMALL LETTER EF
    $0445: Result:= #$b5;  // CYRILLIC SMALL LETTER HA
    $0446: Result:= #$a4;  // CYRILLIC SMALL LETTER TSE
    $0447: Result:= #$fb;  // CYRILLIC SMALL LETTER CHE
    $0448: Result:= #$f5;  // CYRILLIC SMALL LETTER SHA
    $0449: Result:= #$f9;  // CYRILLIC SMALL LETTER SHCHA
    $044a: Result:= #$9e;  // CYRILLIC SMALL LETTER HARD SIGN
    $044b: Result:= #$f1;  // CYRILLIC SMALL LETTER YERU
    $044c: Result:= #$ed;  // CYRILLIC SMALL LETTER SOFT SIGN
    $044d: Result:= #$f7;  // CYRILLIC SMALL LETTER E
    $044e: Result:= #$9c;  // CYRILLIC SMALL LETTER YU
    $044f: Result:= #$de;  // CYRILLIC SMALL LETTER YA
    $0451: Result:= #$84;  // CYRILLIC SMALL LETTER IO
    $0452: Result:= #$80;  // CYRILLIC SMALL LETTER DJE
    $0453: Result:= #$82;  // CYRILLIC SMALL LETTER GJE
    $0454: Result:= #$86;  // CYRILLIC SMALL LETTER UKRAINIAN IE
    $0455: Result:= #$88;  // CYRILLIC SMALL LETTER DZE
    $0456: Result:= #$8a;  // CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I
    $0457: Result:= #$8c;  // CYRILLIC SMALL LETTER YI
    $0458: Result:= #$8e;  // CYRILLIC SMALL LETTER JE
    $0459: Result:= #$90;  // CYRILLIC SMALL LETTER LJE
    $045a: Result:= #$92;  // CYRILLIC SMALL LETTER NJE
    $045b: Result:= #$94;  // CYRILLIC SMALL LETTER TSHE
    $045c: Result:= #$96;  // CYRILLIC SMALL LETTER KJE
    $045e: Result:= #$98;  // CYRILLIC SMALL LETTER SHORT U
    $045f: Result:= #$9a;  // CYRILLIC SMALL LETTER DZHE
    $2116: Result:= #$ef;  // NUMERO SIGN
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp855 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp855_DOSCyrillicChar(const I: longint): char;
begin
  case I of
    $0000..$007f: Result:= Char(I);
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a4: Result:= #$cf;  // CURRENCY SIGN
    $00a7: Result:= #$fd;  // SECTION SIGN
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ad: Result:= #$f0;  // SOFT HYPHEN
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $0401: Result:= #$85;  // CYRILLIC CAPITAL LETTER IO
    $0402: Result:= #$81;  // CYRILLIC CAPITAL LETTER DJE
    $0403: Result:= #$83;  // CYRILLIC CAPITAL LETTER GJE
    $0404: Result:= #$87;  // CYRILLIC CAPITAL LETTER UKRAINIAN IE
    $0405: Result:= #$89;  // CYRILLIC CAPITAL LETTER DZE
    $0406: Result:= #$8b;  // CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I
    $0407: Result:= #$8d;  // CYRILLIC CAPITAL LETTER YI
    $0408: Result:= #$8f;  // CYRILLIC CAPITAL LETTER JE
    $0409: Result:= #$91;  // CYRILLIC CAPITAL LETTER LJE
    $040a: Result:= #$93;  // CYRILLIC CAPITAL LETTER NJE
    $040b: Result:= #$95;  // CYRILLIC CAPITAL LETTER TSHE
    $040c: Result:= #$97;  // CYRILLIC CAPITAL LETTER KJE
    $040e: Result:= #$99;  // CYRILLIC CAPITAL LETTER SHORT U
    $040f: Result:= #$9b;  // CYRILLIC CAPITAL LETTER DZHE
    $0410: Result:= #$a1;  // CYRILLIC CAPITAL LETTER A
    $0411: Result:= #$a3;  // CYRILLIC CAPITAL LETTER BE
    $0412: Result:= #$ec;  // CYRILLIC CAPITAL LETTER VE
    $0413: Result:= #$ad;  // CYRILLIC CAPITAL LETTER GHE
    $0414: Result:= #$a7;  // CYRILLIC CAPITAL LETTER DE
    $0415: Result:= #$a9;  // CYRILLIC CAPITAL LETTER IE
    $0416: Result:= #$ea;  // CYRILLIC CAPITAL LETTER ZHE
    $0417: Result:= #$f4;  // CYRILLIC CAPITAL LETTER ZE
    $0418: Result:= #$b8;  // CYRILLIC CAPITAL LETTER I
    $0419: Result:= #$be;  // CYRILLIC CAPITAL LETTER SHORT I
    $041a: Result:= #$c7;  // CYRILLIC CAPITAL LETTER KA
    $041b: Result:= #$d1;  // CYRILLIC CAPITAL LETTER EL
    $041c: Result:= #$d3;  // CYRILLIC CAPITAL LETTER EM
    $041d: Result:= #$d5;  // CYRILLIC CAPITAL LETTER EN
    $041e: Result:= #$d7;  // CYRILLIC CAPITAL LETTER O
    $041f: Result:= #$dd;  // CYRILLIC CAPITAL LETTER PE
    $0420: Result:= #$e2;  // CYRILLIC CAPITAL LETTER ER
    $0421: Result:= #$e4;  // CYRILLIC CAPITAL LETTER ES
    $0422: Result:= #$e6;  // CYRILLIC CAPITAL LETTER TE
    $0423: Result:= #$e8;  // CYRILLIC CAPITAL LETTER U
    $0424: Result:= #$ab;  // CYRILLIC CAPITAL LETTER EF
    $0425: Result:= #$b6;  // CYRILLIC CAPITAL LETTER HA
    $0426: Result:= #$a5;  // CYRILLIC CAPITAL LETTER TSE
    $0427: Result:= #$fc;  // CYRILLIC CAPITAL LETTER CHE
    $0428: Result:= #$f6;  // CYRILLIC CAPITAL LETTER SHA
    $0429: Result:= #$fa;  // CYRILLIC CAPITAL LETTER SHCHA
    $042a: Result:= #$9f;  // CYRILLIC CAPITAL LETTER HARD SIGN
    $042b: Result:= #$f2;  // CYRILLIC CAPITAL LETTER YERU
    $042c: Result:= #$ee;  // CYRILLIC CAPITAL LETTER SOFT SIGN
    $042d: Result:= #$f8;  // CYRILLIC CAPITAL LETTER E
    $042e: Result:= #$9d;  // CYRILLIC CAPITAL LETTER YU
    $042f: Result:= #$e0;  // CYRILLIC CAPITAL LETTER YA
    $0430: Result:= #$a0;  // CYRILLIC SMALL LETTER A
    $0431: Result:= #$a2;  // CYRILLIC SMALL LETTER BE
    $0432: Result:= #$eb;  // CYRILLIC SMALL LETTER VE
    $0433: Result:= #$ac;  // CYRILLIC SMALL LETTER GHE
    $0434: Result:= #$a6;  // CYRILLIC SMALL LETTER DE
    $0435: Result:= #$a8;  // CYRILLIC SMALL LETTER IE
    $0436: Result:= #$e9;  // CYRILLIC SMALL LETTER ZHE
    $0437: Result:= #$f3;  // CYRILLIC SMALL LETTER ZE
    $0438: Result:= #$b7;  // CYRILLIC SMALL LETTER I
    $0439: Result:= #$bd;  // CYRILLIC SMALL LETTER SHORT I
    $043a: Result:= #$c6;  // CYRILLIC SMALL LETTER KA
    $043b: Result:= #$d0;  // CYRILLIC SMALL LETTER EL
    $043c: Result:= #$d2;  // CYRILLIC SMALL LETTER EM
    $043d: Result:= #$d4;  // CYRILLIC SMALL LETTER EN
    $043e: Result:= #$d6;  // CYRILLIC SMALL LETTER O
    $043f: Result:= #$d8;  // CYRILLIC SMALL LETTER PE
    $0440: Result:= #$e1;  // CYRILLIC SMALL LETTER ER
    $0441: Result:= #$e3;  // CYRILLIC SMALL LETTER ES
    $0442: Result:= #$e5;  // CYRILLIC SMALL LETTER TE
    $0443: Result:= #$e7;  // CYRILLIC SMALL LETTER U
    $0444: Result:= #$aa;  // CYRILLIC SMALL LETTER EF
    $0445: Result:= #$b5;  // CYRILLIC SMALL LETTER HA
    $0446: Result:= #$a4;  // CYRILLIC SMALL LETTER TSE
    $0447: Result:= #$fb;  // CYRILLIC SMALL LETTER CHE
    $0448: Result:= #$f5;  // CYRILLIC SMALL LETTER SHA
    $0449: Result:= #$f9;  // CYRILLIC SMALL LETTER SHCHA
    $044a: Result:= #$9e;  // CYRILLIC SMALL LETTER HARD SIGN
    $044b: Result:= #$f1;  // CYRILLIC SMALL LETTER YERU
    $044c: Result:= #$ed;  // CYRILLIC SMALL LETTER SOFT SIGN
    $044d: Result:= #$f7;  // CYRILLIC SMALL LETTER E
    $044e: Result:= #$9c;  // CYRILLIC SMALL LETTER YU
    $044f: Result:= #$de;  // CYRILLIC SMALL LETTER YA
    $0451: Result:= #$84;  // CYRILLIC SMALL LETTER IO
    $0452: Result:= #$80;  // CYRILLIC SMALL LETTER DJE
    $0453: Result:= #$82;  // CYRILLIC SMALL LETTER GJE
    $0454: Result:= #$86;  // CYRILLIC SMALL LETTER UKRAINIAN IE
    $0455: Result:= #$88;  // CYRILLIC SMALL LETTER DZE
    $0456: Result:= #$8a;  // CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I
    $0457: Result:= #$8c;  // CYRILLIC SMALL LETTER YI
    $0458: Result:= #$8e;  // CYRILLIC SMALL LETTER JE
    $0459: Result:= #$90;  // CYRILLIC SMALL LETTER LJE
    $045a: Result:= #$92;  // CYRILLIC SMALL LETTER NJE
    $045b: Result:= #$94;  // CYRILLIC SMALL LETTER TSHE
    $045c: Result:= #$96;  // CYRILLIC SMALL LETTER KJE
    $045e: Result:= #$98;  // CYRILLIC SMALL LETTER SHORT U
    $045f: Result:= #$9a;  // CYRILLIC SMALL LETTER DZHE
    $2116: Result:= #$ef;  // NUMERO SIGN
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp855_DOSCyrillic sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp856_Hebrew_PCChar(const I: longint): char;
begin
  case I of
    $0000..$007F: Result:= Char(I);
    $00A0: Result:= #$FF;  // NO-BREAK SPACE
    $00A2: Result:= #$BD;  // CENT SIGN
    $00A3: Result:= #$9C;  // POUND SIGN
    $00A4: Result:= #$CF;  // CURRENCY SIGN
    $00A5: Result:= #$BE;  // YEN SIGN
    $00A6: Result:= #$DD;  // BROKEN BAR
    $00A7: Result:= #$F5;  // SECTION SIGN
    $00A8: Result:= #$F9;  // DIAERESIS
    $00A9: Result:= #$B8;  // COPYRIGHT SIGN
    $00AB: Result:= #$AE;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00AC: Result:= #$AA;  // NOT SIGN
    $00AD: Result:= #$F0;  // SOFT HYPHEN
    $00AE: Result:= #$A9;  // REGISTERED SIGN
    $00AF: Result:= #$EE;  // MACRON
    $00B0: Result:= #$F8;  // DEGREE SIGN
    $00B1: Result:= #$F1;  // PLUS-MINUS SIGN
    $00B2: Result:= #$FD;  // SUPERSCRIPT TWO
    $00B3: Result:= #$FC;  // SUPERSCRIPT THREE
    $00B4: Result:= #$EF;  // ACUTE ACCENT
    $00B5: Result:= #$E6;  // MICRO SIGN
    $00B6: Result:= #$F4;  // PILCROW SIGN
    $00B7: Result:= #$FA;  // MIDDLE DOT
    $00B8: Result:= #$F7;  // CEDILLA
    $00B9: Result:= #$FB;  // SUPERSCRIPT ONE
    $00BB: Result:= #$AF;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00BC: Result:= #$AC;  // VULGAR FRACTION ONE QUARTER
    $00BD: Result:= #$AB;  // VULGAR FRACTION ONE HALF
    $00BE: Result:= #$F3;  // VULGAR FRACTION THREE QUARTERS
    $00D7: Result:= #$9E;  // MULTIPLICATION SIGN
    $00F7: Result:= #$F6;  // DIVISION SIGN
    $05D0: Result:= #$80;  // HEBREW LETTER ALEF
    $05D1: Result:= #$81;  // HEBREW LETTER BET
    $05D2: Result:= #$82;  // HEBREW LETTER GIMEL
    $05D3: Result:= #$83;  // HEBREW LETTER DALET
    $05D4: Result:= #$84;  // HEBREW LETTER HE
    $05D5: Result:= #$85;  // HEBREW LETTER VAV
    $05D6: Result:= #$86;  // HEBREW LETTER ZAYIN
    $05D7: Result:= #$87;  // HEBREW LETTER HET
    $05D8: Result:= #$88;  // HEBREW LETTER TET
    $05D9: Result:= #$89;  // HEBREW LETTER YOD
    $05DA: Result:= #$8A;  // HEBREW LETTER FINAL KAF
    $05DB: Result:= #$8B;  // HEBREW LETTER KAF
    $05DC: Result:= #$8C;  // HEBREW LETTER LAMED
    $05DD: Result:= #$8D;  // HEBREW LETTER FINAL MEM
    $05DE: Result:= #$8E;  // HEBREW LETTER MEM
    $05DF: Result:= #$8F;  // HEBREW LETTER FINAL NUN
    $05E0: Result:= #$90;  // HEBREW LETTER NUN
    $05E1: Result:= #$91;  // HEBREW LETTER SAMEKH
    $05E2: Result:= #$92;  // HEBREW LETTER AYIN
    $05E3: Result:= #$93;  // HEBREW LETTER FINAL PE
    $05E4: Result:= #$94;  // HEBREW LETTER PE
    $05E5: Result:= #$95;  // HEBREW LETTER FINAL TSADI
    $05E6: Result:= #$96;  // HEBREW LETTER TSADI
    $05E7: Result:= #$97;  // HEBREW LETTER QOF
    $05E8: Result:= #$98;  // HEBREW LETTER RESH
    $05E9: Result:= #$99;  // HEBREW LETTER SHIN
    $05EA: Result:= #$9A;  // HEBREW LETTER TAV
    $2017: Result:= #$F2;  // DOUBLE LOW LINE
    $2500: Result:= #$C4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$B3;  // BOX DRAWINGS LIGHT VERTICAL
    $250C: Result:= #$DA;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$BF;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$C0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$D9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251C: Result:= #$C3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$B4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252C: Result:= #$C2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$C1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253C: Result:= #$C5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$CD;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$BA;  // BOX DRAWINGS DOUBLE VERTICAL
    $2554: Result:= #$C9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2557: Result:= #$BB;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $255A: Result:= #$C8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255D: Result:= #$BC;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $2560: Result:= #$CC;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2563: Result:= #$B9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2566: Result:= #$CB;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2569: Result:= #$CA;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256C: Result:= #$CE;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$DF;  // UPPER HALF BLOCK
    $2584: Result:= #$DC;  // LOWER HALF BLOCK
    $2588: Result:= #$DB;  // FULL BLOCK
    $2591: Result:= #$B0;  // LIGHT SHADE
    $2592: Result:= #$B1;  // MEDIUM SHADE
    $2593: Result:= #$B2;  // DARK SHADE
    $25A0: Result:= #$FE;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp856_Hebrew_PC sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp857Char(const I: longint): char;
begin
  case I of
    $0000..$0019,$001b,$001d..$007e,$00ec:
      Result:= Char(I);
    $001a: Result:= #$7f;
    $001c: Result:= #$1a;
    $007f: Result:= #$1c;
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a1: Result:= #$ad;  // INVERTED EXCLAMATION MARK
    $00a2: Result:= #$bd;  // CENT SIGN
    $00a3: Result:= #$9c;  // POUND SIGN
    $00a4: Result:= #$cf;  // CURRENCY SIGN
    $00a5: Result:= #$be;  // YEN SIGN
    $00a6: Result:= #$dd;  // BROKEN BAR
    $00a7: Result:= #$f5;  // SECTION SIGN
    $00a8: Result:= #$f9;  // DIAERESIS
    $00a9: Result:= #$b8;  // COPYRIGHT SIGN
    $00aa: Result:= #$d1;  // FEMININE ORDINAL INDICATOR
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00ad: Result:= #$f0;  // SOFT HYPHEN
    $00ae: Result:= #$a9;  // REGISTERED SIGN
    $00af: Result:= #$ee;  // MACRON
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b3: Result:= #$fc;  // SUPERSCRIPT THREE
    $00b4: Result:= #$ef;  // ACUTE ACCENT
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b6: Result:= #$f4;  // PILCROW SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00b8: Result:= #$f7;  // CEDILLA
    $00b9: Result:= #$fb;  // SUPERSCRIPT ONE
    $00ba: Result:= #$d0;  // MASCULINE ORDINAL INDICATOR
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00be: Result:= #$f3;  // VULGAR FRACTION THREE QUARTERS
    $00bf: Result:= #$a8;  // INVERTED QUESTION MARK
    $00c0: Result:= #$b7;  // LATIN CAPITAL LETTER A WITH GRAVE
    $00c1: Result:= #$b5;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00c2: Result:= #$b6;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00c3: Result:= #$c7;  // LATIN CAPITAL LETTER A WITH TILDE
    $00c4: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00c5: Result:= #$8f;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00c6: Result:= #$92;  // LATIN CAPITAL LIGATURE AE
    $00c7: Result:= #$80;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00c8: Result:= #$d4;  // LATIN CAPITAL LETTER E WITH GRAVE
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00ca: Result:= #$d2;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $00cb: Result:= #$d3;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $00cc: Result:= #$de;  // LATIN CAPITAL LETTER I WITH GRAVE
    $00cd: Result:= #$d6;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00ce: Result:= #$d7;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $00cf: Result:= #$d8;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $00d1: Result:= #$a5;  // LATIN CAPITAL LETTER N WITH TILDE
    $00d2: Result:= #$e3;  // LATIN CAPITAL LETTER O WITH GRAVE
    $00d3: Result:= #$e0;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00d4: Result:= #$e2;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00d5: Result:= #$e5;  // LATIN CAPITAL LETTER O WITH TILDE
    $00d6: Result:= #$99;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00d7: Result:= #$e8;  // MULTIPLICATION SIGN
    $00d8: Result:= #$9d;  // LATIN CAPITAL LETTER O WITH STROKE
    $00d9: Result:= #$eb;  // LATIN CAPITAL LETTER U WITH GRAVE
    $00da: Result:= #$e9;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00db: Result:= #$ea;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S
    $00e0: Result:= #$85;  // LATIN SMALL LETTER A WITH GRAVE
    $00e1: Result:= #$a0;  // LATIN SMALL LETTER A WITH ACUTE
    $00e2: Result:= #$83;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e3: Result:= #$c6;  // LATIN SMALL LETTER A WITH TILDE
    $00e4: Result:= #$84;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00e5: Result:= #$86;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00e6: Result:= #$91;  // LATIN SMALL LIGATURE AE
    $00e7: Result:= #$87;  // LATIN SMALL LETTER C WITH CEDILLA
    $00e8: Result:= #$8a;  // LATIN SMALL LETTER E WITH GRAVE
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00ea: Result:= #$88;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00eb: Result:= #$89;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00ed: Result:= #$a1;  // LATIN SMALL LETTER I WITH ACUTE
    $00ee: Result:= #$8c;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00ef: Result:= #$8b;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00f1: Result:= #$a4;  // LATIN SMALL LETTER N WITH TILDE
    $00f2: Result:= #$95;  // LATIN SMALL LETTER O WITH GRAVE
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$93;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f5: Result:= #$e4;  // LATIN SMALL LETTER O WITH TILDE
    $00f6: Result:= #$94;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00f8: Result:= #$9b;  // LATIN SMALL LETTER O WITH STROKE
    $00f9: Result:= #$97;  // LATIN SMALL LETTER U WITH GRAVE
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $00fb: Result:= #$96;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00ff: Result:= #$ed;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $011e: Result:= #$a6;  // LATIN CAPITAL LETTER G WITH BREVE
    $011f: Result:= #$a7;  // LATIN SMALL LETTER G WITH BREVE
    $0130: Result:= #$98;  // LATIN CAPITAL LETTER I WITH DOT ABOVE
    $0131: Result:= #$8d;  // LATIN SMALL LETTER DOTLESS I
    $015e: Result:= #$9e;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $015f: Result:= #$9f;  // LATIN SMALL LETTER S WITH CEDILLA
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp857 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp857_DOSTurkishChar(const I: longint): char;
begin
  case I of
    $0000..$007f,$00ec: Result:= Char(I);
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a1: Result:= #$ad;  // INVERTED EXCLAMATION MARK
    $00a2: Result:= #$bd;  // CENT SIGN
    $00a3: Result:= #$9c;  // POUND SIGN
    $00a4: Result:= #$cf;  // CURRENCY SIGN
    $00a5: Result:= #$be;  // YEN SIGN
    $00a6: Result:= #$dd;  // BROKEN BAR
    $00a7: Result:= #$f5;  // SECTION SIGN
    $00a8: Result:= #$f9;  // DIAERESIS
    $00a9: Result:= #$b8;  // COPYRIGHT SIGN
    $00aa: Result:= #$d1;  // FEMININE ORDINAL INDICATOR
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00ad: Result:= #$f0;  // SOFT HYPHEN
    $00ae: Result:= #$a9;  // REGISTERED SIGN
    $00af: Result:= #$ee;  // MACRON
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b3: Result:= #$fc;  // SUPERSCRIPT THREE
    $00b4: Result:= #$ef;  // ACUTE ACCENT
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b6: Result:= #$f4;  // PILCROW SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00b8: Result:= #$f7;  // CEDILLA
    $00b9: Result:= #$fb;  // SUPERSCRIPT ONE
    $00ba: Result:= #$d0;  // MASCULINE ORDINAL INDICATOR
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00be: Result:= #$f3;  // VULGAR FRACTION THREE QUARTERS
    $00bf: Result:= #$a8;  // INVERTED QUESTION MARK
    $00c0: Result:= #$b7;  // LATIN CAPITAL LETTER A WITH GRAVE
    $00c1: Result:= #$b5;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00c2: Result:= #$b6;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00c3: Result:= #$c7;  // LATIN CAPITAL LETTER A WITH TILDE
    $00c4: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00c5: Result:= #$8f;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00c6: Result:= #$92;  // LATIN CAPITAL LIGATURE AE
    $00c7: Result:= #$80;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00c8: Result:= #$d4;  // LATIN CAPITAL LETTER E WITH GRAVE
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00ca: Result:= #$d2;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $00cb: Result:= #$d3;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $00cc: Result:= #$de;  // LATIN CAPITAL LETTER I WITH GRAVE
    $00cd: Result:= #$d6;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00ce: Result:= #$d7;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $00cf: Result:= #$d8;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $00d1: Result:= #$a5;  // LATIN CAPITAL LETTER N WITH TILDE
    $00d2: Result:= #$e3;  // LATIN CAPITAL LETTER O WITH GRAVE
    $00d3: Result:= #$e0;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00d4: Result:= #$e2;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00d5: Result:= #$e5;  // LATIN CAPITAL LETTER O WITH TILDE
    $00d6: Result:= #$99;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00d7: Result:= #$e8;  // MULTIPLICATION SIGN
    $00d8: Result:= #$9d;  // LATIN CAPITAL LETTER O WITH STROKE
    $00d9: Result:= #$eb;  // LATIN CAPITAL LETTER U WITH GRAVE
    $00da: Result:= #$e9;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00db: Result:= #$ea;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S
    $00e0: Result:= #$85;  // LATIN SMALL LETTER A WITH GRAVE
    $00e1: Result:= #$a0;  // LATIN SMALL LETTER A WITH ACUTE
    $00e2: Result:= #$83;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e3: Result:= #$c6;  // LATIN SMALL LETTER A WITH TILDE
    $00e4: Result:= #$84;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00e5: Result:= #$86;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00e6: Result:= #$91;  // LATIN SMALL LIGATURE AE
    $00e7: Result:= #$87;  // LATIN SMALL LETTER C WITH CEDILLA
    $00e8: Result:= #$8a;  // LATIN SMALL LETTER E WITH GRAVE
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00ea: Result:= #$88;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00eb: Result:= #$89;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00ed: Result:= #$a1;  // LATIN SMALL LETTER I WITH ACUTE
    $00ee: Result:= #$8c;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00ef: Result:= #$8b;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00f1: Result:= #$a4;  // LATIN SMALL LETTER N WITH TILDE
    $00f2: Result:= #$95;  // LATIN SMALL LETTER O WITH GRAVE
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$93;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f5: Result:= #$e4;  // LATIN SMALL LETTER O WITH TILDE
    $00f6: Result:= #$94;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00f8: Result:= #$9b;  // LATIN SMALL LETTER O WITH STROKE
    $00f9: Result:= #$97;  // LATIN SMALL LETTER U WITH GRAVE
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $00fb: Result:= #$96;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00ff: Result:= #$ed;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $011e: Result:= #$a6;  // LATIN CAPITAL LETTER G WITH BREVE
    $011f: Result:= #$a7;  // LATIN SMALL LETTER G WITH BREVE
    $0130: Result:= #$98;  // LATIN CAPITAL LETTER I WITH DOT ABOVE
    $0131: Result:= #$8d;  // LATIN SMALL LETTER DOTLESS I
    $015e: Result:= #$9e;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $015f: Result:= #$9f;  // LATIN SMALL LETTER S WITH CEDILLA
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp857_DOSTurkish sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp860Char(const I: longint): char;
begin
  case I of
    $0000..$0019,$001b,$001d..$007e:
      Result:= Char(I);
    $001a: Result:= #$7f;
    $001c: Result:= #$1a;
    $007f: Result:= #$1c;
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a1: Result:= #$ad;  // INVERTED EXCLAMATION MARK
    $00a2: Result:= #$9b;  // CENT SIGN
    $00a3: Result:= #$9c;  // POUND SIGN
    $00aa: Result:= #$a6;  // FEMININE ORDINAL INDICATOR
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00ba: Result:= #$a7;  // MASCULINE ORDINAL INDICATOR
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00bf: Result:= #$a8;  // INVERTED QUESTION MARK
    $00c0: Result:= #$91;  // LATIN CAPITAL LETTER A WITH GRAVE
    $00c1: Result:= #$86;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00c2: Result:= #$8f;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00c3: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH TILDE
    $00c7: Result:= #$80;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00c8: Result:= #$92;  // LATIN CAPITAL LETTER E WITH GRAVE
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00ca: Result:= #$89;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $00cc: Result:= #$98;  // LATIN CAPITAL LETTER I WITH GRAVE
    $00cd: Result:= #$8b;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00d1: Result:= #$a5;  // LATIN CAPITAL LETTER N WITH TILDE
    $00d2: Result:= #$a9;  // LATIN CAPITAL LETTER O WITH GRAVE
    $00d3: Result:= #$9f;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00d4: Result:= #$8c;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00d5: Result:= #$99;  // LATIN CAPITAL LETTER O WITH TILDE
    $00d9: Result:= #$9d;  // LATIN CAPITAL LETTER U WITH GRAVE
    $00da: Result:= #$96;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S
    $00e0: Result:= #$85;  // LATIN SMALL LETTER A WITH GRAVE
    $00e1: Result:= #$a0;  // LATIN SMALL LETTER A WITH ACUTE
    $00e2: Result:= #$83;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e3: Result:= #$84;  // LATIN SMALL LETTER A WITH TILDE
    $00e7: Result:= #$87;  // LATIN SMALL LETTER C WITH CEDILLA
    $00e8: Result:= #$8a;  // LATIN SMALL LETTER E WITH GRAVE
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00ea: Result:= #$88;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00ec: Result:= #$8d;  // LATIN SMALL LETTER I WITH GRAVE
    $00ed: Result:= #$a1;  // LATIN SMALL LETTER I WITH ACUTE
    $00f1: Result:= #$a4;  // LATIN SMALL LETTER N WITH TILDE
    $00f2: Result:= #$95;  // LATIN SMALL LETTER O WITH GRAVE
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$93;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f5: Result:= #$94;  // LATIN SMALL LETTER O WITH TILDE
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00f9: Result:= #$97;  // LATIN SMALL LETTER U WITH GRAVE
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $0393: Result:= #$e2;  // GREEK CAPITAL LETTER GAMMA
    $0398: Result:= #$e9;  // GREEK CAPITAL LETTER THETA
    $03a3: Result:= #$e4;  // GREEK CAPITAL LETTER SIGMA
    $03a6: Result:= #$e8;  // GREEK CAPITAL LETTER PHI
    $03a9: Result:= #$ea;  // GREEK CAPITAL LETTER OMEGA
    $03b1: Result:= #$e0;  // GREEK SMALL LETTER ALPHA
    $03b4: Result:= #$eb;  // GREEK SMALL LETTER DELTA
    $03b5: Result:= #$ee;  // GREEK SMALL LETTER EPSILON
    $03c0: Result:= #$e3;  // GREEK SMALL LETTER PI
    $03c3: Result:= #$e5;  // GREEK SMALL LETTER SIGMA
    $03c4: Result:= #$e7;  // GREEK SMALL LETTER TAU
    $03c6: Result:= #$ed;  // GREEK SMALL LETTER PHI
    $207f: Result:= #$fc;  // SUPERSCRIPT LATIN SMALL LETTER N
    $20a7: Result:= #$9e;  // PESETA SIGN
    $2219: Result:= #$f9;  // BULLET OPERATOR
    $221a: Result:= #$fb;  // SQUARE ROOT
    $221e: Result:= #$ec;  // INFINITY
    $2229: Result:= #$ef;  // INTERSECTION
    $2248: Result:= #$f7;  // ALMOST EQUAL TO
    $2261: Result:= #$f0;  // IDENTICAL TO
    $2264: Result:= #$f3;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$f2;  // GREATER-THAN OR EQUAL TO
    $2320: Result:= #$f4;  // TOP HALF INTEGRAL
    $2321: Result:= #$f5;  // BOTTOM HALF INTEGRAL
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: Result:= #$d5;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $2553: Result:= #$d6;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: Result:= #$b8;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: Result:= #$b7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: Result:= #$d4;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: Result:= #$d3;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255b: Result:= #$be;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255c: Result:= #$bd;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255e: Result:= #$c6;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255f: Result:= #$c7;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: Result:= #$b5;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $2562: Result:= #$b6;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: Result:= #$d1;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: Result:= #$d2;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: Result:= #$cf;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: Result:= #$d0;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256a: Result:= #$d8;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256b: Result:= #$d7;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $258c: Result:= #$dd;  // LEFT HALF BLOCK
    $2590: Result:= #$de;  // RIGHT HALF BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp860 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp860_DOSPortugueseChar(const I: longint): char;
begin
  case I of
    $0000..$007f: Result:= Char(I);
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a1: Result:= #$ad;  // INVERTED EXCLAMATION MARK
    $00a2: Result:= #$9b;  // CENT SIGN
    $00a3: Result:= #$9c;  // POUND SIGN
    $00aa: Result:= #$a6;  // FEMININE ORDINAL INDICATOR
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00ba: Result:= #$a7;  // MASCULINE ORDINAL INDICATOR
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00bf: Result:= #$a8;  // INVERTED QUESTION MARK
    $00c0: Result:= #$91;  // LATIN CAPITAL LETTER A WITH GRAVE
    $00c1: Result:= #$86;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00c2: Result:= #$8f;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00c3: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH TILDE
    $00c7: Result:= #$80;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00c8: Result:= #$92;  // LATIN CAPITAL LETTER E WITH GRAVE
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00ca: Result:= #$89;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $00cc: Result:= #$98;  // LATIN CAPITAL LETTER I WITH GRAVE
    $00cd: Result:= #$8b;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00d1: Result:= #$a5;  // LATIN CAPITAL LETTER N WITH TILDE
    $00d2: Result:= #$a9;  // LATIN CAPITAL LETTER O WITH GRAVE
    $00d3: Result:= #$9f;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00d4: Result:= #$8c;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00d5: Result:= #$99;  // LATIN CAPITAL LETTER O WITH TILDE
    $00d9: Result:= #$9d;  // LATIN CAPITAL LETTER U WITH GRAVE
    $00da: Result:= #$96;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S
    $00e0: Result:= #$85;  // LATIN SMALL LETTER A WITH GRAVE
    $00e1: Result:= #$a0;  // LATIN SMALL LETTER A WITH ACUTE
    $00e2: Result:= #$83;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e3: Result:= #$84;  // LATIN SMALL LETTER A WITH TILDE
    $00e7: Result:= #$87;  // LATIN SMALL LETTER C WITH CEDILLA
    $00e8: Result:= #$8a;  // LATIN SMALL LETTER E WITH GRAVE
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00ea: Result:= #$88;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00ec: Result:= #$8d;  // LATIN SMALL LETTER I WITH GRAVE
    $00ed: Result:= #$a1;  // LATIN SMALL LETTER I WITH ACUTE
    $00f1: Result:= #$a4;  // LATIN SMALL LETTER N WITH TILDE
    $00f2: Result:= #$95;  // LATIN SMALL LETTER O WITH GRAVE
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$93;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f5: Result:= #$94;  // LATIN SMALL LETTER O WITH TILDE
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00f9: Result:= #$97;  // LATIN SMALL LETTER U WITH GRAVE
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $0393: Result:= #$e2;  // GREEK CAPITAL LETTER GAMMA
    $0398: Result:= #$e9;  // GREEK CAPITAL LETTER THETA
    $03a3: Result:= #$e4;  // GREEK CAPITAL LETTER SIGMA
    $03a6: Result:= #$e8;  // GREEK CAPITAL LETTER PHI
    $03a9: Result:= #$ea;  // GREEK CAPITAL LETTER OMEGA
    $03b1: Result:= #$e0;  // GREEK SMALL LETTER ALPHA
    $03b4: Result:= #$eb;  // GREEK SMALL LETTER DELTA
    $03b5: Result:= #$ee;  // GREEK SMALL LETTER EPSILON
    $03c0: Result:= #$e3;  // GREEK SMALL LETTER PI
    $03c3: Result:= #$e5;  // GREEK SMALL LETTER SIGMA
    $03c4: Result:= #$e7;  // GREEK SMALL LETTER TAU
    $03c6: Result:= #$ed;  // GREEK SMALL LETTER PHI
    $207f: Result:= #$fc;  // SUPERSCRIPT LATIN SMALL LETTER N
    $20a7: Result:= #$9e;  // PESETA SIGN
    $2219: Result:= #$f9;  // BULLET OPERATOR
    $221a: Result:= #$fb;  // SQUARE ROOT
    $221e: Result:= #$ec;  // INFINITY
    $2229: Result:= #$ef;  // INTERSECTION
    $2248: Result:= #$f7;  // ALMOST EQUAL TO
    $2261: Result:= #$f0;  // IDENTICAL TO
    $2264: Result:= #$f3;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$f2;  // GREATER-THAN OR EQUAL TO
    $2320: Result:= #$f4;  // TOP HALF INTEGRAL
    $2321: Result:= #$f5;  // BOTTOM HALF INTEGRAL
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: Result:= #$d5;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $2553: Result:= #$d6;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: Result:= #$b8;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: Result:= #$b7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: Result:= #$d4;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: Result:= #$d3;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255b: Result:= #$be;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255c: Result:= #$bd;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255e: Result:= #$c6;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255f: Result:= #$c7;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: Result:= #$b5;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $2562: Result:= #$b6;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: Result:= #$d1;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: Result:= #$d2;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: Result:= #$cf;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: Result:= #$d0;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256a: Result:= #$d8;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256b: Result:= #$d7;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $258c: Result:= #$dd;  // LEFT HALF BLOCK
    $2590: Result:= #$de;  // RIGHT HALF BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp860_DOSPortuguese sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp861Char(const I: longint): char;
begin
  case I of
    $0000..$0019,$001b,$001d..$007e:
      Result:= Char(I);
    $001a: Result:= #$7f;
    $001c: Result:= #$1a;
    $007f: Result:= #$1c;
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a1: Result:= #$ad;  // INVERTED EXCLAMATION MARK
    $00a3: Result:= #$9c;  // POUND SIGN
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00bf: Result:= #$a8;  // INVERTED QUESTION MARK
    $00c1: Result:= #$a4;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00c4: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00c5: Result:= #$8f;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00c6: Result:= #$92;  // LATIN CAPITAL LIGATURE AE
    $00c7: Result:= #$80;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00cd: Result:= #$a5;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00d0: Result:= #$8b;  // LATIN CAPITAL LETTER ETH
    $00d3: Result:= #$a6;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00d6: Result:= #$99;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00d8: Result:= #$9d;  // LATIN CAPITAL LETTER O WITH STROKE
    $00da: Result:= #$a7;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00dd: Result:= #$97;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $00de: Result:= #$8d;  // LATIN CAPITAL LETTER THORN
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S
    $00e0: Result:= #$85;  // LATIN SMALL LETTER A WITH GRAVE
    $00e1: Result:= #$a0;  // LATIN SMALL LETTER A WITH ACUTE
    $00e2: Result:= #$83;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e4: Result:= #$84;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00e5: Result:= #$86;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00e6: Result:= #$91;  // LATIN SMALL LIGATURE AE
    $00e7: Result:= #$87;  // LATIN SMALL LETTER C WITH CEDILLA
    $00e8: Result:= #$8a;  // LATIN SMALL LETTER E WITH GRAVE
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00ea: Result:= #$88;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00eb: Result:= #$89;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00ed: Result:= #$a1;  // LATIN SMALL LETTER I WITH ACUTE
    $00f0: Result:= #$8c;  // LATIN SMALL LETTER ETH
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$93;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f6: Result:= #$94;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00f8: Result:= #$9b;  // LATIN SMALL LETTER O WITH STROKE
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $00fb: Result:= #$96;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00fd: Result:= #$98;  // LATIN SMALL LETTER Y WITH ACUTE
    $00fe: Result:= #$95;  // LATIN SMALL LETTER THORN
    $0192: Result:= #$9f;  // LATIN SMALL LETTER F WITH HOOK
    $0393: Result:= #$e2;  // GREEK CAPITAL LETTER GAMMA
    $0398: Result:= #$e9;  // GREEK CAPITAL LETTER THETA
    $03a3: Result:= #$e4;  // GREEK CAPITAL LETTER SIGMA
    $03a6: Result:= #$e8;  // GREEK CAPITAL LETTER PHI
    $03a9: Result:= #$ea;  // GREEK CAPITAL LETTER OMEGA
    $03b1: Result:= #$e0;  // GREEK SMALL LETTER ALPHA
    $03b4: Result:= #$eb;  // GREEK SMALL LETTER DELTA
    $03b5: Result:= #$ee;  // GREEK SMALL LETTER EPSILON
    $03c0: Result:= #$e3;  // GREEK SMALL LETTER PI
    $03c3: Result:= #$e5;  // GREEK SMALL LETTER SIGMA
    $03c4: Result:= #$e7;  // GREEK SMALL LETTER TAU
    $03c6: Result:= #$ed;  // GREEK SMALL LETTER PHI
    $207f: Result:= #$fc;  // SUPERSCRIPT LATIN SMALL LETTER N
    $20a7: Result:= #$9e;  // PESETA SIGN
    $2219: Result:= #$f9;  // BULLET OPERATOR
    $221a: Result:= #$fb;  // SQUARE ROOT
    $221e: Result:= #$ec;  // INFINITY
    $2229: Result:= #$ef;  // INTERSECTION
    $2248: Result:= #$f7;  // ALMOST EQUAL TO
    $2261: Result:= #$f0;  // IDENTICAL TO
    $2264: Result:= #$f3;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$f2;  // GREATER-THAN OR EQUAL TO
    $2310: Result:= #$a9;  // REVERSED NOT SIGN
    $2320: Result:= #$f4;  // TOP HALF INTEGRAL
    $2321: Result:= #$f5;  // BOTTOM HALF INTEGRAL
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: Result:= #$d5;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $2553: Result:= #$d6;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: Result:= #$b8;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: Result:= #$b7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: Result:= #$d4;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: Result:= #$d3;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255b: Result:= #$be;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255c: Result:= #$bd;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255e: Result:= #$c6;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255f: Result:= #$c7;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: Result:= #$b5;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $2562: Result:= #$b6;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: Result:= #$d1;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: Result:= #$d2;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: Result:= #$cf;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: Result:= #$d0;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256a: Result:= #$d8;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256b: Result:= #$d7;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $258c: Result:= #$dd;  // LEFT HALF BLOCK
    $2590: Result:= #$de;  // RIGHT HALF BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp861 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp861_DOSIcelandicChar(const I: longint): char;
begin
  case I of
    $0000..$007f: Result:= Char(I);
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a1: Result:= #$ad;  // INVERTED EXCLAMATION MARK
    $00a3: Result:= #$9c;  // POUND SIGN
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00bf: Result:= #$a8;  // INVERTED QUESTION MARK
    $00c1: Result:= #$a4;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00c4: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00c5: Result:= #$8f;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00c6: Result:= #$92;  // LATIN CAPITAL LIGATURE AE
    $00c7: Result:= #$80;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00cd: Result:= #$a5;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00d0: Result:= #$8b;  // LATIN CAPITAL LETTER ETH
    $00d3: Result:= #$a6;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00d6: Result:= #$99;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00d8: Result:= #$9d;  // LATIN CAPITAL LETTER O WITH STROKE
    $00da: Result:= #$a7;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00dd: Result:= #$97;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $00de: Result:= #$8d;  // LATIN CAPITAL LETTER THORN
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S
    $00e0: Result:= #$85;  // LATIN SMALL LETTER A WITH GRAVE
    $00e1: Result:= #$a0;  // LATIN SMALL LETTER A WITH ACUTE
    $00e2: Result:= #$83;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e4: Result:= #$84;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00e5: Result:= #$86;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00e6: Result:= #$91;  // LATIN SMALL LIGATURE AE
    $00e7: Result:= #$87;  // LATIN SMALL LETTER C WITH CEDILLA
    $00e8: Result:= #$8a;  // LATIN SMALL LETTER E WITH GRAVE
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00ea: Result:= #$88;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00eb: Result:= #$89;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00ed: Result:= #$a1;  // LATIN SMALL LETTER I WITH ACUTE
    $00f0: Result:= #$8c;  // LATIN SMALL LETTER ETH
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$93;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f6: Result:= #$94;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00f8: Result:= #$9b;  // LATIN SMALL LETTER O WITH STROKE
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $00fb: Result:= #$96;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00fd: Result:= #$98;  // LATIN SMALL LETTER Y WITH ACUTE
    $00fe: Result:= #$95;  // LATIN SMALL LETTER THORN
    $0192: Result:= #$9f;  // LATIN SMALL LETTER F WITH HOOK
    $0393: Result:= #$e2;  // GREEK CAPITAL LETTER GAMMA
    $0398: Result:= #$e9;  // GREEK CAPITAL LETTER THETA
    $03a3: Result:= #$e4;  // GREEK CAPITAL LETTER SIGMA
    $03a6: Result:= #$e8;  // GREEK CAPITAL LETTER PHI
    $03a9: Result:= #$ea;  // GREEK CAPITAL LETTER OMEGA
    $03b1: Result:= #$e0;  // GREEK SMALL LETTER ALPHA
    $03b4: Result:= #$eb;  // GREEK SMALL LETTER DELTA
    $03b5: Result:= #$ee;  // GREEK SMALL LETTER EPSILON
    $03c0: Result:= #$e3;  // GREEK SMALL LETTER PI
    $03c3: Result:= #$e5;  // GREEK SMALL LETTER SIGMA
    $03c4: Result:= #$e7;  // GREEK SMALL LETTER TAU
    $03c6: Result:= #$ed;  // GREEK SMALL LETTER PHI
    $207f: Result:= #$fc;  // SUPERSCRIPT LATIN SMALL LETTER N
    $20a7: Result:= #$9e;  // PESETA SIGN
    $2219: Result:= #$f9;  // BULLET OPERATOR
    $221a: Result:= #$fb;  // SQUARE ROOT
    $221e: Result:= #$ec;  // INFINITY
    $2229: Result:= #$ef;  // INTERSECTION
    $2248: Result:= #$f7;  // ALMOST EQUAL TO
    $2261: Result:= #$f0;  // IDENTICAL TO
    $2264: Result:= #$f3;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$f2;  // GREATER-THAN OR EQUAL TO
    $2310: Result:= #$a9;  // REVERSED NOT SIGN
    $2320: Result:= #$f4;  // TOP HALF INTEGRAL
    $2321: Result:= #$f5;  // BOTTOM HALF INTEGRAL
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: Result:= #$d5;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $2553: Result:= #$d6;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: Result:= #$b8;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: Result:= #$b7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: Result:= #$d4;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: Result:= #$d3;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255b: Result:= #$be;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255c: Result:= #$bd;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255e: Result:= #$c6;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255f: Result:= #$c7;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: Result:= #$b5;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $2562: Result:= #$b6;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: Result:= #$d1;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: Result:= #$d2;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: Result:= #$cf;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: Result:= #$d0;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256a: Result:= #$d8;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256b: Result:= #$d7;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $258c: Result:= #$dd;  // LEFT HALF BLOCK
    $2590: Result:= #$de;  // RIGHT HALF BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp861_DOSIcelandic sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp862Char(const I: longint): char;
begin
  case I of
    $0000..$0019,$001b,$001d..$007e:
      Result:= Char(I);
    $001a: Result:= #$7f;
    $001c: Result:= #$1a;
    $007f: Result:= #$1c;
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a1: Result:= #$ad;  // INVERTED EXCLAMATION MARK
    $00a2: Result:= #$9b;  // CENT SIGN
    $00a3: Result:= #$9c;  // POUND SIGN
    $00a5: Result:= #$9d;  // YEN SIGN
    $00aa: Result:= #$a6;  // FEMININE ORDINAL INDICATOR
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00ba: Result:= #$a7;  // MASCULINE ORDINAL INDICATOR
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00bf: Result:= #$a8;  // INVERTED QUESTION MARK
    $00d1: Result:= #$a5;  // LATIN CAPITAL LETTER N WITH TILDE
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S (GERMAN)
    $00e1: Result:= #$a0;  // LATIN SMALL LETTER A WITH ACUTE
    $00ed: Result:= #$a1;  // LATIN SMALL LETTER I WITH ACUTE
    $00f1: Result:= #$a4;  // LATIN SMALL LETTER N WITH TILDE
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $0192: Result:= #$9f;  // LATIN SMALL LETTER F WITH HOOK
    $0393: Result:= #$e2;  // GREEK CAPITAL LETTER GAMMA
    $0398: Result:= #$e9;  // GREEK CAPITAL LETTER THETA
    $03a3: Result:= #$e4;  // GREEK CAPITAL LETTER SIGMA
    $03a6: Result:= #$e8;  // GREEK CAPITAL LETTER PHI
    $03a9: Result:= #$ea;  // GREEK CAPITAL LETTER OMEGA
    $03b1: Result:= #$e0;  // GREEK SMALL LETTER ALPHA
    $03b4: Result:= #$eb;  // GREEK SMALL LETTER DELTA
    $03b5: Result:= #$ee;  // GREEK SMALL LETTER EPSILON
    $03c0: Result:= #$e3;  // GREEK SMALL LETTER PI
    $03c3: Result:= #$e5;  // GREEK SMALL LETTER SIGMA
    $03c4: Result:= #$e7;  // GREEK SMALL LETTER TAU
    $03c6: Result:= #$ed;  // GREEK SMALL LETTER PHI
    $05d0: Result:= #$80;  // HEBREW LETTER ALEF
    $05d1: Result:= #$81;  // HEBREW LETTER BET
    $05d2: Result:= #$82;  // HEBREW LETTER GIMEL
    $05d3: Result:= #$83;  // HEBREW LETTER DALET
    $05d4: Result:= #$84;  // HEBREW LETTER HE
    $05d5: Result:= #$85;  // HEBREW LETTER VAV
    $05d6: Result:= #$86;  // HEBREW LETTER ZAYIN
    $05d7: Result:= #$87;  // HEBREW LETTER HET
    $05d8: Result:= #$88;  // HEBREW LETTER TET
    $05d9: Result:= #$89;  // HEBREW LETTER YOD
    $05da: Result:= #$8a;  // HEBREW LETTER FINAL KAF
    $05db: Result:= #$8b;  // HEBREW LETTER KAF
    $05dc: Result:= #$8c;  // HEBREW LETTER LAMED
    $05dd: Result:= #$8d;  // HEBREW LETTER FINAL MEM
    $05de: Result:= #$8e;  // HEBREW LETTER MEM
    $05df: Result:= #$8f;  // HEBREW LETTER FINAL NUN
    $05e0: Result:= #$90;  // HEBREW LETTER NUN
    $05e1: Result:= #$91;  // HEBREW LETTER SAMEKH
    $05e2: Result:= #$92;  // HEBREW LETTER AYIN
    $05e3: Result:= #$93;  // HEBREW LETTER FINAL PE
    $05e4: Result:= #$94;  // HEBREW LETTER PE
    $05e5: Result:= #$95;  // HEBREW LETTER FINAL TSADI
    $05e6: Result:= #$96;  // HEBREW LETTER TSADI
    $05e7: Result:= #$97;  // HEBREW LETTER QOF
    $05e8: Result:= #$98;  // HEBREW LETTER RESH
    $05e9: Result:= #$99;  // HEBREW LETTER SHIN
    $05ea: Result:= #$9a;  // HEBREW LETTER TAV
    $207f: Result:= #$fc;  // SUPERSCRIPT LATIN SMALL LETTER N
    $20a7: Result:= #$9e;  // PESETA SIGN
    $2219: Result:= #$f9;  // BULLET OPERATOR
    $221a: Result:= #$fb;  // SQUARE ROOT
    $221e: Result:= #$ec;  // INFINITY
    $2229: Result:= #$ef;  // INTERSECTION
    $2248: Result:= #$f7;  // ALMOST EQUAL TO
    $2261: Result:= #$f0;  // IDENTICAL TO
    $2264: Result:= #$f3;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$f2;  // GREATER-THAN OR EQUAL TO
    $2310: Result:= #$a9;  // REVERSED NOT SIGN
    $2320: Result:= #$f4;  // TOP HALF INTEGRAL
    $2321: Result:= #$f5;  // BOTTOM HALF INTEGRAL
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: Result:= #$d5;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $2553: Result:= #$d6;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: Result:= #$b8;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: Result:= #$b7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: Result:= #$d4;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: Result:= #$d3;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255b: Result:= #$be;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255c: Result:= #$bd;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255e: Result:= #$c6;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255f: Result:= #$c7;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: Result:= #$b5;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $2562: Result:= #$b6;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: Result:= #$d1;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: Result:= #$d2;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: Result:= #$cf;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: Result:= #$d0;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256a: Result:= #$d8;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256b: Result:= #$d7;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $258c: Result:= #$dd;  // LEFT HALF BLOCK
    $2590: Result:= #$de;  // RIGHT HALF BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp862 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp862_DOSHebrewChar(const I: longint): char;
begin
  case I of
    $0000..$007f: Result:= Char(I);
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a1: Result:= #$ad;  // INVERTED EXCLAMATION MARK
    $00a2: Result:= #$9b;  // CENT SIGN
    $00a3: Result:= #$9c;  // POUND SIGN
    $00a5: Result:= #$9d;  // YEN SIGN
    $00aa: Result:= #$a6;  // FEMININE ORDINAL INDICATOR
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00ba: Result:= #$a7;  // MASCULINE ORDINAL INDICATOR
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00bf: Result:= #$a8;  // INVERTED QUESTION MARK
    $00d1: Result:= #$a5;  // LATIN CAPITAL LETTER N WITH TILDE
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S (GERMAN)
    $00e1: Result:= #$a0;  // LATIN SMALL LETTER A WITH ACUTE
    $00ed: Result:= #$a1;  // LATIN SMALL LETTER I WITH ACUTE
    $00f1: Result:= #$a4;  // LATIN SMALL LETTER N WITH TILDE
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $0192: Result:= #$9f;  // LATIN SMALL LETTER F WITH HOOK
    $0393: Result:= #$e2;  // GREEK CAPITAL LETTER GAMMA
    $0398: Result:= #$e9;  // GREEK CAPITAL LETTER THETA
    $03a3: Result:= #$e4;  // GREEK CAPITAL LETTER SIGMA
    $03a6: Result:= #$e8;  // GREEK CAPITAL LETTER PHI
    $03a9: Result:= #$ea;  // GREEK CAPITAL LETTER OMEGA
    $03b1: Result:= #$e0;  // GREEK SMALL LETTER ALPHA
    $03b4: Result:= #$eb;  // GREEK SMALL LETTER DELTA
    $03b5: Result:= #$ee;  // GREEK SMALL LETTER EPSILON
    $03c0: Result:= #$e3;  // GREEK SMALL LETTER PI
    $03c3: Result:= #$e5;  // GREEK SMALL LETTER SIGMA
    $03c4: Result:= #$e7;  // GREEK SMALL LETTER TAU
    $03c6: Result:= #$ed;  // GREEK SMALL LETTER PHI
    $05d0: Result:= #$80;  // HEBREW LETTER ALEF
    $05d1: Result:= #$81;  // HEBREW LETTER BET
    $05d2: Result:= #$82;  // HEBREW LETTER GIMEL
    $05d3: Result:= #$83;  // HEBREW LETTER DALET
    $05d4: Result:= #$84;  // HEBREW LETTER HE
    $05d5: Result:= #$85;  // HEBREW LETTER VAV
    $05d6: Result:= #$86;  // HEBREW LETTER ZAYIN
    $05d7: Result:= #$87;  // HEBREW LETTER HET
    $05d8: Result:= #$88;  // HEBREW LETTER TET
    $05d9: Result:= #$89;  // HEBREW LETTER YOD
    $05da: Result:= #$8a;  // HEBREW LETTER FINAL KAF
    $05db: Result:= #$8b;  // HEBREW LETTER KAF
    $05dc: Result:= #$8c;  // HEBREW LETTER LAMED
    $05dd: Result:= #$8d;  // HEBREW LETTER FINAL MEM
    $05de: Result:= #$8e;  // HEBREW LETTER MEM
    $05df: Result:= #$8f;  // HEBREW LETTER FINAL NUN
    $05e0: Result:= #$90;  // HEBREW LETTER NUN
    $05e1: Result:= #$91;  // HEBREW LETTER SAMEKH
    $05e2: Result:= #$92;  // HEBREW LETTER AYIN
    $05e3: Result:= #$93;  // HEBREW LETTER FINAL PE
    $05e4: Result:= #$94;  // HEBREW LETTER PE
    $05e5: Result:= #$95;  // HEBREW LETTER FINAL TSADI
    $05e6: Result:= #$96;  // HEBREW LETTER TSADI
    $05e7: Result:= #$97;  // HEBREW LETTER QOF
    $05e8: Result:= #$98;  // HEBREW LETTER RESH
    $05e9: Result:= #$99;  // HEBREW LETTER SHIN
    $05ea: Result:= #$9a;  // HEBREW LETTER TAV
    $207f: Result:= #$fc;  // SUPERSCRIPT LATIN SMALL LETTER N
    $20a7: Result:= #$9e;  // PESETA SIGN
    $2219: Result:= #$f9;  // BULLET OPERATOR
    $221a: Result:= #$fb;  // SQUARE ROOT
    $221e: Result:= #$ec;  // INFINITY
    $2229: Result:= #$ef;  // INTERSECTION
    $2248: Result:= #$f7;  // ALMOST EQUAL TO
    $2261: Result:= #$f0;  // IDENTICAL TO
    $2264: Result:= #$f3;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$f2;  // GREATER-THAN OR EQUAL TO
    $2310: Result:= #$a9;  // REVERSED NOT SIGN
    $2320: Result:= #$f4;  // TOP HALF INTEGRAL
    $2321: Result:= #$f5;  // BOTTOM HALF INTEGRAL
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: Result:= #$d5;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $2553: Result:= #$d6;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: Result:= #$b8;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: Result:= #$b7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: Result:= #$d4;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: Result:= #$d3;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255b: Result:= #$be;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255c: Result:= #$bd;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255e: Result:= #$c6;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255f: Result:= #$c7;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: Result:= #$b5;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $2562: Result:= #$b6;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: Result:= #$d1;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: Result:= #$d2;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: Result:= #$cf;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: Result:= #$d0;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256a: Result:= #$d8;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256b: Result:= #$d7;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $258c: Result:= #$dd;  // LEFT HALF BLOCK
    $2590: Result:= #$de;  // RIGHT HALF BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp862_DOSHebrew sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp863Char(const I: longint): char;
begin
  case I of
    $0000..$0019,$001b,$001d..$007e:
      Result:= Char(I);
    $001a: Result:= #$7f;
    $001c: Result:= #$1a;
    $007f: Result:= #$1c;
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a2: Result:= #$9b;  // CENT SIGN
    $00a3: Result:= #$9c;  // POUND SIGN
    $00a4: Result:= #$98;  // CURRENCY SIGN
    $00a6: Result:= #$a0;  // BROKEN BAR
    $00a7: Result:= #$8f;  // SECTION SIGN
    $00a8: Result:= #$a4;  // DIAERESIS
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00af: Result:= #$a7;  // MACRON
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b3: Result:= #$a6;  // SUPERSCRIPT THREE
    $00b4: Result:= #$a1;  // ACUTE ACCENT
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b6: Result:= #$86;  // PILCROW SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00b8: Result:= #$a5;  // CEDILLA
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00be: Result:= #$ad;  // VULGAR FRACTION THREE QUARTERS
    $00c0: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH GRAVE
    $00c2: Result:= #$84;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00c7: Result:= #$80;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00c8: Result:= #$91;  // LATIN CAPITAL LETTER E WITH GRAVE
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00ca: Result:= #$92;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $00cb: Result:= #$94;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $00ce: Result:= #$a8;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $00cf: Result:= #$95;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $00d4: Result:= #$99;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00d9: Result:= #$9d;  // LATIN CAPITAL LETTER U WITH GRAVE
    $00db: Result:= #$9e;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S
    $00e0: Result:= #$85;  // LATIN SMALL LETTER A WITH GRAVE
    $00e2: Result:= #$83;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e7: Result:= #$87;  // LATIN SMALL LETTER C WITH CEDILLA
    $00e8: Result:= #$8a;  // LATIN SMALL LETTER E WITH GRAVE
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00ea: Result:= #$88;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00eb: Result:= #$89;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00ee: Result:= #$8c;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00ef: Result:= #$8b;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$93;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00f9: Result:= #$97;  // LATIN SMALL LETTER U WITH GRAVE
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $00fb: Result:= #$96;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $0192: Result:= #$9f;  // LATIN SMALL LETTER F WITH HOOK
    $0393: Result:= #$e2;  // GREEK CAPITAL LETTER GAMMA
    $0398: Result:= #$e9;  // GREEK CAPITAL LETTER THETA
    $03a3: Result:= #$e4;  // GREEK CAPITAL LETTER SIGMA
    $03a6: Result:= #$e8;  // GREEK CAPITAL LETTER PHI
    $03a9: Result:= #$ea;  // GREEK CAPITAL LETTER OMEGA
    $03b1: Result:= #$e0;  // GREEK SMALL LETTER ALPHA
    $03b4: Result:= #$eb;  // GREEK SMALL LETTER DELTA
    $03b5: Result:= #$ee;  // GREEK SMALL LETTER EPSILON
    $03c0: Result:= #$e3;  // GREEK SMALL LETTER PI
    $03c3: Result:= #$e5;  // GREEK SMALL LETTER SIGMA
    $03c4: Result:= #$e7;  // GREEK SMALL LETTER TAU
    $03c6: Result:= #$ed;  // GREEK SMALL LETTER PHI
    $2017: Result:= #$8d;  // DOUBLE LOW LINE
    $207f: Result:= #$fc;  // SUPERSCRIPT LATIN SMALL LETTER N
    $2219: Result:= #$f9;  // BULLET OPERATOR
    $221a: Result:= #$fb;  // SQUARE ROOT
    $221e: Result:= #$ec;  // INFINITY
    $2229: Result:= #$ef;  // INTERSECTION
    $2248: Result:= #$f7;  // ALMOST EQUAL TO
    $2261: Result:= #$f0;  // IDENTICAL TO
    $2264: Result:= #$f3;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$f2;  // GREATER-THAN OR EQUAL TO
    $2310: Result:= #$a9;  // REVERSED NOT SIGN
    $2320: Result:= #$f4;  // TOP HALF INTEGRAL
    $2321: Result:= #$f5;  // BOTTOM HALF INTEGRAL
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: Result:= #$d5;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $2553: Result:= #$d6;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: Result:= #$b8;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: Result:= #$b7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: Result:= #$d4;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: Result:= #$d3;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255b: Result:= #$be;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255c: Result:= #$bd;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255e: Result:= #$c6;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255f: Result:= #$c7;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: Result:= #$b5;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $2562: Result:= #$b6;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: Result:= #$d1;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: Result:= #$d2;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: Result:= #$cf;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: Result:= #$d0;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256a: Result:= #$d8;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256b: Result:= #$d7;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $258c: Result:= #$dd;  // LEFT HALF BLOCK
    $2590: Result:= #$de;  // RIGHT HALF BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp863 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp863_DOSCanadaFChar(const I: longint): char;
begin
  case I of
    $0000..$007f: Result:= Char(I);
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a2: Result:= #$9b;  // CENT SIGN
    $00a3: Result:= #$9c;  // POUND SIGN
    $00a4: Result:= #$98;  // CURRENCY SIGN
    $00a6: Result:= #$a0;  // BROKEN BAR
    $00a7: Result:= #$8f;  // SECTION SIGN
    $00a8: Result:= #$a4;  // DIAERESIS
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00af: Result:= #$a7;  // MACRON
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b3: Result:= #$a6;  // SUPERSCRIPT THREE
    $00b4: Result:= #$a1;  // ACUTE ACCENT
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b6: Result:= #$86;  // PILCROW SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00b8: Result:= #$a5;  // CEDILLA
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00be: Result:= #$ad;  // VULGAR FRACTION THREE QUARTERS
    $00c0: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH GRAVE
    $00c2: Result:= #$84;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00c7: Result:= #$80;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00c8: Result:= #$91;  // LATIN CAPITAL LETTER E WITH GRAVE
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00ca: Result:= #$92;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $00cb: Result:= #$94;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $00ce: Result:= #$a8;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $00cf: Result:= #$95;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $00d4: Result:= #$99;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00d9: Result:= #$9d;  // LATIN CAPITAL LETTER U WITH GRAVE
    $00db: Result:= #$9e;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S
    $00e0: Result:= #$85;  // LATIN SMALL LETTER A WITH GRAVE
    $00e2: Result:= #$83;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e7: Result:= #$87;  // LATIN SMALL LETTER C WITH CEDILLA
    $00e8: Result:= #$8a;  // LATIN SMALL LETTER E WITH GRAVE
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00ea: Result:= #$88;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00eb: Result:= #$89;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00ee: Result:= #$8c;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00ef: Result:= #$8b;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$93;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00f9: Result:= #$97;  // LATIN SMALL LETTER U WITH GRAVE
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $00fb: Result:= #$96;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $0192: Result:= #$9f;  // LATIN SMALL LETTER F WITH HOOK
    $0393: Result:= #$e2;  // GREEK CAPITAL LETTER GAMMA
    $0398: Result:= #$e9;  // GREEK CAPITAL LETTER THETA
    $03a3: Result:= #$e4;  // GREEK CAPITAL LETTER SIGMA
    $03a6: Result:= #$e8;  // GREEK CAPITAL LETTER PHI
    $03a9: Result:= #$ea;  // GREEK CAPITAL LETTER OMEGA
    $03b1: Result:= #$e0;  // GREEK SMALL LETTER ALPHA
    $03b4: Result:= #$eb;  // GREEK SMALL LETTER DELTA
    $03b5: Result:= #$ee;  // GREEK SMALL LETTER EPSILON
    $03c0: Result:= #$e3;  // GREEK SMALL LETTER PI
    $03c3: Result:= #$e5;  // GREEK SMALL LETTER SIGMA
    $03c4: Result:= #$e7;  // GREEK SMALL LETTER TAU
    $03c6: Result:= #$ed;  // GREEK SMALL LETTER PHI
    $2017: Result:= #$8d;  // DOUBLE LOW LINE
    $207f: Result:= #$fc;  // SUPERSCRIPT LATIN SMALL LETTER N
    $2219: Result:= #$f9;  // BULLET OPERATOR
    $221a: Result:= #$fb;  // SQUARE ROOT
    $221e: Result:= #$ec;  // INFINITY
    $2229: Result:= #$ef;  // INTERSECTION
    $2248: Result:= #$f7;  // ALMOST EQUAL TO
    $2261: Result:= #$f0;  // IDENTICAL TO
    $2264: Result:= #$f3;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$f2;  // GREATER-THAN OR EQUAL TO
    $2310: Result:= #$a9;  // REVERSED NOT SIGN
    $2320: Result:= #$f4;  // TOP HALF INTEGRAL
    $2321: Result:= #$f5;  // BOTTOM HALF INTEGRAL
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: Result:= #$d5;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $2553: Result:= #$d6;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: Result:= #$b8;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: Result:= #$b7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: Result:= #$d4;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: Result:= #$d3;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255b: Result:= #$be;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255c: Result:= #$bd;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255e: Result:= #$c6;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255f: Result:= #$c7;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: Result:= #$b5;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $2562: Result:= #$b6;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: Result:= #$d1;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: Result:= #$d2;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: Result:= #$cf;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: Result:= #$d0;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256a: Result:= #$d8;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256b: Result:= #$d7;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $258c: Result:= #$dd;  // LEFT HALF BLOCK
    $2590: Result:= #$de;  // RIGHT HALF BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp863_DOSCanadaF sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp864Char(const I: longint): char;
begin
  case I of
    $0000..$0019,$001b,$001d..$0024,$0026..$007e,$00a0,$00a3..$00a4:
      Result:= Char(I);
    $001a: Result:= #$7f;
    $001c: Result:= #$1a;
    $007f: Result:= #$1c;
    $00a2: Result:= #$c0;  // CENT SIGN
    $00a6: Result:= #$db;  // BROKEN VERTICAL BAR
    $00ab: Result:= #$97;  // LEFT POINTING GUILLEMET
    $00ac: Result:= #$dc;  // NOT SIGN
    $00ad: Result:= #$a1;  // SOFT HYPHEN
    $00b0: Result:= #$80;  // DEGREE SIGN
    $00b1: Result:= #$93;  // PLUS-OR-MINUS SIGN
    $00b7: Result:= #$81;  // MIDDLE DOT
    $00bb: Result:= #$98;  // RIGHT POINTING GUILLEMET
    $00bc: Result:= #$95;  // FRACTION 1/4
    $00bd: Result:= #$94;  // FRACTION 1/2
    $00d7: Result:= #$de;  // MULTIPLICATION SIGN
    $00f7: Result:= #$dd;  // DIVISION SIGN
    $03b2: Result:= #$90;  // GREEK SMALL BETA
    $03c6: Result:= #$92;  // GREEK SMALL PHI
    $060c: Result:= #$ac;  // ARABIC COMMA
    $061b: Result:= #$bb;  // ARABIC SEMICOLON
    $061f: Result:= #$bf;  // ARABIC QUESTION MARK
    $0640: Result:= #$e0;  // ARABIC TATWEEL
    $0660: Result:= #$b0;  // ARABIC-INDIC DIGIT ZERO
    $0661: Result:= #$b1;  // ARABIC-INDIC DIGIT ONE
    $0662: Result:= #$b2;  // ARABIC-INDIC DIGIT TWO
    $0663: Result:= #$b3;  // ARABIC-INDIC DIGIT THREE
    $0664: Result:= #$b4;  // ARABIC-INDIC DIGIT FOUR
    $0665: Result:= #$b5;  // ARABIC-INDIC DIGIT FIVE
    $0666: Result:= #$b6;  // ARABIC-INDIC DIGIT SIX
    $0667: Result:= #$b7;  // ARABIC-INDIC DIGIT SEVEN
    $0668: Result:= #$b8;  // ARABIC-INDIC DIGIT EIGHT
    $0669: Result:= #$b9;  // ARABIC-INDIC DIGIT NINE
    $066a: Result:= #$25;  // ARABIC PERCENT SIGN
    $200c: Result:= #$9f;  // ZERO WIDTH NON-JOINER
    $2219: Result:= #$82;  // BULLET OPERATOR
    $221a: Result:= #$83;  // SQUARE ROOT
    $221e: Result:= #$91;  // INFINITY
    $2248: Result:= #$96;  // ALMOST EQUAL TO
    $2500: Result:= #$85;  // FORMS LIGHT HORIZONTAL
    $2502: Result:= #$86;  // FORMS LIGHT VERTICAL
    $250c: Result:= #$8d;  // FORMS LIGHT DOWN AND RIGHT
    $2510: Result:= #$8c;  // FORMS LIGHT DOWN AND LEFT
    $2514: Result:= #$8e;  // FORMS LIGHT UP AND RIGHT
    $2518: Result:= #$8f;  // FORMS LIGHT UP AND LEFT
    $251c: Result:= #$8a;  // FORMS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$88;  // FORMS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$89;  // FORMS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$8b;  // FORMS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$87;  // FORMS LIGHT VERTICAL AND HORIZONTAL
    $2592: Result:= #$84;  // MEDIUM SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
    $fe7c: Result:= #$f1;  // ARABIC SPACING SHADDAH
    $fe7d: Result:= #$f0;  // ARABIC SHADDA MEDIAL FORM
    $fe80: Result:= #$c1;  // ARABIC LETTER HAMZA ISOLATED FORM
    $fe81: Result:= #$c2;  // ARABIC LETTER ALEF WITH MADDA ABOVE ISOLATED FORM
    $fe82: Result:= #$a2;  // ARABIC LETTER ALEF WITH MADDA ABOVE FINAL FORM
    $fe83: Result:= #$c3;  // ARABIC LETTER ALEF WITH HAMZA ABOVE ISOLATED FORM
    $fe84: Result:= #$a5;  // ARABIC LETTER ALEF WITH HAMZA ABOVE FINAL FORM
    $fe85: Result:= #$c4;  // ARABIC LETTER WAW WITH HAMZA ABOVE ISOLATED FORM
    $fe8b: Result:= #$c6;  // ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM
    $fe8d: Result:= #$c7;  // ARABIC LETTER ALEF ISOLATED FORM
    $fe8e: Result:= #$a8;  // ARABIC LETTER ALEF FINAL FORM
    $fe8f: Result:= #$a9;  // ARABIC LETTER BEH ISOLATED FORM
    $fe91: Result:= #$c8;  // ARABIC LETTER BEH INITIAL FORM
    $fe93: Result:= #$c9;  // ARABIC LETTER TEH MARBUTA ISOLATED FORM
    $fe95: Result:= #$aa;  // ARABIC LETTER TEH ISOLATED FORM
    $fe97: Result:= #$ca;  // ARABIC LETTER TEH INITIAL FORM
    $fe99: Result:= #$ab;  // ARABIC LETTER THEH ISOLATED FORM
    $fe9b: Result:= #$cb;  // ARABIC LETTER THEH INITIAL FORM
    $fe9d: Result:= #$ad;  // ARABIC LETTER JEEM ISOLATED FORM
    $fe9f: Result:= #$cc;  // ARABIC LETTER JEEM INITIAL FORM
    $fea1: Result:= #$ae;  // ARABIC LETTER HAH ISOLATED FORM
    $fea3: Result:= #$cd;  // ARABIC LETTER HAH INITIAL FORM
    $fea5: Result:= #$af;  // ARABIC LETTER KHAH ISOLATED FORM
    $fea7: Result:= #$ce;  // ARABIC LETTER KHAH INITIAL FORM
    $fea9: Result:= #$cf;  // ARABIC LETTER DAL ISOLATED FORM
    $feab: Result:= #$d0;  // ARABIC LETTER THAL ISOLATED FORM
    $fead: Result:= #$d1;  // ARABIC LETTER REH ISOLATED FORM
    $feaf: Result:= #$d2;  // ARABIC LETTER ZAIN ISOLATED FORM
    $feb1: Result:= #$bc;  // ARABIC LETTER SEEN ISOLATED FORM
    $feb3: Result:= #$d3;  // ARABIC LETTER SEEN INITIAL FORM
    $feb5: Result:= #$bd;  // ARABIC LETTER SHEEN ISOLATED FORM
    $feb7: Result:= #$d4;  // ARABIC LETTER SHEEN INITIAL FORM
    $feb9: Result:= #$be;  // ARABIC LETTER SAD ISOLATED FORM
    $febb: Result:= #$d5;  // ARABIC LETTER SAD INITIAL FORM
    $febd: Result:= #$eb;  // ARABIC LETTER DAD ISOLATED FORM
    $febf: Result:= #$d6;  // ARABIC LETTER DAD INITIAL FORM
    $fec3: Result:= #$d7;  // ARABIC LETTER TAH MEDIAL FORM
    $fec7: Result:= #$d8;  // ARABIC LETTER ZAH MEDIAL FORM
    $fec9: Result:= #$df;  // ARABIC LETTER AIN ISOLATED FORM
    $feca: Result:= #$c5;  // ARABIC LETTER AIN FINAL FORM
    $fecb: Result:= #$d9;  // ARABIC LETTER AIN INITIAL FORM
    $fecc: Result:= #$ec;  // ARABIC LETTER AIN MEDIAL FORM
    $fecd: Result:= #$ee;  // ARABIC LETTER GHAIN ISOLATED FORM
    $fece: Result:= #$ed;  // ARABIC LETTER GHAIN FINAL FORM
    $fecf: Result:= #$da;  // ARABIC LETTER GHAIN INITIAL FORM
    $fed0: Result:= #$f7;  // ARABIC LETTER GHAIN MEDIAL FORM
    $fed1: Result:= #$ba;  // ARABIC LETTER FEH ISOLATED FORM
    $fed3: Result:= #$e1;  // ARABIC LETTER FEH INITIAL FORM
    $fed5: Result:= #$f8;  // ARABIC LETTER QAF ISOLATED FORM
    $fed7: Result:= #$e2;  // ARABIC LETTER QAF INITIAL FORM
    $fed9: Result:= #$fc;  // ARABIC LETTER KAF ISOLATED FORM
    $fedb: Result:= #$e3;  // ARABIC LETTER KAF INITIAL FORM
    $fedd: Result:= #$fb;  // ARABIC LETTER LAM ISOLATED FORM
    $fedf: Result:= #$e4;  // ARABIC LETTER LAM INITIAL FORM
    $fee1: Result:= #$ef;  // ARABIC LETTER MEEM ISOLATED FORM
    $fee3: Result:= #$e5;  // ARABIC LETTER MEEM INITIAL FORM
    $fee5: Result:= #$f2;  // ARABIC LETTER NOON ISOLATED FORM
    $fee7: Result:= #$e6;  // ARABIC LETTER NOON INITIAL FORM
    $fee9: Result:= #$f3;  // ARABIC LETTER HEH ISOLATED FORM
    $feeb: Result:= #$e7;  // ARABIC LETTER HEH INITIAL FORM
    $feec: Result:= #$f4;  // ARABIC LETTER HEH MEDIAL FORM
    $feed: Result:= #$e8;  // ARABIC LETTER WAW ISOLATED FORM
    $feef: Result:= #$e9;  // ARABIC LETTER ALEF MAKSURA ISOLATED FORM
    $fef0: Result:= #$f5;  // ARABIC LETTER ALEF MAKSURA FINAL FORM
    $fef1: Result:= #$fd;  // ARABIC LETTER YEH ISOLATED FORM
    $fef2: Result:= #$f6;  // ARABIC LETTER YEH FINAL FORM
    $fef3: Result:= #$ea;  // ARABIC LETTER YEH INITIAL FORM
    $fef5: Result:= #$f9;  // ARABIC LIGATURE LAM WITH ALEF WITH MADDA ABOVE ISOLATED FORM
    $fef6: Result:= #$fa;  // ARABIC LIGATURE LAM WITH ALEF WITH MADDA ABOVE FINAL FORM
    $fef7: Result:= #$99;  // ARABIC LIGATURE LAM WITH ALEF WITH HAMZA ABOVE ISOLATED FORM
    $fef8: Result:= #$9a;  // ARABIC LIGATURE LAM WITH ALEF WITH HAMZA ABOVE FINAL FORM
    $fefb: Result:= #$9d;  // ARABIC LIGATURE LAM WITH ALEF ISOLATED FORM
    $fefc: Result:= #$9e;  // ARABIC LIGATURE LAM WITH ALEF FINAL FORM
  else
    raise EConvertError.CreateFmt('Invalid cp864 sequence of Unicode code point %d',[I]);
  end;
end;


function UTF16ToCp864_DOSArabicChar(const I: longint): char;
begin
  case I of
    $00..$24,$26..$7f,$9b..$9c,$9f,$a0,$a3..$a4: 
      Result:= Char(I);
    $00a2: Result:= #$c0;  // CENT SIGN
    $00a6: Result:= #$db;  // BROKEN VERTICAL BAR
    $00ab: Result:= #$97;  // LEFT POINTING GUILLEMET
    $00ac: Result:= #$dc;  // NOT SIGN
    $00ad: Result:= #$a1;  // SOFT HYPHEN
    $00b0: Result:= #$80;  // DEGREE SIGN
    $00b1: Result:= #$93;  // PLUS-OR-MINUS SIGN
    $00b7: Result:= #$81;  // MIDDLE DOT
    $00bb: Result:= #$98;  // RIGHT POINTING GUILLEMET
    $00bc: Result:= #$95;  // FRACTION 1/4
    $00bd: Result:= #$94;  // FRACTION 1/2
    $00d7: Result:= #$de;  // MULTIPLICATION SIGN
    $00f7: Result:= #$dd;  // DIVISION SIGN
    $03b2: Result:= #$90;  // GREEK SMALL BETA
    $03c6: Result:= #$92;  // GREEK SMALL PHI
    $060c: Result:= #$ac;  // ARABIC COMMA
    $061b: Result:= #$bb;  // ARABIC SEMICOLON
    $061f: Result:= #$bf;  // ARABIC QUESTION MARK
    $0640: Result:= #$e0;  // ARABIC TATWEEL
    $0651: Result:= #$f1;  // ARABIC SHADDAH
    $0660: Result:= #$b0;  // ARABIC-INDIC DIGIT ZERO
    $0661: Result:= #$b1;  // ARABIC-INDIC DIGIT ONE
    $0662: Result:= #$b2;  // ARABIC-INDIC DIGIT TWO
    $0663: Result:= #$b3;  // ARABIC-INDIC DIGIT THREE
    $0664: Result:= #$b4;  // ARABIC-INDIC DIGIT FOUR
    $0665: Result:= #$b5;  // ARABIC-INDIC DIGIT FIVE
    $0666: Result:= #$b6;  // ARABIC-INDIC DIGIT SIX
    $0667: Result:= #$b7;  // ARABIC-INDIC DIGIT SEVEN
    $0668: Result:= #$b8;  // ARABIC-INDIC DIGIT EIGHT
    $0669: Result:= #$b9;  // ARABIC-INDIC DIGIT NINE
    $066a: Result:= #$25;  // ARABIC PERCENT SIGN
    $2219: Result:= #$82;  // BULLET OPERATOR
    $221a: Result:= #$83;  // SQUARE ROOT
    $221e: Result:= #$91;  // INFINITY
    $2248: Result:= #$96;  // ALMOST EQUAL TO
    $2500: Result:= #$85;  // FORMS LIGHT HORIZONTAL
    $2502: Result:= #$86;  // FORMS LIGHT VERTICAL
    $250c: Result:= #$8d;  // FORMS LIGHT DOWN AND RIGHT
    $2510: Result:= #$8c;  // FORMS LIGHT DOWN AND LEFT
    $2514: Result:= #$8e;  // FORMS LIGHT UP AND RIGHT
    $2518: Result:= #$8f;  // FORMS LIGHT UP AND LEFT
    $251c: Result:= #$8a;  // FORMS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$88;  // FORMS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$89;  // FORMS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$8b;  // FORMS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$87;  // FORMS LIGHT VERTICAL AND HORIZONTAL
    $2592: Result:= #$84;  // MEDIUM SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
    $f8be: Result:= #$a6;
    $f8bf: Result:= #$a7;
    $fe7d: Result:= #$f0;  // ARABIC SHADDA MEDIAL FORM
    $fe80: Result:= #$c1;  // ARABIC LETTER HAMZA ISOLATED FORM
    $fe81: Result:= #$c2;  // ARABIC LETTER ALEF WITH MADDA ABOVE ISOLATED FORM
    $fe82: Result:= #$a2;  // ARABIC LETTER ALEF WITH MADDA ABOVE FINAL FORM
    $fe83: Result:= #$c3;  // ARABIC LETTER ALEF WITH HAMZA ABOVE ISOLATED FORM
    $fe84: Result:= #$a5;  // ARABIC LETTER ALEF WITH HAMZA ABOVE FINAL FORM
    $fe85: Result:= #$c4;  // ARABIC LETTER WAW WITH HAMZA ABOVE ISOLATED FORM
    $fe8b: Result:= #$c6;  // ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM
    $fe8d: Result:= #$c7;  // ARABIC LETTER ALEF ISOLATED FORM
    $fe8e: Result:= #$a8;  // ARABIC LETTER ALEF FINAL FORM
    $fe8f: Result:= #$a9;  // ARABIC LETTER BEH ISOLATED FORM
    $fe91: Result:= #$c8;  // ARABIC LETTER BEH INITIAL FORM
    $fe93: Result:= #$c9;  // ARABIC LETTER TEH MARBUTA ISOLATED FORM
    $fe95: Result:= #$aa;  // ARABIC LETTER TEH ISOLATED FORM
    $fe97: Result:= #$ca;  // ARABIC LETTER TEH INITIAL FORM
    $fe99: Result:= #$ab;  // ARABIC LETTER THEH ISOLATED FORM
    $fe9b: Result:= #$cb;  // ARABIC LETTER THEH INITIAL FORM
    $fe9d: Result:= #$ad;  // ARABIC LETTER JEEM ISOLATED FORM
    $fe9f: Result:= #$cc;  // ARABIC LETTER JEEM INITIAL FORM
    $fea1: Result:= #$ae;  // ARABIC LETTER HAH ISOLATED FORM
    $fea3: Result:= #$cd;  // ARABIC LETTER HAH INITIAL FORM
    $fea5: Result:= #$af;  // ARABIC LETTER KHAH ISOLATED FORM
    $fea7: Result:= #$ce;  // ARABIC LETTER KHAH INITIAL FORM
    $fea9: Result:= #$cf;  // ARABIC LETTER DAL ISOLATED FORM
    $feab: Result:= #$d0;  // ARABIC LETTER THAL ISOLATED FORM
    $fead: Result:= #$d1;  // ARABIC LETTER REH ISOLATED FORM
    $feaf: Result:= #$d2;  // ARABIC LETTER ZAIN ISOLATED FORM
    $feb1: Result:= #$bc;  // ARABIC LETTER SEEN ISOLATED FORM
    $feb3: Result:= #$d3;  // ARABIC LETTER SEEN INITIAL FORM
    $feb5: Result:= #$bd;  // ARABIC LETTER SHEEN ISOLATED FORM
    $feb7: Result:= #$d4;  // ARABIC LETTER SHEEN INITIAL FORM
    $feb9: Result:= #$be;  // ARABIC LETTER SAD ISOLATED FORM
    $febb: Result:= #$d5;  // ARABIC LETTER SAD INITIAL FORM
    $febd: Result:= #$eb;  // ARABIC LETTER DAD ISOLATED FORM
    $febf: Result:= #$d6;  // ARABIC LETTER DAD INITIAL FORM
    $fec1: Result:= #$d7;  // ARABIC LETTER TAH ISOLATED FORM
    $fec5: Result:= #$d8;  // ARABIC LETTER ZAH ISOLATED FORM
    $fec9: Result:= #$df;  // ARABIC LETTER AIN ISOLATED FORM
    $feca: Result:= #$c5;  // ARABIC LETTER AIN FINAL FORM
    $fecb: Result:= #$d9;  // ARABIC LETTER AIN INITIAL FORM
    $fecc: Result:= #$ec;  // ARABIC LETTER AIN MEDIAL FORM
    $fecd: Result:= #$ee;  // ARABIC LETTER GHAIN ISOLATED FORM
    $fece: Result:= #$ed;  // ARABIC LETTER GHAIN FINAL FORM
    $fecf: Result:= #$da;  // ARABIC LETTER GHAIN INITIAL FORM
    $fed0: Result:= #$f7;  // ARABIC LETTER GHAIN MEDIAL FORM
    $fed1: Result:= #$ba;  // ARABIC LETTER FEH ISOLATED FORM
    $fed3: Result:= #$e1;  // ARABIC LETTER FEH INITIAL FORM
    $fed5: Result:= #$f8;  // ARABIC LETTER QAF ISOLATED FORM
    $fed7: Result:= #$e2;  // ARABIC LETTER QAF INITIAL FORM
    $fed9: Result:= #$fc;  // ARABIC LETTER KAF ISOLATED FORM
    $fedb: Result:= #$e3;  // ARABIC LETTER KAF INITIAL FORM
    $fedd: Result:= #$fb;  // ARABIC LETTER LAM ISOLATED FORM
    $fedf: Result:= #$e4;  // ARABIC LETTER LAM INITIAL FORM
    $fee1: Result:= #$ef;  // ARABIC LETTER MEEM ISOLATED FORM
    $fee3: Result:= #$e5;  // ARABIC LETTER MEEM INITIAL FORM
    $fee5: Result:= #$f2;  // ARABIC LETTER NOON ISOLATED FORM
    $fee7: Result:= #$e6;  // ARABIC LETTER NOON INITIAL FORM
    $fee9: Result:= #$f3;  // ARABIC LETTER HEH ISOLATED FORM
    $feeb: Result:= #$e7;  // ARABIC LETTER HEH INITIAL FORM
    $feec: Result:= #$f4;  // ARABIC LETTER HEH MEDIAL FORM
    $feed: Result:= #$e8;  // ARABIC LETTER WAW ISOLATED FORM
    $feef: Result:= #$e9;  // ARABIC LETTER ALEF MAKSURA ISOLATED FORM
    $fef0: Result:= #$f5;  // ARABIC LETTER ALEF MAKSURA FINAL FORM
    $fef1: Result:= #$fd;  // ARABIC LETTER YEH ISOLATED FORM
    $fef2: Result:= #$f6;  // ARABIC LETTER YEH FINAL FORM
    $fef3: Result:= #$ea;  // ARABIC LETTER YEH INITIAL FORM
    $fef5: Result:= #$f9;  // ARABIC LIGATURE LAM WITH ALEF WITH MADDA ABOVE ISOLATED FORM
    $fef6: Result:= #$fa;  // ARABIC LIGATURE LAM WITH ALEF WITH MADDA ABOVE FINAL FORM
    $fef7: Result:= #$99;  // ARABIC LIGATURE LAM WITH ALEF WITH HAMZA ABOVE ISOLATED FORM
    $fef8: Result:= #$9a;  // ARABIC LIGATURE LAM WITH ALEF WITH HAMZA ABOVE FINAL FORM
    $fefb: Result:= #$9d;  // ARABIC LIGATURE LAM WITH ALEF ISOLATED FORM
    $fefc: Result:= #$9e;  // ARABIC LIGATURE LAM WITH ALEF FINAL FORM
  else
    raise EConvertError.CreateFmt('Invalid cp864_DOSArabic sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp865Char(const I: longint): char;
begin
  case I of
    $0000..$0019,$001b,$001d..$007e:
      Result:= Char(I);
    $001a: Result:= #$7f;
    $001c: Result:= #$1a;
    $007f: Result:= #$1c;
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a1: Result:= #$ad;  // INVERTED EXCLAMATION MARK
    $00a3: Result:= #$9c;  // POUND SIGN
    $00a4: Result:= #$af;  // CURRENCY SIGN
    $00aa: Result:= #$a6;  // FEMININE ORDINAL INDICATOR
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00ba: Result:= #$a7;  // MASCULINE ORDINAL INDICATOR
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00bf: Result:= #$a8;  // INVERTED QUESTION MARK
    $00c4: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00c5: Result:= #$8f;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00c6: Result:= #$92;  // LATIN CAPITAL LIGATURE AE
    $00c7: Result:= #$80;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00d1: Result:= #$a5;  // LATIN CAPITAL LETTER N WITH TILDE
    $00d6: Result:= #$99;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00d8: Result:= #$9d;  // LATIN CAPITAL LETTER O WITH STROKE
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S
    $00e0: Result:= #$85;  // LATIN SMALL LETTER A WITH GRAVE
    $00e1: Result:= #$a0;  // LATIN SMALL LETTER A WITH ACUTE
    $00e2: Result:= #$83;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e4: Result:= #$84;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00e5: Result:= #$86;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00e6: Result:= #$91;  // LATIN SMALL LIGATURE AE
    $00e7: Result:= #$87;  // LATIN SMALL LETTER C WITH CEDILLA
    $00e8: Result:= #$8a;  // LATIN SMALL LETTER E WITH GRAVE
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00ea: Result:= #$88;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00eb: Result:= #$89;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00ec: Result:= #$8d;  // LATIN SMALL LETTER I WITH GRAVE
    $00ed: Result:= #$a1;  // LATIN SMALL LETTER I WITH ACUTE
    $00ee: Result:= #$8c;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00ef: Result:= #$8b;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00f1: Result:= #$a4;  // LATIN SMALL LETTER N WITH TILDE
    $00f2: Result:= #$95;  // LATIN SMALL LETTER O WITH GRAVE
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$93;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f6: Result:= #$94;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00f8: Result:= #$9b;  // LATIN SMALL LETTER O WITH STROKE
    $00f9: Result:= #$97;  // LATIN SMALL LETTER U WITH GRAVE
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $00fb: Result:= #$96;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00ff: Result:= #$98;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $0192: Result:= #$9f;  // LATIN SMALL LETTER F WITH HOOK
    $0393: Result:= #$e2;  // GREEK CAPITAL LETTER GAMMA
    $0398: Result:= #$e9;  // GREEK CAPITAL LETTER THETA
    $03a3: Result:= #$e4;  // GREEK CAPITAL LETTER SIGMA
    $03a6: Result:= #$e8;  // GREEK CAPITAL LETTER PHI
    $03a9: Result:= #$ea;  // GREEK CAPITAL LETTER OMEGA
    $03b1: Result:= #$e0;  // GREEK SMALL LETTER ALPHA
    $03b4: Result:= #$eb;  // GREEK SMALL LETTER DELTA
    $03b5: Result:= #$ee;  // GREEK SMALL LETTER EPSILON
    $03c0: Result:= #$e3;  // GREEK SMALL LETTER PI
    $03c3: Result:= #$e5;  // GREEK SMALL LETTER SIGMA
    $03c4: Result:= #$e7;  // GREEK SMALL LETTER TAU
    $03c6: Result:= #$ed;  // GREEK SMALL LETTER PHI
    $207f: Result:= #$fc;  // SUPERSCRIPT LATIN SMALL LETTER N
    $20a7: Result:= #$9e;  // PESETA SIGN
    $2219: Result:= #$f9;  // BULLET OPERATOR
    $221a: Result:= #$fb;  // SQUARE ROOT
    $221e: Result:= #$ec;  // INFINITY
    $2229: Result:= #$ef;  // INTERSECTION
    $2248: Result:= #$f7;  // ALMOST EQUAL TO
    $2261: Result:= #$f0;  // IDENTICAL TO
    $2264: Result:= #$f3;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$f2;  // GREATER-THAN OR EQUAL TO
    $2310: Result:= #$a9;  // REVERSED NOT SIGN
    $2320: Result:= #$f4;  // TOP HALF INTEGRAL
    $2321: Result:= #$f5;  // BOTTOM HALF INTEGRAL
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: Result:= #$d5;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $2553: Result:= #$d6;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: Result:= #$b8;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: Result:= #$b7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: Result:= #$d4;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: Result:= #$d3;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255b: Result:= #$be;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255c: Result:= #$bd;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255e: Result:= #$c6;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255f: Result:= #$c7;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: Result:= #$b5;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $2562: Result:= #$b6;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: Result:= #$d1;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: Result:= #$d2;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: Result:= #$cf;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: Result:= #$d0;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256a: Result:= #$d8;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256b: Result:= #$d7;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $258c: Result:= #$dd;  // LEFT HALF BLOCK
    $2590: Result:= #$de;  // RIGHT HALF BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp865 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp865_DOSNordicChar(const I: longint): char;
begin
  case I of
    $0000..$007f: Result:= Char(I);
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a1: Result:= #$ad;  // INVERTED EXCLAMATION MARK
    $00a3: Result:= #$9c;  // POUND SIGN
    $00a4: Result:= #$af;  // CURRENCY SIGN
    $00aa: Result:= #$a6;  // FEMININE ORDINAL INDICATOR
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$aa;  // NOT SIGN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$fd;  // SUPERSCRIPT TWO
    $00b5: Result:= #$e6;  // MICRO SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $00ba: Result:= #$a7;  // MASCULINE ORDINAL INDICATOR
    $00bc: Result:= #$ac;  // VULGAR FRACTION ONE QUARTER
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $00bf: Result:= #$a8;  // INVERTED QUESTION MARK
    $00c4: Result:= #$8e;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00c5: Result:= #$8f;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00c6: Result:= #$92;  // LATIN CAPITAL LIGATURE AE
    $00c7: Result:= #$80;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00c9: Result:= #$90;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00d1: Result:= #$a5;  // LATIN CAPITAL LETTER N WITH TILDE
    $00d6: Result:= #$99;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00d8: Result:= #$9d;  // LATIN CAPITAL LETTER O WITH STROKE
    $00dc: Result:= #$9a;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00df: Result:= #$e1;  // LATIN SMALL LETTER SHARP S
    $00e0: Result:= #$85;  // LATIN SMALL LETTER A WITH GRAVE
    $00e1: Result:= #$a0;  // LATIN SMALL LETTER A WITH ACUTE
    $00e2: Result:= #$83;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00e4: Result:= #$84;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00e5: Result:= #$86;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00e6: Result:= #$91;  // LATIN SMALL LIGATURE AE
    $00e7: Result:= #$87;  // LATIN SMALL LETTER C WITH CEDILLA
    $00e8: Result:= #$8a;  // LATIN SMALL LETTER E WITH GRAVE
    $00e9: Result:= #$82;  // LATIN SMALL LETTER E WITH ACUTE
    $00ea: Result:= #$88;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00eb: Result:= #$89;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00ec: Result:= #$8d;  // LATIN SMALL LETTER I WITH GRAVE
    $00ed: Result:= #$a1;  // LATIN SMALL LETTER I WITH ACUTE
    $00ee: Result:= #$8c;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00ef: Result:= #$8b;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00f1: Result:= #$a4;  // LATIN SMALL LETTER N WITH TILDE
    $00f2: Result:= #$95;  // LATIN SMALL LETTER O WITH GRAVE
    $00f3: Result:= #$a2;  // LATIN SMALL LETTER O WITH ACUTE
    $00f4: Result:= #$93;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00f6: Result:= #$94;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00f7: Result:= #$f6;  // DIVISION SIGN
    $00f8: Result:= #$9b;  // LATIN SMALL LETTER O WITH STROKE
    $00f9: Result:= #$97;  // LATIN SMALL LETTER U WITH GRAVE
    $00fa: Result:= #$a3;  // LATIN SMALL LETTER U WITH ACUTE
    $00fb: Result:= #$96;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00fc: Result:= #$81;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00ff: Result:= #$98;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $0192: Result:= #$9f;  // LATIN SMALL LETTER F WITH HOOK
    $0393: Result:= #$e2;  // GREEK CAPITAL LETTER GAMMA
    $0398: Result:= #$e9;  // GREEK CAPITAL LETTER THETA
    $03a3: Result:= #$e4;  // GREEK CAPITAL LETTER SIGMA
    $03a6: Result:= #$e8;  // GREEK CAPITAL LETTER PHI
    $03a9: Result:= #$ea;  // GREEK CAPITAL LETTER OMEGA
    $03b1: Result:= #$e0;  // GREEK SMALL LETTER ALPHA
    $03b4: Result:= #$eb;  // GREEK SMALL LETTER DELTA
    $03b5: Result:= #$ee;  // GREEK SMALL LETTER EPSILON
    $03c0: Result:= #$e3;  // GREEK SMALL LETTER PI
    $03c3: Result:= #$e5;  // GREEK SMALL LETTER SIGMA
    $03c4: Result:= #$e7;  // GREEK SMALL LETTER TAU
    $03c6: Result:= #$ed;  // GREEK SMALL LETTER PHI
    $207f: Result:= #$fc;  // SUPERSCRIPT LATIN SMALL LETTER N
    $20a7: Result:= #$9e;  // PESETA SIGN
    $2219: Result:= #$f9;  // BULLET OPERATOR
    $221a: Result:= #$fb;  // SQUARE ROOT
    $221e: Result:= #$ec;  // INFINITY
    $2229: Result:= #$ef;  // INTERSECTION
    $2248: Result:= #$f7;  // ALMOST EQUAL TO
    $2261: Result:= #$f0;  // IDENTICAL TO
    $2264: Result:= #$f3;  // LESS-THAN OR EQUAL TO
    $2265: Result:= #$f2;  // GREATER-THAN OR EQUAL TO
    $2310: Result:= #$a9;  // REVERSED NOT SIGN
    $2320: Result:= #$f4;  // TOP HALF INTEGRAL
    $2321: Result:= #$f5;  // BOTTOM HALF INTEGRAL
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: Result:= #$d5;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $2553: Result:= #$d6;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: Result:= #$b8;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: Result:= #$b7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: Result:= #$d4;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: Result:= #$d3;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255b: Result:= #$be;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255c: Result:= #$bd;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255e: Result:= #$c6;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255f: Result:= #$c7;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: Result:= #$b5;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $2562: Result:= #$b6;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: Result:= #$d1;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: Result:= #$d2;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: Result:= #$cf;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: Result:= #$d0;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256a: Result:= #$d8;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256b: Result:= #$d7;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $258c: Result:= #$dd;  // LEFT HALF BLOCK
    $2590: Result:= #$de;  // RIGHT HALF BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp865_DOSNordic sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp866Char(const I: longint): char;
begin
  case I of
    $0000..$0019,$001b,$001d..$007e:
      Result:= Char(I);
    $001a: Result:= #$7f;
    $001c: Result:= #$1a;
    $007f: Result:= #$1c;
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a4: Result:= #$fd;  // CURRENCY SIGN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $0401: Result:= #$f0;  // CYRILLIC CAPITAL LETTER IO
    $0404: Result:= #$f2;  // CYRILLIC CAPITAL LETTER UKRAINIAN IE
    $0407: Result:= #$f4;  // CYRILLIC CAPITAL LETTER YI
    $040e: Result:= #$f6;  // CYRILLIC CAPITAL LETTER SHORT U
    $0410: Result:= #$80;  // CYRILLIC CAPITAL LETTER A
    $0411: Result:= #$81;  // CYRILLIC CAPITAL LETTER BE
    $0412: Result:= #$82;  // CYRILLIC CAPITAL LETTER VE
    $0413: Result:= #$83;  // CYRILLIC CAPITAL LETTER GHE
    $0414: Result:= #$84;  // CYRILLIC CAPITAL LETTER DE
    $0415: Result:= #$85;  // CYRILLIC CAPITAL LETTER IE
    $0416: Result:= #$86;  // CYRILLIC CAPITAL LETTER ZHE
    $0417: Result:= #$87;  // CYRILLIC CAPITAL LETTER ZE
    $0418: Result:= #$88;  // CYRILLIC CAPITAL LETTER I
    $0419: Result:= #$89;  // CYRILLIC CAPITAL LETTER SHORT I
    $041a: Result:= #$8a;  // CYRILLIC CAPITAL LETTER KA
    $041b: Result:= #$8b;  // CYRILLIC CAPITAL LETTER EL
    $041c: Result:= #$8c;  // CYRILLIC CAPITAL LETTER EM
    $041d: Result:= #$8d;  // CYRILLIC CAPITAL LETTER EN
    $041e: Result:= #$8e;  // CYRILLIC CAPITAL LETTER O
    $041f: Result:= #$8f;  // CYRILLIC CAPITAL LETTER PE
    $0420: Result:= #$90;  // CYRILLIC CAPITAL LETTER ER
    $0421: Result:= #$91;  // CYRILLIC CAPITAL LETTER ES
    $0422: Result:= #$92;  // CYRILLIC CAPITAL LETTER TE
    $0423: Result:= #$93;  // CYRILLIC CAPITAL LETTER U
    $0424: Result:= #$94;  // CYRILLIC CAPITAL LETTER EF
    $0425: Result:= #$95;  // CYRILLIC CAPITAL LETTER HA
    $0426: Result:= #$96;  // CYRILLIC CAPITAL LETTER TSE
    $0427: Result:= #$97;  // CYRILLIC CAPITAL LETTER CHE
    $0428: Result:= #$98;  // CYRILLIC CAPITAL LETTER SHA
    $0429: Result:= #$99;  // CYRILLIC CAPITAL LETTER SHCHA
    $042a: Result:= #$9a;  // CYRILLIC CAPITAL LETTER HARD SIGN
    $042b: Result:= #$9b;  // CYRILLIC CAPITAL LETTER YERU
    $042c: Result:= #$9c;  // CYRILLIC CAPITAL LETTER SOFT SIGN
    $042d: Result:= #$9d;  // CYRILLIC CAPITAL LETTER E
    $042e: Result:= #$9e;  // CYRILLIC CAPITAL LETTER YU
    $042f: Result:= #$9f;  // CYRILLIC CAPITAL LETTER YA
    $0430: Result:= #$a0;  // CYRILLIC SMALL LETTER A
    $0431: Result:= #$a1;  // CYRILLIC SMALL LETTER BE
    $0432: Result:= #$a2;  // CYRILLIC SMALL LETTER VE
    $0433: Result:= #$a3;  // CYRILLIC SMALL LETTER GHE
    $0434: Result:= #$a4;  // CYRILLIC SMALL LETTER DE
    $0435: Result:= #$a5;  // CYRILLIC SMALL LETTER IE
    $0436: Result:= #$a6;  // CYRILLIC SMALL LETTER ZHE
    $0437: Result:= #$a7;  // CYRILLIC SMALL LETTER ZE
    $0438: Result:= #$a8;  // CYRILLIC SMALL LETTER I
    $0439: Result:= #$a9;  // CYRILLIC SMALL LETTER SHORT I
    $043a: Result:= #$aa;  // CYRILLIC SMALL LETTER KA
    $043b: Result:= #$ab;  // CYRILLIC SMALL LETTER EL
    $043c: Result:= #$ac;  // CYRILLIC SMALL LETTER EM
    $043d: Result:= #$ad;  // CYRILLIC SMALL LETTER EN
    $043e: Result:= #$ae;  // CYRILLIC SMALL LETTER O
    $043f: Result:= #$af;  // CYRILLIC SMALL LETTER PE
    $0440: Result:= #$e0;  // CYRILLIC SMALL LETTER ER
    $0441: Result:= #$e1;  // CYRILLIC SMALL LETTER ES
    $0442: Result:= #$e2;  // CYRILLIC SMALL LETTER TE
    $0443: Result:= #$e3;  // CYRILLIC SMALL LETTER U
    $0444: Result:= #$e4;  // CYRILLIC SMALL LETTER EF
    $0445: Result:= #$e5;  // CYRILLIC SMALL LETTER HA
    $0446: Result:= #$e6;  // CYRILLIC SMALL LETTER TSE
    $0447: Result:= #$e7;  // CYRILLIC SMALL LETTER CHE
    $0448: Result:= #$e8;  // CYRILLIC SMALL LETTER SHA
    $0449: Result:= #$e9;  // CYRILLIC SMALL LETTER SHCHA
    $044a: Result:= #$ea;  // CYRILLIC SMALL LETTER HARD SIGN
    $044b: Result:= #$eb;  // CYRILLIC SMALL LETTER YERU
    $044c: Result:= #$ec;  // CYRILLIC SMALL LETTER SOFT SIGN
    $044d: Result:= #$ed;  // CYRILLIC SMALL LETTER E
    $044e: Result:= #$ee;  // CYRILLIC SMALL LETTER YU
    $044f: Result:= #$ef;  // CYRILLIC SMALL LETTER YA
    $0451: Result:= #$f1;  // CYRILLIC SMALL LETTER IO
    $0454: Result:= #$f3;  // CYRILLIC SMALL LETTER UKRAINIAN IE
    $0457: Result:= #$f5;  // CYRILLIC SMALL LETTER YI
    $045e: Result:= #$f7;  // CYRILLIC SMALL LETTER SHORT U
    $2116: Result:= #$fc;  // NUMERO SIGN
    $2219: Result:= #$f9;  // BULLET OPERATOR
    $221a: Result:= #$fb;  // SQUARE ROOT
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: Result:= #$d5;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $2553: Result:= #$d6;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: Result:= #$b8;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: Result:= #$b7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: Result:= #$d4;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: Result:= #$d3;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255b: Result:= #$be;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255c: Result:= #$bd;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255e: Result:= #$c6;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255f: Result:= #$c7;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: Result:= #$b5;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $2562: Result:= #$b6;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: Result:= #$d1;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: Result:= #$d2;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: Result:= #$cf;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: Result:= #$d0;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256a: Result:= #$d8;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256b: Result:= #$d7;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $258c: Result:= #$dd;  // LEFT HALF BLOCK
    $2590: Result:= #$de;  // RIGHT HALF BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp866 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp866_DOSCyrillicRussianChar(const I: longint): char;
begin
  case I of
    $0000..$007f: Result:= Char(I);
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a4: Result:= #$fd;  // CURRENCY SIGN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b7: Result:= #$fa;  // MIDDLE DOT
    $0401: Result:= #$f0;  // CYRILLIC CAPITAL LETTER IO
    $0404: Result:= #$f2;  // CYRILLIC CAPITAL LETTER UKRAINIAN IE
    $0407: Result:= #$f4;  // CYRILLIC CAPITAL LETTER YI
    $040e: Result:= #$f6;  // CYRILLIC CAPITAL LETTER SHORT U
    $0410: Result:= #$80;  // CYRILLIC CAPITAL LETTER A
    $0411: Result:= #$81;  // CYRILLIC CAPITAL LETTER BE
    $0412: Result:= #$82;  // CYRILLIC CAPITAL LETTER VE
    $0413: Result:= #$83;  // CYRILLIC CAPITAL LETTER GHE
    $0414: Result:= #$84;  // CYRILLIC CAPITAL LETTER DE
    $0415: Result:= #$85;  // CYRILLIC CAPITAL LETTER IE
    $0416: Result:= #$86;  // CYRILLIC CAPITAL LETTER ZHE
    $0417: Result:= #$87;  // CYRILLIC CAPITAL LETTER ZE
    $0418: Result:= #$88;  // CYRILLIC CAPITAL LETTER I
    $0419: Result:= #$89;  // CYRILLIC CAPITAL LETTER SHORT I
    $041a: Result:= #$8a;  // CYRILLIC CAPITAL LETTER KA
    $041b: Result:= #$8b;  // CYRILLIC CAPITAL LETTER EL
    $041c: Result:= #$8c;  // CYRILLIC CAPITAL LETTER EM
    $041d: Result:= #$8d;  // CYRILLIC CAPITAL LETTER EN
    $041e: Result:= #$8e;  // CYRILLIC CAPITAL LETTER O
    $041f: Result:= #$8f;  // CYRILLIC CAPITAL LETTER PE
    $0420: Result:= #$90;  // CYRILLIC CAPITAL LETTER ER
    $0421: Result:= #$91;  // CYRILLIC CAPITAL LETTER ES
    $0422: Result:= #$92;  // CYRILLIC CAPITAL LETTER TE
    $0423: Result:= #$93;  // CYRILLIC CAPITAL LETTER U
    $0424: Result:= #$94;  // CYRILLIC CAPITAL LETTER EF
    $0425: Result:= #$95;  // CYRILLIC CAPITAL LETTER HA
    $0426: Result:= #$96;  // CYRILLIC CAPITAL LETTER TSE
    $0427: Result:= #$97;  // CYRILLIC CAPITAL LETTER CHE
    $0428: Result:= #$98;  // CYRILLIC CAPITAL LETTER SHA
    $0429: Result:= #$99;  // CYRILLIC CAPITAL LETTER SHCHA
    $042a: Result:= #$9a;  // CYRILLIC CAPITAL LETTER HARD SIGN
    $042b: Result:= #$9b;  // CYRILLIC CAPITAL LETTER YERU
    $042c: Result:= #$9c;  // CYRILLIC CAPITAL LETTER SOFT SIGN
    $042d: Result:= #$9d;  // CYRILLIC CAPITAL LETTER E
    $042e: Result:= #$9e;  // CYRILLIC CAPITAL LETTER YU
    $042f: Result:= #$9f;  // CYRILLIC CAPITAL LETTER YA
    $0430: Result:= #$a0;  // CYRILLIC SMALL LETTER A
    $0431: Result:= #$a1;  // CYRILLIC SMALL LETTER BE
    $0432: Result:= #$a2;  // CYRILLIC SMALL LETTER VE
    $0433: Result:= #$a3;  // CYRILLIC SMALL LETTER GHE
    $0434: Result:= #$a4;  // CYRILLIC SMALL LETTER DE
    $0435: Result:= #$a5;  // CYRILLIC SMALL LETTER IE
    $0436: Result:= #$a6;  // CYRILLIC SMALL LETTER ZHE
    $0437: Result:= #$a7;  // CYRILLIC SMALL LETTER ZE
    $0438: Result:= #$a8;  // CYRILLIC SMALL LETTER I
    $0439: Result:= #$a9;  // CYRILLIC SMALL LETTER SHORT I
    $043a: Result:= #$aa;  // CYRILLIC SMALL LETTER KA
    $043b: Result:= #$ab;  // CYRILLIC SMALL LETTER EL
    $043c: Result:= #$ac;  // CYRILLIC SMALL LETTER EM
    $043d: Result:= #$ad;  // CYRILLIC SMALL LETTER EN
    $043e: Result:= #$ae;  // CYRILLIC SMALL LETTER O
    $043f: Result:= #$af;  // CYRILLIC SMALL LETTER PE
    $0440: Result:= #$e0;  // CYRILLIC SMALL LETTER ER
    $0441: Result:= #$e1;  // CYRILLIC SMALL LETTER ES
    $0442: Result:= #$e2;  // CYRILLIC SMALL LETTER TE
    $0443: Result:= #$e3;  // CYRILLIC SMALL LETTER U
    $0444: Result:= #$e4;  // CYRILLIC SMALL LETTER EF
    $0445: Result:= #$e5;  // CYRILLIC SMALL LETTER HA
    $0446: Result:= #$e6;  // CYRILLIC SMALL LETTER TSE
    $0447: Result:= #$e7;  // CYRILLIC SMALL LETTER CHE
    $0448: Result:= #$e8;  // CYRILLIC SMALL LETTER SHA
    $0449: Result:= #$e9;  // CYRILLIC SMALL LETTER SHCHA
    $044a: Result:= #$ea;  // CYRILLIC SMALL LETTER HARD SIGN
    $044b: Result:= #$eb;  // CYRILLIC SMALL LETTER YERU
    $044c: Result:= #$ec;  // CYRILLIC SMALL LETTER SOFT SIGN
    $044d: Result:= #$ed;  // CYRILLIC SMALL LETTER E
    $044e: Result:= #$ee;  // CYRILLIC SMALL LETTER YU
    $044f: Result:= #$ef;  // CYRILLIC SMALL LETTER YA
    $0451: Result:= #$f1;  // CYRILLIC SMALL LETTER IO
    $0454: Result:= #$f3;  // CYRILLIC SMALL LETTER UKRAINIAN IE
    $0457: Result:= #$f5;  // CYRILLIC SMALL LETTER YI
    $045e: Result:= #$f7;  // CYRILLIC SMALL LETTER SHORT U
    $2116: Result:= #$fc;  // NUMERO SIGN
    $2219: Result:= #$f9;  // BULLET OPERATOR
    $221a: Result:= #$fb;  // SQUARE ROOT
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2552: Result:= #$d5;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $2553: Result:= #$d6;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2555: Result:= #$b8;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $2556: Result:= #$b7;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $2558: Result:= #$d4;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $2559: Result:= #$d3;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255b: Result:= #$be;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $255c: Result:= #$bd;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $255e: Result:= #$c6;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $255f: Result:= #$c7;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2561: Result:= #$b5;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $2562: Result:= #$b6;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2564: Result:= #$d1;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $2565: Result:= #$d2;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2567: Result:= #$cf;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $2568: Result:= #$d0;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256a: Result:= #$d8;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $256b: Result:= #$d7;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $258c: Result:= #$dd;  // LEFT HALF BLOCK
    $2590: Result:= #$de;  // RIGHT HALF BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp866_DOSCyrillicRussian sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp869Char(const I: longint): char;
begin
  case I of
    $0000..$0019,$001b,$001d..$007e:
      Result:= Char(I);
    $001a: Result:= #$7f;
    $001c: Result:= #$1a;
    $007f: Result:= #$1c;
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a3: Result:= #$9c;  // POUND SIGN
    $00a6: Result:= #$8a;  // BROKEN BAR
    $00a7: Result:= #$f5;  // SECTION SIGN
    $00a8: Result:= #$f9;  // DIAERESIS
    $00a9: Result:= #$97;  // COPYRIGHT SIGN
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$89;  // NOT SIGN
    $00ad: Result:= #$f0;  // SOFT HYPHEN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$99;  // SUPERSCRIPT TWO
    $00b3: Result:= #$9a;  // SUPERSCRIPT THREE
    $00b4: Result:= #$ef;  // ACUTE ACCENT
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $0385: Result:= #$f7;  // GREEK DIALYTIKA TONOS
    $0386: Result:= #$86;  // GREEK CAPITAL LETTER ALPHA WITH TONOS
    $0387: Result:= #$88;  // GREEK ANO TELEIA
    $0388: Result:= #$8d;  // GREEK CAPITAL LETTER EPSILON WITH TONOS
    $0389: Result:= #$8f;  // GREEK CAPITAL LETTER ETA WITH TONOS
    $038a: Result:= #$90;  // GREEK CAPITAL LETTER IOTA WITH TONOS
    $038c: Result:= #$92;  // GREEK CAPITAL LETTER OMICRON WITH TONOS
    $038e: Result:= #$95;  // GREEK CAPITAL LETTER UPSILON WITH TONOS
    $038f: Result:= #$98;  // GREEK CAPITAL LETTER OMEGA WITH TONOS
    $0390: Result:= #$a1;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA AND TONOS
    $0391: Result:= #$a4;  // GREEK CAPITAL LETTER ALPHA
    $0392: Result:= #$a5;  // GREEK CAPITAL LETTER BETA
    $0393: Result:= #$a6;  // GREEK CAPITAL LETTER GAMMA
    $0394: Result:= #$a7;  // GREEK CAPITAL LETTER DELTA
    $0395: Result:= #$a8;  // GREEK CAPITAL LETTER EPSILON
    $0396: Result:= #$a9;  // GREEK CAPITAL LETTER ZETA
    $0397: Result:= #$aa;  // GREEK CAPITAL LETTER ETA
    $0398: Result:= #$ac;  // GREEK CAPITAL LETTER THETA
    $0399: Result:= #$ad;  // GREEK CAPITAL LETTER IOTA
    $039a: Result:= #$b5;  // GREEK CAPITAL LETTER KAPPA
    $039b: Result:= #$b6;  // GREEK CAPITAL LETTER LAMDA
    $039c: Result:= #$b7;  // GREEK CAPITAL LETTER MU
    $039d: Result:= #$b8;  // GREEK CAPITAL LETTER NU
    $039e: Result:= #$bd;  // GREEK CAPITAL LETTER XI
    $039f: Result:= #$be;  // GREEK CAPITAL LETTER OMICRON
    $03a0: Result:= #$c6;  // GREEK CAPITAL LETTER PI
    $03a1: Result:= #$c7;  // GREEK CAPITAL LETTER RHO
    $03a3: Result:= #$cf;  // GREEK CAPITAL LETTER SIGMA
    $03a4: Result:= #$d0;  // GREEK CAPITAL LETTER TAU
    $03a5: Result:= #$d1;  // GREEK CAPITAL LETTER UPSILON
    $03a6: Result:= #$d2;  // GREEK CAPITAL LETTER PHI
    $03a7: Result:= #$d3;  // GREEK CAPITAL LETTER CHI
    $03a8: Result:= #$d4;  // GREEK CAPITAL LETTER PSI
    $03a9: Result:= #$d5;  // GREEK CAPITAL LETTER OMEGA
    $03aa: Result:= #$91;  // GREEK CAPITAL LETTER IOTA WITH DIALYTIKA
    $03ab: Result:= #$96;  // GREEK CAPITAL LETTER UPSILON WITH DIALYTIKA
    $03ac: Result:= #$9b;  // GREEK SMALL LETTER ALPHA WITH TONOS
    $03ad: Result:= #$9d;  // GREEK SMALL LETTER EPSILON WITH TONOS
    $03ae: Result:= #$9e;  // GREEK SMALL LETTER ETA WITH TONOS
    $03af: Result:= #$9f;  // GREEK SMALL LETTER IOTA WITH TONOS
    $03b0: Result:= #$fc;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA AND TONOS
    $03b1: Result:= #$d6;  // GREEK SMALL LETTER ALPHA
    $03b2: Result:= #$d7;  // GREEK SMALL LETTER BETA
    $03b3: Result:= #$d8;  // GREEK SMALL LETTER GAMMA
    $03b4: Result:= #$dd;  // GREEK SMALL LETTER DELTA
    $03b5: Result:= #$de;  // GREEK SMALL LETTER EPSILON
    $03b6: Result:= #$e0;  // GREEK SMALL LETTER ZETA
    $03b7: Result:= #$e1;  // GREEK SMALL LETTER ETA
    $03b8: Result:= #$e2;  // GREEK SMALL LETTER THETA
    $03b9: Result:= #$e3;  // GREEK SMALL LETTER IOTA
    $03ba: Result:= #$e4;  // GREEK SMALL LETTER KAPPA
    $03bb: Result:= #$e5;  // GREEK SMALL LETTER LAMDA
    $03bc: Result:= #$e6;  // GREEK SMALL LETTER MU
    $03bd: Result:= #$e7;  // GREEK SMALL LETTER NU
    $03be: Result:= #$e8;  // GREEK SMALL LETTER XI
    $03bf: Result:= #$e9;  // GREEK SMALL LETTER OMICRON
    $03c0: Result:= #$ea;  // GREEK SMALL LETTER PI
    $03c1: Result:= #$eb;  // GREEK SMALL LETTER RHO
    $03c2: Result:= #$ed;  // GREEK SMALL LETTER FINAL SIGMA
    $03c3: Result:= #$ec;  // GREEK SMALL LETTER SIGMA
    $03c4: Result:= #$ee;  // GREEK SMALL LETTER TAU
    $03c5: Result:= #$f2;  // GREEK SMALL LETTER UPSILON
    $03c6: Result:= #$f3;  // GREEK SMALL LETTER PHI
    $03c7: Result:= #$f4;  // GREEK SMALL LETTER CHI
    $03c8: Result:= #$f6;  // GREEK SMALL LETTER PSI
    $03c9: Result:= #$fa;  // GREEK SMALL LETTER OMEGA
    $03ca: Result:= #$a0;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA
    $03cb: Result:= #$fb;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA
    $03cc: Result:= #$a2;  // GREEK SMALL LETTER OMICRON WITH TONOS
    $03cd: Result:= #$a3;  // GREEK SMALL LETTER UPSILON WITH TONOS
    $03ce: Result:= #$fd;  // GREEK SMALL LETTER OMEGA WITH TONOS
    $2015: Result:= #$8e;  // HORIZONTAL BAR
    $2018: Result:= #$8b;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$8c;  // RIGHT SINGLE QUOTATION MARK
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp869 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp869_DOSGreek2Char(const I: longint): char;
begin
  case I of
    $0000..$007f: Result:= Char(I);
    $00a0: Result:= #$ff;  // NO-BREAK SPACE
    $00a3: Result:= #$9c;  // POUND SIGN
    $00a6: Result:= #$8a;  // BROKEN BAR
    $00a7: Result:= #$f5;  // SECTION SIGN
    $00a8: Result:= #$f9;  // DIAERESIS
    $00a9: Result:= #$97;  // COPYRIGHT SIGN
    $00ab: Result:= #$ae;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00ac: Result:= #$89;  // NOT SIGN
    $00ad: Result:= #$f0;  // SOFT HYPHEN
    $00b0: Result:= #$f8;  // DEGREE SIGN
    $00b1: Result:= #$f1;  // PLUS-MINUS SIGN
    $00b2: Result:= #$99;  // SUPERSCRIPT TWO
    $00b3: Result:= #$9a;  // SUPERSCRIPT THREE
    $00b7: Result:= #$88;  // MIDDLE DOT
    $00bb: Result:= #$af;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00bd: Result:= #$ab;  // VULGAR FRACTION ONE HALF
    $0384: Result:= #$ef;  // GREEK TONOS
    $0385: Result:= #$f7;  // GREEK DIALYTIKA TONOS
    $0386: Result:= #$86;  // GREEK CAPITAL LETTER ALPHA WITH TONOS
    $0388: Result:= #$8d;  // GREEK CAPITAL LETTER EPSILON WITH TONOS
    $0389: Result:= #$8f;  // GREEK CAPITAL LETTER ETA WITH TONOS
    $038a: Result:= #$90;  // GREEK CAPITAL LETTER IOTA WITH TONOS
    $038c: Result:= #$92;  // GREEK CAPITAL LETTER OMICRON WITH TONOS
    $038e: Result:= #$95;  // GREEK CAPITAL LETTER UPSILON WITH TONOS
    $038f: Result:= #$98;  // GREEK CAPITAL LETTER OMEGA WITH TONOS
    $0390: Result:= #$a1;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA AND TONOS
    $0391: Result:= #$a4;  // GREEK CAPITAL LETTER ALPHA
    $0392: Result:= #$a5;  // GREEK CAPITAL LETTER BETA
    $0393: Result:= #$a6;  // GREEK CAPITAL LETTER GAMMA
    $0394: Result:= #$a7;  // GREEK CAPITAL LETTER DELTA
    $0395: Result:= #$a8;  // GREEK CAPITAL LETTER EPSILON
    $0396: Result:= #$a9;  // GREEK CAPITAL LETTER ZETA
    $0397: Result:= #$aa;  // GREEK CAPITAL LETTER ETA
    $0398: Result:= #$ac;  // GREEK CAPITAL LETTER THETA
    $0399: Result:= #$ad;  // GREEK CAPITAL LETTER IOTA
    $039a: Result:= #$b5;  // GREEK CAPITAL LETTER KAPPA
    $039b: Result:= #$b6;  // GREEK CAPITAL LETTER LAMDA
    $039c: Result:= #$b7;  // GREEK CAPITAL LETTER MU
    $039d: Result:= #$b8;  // GREEK CAPITAL LETTER NU
    $039e: Result:= #$bd;  // GREEK CAPITAL LETTER XI
    $039f: Result:= #$be;  // GREEK CAPITAL LETTER OMICRON
    $03a0: Result:= #$c6;  // GREEK CAPITAL LETTER PI
    $03a1: Result:= #$c7;  // GREEK CAPITAL LETTER RHO
    $03a3: Result:= #$cf;  // GREEK CAPITAL LETTER SIGMA
    $03a4: Result:= #$d0;  // GREEK CAPITAL LETTER TAU
    $03a5: Result:= #$d1;  // GREEK CAPITAL LETTER UPSILON
    $03a6: Result:= #$d2;  // GREEK CAPITAL LETTER PHI
    $03a7: Result:= #$d3;  // GREEK CAPITAL LETTER CHI
    $03a8: Result:= #$d4;  // GREEK CAPITAL LETTER PSI
    $03a9: Result:= #$d5;  // GREEK CAPITAL LETTER OMEGA
    $03aa: Result:= #$91;  // GREEK CAPITAL LETTER IOTA WITH DIALYTIKA
    $03ab: Result:= #$96;  // GREEK CAPITAL LETTER UPSILON WITH DIALYTIKA
    $03ac: Result:= #$9b;  // GREEK SMALL LETTER ALPHA WITH TONOS
    $03ad: Result:= #$9d;  // GREEK SMALL LETTER EPSILON WITH TONOS
    $03ae: Result:= #$9e;  // GREEK SMALL LETTER ETA WITH TONOS
    $03af: Result:= #$9f;  // GREEK SMALL LETTER IOTA WITH TONOS
    $03b0: Result:= #$fc;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA AND TONOS
    $03b1: Result:= #$d6;  // GREEK SMALL LETTER ALPHA
    $03b2: Result:= #$d7;  // GREEK SMALL LETTER BETA
    $03b3: Result:= #$d8;  // GREEK SMALL LETTER GAMMA
    $03b4: Result:= #$dd;  // GREEK SMALL LETTER DELTA
    $03b5: Result:= #$de;  // GREEK SMALL LETTER EPSILON
    $03b6: Result:= #$e0;  // GREEK SMALL LETTER ZETA
    $03b7: Result:= #$e1;  // GREEK SMALL LETTER ETA
    $03b8: Result:= #$e2;  // GREEK SMALL LETTER THETA
    $03b9: Result:= #$e3;  // GREEK SMALL LETTER IOTA
    $03ba: Result:= #$e4;  // GREEK SMALL LETTER KAPPA
    $03bb: Result:= #$e5;  // GREEK SMALL LETTER LAMDA
    $03bc: Result:= #$e6;  // GREEK SMALL LETTER MU
    $03bd: Result:= #$e7;  // GREEK SMALL LETTER NU
    $03be: Result:= #$e8;  // GREEK SMALL LETTER XI
    $03bf: Result:= #$e9;  // GREEK SMALL LETTER OMICRON
    $03c0: Result:= #$ea;  // GREEK SMALL LETTER PI
    $03c1: Result:= #$eb;  // GREEK SMALL LETTER RHO
    $03c2: Result:= #$ed;  // GREEK SMALL LETTER FINAL SIGMA
    $03c3: Result:= #$ec;  // GREEK SMALL LETTER SIGMA
    $03c4: Result:= #$ee;  // GREEK SMALL LETTER TAU
    $03c5: Result:= #$f2;  // GREEK SMALL LETTER UPSILON
    $03c6: Result:= #$f3;  // GREEK SMALL LETTER PHI
    $03c7: Result:= #$f4;  // GREEK SMALL LETTER CHI
    $03c8: Result:= #$f6;  // GREEK SMALL LETTER PSI
    $03c9: Result:= #$fa;  // GREEK SMALL LETTER OMEGA
    $03ca: Result:= #$a0;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA
    $03cb: Result:= #$fb;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA
    $03cc: Result:= #$a2;  // GREEK SMALL LETTER OMICRON WITH TONOS
    $03cd: Result:= #$a3;  // GREEK SMALL LETTER UPSILON WITH TONOS
    $03ce: Result:= #$fd;  // GREEK SMALL LETTER OMEGA WITH TONOS
    $2015: Result:= #$8e;  // HORIZONTAL BAR
    $2018: Result:= #$8b;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$8c;  // RIGHT SINGLE QUOTATION MARK
    $2500: Result:= #$c4;  // BOX DRAWINGS LIGHT HORIZONTAL
    $2502: Result:= #$b3;  // BOX DRAWINGS LIGHT VERTICAL
    $250c: Result:= #$da;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $2510: Result:= #$bf;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $2514: Result:= #$c0;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $2518: Result:= #$d9;  // BOX DRAWINGS LIGHT UP AND LEFT
    $251c: Result:= #$c3;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $2524: Result:= #$b4;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $252c: Result:= #$c2;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $2534: Result:= #$c1;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $253c: Result:= #$c5;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $2550: Result:= #$cd;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $2551: Result:= #$ba;  // BOX DRAWINGS DOUBLE VERTICAL
    $2554: Result:= #$c9;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $2557: Result:= #$bb;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $255a: Result:= #$c8;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $255d: Result:= #$bc;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $2560: Result:= #$cc;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $2563: Result:= #$b9;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $2566: Result:= #$cb;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $2569: Result:= #$ca;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $256c: Result:= #$ce;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $2580: Result:= #$df;  // UPPER HALF BLOCK
    $2584: Result:= #$dc;  // LOWER HALF BLOCK
    $2588: Result:= #$db;  // FULL BLOCK
    $2591: Result:= #$b0;  // LIGHT SHADE
    $2592: Result:= #$b1;  // MEDIUM SHADE
    $2593: Result:= #$b2;  // DARK SHADE
    $25a0: Result:= #$fe;  // BLACK SQUARE
  else
    raise EConvertError.CreateFmt('Invalid cp869_DOSGreek2 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp874Char(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A0: Result:= Char(I);
    $0E01: Result:= #$A1;  // THAI CHARACTER KO KAI
    $0E02: Result:= #$A2;  // THAI CHARACTER KHO KHAI
    $0E03: Result:= #$A3;  // THAI CHARACTER KHO KHUAT
    $0E04: Result:= #$A4;  // THAI CHARACTER KHO KHWAI
    $0E05: Result:= #$A5;  // THAI CHARACTER KHO KHON
    $0E06: Result:= #$A6;  // THAI CHARACTER KHO RAKHANG
    $0E07: Result:= #$A7;  // THAI CHARACTER NGO NGU
    $0E08: Result:= #$A8;  // THAI CHARACTER CHO CHAN
    $0E09: Result:= #$A9;  // THAI CHARACTER CHO CHING
    $0E0A: Result:= #$AA;  // THAI CHARACTER CHO CHANG
    $0E0B: Result:= #$AB;  // THAI CHARACTER SO SO
    $0E0C: Result:= #$AC;  // THAI CHARACTER CHO CHOE
    $0E0D: Result:= #$AD;  // THAI CHARACTER YO YING
    $0E0E: Result:= #$AE;  // THAI CHARACTER DO CHADA
    $0E0F: Result:= #$AF;  // THAI CHARACTER TO PATAK
    $0E10: Result:= #$B0;  // THAI CHARACTER THO THAN
    $0E11: Result:= #$B1;  // THAI CHARACTER THO NANGMONTHO
    $0E12: Result:= #$B2;  // THAI CHARACTER THO PHUTHAO
    $0E13: Result:= #$B3;  // THAI CHARACTER NO NEN
    $0E14: Result:= #$B4;  // THAI CHARACTER DO DEK
    $0E15: Result:= #$B5;  // THAI CHARACTER TO TAO
    $0E16: Result:= #$B6;  // THAI CHARACTER THO THUNG
    $0E17: Result:= #$B7;  // THAI CHARACTER THO THAHAN
    $0E18: Result:= #$B8;  // THAI CHARACTER THO THONG
    $0E19: Result:= #$B9;  // THAI CHARACTER NO NU
    $0E1A: Result:= #$BA;  // THAI CHARACTER BO BAIMAI
    $0E1B: Result:= #$BB;  // THAI CHARACTER PO PLA
    $0E1C: Result:= #$BC;  // THAI CHARACTER PHO PHUNG
    $0E1D: Result:= #$BD;  // THAI CHARACTER FO FA
    $0E1E: Result:= #$BE;  // THAI CHARACTER PHO PHAN
    $0E1F: Result:= #$BF;  // THAI CHARACTER FO FAN
    $0E20: Result:= #$C0;  // THAI CHARACTER PHO SAMPHAO
    $0E21: Result:= #$C1;  // THAI CHARACTER MO MA
    $0E22: Result:= #$C2;  // THAI CHARACTER YO YAK
    $0E23: Result:= #$C3;  // THAI CHARACTER RO RUA
    $0E24: Result:= #$C4;  // THAI CHARACTER RU
    $0E25: Result:= #$C5;  // THAI CHARACTER LO LING
    $0E26: Result:= #$C6;  // THAI CHARACTER LU
    $0E27: Result:= #$C7;  // THAI CHARACTER WO WAEN
    $0E28: Result:= #$C8;  // THAI CHARACTER SO SALA
    $0E29: Result:= #$C9;  // THAI CHARACTER SO RUSI
    $0E2A: Result:= #$CA;  // THAI CHARACTER SO SUA
    $0E2B: Result:= #$CB;  // THAI CHARACTER HO HIP
    $0E2C: Result:= #$CC;  // THAI CHARACTER LO CHULA
    $0E2D: Result:= #$CD;  // THAI CHARACTER O ANG
    $0E2E: Result:= #$CE;  // THAI CHARACTER HO NOKHUK
    $0E2F: Result:= #$CF;  // THAI CHARACTER PAIYANNOI
    $0E30: Result:= #$D0;  // THAI CHARACTER SARA A
    $0E31: Result:= #$D1;  // THAI CHARACTER MAI HAN-AKAT
    $0E32: Result:= #$D2;  // THAI CHARACTER SARA AA
    $0E33: Result:= #$D3;  // THAI CHARACTER SARA AM
    $0E34: Result:= #$D4;  // THAI CHARACTER SARA I
    $0E35: Result:= #$D5;  // THAI CHARACTER SARA II
    $0E36: Result:= #$D6;  // THAI CHARACTER SARA UE
    $0E37: Result:= #$D7;  // THAI CHARACTER SARA UEE
    $0E38: Result:= #$D8;  // THAI CHARACTER SARA U
    $0E39: Result:= #$D9;  // THAI CHARACTER SARA UU
    $0E3A: Result:= #$DA;  // THAI CHARACTER PHINTHU
    $0E3F: Result:= #$DF;  // THAI CURRENCY SYMBOL BAHT
    $0E40: Result:= #$E0;  // THAI CHARACTER SARA E
    $0E41: Result:= #$E1;  // THAI CHARACTER SARA AE
    $0E42: Result:= #$E2;  // THAI CHARACTER SARA O
    $0E43: Result:= #$E3;  // THAI CHARACTER SARA AI MAIMUAN
    $0E44: Result:= #$E4;  // THAI CHARACTER SARA AI MAIMALAI
    $0E45: Result:= #$E5;  // THAI CHARACTER LAKKHANGYAO
    $0E46: Result:= #$E6;  // THAI CHARACTER MAIYAMOK
    $0E47: Result:= #$E7;  // THAI CHARACTER MAITAIKHU
    $0E48: Result:= #$E8;  // THAI CHARACTER MAI EK
    $0E49: Result:= #$E9;  // THAI CHARACTER MAI THO
    $0E4A: Result:= #$EA;  // THAI CHARACTER MAI TRI
    $0E4B: Result:= #$EB;  // THAI CHARACTER MAI CHATTAWA
    $0E4C: Result:= #$EC;  // THAI CHARACTER THANTHAKHAT
    $0E4D: Result:= #$ED;  // THAI CHARACTER NIKHAHIT
    $0E4E: Result:= #$EE;  // THAI CHARACTER YAMAKKAN
    $0E4F: Result:= #$EF;  // THAI CHARACTER FONGMAN
    $0E50: Result:= #$F0;  // THAI DIGIT ZERO
    $0E51: Result:= #$F1;  // THAI DIGIT ONE
    $0E52: Result:= #$F2;  // THAI DIGIT TWO
    $0E53: Result:= #$F3;  // THAI DIGIT THREE
    $0E54: Result:= #$F4;  // THAI DIGIT FOUR
    $0E55: Result:= #$F5;  // THAI DIGIT FIVE
    $0E56: Result:= #$F6;  // THAI DIGIT SIX
    $0E57: Result:= #$F7;  // THAI DIGIT SEVEN
    $0E58: Result:= #$F8;  // THAI DIGIT EIGHT
    $0E59: Result:= #$F9;  // THAI DIGIT NINE
    $0E5A: Result:= #$FA;  // THAI CHARACTER ANGKHANKHU
    $0E5B: Result:= #$FB;  // THAI CHARACTER KHOMUT
    $2013: Result:= #$96;  // EN DASH
    $2014: Result:= #$97;  // EM DASH
    $2018: Result:= #$91;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$92;  // RIGHT SINGLE QUOTATION MARK
    $201C: Result:= #$93;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$94;  // RIGHT DOUBLE QUOTATION MARK
    $2022: Result:= #$95;  // BULLET
    $2026: Result:= #$85;  // HORIZONTAL ELLIPSIS
    $20AC: Result:= #$80;  // EURO SIGN
  else
    raise EConvertError.CreateFmt('Invalid Windows-874 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp875Char(const I: longint): char;
begin
  case I of
    $0000..$0003,$000B..$0013,$0018..$0019,$001C..$001F: Result:= Char(I);
    $0004: Result:= #$37;  // END OF TRANSMISSION
    $0005: Result:= #$2D;  // ENQUIRY
    $0006: Result:= #$2E;  // ACKNOWLEDGE
    $0007: Result:= #$2F;  // BELL
    $0008: Result:= #$16;  // BACKSPACE
    $0009: Result:= #$05;  // HORIZONTAL TABULATION
    $000A: Result:= #$25;  // LINE FEED
    $0014: Result:= #$3C;  // DEVICE CONTROL FOUR
    $0015: Result:= #$3D;  // NEGATIVE ACKNOWLEDGE
    $0016: Result:= #$32;  // SYNCHRONOUS IDLE
    $0017: Result:= #$26;  // END OF TRANSMISSION BLOCK
    $001A: Result:= #$3F;  // SUBSTITUTE
//    $001A: Result:= #$DC;  // SUBSTITUTE
//    $001A: Result:= #$E1;  // SUBSTITUTE
//    $001A: Result:= #$EC;  // SUBSTITUTE
//    $001A: Result:= #$ED;  // SUBSTITUTE
//    $001A: Result:= #$FC;  // SUBSTITUTE
//    $001A: Result:= #$FD;  // SUBSTITUTE
    $001B: Result:= #$27;  // ESCAPE
    $0020: Result:= #$40;  // SPACE
    $0021: Result:= #$4F;  // EXCLAMATION MARK
    $0022: Result:= #$7F;  // QUOTATION MARK
    $0023: Result:= #$7B;  // NUMBER SIGN
    $0024: Result:= #$5B;  // DOLLAR SIGN
    $0025: Result:= #$6C;  // PERCENT SIGN
    $0026: Result:= #$50;  // AMPERSAND
    $0027: Result:= #$7D;  // APOSTROPHE
    $0028: Result:= #$4D;  // LEFT PARENTHESIS
    $0029: Result:= #$5D;  // RIGHT PARENTHESIS
    $002A: Result:= #$5C;  // ASTERISK
    $002B: Result:= #$4E;  // PLUS SIGN
    $002C: Result:= #$6B;  // COMMA
    $002D: Result:= #$60;  // HYPHEN-MINUS
    $002E: Result:= #$4B;  // FULL STOP
    $002F: Result:= #$61;  // SOLIDUS
    $0030: Result:= #$F0;  // DIGIT ZERO
    $0031: Result:= #$F1;  // DIGIT ONE
    $0032: Result:= #$F2;  // DIGIT TWO
    $0033: Result:= #$F3;  // DIGIT THREE
    $0034: Result:= #$F4;  // DIGIT FOUR
    $0035: Result:= #$F5;  // DIGIT FIVE
    $0036: Result:= #$F6;  // DIGIT SIX
    $0037: Result:= #$F7;  // DIGIT SEVEN
    $0038: Result:= #$F8;  // DIGIT EIGHT
    $0039: Result:= #$F9;  // DIGIT NINE
    $003A: Result:= #$7A;  // COLON
    $003B: Result:= #$5E;  // SEMICOLON
    $003C: Result:= #$4C;  // LESS-THAN SIGN
    $003D: Result:= #$7E;  // EQUALS SIGN
    $003E: Result:= #$6E;  // GREATER-THAN SIGN
    $003F: Result:= #$6F;  // QUESTION MARK
    $0040: Result:= #$7C;  // COMMERCIAL AT
    $0041: Result:= #$C1;  // LATIN CAPITAL LETTER A
    $0042: Result:= #$C2;  // LATIN CAPITAL LETTER B
    $0043: Result:= #$C3;  // LATIN CAPITAL LETTER C
    $0044: Result:= #$C4;  // LATIN CAPITAL LETTER D
    $0045: Result:= #$C5;  // LATIN CAPITAL LETTER E
    $0046: Result:= #$C6;  // LATIN CAPITAL LETTER F
    $0047: Result:= #$C7;  // LATIN CAPITAL LETTER G
    $0048: Result:= #$C8;  // LATIN CAPITAL LETTER H
    $0049: Result:= #$C9;  // LATIN CAPITAL LETTER I
    $004A: Result:= #$D1;  // LATIN CAPITAL LETTER J
    $004B: Result:= #$D2;  // LATIN CAPITAL LETTER K
    $004C: Result:= #$D3;  // LATIN CAPITAL LETTER L
    $004D: Result:= #$D4;  // LATIN CAPITAL LETTER M
    $004E: Result:= #$D5;  // LATIN CAPITAL LETTER N
    $004F: Result:= #$D6;  // LATIN CAPITAL LETTER O
    $0050: Result:= #$D7;  // LATIN CAPITAL LETTER P
    $0051: Result:= #$D8;  // LATIN CAPITAL LETTER Q
    $0052: Result:= #$D9;  // LATIN CAPITAL LETTER R
    $0053: Result:= #$E2;  // LATIN CAPITAL LETTER S
    $0054: Result:= #$E3;  // LATIN CAPITAL LETTER T
    $0055: Result:= #$E4;  // LATIN CAPITAL LETTER U
    $0056: Result:= #$E5;  // LATIN CAPITAL LETTER V
    $0057: Result:= #$E6;  // LATIN CAPITAL LETTER W
    $0058: Result:= #$E7;  // LATIN CAPITAL LETTER X
    $0059: Result:= #$E8;  // LATIN CAPITAL LETTER Y
    $005A: Result:= #$E9;  // LATIN CAPITAL LETTER Z
    $005B: Result:= #$4A;  // LEFT SQUARE BRACKET
    $005C: Result:= #$E0;  // REVERSE SOLIDUS
    $005D: Result:= #$5A;  // RIGHT SQUARE BRACKET
    $005E: Result:= #$5F;  // CIRCUMFLEX ACCENT
    $005F: Result:= #$6D;  // LOW LINE
    $0060: Result:= #$79;  // GRAVE ACCENT
    $0061: Result:= #$81;  // LATIN SMALL LETTER A
    $0062: Result:= #$82;  // LATIN SMALL LETTER B
    $0063: Result:= #$83;  // LATIN SMALL LETTER C
    $0064: Result:= #$84;  // LATIN SMALL LETTER D
    $0065: Result:= #$85;  // LATIN SMALL LETTER E
    $0066: Result:= #$86;  // LATIN SMALL LETTER F
    $0067: Result:= #$87;  // LATIN SMALL LETTER G
    $0068: Result:= #$88;  // LATIN SMALL LETTER H
    $0069: Result:= #$89;  // LATIN SMALL LETTER I
    $006A: Result:= #$91;  // LATIN SMALL LETTER J
    $006B: Result:= #$92;  // LATIN SMALL LETTER K
    $006C: Result:= #$93;  // LATIN SMALL LETTER L
    $006D: Result:= #$94;  // LATIN SMALL LETTER M
    $006E: Result:= #$95;  // LATIN SMALL LETTER N
    $006F: Result:= #$96;  // LATIN SMALL LETTER O
    $0070: Result:= #$97;  // LATIN SMALL LETTER P
    $0071: Result:= #$98;  // LATIN SMALL LETTER Q
    $0072: Result:= #$99;  // LATIN SMALL LETTER R
    $0073: Result:= #$A2;  // LATIN SMALL LETTER S
    $0074: Result:= #$A3;  // LATIN SMALL LETTER T
    $0075: Result:= #$A4;  // LATIN SMALL LETTER U
    $0076: Result:= #$A5;  // LATIN SMALL LETTER V
    $0077: Result:= #$A6;  // LATIN SMALL LETTER W
    $0078: Result:= #$A7;  // LATIN SMALL LETTER X
    $0079: Result:= #$A8;  // LATIN SMALL LETTER Y
    $007A: Result:= #$A9;  // LATIN SMALL LETTER Z
    $007B: Result:= #$C0;  // LEFT CURLY BRACKET
    $007C: Result:= #$6A;  // VERTICAL LINE
    $007D: Result:= #$D0;  // RIGHT CURLY BRACKET
    $007E: Result:= #$A1;  // TILDE
    $007F: Result:= #$07;  // DELETE
    $0080: Result:= #$20;  // CONTROL
    $0081: Result:= #$21;  // CONTROL
    $0082: Result:= #$22;  // CONTROL
    $0083: Result:= #$23;  // CONTROL
    $0084: Result:= #$24;  // CONTROL
    $0085: Result:= #$15;  // CONTROL
    $0086: Result:= #$06;  // CONTROL
    $0087: Result:= #$17;  // CONTROL
    $0088: Result:= #$28;  // CONTROL
    $0089: Result:= #$29;  // CONTROL
    $008A: Result:= #$2A;  // CONTROL
    $008B: Result:= #$2B;  // CONTROL
    $008C: Result:= #$2C;  // CONTROL
    $008D: Result:= #$09;  // CONTROL
    $008E: Result:= #$0A;  // CONTROL
    $008F: Result:= #$1B;  // CONTROL
    $0090: Result:= #$30;  // CONTROL
    $0091: Result:= #$31;  // CONTROL
    $0092: Result:= #$1A;  // CONTROL
    $0093: Result:= #$33;  // CONTROL
    $0094: Result:= #$34;  // CONTROL
    $0095: Result:= #$35;  // CONTROL
    $0096: Result:= #$36;  // CONTROL
    $0097: Result:= #$08;  // CONTROL
    $0098: Result:= #$38;  // CONTROL
    $0099: Result:= #$39;  // CONTROL
    $009A: Result:= #$3A;  // CONTROL
    $009B: Result:= #$3B;  // CONTROL
    $009C: Result:= #$04;  // CONTROL
    $009D: Result:= #$14;  // CONTROL
    $009E: Result:= #$3E;  // CONTROL
    $009F: Result:= #$FF;  // CONTROL
    $00A0: Result:= #$74;  // NO-BREAK SPACE
    $00A3: Result:= #$B0;  // POUND SIGN
    $00A6: Result:= #$DF;  // BROKEN BAR
    $00A7: Result:= #$EB;  // SECTION SIGN
    $00A8: Result:= #$70;  // DIAERESIS
    $00A9: Result:= #$FB;  // COPYRIGHT SIGN
    $00AB: Result:= #$EE;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00AC: Result:= #$EF;  // NOT SIGN
    $00AD: Result:= #$CA;  // SOFT HYPHEN
    $00B0: Result:= #$90;  // DEGREE SIGN
    $00B1: Result:= #$DA;  // PLUS-MINUS SIGN
    $00B2: Result:= #$EA;  // SUPERSCRIPT TWO
    $00B3: Result:= #$FA;  // SUPERSCRIPT THREE
    $00B4: Result:= #$A0;  // ACUTE ACCENT
    $00BB: Result:= #$FE;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00BD: Result:= #$DB;  // VULGAR FRACTION ONE HALF
    $0385: Result:= #$80;  // GREEK DIALYTIKA TONOS
    $0386: Result:= #$71;  // GREEK CAPITAL LETTER ALPHA WITH TONOS
    $0387: Result:= #$DD;  // GREEK ANO TELEIA
    $0388: Result:= #$72;  // GREEK CAPITAL LETTER EPSILON WITH TONOS
    $0389: Result:= #$73;  // GREEK CAPITAL LETTER ETA WITH TONOS
    $038A: Result:= #$75;  // GREEK CAPITAL LETTER IOTA WITH TONOS
    $038C: Result:= #$76;  // GREEK CAPITAL LETTER OMICRON WITH TONOS
    $038E: Result:= #$77;  // GREEK CAPITAL LETTER UPSILON WITH TONOS
    $038F: Result:= #$78;  // GREEK CAPITAL LETTER OMEGA WITH TONOS
    $0390: Result:= #$CC;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA AND TONOS
    $0391: Result:= #$41;  // GREEK CAPITAL LETTER ALPHA
    $0392: Result:= #$42;  // GREEK CAPITAL LETTER BETA
    $0393: Result:= #$43;  // GREEK CAPITAL LETTER GAMMA
    $0394: Result:= #$44;  // GREEK CAPITAL LETTER DELTA
    $0395: Result:= #$45;  // GREEK CAPITAL LETTER EPSILON
    $0396: Result:= #$46;  // GREEK CAPITAL LETTER ZETA
    $0397: Result:= #$47;  // GREEK CAPITAL LETTER ETA
    $0398: Result:= #$48;  // GREEK CAPITAL LETTER THETA
    $0399: Result:= #$49;  // GREEK CAPITAL LETTER IOTA
    $039A: Result:= #$51;  // GREEK CAPITAL LETTER KAPPA
    $039B: Result:= #$52;  // GREEK CAPITAL LETTER LAMDA
    $039C: Result:= #$53;  // GREEK CAPITAL LETTER MU
    $039D: Result:= #$54;  // GREEK CAPITAL LETTER NU
    $039E: Result:= #$55;  // GREEK CAPITAL LETTER XI
    $039F: Result:= #$56;  // GREEK CAPITAL LETTER OMICRON
    $03A0: Result:= #$57;  // GREEK CAPITAL LETTER PI
    $03A1: Result:= #$58;  // GREEK CAPITAL LETTER RHO
    $03A3: Result:= #$59;  // GREEK CAPITAL LETTER SIGMA
    $03A4: Result:= #$62;  // GREEK CAPITAL LETTER TAU
    $03A5: Result:= #$63;  // GREEK CAPITAL LETTER UPSILON
    $03A6: Result:= #$64;  // GREEK CAPITAL LETTER PHI
    $03A7: Result:= #$65;  // GREEK CAPITAL LETTER CHI
    $03A8: Result:= #$66;  // GREEK CAPITAL LETTER PSI
    $03A9: Result:= #$67;  // GREEK CAPITAL LETTER OMEGA
    $03AA: Result:= #$68;  // GREEK CAPITAL LETTER IOTA WITH DIALYTIKA
    $03AB: Result:= #$69;  // GREEK CAPITAL LETTER UPSILON WITH DIALYTIKA
    $03AC: Result:= #$B1;  // GREEK SMALL LETTER ALPHA WITH TONOS
    $03AD: Result:= #$B2;  // GREEK SMALL LETTER EPSILON WITH TONOS
    $03AE: Result:= #$B3;  // GREEK SMALL LETTER ETA WITH TONOS
    $03AF: Result:= #$B5;  // GREEK SMALL LETTER IOTA WITH TONOS
    $03B0: Result:= #$CD;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA AND TONOS
    $03B1: Result:= #$8A;  // GREEK SMALL LETTER ALPHA
    $03B2: Result:= #$8B;  // GREEK SMALL LETTER BETA
    $03B3: Result:= #$8C;  // GREEK SMALL LETTER GAMMA
    $03B4: Result:= #$8D;  // GREEK SMALL LETTER DELTA
    $03B5: Result:= #$8E;  // GREEK SMALL LETTER EPSILON
    $03B6: Result:= #$8F;  // GREEK SMALL LETTER ZETA
    $03B7: Result:= #$9A;  // GREEK SMALL LETTER ETA
    $03B8: Result:= #$9B;  // GREEK SMALL LETTER THETA
    $03B9: Result:= #$9C;  // GREEK SMALL LETTER IOTA
    $03BA: Result:= #$9D;  // GREEK SMALL LETTER KAPPA
    $03BB: Result:= #$9E;  // GREEK SMALL LETTER LAMDA
    $03BC: Result:= #$9F;  // GREEK SMALL LETTER MU
    $03BD: Result:= #$AA;  // GREEK SMALL LETTER NU
    $03BE: Result:= #$AB;  // GREEK SMALL LETTER XI
    $03BF: Result:= #$AC;  // GREEK SMALL LETTER OMICRON
    $03C0: Result:= #$AD;  // GREEK SMALL LETTER PI
    $03C1: Result:= #$AE;  // GREEK SMALL LETTER RHO
    $03C2: Result:= #$BA;  // GREEK SMALL LETTER FINAL SIGMA
    $03C3: Result:= #$AF;  // GREEK SMALL LETTER SIGMA
    $03C4: Result:= #$BB;  // GREEK SMALL LETTER TAU
    $03C5: Result:= #$BC;  // GREEK SMALL LETTER UPSILON
    $03C6: Result:= #$BD;  // GREEK SMALL LETTER PHI
    $03C7: Result:= #$BE;  // GREEK SMALL LETTER CHI
    $03C8: Result:= #$BF;  // GREEK SMALL LETTER PSI
    $03C9: Result:= #$CB;  // GREEK SMALL LETTER OMEGA
    $03CA: Result:= #$B4;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA
    $03CB: Result:= #$B8;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA
    $03CC: Result:= #$B6;  // GREEK SMALL LETTER OMICRON WITH TONOS
    $03CD: Result:= #$B7;  // GREEK SMALL LETTER UPSILON WITH TONOS
    $03CE: Result:= #$B9;  // GREEK SMALL LETTER OMEGA WITH TONOS
    $2015: Result:= #$CF;  // HORIZONTAL BAR
    $2018: Result:= #$CE;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$DE;  // RIGHT SINGLE QUOTATION MARK
  else
    raise EConvertError.CreateFmt('Invalid Windows-875 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp932Char(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A0: Result:= Char(I);
    $0E01: Result:= #$A1;  // THAI CHARACTER KO KAI
    $0E02: Result:= #$A2;  // THAI CHARACTER KHO KHAI
    $0E03: Result:= #$A3;  // THAI CHARACTER KHO KHUAT
    $0E04: Result:= #$A4;  // THAI CHARACTER KHO KHWAI
    $0E05: Result:= #$A5;  // THAI CHARACTER KHO KHON
    $0E06: Result:= #$A6;  // THAI CHARACTER KHO RAKHANG
    $0E07: Result:= #$A7;  // THAI CHARACTER NGO NGU
    $0E08: Result:= #$A8;  // THAI CHARACTER CHO CHAN
    $0E09: Result:= #$A9;  // THAI CHARACTER CHO CHING
    $0E0A: Result:= #$AA;  // THAI CHARACTER CHO CHANG
    $0E0B: Result:= #$AB;  // THAI CHARACTER SO SO
    $0E0C: Result:= #$AC;  // THAI CHARACTER CHO CHOE
    $0E0D: Result:= #$AD;  // THAI CHARACTER YO YING
    $0E0E: Result:= #$AE;  // THAI CHARACTER DO CHADA
    $0E0F: Result:= #$AF;  // THAI CHARACTER TO PATAK
    $0E10: Result:= #$B0;  // THAI CHARACTER THO THAN
    $0E11: Result:= #$B1;  // THAI CHARACTER THO NANGMONTHO
    $0E12: Result:= #$B2;  // THAI CHARACTER THO PHUTHAO
    $0E13: Result:= #$B3;  // THAI CHARACTER NO NEN
    $0E14: Result:= #$B4;  // THAI CHARACTER DO DEK
    $0E15: Result:= #$B5;  // THAI CHARACTER TO TAO
    $0E16: Result:= #$B6;  // THAI CHARACTER THO THUNG
    $0E17: Result:= #$B7;  // THAI CHARACTER THO THAHAN
    $0E18: Result:= #$B8;  // THAI CHARACTER THO THONG
    $0E19: Result:= #$B9;  // THAI CHARACTER NO NU
    $0E1A: Result:= #$BA;  // THAI CHARACTER BO BAIMAI
    $0E1B: Result:= #$BB;  // THAI CHARACTER PO PLA
    $0E1C: Result:= #$BC;  // THAI CHARACTER PHO PHUNG
    $0E1D: Result:= #$BD;  // THAI CHARACTER FO FA
    $0E1E: Result:= #$BE;  // THAI CHARACTER PHO PHAN
    $0E1F: Result:= #$BF;  // THAI CHARACTER FO FAN
    $0E20: Result:= #$C0;  // THAI CHARACTER PHO SAMPHAO
    $0E21: Result:= #$C1;  // THAI CHARACTER MO MA
    $0E22: Result:= #$C2;  // THAI CHARACTER YO YAK
    $0E23: Result:= #$C3;  // THAI CHARACTER RO RUA
    $0E24: Result:= #$C4;  // THAI CHARACTER RU
    $0E25: Result:= #$C5;  // THAI CHARACTER LO LING
    $0E26: Result:= #$C6;  // THAI CHARACTER LU
    $0E27: Result:= #$C7;  // THAI CHARACTER WO WAEN
    $0E28: Result:= #$C8;  // THAI CHARACTER SO SALA
    $0E29: Result:= #$C9;  // THAI CHARACTER SO RUSI
    $0E2A: Result:= #$CA;  // THAI CHARACTER SO SUA
    $0E2B: Result:= #$CB;  // THAI CHARACTER HO HIP
    $0E2C: Result:= #$CC;  // THAI CHARACTER LO CHULA
    $0E2D: Result:= #$CD;  // THAI CHARACTER O ANG
    $0E2E: Result:= #$CE;  // THAI CHARACTER HO NOKHUK
    $0E2F: Result:= #$CF;  // THAI CHARACTER PAIYANNOI
    $0E30: Result:= #$D0;  // THAI CHARACTER SARA A
    $0E31: Result:= #$D1;  // THAI CHARACTER MAI HAN-AKAT
    $0E32: Result:= #$D2;  // THAI CHARACTER SARA AA
    $0E33: Result:= #$D3;  // THAI CHARACTER SARA AM
    $0E34: Result:= #$D4;  // THAI CHARACTER SARA I
    $0E35: Result:= #$D5;  // THAI CHARACTER SARA II
    $0E36: Result:= #$D6;  // THAI CHARACTER SARA UE
    $0E37: Result:= #$D7;  // THAI CHARACTER SARA UEE
    $0E38: Result:= #$D8;  // THAI CHARACTER SARA U
    $0E39: Result:= #$D9;  // THAI CHARACTER SARA UU
    $0E3A: Result:= #$DA;  // THAI CHARACTER PHINTHU
    $0E3F: Result:= #$DF;  // THAI CURRENCY SYMBOL BAHT
    $0E40: Result:= #$E0;  // THAI CHARACTER SARA E
    $0E41: Result:= #$E1;  // THAI CHARACTER SARA AE
    $0E42: Result:= #$E2;  // THAI CHARACTER SARA O
    $0E43: Result:= #$E3;  // THAI CHARACTER SARA AI MAIMUAN
    $0E44: Result:= #$E4;  // THAI CHARACTER SARA AI MAIMALAI
    $0E45: Result:= #$E5;  // THAI CHARACTER LAKKHANGYAO
    $0E46: Result:= #$E6;  // THAI CHARACTER MAIYAMOK
    $0E47: Result:= #$E7;  // THAI CHARACTER MAITAIKHU
    $0E48: Result:= #$E8;  // THAI CHARACTER MAI EK
    $0E49: Result:= #$E9;  // THAI CHARACTER MAI THO
    $0E4A: Result:= #$EA;  // THAI CHARACTER MAI TRI
    $0E4B: Result:= #$EB;  // THAI CHARACTER MAI CHATTAWA
    $0E4C: Result:= #$EC;  // THAI CHARACTER THANTHAKHAT
    $0E4D: Result:= #$ED;  // THAI CHARACTER NIKHAHIT
    $0E4E: Result:= #$EE;  // THAI CHARACTER YAMAKKAN
    $0E4F: Result:= #$EF;  // THAI CHARACTER FONGMAN
    $0E50: Result:= #$F0;  // THAI DIGIT ZERO
    $0E51: Result:= #$F1;  // THAI DIGIT ONE
    $0E52: Result:= #$F2;  // THAI DIGIT TWO
    $0E53: Result:= #$F3;  // THAI DIGIT THREE
    $0E54: Result:= #$F4;  // THAI DIGIT FOUR
    $0E55: Result:= #$F5;  // THAI DIGIT FIVE
    $0E56: Result:= #$F6;  // THAI DIGIT SIX
    $0E57: Result:= #$F7;  // THAI DIGIT SEVEN
    $0E58: Result:= #$F8;  // THAI DIGIT EIGHT
    $0E59: Result:= #$F9;  // THAI DIGIT NINE
    $0E5A: Result:= #$FA;  // THAI CHARACTER ANGKHANKHU
    $0E5B: Result:= #$FB;  // THAI CHARACTER KHOMUT
    $2013: Result:= #$96;  // EN DASH
    $2014: Result:= #$97;  // EM DASH
    $2018: Result:= #$91;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$92;  // RIGHT SINGLE QUOTATION MARK
    $201C: Result:= #$93;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$94;  // RIGHT DOUBLE QUOTATION MARK
    $2022: Result:= #$95;  // BULLET
    $2026: Result:= #$85;  // HORIZONTAL ELLIPSIS
    $20AC: Result:= #$80;  // EURO SIGN
  else
    raise EConvertError.CreateFmt('Invalid Windows-932 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp936Char(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A0: Result:= Char(I);
    $0E01: Result:= #$A1;  // THAI CHARACTER KO KAI
    $0E02: Result:= #$A2;  // THAI CHARACTER KHO KHAI
    $0E03: Result:= #$A3;  // THAI CHARACTER KHO KHUAT
    $0E04: Result:= #$A4;  // THAI CHARACTER KHO KHWAI
    $0E05: Result:= #$A5;  // THAI CHARACTER KHO KHON
    $0E06: Result:= #$A6;  // THAI CHARACTER KHO RAKHANG
    $0E07: Result:= #$A7;  // THAI CHARACTER NGO NGU
    $0E08: Result:= #$A8;  // THAI CHARACTER CHO CHAN
    $0E09: Result:= #$A9;  // THAI CHARACTER CHO CHING
    $0E0A: Result:= #$AA;  // THAI CHARACTER CHO CHANG
    $0E0B: Result:= #$AB;  // THAI CHARACTER SO SO
    $0E0C: Result:= #$AC;  // THAI CHARACTER CHO CHOE
    $0E0D: Result:= #$AD;  // THAI CHARACTER YO YING
    $0E0E: Result:= #$AE;  // THAI CHARACTER DO CHADA
    $0E0F: Result:= #$AF;  // THAI CHARACTER TO PATAK
    $0E10: Result:= #$B0;  // THAI CHARACTER THO THAN
    $0E11: Result:= #$B1;  // THAI CHARACTER THO NANGMONTHO
    $0E12: Result:= #$B2;  // THAI CHARACTER THO PHUTHAO
    $0E13: Result:= #$B3;  // THAI CHARACTER NO NEN
    $0E14: Result:= #$B4;  // THAI CHARACTER DO DEK
    $0E15: Result:= #$B5;  // THAI CHARACTER TO TAO
    $0E16: Result:= #$B6;  // THAI CHARACTER THO THUNG
    $0E17: Result:= #$B7;  // THAI CHARACTER THO THAHAN
    $0E18: Result:= #$B8;  // THAI CHARACTER THO THONG
    $0E19: Result:= #$B9;  // THAI CHARACTER NO NU
    $0E1A: Result:= #$BA;  // THAI CHARACTER BO BAIMAI
    $0E1B: Result:= #$BB;  // THAI CHARACTER PO PLA
    $0E1C: Result:= #$BC;  // THAI CHARACTER PHO PHUNG
    $0E1D: Result:= #$BD;  // THAI CHARACTER FO FA
    $0E1E: Result:= #$BE;  // THAI CHARACTER PHO PHAN
    $0E1F: Result:= #$BF;  // THAI CHARACTER FO FAN
    $0E20: Result:= #$C0;  // THAI CHARACTER PHO SAMPHAO
    $0E21: Result:= #$C1;  // THAI CHARACTER MO MA
    $0E22: Result:= #$C2;  // THAI CHARACTER YO YAK
    $0E23: Result:= #$C3;  // THAI CHARACTER RO RUA
    $0E24: Result:= #$C4;  // THAI CHARACTER RU
    $0E25: Result:= #$C5;  // THAI CHARACTER LO LING
    $0E26: Result:= #$C6;  // THAI CHARACTER LU
    $0E27: Result:= #$C7;  // THAI CHARACTER WO WAEN
    $0E28: Result:= #$C8;  // THAI CHARACTER SO SALA
    $0E29: Result:= #$C9;  // THAI CHARACTER SO RUSI
    $0E2A: Result:= #$CA;  // THAI CHARACTER SO SUA
    $0E2B: Result:= #$CB;  // THAI CHARACTER HO HIP
    $0E2C: Result:= #$CC;  // THAI CHARACTER LO CHULA
    $0E2D: Result:= #$CD;  // THAI CHARACTER O ANG
    $0E2E: Result:= #$CE;  // THAI CHARACTER HO NOKHUK
    $0E2F: Result:= #$CF;  // THAI CHARACTER PAIYANNOI
    $0E30: Result:= #$D0;  // THAI CHARACTER SARA A
    $0E31: Result:= #$D1;  // THAI CHARACTER MAI HAN-AKAT
    $0E32: Result:= #$D2;  // THAI CHARACTER SARA AA
    $0E33: Result:= #$D3;  // THAI CHARACTER SARA AM
    $0E34: Result:= #$D4;  // THAI CHARACTER SARA I
    $0E35: Result:= #$D5;  // THAI CHARACTER SARA II
    $0E36: Result:= #$D6;  // THAI CHARACTER SARA UE
    $0E37: Result:= #$D7;  // THAI CHARACTER SARA UEE
    $0E38: Result:= #$D8;  // THAI CHARACTER SARA U
    $0E39: Result:= #$D9;  // THAI CHARACTER SARA UU
    $0E3A: Result:= #$DA;  // THAI CHARACTER PHINTHU
    $0E3F: Result:= #$DF;  // THAI CURRENCY SYMBOL BAHT
    $0E40: Result:= #$E0;  // THAI CHARACTER SARA E
    $0E41: Result:= #$E1;  // THAI CHARACTER SARA AE
    $0E42: Result:= #$E2;  // THAI CHARACTER SARA O
    $0E43: Result:= #$E3;  // THAI CHARACTER SARA AI MAIMUAN
    $0E44: Result:= #$E4;  // THAI CHARACTER SARA AI MAIMALAI
    $0E45: Result:= #$E5;  // THAI CHARACTER LAKKHANGYAO
    $0E46: Result:= #$E6;  // THAI CHARACTER MAIYAMOK
    $0E47: Result:= #$E7;  // THAI CHARACTER MAITAIKHU
    $0E48: Result:= #$E8;  // THAI CHARACTER MAI EK
    $0E49: Result:= #$E9;  // THAI CHARACTER MAI THO
    $0E4A: Result:= #$EA;  // THAI CHARACTER MAI TRI
    $0E4B: Result:= #$EB;  // THAI CHARACTER MAI CHATTAWA
    $0E4C: Result:= #$EC;  // THAI CHARACTER THANTHAKHAT
    $0E4D: Result:= #$ED;  // THAI CHARACTER NIKHAHIT
    $0E4E: Result:= #$EE;  // THAI CHARACTER YAMAKKAN
    $0E4F: Result:= #$EF;  // THAI CHARACTER FONGMAN
    $0E50: Result:= #$F0;  // THAI DIGIT ZERO
    $0E51: Result:= #$F1;  // THAI DIGIT ONE
    $0E52: Result:= #$F2;  // THAI DIGIT TWO
    $0E53: Result:= #$F3;  // THAI DIGIT THREE
    $0E54: Result:= #$F4;  // THAI DIGIT FOUR
    $0E55: Result:= #$F5;  // THAI DIGIT FIVE
    $0E56: Result:= #$F6;  // THAI DIGIT SIX
    $0E57: Result:= #$F7;  // THAI DIGIT SEVEN
    $0E58: Result:= #$F8;  // THAI DIGIT EIGHT
    $0E59: Result:= #$F9;  // THAI DIGIT NINE
    $0E5A: Result:= #$FA;  // THAI CHARACTER ANGKHANKHU
    $0E5B: Result:= #$FB;  // THAI CHARACTER KHOMUT
    $2013: Result:= #$96;  // EN DASH
    $2014: Result:= #$97;  // EM DASH
    $2018: Result:= #$91;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$92;  // RIGHT SINGLE QUOTATION MARK
    $201C: Result:= #$93;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$94;  // RIGHT DOUBLE QUOTATION MARK
    $2022: Result:= #$95;  // BULLET
    $2026: Result:= #$85;  // HORIZONTAL ELLIPSIS
    $20AC: Result:= #$80;  // EURO SIGN
  else
    raise EConvertError.CreateFmt('Invalid Windows-936 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp949Char(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A0: Result:= Char(I);
    $0E01: Result:= #$A1;  // THAI CHARACTER KO KAI
    $0E02: Result:= #$A2;  // THAI CHARACTER KHO KHAI
    $0E03: Result:= #$A3;  // THAI CHARACTER KHO KHUAT
    $0E04: Result:= #$A4;  // THAI CHARACTER KHO KHWAI
    $0E05: Result:= #$A5;  // THAI CHARACTER KHO KHON
    $0E06: Result:= #$A6;  // THAI CHARACTER KHO RAKHANG
    $0E07: Result:= #$A7;  // THAI CHARACTER NGO NGU
    $0E08: Result:= #$A8;  // THAI CHARACTER CHO CHAN
    $0E09: Result:= #$A9;  // THAI CHARACTER CHO CHING
    $0E0A: Result:= #$AA;  // THAI CHARACTER CHO CHANG
    $0E0B: Result:= #$AB;  // THAI CHARACTER SO SO
    $0E0C: Result:= #$AC;  // THAI CHARACTER CHO CHOE
    $0E0D: Result:= #$AD;  // THAI CHARACTER YO YING
    $0E0E: Result:= #$AE;  // THAI CHARACTER DO CHADA
    $0E0F: Result:= #$AF;  // THAI CHARACTER TO PATAK
    $0E10: Result:= #$B0;  // THAI CHARACTER THO THAN
    $0E11: Result:= #$B1;  // THAI CHARACTER THO NANGMONTHO
    $0E12: Result:= #$B2;  // THAI CHARACTER THO PHUTHAO
    $0E13: Result:= #$B3;  // THAI CHARACTER NO NEN
    $0E14: Result:= #$B4;  // THAI CHARACTER DO DEK
    $0E15: Result:= #$B5;  // THAI CHARACTER TO TAO
    $0E16: Result:= #$B6;  // THAI CHARACTER THO THUNG
    $0E17: Result:= #$B7;  // THAI CHARACTER THO THAHAN
    $0E18: Result:= #$B8;  // THAI CHARACTER THO THONG
    $0E19: Result:= #$B9;  // THAI CHARACTER NO NU
    $0E1A: Result:= #$BA;  // THAI CHARACTER BO BAIMAI
    $0E1B: Result:= #$BB;  // THAI CHARACTER PO PLA
    $0E1C: Result:= #$BC;  // THAI CHARACTER PHO PHUNG
    $0E1D: Result:= #$BD;  // THAI CHARACTER FO FA
    $0E1E: Result:= #$BE;  // THAI CHARACTER PHO PHAN
    $0E1F: Result:= #$BF;  // THAI CHARACTER FO FAN
    $0E20: Result:= #$C0;  // THAI CHARACTER PHO SAMPHAO
    $0E21: Result:= #$C1;  // THAI CHARACTER MO MA
    $0E22: Result:= #$C2;  // THAI CHARACTER YO YAK
    $0E23: Result:= #$C3;  // THAI CHARACTER RO RUA
    $0E24: Result:= #$C4;  // THAI CHARACTER RU
    $0E25: Result:= #$C5;  // THAI CHARACTER LO LING
    $0E26: Result:= #$C6;  // THAI CHARACTER LU
    $0E27: Result:= #$C7;  // THAI CHARACTER WO WAEN
    $0E28: Result:= #$C8;  // THAI CHARACTER SO SALA
    $0E29: Result:= #$C9;  // THAI CHARACTER SO RUSI
    $0E2A: Result:= #$CA;  // THAI CHARACTER SO SUA
    $0E2B: Result:= #$CB;  // THAI CHARACTER HO HIP
    $0E2C: Result:= #$CC;  // THAI CHARACTER LO CHULA
    $0E2D: Result:= #$CD;  // THAI CHARACTER O ANG
    $0E2E: Result:= #$CE;  // THAI CHARACTER HO NOKHUK
    $0E2F: Result:= #$CF;  // THAI CHARACTER PAIYANNOI
    $0E30: Result:= #$D0;  // THAI CHARACTER SARA A
    $0E31: Result:= #$D1;  // THAI CHARACTER MAI HAN-AKAT
    $0E32: Result:= #$D2;  // THAI CHARACTER SARA AA
    $0E33: Result:= #$D3;  // THAI CHARACTER SARA AM
    $0E34: Result:= #$D4;  // THAI CHARACTER SARA I
    $0E35: Result:= #$D5;  // THAI CHARACTER SARA II
    $0E36: Result:= #$D6;  // THAI CHARACTER SARA UE
    $0E37: Result:= #$D7;  // THAI CHARACTER SARA UEE
    $0E38: Result:= #$D8;  // THAI CHARACTER SARA U
    $0E39: Result:= #$D9;  // THAI CHARACTER SARA UU
    $0E3A: Result:= #$DA;  // THAI CHARACTER PHINTHU
    $0E3F: Result:= #$DF;  // THAI CURRENCY SYMBOL BAHT
    $0E40: Result:= #$E0;  // THAI CHARACTER SARA E
    $0E41: Result:= #$E1;  // THAI CHARACTER SARA AE
    $0E42: Result:= #$E2;  // THAI CHARACTER SARA O
    $0E43: Result:= #$E3;  // THAI CHARACTER SARA AI MAIMUAN
    $0E44: Result:= #$E4;  // THAI CHARACTER SARA AI MAIMALAI
    $0E45: Result:= #$E5;  // THAI CHARACTER LAKKHANGYAO
    $0E46: Result:= #$E6;  // THAI CHARACTER MAIYAMOK
    $0E47: Result:= #$E7;  // THAI CHARACTER MAITAIKHU
    $0E48: Result:= #$E8;  // THAI CHARACTER MAI EK
    $0E49: Result:= #$E9;  // THAI CHARACTER MAI THO
    $0E4A: Result:= #$EA;  // THAI CHARACTER MAI TRI
    $0E4B: Result:= #$EB;  // THAI CHARACTER MAI CHATTAWA
    $0E4C: Result:= #$EC;  // THAI CHARACTER THANTHAKHAT
    $0E4D: Result:= #$ED;  // THAI CHARACTER NIKHAHIT
    $0E4E: Result:= #$EE;  // THAI CHARACTER YAMAKKAN
    $0E4F: Result:= #$EF;  // THAI CHARACTER FONGMAN
    $0E50: Result:= #$F0;  // THAI DIGIT ZERO
    $0E51: Result:= #$F1;  // THAI DIGIT ONE
    $0E52: Result:= #$F2;  // THAI DIGIT TWO
    $0E53: Result:= #$F3;  // THAI DIGIT THREE
    $0E54: Result:= #$F4;  // THAI DIGIT FOUR
    $0E55: Result:= #$F5;  // THAI DIGIT FIVE
    $0E56: Result:= #$F6;  // THAI DIGIT SIX
    $0E57: Result:= #$F7;  // THAI DIGIT SEVEN
    $0E58: Result:= #$F8;  // THAI DIGIT EIGHT
    $0E59: Result:= #$F9;  // THAI DIGIT NINE
    $0E5A: Result:= #$FA;  // THAI CHARACTER ANGKHANKHU
    $0E5B: Result:= #$FB;  // THAI CHARACTER KHOMUT
    $2013: Result:= #$96;  // EN DASH
    $2014: Result:= #$97;  // EM DASH
    $2018: Result:= #$91;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$92;  // RIGHT SINGLE QUOTATION MARK
    $201C: Result:= #$93;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$94;  // RIGHT DOUBLE QUOTATION MARK
    $2022: Result:= #$95;  // BULLET
    $2026: Result:= #$85;  // HORIZONTAL ELLIPSIS
    $20AC: Result:= #$80;  // EURO SIGN
  else
    raise EConvertError.CreateFmt('Invalid Windows-949 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp950Char(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A0: Result:= Char(I);
    $0E01: Result:= #$A1;  // THAI CHARACTER KO KAI
    $0E02: Result:= #$A2;  // THAI CHARACTER KHO KHAI
    $0E03: Result:= #$A3;  // THAI CHARACTER KHO KHUAT
    $0E04: Result:= #$A4;  // THAI CHARACTER KHO KHWAI
    $0E05: Result:= #$A5;  // THAI CHARACTER KHO KHON
    $0E06: Result:= #$A6;  // THAI CHARACTER KHO RAKHANG
    $0E07: Result:= #$A7;  // THAI CHARACTER NGO NGU
    $0E08: Result:= #$A8;  // THAI CHARACTER CHO CHAN
    $0E09: Result:= #$A9;  // THAI CHARACTER CHO CHING
    $0E0A: Result:= #$AA;  // THAI CHARACTER CHO CHANG
    $0E0B: Result:= #$AB;  // THAI CHARACTER SO SO
    $0E0C: Result:= #$AC;  // THAI CHARACTER CHO CHOE
    $0E0D: Result:= #$AD;  // THAI CHARACTER YO YING
    $0E0E: Result:= #$AE;  // THAI CHARACTER DO CHADA
    $0E0F: Result:= #$AF;  // THAI CHARACTER TO PATAK
    $0E10: Result:= #$B0;  // THAI CHARACTER THO THAN
    $0E11: Result:= #$B1;  // THAI CHARACTER THO NANGMONTHO
    $0E12: Result:= #$B2;  // THAI CHARACTER THO PHUTHAO
    $0E13: Result:= #$B3;  // THAI CHARACTER NO NEN
    $0E14: Result:= #$B4;  // THAI CHARACTER DO DEK
    $0E15: Result:= #$B5;  // THAI CHARACTER TO TAO
    $0E16: Result:= #$B6;  // THAI CHARACTER THO THUNG
    $0E17: Result:= #$B7;  // THAI CHARACTER THO THAHAN
    $0E18: Result:= #$B8;  // THAI CHARACTER THO THONG
    $0E19: Result:= #$B9;  // THAI CHARACTER NO NU
    $0E1A: Result:= #$BA;  // THAI CHARACTER BO BAIMAI
    $0E1B: Result:= #$BB;  // THAI CHARACTER PO PLA
    $0E1C: Result:= #$BC;  // THAI CHARACTER PHO PHUNG
    $0E1D: Result:= #$BD;  // THAI CHARACTER FO FA
    $0E1E: Result:= #$BE;  // THAI CHARACTER PHO PHAN
    $0E1F: Result:= #$BF;  // THAI CHARACTER FO FAN
    $0E20: Result:= #$C0;  // THAI CHARACTER PHO SAMPHAO
    $0E21: Result:= #$C1;  // THAI CHARACTER MO MA
    $0E22: Result:= #$C2;  // THAI CHARACTER YO YAK
    $0E23: Result:= #$C3;  // THAI CHARACTER RO RUA
    $0E24: Result:= #$C4;  // THAI CHARACTER RU
    $0E25: Result:= #$C5;  // THAI CHARACTER LO LING
    $0E26: Result:= #$C6;  // THAI CHARACTER LU
    $0E27: Result:= #$C7;  // THAI CHARACTER WO WAEN
    $0E28: Result:= #$C8;  // THAI CHARACTER SO SALA
    $0E29: Result:= #$C9;  // THAI CHARACTER SO RUSI
    $0E2A: Result:= #$CA;  // THAI CHARACTER SO SUA
    $0E2B: Result:= #$CB;  // THAI CHARACTER HO HIP
    $0E2C: Result:= #$CC;  // THAI CHARACTER LO CHULA
    $0E2D: Result:= #$CD;  // THAI CHARACTER O ANG
    $0E2E: Result:= #$CE;  // THAI CHARACTER HO NOKHUK
    $0E2F: Result:= #$CF;  // THAI CHARACTER PAIYANNOI
    $0E30: Result:= #$D0;  // THAI CHARACTER SARA A
    $0E31: Result:= #$D1;  // THAI CHARACTER MAI HAN-AKAT
    $0E32: Result:= #$D2;  // THAI CHARACTER SARA AA
    $0E33: Result:= #$D3;  // THAI CHARACTER SARA AM
    $0E34: Result:= #$D4;  // THAI CHARACTER SARA I
    $0E35: Result:= #$D5;  // THAI CHARACTER SARA II
    $0E36: Result:= #$D6;  // THAI CHARACTER SARA UE
    $0E37: Result:= #$D7;  // THAI CHARACTER SARA UEE
    $0E38: Result:= #$D8;  // THAI CHARACTER SARA U
    $0E39: Result:= #$D9;  // THAI CHARACTER SARA UU
    $0E3A: Result:= #$DA;  // THAI CHARACTER PHINTHU
    $0E3F: Result:= #$DF;  // THAI CURRENCY SYMBOL BAHT
    $0E40: Result:= #$E0;  // THAI CHARACTER SARA E
    $0E41: Result:= #$E1;  // THAI CHARACTER SARA AE
    $0E42: Result:= #$E2;  // THAI CHARACTER SARA O
    $0E43: Result:= #$E3;  // THAI CHARACTER SARA AI MAIMUAN
    $0E44: Result:= #$E4;  // THAI CHARACTER SARA AI MAIMALAI
    $0E45: Result:= #$E5;  // THAI CHARACTER LAKKHANGYAO
    $0E46: Result:= #$E6;  // THAI CHARACTER MAIYAMOK
    $0E47: Result:= #$E7;  // THAI CHARACTER MAITAIKHU
    $0E48: Result:= #$E8;  // THAI CHARACTER MAI EK
    $0E49: Result:= #$E9;  // THAI CHARACTER MAI THO
    $0E4A: Result:= #$EA;  // THAI CHARACTER MAI TRI
    $0E4B: Result:= #$EB;  // THAI CHARACTER MAI CHATTAWA
    $0E4C: Result:= #$EC;  // THAI CHARACTER THANTHAKHAT
    $0E4D: Result:= #$ED;  // THAI CHARACTER NIKHAHIT
    $0E4E: Result:= #$EE;  // THAI CHARACTER YAMAKKAN
    $0E4F: Result:= #$EF;  // THAI CHARACTER FONGMAN
    $0E50: Result:= #$F0;  // THAI DIGIT ZERO
    $0E51: Result:= #$F1;  // THAI DIGIT ONE
    $0E52: Result:= #$F2;  // THAI DIGIT TWO
    $0E53: Result:= #$F3;  // THAI DIGIT THREE
    $0E54: Result:= #$F4;  // THAI DIGIT FOUR
    $0E55: Result:= #$F5;  // THAI DIGIT FIVE
    $0E56: Result:= #$F6;  // THAI DIGIT SIX
    $0E57: Result:= #$F7;  // THAI DIGIT SEVEN
    $0E58: Result:= #$F8;  // THAI DIGIT EIGHT
    $0E59: Result:= #$F9;  // THAI DIGIT NINE
    $0E5A: Result:= #$FA;  // THAI CHARACTER ANGKHANKHU
    $0E5B: Result:= #$FB;  // THAI CHARACTER KHOMUT
    $2013: Result:= #$96;  // EN DASH
    $2014: Result:= #$97;  // EM DASH
    $2018: Result:= #$91;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$92;  // RIGHT SINGLE QUOTATION MARK
    $201C: Result:= #$93;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$94;  // RIGHT DOUBLE QUOTATION MARK
    $2022: Result:= #$95;  // BULLET
    $2026: Result:= #$85;  // HORIZONTAL ELLIPSIS
    $20AC: Result:= #$80;  // EURO SIGN
  else
    raise EConvertError.CreateFmt('Invalid Windows-950 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp1006Char(const I: longint): char;
begin
  case I of
    $0000..$00A0,$00AD: Result:= Char(I);
    $060C: Result:= #$AB;  // ARABIC COMMA
    $061B: Result:= #$AC;  // ARABIC SEMICOLON
    $061F: Result:= #$AE;  // ARABIC QUESTION MARK
    $06F0: Result:= #$A1;  // EXTENDED ARABIC-INDIC DIGIT ZERO
    $06F1: Result:= #$A2;  // EXTENDED ARABIC-INDIC DIGIT ONE
    $06F2: Result:= #$A3;  // EXTENDED ARABIC-INDIC DIGIT TWO
    $06F3: Result:= #$A4;  // EXTENDED ARABIC-INDIC DIGIT THREE
    $06F4: Result:= #$A5;  // EXTENDED ARABIC-INDIC DIGIT FOUR
    $06F5: Result:= #$A6;  // EXTENDED ARABIC-INDIC DIGIT FIVE
    $06F6: Result:= #$A7;  // EXTENDED ARABIC-INDIC DIGIT SIX
    $06F7: Result:= #$A8;  // EXTENDED ARABIC-INDIC DIGIT SEVEN
    $06F8: Result:= #$A9;  // EXTENDED ARABIC-INDIC DIGIT EIGHT
    $06F9: Result:= #$AA;  // EXTENDED ARABIC-INDIC DIGIT NINE
    $FB56: Result:= #$B5;  // ARABIC LETTER PEH ISOLATED FORM
    $FB58: Result:= #$B6;  // ARABIC LETTER PEH INITIAL FORM
    $FB66: Result:= #$BA;  // ARABIC LETTER TTEH ISOLATED FORM
    $FB68: Result:= #$BB;  // ARABIC LETTER TTEH INITIAL FORM
    $FB7A: Result:= #$C0;  // ARABIC LETTER TCHEH ISOLATED FORM
    $FB7C: Result:= #$C1;  // ARABIC LETTER TCHEH INITIAL FORM
    $FB84: Result:= #$C7;  // ARABIC LETTER DAHAL ISOLATED FORMN
    $FB8A: Result:= #$CC;  // ARABIC LETTER JEH ISOLATED FORM
    $FB8C: Result:= #$CA;  // ARABIC LETTER RREH ISOLATED FORM
    $FB92: Result:= #$E5;  // ARABIC LETTER GAF ISOLATED FORM
    $FB94: Result:= #$E6;  // ARABIC LETTER GAF INITIAL FORM
    $FB9E: Result:= #$EC;  // ARABIC LETTER NOON GHUNNA ISOLATED FORM
    $FBA6: Result:= #$F1;  // ARABIC LETTER HEH GOAL ISOLATED FORM
    $FBA8: Result:= #$F2;  // ARABIC LETTER HEH GOAL INITIAL FORM
    $FBA9: Result:= #$F3;  // ARABIC LETTER HEH GOAL MEDIAL FORM
    $FBAA: Result:= #$F4;  // ARABIC LETTER HEH DOACHASHMEE ISOLATED FORM
    $FBAE: Result:= #$FD;  // ARABIC LETTER YEH BARREE ISOLATED FORM
    $FBB0: Result:= #$FC;  // ARABIC LETTER YEH BARREE WITH HAMZA ABOVE ISOLATED FORM
    $FE7C: Result:= #$FE;  // ARABIC SHADDA ISOLATED FORM
    $FE7D: Result:= #$FF;  // ARABIC SHADDA MEDIAL FORM
    $FE80: Result:= #$F5;  // ARABIC LETTER HAMZA ISOLATED FORM
    $FE81: Result:= #$AF;  // ARABIC LETTER ALEF WITH MADDA ABOVE ISOLATED FORM
    $FE85: Result:= #$EF;  // ARABIC LETTER WAW WITH HAMZA ABOVE ISOLATED FORM
    $FE89: Result:= #$F6;  // ARABIC LETTER YEH WITH HAMZA ABOVE ISOLATED FORM
    $FE8A: Result:= #$F7;  // ARABIC LETTER YEH WITH HAMZA ABOVE FINAL FORM
    $FE8B: Result:= #$F8;  // ARABIC LETTER YEH WITH HAMZA ABOVE INITIAL FORM
    $FE8D: Result:= #$B0;  // ARABIC LETTER ALEF ISOLATED FORM
    $FE8E: Result:= #$B1;  // ARABIC LETTER ALEF FINAL FORM
//    $FE8E: Result:= #$B2;  // ARABIC LETTER ALEF FINAL FORM
    $FE8F: Result:= #$B3;  // ARABIC LETTER BEH ISOLATED FORM
    $FE91: Result:= #$B4;  // ARABIC LETTER BEH INITIAL FORM
    $FE93: Result:= #$B7;  // ARABIC LETTER TEH MARBUTA ISOLATED FORM
    $FE95: Result:= #$B8;  // ARABIC LETTER TEH ISOLATED FORM
    $FE97: Result:= #$B9;  // ARABIC LETTER TEH INITIAL FORM
    $FE99: Result:= #$BC;  // ARABIC LETTER THEH ISOLATED FORM
    $FE9B: Result:= #$BD;  // ARABIC LETTER THEH INITIAL FORM
    $FE9D: Result:= #$BE;  // ARABIC LETTER JEEM ISOLATED FORM
    $FE9F: Result:= #$BF;  // ARABIC LETTER JEEM INITIAL FORM
    $FEA1: Result:= #$C2;  // ARABIC LETTER HAH ISOLATED FORM
    $FEA3: Result:= #$C3;  // ARABIC LETTER HAH INITIAL FORM
    $FEA5: Result:= #$C4;  // ARABIC LETTER KHAH ISOLATED FORM
    $FEA7: Result:= #$C5;  // ARABIC LETTER KHAH INITIAL FORM
    $FEA9: Result:= #$C6;  // ARABIC LETTER DAL ISOLATED FORM
    $FEAB: Result:= #$C8;  // ARABIC LETTER THAL ISOLATED FORM
    $FEAD: Result:= #$C9;  // ARABIC LETTER REH ISOLATED FORM
    $FEAF: Result:= #$CB;  // ARABIC LETTER ZAIN ISOLATED FORM
    $FEB1: Result:= #$CD;  // ARABIC LETTER SEEN ISOLATED FORM
    $FEB3: Result:= #$CE;  // ARABIC LETTER SEEN INITIAL FORM
    $FEB5: Result:= #$CF;  // ARABIC LETTER SHEEN ISOLATED FORM
    $FEB7: Result:= #$D0;  // ARABIC LETTER SHEEN INITIAL FORM
    $FEB9: Result:= #$D1;  // ARABIC LETTER SAD ISOLATED FORM
    $FEBB: Result:= #$D2;  // ARABIC LETTER SAD INITIAL FORM
    $FEBD: Result:= #$D3;  // ARABIC LETTER DAD ISOLATED FORM
    $FEBF: Result:= #$D4;  // ARABIC LETTER DAD INITIAL FORM
    $FEC1: Result:= #$D5;  // ARABIC LETTER TAH ISOLATED FORM
    $FEC5: Result:= #$D6;  // ARABIC LETTER ZAH ISOLATED FORM
    $FEC9: Result:= #$D7;  // ARABIC LETTER AIN ISOLATED FORM
    $FECA: Result:= #$D8;  // ARABIC LETTER AIN FINAL FORM
    $FECB: Result:= #$D9;  // ARABIC LETTER AIN INITIAL FORM
    $FECC: Result:= #$DA;  // ARABIC LETTER AIN MEDIAL FORM
    $FECD: Result:= #$DB;  // ARABIC LETTER GHAIN ISOLATED FORM
    $FECE: Result:= #$DC;  // ARABIC LETTER GHAIN FINAL FORM
    $FECF: Result:= #$DD;  // ARABIC LETTER GHAIN INITIAL FORM
    $FED0: Result:= #$DE;  // ARABIC LETTER GHAIN MEDIAL FORM
    $FED1: Result:= #$DF;  // ARABIC LETTER FEH ISOLATED FORM
    $FED3: Result:= #$E0;  // ARABIC LETTER FEH INITIAL FORM
    $FED5: Result:= #$E1;  // ARABIC LETTER QAF ISOLATED FORM
    $FED7: Result:= #$E2;  // ARABIC LETTER QAF INITIAL FORM
    $FED9: Result:= #$E3;  // ARABIC LETTER KAF ISOLATED FORM
    $FEDB: Result:= #$E4;  // ARABIC LETTER KAF INITIAL FORM
    $FEDD: Result:= #$E7;  // ARABIC LETTER LAM ISOLATED FORM
    $FEDF: Result:= #$E8;  // ARABIC LETTER LAM INITIAL FORM
    $FEE0: Result:= #$E9;  // ARABIC LETTER LAM MEDIAL FORM
    $FEE1: Result:= #$EA;  // ARABIC LETTER MEEM ISOLATED FORM
    $FEE3: Result:= #$EB;  // ARABIC LETTER MEEM INITIAL FORM
    $FEE5: Result:= #$ED;  // ARABIC LETTER NOON ISOLATED FORM
    $FEE7: Result:= #$EE;  // ARABIC LETTER NOON INITIAL FORM
    $FEED: Result:= #$F0;  // ARABIC LETTER WAW ISOLATED FORM
    $FEF1: Result:= #$F9;  // ARABIC LETTER YEH ISOLATED FORM
    $FEF2: Result:= #$FA;  // ARABIC LETTER YEH FINAL FORM
    $FEF3: Result:= #$FB;  // ARABIC LETTER YEH INITIAL FORM
  else
    raise EConvertError.CreateFmt('Invalid cp1006 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp1026Char(const I: longint): char;
begin
  case I of
    $0000..$0003,$000B..$0013,$0018..$0019,$001C..$001F,$00B6:
      Result:= Char(I);
    $0004: Result:= #$37;  // END OF TRANSMISSION
    $0005: Result:= #$2D;  // ENQUIRY
    $0006: Result:= #$2E;  // ACKNOWLEDGE
    $0007: Result:= #$2F;  // BELL
    $0008: Result:= #$16;  // BACKSPACE
    $0009: Result:= #$05;  // HORIZONTAL TABULATION
    $000A: Result:= #$25;  // LINE FEED
    $0014: Result:= #$3C;  // DEVICE CONTROL FOUR
    $0015: Result:= #$3D;  // NEGATIVE ACKNOWLEDGE
    $0016: Result:= #$32;  // SYNCHRONOUS IDLE
    $0017: Result:= #$26;  // END OF TRANSMISSION BLOCK
    $001A: Result:= #$3F;  // SUBSTITUTE
    $001B: Result:= #$27;  // ESCAPE
    $0020: Result:= #$40;  // SPACE
    $0021: Result:= #$4F;  // EXCLAMATION MARK
    $0022: Result:= #$FC;  // QUOTATION MARK
    $0023: Result:= #$EC;  // NUMBER SIGN
    $0024: Result:= #$AD;  // DOLLAR SIGN
    $0025: Result:= #$6C;  // PERCENT SIGN
    $0026: Result:= #$50;  // AMPERSAND
    $0027: Result:= #$7D;  // APOSTROPHE
    $0028: Result:= #$4D;  // LEFT PARENTHESIS
    $0029: Result:= #$5D;  // RIGHT PARENTHESIS
    $002A: Result:= #$5C;  // ASTERISK
    $002B: Result:= #$4E;  // PLUS SIGN
    $002C: Result:= #$6B;  // COMMA
    $002D: Result:= #$60;  // HYPHEN-MINUS
    $002E: Result:= #$4B;  // FULL STOP
    $002F: Result:= #$61;  // SOLIDUS
    $0030: Result:= #$F0;  // DIGIT ZERO
    $0031: Result:= #$F1;  // DIGIT ONE
    $0032: Result:= #$F2;  // DIGIT TWO
    $0033: Result:= #$F3;  // DIGIT THREE
    $0034: Result:= #$F4;  // DIGIT FOUR
    $0035: Result:= #$F5;  // DIGIT FIVE
    $0036: Result:= #$F6;  // DIGIT SIX
    $0037: Result:= #$F7;  // DIGIT SEVEN
    $0038: Result:= #$F8;  // DIGIT EIGHT
    $0039: Result:= #$F9;  // DIGIT NINE
    $003A: Result:= #$7A;  // COLON
    $003B: Result:= #$5E;  // SEMICOLON
    $003C: Result:= #$4C;  // LESS-THAN SIGN
    $003D: Result:= #$7E;  // EQUALS SIGN
    $003E: Result:= #$6E;  // GREATER-THAN SIGN
    $003F: Result:= #$6F;  // QUESTION MARK
    $0040: Result:= #$AE;  // COMMERCIAL AT
    $0041: Result:= #$C1;  // LATIN CAPITAL LETTER A
    $0042: Result:= #$C2;  // LATIN CAPITAL LETTER B
    $0043: Result:= #$C3;  // LATIN CAPITAL LETTER C
    $0044: Result:= #$C4;  // LATIN CAPITAL LETTER D
    $0045: Result:= #$C5;  // LATIN CAPITAL LETTER E
    $0046: Result:= #$C6;  // LATIN CAPITAL LETTER F
    $0047: Result:= #$C7;  // LATIN CAPITAL LETTER G
    $0048: Result:= #$C8;  // LATIN CAPITAL LETTER H
    $0049: Result:= #$C9;  // LATIN CAPITAL LETTER I
    $004A: Result:= #$D1;  // LATIN CAPITAL LETTER J
    $004B: Result:= #$D2;  // LATIN CAPITAL LETTER K
    $004C: Result:= #$D3;  // LATIN CAPITAL LETTER L
    $004D: Result:= #$D4;  // LATIN CAPITAL LETTER M
    $004E: Result:= #$D5;  // LATIN CAPITAL LETTER N
    $004F: Result:= #$D6;  // LATIN CAPITAL LETTER O
    $0050: Result:= #$D7;  // LATIN CAPITAL LETTER P
    $0051: Result:= #$D8;  // LATIN CAPITAL LETTER Q
    $0052: Result:= #$D9;  // LATIN CAPITAL LETTER R
    $0053: Result:= #$E2;  // LATIN CAPITAL LETTER S
    $0054: Result:= #$E3;  // LATIN CAPITAL LETTER T
    $0055: Result:= #$E4;  // LATIN CAPITAL LETTER U
    $0056: Result:= #$E5;  // LATIN CAPITAL LETTER V
    $0057: Result:= #$E6;  // LATIN CAPITAL LETTER W
    $0058: Result:= #$E7;  // LATIN CAPITAL LETTER X
    $0059: Result:= #$E8;  // LATIN CAPITAL LETTER Y
    $005A: Result:= #$E9;  // LATIN CAPITAL LETTER Z
    $005B: Result:= #$68;  // LEFT SQUARE BRACKET
    $005C: Result:= #$DC;  // REVERSE SOLIDUS
    $005D: Result:= #$AC;  // RIGHT SQUARE BRACKET
    $005E: Result:= #$5F;  // CIRCUMFLEX ACCENT
    $005F: Result:= #$6D;  // LOW LINE
    $0060: Result:= #$8D;  // GRAVE ACCENT
    $0061: Result:= #$81;  // LATIN SMALL LETTER A
    $0062: Result:= #$82;  // LATIN SMALL LETTER B
    $0063: Result:= #$83;  // LATIN SMALL LETTER C
    $0064: Result:= #$84;  // LATIN SMALL LETTER D
    $0065: Result:= #$85;  // LATIN SMALL LETTER E
    $0066: Result:= #$86;  // LATIN SMALL LETTER F
    $0067: Result:= #$87;  // LATIN SMALL LETTER G
    $0068: Result:= #$88;  // LATIN SMALL LETTER H
    $0069: Result:= #$89;  // LATIN SMALL LETTER I
    $006A: Result:= #$91;  // LATIN SMALL LETTER J
    $006B: Result:= #$92;  // LATIN SMALL LETTER K
    $006C: Result:= #$93;  // LATIN SMALL LETTER L
    $006D: Result:= #$94;  // LATIN SMALL LETTER M
    $006E: Result:= #$95;  // LATIN SMALL LETTER N
    $006F: Result:= #$96;  // LATIN SMALL LETTER O
    $0070: Result:= #$97;  // LATIN SMALL LETTER P
    $0071: Result:= #$98;  // LATIN SMALL LETTER Q
    $0072: Result:= #$99;  // LATIN SMALL LETTER R
    $0073: Result:= #$A2;  // LATIN SMALL LETTER S
    $0074: Result:= #$A3;  // LATIN SMALL LETTER T
    $0075: Result:= #$A4;  // LATIN SMALL LETTER U
    $0076: Result:= #$A5;  // LATIN SMALL LETTER V
    $0077: Result:= #$A6;  // LATIN SMALL LETTER W
    $0078: Result:= #$A7;  // LATIN SMALL LETTER X
    $0079: Result:= #$A8;  // LATIN SMALL LETTER Y
    $007A: Result:= #$A9;  // LATIN SMALL LETTER Z
    $007B: Result:= #$48;  // LEFT CURLY BRACKET
    $007C: Result:= #$BB;  // VERTICAL LINE
    $007D: Result:= #$8C;  // RIGHT CURLY BRACKET
    $007E: Result:= #$CC;  // TILDE
    $007F: Result:= #$07;  // DELETE
    $0080: Result:= #$20;  // CONTROL
    $0081: Result:= #$21;  // CONTROL
    $0082: Result:= #$22;  // CONTROL
    $0083: Result:= #$23;  // CONTROL
    $0084: Result:= #$24;  // CONTROL
    $0085: Result:= #$15;  // CONTROL
    $0086: Result:= #$06;  // CONTROL
    $0087: Result:= #$17;  // CONTROL
    $0088: Result:= #$28;  // CONTROL
    $0089: Result:= #$29;  // CONTROL
    $008A: Result:= #$2A;  // CONTROL
    $008B: Result:= #$2B;  // CONTROL
    $008C: Result:= #$2C;  // CONTROL
    $008D: Result:= #$09;  // CONTROL
    $008E: Result:= #$0A;  // CONTROL
    $008F: Result:= #$1B;  // CONTROL
    $0090: Result:= #$30;  // CONTROL
    $0091: Result:= #$31;  // CONTROL
    $0092: Result:= #$1A;  // CONTROL
    $0093: Result:= #$33;  // CONTROL
    $0094: Result:= #$34;  // CONTROL
    $0095: Result:= #$35;  // CONTROL
    $0096: Result:= #$36;  // CONTROL
    $0097: Result:= #$08;  // CONTROL
    $0098: Result:= #$38;  // CONTROL
    $0099: Result:= #$39;  // CONTROL
    $009A: Result:= #$3A;  // CONTROL
    $009B: Result:= #$3B;  // CONTROL
    $009C: Result:= #$04;  // CONTROL
    $009D: Result:= #$14;  // CONTROL
    $009E: Result:= #$3E;  // CONTROL
    $009F: Result:= #$FF;  // CONTROL
    $00A0: Result:= #$41;  // NO-BREAK SPACE
    $00A1: Result:= #$AA;  // INVERTED EXCLAMATION MARK
    $00A2: Result:= #$B0;  // CENT SIGN
    $00A3: Result:= #$B1;  // POUND SIGN
    $00A4: Result:= #$9F;  // CURRENCY SIGN
    $00A5: Result:= #$B2;  // YEN SIGN
    $00A6: Result:= #$8E;  // BROKEN BAR
    $00A7: Result:= #$B5;  // SECTION SIGN
    $00A8: Result:= #$BD;  // DIAERESIS
    $00A9: Result:= #$B4;  // COPYRIGHT SIGN
    $00AA: Result:= #$9A;  // FEMININE ORDINAL INDICATOR
    $00AB: Result:= #$8A;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00AC: Result:= #$BA;  // NOT SIGN
    $00AD: Result:= #$CA;  // SOFT HYPHEN
    $00AE: Result:= #$AF;  // REGISTERED SIGN
    $00AF: Result:= #$BC;  // MACRON
    $00B0: Result:= #$90;  // DEGREE SIGN
    $00B1: Result:= #$8F;  // PLUS-MINUS SIGN
    $00B2: Result:= #$EA;  // SUPERSCRIPT TWO
    $00B3: Result:= #$FA;  // SUPERSCRIPT THREE
    $00B4: Result:= #$BE;  // ACUTE ACCENT
    $00B5: Result:= #$A0;  // MICRO SIGN
    $00B7: Result:= #$B3;  // MIDDLE DOT
    $00B8: Result:= #$9D;  // CEDILLA
    $00B9: Result:= #$DA;  // SUPERSCRIPT ONE
    $00BA: Result:= #$9B;  // MASCULINE ORDINAL INDICATOR
    $00BB: Result:= #$8B;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $00BC: Result:= #$B7;  // VULGAR FRACTION ONE QUARTER
    $00BD: Result:= #$B8;  // VULGAR FRACTION ONE HALF
    $00BE: Result:= #$B9;  // VULGAR FRACTION THREE QUARTERS
    $00BF: Result:= #$AB;  // INVERTED QUESTION MARK
    $00C0: Result:= #$64;  // LATIN CAPITAL LETTER A WITH GRAVE
    $00C1: Result:= #$65;  // LATIN CAPITAL LETTER A WITH ACUTE
    $00C2: Result:= #$62;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $00C3: Result:= #$66;  // LATIN CAPITAL LETTER A WITH TILDE
    $00C4: Result:= #$63;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $00C5: Result:= #$67;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $00C6: Result:= #$9E;  // LATIN CAPITAL LIGATURE AE
    $00C7: Result:= #$4A;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $00C8: Result:= #$74;  // LATIN CAPITAL LETTER E WITH GRAVE
    $00C9: Result:= #$71;  // LATIN CAPITAL LETTER E WITH ACUTE
    $00CA: Result:= #$72;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $00CB: Result:= #$73;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $00CC: Result:= #$78;  // LATIN CAPITAL LETTER I WITH GRAVE
    $00CD: Result:= #$75;  // LATIN CAPITAL LETTER I WITH ACUTE
    $00CE: Result:= #$76;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $00CF: Result:= #$77;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $00D1: Result:= #$69;  // LATIN CAPITAL LETTER N WITH TILDE
    $00D2: Result:= #$ED;  // LATIN CAPITAL LETTER O WITH GRAVE
    $00D3: Result:= #$EE;  // LATIN CAPITAL LETTER O WITH ACUTE
    $00D4: Result:= #$EB;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $00D5: Result:= #$EF;  // LATIN CAPITAL LETTER O WITH TILDE
    $00D6: Result:= #$7B;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $00D7: Result:= #$BF;  // MULTIPLICATION SIGN
    $00D8: Result:= #$80;  // LATIN CAPITAL LETTER O WITH STROKE
    $00D9: Result:= #$FD;  // LATIN CAPITAL LETTER U WITH GRAVE
    $00DA: Result:= #$FE;  // LATIN CAPITAL LETTER U WITH ACUTE
    $00DB: Result:= #$FB;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $00DC: Result:= #$7F;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $00DF: Result:= #$59;  // LATIN SMALL LETTER SHARP S (GERMAN)
    $00E0: Result:= #$44;  // LATIN SMALL LETTER A WITH GRAVE
    $00E1: Result:= #$45;  // LATIN SMALL LETTER A WITH ACUTE
    $00E2: Result:= #$42;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $00E3: Result:= #$46;  // LATIN SMALL LETTER A WITH TILDE
    $00E4: Result:= #$43;  // LATIN SMALL LETTER A WITH DIAERESIS
    $00E5: Result:= #$47;  // LATIN SMALL LETTER A WITH RING ABOVE
    $00E6: Result:= #$9C;  // LATIN SMALL LIGATURE AE
    $00E7: Result:= #$C0;  // LATIN SMALL LETTER C WITH CEDILLA
    $00E8: Result:= #$54;  // LATIN SMALL LETTER E WITH GRAVE
    $00E9: Result:= #$51;  // LATIN SMALL LETTER E WITH ACUTE
    $00EA: Result:= #$52;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $00EB: Result:= #$53;  // LATIN SMALL LETTER E WITH DIAERESIS
    $00EC: Result:= #$58;  // LATIN SMALL LETTER I WITH GRAVE
    $00ED: Result:= #$55;  // LATIN SMALL LETTER I WITH ACUTE
    $00EE: Result:= #$56;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $00EF: Result:= #$57;  // LATIN SMALL LETTER I WITH DIAERESIS
    $00F1: Result:= #$49;  // LATIN SMALL LETTER N WITH TILDE
    $00F2: Result:= #$CD;  // LATIN SMALL LETTER O WITH GRAVE
    $00F3: Result:= #$CE;  // LATIN SMALL LETTER O WITH ACUTE
    $00F4: Result:= #$CB;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $00F5: Result:= #$CF;  // LATIN SMALL LETTER O WITH TILDE
    $00F6: Result:= #$A1;  // LATIN SMALL LETTER O WITH DIAERESIS
    $00F7: Result:= #$E1;  // DIVISION SIGN
    $00F8: Result:= #$70;  // LATIN SMALL LETTER O WITH STROKE
    $00F9: Result:= #$DD;  // LATIN SMALL LETTER U WITH GRAVE
    $00FA: Result:= #$DE;  // LATIN SMALL LETTER U WITH ACUTE
    $00FB: Result:= #$DB;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $00FC: Result:= #$E0;  // LATIN SMALL LETTER U WITH DIAERESIS
    $00FF: Result:= #$DF;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $011E: Result:= #$5A;  // LATIN CAPITAL LETTER G WITH BREVE
    $011F: Result:= #$D0;  // LATIN SMALL LETTER G WITH BREVE
    $0130: Result:= #$5B;  // LATIN CAPITAL LETTER I WITH DOT ABOVE
    $0131: Result:= #$79;  // LATIN SMALL LETTER DOTLESS I
    $015E: Result:= #$7C;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $015F: Result:= #$6A;  // LATIN SMALL LETTER S WITH CEDILLA
  else
    raise EConvertError.CreateFmt('Invalid cp1026 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp1250Char(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A0,$00A4,$00A6..$00A9,$00AB..$00AE,$00B0..$00B1,
    $00B4..$00B8,$00BB,$00C1..$00C2,$00C4,$00C7,$00C9,$00CB,$00CD..$00CE,
    $00D3..$00D4,$00D6..$00D7,$00DA,$00DC..$00DD,$00DF,$00E1..$00E2,$00E4,
    $00E7,$00E9,$00EB,$00ED..$00EE,$00F3..$00F4,$00F6..$00F7,$00FA,
    $00FC..$00FD:
      Result:= Char(I);
    $0102: Result:= #$C3;  // LATIN CAPITAL LETTER A WITH BREVE
    $0103: Result:= #$E3;  // LATIN SMALL LETTER A WITH BREVE
    $0104: Result:= #$A5;  // LATIN CAPITAL LETTER A WITH OGONEK
    $0105: Result:= #$B9;  // LATIN SMALL LETTER A WITH OGONEK
    $0106: Result:= #$C6;  // LATIN CAPITAL LETTER C WITH ACUTE
    $0107: Result:= #$E6;  // LATIN SMALL LETTER C WITH ACUTE
    $010C: Result:= #$C8;  // LATIN CAPITAL LETTER C WITH CARON
    $010D: Result:= #$E8;  // LATIN SMALL LETTER C WITH CARON
    $010E: Result:= #$CF;  // LATIN CAPITAL LETTER D WITH CARON
    $010F: Result:= #$EF;  // LATIN SMALL LETTER D WITH CARON
    $0110: Result:= #$D0;  // LATIN CAPITAL LETTER D WITH STROKE
    $0111: Result:= #$F0;  // LATIN SMALL LETTER D WITH STROKE
    $0118: Result:= #$CA;  // LATIN CAPITAL LETTER E WITH OGONEK
    $0119: Result:= #$EA;  // LATIN SMALL LETTER E WITH OGONEK
    $011A: Result:= #$CC;  // LATIN CAPITAL LETTER E WITH CARON
    $011B: Result:= #$EC;  // LATIN SMALL LETTER E WITH CARON
    $0139: Result:= #$C5;  // LATIN CAPITAL LETTER L WITH ACUTE
    $013A: Result:= #$E5;  // LATIN SMALL LETTER L WITH ACUTE
    $013D: Result:= #$BC;  // LATIN CAPITAL LETTER L WITH CARON
    $013E: Result:= #$BE;  // LATIN SMALL LETTER L WITH CARON
    $0141: Result:= #$A3;  // LATIN CAPITAL LETTER L WITH STROKE
    $0142: Result:= #$B3;  // LATIN SMALL LETTER L WITH STROKE
    $0143: Result:= #$D1;  // LATIN CAPITAL LETTER N WITH ACUTE
    $0144: Result:= #$F1;  // LATIN SMALL LETTER N WITH ACUTE
    $0147: Result:= #$D2;  // LATIN CAPITAL LETTER N WITH CARON
    $0148: Result:= #$F2;  // LATIN SMALL LETTER N WITH CARON
    $0150: Result:= #$D5;  // LATIN CAPITAL LETTER O WITH DOUBLE ACUTE
    $0151: Result:= #$F5;  // LATIN SMALL LETTER O WITH DOUBLE ACUTE
    $0154: Result:= #$C0;  // LATIN CAPITAL LETTER R WITH ACUTE
    $0155: Result:= #$E0;  // LATIN SMALL LETTER R WITH ACUTE
    $0158: Result:= #$D8;  // LATIN CAPITAL LETTER R WITH CARON
    $0159: Result:= #$F8;  // LATIN SMALL LETTER R WITH CARON
    $015A: Result:= #$8C;  // LATIN CAPITAL LETTER S WITH ACUTE
    $015B: Result:= #$9C;  // LATIN SMALL LETTER S WITH ACUTE
    $015E: Result:= #$AA;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $015F: Result:= #$BA;  // LATIN SMALL LETTER S WITH CEDILLA
    $0160: Result:= #$8A;  // LATIN CAPITAL LETTER S WITH CARON
    $0161: Result:= #$9A;  // LATIN SMALL LETTER S WITH CARON
    $0162: Result:= #$DE;  // LATIN CAPITAL LETTER T WITH CEDILLA
    $0163: Result:= #$FE;  // LATIN SMALL LETTER T WITH CEDILLA
    $0164: Result:= #$8D;  // LATIN CAPITAL LETTER T WITH CARON
    $0165: Result:= #$9D;  // LATIN SMALL LETTER T WITH CARON
    $016E: Result:= #$D9;  // LATIN CAPITAL LETTER U WITH RING ABOVE
    $016F: Result:= #$F9;  // LATIN SMALL LETTER U WITH RING ABOVE
    $0170: Result:= #$DB;  // LATIN CAPITAL LETTER U WITH DOUBLE ACUTE
    $0171: Result:= #$FB;  // LATIN SMALL LETTER U WITH DOUBLE ACUTE
    $0179: Result:= #$8F;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $017A: Result:= #$9F;  // LATIN SMALL LETTER Z WITH ACUTE
    $017B: Result:= #$AF;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $017C: Result:= #$BF;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $017D: Result:= #$8E;  // LATIN CAPITAL LETTER Z WITH CARON
    $017E: Result:= #$9E;  // LATIN SMALL LETTER Z WITH CARON
    $02C7: Result:= #$A1;  // CARON
    $02D8: Result:= #$A2;  // BREVE
    $02D9: Result:= #$FF;  // DOT ABOVE
    $02DB: Result:= #$B2;  // OGONEK
    $02DD: Result:= #$BD;  // DOUBLE ACUTE ACCENT
    $2013: Result:= #$96;  // EN DASH
    $2014: Result:= #$97;  // EM DASH
    $2018: Result:= #$91;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$92;  // RIGHT SINGLE QUOTATION MARK
    $201A: Result:= #$82;  // SINGLE LOW-9 QUOTATION MARK
    $201C: Result:= #$93;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$94;  // RIGHT DOUBLE QUOTATION MARK
    $201E: Result:= #$84;  // DOUBLE LOW-9 QUOTATION MARK
    $2020: Result:= #$86;  // DAGGER
    $2021: Result:= #$87;  // DOUBLE DAGGER
    $2022: Result:= #$95;  // BULLET
    $2026: Result:= #$85;  // HORIZONTAL ELLIPSIS
    $2030: Result:= #$89;  // PER MILLE SIGN
    $2039: Result:= #$8B;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $203A: Result:= #$9B;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $20AC: Result:= #$80;  // EURO SIGN
    $2122: Result:= #$99;  // TRADE MARK SIGN
  else
    raise EConvertError.CreateFmt('Invalid Windows-1250 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp1251Char(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A0,$00A4,$00A6..$00A7,$00A9,$00AB..$00AE,$00B0..$00B1,
    $00B5..$00B7,$00BB:
      Result:= Char(I);
    $0401: Result:= #$A8;  // CYRILLIC CAPITAL LETTER IO
    $0402: Result:= #$80;  // CYRILLIC CAPITAL LETTER DJE
    $0403: Result:= #$81;  // CYRILLIC CAPITAL LETTER GJE
    $0404: Result:= #$AA;  // CYRILLIC CAPITAL LETTER UKRAINIAN IE
    $0405: Result:= #$BD;  // CYRILLIC CAPITAL LETTER DZE
    $0406: Result:= #$B2;  // CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I
    $0407: Result:= #$AF;  // CYRILLIC CAPITAL LETTER YI
    $0408: Result:= #$A3;  // CYRILLIC CAPITAL LETTER JE
    $0409: Result:= #$8A;  // CYRILLIC CAPITAL LETTER LJE
    $040A: Result:= #$8C;  // CYRILLIC CAPITAL LETTER NJE
    $040B: Result:= #$8E;  // CYRILLIC CAPITAL LETTER TSHE
    $040C: Result:= #$8D;  // CYRILLIC CAPITAL LETTER KJE
    $040E: Result:= #$A1;  // CYRILLIC CAPITAL LETTER SHORT U
    $040F: Result:= #$8F;  // CYRILLIC CAPITAL LETTER DZHE
    $0410: Result:= #$C0;  // CYRILLIC CAPITAL LETTER A
    $0411: Result:= #$C1;  // CYRILLIC CAPITAL LETTER BE
    $0412: Result:= #$C2;  // CYRILLIC CAPITAL LETTER VE
    $0413: Result:= #$C3;  // CYRILLIC CAPITAL LETTER GHE
    $0414: Result:= #$C4;  // CYRILLIC CAPITAL LETTER DE
    $0415: Result:= #$C5;  // CYRILLIC CAPITAL LETTER IE
    $0416: Result:= #$C6;  // CYRILLIC CAPITAL LETTER ZHE
    $0417: Result:= #$C7;  // CYRILLIC CAPITAL LETTER ZE
    $0418: Result:= #$C8;  // CYRILLIC CAPITAL LETTER I
    $0419: Result:= #$C9;  // CYRILLIC CAPITAL LETTER SHORT I
    $041A: Result:= #$CA;  // CYRILLIC CAPITAL LETTER KA
    $041B: Result:= #$CB;  // CYRILLIC CAPITAL LETTER EL
    $041C: Result:= #$CC;  // CYRILLIC CAPITAL LETTER EM
    $041D: Result:= #$CD;  // CYRILLIC CAPITAL LETTER EN
    $041E: Result:= #$CE;  // CYRILLIC CAPITAL LETTER O
    $041F: Result:= #$CF;  // CYRILLIC CAPITAL LETTER PE
    $0420: Result:= #$D0;  // CYRILLIC CAPITAL LETTER ER
    $0421: Result:= #$D1;  // CYRILLIC CAPITAL LETTER ES
    $0422: Result:= #$D2;  // CYRILLIC CAPITAL LETTER TE
    $0423: Result:= #$D3;  // CYRILLIC CAPITAL LETTER U
    $0424: Result:= #$D4;  // CYRILLIC CAPITAL LETTER EF
    $0425: Result:= #$D5;  // CYRILLIC CAPITAL LETTER HA
    $0426: Result:= #$D6;  // CYRILLIC CAPITAL LETTER TSE
    $0427: Result:= #$D7;  // CYRILLIC CAPITAL LETTER CHE
    $0428: Result:= #$D8;  // CYRILLIC CAPITAL LETTER SHA
    $0429: Result:= #$D9;  // CYRILLIC CAPITAL LETTER SHCHA
    $042A: Result:= #$DA;  // CYRILLIC CAPITAL LETTER HARD SIGN
    $042B: Result:= #$DB;  // CYRILLIC CAPITAL LETTER YERU
    $042C: Result:= #$DC;  // CYRILLIC CAPITAL LETTER SOFT SIGN
    $042D: Result:= #$DD;  // CYRILLIC CAPITAL LETTER E
    $042E: Result:= #$DE;  // CYRILLIC CAPITAL LETTER YU
    $042F: Result:= #$DF;  // CYRILLIC CAPITAL LETTER YA
    $0430: Result:= #$E0;  // CYRILLIC SMALL LETTER A
    $0431: Result:= #$E1;  // CYRILLIC SMALL LETTER BE
    $0432: Result:= #$E2;  // CYRILLIC SMALL LETTER VE
    $0433: Result:= #$E3;  // CYRILLIC SMALL LETTER GHE
    $0434: Result:= #$E4;  // CYRILLIC SMALL LETTER DE
    $0435: Result:= #$E5;  // CYRILLIC SMALL LETTER IE
    $0436: Result:= #$E6;  // CYRILLIC SMALL LETTER ZHE
    $0437: Result:= #$E7;  // CYRILLIC SMALL LETTER ZE
    $0438: Result:= #$E8;  // CYRILLIC SMALL LETTER I
    $0439: Result:= #$E9;  // CYRILLIC SMALL LETTER SHORT I
    $043A: Result:= #$EA;  // CYRILLIC SMALL LETTER KA
    $043B: Result:= #$EB;  // CYRILLIC SMALL LETTER EL
    $043C: Result:= #$EC;  // CYRILLIC SMALL LETTER EM
    $043D: Result:= #$ED;  // CYRILLIC SMALL LETTER EN
    $043E: Result:= #$EE;  // CYRILLIC SMALL LETTER O
    $043F: Result:= #$EF;  // CYRILLIC SMALL LETTER PE
    $0440: Result:= #$F0;  // CYRILLIC SMALL LETTER ER
    $0441: Result:= #$F1;  // CYRILLIC SMALL LETTER ES
    $0442: Result:= #$F2;  // CYRILLIC SMALL LETTER TE
    $0443: Result:= #$F3;  // CYRILLIC SMALL LETTER U
    $0444: Result:= #$F4;  // CYRILLIC SMALL LETTER EF
    $0445: Result:= #$F5;  // CYRILLIC SMALL LETTER HA
    $0446: Result:= #$F6;  // CYRILLIC SMALL LETTER TSE
    $0447: Result:= #$F7;  // CYRILLIC SMALL LETTER CHE
    $0448: Result:= #$F8;  // CYRILLIC SMALL LETTER SHA
    $0449: Result:= #$F9;  // CYRILLIC SMALL LETTER SHCHA
    $044A: Result:= #$FA;  // CYRILLIC SMALL LETTER HARD SIGN
    $044B: Result:= #$FB;  // CYRILLIC SMALL LETTER YERU
    $044C: Result:= #$FC;  // CYRILLIC SMALL LETTER SOFT SIGN
    $044D: Result:= #$FD;  // CYRILLIC SMALL LETTER E
    $044E: Result:= #$FE;  // CYRILLIC SMALL LETTER YU
    $044F: Result:= #$FF;  // CYRILLIC SMALL LETTER YA
    $0451: Result:= #$B8;  // CYRILLIC SMALL LETTER IO
    $0452: Result:= #$90;  // CYRILLIC SMALL LETTER DJE
    $0453: Result:= #$83;  // CYRILLIC SMALL LETTER GJE
    $0454: Result:= #$BA;  // CYRILLIC SMALL LETTER UKRAINIAN IE
    $0455: Result:= #$BE;  // CYRILLIC SMALL LETTER DZE
    $0456: Result:= #$B3;  // CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I
    $0457: Result:= #$BF;  // CYRILLIC SMALL LETTER YI
    $0458: Result:= #$BC;  // CYRILLIC SMALL LETTER JE
    $0459: Result:= #$9A;  // CYRILLIC SMALL LETTER LJE
    $045A: Result:= #$9C;  // CYRILLIC SMALL LETTER NJE
    $045B: Result:= #$9E;  // CYRILLIC SMALL LETTER TSHE
    $045C: Result:= #$9D;  // CYRILLIC SMALL LETTER KJE
    $045E: Result:= #$A2;  // CYRILLIC SMALL LETTER SHORT U
    $045F: Result:= #$9F;  // CYRILLIC SMALL LETTER DZHE
    $0490: Result:= #$A5;  // CYRILLIC CAPITAL LETTER GHE WITH UPTURN
    $0491: Result:= #$B4;  // CYRILLIC SMALL LETTER GHE WITH UPTURN
    $2013: Result:= #$96;  // EN DASH
    $2014: Result:= #$97;  // EM DASH
    $2018: Result:= #$91;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$92;  // RIGHT SINGLE QUOTATION MARK
    $201A: Result:= #$82;  // SINGLE LOW-9 QUOTATION MARK
    $201C: Result:= #$93;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$94;  // RIGHT DOUBLE QUOTATION MARK
    $201E: Result:= #$84;  // DOUBLE LOW-9 QUOTATION MARK
    $2020: Result:= #$86;  // DAGGER
    $2021: Result:= #$87;  // DOUBLE DAGGER
    $2022: Result:= #$95;  // BULLET
    $2026: Result:= #$85;  // HORIZONTAL ELLIPSIS
    $2030: Result:= #$89;  // PER MILLE SIGN
    $2039: Result:= #$8B;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $203A: Result:= #$9B;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $20AC: Result:= #$88;  // EURO SIGN
    $2116: Result:= #$B9;  // NUMERO SIGN
    $2122: Result:= #$99;  // TRADE MARK SIGN
  else
    raise EConvertError.CreateFmt('Invalid Windows-1251 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp1252Char(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A0..$00FF: Result:= Char(I);
    $0152: Result:= #$8C;  // LATIN CAPITAL LIGATURE OE
    $0153: Result:= #$9C;  // LATIN SMALL LIGATURE OE
    $0160: Result:= #$8A;  // LATIN CAPITAL LETTER S WITH CARON
    $0161: Result:= #$9A;  // LATIN SMALL LETTER S WITH CARON
    $0178: Result:= #$9F;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
    $017D: Result:= #$8E;  // LATIN CAPITAL LETTER Z WITH CARON
    $017E: Result:= #$9E;  // LATIN SMALL LETTER Z WITH CARON
    $0192: Result:= #$83;  // LATIN SMALL LETTER F WITH HOOK
    $02C6: Result:= #$88;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $02DC: Result:= #$98;  // SMALL TILDE
    $2013: Result:= #$96;  // EN DASH
    $2014: Result:= #$97;  // EM DASH
    $2018: Result:= #$91;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$92;  // RIGHT SINGLE QUOTATION MARK
    $201A: Result:= #$82;  // SINGLE LOW-9 QUOTATION MARK
    $201C: Result:= #$93;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$94;  // RIGHT DOUBLE QUOTATION MARK
    $201E: Result:= #$84;  // DOUBLE LOW-9 QUOTATION MARK
    $2020: Result:= #$86;  // DAGGER
    $2021: Result:= #$87;  // DOUBLE DAGGER
    $2022: Result:= #$95;  // BULLET
    $2026: Result:= #$85;  // HORIZONTAL ELLIPSIS
    $2030: Result:= #$89;  // PER MILLE SIGN
    $2039: Result:= #$8B;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $203A: Result:= #$9B;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $20AC: Result:= #$80;  // EURO SIGN
    $2122: Result:= #$99;  // TRADE MARK SIGN
  else
    raise EConvertError.CreateFmt('Invalid Windows-1252 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp1253Char(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A0,$00A3..$00A9,$00AB..$00AE,$00B0..$00B3,$00B5..$00B7,
    $00BB,$00BD:
      Result:= Char(I);
    $0192: Result:= #$83;  // LATIN SMALL LETTER F WITH HOOK
    $0384: Result:= #$B4;  // GREEK TONOS
    $0385: Result:= #$A1;  // GREEK DIALYTIKA TONOS
    $0386: Result:= #$A2;  // GREEK CAPITAL LETTER ALPHA WITH TONOS
    $0388: Result:= #$B8;  // GREEK CAPITAL LETTER EPSILON WITH TONOS
    $0389: Result:= #$B9;  // GREEK CAPITAL LETTER ETA WITH TONOS
    $038A: Result:= #$BA;  // GREEK CAPITAL LETTER IOTA WITH TONOS
    $038C: Result:= #$BC;  // GREEK CAPITAL LETTER OMICRON WITH TONOS
    $038E: Result:= #$BE;  // GREEK CAPITAL LETTER UPSILON WITH TONOS
    $038F: Result:= #$BF;  // GREEK CAPITAL LETTER OMEGA WITH TONOS
    $0390: Result:= #$C0;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA AND TONOS
    $0391: Result:= #$C1;  // GREEK CAPITAL LETTER ALPHA
    $0392: Result:= #$C2;  // GREEK CAPITAL LETTER BETA
    $0393: Result:= #$C3;  // GREEK CAPITAL LETTER GAMMA
    $0394: Result:= #$C4;  // GREEK CAPITAL LETTER DELTA
    $0395: Result:= #$C5;  // GREEK CAPITAL LETTER EPSILON
    $0396: Result:= #$C6;  // GREEK CAPITAL LETTER ZETA
    $0397: Result:= #$C7;  // GREEK CAPITAL LETTER ETA
    $0398: Result:= #$C8;  // GREEK CAPITAL LETTER THETA
    $0399: Result:= #$C9;  // GREEK CAPITAL LETTER IOTA
    $039A: Result:= #$CA;  // GREEK CAPITAL LETTER KAPPA
    $039B: Result:= #$CB;  // GREEK CAPITAL LETTER LAMDA
    $039C: Result:= #$CC;  // GREEK CAPITAL LETTER MU
    $039D: Result:= #$CD;  // GREEK CAPITAL LETTER NU
    $039E: Result:= #$CE;  // GREEK CAPITAL LETTER XI
    $039F: Result:= #$CF;  // GREEK CAPITAL LETTER OMICRON
    $03A0: Result:= #$D0;  // GREEK CAPITAL LETTER PI
    $03A1: Result:= #$D1;  // GREEK CAPITAL LETTER RHO
    $03A3: Result:= #$D3;  // GREEK CAPITAL LETTER SIGMA
    $03A4: Result:= #$D4;  // GREEK CAPITAL LETTER TAU
    $03A5: Result:= #$D5;  // GREEK CAPITAL LETTER UPSILON
    $03A6: Result:= #$D6;  // GREEK CAPITAL LETTER PHI
    $03A7: Result:= #$D7;  // GREEK CAPITAL LETTER CHI
    $03A8: Result:= #$D8;  // GREEK CAPITAL LETTER PSI
    $03A9: Result:= #$D9;  // GREEK CAPITAL LETTER OMEGA
    $03AA: Result:= #$DA;  // GREEK CAPITAL LETTER IOTA WITH DIALYTIKA
    $03AB: Result:= #$DB;  // GREEK CAPITAL LETTER UPSILON WITH DIALYTIKA
    $03AC: Result:= #$DC;  // GREEK SMALL LETTER ALPHA WITH TONOS
    $03AD: Result:= #$DD;  // GREEK SMALL LETTER EPSILON WITH TONOS
    $03AE: Result:= #$DE;  // GREEK SMALL LETTER ETA WITH TONOS
    $03AF: Result:= #$DF;  // GREEK SMALL LETTER IOTA WITH TONOS
    $03B0: Result:= #$E0;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA AND TONOS
    $03B1: Result:= #$E1;  // GREEK SMALL LETTER ALPHA
    $03B2: Result:= #$E2;  // GREEK SMALL LETTER BETA
    $03B3: Result:= #$E3;  // GREEK SMALL LETTER GAMMA
    $03B4: Result:= #$E4;  // GREEK SMALL LETTER DELTA
    $03B5: Result:= #$E5;  // GREEK SMALL LETTER EPSILON
    $03B6: Result:= #$E6;  // GREEK SMALL LETTER ZETA
    $03B7: Result:= #$E7;  // GREEK SMALL LETTER ETA
    $03B8: Result:= #$E8;  // GREEK SMALL LETTER THETA
    $03B9: Result:= #$E9;  // GREEK SMALL LETTER IOTA
    $03BA: Result:= #$EA;  // GREEK SMALL LETTER KAPPA
    $03BB: Result:= #$EB;  // GREEK SMALL LETTER LAMDA
    $03BC: Result:= #$EC;  // GREEK SMALL LETTER MU
    $03BD: Result:= #$ED;  // GREEK SMALL LETTER NU
    $03BE: Result:= #$EE;  // GREEK SMALL LETTER XI
    $03BF: Result:= #$EF;  // GREEK SMALL LETTER OMICRON
    $03C0: Result:= #$F0;  // GREEK SMALL LETTER PI
    $03C1: Result:= #$F1;  // GREEK SMALL LETTER RHO
    $03C2: Result:= #$F2;  // GREEK SMALL LETTER FINAL SIGMA
    $03C3: Result:= #$F3;  // GREEK SMALL LETTER SIGMA
    $03C4: Result:= #$F4;  // GREEK SMALL LETTER TAU
    $03C5: Result:= #$F5;  // GREEK SMALL LETTER UPSILON
    $03C6: Result:= #$F6;  // GREEK SMALL LETTER PHI
    $03C7: Result:= #$F7;  // GREEK SMALL LETTER CHI
    $03C8: Result:= #$F8;  // GREEK SMALL LETTER PSI
    $03C9: Result:= #$F9;  // GREEK SMALL LETTER OMEGA
    $03CA: Result:= #$FA;  // GREEK SMALL LETTER IOTA WITH DIALYTIKA
    $03CB: Result:= #$FB;  // GREEK SMALL LETTER UPSILON WITH DIALYTIKA
    $03CC: Result:= #$FC;  // GREEK SMALL LETTER OMICRON WITH TONOS
    $03CD: Result:= #$FD;  // GREEK SMALL LETTER UPSILON WITH TONOS
    $03CE: Result:= #$FE;  // GREEK SMALL LETTER OMEGA WITH TONOS
    $2013: Result:= #$96;  // EN DASH
    $2014: Result:= #$97;  // EM DASH
    $2015: Result:= #$AF;  // HORIZONTAL BAR
    $2018: Result:= #$91;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$92;  // RIGHT SINGLE QUOTATION MARK
    $201A: Result:= #$82;  // SINGLE LOW-9 QUOTATION MARK
    $201C: Result:= #$93;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$94;  // RIGHT DOUBLE QUOTATION MARK
    $201E: Result:= #$84;  // DOUBLE LOW-9 QUOTATION MARK
    $2020: Result:= #$86;  // DAGGER
    $2021: Result:= #$87;  // DOUBLE DAGGER
    $2022: Result:= #$95;  // BULLET
    $2026: Result:= #$85;  // HORIZONTAL ELLIPSIS
    $2030: Result:= #$89;  // PER MILLE SIGN
    $2039: Result:= #$8B;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $203A: Result:= #$9B;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $20AC: Result:= #$80;  // EURO SIGN
    $2122: Result:= #$99;  // TRADE MARK SIGN
  else
    raise EConvertError.CreateFmt('Invalid Windows-1253 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp1254Char(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A0..$00CF,$00D1..$00DC,$00DF..$00EF,$00F1..$00FC,$00FF:
      Result:= Char(I);
    $011E: Result:= #$D0;  // LATIN CAPITAL LETTER G WITH BREVE
    $011F: Result:= #$F0;  // LATIN SMALL LETTER G WITH BREVE
    $0130: Result:= #$DD;  // LATIN CAPITAL LETTER I WITH DOT ABOVE
    $0131: Result:= #$FD;  // LATIN SMALL LETTER DOTLESS I
    $0152: Result:= #$8C;  // LATIN CAPITAL LIGATURE OE
    $0153: Result:= #$9C;  // LATIN SMALL LIGATURE OE
    $015E: Result:= #$DE;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $015F: Result:= #$FE;  // LATIN SMALL LETTER S WITH CEDILLA
    $0160: Result:= #$8A;  // LATIN CAPITAL LETTER S WITH CARON
    $0161: Result:= #$9A;  // LATIN SMALL LETTER S WITH CARON
    $0178: Result:= #$9F;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
    $0192: Result:= #$83;  // LATIN SMALL LETTER F WITH HOOK
    $02C6: Result:= #$88;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $02DC: Result:= #$98;  // SMALL TILDE
    $2013: Result:= #$96;  // EN DASH
    $2014: Result:= #$97;  // EM DASH
    $2018: Result:= #$91;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$92;  // RIGHT SINGLE QUOTATION MARK
    $201A: Result:= #$82;  // SINGLE LOW-9 QUOTATION MARK
    $201C: Result:= #$93;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$94;  // RIGHT DOUBLE QUOTATION MARK
    $201E: Result:= #$84;  // DOUBLE LOW-9 QUOTATION MARK
    $2020: Result:= #$86;  // DAGGER
    $2021: Result:= #$87;  // DOUBLE DAGGER
    $2022: Result:= #$95;  // BULLET
    $2026: Result:= #$85;  // HORIZONTAL ELLIPSIS
    $2030: Result:= #$89;  // PER MILLE SIGN
    $2039: Result:= #$8B;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $203A: Result:= #$9B;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $20AC: Result:= #$80;  // EURO SIGN
    $2122: Result:= #$99;  // TRADE MARK SIGN
  else
    raise EConvertError.CreateFmt('Invalid Windows-1254 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp1255Char(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A0..$00A3,$00A5..$00A9,$00AB..$00B9,$00BB..$00BF:
      Result:= Char(I);
    $00D7: Result:= #$AA;  // MULTIPLICATION SIGN
    $00F7: Result:= #$BA;  // DIVISION SIGN
    $0192: Result:= #$83;  // LATIN SMALL LETTER F WITH HOOK
    $02C6: Result:= #$88;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $02DC: Result:= #$98;  // SMALL TILDE
    $05B0: Result:= #$C0;  // HEBREW POINT SHEVA
    $05B1: Result:= #$C1;  // HEBREW POINT HATAF SEGOL
    $05B2: Result:= #$C2;  // HEBREW POINT HATAF PATAH
    $05B3: Result:= #$C3;  // HEBREW POINT HATAF QAMATS
    $05B4: Result:= #$C4;  // HEBREW POINT HIRIQ
    $05B5: Result:= #$C5;  // HEBREW POINT TSERE
    $05B6: Result:= #$C6;  // HEBREW POINT SEGOL
    $05B7: Result:= #$C7;  // HEBREW POINT PATAH
    $05B8: Result:= #$C8;  // HEBREW POINT QAMATS
    $05B9: Result:= #$C9;  // HEBREW POINT HOLAM
    $05BB: Result:= #$CB;  // HEBREW POINT QUBUTS
    $05BC: Result:= #$CC;  // HEBREW POINT DAGESH OR MAPIQ
    $05BD: Result:= #$CD;  // HEBREW POINT METEG
    $05BE: Result:= #$CE;  // HEBREW PUNCTUATION MAQAF
    $05BF: Result:= #$CF;  // HEBREW POINT RAFE
    $05C0: Result:= #$D0;  // HEBREW PUNCTUATION PASEQ
    $05C1: Result:= #$D1;  // HEBREW POINT SHIN DOT
    $05C2: Result:= #$D2;  // HEBREW POINT SIN DOT
    $05C3: Result:= #$D3;  // HEBREW PUNCTUATION SOF PASUQ
    $05D0: Result:= #$E0;  // HEBREW LETTER ALEF
    $05D1: Result:= #$E1;  // HEBREW LETTER BET
    $05D2: Result:= #$E2;  // HEBREW LETTER GIMEL
    $05D3: Result:= #$E3;  // HEBREW LETTER DALET
    $05D4: Result:= #$E4;  // HEBREW LETTER HE
    $05D5: Result:= #$E5;  // HEBREW LETTER VAV
    $05D6: Result:= #$E6;  // HEBREW LETTER ZAYIN
    $05D7: Result:= #$E7;  // HEBREW LETTER HET
    $05D8: Result:= #$E8;  // HEBREW LETTER TET
    $05D9: Result:= #$E9;  // HEBREW LETTER YOD
    $05DA: Result:= #$EA;  // HEBREW LETTER FINAL KAF
    $05DB: Result:= #$EB;  // HEBREW LETTER KAF
    $05DC: Result:= #$EC;  // HEBREW LETTER LAMED
    $05DD: Result:= #$ED;  // HEBREW LETTER FINAL MEM
    $05DE: Result:= #$EE;  // HEBREW LETTER MEM
    $05DF: Result:= #$EF;  // HEBREW LETTER FINAL NUN
    $05E0: Result:= #$F0;  // HEBREW LETTER NUN
    $05E1: Result:= #$F1;  // HEBREW LETTER SAMEKH
    $05E2: Result:= #$F2;  // HEBREW LETTER AYIN
    $05E3: Result:= #$F3;  // HEBREW LETTER FINAL PE
    $05E4: Result:= #$F4;  // HEBREW LETTER PE
    $05E5: Result:= #$F5;  // HEBREW LETTER FINAL TSADI
    $05E6: Result:= #$F6;  // HEBREW LETTER TSADI
    $05E7: Result:= #$F7;  // HEBREW LETTER QOF
    $05E8: Result:= #$F8;  // HEBREW LETTER RESH
    $05E9: Result:= #$F9;  // HEBREW LETTER SHIN
    $05EA: Result:= #$FA;  // HEBREW LETTER TAV
    $05F0: Result:= #$D4;  // HEBREW LIGATURE YIDDISH DOUBLE VAV
    $05F1: Result:= #$D5;  // HEBREW LIGATURE YIDDISH VAV YOD
    $05F2: Result:= #$D6;  // HEBREW LIGATURE YIDDISH DOUBLE YOD
    $05F3: Result:= #$D7;  // HEBREW PUNCTUATION GERESH
    $05F4: Result:= #$D8;  // HEBREW PUNCTUATION GERSHAYIM
    $200E: Result:= #$FD;  // LEFT-TO-RIGHT MARK
    $200F: Result:= #$FE;  // RIGHT-TO-LEFT MARK
    $2013: Result:= #$96;  // EN DASH
    $2014: Result:= #$97;  // EM DASH
    $2018: Result:= #$91;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$92;  // RIGHT SINGLE QUOTATION MARK
    $201A: Result:= #$82;  // SINGLE LOW-9 QUOTATION MARK
    $201C: Result:= #$93;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$94;  // RIGHT DOUBLE QUOTATION MARK
    $201E: Result:= #$84;  // DOUBLE LOW-9 QUOTATION MARK
    $2020: Result:= #$86;  // DAGGER
    $2021: Result:= #$87;  // DOUBLE DAGGER
    $2022: Result:= #$95;  // BULLET
    $2026: Result:= #$85;  // HORIZONTAL ELLIPSIS
    $2030: Result:= #$89;  // PER MILLE SIGN
    $2039: Result:= #$8B;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $203A: Result:= #$9B;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $20AA: Result:= #$A4;  // NEW SHEQEL SIGN
    $20AC: Result:= #$80;  // EURO SIGN
    $2122: Result:= #$99;  // TRADE MARK SIGN
  else
    raise EConvertError.CreateFmt('Invalid Windows-1255 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp1256Char(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A0,$00A2..$00A9,$00AB..$00B9,$00BB..$00BE,$00D7,$00E0,
    $00E2,$00E7..$00EB,$00EE..$00EF,$00F4,$00F7,$00F9,$00FB..$00FC:
      Result:= Char(I);
    $0152: Result:= #$8C;  // LATIN CAPITAL LIGATURE OE
    $0153: Result:= #$9C;  // LATIN SMALL LIGATURE OE
    $0192: Result:= #$83;  // LATIN SMALL LETTER F WITH HOOK
    $02C6: Result:= #$88;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $060C: Result:= #$A1;  // ARABIC COMMA
    $061B: Result:= #$BA;  // ARABIC SEMICOLON
    $061F: Result:= #$BF;  // ARABIC QUESTION MARK
    $0621: Result:= #$C1;  // ARABIC LETTER HAMZA
    $0622: Result:= #$C2;  // ARABIC LETTER ALEF WITH MADDA ABOVE
    $0623: Result:= #$C3;  // ARABIC LETTER ALEF WITH HAMZA ABOVE
    $0624: Result:= #$C4;  // ARABIC LETTER WAW WITH HAMZA ABOVE
    $0625: Result:= #$C5;  // ARABIC LETTER ALEF WITH HAMZA BELOW
    $0626: Result:= #$C6;  // ARABIC LETTER YEH WITH HAMZA ABOVE
    $0627: Result:= #$C7;  // ARABIC LETTER ALEF
    $0628: Result:= #$C8;  // ARABIC LETTER BEH
    $0629: Result:= #$C9;  // ARABIC LETTER TEH MARBUTA
    $062A: Result:= #$CA;  // ARABIC LETTER TEH
    $062B: Result:= #$CB;  // ARABIC LETTER THEH
    $062C: Result:= #$CC;  // ARABIC LETTER JEEM
    $062D: Result:= #$CD;  // ARABIC LETTER HAH
    $062E: Result:= #$CE;  // ARABIC LETTER KHAH
    $062F: Result:= #$CF;  // ARABIC LETTER DAL
    $0630: Result:= #$D0;  // ARABIC LETTER THAL
    $0631: Result:= #$D1;  // ARABIC LETTER REH
    $0632: Result:= #$D2;  // ARABIC LETTER ZAIN
    $0633: Result:= #$D3;  // ARABIC LETTER SEEN
    $0634: Result:= #$D4;  // ARABIC LETTER SHEEN
    $0635: Result:= #$D5;  // ARABIC LETTER SAD
    $0636: Result:= #$D6;  // ARABIC LETTER DAD
    $0637: Result:= #$D8;  // ARABIC LETTER TAH
    $0638: Result:= #$D9;  // ARABIC LETTER ZAH
    $0639: Result:= #$DA;  // ARABIC LETTER AIN
    $063A: Result:= #$DB;  // ARABIC LETTER GHAIN
    $0640: Result:= #$DC;  // ARABIC TATWEEL
    $0641: Result:= #$DD;  // ARABIC LETTER FEH
    $0642: Result:= #$DE;  // ARABIC LETTER QAF
    $0643: Result:= #$DF;  // ARABIC LETTER KAF
    $0644: Result:= #$E1;  // ARABIC LETTER LAM
    $0645: Result:= #$E3;  // ARABIC LETTER MEEM
    $0646: Result:= #$E4;  // ARABIC LETTER NOON
    $0647: Result:= #$E5;  // ARABIC LETTER HEH
    $0648: Result:= #$E6;  // ARABIC LETTER WAW
    $0649: Result:= #$EC;  // ARABIC LETTER ALEF MAKSURA
    $064A: Result:= #$ED;  // ARABIC LETTER YEH
    $064B: Result:= #$F0;  // ARABIC FATHATAN
    $064C: Result:= #$F1;  // ARABIC DAMMATAN
    $064D: Result:= #$F2;  // ARABIC KASRATAN
    $064E: Result:= #$F3;  // ARABIC FATHA
    $064F: Result:= #$F5;  // ARABIC DAMMA
    $0650: Result:= #$F6;  // ARABIC KASRA
    $0651: Result:= #$F8;  // ARABIC SHADDA
    $0652: Result:= #$FA;  // ARABIC SUKUN
    $0679: Result:= #$8A;  // ARABIC LETTER TTEH
    $067E: Result:= #$81;  // ARABIC LETTER PEH
    $0686: Result:= #$8D;  // ARABIC LETTER TCHEH
    $0688: Result:= #$8F;  // ARABIC LETTER DDAL
    $0691: Result:= #$9A;  // ARABIC LETTER RREH
    $0698: Result:= #$8E;  // ARABIC LETTER JEH
    $06A9: Result:= #$98;  // ARABIC LETTER KEHEH
    $06AF: Result:= #$90;  // ARABIC LETTER GAF
    $06BA: Result:= #$9F;  // ARABIC LETTER NOON GHUNNA
    $06BE: Result:= #$AA;  // ARABIC LETTER HEH DOACHASHMEE
    $06C1: Result:= #$C0;  // ARABIC LETTER HEH GOAL
    $06D2: Result:= #$FF;  // ARABIC LETTER YEH BARREE
    $200C: Result:= #$9D;  // ZERO WIDTH NON-JOINER
    $200D: Result:= #$9E;  // ZERO WIDTH JOINER
    $200E: Result:= #$FD;  // LEFT-TO-RIGHT MARK
    $200F: Result:= #$FE;  // RIGHT-TO-LEFT MARK
    $2013: Result:= #$96;  // EN DASH
    $2014: Result:= #$97;  // EM DASH
    $2018: Result:= #$91;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$92;  // RIGHT SINGLE QUOTATION MARK
    $201A: Result:= #$82;  // SINGLE LOW-9 QUOTATION MARK
    $201C: Result:= #$93;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$94;  // RIGHT DOUBLE QUOTATION MARK
    $201E: Result:= #$84;  // DOUBLE LOW-9 QUOTATION MARK
    $2020: Result:= #$86;  // DAGGER
    $2021: Result:= #$87;  // DOUBLE DAGGER
    $2022: Result:= #$95;  // BULLET
    $2026: Result:= #$85;  // HORIZONTAL ELLIPSIS
    $2030: Result:= #$89;  // PER MILLE SIGN
    $2039: Result:= #$8B;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $203A: Result:= #$9B;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $20AC: Result:= #$80;  // EURO SIGN
    $2122: Result:= #$99;  // TRADE MARK SIGN
  else
    raise EConvertError.CreateFmt('Invalid Windows-1256 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp1257Char(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A0,$00A2..$00A4,$00A6..$00A7,$00A9,$00AB..$00AE,
    $00B0..$00B7,$00B9,$00BB..$00BE,$00C4..$00C5,$00C9,$00D3,$00D5..$00D7,
    $00DC,$00DF,$00E4..$00E5,$00E9,$00F3,$00F5..$00F7,$00FC:
      Result:= Char(I);
    $00A8: Result:= #$8D;  // DIAERESIS
    $00AF: Result:= #$9D;  // MACRON
    $00B8: Result:= #$8F;  // CEDILLA
    $00C6: Result:= #$AF;  // LATIN CAPITAL LETTER AE
    $00D8: Result:= #$A8;  // LATIN CAPITAL LETTER O WITH STROKE
    $00E6: Result:= #$BF;  // LATIN SMALL LETTER AE
    $00F8: Result:= #$B8;  // LATIN SMALL LETTER O WITH STROKE
    $0100: Result:= #$C2;  // LATIN CAPITAL LETTER A WITH MACRON
    $0101: Result:= #$E2;  // LATIN SMALL LETTER A WITH MACRON
    $0104: Result:= #$C0;  // LATIN CAPITAL LETTER A WITH OGONEK
    $0105: Result:= #$E0;  // LATIN SMALL LETTER A WITH OGONEK
    $0106: Result:= #$C3;  // LATIN CAPITAL LETTER C WITH ACUTE
    $0107: Result:= #$E3;  // LATIN SMALL LETTER C WITH ACUTE
    $010C: Result:= #$C8;  // LATIN CAPITAL LETTER C WITH CARON
    $010D: Result:= #$E8;  // LATIN SMALL LETTER C WITH CARON
    $0112: Result:= #$C7;  // LATIN CAPITAL LETTER E WITH MACRON
    $0113: Result:= #$E7;  // LATIN SMALL LETTER E WITH MACRON
    $0116: Result:= #$CB;  // LATIN CAPITAL LETTER E WITH DOT ABOVE
    $0117: Result:= #$EB;  // LATIN SMALL LETTER E WITH DOT ABOVE
    $0118: Result:= #$C6;  // LATIN CAPITAL LETTER E WITH OGONEK
    $0119: Result:= #$E6;  // LATIN SMALL LETTER E WITH OGONEK
    $0122: Result:= #$CC;  // LATIN CAPITAL LETTER G WITH CEDILLA
    $0123: Result:= #$EC;  // LATIN SMALL LETTER G WITH CEDILLA
    $012A: Result:= #$CE;  // LATIN CAPITAL LETTER I WITH MACRON
    $012B: Result:= #$EE;  // LATIN SMALL LETTER I WITH MACRON
    $012E: Result:= #$C1;  // LATIN CAPITAL LETTER I WITH OGONEK
    $012F: Result:= #$E1;  // LATIN SMALL LETTER I WITH OGONEK
    $0136: Result:= #$CD;  // LATIN CAPITAL LETTER K WITH CEDILLA
    $0137: Result:= #$ED;  // LATIN SMALL LETTER K WITH CEDILLA
    $013B: Result:= #$CF;  // LATIN CAPITAL LETTER L WITH CEDILLA
    $013C: Result:= #$EF;  // LATIN SMALL LETTER L WITH CEDILLA
    $0141: Result:= #$D9;  // LATIN CAPITAL LETTER L WITH STROKE
    $0142: Result:= #$F9;  // LATIN SMALL LETTER L WITH STROKE
    $0143: Result:= #$D1;  // LATIN CAPITAL LETTER N WITH ACUTE
    $0144: Result:= #$F1;  // LATIN SMALL LETTER N WITH ACUTE
    $0145: Result:= #$D2;  // LATIN CAPITAL LETTER N WITH CEDILLA
    $0146: Result:= #$F2;  // LATIN SMALL LETTER N WITH CEDILLA
    $014C: Result:= #$D4;  // LATIN CAPITAL LETTER O WITH MACRON
    $014D: Result:= #$F4;  // LATIN SMALL LETTER O WITH MACRON
    $0156: Result:= #$AA;  // LATIN CAPITAL LETTER R WITH CEDILLA
    $0157: Result:= #$BA;  // LATIN SMALL LETTER R WITH CEDILLA
    $015A: Result:= #$DA;  // LATIN CAPITAL LETTER S WITH ACUTE
    $015B: Result:= #$FA;  // LATIN SMALL LETTER S WITH ACUTE
    $0160: Result:= #$D0;  // LATIN CAPITAL LETTER S WITH CARON
    $0161: Result:= #$F0;  // LATIN SMALL LETTER S WITH CARON
    $016A: Result:= #$DB;  // LATIN CAPITAL LETTER U WITH MACRON
    $016B: Result:= #$FB;  // LATIN SMALL LETTER U WITH MACRON
    $0172: Result:= #$D8;  // LATIN CAPITAL LETTER U WITH OGONEK
    $0173: Result:= #$F8;  // LATIN SMALL LETTER U WITH OGONEK
    $0179: Result:= #$CA;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $017A: Result:= #$EA;  // LATIN SMALL LETTER Z WITH ACUTE
    $017B: Result:= #$DD;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $017C: Result:= #$FD;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $017D: Result:= #$DE;  // LATIN CAPITAL LETTER Z WITH CARON
    $017E: Result:= #$FE;  // LATIN SMALL LETTER Z WITH CARON
    $02C7: Result:= #$8E;  // CARON
    $02D9: Result:= #$FF;  // DOT ABOVE
    $02DB: Result:= #$9E;  // OGONEK
    $2013: Result:= #$96;  // EN DASH
    $2014: Result:= #$97;  // EM DASH
    $2018: Result:= #$91;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$92;  // RIGHT SINGLE QUOTATION MARK
    $201A: Result:= #$82;  // SINGLE LOW-9 QUOTATION MARK
    $201C: Result:= #$93;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$94;  // RIGHT DOUBLE QUOTATION MARK
    $201E: Result:= #$84;  // DOUBLE LOW-9 QUOTATION MARK
    $2020: Result:= #$86;  // DAGGER
    $2021: Result:= #$87;  // DOUBLE DAGGER
    $2022: Result:= #$95;  // BULLET
    $2026: Result:= #$85;  // HORIZONTAL ELLIPSIS
    $2030: Result:= #$89;  // PER MILLE SIGN
    $2039: Result:= #$8B;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $203A: Result:= #$9B;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $20AC: Result:= #$80;  // EURO SIGN
    $2122: Result:= #$99;  // TRADE MARK SIGN
  else
    raise EConvertError.CreateFmt('Invalid Windows-1257 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToCp1258Char(const I: longint): char;
begin
  case I of
    $0000..$007F,$00A0..$00C2,$00C4..$00CB,$00CD..$00CF,$00D1,$00D3..$00D4,
    $00D6..$00DC,$00DF..$00E2,$00E4..$00EB,$00ED..$00EF,$00F1,$00F3..$00F4,
    $00F6..$00FC,$00FF:
      Result:= Char(I);
    $0102: Result:= #$C3;  // LATIN CAPITAL LETTER A WITH BREVE
    $0103: Result:= #$E3;  // LATIN SMALL LETTER A WITH BREVE
    $0110: Result:= #$D0;  // LATIN CAPITAL LETTER D WITH STROKE
    $0111: Result:= #$F0;  // LATIN SMALL LETTER D WITH STROKE
    $0152: Result:= #$8C;  // LATIN CAPITAL LIGATURE OE
    $0153: Result:= #$9C;  // LATIN SMALL LIGATURE OE
    $0178: Result:= #$9F;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
    $0192: Result:= #$83;  // LATIN SMALL LETTER F WITH HOOK
    $01A0: Result:= #$D5;  // LATIN CAPITAL LETTER O WITH HORN
    $01A1: Result:= #$F5;  // LATIN SMALL LETTER O WITH HORN
    $01AF: Result:= #$DD;  // LATIN CAPITAL LETTER U WITH HORN
    $01B0: Result:= #$FD;  // LATIN SMALL LETTER U WITH HORN
    $02C6: Result:= #$88;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $02DC: Result:= #$98;  // SMALL TILDE
    $0300: Result:= #$CC;  // COMBINING GRAVE ACCENT
    $0301: Result:= #$EC;  // COMBINING ACUTE ACCENT
    $0303: Result:= #$DE;  // COMBINING TILDE
    $0309: Result:= #$D2;  // COMBINING HOOK ABOVE
    $0323: Result:= #$F2;  // COMBINING DOT BELOW
    $2013: Result:= #$96;  // EN DASH
    $2014: Result:= #$97;  // EM DASH
    $2018: Result:= #$91;  // LEFT SINGLE QUOTATION MARK
    $2019: Result:= #$92;  // RIGHT SINGLE QUOTATION MARK
    $201A: Result:= #$82;  // SINGLE LOW-9 QUOTATION MARK
    $201C: Result:= #$93;  // LEFT DOUBLE QUOTATION MARK
    $201D: Result:= #$94;  // RIGHT DOUBLE QUOTATION MARK
    $201E: Result:= #$84;  // DOUBLE LOW-9 QUOTATION MARK
    $2020: Result:= #$86;  // DAGGER
    $2021: Result:= #$87;  // DOUBLE DAGGER
    $2022: Result:= #$95;  // BULLET
    $2026: Result:= #$85;  // HORIZONTAL ELLIPSIS
    $2030: Result:= #$89;  // PER MILLE SIGN
    $2039: Result:= #$8B;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $203A: Result:= #$9B;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $20AB: Result:= #$FE;  // DONG SIGN
    $20AC: Result:= #$80;  // EURO SIGN
    $2122: Result:= #$99;  // TRADE MARK SIGN
  else
    raise EConvertError.CreateFmt('Invalid Windows-1258 sequence of Unicode code point %d',[I]);
  end;
end;

function UTF16ToUS_ASCIIStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToUS_ASCIIChar);
end;

function UTF16ToIso8859_1Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToIso8859_1Char);
end;

function UTF16ToIso8859_2Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToIso8859_2Char);
end;

function UTF16ToIso8859_3Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToIso8859_3Char);
end;

function UTF16ToIso8859_4Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToIso8859_4Char);
end;

function UTF16ToIso8859_5Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToIso8859_5Char);
end;

function UTF16ToIso8859_6Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToIso8859_6Char);
end;

function UTF16ToIso8859_7Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToIso8859_7Char);
end;

function UTF16ToIso8859_8Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToIso8859_8Char);
end;

function UTF16ToIso8859_9Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToIso8859_9Char);
end;

function UTF16ToIso8859_10Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToIso8859_10Char);
end;

function UTF16ToIso8859_13Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToIso8859_13Char);
end;

function UTF16ToIso8859_14Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToIso8859_14Char);
end;

function UTF16ToIso8859_15Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToIso8859_15Char);
end;

function UTF16ToKOI8_RStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToKOI8_RChar);
end;

function UTF16ToJIS_X0201Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToJIS_X0201Char);
end;

function UTF16ToNextStepStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToNextStepChar);
end;

function UTF16ToCp10000_MacRomanStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp10000_MacRomanChar);
end;

function UTF16ToCp10006_MacGreekStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp10006_MacGreekChar);
end;

function UTF16ToCp10007_MacCyrillicStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp10007_MacCyrillicChar);
end;

function UTF16ToCp10029_MacLatin2Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp10029_MacLatin2Char);
end;

function UTF16ToCp10079_MacIcelandicStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp10079_MacIcelandicChar);
end;

function UTF16ToCp10081_MacTurkishStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp10081_MacTurkishChar);
end;

function UTF16ToCp037Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp037Char);
end;

function UTF16ToCp424Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp424Char);
end;

function UTF16ToCp437Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp437Char);
end;

function UTF16ToCp437_DOSLatinUSStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp437_DOSLatinUSChar);
end;

function UTF16ToCp500Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp500Char);
end;

function UTF16ToCp737_DOSGreekStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp737_DOSGreekChar);
end;

function UTF16ToCp775_DOSBaltRimStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp775_DOSBaltRimChar);
end;

function UTF16ToCp850Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp850Char);
end;

function UTF16ToCp850_DOSLatin1Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp850_DOSLatin1Char);
end;

function UTF16ToCp852Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp852Char);
end;

function UTF16ToCp852_DOSLatin2Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp852_DOSLatin2Char);
end;

function UTF16ToCp855Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp855Char);
end;

function UTF16ToCp855_DOSCyrillicStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp855_DOSCyrillicChar);
end;

function UTF16ToCp856_Hebrew_PCStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp856_Hebrew_PCChar);
end;

function UTF16ToCp857Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp857Char);
end;

function UTF16ToCp857_DOSTurkishStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp857_DOSTurkishChar);
end;

function UTF16ToCp860Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp860Char);
end;

function UTF16ToCp860_DOSPortugueseStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp860_DOSPortugueseChar);
end;

function UTF16ToCp861Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp861Char);
end;

function UTF16ToCp861_DOSIcelandicStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp861_DOSIcelandicChar);
end;

function UTF16ToCp862Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp862Char);
end;

function UTF16ToCp862_DOSHebrewStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp862_DOSHebrewChar);
end;

function UTF16ToCp863Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp863Char);
end;

function UTF16ToCp863_DOSCanadaFStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp863_DOSCanadaFChar);
end;

function UTF16ToCp864Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp864Char);
end;

function UTF16ToCp864_DOSArabicStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp864_DOSArabicChar);
end;

function UTF16ToCp865Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp865Char);
end;

function UTF16ToCp865_DOSNordicStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp865_DOSNordicChar);
end;

function UTF16ToCp866Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp866Char);
end;

function UTF16ToCp866_DOSCyrillicRussianStr(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp866_DOSCyrillicRussianChar);
end;

function UTF16ToCp869Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp869Char);
end;

function UTF16ToCp869_DOSGreek2Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp869_DOSGreek2Char);
end;

function UTF16ToCp874Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp874Char);
end;

function UTF16ToCp875Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp875Char);
end;

function UTF16ToCp932Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp932Char);
end;

function UTF16ToCp936Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp936Char);
end;

function UTF16ToCp949Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp949Char);
end;

function UTF16ToCp950Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp950Char);
end;

function UTF16ToCp1006Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp1006Char);
end;

function UTF16ToCp1026Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp1026Char);
end;

function UTF16ToCp1250Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp1250Char);
end;

function UTF16ToCp1251Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp1251Char);
end;

function UTF16ToCp1252Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp1252Char);
end;

function UTF16ToCp1253Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp1253Char);
end;

function UTF16ToCp1254Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp1254Char);
end;

function UTF16ToCp1255Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp1255Char);
end;

function UTF16ToCp1256Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp1256Char);
end;

function UTF16ToCp1257Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp1257Char);
end;

function UTF16ToCp1258Str(const S: WideString): string;
begin
  Result:= UTF16WideStrToStr(S, UTF16ToCp1258Char);
end;

function Utf16HighSurrogate(const value: integer): WideChar;
var
  value2: word;
begin
  value2:= ($D7C0 + ( value shr 10 ));
  Result:= WideChar(value2);
end;

function Utf16LowSurrogate(const value: integer): WideChar;
var
  value2: word;
begin
  value2:= ($DC00 XOR (value AND $3FF));
  Result:= WideChar(value2);
end;

function Utf16SurrogateToInt(const highSurrogate, lowSurrogate: WideChar): integer;
begin
  Result:=  ( (word(highSurrogate) -  $D7C0) shl 10 )
          + (  word(lowSurrogate) XOR $DC00  );
end;

function IsUtf16HighSurrogate(const S: WideChar): boolean;
begin
  Case Word(S) of
    $D800..$DBFF: Result:= true;
  else
    Result:= false;
  end;
end;

function IsUtf16LowSurrogate(const S: WideChar): boolean;
begin
  Case Word(S) of
    $DC00..$DFFF: Result:= true;
  else
    Result:= false;
  end;
end;



{ TCSMIB }

constructor TCSMIB.Create(AOwner: TComponent);
begin
  inherited;
  Enum:= 3;
end;

procedure TCSMIB.DoChange(Sender: TObject);
begin
  if assigned(FOnChange)
    then FOnChange(Sender);
end;

procedure TCSMIB.DoChanging(Sender: TObject; NewEnum: integer;
  var AllowChange: Boolean);
begin
  if assigned(FOnChanging)
    then FOnChanging(Sender,NewEnum,AllowChange);
end;

function TCSMIB.GetAlias(i: integer): string;
begin
  case FEnum of
    3: case i of
      0: Result:= 'ANSI_X3.4-1968';
      1: Result:= 'iso-ir-6';
      2: Result:= 'ANSI_X3.4-1986';
      3: Result:= 'ISO_646.irv:1991';
      4: Result:= 'ASCII';
      5: Result:= 'ISO646-US';
      6: Result:= 'US-ASCII';
      7: Result:= 'us';
      8: Result:= 'IBM367';
      9: Result:= 'cp367';
      10: Result:= 'csASCII';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    4: case i of
      0: Result:= 'ISO_8859-1:1987';
      1: Result:= 'iso-ir-100';
      2: Result:= 'ISO_8859-1';
      3: Result:= 'ISO-8859-1';
      4: Result:= 'latin1';
      5: Result:= 'l1';
      6: Result:= 'IBM819';
      7: Result:= 'CP819';
      8: Result:= 'csISOLatin1';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    5: case i of
      0: Result:= 'ISO_8859-2:1987';
      1: Result:= 'iso-ir-101';
      2: Result:= 'ISO_8859-2';
      3: Result:= 'ISO-8859-2';
      4: Result:= 'latin2';
      5: Result:= 'l2';
      6: Result:= 'csISOLatin2';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    6: case i of
      0: Result:= 'ISO_8859-3:1988';
      1: Result:= 'iso-ir-109';
      2: Result:= 'ISO_8859-3';
      3: Result:= 'ISO-8859-3';
      4: Result:= 'latin3';
      5: Result:= 'l3';
      6: Result:= 'csISOLatin3';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    7: case i of
      0: Result:= 'ISO_8859-4:1988';
      1: Result:= 'iso-ir-110';
      2: Result:= 'ISO_8859-4';
      3: Result:= 'ISO-8859-4';
      4: Result:= 'latin4';
      5: Result:= 'l4';
      6: Result:= 'csISOLatin4';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    8: case i of
      0: Result:= 'ISO_8859-5:1988';
      1: Result:= 'iso-ir-144';
      2: Result:= 'ISO_8859-5';
      3: Result:= 'ISO-8859-5';
      4: Result:= 'cyrillic';
      5: Result:= 'csISOLatinCyrillic';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    9: case i of
      0: Result:= 'ISO_8859-6:1987';
      1: Result:= 'iso-ir-127';
      2: Result:= 'ISO_8859-6';
      3: Result:= 'ISO-8859-6';
      4: Result:= 'ECMA-114';
      5: Result:= 'ASMO-708';
      6: Result:= 'arabic';
      7: Result:= 'csISOLatinArabic';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    10: case i of
      0: Result:= 'ISO_8859-7:1987';
      1: Result:= 'iso-ir-126';
      2: Result:= 'ISO_8859-7';
      3: Result:= 'ISO-8859-7';
      4: Result:= 'ELOT_928';
      5: Result:= 'ECMA-118';
      6: Result:= 'greek';
      7: Result:= 'greek8';
      8: Result:= 'csISOLatinGreek';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    11: case i of
      0: Result:= 'ISO_8859-8:1988';
      1: Result:= 'iso-ir-138';
      2: Result:= 'ISO_8859-8';
      3: Result:= 'ISO-8859-8';
      4: Result:= 'hebrew';
      5: Result:= 'csISOLatinHebrew';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    12: case i of
      0: Result:= 'ISO_8859-9:1989';
      1: Result:= 'iso-ir-148';
      2: Result:= 'ISO_8859-9';
      3: Result:= 'ISO-8859-9';
      4: Result:= 'latin5';
      5: Result:= 'l5';
      6: Result:= 'csISOLatin5';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    13: case i of
      0: Result:= 'ISO_8859-10';
      1: Result:= 'iso-ir-157';
      2: Result:= 'l6';
      3: Result:= 'ISO-8859-10:1992';
      4: Result:= 'csISOLatin6';
      5: Result:= 'latin6';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    14: case i of
      0: Result:= 'ISO_6937-2-add';
      1: Result:= 'iso-ir-142';
      2: Result:= 'csISOTextComm';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    15: case i of
      0: Result:= 'JIS_X0201';
      1: Result:= 'X0201';
      2: Result:= 'csHalfWidthKatakana';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    16: case i of
      0: Result:= 'JIS_Encoding';
      1: Result:= 'csJISEncoding';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    17: case i of
      0: Result:= 'Shift_JIS';
      1: Result:= 'MS_Kanji';
      2: Result:= 'csShiftJIS';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    18: case i of
      0: Result:= 'Extended_UNIX_Code_Packed_Format_for_Japanese';
      1: Result:= 'csEUCPPkdFmtJapanese';
      2: Result:= 'EUC-JP';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    19: case i of
      0: Result:= 'Extended_UNIX_Code_Fixed_Width_for_Japanese';
      1: Result:= 'csEUCFixWidJapanese';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    20: case i of
      0: Result:= 'BS_4730';
      1: Result:= 'iso-ir-4';
      2: Result:= 'ISO646-GB';
      3: Result:= 'gb';
      4: Result:= 'uk';
      5: Result:= 'csISO4UnitedKingdom';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    21: case i of
      0: Result:= 'SEN_850200_C';
      1: Result:= 'iso-ir-11';
      2: Result:= 'ISO646-SE2';
      3: Result:= 'se2';
      4: Result:= 'csISO11SwedishForNames';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    22: case i of
      0: Result:= 'IT';
      1: Result:= 'iso-ir-15';
      2: Result:= 'ISO646-IT';
      3: Result:= 'csISO15Italian';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    23: case i of
      0: Result:= 'ES';
      1: Result:= 'iso-ir-17';
      2: Result:= 'ISO646-ES';
      3: Result:= 'csISO17Spanish';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    24: case i of
      0: Result:= 'DIN_66003';
      1: Result:= 'iso-ir-21';
      2: Result:= 'de';
      3: Result:= 'ISO646-DE';
      4: Result:= 'csISO21German';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    25: case i of
      0: Result:= 'NS_4551-1';
      1: Result:= 'iso-ir-60';
      2: Result:= 'ISO646-NO';
      3: Result:= 'no';
      4: Result:= 'csISO60Danish-Norwegian';
      5: Result:= 'csISO60Norwegian1';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    26: case i of
      0: Result:= 'NF_Z_62-010';
      1: Result:= 'iso-ir-69';
      2: Result:= 'ISO646-FR';
      3: Result:= 'fr';
      4: Result:= 'csISO69French';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    27: case i of
      0: Result:= 'ISO-10646-UTF-1';
      1: Result:= 'csISO10646UTF1';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    28: case i of
      0: Result:= 'ISO_646.basic:1983';
      1: Result:= 'ref';
      2: Result:= 'csISO646basic1983';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    29: case i of
      0: Result:= 'INVARIANT';
      1: Result:= 'csINVARIANT';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    30: case i of
      0: Result:= 'ISO_646.irv:1983';
      1: Result:= 'iso-ir-2';
      2: Result:= 'irv';
      3: Result:= 'csISO2Int1RefVersion';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    31: case i of
      0: Result:= 'NATS-SEFI';
      1: Result:= 'iso-ir-8-1';
      2: Result:= 'csNATSSEFI';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    32: case i of
      0: Result:= 'NATS-SEFI-ADD';
      1: Result:= 'iso-ir-8-2';
      2: Result:= 'csNATSSEFIADD';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    33: case i of
      0: Result:= 'NATS-DANO';
      1: Result:= 'iso-ir-9-1';
      2: Result:= 'csNATSDANO';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    34: case i of
      0: Result:= 'NATS-DANO-ADD';
      1: Result:= 'iso-ir-9-2';
      2: Result:= 'csNATSDANOADD';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    35: case i of
      0: Result:= 'SEN_850200_B';
      1: Result:= 'iso-ir-10';
      2: Result:= 'FI';
      3: Result:= 'ISO646-FI';
      4: Result:= 'ISO646-SE';
      5: Result:= 'se';
      6: Result:= 'csISO10Swedish';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    36: case i of
      0: Result:= 'KS_C_5601-1987';
      1: Result:= 'iso-ir-149';
      2: Result:= 'KS_C_5601-1989';
      3: Result:= 'KSC_5601';
      4: Result:= 'korean';
      5: Result:= 'csKSC56011987';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    37: case i of
      0: Result:= 'ISO-2022-KR';
      1: Result:= 'csISO2022KR';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    38: case i of
      0: Result:= 'EUC-KR';
      1: Result:= 'csEUCKR';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    39: case i of
      0: Result:= 'ISO-2022-JP';
      1: Result:= 'csISO2022JP';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    40: case i of
      0: Result:= 'ISO-2022-JP-2';
      1: Result:= 'csISO2022JP2';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    41: case i of
      0: Result:= 'JIS_C6220-1969-jp';
      1: Result:= 'JIS_C6220-1969';
      2: Result:= 'iso-ir-13';
      3: Result:= 'katakana';
      4: Result:= 'x0201-7';
      5: Result:= 'csISO13JISC6220jp';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    42: case i of
      0: Result:= 'JIS_C6220-1969-ro';
      1: Result:= 'iso-ir-14';
      2: Result:= 'jp';
      3: Result:= 'ISO646-JP';
      4: Result:= 'csISO14JISC6220ro';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    43: case i of
      0: Result:= 'PT';
      1: Result:= 'iso-ir-16';
      2: Result:= 'ISO646-PT';
      3: Result:= 'csISO16Portuguese';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    44: case i of
      0: Result:= 'greek7-old';
      1: Result:= 'iso-ir-18';
      2: Result:= 'csISO18Greek7Old';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    45: case i of
      0: Result:= 'latin-greek';
      1: Result:= 'iso-ir-19';
      2: Result:= 'csISO19LatinGreek';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    46: case i of
      0: Result:= 'NF_Z_62-010_(1973)';
      1: Result:= 'iso-ir-25';
      2: Result:= 'ISO646-FR1';
      3: Result:= 'csISO25French';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    47: case i of
      0: Result:= 'Latin-greek-1';
      1: Result:= 'iso-ir-27';
      2: Result:= 'csISO27LatinGreek1';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    48: case i of
      0: Result:= 'ISO_5427';
      1: Result:= 'iso-ir-37';
      2: Result:= 'csISO5427Cyrillic';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    49: case i of
      0: Result:= 'JIS_C6226-1978';
      1: Result:= 'iso-ir-42';
      2: Result:= 'csISO42JISC62261978';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    50: case i of
      0: Result:= 'BS_viewdata';
      1: Result:= 'iso-ir-47';
      2: Result:= 'csISO47BSViewdata';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    51: case i of
      0: Result:= 'INIS';
      1: Result:= 'iso-ir-49';
      2: Result:= 'csISO49INIS';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    52: case i of
      0: Result:= 'INIS-8';
      1: Result:= 'iso-ir-50';
      2: Result:= 'csISO50INIS8';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    53: case i of
      0: Result:= 'INIS-cyrillic';
      1: Result:= 'iso-ir-51';
      2: Result:= 'csISO51INISCyrillic';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    54: case i of
      0: Result:= 'ISO_5427:1981';
      1: Result:= 'iso-ir-54';
      2: Result:= 'ISO5427Cyrillic1981';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    55: case i of
      0: Result:= 'ISO_5428:1980';
      1: Result:= 'iso-ir-55';
      2: Result:= 'csISO5428Greek';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    56: case i of
      0: Result:= 'GB_1988-80';
      1: Result:= 'iso-ir-57';
      2: Result:= 'cn';
      3: Result:= 'ISO646-CN';
      4: Result:= 'csISO57GB1988';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    57: case i of
      0: Result:= 'GB_2312-80';
      1: Result:= 'iso-ir-58';
      2: Result:= 'chinese';
      3: Result:= 'csISO58GB231280';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    58: case i of
      0: Result:= 'NS_4551-2';
      1: Result:= 'ISO646-NO2';
      2: Result:= 'iso-ir-61';
      3: Result:= 'no2';
      4: Result:= 'csISO61Norwegian2';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    59: case i of
      0: Result:= 'videotex-suppl';
      1: Result:= 'iso-ir-70';
      2: Result:= 'csISO70VideotexSupp1';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    60: case i of
      0: Result:= 'PT2';
      1: Result:= 'iso-ir-84';
      2: Result:= 'ISO646-PT2';
      3: Result:= 'csISO84Portuguese2';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    61: case i of
      0: Result:= 'ES2';
      1: Result:= 'iso-ir-85';
      2: Result:= 'ISO646-ES2';
      3: Result:= 'csISO85Spanish2';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    62: case i of
      0: Result:= 'MSZ_7795.3';
      1: Result:= 'iso-ir-86';
      2: Result:= 'ISO646-HU';
      3: Result:= 'hu';
      4: Result:= 'csISO86Hungarian';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    63: case i of
      0: Result:= 'JIS_C6226-1983';
      1: Result:= 'iso-ir-87';
      2: Result:= 'x0208';
      3: Result:= 'JIS_X0208-1983';
      4: Result:= 'csISO87JISX0208';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    64: case i of
      0: Result:= 'greek7';
      1: Result:= 'iso-ir-88';
      2: Result:= 'csISO88Greek7';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    65: case i of
      0: Result:= 'ASMO_449';
      1: Result:= 'ISO_9036';
      2: Result:= 'arabic7';
      3: Result:= 'iso-ir-89';
      4: Result:= 'csISO89ASMO449';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    66: case i of
      0: Result:= 'iso-ir-90';
      1: Result:= 'csISO90';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    67: case i of
      0: Result:= 'JIS_C6229-1984-a';
      1: Result:= 'iso-ir-91';
      2: Result:= 'jp-ocr-a';
      3: Result:= 'csISO91JISC62291984a';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    68: case i of
      0: Result:= 'JIS_C6229-1984-b';
      1: Result:= 'iso-ir-92';
      2: Result:= 'ISO646-JP-OCR-B';
      3: Result:= 'jp-ocr-b';
      4: Result:= 'csISO92JISC62291984b';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    69: case i of
      0: Result:= 'JIS_C6229-1984-b-add';
      1: Result:= 'iso-ir-93';
      2: Result:= 'jp-ocr-b-add';
      3: Result:= 'csISO93JISC62291984badd';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    70: case i of
      0: Result:= 'JIS_C6229-1984-hand';
      1: Result:= 'iso-ir-94';
      2: Result:= 'jp-ocr-hand';
      3: Result:= 'csISO94JISC62291984hand';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    71: case i of
      0: Result:= 'JIS_C6229-1984-hand-add';
      1: Result:= 'iso-ir-95';
      2: Result:= 'jp-ocr-hand-add';
      3: Result:= 'csISO95JISC62291984handadd';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    72: case i of
      0: Result:= 'JIS_C6229-1984-kana';
      1: Result:= 'iso-ir-96';
      2: Result:= 'jp-ocr-hand';
      3: Result:= 'csISO96JISC62291984kana';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    73: case i of
      0: Result:= 'ISO_2033-1983';
      1: Result:= 'iso-ir-98';
      2: Result:= 'e13b';
      3: Result:= 'csISO2033';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    74: case i of
      0: Result:= 'ANSI_X3.110-1983';
      1: Result:= 'iso-ir-99';
      2: Result:= 'CSA_T500-1983';
      3: Result:= 'NAPLPS';
      4: Result:= 'csISO99NAPLPS';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    75: case i of
      0: Result:= 'T.61-7bit';
      1: Result:= 'iso-ir-102';
      2: Result:= 'csISO102T617bit';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    76: case i of
      0: Result:= 'T.61-8bit';
      1: Result:= 'T.61';
      2: Result:= 'iso-ir-103';
      3: Result:= 'csISO103T618bit';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    77: case i of
      0: Result:= 'ECMA-cyrillic';
      1: Result:= 'iso-ir-111';
      2: Result:= 'csISO111ECMACyrillic';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    78: case i of
      0: Result:= 'CSA_Z243.4-1985-1';
      1: Result:= 'iso-ir-121';
      2: Result:= 'ISO646-CA';
      3: Result:= 'csa7-1';
      4: Result:= 'ca';
      5: Result:= 'csISO121Canadian1';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    79: case i of
      0: Result:= 'CSA_Z243.4-1985-2';
      1: Result:= 'iso-ir-122';
      2: Result:= 'ISO646-CA2';
      3: Result:= 'csa7-2';
      4: Result:= 'csISO122Canadian2';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    80: case i of
      0: Result:= 'CSA_Z243.4-1985-gr';
      1: Result:= 'iso-ir-123';
      2: Result:= 'csISO123CSAZ24341985gr';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    81: case i of
      0: Result:= 'ISO_8859-6-E';
      1: Result:= 'csISO88596E';
      2: Result:= 'ISO-8859-6-E';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    82: case i of
      0: Result:= 'ISO_8859-6-I';
      1: Result:= 'csISO88596I';
      2: Result:= 'ISO-8859-6-I';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    83: case i of
      0: Result:= 'T.101-G2';
      1: Result:= 'iso-ir-128';
      2: Result:= 'csISO128T101G2';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    84: case i of
      0: Result:= 'ISO_8859-8-E';
      1: Result:= 'csISO88598E';
      2: Result:= 'ISO-8859-8-E';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    85: case i of
      0: Result:= 'ISO_8859-8-I';
      1: Result:= 'csISO88598I';
      2: Result:= 'ISO-8859-8-I';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    86: case i of
      0: Result:= 'CSN_369103';
      1: Result:= 'iso-ir-139';
      2: Result:= 'csISO139CSN369103';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    87: case i of
      0: Result:= 'JUS_I.B1.002';
      1: Result:= 'iso-ir-141';
      2: Result:= 'ISO646-YU';
      3: Result:= 'js';
      4: Result:= 'yu';
      5: Result:= 'csISO141JUSIB1002';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    88: case i of
      0: Result:= 'IEC_P27-1';
      1: Result:= 'iso-ir-143';
      2: Result:= 'csISO143IECP271';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    89: case i of
      0: Result:= 'JUS_I.B1.003-serb';
      1: Result:= 'iso-ir-146';
      2: Result:= 'serbian';
      3: Result:= 'csISO146Serbian';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    90: case i of
      0: Result:= 'JUS_I.B1.003-mac';
      1: Result:= 'macedonian';
      2: Result:= 'iso-ir-147';
      3: Result:= 'csISO147Macedonian';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    91: case i of
      0: Result:= 'greek-ccitt';
      1: Result:= 'iso-ir-150';
      2: Result:= 'csISO150';
      3: Result:= 'csISO150GreekCCITT';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    92: case i of
      0: Result:= 'NC_NC00-10:81';
      1: Result:= 'cuba';
      2: Result:= 'iso-ir-151';
      3: Result:= 'ISO646-CU';
      4: Result:= 'csISO151Cuba';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    93: case i of
      0: Result:= 'ISO_6937-2-25';
      1: Result:= 'iso-ir-152';
      2: Result:= 'csISO6937Add';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    94: case i of
      0: Result:= 'GOST_19768-74';
      1: Result:= 'ST_SEV_358-88';
      2: Result:= 'iso-ir-153';
      3: Result:= 'csISO153GOST1976874';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    95: case i of
      0: Result:= 'ISO_8859-supp';
      1: Result:= 'iso-ir-154';
      2: Result:= 'latin1-2-5';
      3: Result:= 'csISO8859Supp';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    96: case i of
      0: Result:= 'ISO_10367-box';
      1: Result:= 'iso-ir-155';
      2: Result:= 'csISO10367Box';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    97: case i of
      0: Result:= 'latin-lap';
      1: Result:= 'lap';
      2: Result:= 'iso-ir-158';
      3: Result:= 'csISO158Lap';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    98: case i of
      0: Result:= 'JIS_X0212-1990';
      1: Result:= 'x0212';
      2: Result:= 'iso-ir-159';
      3: Result:= 'csISO159JISX02121990';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    99: case i of
      0: Result:= 'DS_2089';
      1: Result:= 'DS2089';
      2: Result:= 'ISO646-DK';
      3: Result:= 'dk';
      4: Result:= 'csISO646Danish';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    100: case i of
      0: Result:= 'us-dk';
      1: Result:= 'csUSDK';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    101: case i of
      0: Result:= 'dk-us';
      1: Result:= 'csDKUS';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    102: case i of
      0: Result:= 'KSC5636';
      1: Result:= 'ISO646-KR';
      2: Result:= 'csKSC5636';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    103: case i of
      0: Result:= 'UNICODE-1-1-UTF-7';
      1: Result:= 'csUnicode11UTF7';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    104: case i of
      0: Result:= 'ISO-2022-CN';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    105: case i of
      0: Result:= 'ISO-2022-CN-EXT';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    106: case i of
      0: Result:= 'UTF-8';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    109: case i of
      0: Result:= 'ISO-8859-13';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    110: case i of
      0: Result:= 'ISO-8859-14';
      1: Result:= 'iso-ir-199';
      2: Result:= 'ISO_8859-14:1998';
      3: Result:= 'ISO_8859-14';
      4: Result:= 'latin8';
      5: Result:= 'iso-celtic';
      6: Result:= 'l8';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    111: case i of
      0: Result:= 'ISO-8859-15';
      1: Result:= 'ISO_8869-15';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    112: case i of
      0: Result:= 'ISO-8859-16';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    1000: case i of
      0: Result:= 'ISO-10646-UCS-2';
      1: Result:= 'csUnicode';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    1001: case i of
      0: Result:= 'ISO-10646-UCS-4';
      1: Result:= 'csUCS4';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    1002: case i of
      0: Result:= 'ISO-10646-UCS-Basic';
      1: Result:= 'csUnicodeASCII';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    1003: case i of
      0: Result:= 'ISO-10646-Unicode-Latin1';
      1: Result:= 'csUnicodeLatin1';
      2: Result:= 'ISO-10646';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    1004: case i of
      0: Result:= 'ISO-10646-J-1';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    1005: case i of
      0: Result:= 'ISO-Unicode-IBM-1261';
      1: Result:= 'csUnicodeIBM1261';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    1006: case i of
      0: Result:= 'ISO-Unicode-IBM-1268';
      1: Result:= 'csUnicodeIBM1268';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    1007: case i of
      0: Result:= 'ISO-Unicode-IBM-1276';
      1: Result:= 'csUnicodeIBM1276';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    1008: case i of
      0: Result:= 'ISO-Unicode-IBM-1264';
      1: Result:= 'csUnicodeIBM1264';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    1009: case i of
      0: Result:= 'ISO-Unicode-IBM-1265';
      1: Result:= 'csUnicodeIBM1265';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    1010: case i of
      0: Result:= 'UNICODE-1-1';
      1: Result:= 'csUnicode11';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    1011: case i of
      0: Result:= 'SCSU';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    1012: case i of
      0: Result:= 'UTF-7';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    1013: case i of
      0: Result:= 'UTF-16BE';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    1014: case i of
      0: Result:= 'UTF-16LE';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    1015: case i of
      0: Result:= 'UTF-16';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2000: case i of
      0: Result:= 'ISO-8859-1-Windows-3.0-Latin-1';
      1: Result:= 'csWindows30Latin1';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2001: case i of
      0: Result:= 'ISO-8859-1-Windows-3.1-Latin-1';
      1: Result:= 'csWindows31Latin1';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2002: case i of
      0: Result:= 'ISO-8859-2-Windows-Latin-2';
      1: Result:= 'csWindows31Latin2';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2003: case i of
      0: Result:= 'ISO-8859-9-Windows-Latin-5';
      1: Result:= 'csWindows31Latin5';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2004: case i of
      0: Result:= 'hp-roman8';
      1: Result:= 'roman8';
      2: Result:= 'r8';
      3: Result:= 'csHPRoman8';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2005: case i of
      0: Result:= 'Adobe-Standard-Encoding';
      1: Result:= 'csAdobeStandardEncoding';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2006: case i of
      0: Result:= 'Ventura-US';
      1: Result:= 'csVenturaUS';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2007: case i of
      0: Result:= 'Ventura-International';
      1: Result:= 'csVenturaInternational';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2008: case i of
      0: Result:= 'DEC-MCS';
      1: Result:= 'dec';
      2: Result:= 'csDECMCS';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2009: case i of
      0: Result:= 'IBM850';
      1: Result:= 'cp850';
      2: Result:= '850';
      3: Result:= 'csPC850Multilingual';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2010: case i of
      0: Result:= 'IBM852';
      1: Result:= 'cp852';
      2: Result:= '852';
      3: Result:= 'csPCp852';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2011: case i of
      0: Result:= 'IBM437';
      1: Result:= 'cp437';
      2: Result:= '437';
      3: Result:= 'csPC8CodePage437';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2012: case i of
      0: Result:= 'PC8-Danish-Norwegian';
      1: Result:= 'csPC8DanishNorwegian';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2013: case i of
      0: Result:= 'IBM862';
      1: Result:= 'cp862';
      2: Result:= '862';
      3: Result:= 'csPC862LatinHebrew';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2014: case i of
      0: Result:= 'PC8-Turkish';
      1: Result:= 'csPC8Turkish';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2015: case i of
      0: Result:= 'IBM-Symbols';
      1: Result:= 'csIBMSymbols';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2016: case i of
      0: Result:= 'IBM-Thai';
      1: Result:= 'csIBMThai';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2017: case i of
      0: Result:= 'HP-Legal';
      1: Result:= 'csHPLegal';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2018: case i of
      0: Result:= 'HP-Pi-font';
      1: Result:= 'csHPPiFont';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2019: case i of
      0: Result:= 'HP-Math8';
      1: Result:= 'csHPMath8';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2020: case i of
      0: Result:= 'Adobe-Symbol-Encoding';
      1: Result:= 'csHPPSMath';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2021: case i of
      0: Result:= 'HP-DeskTop';
      1: Result:= 'csHPDesktop';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2022: case i of
      0: Result:= 'Ventura-Math';
      1: Result:= 'csVenturaMath';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2023: case i of
      0: Result:= 'Microsoft-Publishing';
      1: Result:= 'csMicrosoftPublishing';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2024: case i of
      0: Result:= 'Windows-31J';
      1: Result:= 'csWindows31J';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2025: case i of
      0: Result:= 'GB2312';
      1: Result:= 'csGB2312';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2026: case i of
      0: Result:= 'Big5';
      1: Result:= 'csBig5';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2027: case i of
      0: Result:= 'macintosh';
      1: Result:= 'mac';
      2: Result:= 'csMacintosh';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2028: case i of
      0: Result:= 'IBM037';
      1: Result:= 'cp037';
      2: Result:= 'ebcdic-cp-us';
      3: Result:= 'ebcdic-cp-ca';
      4: Result:= 'ebcdic-cp-wt';
      5: Result:= 'ebcdic-cp-nl';
      6: Result:= 'csIBM037';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2029: case i of
      0: Result:= 'IBM038';
      1: Result:= 'EBCDIC-INT';
      2: Result:= 'cp038';
      3: Result:= 'csIBM038';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2030: case i of
      0: Result:= 'IBM273';
      1: Result:= 'CP273';
      2: Result:= 'csIBM273';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2031: case i of
      0: Result:= 'IBM274';
      1: Result:= 'EBCDIC-BE';
      2: Result:= 'CP274';
      3: Result:= 'csIBM274';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2032: case i of
      0: Result:= 'IBM275';
      1: Result:= 'EBCDIC-BR';
      2: Result:= 'cp275';
      3: Result:= 'csIBM275';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2033: case i of
      0: Result:= 'IBM277';
      1: Result:= 'EBCDIC-CP-DK';
      2: Result:= 'EBCDIC-CP-NO';
      3: Result:= 'csIBM277';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2034: case i of
      0: Result:= 'IBM278';
      1: Result:= 'CP278';
      2: Result:= 'ebcdic-cp-fi';
      3: Result:= 'ebcdic-cp-se';
      4: Result:= 'csIBM278';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2035: case i of
      0: Result:= 'IBM280';
      1: Result:= 'CP280';
      2: Result:= 'ebcdic-cp-it';
      3: Result:= 'csIBM280';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2036: case i of
      0: Result:= 'IBM281';
      1: Result:= 'EBCDIC-JP-E';
      2: Result:= 'cp281';
      3: Result:= 'csIBM281';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2037: case i of
      0: Result:= 'IBM284';
      1: Result:= 'CP284';
      2: Result:= 'ebcdic-cp-es';
      3: Result:= 'csIBM284';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2038: case i of
      0: Result:= 'IBM285';
      1: Result:= 'CP285';
      2: Result:= 'ebcdic-cp-gb';
      3: Result:= 'csIBM285';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2039: case i of
      0: Result:= 'IBM290';
      1: Result:= 'cp290';
      2: Result:= 'EBCDIC-JP-kana';
      3: Result:= 'csIBM290';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2040: case i of
      0: Result:= 'IBM297';
      1: Result:= 'cp297';
      2: Result:= 'ebcdic-cp-fr';
      3: Result:= 'csIBM297';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2041: case i of
      0: Result:= 'IBM420';
      1: Result:= 'cp420';
      2: Result:= 'ebcdic-cp-ar1';
      3: Result:= 'csIBM420';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2042: case i of
      0: Result:= 'IBM423';
      1: Result:= 'cp423';
      2: Result:= 'ebcdic-cp-gr';
      3: Result:= 'csIBM423';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2043: case i of
      0: Result:= 'IBM424';
      1: Result:= 'cp424';
      2: Result:= 'ebcdic-cp-he';
      3: Result:= 'csIBM424';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2044: case i of
      0: Result:= 'IBM500';
      1: Result:= 'CP500';
      2: Result:= 'ebcdic-cp-be';
      3: Result:= 'ebcdic-cp-ch';
      4: Result:= 'csIBM500';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2045: case i of
      0: Result:= 'IBM851';
      1: Result:= 'cp851';
      2: Result:= '851';
      3: Result:= 'csIBM851';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2046: case i of
      0: Result:= 'IBM855';
      1: Result:= 'cp855';
      2: Result:= '855';
      3: Result:= 'csIBM855';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2047: case i of
      0: Result:= 'IBM857';
      1: Result:= 'cp857';
      2: Result:= '857';
      3: Result:= 'csIBM857';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2048: case i of
      0: Result:= 'IBM860';
      1: Result:= 'cp860';
      2: Result:= '860';
      3: Result:= 'csIBM860';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2049: case i of
      0: Result:= 'IBM861';
      1: Result:= 'cp861';
      2: Result:= '861';
      3: Result:= 'cp-is';
      4: Result:= 'csIBM861';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2050: case i of
      0: Result:= 'IBM863';
      1: Result:= 'cp863';
      2: Result:= '863';
      3: Result:= 'csIBM863';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2051: case i of
      0: Result:= 'IBM864';
      1: Result:= 'cp864';
      2: Result:= 'csIBM864';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2052: case i of
      0: Result:= 'IBM865';
      1: Result:= 'cp865';
      2: Result:= '865';
      3: Result:= 'csIBM865';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2053: case i of
      0: Result:= 'IBM868';
      1: Result:= 'CP868';
      2: Result:= 'cp-ar';
      3: Result:= 'csIBM868';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2054: case i of
      0: Result:= 'IBM869';
      1: Result:= 'cp869';
      2: Result:= '869';
      3: Result:= 'cp-gr';
      4: Result:= 'csIBM869';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2055: case i of
      0: Result:= 'IBM870';
      1: Result:= 'CP870';
      2: Result:= 'ebcdic-cp-roece';
      3: Result:= 'ebcdic-cp-yu';
      4: Result:= 'csIBM870';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2056: case i of
      0: Result:= 'IBM871';
      1: Result:= 'CP871';
      2: Result:= 'ebcdic-cp-is';
      3: Result:= 'csIBM871';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2057: case i of
      0: Result:= 'IBM880';
      1: Result:= 'cp880';
      2: Result:= 'EBCDIC-Cyrillic';
      3: Result:= 'csIBM880';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2058: case i of
      0: Result:= 'IBM891';
      1: Result:= 'cp891';
      2: Result:= 'csIBM891';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2059: case i of
      0: Result:= 'IBM903';
      1: Result:= 'cp903';
      2: Result:= 'csIBM903';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2060: case i of
      0: Result:= 'IBM904';
      1: Result:= 'cp904';
      2: Result:= '904';
      3: Result:= 'csIBM904';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2061: case i of
      0: Result:= 'IBM905';
      1: Result:= 'CP905';
      2: Result:= 'ebcdic-cp-tr';
      3: Result:= 'csIBM905';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2062: case i of
      0: Result:= 'IBM918';
      1: Result:= 'CP918';
      2: Result:= 'ebcdic-cp-ar2';
      3: Result:= 'csIBM918';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2063: case i of
      0: Result:= 'IBM1026';
      1: Result:= 'CP1026';
      2: Result:= 'csIBM1026';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2064: case i of
      0: Result:= 'EBCDIC-AT-DE';
      1: Result:= 'csIBMEBCDICATDE';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2065: case i of
      0: Result:= 'EBCDIC-AT-DE-A';
      1: Result:= 'csIBMEBCDICATDEA';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2066: case i of
      0: Result:= 'EBCDIC-CA-FR';
      1: Result:= 'csIBMEBCDICCAFR';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2067: case i of
      0: Result:= 'EBCDIC-DK-NO';
      1: Result:= 'csIBMEBCDICDKNO';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2068: case i of
      0: Result:= 'EBCDIC-DK-NO-A';
      1: Result:= 'csIBMEBCDICDKNOA';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2069: case i of
      0: Result:= 'EBCDIC-FI-SE';
      1: Result:= 'csIBMEBCDICFISE';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2070: case i of
      0: Result:= 'EBCDIC-FI-SE-A';
      1: Result:= 'csIBMEBCDICFISEA';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2071: case i of
      0: Result:= 'EBCDIC-FR';
      1: Result:= 'csIBMEBCDICFR';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2072: case i of
      0: Result:= 'EBCDIC-IT';
      1: Result:= 'csIBMEBCDICIT';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2073: case i of
      0: Result:= 'EBCDIC-PT';
      1: Result:= 'csIBMEBCDICPT';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2074: case i of
      0: Result:= 'EBCDIC-ES';
      1: Result:= 'csIBMEBCDICES';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2075: case i of
      0: Result:= 'EBCDIC-ES-A';
      1: Result:= 'csIBMEBCDICESA';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2076: case i of
      0: Result:= 'EBCDIC-ES-S';
      1: Result:= 'csIBMEBCDICESS';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2077: case i of
      0: Result:= 'EBCDIC-UK';
      1: Result:= 'csIBMEBCDICUK';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2078: case i of
      0: Result:= 'EBCDIC-US';
      1: Result:= 'csIBMEBCDICUS';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2079: case i of
      0: Result:= 'UNKNOWN-8BIT';
      1: Result:= 'csUnkown8Bit';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2080: case i of
      0: Result:= 'MNEMONIC';
      1: Result:= 'csMnemonic';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2081: case i of
      0: Result:= 'MNEM';
      1: Result:= 'csMnem';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2082: case i of
      0: Result:= 'VISCII';
      1: Result:= 'csVISCII';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2083: case i of
      0: Result:= 'VIQR';
      1: Result:= 'csVIQR';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2084: case i of
      0: Result:= 'KOI8-R';
      1: Result:= 'csKOI8R';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2085: case i of
      0: Result:= 'HZ-GB-2312';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2086: case i of
      0: Result:= 'IBM866';
      1: Result:= 'cp866';
      2: Result:= '866';
      3: Result:= 'csIBM866';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2087: case i of
      0: Result:= 'IBM775';
      1: Result:= 'cp775';
      2: Result:= 'csPC775Baltic';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2088: case i of
      0: Result:= 'KOI8-U';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2089: case i of
      0: Result:= 'IBM00858';
      1: Result:= 'CCSID00858';
      2: Result:= 'CP00858';
      3: Result:= 'PC-Multilingual-850+euro';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2090: case i of
      0: Result:= 'IBM00924';
      1: Result:= 'CCSID00924';
      2: Result:= 'CP00924';
      3: Result:= 'ebcdic-Latin9--euro';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2091: case i of
      0: Result:= 'IBM01140';
      1: Result:= 'CCSID01140';
      2: Result:= 'CP01140';
      3: Result:= 'ebcdic-us-37+euro';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2092: case i of
      0: Result:= 'IBM01141';
      1: Result:= 'CCSID01141';
      2: Result:= 'CP01141';
      3: Result:= 'ebcdic-de-273+euro';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2093: case i of
      0: Result:= 'IBM01142';
      1: Result:= 'CCSID01142';
      2: Result:= 'CP01142';
      3: Result:= 'ebcdic-dk-277+euro';
      4: Result:= 'ebcdic-no-277+euro';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2094: case i of
      0: Result:= 'IBM01143';
      1: Result:= 'CCSID01143';
      2: Result:= 'CP01143';
      3: Result:= 'ebcdic-fi-278+euro';
      4: Result:= 'ebcdic-se-278+euro';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2095: case i of
      0: Result:= 'IBM01144';
      1: Result:= 'CCSID01144';
      2: Result:= 'CP01144';
      3: Result:= 'ebcdic-it-280+euro';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2096: case i of
      0: Result:= 'IBM01145';
      1: Result:= 'CCSID01145';
      2: Result:= 'CP01145';
      3: Result:= 'ebcdic-es-284+euro';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2097: case i of
      0: Result:= 'IBM01146';
      1: Result:= 'CCSID01146';
      2: Result:= 'CP01146';
      3: Result:= 'ebcdic-gb-285+euro';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2098: case i of
      0: Result:= 'IBM01147';
      1: Result:= 'CCSID01147';
      2: Result:= 'CP01147';
      3: Result:= 'ebcdic-fr-297+euro';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2099: case i of
      0: Result:= 'IBM01148';
      1: Result:= 'CCSID01148';
      2: Result:= 'CP01148';
      3: Result:= 'ebcdic-international-500+euro';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2100: case i of
      0: Result:= 'IBM01149';
      1: Result:= 'CCSID01149';
      2: Result:= 'CP01149';
      3: Result:= 'ebcdic-is-871+euro';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2101: case i of
      0: Result:= 'Big5-HKSCS';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2250: case i of
      0: Result:= 'windows-1250';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2251: case i of
      0: Result:= 'windows-1251';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2252: case i of
      0: Result:= 'windows-1252';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2253: case i of
      0: Result:= 'windows-1253';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2254: case i of
      0: Result:= 'windows-1254';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2255: case i of
      0: Result:= 'windows-1255';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2256: case i of
      0: Result:= 'windows-1256';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2257: case i of
      0: Result:= 'windows-1257';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2258: case i of
      0: Result:= 'windows-1258';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
    2259: case i of
      0: Result:= 'TIS-620';
    else
      raise ECSMIBException.Create('Invalid MIB number');
    end;
  else
    raise ECSMIBException.Create('Invalid MIB number');
  end;
end;

function TCSMIB.GetAliasCount: integer;
begin
  case FEnum of
    104..106,109,112,1004,1011..1015,2085,2088,2101,2250..2259: Result:= 1;
    16,19,27,29,37..40,66,100..101,103,111,1000..1002,1005..1010,2000..2003,2005..2007,2012,2014..2026,2064..2084: Result:= 2;
    14..15,17..18,28,31..34,44..45,47..55,59,64,72,75,77,80..86,88,93,96,102,1003,2008,2027,2030,2051,2058..2059,2063,2087: Result:= 3;
    22..23,30,43,46,57,60..61,67,69..71,73,76,89..91,94..95,97..98,2004,2009..2011,2013,2029,2031..2033,2035..2043,2045..2048,2050,2052..2053,2056..2057,2060..2062,2086,2089..2092,2095..2100: Result:= 4;
    21,24,26,42,56,58,62..63,65,68,74,79,92,99,2034,2044,2049,2054..2055,2093..2094: Result:= 5;
    8,11,13,20,25,36,41,78,87: Result:= 6;
    5..7,12,35,110,2028: Result:= 7;
    9: Result:= 8;
    4,10: Result:= 9;
    3: Result:= 11;
  else
    raise ECSMIBException.Create('Invalid MIB number');
  end;
end;

function TCSMIB.GetPrfMIMEName: string;
begin
  case FEnum of
  13,17,37..40,2025..2026,2084: Result:= Alias[0];
  18,82,84..85: Result:= Alias[2];
  4..12: Result:= Alias[3];
  3: Result:= Alias[6];
  else
    Result:= '';
  end;
end;

function TCSMIB.IsValidEnum(const Value: integer): boolean;
begin
  case Value of
    3..106,109..112,1000..1015,2000..2101,2250..2259:
      Result:= true;
  else
    Result:= false;
  end;
end;

procedure TCSMIB.SetEnum(const Value: integer);
var
  AllowChange: boolean;
begin
  if IsValidEnum(Value) then begin
    if FEnum = Value then exit;
    AllowChange:= True;
    DoChanging(self,Value,AllowChange);
    if AllowChange then begin
      FEnum:= Value;
      DoChange(self);
    end;
  end else if not IgnoreInvalidEnum then begin
    raise ECSMIBException.Create('Invalid MIB number');
  end;
end;

procedure TCSMIB.SetOnChange(const Value: TNotifyEvent);
begin
  FOnChange := Value;
end;

procedure TCSMIB.SetOnChanging(const Value: TCSMIBChangingEvent);
begin
  FOnChanging := Value;
end;

function TCSMIB.SetToAlias(const S: string): boolean;
var
  i,j,oldEnum: integer;
begin
  Result:= true;
  oldEnum:= Enum;
  for i:= 3 to 106 do begin
    Enum:= i;
    for j:= 0 to pred(AliasCount) do begin
      if CompareText(Alias[j],S) = 0 then exit;
    end;
  end;
  for i:= 109 to 112 do begin
    Enum:= i;
    for j:= 0 to pred(AliasCount) do begin
      if CompareText(Alias[j],S) = 0 then exit;
    end;
  end;
  for i:= 1000 to 1015 do begin
    Enum:= i;
    for j:= 0 to pred(AliasCount) do begin
      if CompareText(Alias[j],S) = 0 then exit;
    end;
  end;
  for i:= 2000 to 2101 do begin
    Enum:= i;
    for j:= 0 to pred(AliasCount) do begin
      if CompareText(Alias[j],S) = 0 then exit;
    end;
  end;
  for i:= 2250 to 2259 do begin
    Enum:= i;
    for j:= 0 to pred(AliasCount) do begin
      if CompareText(Alias[j],S) = 0 then exit;
    end;
  end;
  Result:= false;
  Enum:= oldEnum;
end;

end.
