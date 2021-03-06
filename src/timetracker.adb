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

--trying some things out
procedure Timetracker is
   type Track_Record is
      record
         Name: Unbounded_String;
         Date: Time;
         Hours: Integer;
      end record;
   type Record_Array is array(1..100) of Track_Record;

   filehandle: Ada.Streams.Stream_IO.File_Type;
   fileaccess: Ada.Streams.Stream_IO.Stream_Access;

   --application logic variables
   track: Track_Record;
   records: Record_Array := Record_Array'(others =>
                                             (Hours => -1,
                                              Name => To_Unbounded_String(""),
                                              Date => Clock)
                                          );
   counter: Natural := 1;
   track_file: String := "trackingdb";

   procedure Output_Track_Record(track: in Track_Record) is
   begin
      Put_Line(track.Name);
      Put_Line(Image(Date => track.Date));
      Put_Line(Item => Integer'Image(track.Hours));
      New_Line;
   end Output_Track_Record;

   procedure Read_In_Records(File: in out Ada.Streams.Stream_IO.File_Type;
                             Name: in String) is
   begin
      Open(File, In_File, Name);
      fileaccess := Ada.Streams.Stream_IO.Stream(File);
      While not End_Of_File(File) loop
         Track_Record'Read(fileaccess, track);
         Output_Track_Record(track);
         records(counter) := track;
         counter := counter +1;
      end loop;
      Close(File);
   end Read_In_Records;


   procedure Save_Records_To_File(File: in out Ada.Streams.Stream_IO.File_Type;
                                  Name: in String ) is
   begin
      Create(File, Out_File, Name);
      fileaccess := Stream(File);
      for T in records'Range loop
         if (records (T).Hours /= -1) then
            Track_Record'Write (fileaccess, records (T));
         end if;
      end loop;
      Close(File);
   end Save_Records_To_File;


   procedure Get_New_Track is
   begin
      Put_Line("What are you tracking? ");
      track.Name := Get_Line;
      track.Date := Clock;
      Put_Line ("How many hours have you done? ");
      track.Hours := Integer'Value (Get_Line);
      records (counter) := track;
   end Get_New_Track;


begin
   if (Exists (track_file)) then
      Read_In_Records (filehandle, track_file);
   end if;
   Save_Records_To_File(filehandle, track_file);
end Timetracker;
