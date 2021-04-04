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
  Devices,
  I2C,
  Ultibo,
  OpenVG,       {Include the OpenVG unit so we can use the various types and structures}
  VGShapes,     {Include the VGShapes unit to give us access to all the functions}
  VC4,
  thermometer,
  barometer
   { Add additional units here };

 var
  WindowHandle:TWindowHandle;
  I2CDevice:PI2CDevice;
  Width: Integer;
  Height: Integer;

  data: array of Byte;
  status:Byte;

  Sysmod:Byte;
  ID:Byte;
  Ctl_reg1:Byte;
  Ctl_reg2:Byte;

  Phsb:Byte;
  Pmsb:Byte;
  Plsb:Byte;
  Tlsb:Byte;
  Thsb:Byte;

  Temp:Integer;
  Mbar:Integer;

  count:LongWord;
  Buffer: array of Byte;
  i2cregister:Byte;
  address: LongWord;

 begin
   WindowHandle:=ConsoleWindowCreate(ConsoleDeviceGetDefault,CONSOLE_POSITION_FULL,True);

  ConsoleWindowWriteLn(WindowHandle,'Hello Ultibo!');


  VGShapesInit(Width, Height);
  VGShapesBackground(102,51,0);
  vgSeti(VG_STROKE_CAP_STYLE,VG_CAP_ROUND);

  altimeter_brass('2157','0',250,500,300);
  barometer_brass('1052', 600,500,300);
  thermometer_brass('34',950,500,300);

  VGShapesEnd;
    {Sleep for 10 seconds}
  Sleep(100000);

   {Clear our screen, cleanup OpenVG and deinitialize VGShapes}
  VGShapesFinish;

   {VGShapes calls BCMHostInit during initialization, we should also call BCMHostDeinit to cleanup}
  BCMHostDeinit;

  ThreadHalt(0);
 end.

