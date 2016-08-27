with Ada.Calendar, Ada.Calendar.Formatting;
with Ada.Text_IO;
with Ada.Strings.Unbounded, Ada.Strings.Unbounded.Text_IO;

use Ada.Calendar, Ada.Calendar.Formatting;
use Ada.Text_IO;
use Ada.Strings.Unbounded, Ada.Strings.Unbounded.Text_IO;

procedure Timetracker is
   track : Unbounded_String;
   date : Time := Clock;
begin
   Put_Line("What are you tracking? ");
   track := Get_Line;
   Put_Line(track);
   Put_Line(Image(Date => date));
   New_Line;
end Timetracker;
