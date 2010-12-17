{**************************************************************************************************}
{                                                                                                  }
{ Unit uWmiDelphiClass                                                                             }
{ Base class  for the classes generated by the Delphi Wmi Class generator                          }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is uWmiDelphiClass.pas.                                                        }
{                                                                                                  }
{ The Initial Developer of the Original Code is Rodrigo Ruz V.                                     }
{ Portions created by Rodrigo Ruz V. are Copyright (C) 2010 Rodrigo Ruz V.                         }
{ All Rights Reserved.                                                                             }
{                                                                                                  }
{**************************************************************************************************}

unit uWmiDelphiClass;

interface
{$IFNDEF MSWINDOWS}
     Sorry Only Windows
{$ENDIF}
{.$DEFINE _DEBUG}
{.$DEFINE WbemScripting_TLB}

{$IFDEF FPC}
{$mode objfpc}{$H+}
{$UNDEF WbemScripting_TLB}
{$ENDIF}


{$IFNDEF WbemScripting_TLB}
  {$DEFINE WMI_LateBinding}
{$ENDIF}

uses
{$IFDEF WbemScripting_TLB}
WbemScripting_TLB,
{$ENDIF}
Classes;

{$IFDEF WMI_LateBinding}
const
SWbemScripting_SWbemLocator {$IFDEF FPC}:WideString{$ENDIF}  = 'WbemScripting.SWbemLocator';

wbemImpersonationLevelAnonymous   = $00000001;  //Anonymous 	Hides the credentials of the caller.
                                                //Calls to WMI may fail with this impersonation level.
wbemImpersonationLevelIdentify 	  = $00000002;  //Identify 	Allows objects to query the credentials of the caller.
                                                //Calls to WMI may fail with this impersonation level.
wbemImpersonationLevelImpersonate = $00000003;  //Impersonate 	Allows objects to use the credentials of the caller.
                                                //This is the recommended impersonation level for WMI Scripting API calls.
wbemImpersonationLevelDelegate 	  = $00000004;  //Delegate 	Allows objects to permit other objects to use the credentials of the caller.
                                                //This impersonation, which will work with WMI Scripting API calls but may constitute an unnecessary security risk, is supported only under Windows 2000.

wbemFlagForwardOnly               = $00000020; //Causes a forward-only enumerator to be returned. Forward-only enumerators are generally much faster and use less memory than conventional enumerators, but they do not allow calls to SWbemObject.Clone_.
wbemFlagBidirectional             = $00000000; //Causes WMI to retain pointers to objects of the enumeration until the client releases the enumerator.
wbemFlagReturnImmediately         = $00000010; //Causes the call to return immediately.
wbemFlagReturnWhenComplete        = $00000000; //Causes this call to block until the query is complete. This flag calls the method in the synchronous mode.
wbemQueryFlagPrototype            = $00000002; //Used for prototyping. It stops the query from happening and returns an object that looks like a typical result object.
wbemFlagUseAmendedQualifiers      = $00020000; //Causes WMI to return class amendment data with the base class definition. For more information, see Localizing WMI Class Information.
{$ENDIF}

type
  TWmiClass=class//(TObject)
  private
    {$IFDEF WbemScripting_TLB}
    FSWbemLocator   : ISWbemLocator;
    FWMIService     : ISWbemServices;
    {$ENDIF}
    {$IFDEF WMI_LateBinding}
    FSWbemLocator   : OleVariant;
    FWMIService     : OleVariant;
    {$ENDIF}
    {$IFDEF FPC}
    FWmiServer      : WideString;
    FWmiUser        : WideString;
    FWmiPass        : WideString;
    FWmiNameSpace   : WideString;
    FWmiClass       : WideString;
    {$ELSE}
    FWmiServer      : string;
    FWmiUser        : string;
    FWmiPass        : string;
    FWmiNameSpace   : string;
    FWmiClass       : string;
    {$ENDIF}

    FWmiConnected   : Boolean;
    FWMiDataLoaded  : Boolean;
    FWmiIsLocal     : Boolean;
    FWmiPropsNames  : TStrings;
    procedure DisposeCollection;
   {$IFDEF FPC}
    procedure SetWmiServer(const Value: WideString);
    procedure SetWmiUser(const Value: WideString);
    procedure SetWmiPass(const Value: WideString);
   {$ELSE}
    procedure SetWmiServer(const Value: string);
    procedure SetWmiUser(const Value: string);
    procedure SetWmiPass(const Value: string);
   {$ENDIF}
    procedure WmiConnect;
    function  GetPropValue(const PropName: string): OleVariant;
  protected
    FWmiCollection      : TList;
    FWmiCollectionIndex : Integer;
    function    _LoadWmiData: boolean;
    constructor Create(LoadData:boolean;const _WmiNamespace,_WmiClass:string); overload;
  public
    {$IFDEF FPC}
    property  WmiNameSpace  : WideString read FWmiNameSpace;
    property  WmiClass  : WideString read FWmiClass;
    property  WmiServer : WideString read FWmiServer write SetWmiServer;
    property  WmiUser : WideString read FWmiUser write SetWmiUser;
    property  WmiPass: WideString read FWmiPass write SetWmiPass;
    {$ELSE}
    property  WmiNameSpace  : string read FWmiNameSpace;
    property  WmiClass  : string read FWmiClass;
    property  WmiServer : string read FWmiServer write SetWmiServer;
    property  WmiUser : string read FWmiUser write SetWmiUser;
    property  WmiPass: string read FWmiPass write SetWmiPass;
    {$ENDIF}
    property  WmiConnected  : boolean read FWmiConnected;
    {$IFDEF WMI_LateBinding}
    property  SWbemLocator  : OleVariant read FSWbemLocator;
    property  WMIService    : OleVariant read FWMIService;
    function  GetNullValue  : OleVariant;
    {$ENDIF}
    {$IFDEF WbemScripting_TLB}
    property  SWbemLocator  : ISWbemLocator  read FSWbemLocator;
    property  WMIService    : ISWbemServices read FWMIService;
    function  GetNullValue : IDispatch;
    {$ENDIF}
    property  Value[const PropName : string] : OleVariant read GetPropValue; default;
    property  WmiCollectionIndex : integer read FWmiCollectionIndex  write FWmiCollectionIndex;
    function  GetCollectionCount:Integer;
    procedure SetCollectionIndex(Index: Integer);virtual;
    function  GetPropertyValue(const PropName: string): OleVariant;
    function  GetInstanceOf: OleVariant;
    procedure LoadWmiData;
    Destructor Destroy; override;
  end;
{
  TWmiError=class
  private
    FOperation: string;
    FProviderName: string;
    FParameterInfo: string;
  public
    property Operation : string read FOperation;
    property ParameterInfo : string read FParameterInfo;
    property ProviderName : string read FProviderName;
    constructor Create; overload;
    Destructor  Destroy; override;
  end;
}

  function VarStrNull(const V:OleVariant):string;
  function VarByteNull(const V:OleVariant):Byte;
  function VarWordNull(const V:OleVariant):Word;
  function VarSmallIntNull(const V:OleVariant):SmallInt;
  function VarIntegerNull(const V:OleVariant):Integer;
  function VarInt64Null(const V:OleVariant):Int64;
  function VarLongNull(const V:OleVariant):Longint;
  function VarBoolNull(const V:OleVariant):Boolean;
  function VarDoubleNull(const V:OleVariant):Double;
  function VarDateTimeNull(const V : OleVariant): TDateTime; //UTC


implementation

uses
 ComObj, Windows, Variants, Activex,  SysUtils;

type
  TVariantValueClass=class
   Value      : OleVariant;
  end;

  TDataWmiClass=class
   PropsValues : Array of OleVariant;
   //PropsValues : TStringList;
   InstanceOf  : TVariantValueClass;
  end;



Const
 MaxNumProps             =256;
 DefaultDoubleNullValue  :Double=0.0;
 //DefaultDateTimeNullValue=0;
 DefaultByteNullValue    :Byte=0;
 DefaultWordNullValue    :Word=0;
 DefaultSmallIntNullValue:Smallint=0;
 DefaultIntegerNullValue :Integer=0;
 DefaultInt64NullValue   :Int64=0;
 DefaultLongNullValue    :Longint=0;
 DefaultBoolNullValue    :Boolean=False;

function CreateInstanceDataWmiClass: TDataWmiClass;
begin
  Result           :=TDataWmiClass.Create;
  Result.InstanceOf:=TVariantValueClass.Create;
  SetLength(Result.PropsValues,MaxNumProps);
end;

procedure DisposeDataWmiClass(DataWmiClass: TDataWmiClass);
var
 i : integer;
begin
  for i := 0 to MaxNumProps-1 do
   DataWmiClass.PropsValues[i]:=Unassigned;

  SetLength(DataWmiClass.PropsValues, 0);
  DataWmiClass.InstanceOf.Value:=Unassigned;
  DataWmiClass.InstanceOf.Free;
  DataWmiClass.Free;
end;


function VarDoubleNull(const V:OleVariant):Double;
begin
  Result:=DefaultDoubleNullValue;
  if not VarIsNull(V) then
    Result:=V;
end;

function VarStrNull(const V:OleVariant):string;
begin
  Result:='';
  if not VarIsNull(V) then
    Result:=V;//VarToStr(V);
end;

function VarByteNull(const V:OleVariant):Byte;
begin
  Result:=DefaultByteNullValue;
  if not VarIsNull(V) then
    Result:=V;
end;


function VarWordNull(const V:OleVariant):Word;
begin
  Result:=DefaultWordNullValue;
  if not VarIsNull(V) then
    Result:=V;
end;

function VarSmallIntNull(const V:OleVariant):SmallInt;
begin
  Result:=DefaultSmallIntNullValue;
  if not VarIsNull(V) then
    Result:=  V;
end;

function VarIntegerNull(const V:OleVariant):Integer;
begin
  Result:=DefaultIntegerNullValue;
  if not VarIsNull(V) then
    Result:=V;
end;

function VarInt64Null(const V:OleVariant):Int64;
begin
  Result:=DefaultInt64NullValue;
  if not VarIsNull(V) then
    Result:=0;
end;

function VarLongNull(const V:OleVariant):Longint;
begin
  Result:=DefaultLongNullValue;
  if not VarIsNull(V) then
    Result:=V;
end;

function VarBoolNull(const V:OleVariant):Boolean;
begin
  Result:=DefaultBoolNullValue;
  if not VarIsNull(V) then
    Result:=V;
end;

//Universal Time (UTC) format of YYYYMMDDHHMMSS.MMMMMM(+-)OOO.
//20091231000000.000000+000
function VarDateTimeNull(const V : OleVariant): TDateTime;
var
 Year, Month, Day    : Word;
 Hour, Min, Sec, MSec: Word;
 UtcStr              : string;
begin
  Result:=0;
  UtcStr:=VarStrNull(V);
  if Length(UtcStr)>=15 then
  begin
     Year  :=StrToInt(Copy(UtcStr,1,4));
     Month :=StrToInt(Copy(UtcStr,5,2));
     Day   :=StrToInt(Copy(UtcStr,7,2));

     Hour  :=StrToInt(Copy(UtcStr,9,2));
     Min   :=StrToInt(Copy(UtcStr,11,2));
     Sec   :=StrToInt(Copy(UtcStr,13,2));
     MSec  :=0;
     Result:=EncodeDate(Year, Month, Day)+EncodeTime(Hour, Min, Sec, MSec);
  end;
end;

{
function VarDateTimeNull(const V:OleVariant):TDateTime;
begin
  Result:=DefaultDateTimeNullValue;
  if VarIsArray(V) and not VarIsNull(V) then
    Result:= V[0]
  else
  if not VarIsNull(V) then
    Result:=V;
end;
}
{ TWmiClass }
constructor TWmiClass.Create(LoadData:boolean;const _WmiNamespace,_WmiClass:string);
begin
  inherited Create;
  {$IFNDEF FPC}
  CoInitialize(nil);
  {$ELSE}
  comobj.CoInitializeEx(nil, CoInitFlags);
  {$ENDIF}
  FWmiConnected       := False;
  FWmiIsLocal         := True;
  FWmiServer          := 'localhost';
  FWmiUser            := '';
  FWmiPass            := '';
  FWMiDataLoaded      := False;
  FWmiCollectionIndex := -1;
  FWmiCollection      := TList.Create;
  FWmiNameSpace       := _WmiNamespace;
  FWmiClass           := _WmiClass;
  FWmiPropsNames      := TStringList.Create;

  if LoadData then
    FWMiDataLoaded:=_LoadWmiData;
end;


destructor TWmiClass.Destroy;
begin
  FWmiPropsNames.Free;
  DisposeCollection;
  FWmiCollection.Free;
  {$IFDEF WMI_LateBinding}
  FSWbemLocator:=Unassigned;
  FWMIService  :=Unassigned;
  {$ENDIF}
  {$IFNDEF FPC}
  CoUninitialize;
  {$ENDIF}
  inherited;
end;

{$IFDEF FPC}
function GetWMIObject(const objectName: WideString): IDispatch;
var
  chEaten: PULONG;
  BindCtx: IBindCtx;
  Moniker: IMoniker;
begin
  OleCheck(CreateBindCtx(0, bindCtx));
  OleCheck(MkParseDisplayName(BindCtx, StringToOleStr(objectName), chEaten, Moniker));
  OleCheck(Moniker.BindToObject(BindCtx, nil, IDispatch, Result));
end;
{$ENDIF}

//http://www.computerperformance.co.uk/Logon/code/code_80070005.htm#Local_Security_and_Policies_and_DCOM
procedure TWmiClass.WmiConnect;
begin
   if not FWmiConnected then
   begin
     {$IFDEF WMI_LateBinding}
     {$IFDEF FPC}
      FSWbemLocator := CreateOleObject(SWbemScripting_SWbemLocator);
      FWMIService   := FSWbemLocator.ConnectServer(WmiServer, WmiNameSpace, WmiUser, WmiPass);
      //FWMIService      := GetWMIObject(Format('winmgmts:\\localhost\%s',[FWmiNameSpace]));
     {$ELSE}
      FSWbemLocator := CreateOleObject(SWbemScripting_SWbemLocator);
      FWMIService   := FSWbemLocator.ConnectServer(WmiServer, WmiNameSpace, WmiUser, WmiPass);
     {$ENDIF}
      if not FWmiIsLocal then
        FWMIService.Security_.ImpersonationLevel := wbemImpersonationLevelImpersonate;
     {$ENDIF}
     {$IFDEF WbemScripting_TLB}
       FSWbemLocator  := CoSWbemLocator.Create;
       FWMIService    := FSWbemLocator.ConnectServer(WmiServer, WmiNameSpace,WmiUser, WmiPass, '', '', 0, nil);
      if not FWmiIsLocal then
        FWMIService.Security_.ImpersonationLevel := wbemImpersonationLevelImpersonate;
     {$ENDIF}
      FWmiConnected   := True;
   end;
end;


function TWmiClass.GetCollectionCount: Integer;
begin
  Result:=FWmiCollection.Count;
end;

function TWmiClass.GetInstanceOf: OleVariant;
begin
  Result:=TDataWmiClass(FWmiCollection[FWmiCollectionIndex]).InstanceOf.Value;
end;

{$IFDEF WMI_LateBinding}
function TWmiClass.GetNullValue: OleVariant;
begin
  Result:=Null;
end;
{$ENDIF}

{$IFDEF WbemScripting_TLB}
function TWmiClass.GetNullValue: IDispatch;
begin
  Result:=nil;
end;
{$ENDIF}

function TWmiClass.GetPropertyValue(const PropName: string): OleVariant;
var
 i  : integer;
begin
  //i:=TDataWmiClass(FWmiCollection[FWmiCollectionIndex]).PropsValues.IndexOf(PropName);
  //Result:=TVariantValueClass(TDataWmiClass(FWmiCollection[FWmiCollectionIndex]).PropsValues.Objects[i]).Value;
  i     :=FWmiPropsNames.IndexOf(PropName);
  Result:=TDataWmiClass(FWmiCollection[FWmiCollectionIndex]).PropsValues[i];
end;

function TWmiClass.GetPropValue(const PropName: string): OleVariant;
begin
Result:=GetPropertyValue(PropName);
end;

//Improving Enumeration Performance  http://msdn.microsoft.com/en-us/library/aa390880%28VS.85%29.aspx
function TWmiClass._LoadWmiData: boolean;
var
  {$IFDEF WMI_LateBinding}
  objWbemObjectSet: OLEVariant;
  WmiProperties   : OLEVariant;
  {$ENDIF}
  {$IFDEF WbemScripting_TLB}
  objWbemObjectSet: ISWbemObjectSet;
  SWbemObject     : ISWbemObject;
  WmiProperties   : ISWbemPropertySet;
  {$ENDIF}
  oEnum           : IEnumvariant;
  {$IFDEF FPC}
  //iValue          : PULONG;
  oWmiObject      : Variant;
  PropItem        : Variant;
  WQL             : WideString;
  sValue          : WideString;
  {$ELSE}
  iValue          : Cardinal;
  PropItem        : OLEVariant;
  oWmiObject      : OLEVariant;
  {$ENDIF}
  i               : integer;
  oEnumProps      : IEnumVARIANT;
  DataWmiClass    : TDataWmiClass;
  {$IFDEF _DEBUG}
  dt              : TDateTime;
  dg              : TDateTime;
  {$ENDIF}
begin;
 DisposeCollection;
 result:=True;
  try
    {$IFDEF _DEBUG} dt:=now; {$ENDIF}
    WmiConnect;
    {$IFDEF _DEBUG} OutputDebugString(PAnsiChar('Connected '+FormatDateTime('hh:nn:ss.zzz', Now-dt))); {$ENDIF}

    {$IFDEF _DEBUG} dt:=now; {$ENDIF}

    {$IFDEF WMI_LateBinding}
    {$IFDEF FPC}
     WQL              := Format('SELECT * FROM %s',[FWmiClass]);
     objWbemObjectSet := FWMIService.ExecQuery( WQL,'WQL',0);
     oEnum            := IUnknown(objWbemObjectSet._NewEnum) as IEnumVariant;
    {$ELSE}
     objWbemObjectSet:= FWMIService.ExecQuery(Format('SELECT * FROM %s',[FWmiClass]),'WQL',wbemFlagForwardOnly);
     oEnum           := IUnknown(objWbemObjectSet._NewEnum) as IEnumVariant;
    {$ENDIF}
    {$ENDIF}
    {$IFDEF WbemScripting_TLB}
    objWbemObjectSet:= FWMIService.ExecQuery(Format('SELECT * FROM %s',[FWmiClass]),'WQL',wbemFlagForwardOnly,nil);
    oEnum           := (objWbemObjectSet._NewEnum) as IEnumVariant;
    {$ENDIF}
    {$IFDEF _DEBUG} OutputDebugString(PAnsiChar('Query Executed in '+FormatDateTime('hh:nn:ss.zzz', Now-dt))); {$ENDIF}

    {$IFDEF _DEBUG} dg:=now; {$ENDIF}

   {$IFDEF FPC}
    while oEnum.Next(1, oWmiObject, nil) = S_OK do
   {$ELSE}
    while oEnum.Next(1, oWmiObject, iValue) = S_OK do
   {$ENDIF}
    begin
       {$IFDEF WbemScripting_TLB}
       SWbemObject     := IUnknown(oWmiObject) as ISWBemObject;
       WmiProperties   := SWbemObject.Properties_;
       {$ENDIF}

       {$IFDEF WMI_LateBinding}
       WmiProperties := oWmiObject.Properties_;
       {$ENDIF}

      if FWmiPropsNames.Count=0 then
       begin
          {$IFDEF WMI_LateBinding}
          oEnumProps    := IUnknown(WmiProperties._NewEnum) as IEnumVariant;
          {$ENDIF}

          {$IFDEF WbemScripting_TLB}
          oEnumProps    := (WmiProperties._NewEnum) as IEnumVariant;
          {$ENDIF}
          {$IFDEF FPC}
          while oEnumProps.Next(1, PropItem, nil) = S_OK do
          {$ELSE}
          while oEnumProps.Next(1, PropItem, iValue) = S_OK do
          {$ENDIF}
          begin
            FWmiPropsNames.Add(PropItem.Name);
            PropItem:=Unassigned;
          end;
       end;


      DataWmiClass:=CreateInstanceDataWmiClass;
      FWmiCollection.Add(DataWmiClass);
      DataWmiClass.InstanceOf.Value:=oWmiObject;

      {$IFDEF _DEBUG} dt:=now; {$ENDIF}
         for i := 0 to FWmiPropsNames.Count - 1 do
         begin
          {$IFDEF WMI_LateBinding}
          {$IFDEF FPC}
          sValue:=FWmiPropsNames[i];
          DataWmiClass.PropsValues[i]:= WmiProperties.Item(sValue).Value;
          {$ELSE}
          DataWmiClass.PropsValues[i]:= WmiProperties.Item(FWmiPropsNames[i]).Value;
          {$ENDIF}
          {$ENDIF}
          {$IFDEF WbemScripting_TLB}
          DataWmiClass.PropsValues[i]:= WmiProperties.Item(FWmiPropsNames[i],0).Get_Value;
          {$ENDIF}
         end;
     oWmiObject    :=Unassigned; //avoid leak cause by  IEnumVARIANT.Next
    {$IFDEF _DEBUG} OutputDebugString(PAnsiChar('Pass in '+FormatDateTime('hh:nn:ss.zzz', Now-dt))); {$ENDIF}
    end;
    {$IFDEF _DEBUG} OutputDebugString(PAnsiChar('Assigned in '+FormatDateTime('hh:nn:ss.zzz', Now-dg))); {$ENDIF}

    if FWmiCollection.Count>0 then
     SetCollectionIndex(0);
  except
   Result:=False;
  end;
end;


procedure TWmiClass.SetCollectionIndex(Index: Integer);
begin
  raise Exception.Create(Format('You must override this method %s',['SetCollectionIndex']));
end;

procedure TWmiClass.DisposeCollection;
var
 i : integer;
begin
  if Assigned(FWmiCollection) then
  begin
    for i:= 0 to FWmiCollection.Count - 1 do
     DisposeDataWmiClass(TDataWmiClass(FWmiCollection[i]));
    FWmiCollection.Clear;
    FWmiCollectionIndex :=-1;
  end;
end;

{$IFDEF FPC}
procedure TWmiClass.SetWmiServer(const Value: WideString);
begin
  FWmiServer  := Value;
  FWmiIsLocal := false;
end;

procedure TWmiClass.SetWmiUser(const Value: WideString);
begin
  FWmiUser    := Value;
  FWmiIsLocal := false;
end;

procedure TWmiClass.SetWmiPass(const Value: WideString);
begin
  FWmiPass := Value;
  FWmiIsLocal := false;
end;
{$ELSE}
procedure TWmiClass.SetWmiServer(const Value: string);
begin
  FWmiServer  := Value;
  FWmiIsLocal := false;
end;

procedure TWmiClass.SetWmiUser(const Value: string);
begin
  FWmiUser    := Value;
  FWmiIsLocal := false;
end;

procedure TWmiClass.SetWmiPass(const Value: string);
begin
  FWmiPass := Value;
  FWmiIsLocal := false;
end;
{$ENDIF}

procedure TWmiClass.LoadWmiData;
begin
 _LoadWmiData;
end;

{ TWmiError }
{
constructor TWmiError.Create;
var
  objSWbemError :OleVariant;
begin
   inherited Create;
   CoInitialize(nil);
   objSWbemError  := CreateOleObject(SWbemScripting_SWbemLocator);
   FOperation     :=VarStrNull(objSWbemError.Operation);
   FProviderName  :=VarStrNull(objSWbemError.ProviderName);
   FParameterInfo :=VarStrNull(objSWbemError.ParameterInfo);
end;

destructor TWmiError.Destroy;
begin
  CoUninitialize;
  inherited;
end;
}
end.
