unit barometer;

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


procedure barometer_brass(pressure:string; x,y,r:LongWord) ;
procedure altimeter_brass(altitude,sealevel:string; x,y,r:LongWord) ;

implementation

procedure altimeter_brass(altitude,sealevel:string; x,y,r:LongWord );
    var
       Ticks:Integer;
       PosDeg:VGfloat;
       PosNum:VGfloat;
       PosT1:VGfloat;
       PosT2:VGfloat;
       PosT3:VGfloat;
       PosT4:VGfloat;
       PosT5:VGfloat;
       PosT6:VGfloat;

       Dial:VGfloat;
       Needle:VGfloat;
       mbar :Integer;
       height, code:Integer;

       Fontsize:Integer;

       feet: string;
       inhg: string;

     begin

       val(altitude,height, code);
       //convert to mbar angle
       //mbar := barometric - 960;

       VGShapesTranslate(x,y);
       PosT1:= r / 2 * 0.85;
       PosT2:= r / 2 * 0.81;
       PosT3:= r / 2 * 0.77;
       PosT4:= r / 2 * 0.73;
       PosT5:= r / 2 * 0.70;
       PosT6:= r / 2 * 0.60;

       PosNum:= r / 2 * 0.87;
       Needle:= r / 2 * 0.82;
       Dial:= r * 1.0;

       VGShapesStrokeWidth(Dial / 30);
       VGShapesStroke(181,166,66,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0, Dial);

       VGShapesStrokeWidth(Dial * 0.002);
       VGShapesStroke(0,0,0,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0,2 * PosT1);

       VGShapesStrokeWidth(Dial * 0.002);
       VGShapesStroke(0,0,0,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0,2 * PosT2);

       Fontsize:= 12;
       VGShapesFill(0,0,0,1);
       //VGShapesTextMid(0,Dial * 0.6,IntToStr(Speed),VGShapesSerifTypeface,Fontsize);


       Fontsize:=Trunc(Dial * 0.03);
       VGShapesRotate(-30);
       for Ticks := 0 to 100 do
           Begin

                if Ticks mod 10 = 0 then
                Begin
                  feet := IntToStr(Ticks * 100);
                  VGShapesStrokeWidth(Dial * 0.01);
                  VGShapesTextMid(0,PosNum,feet,VGShapesSansTypeface,Fontsize);
                end

                else
                   VGShapesStrokeWidth(Dial * 0.003);

                VGShapesLine(0,PosT1, 0,PosT2);
                VGShapesRotate(3);
          end;

       VGShapesRotate(57);

       VGShapesStrokeWidth(Dial * 0.003);
       for Ticks := 0 to 200 do
           Begin
                VGShapesLine(0,PosT2, 0,PosT3);
                VGShapesRotate(1.5);
           end;
       VGShapesRotate(40);
       VGShapesTextMid(0,PosNum,'Feet',VGShapesSansTypeface,Fontsize);
       VGShapesRotate(-40);

       VGShapesStrokeWidth(Dial * 0.001);
       VGShapesStroke(0,0,0,1);
       VGShapesFill(255,255,200,1);
       VGShapesCircle(0,0,2 * PosT3);

       mbar:= 31;

       VGShapesFill(0,0,0,1);
       Fontsize:=Trunc(Dial * 0.045);
       VGShapesRotate(30);

       for Ticks := 0 to 100 do
           Begin

                if Ticks mod 10 = 0 then
                  Begin
                    inhg := IntToStr(mbar);
                    VGShapesStrokeWidth(Dial * 0.003);
                    VGShapesTextMid(0,PosT6,inhg,VGShapesSansTypeface,Fontsize);
                    VGShapesLine(0,PosT3, 0,PosT5);
                    dec(mbar);
                  end

                else
                  begin
                   VGShapesStrokeWidth(Dial * 0.003);
                   VGShapesLine(0,PosT3, 0,PosT4);
                  end;
                VGShapesRotate(3);
          end;


       // set to 0 feet
       VGShapesRotate(85.5);

       VGShapesStroke(0,0,0,1);
       VGShapesFill(0,0,0,1);
       VGShapesCircle(0,0,Dial * 0.08);

       VGShapesRotate(height  * 0.03);
       VGShapesStrokeWidth(Dial * 0.010);
       VGShapesLine(0,0, 0,Needle);
       VGShapesRotate(height  * -0.03);

        //return to zero rotation
       VGShapesRotate(30);

       //reset back to zero position
       VGShapesTranslate(-x,-y);


  end;




procedure barometer_brass(pressure:string; x,y,r:LongWord );
    var
       Ticks:Integer;
       PosDeg:VGfloat;
       PosNum:VGfloat;
       PosT1:VGfloat;
       PosT2:VGfloat;
       Dial:VGfloat;
       Needle:VGfloat;
       mbar :Integer;
       barometric, code:Integer;

       Fontsize:Integer;

       gauge: string;

     begin

       val(pressure,barometric, code);
       //convert to mbar angle
       mbar := barometric - 960;

       VGShapesTranslate(x,y);
       PosT1:= r / 2 * 0.95;
       PosT2:= r / 2 * 0.88;

       PosNum:= r / 2 * 0.75;
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
       //VGShapesTextMid(0,Dial * 0.6,IntToStr(Speed),VGShapesSerifTypeface,Fontsize);


       Fontsize:=Trunc(Dial * 0.05);
       VGShapesRotate(-210);
       for Ticks := 960 to 1060 do
           Begin

                if Ticks mod 10 = 0 then
                Begin
                  gauge := IntToStr(Ticks);
                  VGShapesStrokeWidth(Dial * 0.01);
                  VGShapesTextMid(0,PosNum,gauge,VGShapesSansTypeface,Fontsize);
                end

                else
                   VGShapesStrokeWidth(Dial * 0.002);

                VGShapesLine(0,PosT1, 0,PosT2);
                VGShapesRotate(-3);
          end;
       // set to 960 mbar
       VGShapesRotate(-57);

       VGShapesStroke(0,0,0,1);
       VGShapesFill(0,0,0,1);
       VGShapesCircle(0,0,Dial * 0.08);

       VGShapesRotate(mbar  * -3);
       VGShapesStrokeWidth(Dial * 0.015);
       VGShapesLine(0,0, 0,Needle);
       VGShapesRotate(mbar  * 3);

        //return to zero rotation
       VGShapesRotate(210);

       //reset back to zero position
       VGShapesTranslate(-x,-y);


  end;

end.

