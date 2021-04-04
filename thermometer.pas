unit thermometer;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  OpenVG,       {Include the OpenVG unit so we can use the various types and structures}
  VGShapes,     {Include the VGShapes unit to give us access to all the functions}
  VC4;


var

Width:Integer;  {A few variables used by our shapes example}
Height:Integer;


procedure thermometer_brass(temperature:string; x,y,r:LongWord) ;

implementation



procedure thermometer_brass(temperature:string; x,y,r:LongWord );
    var
       Ticks:Integer;
       PosDeg:VGfloat;
       PosNum:VGfloat;
       PosT1:VGfloat;
       PosT2:VGfloat;
       Dial:VGfloat;
       Needle:VGfloat;
       Celsius:Integer;
       code:Integer;

       Fontsize:Integer;

       Temp: string;

     begin

       val(temperature,Celsius, code);

       VGShapesTranslate(x,y);
       PosT1:= r / 2 * 0.95;
       PosT2:= r / 2 * 0.88;

       PosNum:= r / 2 * 0.70;
       Needle:= r / 2 * 0.92;
       Dial:= r * 1.0;

       VGShapesStrokeWidth(Dial / 30);
       VGShapesStroke(181,166,66,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0, Dial);

       VGShapesStrokeWidth(Dial * 0.005);
       VGShapesStroke(0,0,0,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0,2 * PosT1);

       VGShapesStrokeWidth(Dial * 0.005);
       VGShapesStroke(0,0,0,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0,2 * PosT2);

       Fontsize:= 12;
       VGShapesFill(0,0,0,1);

       Fontsize:=Trunc(Dial * 0.07);
       VGShapesRotate(-210);
       for Ticks := 0 to 50 do
           Begin

                if Ticks mod 5 = 0 then
                Begin
                  Temp := IntToStr(Ticks);
                  VGShapesStrokeWidth(Dial * 0.01);
                  VGShapesTextMid(0,PosNum,Temp,VGShapesSansTypeface,Fontsize);
                end

                else
                   VGShapesStrokeWidth(Dial * 0.002);

                VGShapesLine(0,PosT1, 0,PosT2);
                VGShapesRotate(-6);
          end;
       // set to O celsius
       VGShapesRotate(-54);

       VGShapesStroke(0,0,0,1);
       VGShapesFill(0,0,0,1);
       VGShapesCircle(0,0,Dial * 0.08);

       VGShapesRotate(Celsius * -6);
       VGShapesStrokeWidth(Dial * 0.025);
       VGShapesLine(0,0, 0,Needle);
       VGShapesRotate(Celsius * 6);

        //return to zero rotation
       VGShapesRotate(210);

       //reset back to zero position
       VGShapesTranslate(-x,-y);


  end;

end.

