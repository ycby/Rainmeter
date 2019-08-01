[MeterItem0]
Meter = String
X = 0R
Y = 5R
[MeterItem1]
Meter = String
MeterStyle = inputStyle
Group = 1
X = 10
Y = ([MeterItem0:Y] + [MeterItem0:H] + 4)
W = 390
Text = Hello
ClipString = 2
InlineSetting = None
DynamicVariables = 1
[MeterCheckBox1]
Meter = Image
ImageName = #@#Images\checkbox.png
X = 395
Y = ([MeterItem1:Y] + ([MeterItem1:H] / 2) - 10)
W = 20
H = 20
LeftMouseUpAction = [!ToggleMeter "MeterCheck1"][!CommandMeasure "MeasureTodoScript" "ToggleStrikethrough(1)"][!CommandMeasure "MeasureTodoScript" "ToggleCheck(1)"][!UpdateMeter MeterItem1][!Redraw]
DynamicVariables = 1
[MeterCheck1]
Meter = Image
ImageName = #@#Images\check.png
X = -17R
Y = -17R
W = 14
H = 14
Hidden = 1
;endItem1
[MeterItem2]
Meter = String
MeterStyle = inputStyle
Group = 2
X = 10
Y = ([MeterItem1:Y] + [MeterItem1:H] + 4)
W = 390
Text = What
ClipString = 2
InlineSetting = None
DynamicVariables = 1
[MeterCheckBox2]
Meter = Image
ImageName = #@#Images\checkbox.png
X = 395
Y = ([MeterItem2:Y] + ([MeterItem2:H] / 2) - 10)
W = 20
H = 20
LeftMouseUpAction = [!ToggleMeter "MeterCheck2"][!CommandMeasure "MeasureTodoScript" "ToggleStrikethrough(2)"][!CommandMeasure "MeasureTodoScript" "ToggleCheck(2)"][!UpdateMeter MeterItem2][!Redraw]
DynamicVariables = 1
[MeterCheck2]
Meter = Image
ImageName = #@#Images\check.png
X = -17R
Y = -17R
W = 14
H = 14
Hidden = 1
;endItem2
[MeterItem3]
Meter = String
MeterStyle = inputStyle
Group = 3
X = 10
Y = ([MeterItem2:Y] + [MeterItem2:H] + 4)
W = 390
Text = Why
ClipString = 2
InlineSetting = None
DynamicVariables = 1
[MeterCheckBox3]
Meter = Image
ImageName = #@#Images\checkbox.png
X = 395
Y = ([MeterItem3:Y] + ([MeterItem3:H] / 2) - 10)
W = 20
H = 20
LeftMouseUpAction = [!ToggleMeter "MeterCheck3"][!CommandMeasure "MeasureTodoScript" "ToggleStrikethrough(3)"][!CommandMeasure "MeasureTodoScript" "ToggleCheck(3)"][!UpdateMeter MeterItem3][!Redraw]
DynamicVariables = 1
[MeterCheck3]
Meter = Image
ImageName = #@#Images\check.png
X = -17R
Y = -17R
W = 14
H = 14
Hidden = 1
;endItem3
[MeterItem4]
Meter = String
MeterStyle = inputStyle
Group = 4
X = 10
Y = ([MeterItem3:Y] + [MeterItem3:H] + 4)
W = 390
Text = How
ClipString = 2
InlineSetting = None
DynamicVariables = 1
[MeterCheckBox4]
Meter = Image
ImageName = #@#Images\checkbox.png
X = 395
Y = ([MeterItem4:Y] + ([MeterItem4:H] / 2) - 10)
W = 20
H = 20
LeftMouseUpAction = [!ToggleMeter "MeterCheck4"][!CommandMeasure "MeasureTodoScript" "ToggleStrikethrough(4)"][!CommandMeasure "MeasureTodoScript" "ToggleCheck(4)"][!UpdateMeter MeterItem4][!Redraw]
DynamicVariables = 1
[MeterCheck4]
Meter = Image
ImageName = #@#Images\check.png
X = -17R
Y = -17R
W = 14
H = 14
Hidden = 1
;endItem4
