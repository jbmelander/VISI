function varargout = VISI(varargin)
% VISI MATLAB code for VISI.fig
%      VISI, by itself, creates a new VISI or raises the existing
%      singleton*.
%
%      H = VISI returns the handle to a new VISI or the handle to
%      the existing singleton*.
%
%      VISI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VISI.M with the given input arguments.
%
%      VISI('Property','Value',...) creates a new VISI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VISI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VISI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VISI

% Last Modified by GUIDE v2.5 25-Nov-2017 15:37:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VISI_OpeningFcn, ...
                   'gui_OutputFcn',  @VISI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before VISI is made visible.
function VISI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VISI (see VARARGIN)
global isi;
isi.bvmap = cat(3,zeros(300,400),zeros(300,400),zeros(300,400));
isi.binarymode = 0;
isi.isi1 = zeros(300,400);
isi.isi2 = zeros(300,400);
isi.isi3 = zeros(300,400);
isi.plotimg = cat(3,zeros(300,400),zeros(300,400),zeros(300,400));
isi.slider1 = 0.7;
isi.lowslider1 = 0.7;
isi.lowslider2 = 0.7;
isi.lowslider3 = 0.7;
isi.slider2 = 0.7;
isi.slider3 = 0.7;
isi.bvslider = 0.7;
isi.onoff = 1;
isi.left = 0;
isi.right = 0;
isi.bv_adjust = 0.75
isi.mirror = 0;
isi.mean_rotational_angle_deg = 0;
isiplot(handles);
set(handles.isi1rdio,'Value',1);
set(handles.isi2rdio,'Value',1);
set(handles.isi3rdio,'Value',1);

% Choose default command line output for VISI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VISI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VISI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function main_axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to main_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate main_axes
set(hObject,'xtick',[]);
set(hObject,'ytick',[]);
set(hObject,'yticklabel',[]);
set(hObject,'xticklabel',[]);


% --- Executes on button press in load_bvmap.
function load_bvmap_Callback(hObject, eventdata, handles)
% hObject    handle to load_bvmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isi;
isi.bvmap = fig2rgb(getfile);
isiplot(handles);

% --- Executes on slider movement.
function bv_slider_Callback(hObject, eventdata, handles)
% hObject    handle to bv_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global isi;
isi.bvslider = get(hObject,'Value');
isiplot(handles);

% --- Executes during object creation, after setting all properties.
function bv_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bv_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in isi1.
function isi1_Callback(hObject, eventdata, handles)
% hObject    handle to isi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isi;
isi.isi1 = process_isi(getfile,3:5,12:20);
isi.isi1(isi.isi1<0) = 0;
isi.isi1 = isi.isi1 / max(max(isi.isi1));
isiplot(handles);


% --- Executes on slider movement.
function isi1slider_Callback(hObject, eventdata, handles)
% hObject    handle to isi1slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global isi;
isi.slider1 = get(hObject, 'Value');
isiplot(handles);
% --- Executes during object creation, after setting all properties.
function isi1slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isi1slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in isi2.
function isi2_Callback(hObject, eventdata, handles)
% hObject    handle to isi2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isi;
isi.isi2 = process_isi(getfile,3:5,12:20);
isi.isi2(isi.isi2<0) = 0;
isi.isi2 = isi.isi2 / max(max(isi.isi2));
isiplot(handles);


% --- Executes on slider movement.
function isi2slider_Callback(hObject, eventdata, handles)
% hObject    handle to isi2slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global isi;
isi.slider2 = get(hObject,'Value');
isiplot(handles);

% --- Executes during object creation, after setting all properties.
function isi2slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isi2slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in isi3.
function isi3_Callback(hObject, eventdata, handles)
% hObject    handle to isi3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isi;
isi.isi3 = process_isi(getfile,3:5,12:20);
isi.isi3(isi.isi3 < 0) = 0;
isi.isi3 = isi.isi3 / max(max(isi.isi3));
isiplot(handles);

% --- Executes on slider movement.
function isi3slider_Callback(hObject, eventdata, handles)
% hObject    handle to isi3slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global isi;
isi.slider3 = get(hObject,'Value');
isiplot(handles);




% --- Executes during object creation, after setting all properties.
function isi3slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isi3slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function isiplot(handles)
global isi;

if isi.onoff == 1
    axes(handles.main_axes)
    isi.bvmap2 = isi.bvmap*isi.bv_adjust;
    bvmap_adjusted = adjust_rgb_lut(isi.bvmap2,0,isi.bvslider);
    isi1_adjusted = adjust_rgb_lut(isi.isi1,isi.lowslider1,isi.slider1);
    isi2_adjusted = adjust_rgb_lut(isi.isi2,isi.lowslider2,isi.slider2);
    isi3_adjusted = adjust_rgb_lut(isi.isi3,isi.lowslider3,isi.slider3);
    if get(handles.isi1rdio,'Value') == 0
        isi1_adjusted = zeros(300,400);
    end
    
    if get(handles.isi2rdio,'Value') == 0
        isi2_adjusted = zeros(300,400);
    end
    
    if get(handles.isi3rdio,'Value') == 0
        isi3_adjusted = zeros(300,400);
    end
    
    
    isiz = cat(3,isi1_adjusted,isi2_adjusted,isi3_adjusted);
    
    
    

    isi.plotimg = bvmap_adjusted + isiz;
    isi.plotimg(isi.plotimg>1) = 1;
    isi.plotimg(isi.plotimg<0) = 0;
    imagesc(isi.plotimg);
else 
    axes(handles.main_axes);
    bvmap_adjusted = adjust_rgb_lut(isi.bvmap,0,isi.bvslider);
    isi.plotimg = bvmap_adjusted;
    imagesc(isi.plotimg);
end
isi.left
if isi.left == 1
    axes(handles.main_axes);
    imagesc(imrotate(isi.plotimg,270));
end

if isi.right == 1
    axes(handles.main_axes);
    imagesc(imrotate(isi.plotimg,90));
end

if isi.mirror == 1
    axes(handles.main_axes);
    for i = 1:3
        isi.mirrorimg(:,:,i) = flipud(isi.plotimg(:,:,i));
    end
    imagesc(imrotate(isi.mirrorimg,90));
end


% --- Executes on button press in isi_onoff.
function isi_onoff_Callback(hObject, eventdata, handles)
% hObject    handle to isi_onoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of isi_onoff

global isi;
isi.onoff = get(hObject,'Value');
isiplot(handles);


% --- Executes during object creation, after setting all properties.
function isi_onoff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isi_onoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in right_radio.
function right_radio_Callback(hObject, eventdata, handles)
% hObject    handle to right_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of right_radio
global isi;
isi.right = get(hObject,'Value');
isiplot(handles);

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isi;
isi.left = get(hObject,'Value');
isiplot(handles);

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in CoDe.
function CoDe_Callback(hObject, eventdata, handles)
% hObject    handle to CoDe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.main_axes;
global isi;
[isi.x,isi.y] = ginput(2);
aa = inputdlg('um known')

isi.knowndistance = str2num(aa{1})
isi.width_coordinates = [isi.x(1),isi.y(1);isi.x(2),isi.y(2)];

isi.umperpixel = isi.knowndistance/(pdist(isi.width_coordinates,'euclidean'));
%hardcoded 3000 since standard window size is 3m
set(handles.text3, 'String', ['um/pixel: ' num2str(isi.umperpixel)]);




% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
global isi;

isi.mirror = get(hObject,'Value');
isiplot(handles);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isi;
handles.main_axes;
if get(handles.applycorrection,'Value') == 0
    isi.current_coordinates = [isi.zero_coordinate(1) - isi.currentx/isi.umperpixel, isi.zero_coordinate(2) + isi.currenty/isi.umperpixel];
    axes(handles.main_axes);
    isi.current_roi = viscircles(isi.current_coordinates,3,'EdgeColor','y','lineWidth',3);
elseif get(handles.applycorrection,'Value') == 1
    isi.current_coordinates = [isi.zero_coordinate(1) - isi.currentx/isi.umperpixel, isi.zero_coordinate(2) + isi.currenty/isi.umperpixel];
    axes(handles.main_axes);
    isi.corrected_current_coordinates = angular_coordinate_correction(handles,isi.current_coordinates);
    isi.current_roi = viscircles(isi.corrected_current_coordinates,3,'EdgeColor','k','lineWidth',3);
end

    
    
    
    
function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

global isi
isi.currentx = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
global isi;
isi.currenty = str2double(get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
global isi
isi.bv_adjust = str2double(get(hObject,'String'));
isiplot(handles);


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isi;
handles.main_axes;
[isi.zerox,isi.zeroy] = ginput(1);
isi.zero_coordinate = [isi.zerox,isi.zeroy];
axes(handles.main_axes);
isi.zero_roi = viscircles(isi.zero_coordinate,3,'EdgeColor','b','lineWidth',3);


% --- Executes during object creation, after setting all properties.
function text3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in isi1rdio.
function isi1rdio_Callback(hObject, eventdata, handles)
% hObject    handle to isi1rdio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of isi1rdio
isiplot(handles);

% --- Executes on button press in isi2rdio.
function isi2rdio_Callback(hObject, eventdata, handles)
% hObject    handle to isi2rdio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of isi2rdio
isiplot(handles);

% --- Executes on button press in isi3rdio.
function isi3rdio_Callback(hObject, eventdata, handles)
% hObject    handle to isi3rdio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of isi3rdio
isiplot(handles);


% --------------------------------------------------------------------
function retrvcoordinates_Callback(hObject, eventdata, handles)
% hObject    handle to retrvcoordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function retreive_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to retreive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Beginning Alignment Algorithm ...')
global isi;
ERROR_THRESHOLD = 10; %microns
axes(handles.main_axes);
[x,y] = ginput(3);

isi.isi_fiducial_coordinates = [];
for i = 1:length(x)
    isi.isi_fiducial_coordinates(i,1) = x(i);
    isi.isi_fiducial_coordinates(i,2) = y(i);
end

for i = 1:3
    isi.isi_fiducial_coordinates_fromOrigin(i,:) = isi.isi_fiducial_coordinates(i,:) - isi.zero_coordinate;
end


isi.user_fiducial_coordinates_input = inputdlg({'Fiducial 1 X','Fiducial 1 Y','Fiducial 2 X','Fiducial 2 Y','Fidicual 3 X','Fiducial 3 Y'},...
              'Fiducials', [1 20; 1 20; 1 20; 1 20 ; 1 20 ; 1 20]); 

j = 1;
for i = 1:3
    isi.user_fiducial_coordinates(i,1) = str2num(isi.user_fiducial_coordinates_input{j});
    j = j+1;
    isi.user_fiducial_coordinates(i,2) = -(str2num(isi.user_fiducial_coordinates_input{j}));
    j = j+1;
end

isi.naga_fiducial_distances = [];
isi.isi_fiducial_distances = [];
isi.fiducial_alignment_error = 0;
for i = 1:3
    isi.isi_fiducial_distances(i) = norm(isi.isi_fiducial_coordinates_fromOrigin(i,:));
    isi.naga_fiducial_distances(i) = norm(isi.user_fiducial_coordinates(i,:));
    if abs(isi.isi_fiducial_distances(i) - isi.naga_fiducial_distances(i)) > ERROR_THRESHOLD
        disp(['Fiducial Vector ' num2str(i) ' Misalignment Error']);
        isi.fiducial_alignment_error = 1;
    end
end

if isi.fiducial_alignment_error == 1;
    disp('Please correct fiducial alignment error!');
    return
end

for i = 1:3
    isi_fid = isi.isi_fiducial_coordinates_fromOrigin(i,:);
    naga_fid = isi.user_fiducial_coordinates(i,:);
    CosTheta = dot(isi_fid,naga_fid)/(norm(isi_fid)*norm(naga_fid));
    isi.rotational_angle_degrees(i) = acos(CosTheta)*180/pi; 
    isi.rotational_angle_radians(i) = isi.rotational_angle_degrees(i)*pi/180;
end

disp('Rotational Angles (Degrees): ');
disp(isi.rotational_angle_degrees);

% NEED TO ACCOUNT FOR DIFFERENT COORDINATE SYSTEMS
ROTATIONAL_ANGLE_ERROR_THRESHOLD = 2; %degrees
max_ra = max(isi.rotational_angle_degrees);
min_ra = min(isi.rotational_angle_degrees);
if (max_ra - min_ra) > ROTATIONAL_ANGLE_ERROR_THRESHOLD
    disp('Rotational Angle Calculated Differently for Different Fiducials');
    disp('Please correct fiducial alignments');
    return

else
    set(handles.applycorrection,'BackgroundColor','g');
    isi.mean_rotational_angle_deg = mean(isi.rotational_angle_degrees);
end








    

    


% --- Executes on button press in applycorrection.
function applycorrection_Callback(hObject, eventdata, handles)
% hObject    handle to applycorrection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of applycorrection


% --- Executes during object creation, after setting all properties.
function applycorrection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to applycorrection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'BackgroundColor','r');



function [corrected_coordinates] = angular_coordinate_correction(handles,coordinates)
x = coordinates(1);
y = coordinates(2);
corrected_x = x*cosd(isi.mean_rotational_angle_deg) - y*sind(isi.mean_rotational_angle_deg);
corrected_y = x*sind(isi.mean_rotational_angle_deg) + y*cosd(isi.mean_rotational_angle_deg);
corrected_coordinates = [corrected_x corrected_y];


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h = figure('position',[100 100 600 600]);
c = copyobj(handles.main_axes,h);


% --- Executes on slider movement.
function lowerisi1slider_Callback(hObject, eventdata, handles)
% hObject    handle to lowerisi1slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global isi;
isi.lowslider1 = get(hObject,'Value');
isiplot(handles);

% --- Executes during object creation, after setting all properties.
function lowerisi1slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerisi1slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global isi;
isi.lowslider2 = get(hObject,'Value');
isiplot(handles);




% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global isi;
isi.lowslider3 = get(hObject,'Value');
isiplot(handles);

% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1
global isi;
isi.binarymode = get(hObject,'Value');
isiplot(handles);
