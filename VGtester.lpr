program VGtester;

{$mode objfpc}{$H+}

{ Raspberry Pi Application                                                     }
{  Add your program code below, add additional units to the "uses" section if  }
{  required and create new units by selecting File, New Unit from the menu.    }
{                                                                              }
{  To compile your program select Run, Compile (or Run, Build) from the menu.  }

uses
  RaspberryPi,
  GlobalConfig,
  GlobalConst,
  GlobalTypes,
  Platform,
  console,
  Threads,
  SysUtils,
  Classes,
  Ultibo,
  OpenVG,       {Include the OpenVG unit so we can use the various types and structures}
  VGShapes,     {Include the VGShapes unit to give us access to all the functions}
  VC4,
  barometer
   { Add additional units here };

 var
  WindowHandle:TWindowHandle;
  Width: Integer;
  Height: Integer;

 begin
   WindowHandle:=ConsoleWindowCreate(ConsoleDeviceGetDefault,CONSOLE_POSITION_FULL,True);

  ConsoleWindowWriteLn(WindowHandle,'Hello Ultibo!');

  VGShapesInit(Width, Height);
  VGShapesBackground(102,51,0);
  vgSeti(VG_STROKE_CAP_STYLE,VG_CAP_ROUND);


  barometer_brass('1010',500,500,400);
  barometer_brass('960', 200,200,200);
  barometer_brass('1050',700,200,300);

  VGShapesEnd;
    {Sleep for 10 seconds}
  Sleep(100000);

   {Clear our screen, cleanup OpenVG and deinitialize VGShapes}
  VGShapesFinish;

   {VGShapes calls BCMHostInit during initialization, we should also call BCMHostDeinit to cleanup}
  BCMHostDeinit;

  ThreadHalt(0);
 end.

