with Ada.Calendar, Ada.Calendar.Formatting;
with Ada.Text_IO;
with Ada.Strings.Unbounded, Ada.Strings.Unbounded.Text_IO;
use Ada.Calendar, Ada.Calendar.Formatting;
use Ada.Text_IO;
use Ada.Strings.Unbounded, Ada.Strings.Unbounded.Text_IO;

procedure Timetracker is
   type Track_Record is
      record
         Name : Unbounded_String;
         Date : Time;
         Hours : Integer;
      end record;
   track : Track_Record;

   procedure Output_Track_Record(track : in Track_Record) is
   begin
      Put_Line(track.Name);
      Put_Line(Image(Date => track.Date));
      Put_Line(Item => Integer'Image(track.Hours));
      New_Line;
   end Output_Track_Record;

begin
   Put_Line("What are you tracking? ");
   track.Name := Get_Line;
   track.Date := Clock;
   Put_Line("How mane hours have you done? ");
   track.Hours := Integer'Value(Get_Line);
   Output_Track_Record(track);
end Timetracker;
