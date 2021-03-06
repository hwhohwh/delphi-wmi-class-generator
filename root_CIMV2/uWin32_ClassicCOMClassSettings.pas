/// <summary>
/// Unit generated using the Delphi Wmi class generator tool, Copyright Rodrigo Ruz V. 2010-2012
/// Application version 1.0.4674.62299
/// WMI version 7601.17514
/// Creation Date 17-10-2012 18:18:16
/// Namespace root\CIMV2 Class Win32_ClassicCOMClassSettings
/// MSDN info about this class http://msdn2.microsoft.com/library/default.asp?url=/library/en-us/wmisdk/wmi/Win32_ClassicCOMClassSettings.asp
/// </summary>


unit uWin32_ClassicCOMClassSettings;

interface

uses
 Classes,
 Activex,
 Variants,
 ComObj,
 uWmiDelphiClass;

type
  {$REGION 'Documentation'}
  /// <summary>
  /// The Win32_ClassicCOMClassSettings class represents an association between a COM 
  /// class and the settings used to configure instances of the COM class.
  /// </summary>
  {$ENDREGION}
  TWin32_ClassicCOMClassSettings=class(TWmiClass)
  private
    FElement                            : OleVariant;
    FSetting                            : OleVariant;
  public
   constructor Create(LoadWmiData : boolean=True); overload;
   destructor Destroy;Override;
   {$REGION 'Documentation'}
   /// <summary>
   /// The Element reference represents the COM class where the settings are applied.
   /// </summary>
   {$ENDREGION}
   property Element : OleVariant read FElement;
   {$REGION 'Documentation'}
   /// <summary>
   /// The Setting reference represents configuration settings associated with the COM 
   /// class.
   /// </summary>
   {$ENDREGION}
   property Setting : OleVariant read FSetting;
   procedure SetCollectionIndex(Index : Integer); override;
  end;



implementation


{TWin32_ClassicCOMClassSettings}

constructor TWin32_ClassicCOMClassSettings.Create(LoadWmiData : boolean=True);
begin
  inherited Create(LoadWmiData,'root\CIMV2','Win32_ClassicCOMClassSettings');
end;

destructor TWin32_ClassicCOMClassSettings.Destroy;
begin
  inherited;
end;

procedure TWin32_ClassicCOMClassSettings.SetCollectionIndex(Index : Integer);
begin
  if (Index>=0) and (Index<=FWmiCollection.Count-1) and (FWmiCollectionIndex<>Index) then
  begin
    FWmiCollectionIndex:=Index;
    FElement      := inherited Value['Element'];
    FSetting      := inherited Value['Setting'];
  end;
end;

end.
