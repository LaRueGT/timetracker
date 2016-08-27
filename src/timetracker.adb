--calendar standard libraries
with Ada.Calendar, Ada.Calendar.Formatting;
--text io
with Ada.Text_IO;
--unbounded strings
with Ada.Strings.Unbounded, Ada.Strings.Unbounded.Text_IO;
--file IO
with Ada.Directories, Ada.Streams.Stream_IO;

use Ada.Calendar, Ada.Calendar.Formatting;
use Ada.Text_IO;
use Ada.Strings.Unbounded, Ada.Strings.Unbounded.Text_IO;
use Ada.Directories, Ada.Streams.Stream_IO;

procedure Timetracker is
   type Track_Record is
      record
         Name : Unbounded_String;
         Date : Time;
         Hours : Integer;
      end record;
   track : Track_Record;

   type Record_Array is array(1..100) of Track_Record;

   procedure Save_Records_To_File(File : in out Ada.Streams.Stream_IO.File_Type;
                                  Name : in String ) is
   begin
      Create(File, Out_File, Name);
      fileaccess := Stream(File);
      Track_Record'Write(fileaccess, track);
      Close(File);
   end Save_Records_To_File;

   procedure Output_Track_Record(track : in Track_Record) is
   begin
      Put_Line(track.Name);
      Put_Line(Image(Date => track.Date));
      Put_Line(Item => Integer'Image(track.Hours));
      New_Line;
   end Output_Track_Record;

   filehandle : Ada.Streams.Stream_IO.File_Type;
   fileaccess : Ada.Streams.Stream_IO.Stream_Access;

   --application logic variables
   records : Record_Array := Record_Array'(others =>
                                             (Hours => -1,
                                              Name => To_Unbounded_String(""),
                                              Date => Clock)
                                          );
   counter : Natural := 1;
   track_file : String := "trackingdb";

begin
   Put_Line("What are you tracking? ");
   track.Name := Get_Line;
   track.Date := Clock;
   Put_Line("How many hours have you done? ");
   track.Hours := Integer'Value(Get_Line);
   Output_Track_Record(track);
   Save_Records_To_File(filehandle, "trackingdb");
end Timetracker;
