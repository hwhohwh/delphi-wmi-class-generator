//**************************************************************************************************
//                                                                                                  
// Unit ListView_Helper                                                                             
// Helper functions to hanle TListView for the Delphi Wmi Class generator                           
// https://github.com/RRUZ/delphi-wmi-class-generator                                               
//                                                                                                  
// The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); 
// you may not use this file except in compliance with the License. You may obtain a copy of the    
// License at http://www.mozilla.org/MPL/                                                           
//                                                                                                  
// Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   
// ANY KIND, either express or implied. See the License for the specific language governing rights  
// and limitations under the License.                                                               
//                                                                                                  
// The Original Code is ListView_Helper.pas.                                                        
//                                                                                                  
// The Initial Developer of the Original Code is Rodrigo Ruz V.                                     
// Portions created by Rodrigo Ruz V. are Copyright (C) 2010-2015 Rodrigo Ruz V.                    
// All Rights Reserved.                                                                             
//                                                                                                  
//**************************************************************************************************

unit ListView_Helper;

interface
uses
CommCtrl,
ComCtrls;

const
LVSCW_AUTOSIZE_BESTFIT=-3;

procedure AutoResizeColumn(const Column:TListColumn;const Mode:Integer=LVSCW_AUTOSIZE_BESTFIT);
procedure AutoResizeColumns(const Columns : Array of TListColumn;const Mode:Integer=LVSCW_AUTOSIZE_BESTFIT);
procedure AutoResizeListView(const ListView : TListView;const Mode:Integer=LVSCW_AUTOSIZE_BESTFIT);

implementation


procedure AutoResizeColumn(const Column:TListColumn;const Mode:Integer=LVSCW_AUTOSIZE_BESTFIT);
var
 Width : Integer;
begin
   Case Mode of
    LVSCW_AUTOSIZE_BESTFIT  : begin
                                 Column.Width := LVSCW_AUTOSIZE;
                                 Width        := Column.Width;
                                 Column.Width := LVSCW_AUTOSIZE_USEHEADER;
                                 if Width>Column.Width then
                                 Column.Width := LVSCW_AUTOSIZE;
                              end;

    LVSCW_AUTOSIZE           : Column.Width := LVSCW_AUTOSIZE;
    LVSCW_AUTOSIZE_USEHEADER : Column.Width := LVSCW_AUTOSIZE_USEHEADER;
   End;
end;

procedure AutoResizeColumns(const Columns : Array of TListColumn;const Mode:Integer=LVSCW_AUTOSIZE_BESTFIT);
var
  i : integer;
begin
  for i := Low(Columns) to High(Columns) do
   AutoResizeColumn(Columns[i],Mode);
end;

procedure AutoResizeListView(const ListView : TListView;const Mode:Integer=LVSCW_AUTOSIZE_BESTFIT);
var
  i : integer;
begin
  for i:=0 to ListView.Columns.Count-1 do
   AutoResizeColumn(ListView.Columns[i],Mode);
end;

end.
