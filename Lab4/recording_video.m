function RecordVideo()
vobj = videoinput('winvideo', 1);

vobj.TimeOut = Inf;
vobj.FrameGrabInterval = 1;
vobj.LoggingMode = 'disk&memory';
vobj.FramesPerTrigger = 1;
vobj.TriggerRepeat = Inf;

timenow = datestr(now,'hhMMss_ddmmyy');
v = VideoWriter(['newfile_', timenow,'.avi']);
v.Quality = 50;
v.FrameRate = 30;
vobj.DiskLogger = v;

% Select the source to use for acquisition.
vobj.SelectedSourceName = 'input1';

% Create a customized GUI.
f = figure('Name', 'Video Recording Preview');
uicontrol('String', 'Rec Stop', 'Callback', 'close(gcf)');

% Create an image object for previewing.
vidRes = vobj.VideoResolution;
nBands = vobj.NumberOfBands;
hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
preview(vobj, hImage);
start(vobj)
uiwait(f)
stop(vobj)
delete(vobj);
