function varargout = Upload(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Upload_OpeningFcn, ...
                   'gui_OutputFcn',  @Upload_OutputFcn, ...
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

% --- Executes just before Upload is made visible.
function Upload_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Upload_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

[filename, pathname] = uigetfile(...
        {'*.tif;*.jpg;*.pgm;*.gif';'*.*'},'File Selector');
    handles.filename = strcat(pathname,'\',filename);
    guidata(hObject, handles);
    handles.filename

    axes(handles.axes1)
    [x,~] = imread(handles.filename);
    axes(handles.axes1)
    imshow(x,[]);
    handles.image = x;
    
    handles.output = hObject;
    guidata(hObject,handles);
    
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)

function edit1_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit5_Callback(hObject, eventdata, handles)

function edit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)

if handles.radiobutton4.Value==1
    handles.quality=98;
    handles.quality = 2 - handles.quality/50;
    guidata(hObject,handles);
end

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)

if handles.radiobutton5.Value==1
    handles.quality=70;
    handles.quality = 2 - handles.quality/50;
    guidata(hObject,handles);
end

% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)

if handles.radiobutton6.Value==1
    handles.quality=49;
    handles.quality = 50/handles.quality;
    guidata(hObject,handles);
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)

if isfield(handles,'image')
    handles.image=handles.image;
       
    handles.quality=handles.quality;
    [img1,f4comp,f4decomp,img2,f2comp,f2decomp,fcomp,fdecomp,fdash,loss1,Loss2,Loss3,CompressionRatio] = Hierarchical_JPEG(handles.image,handles.quality);
    %handles.f4comp=f4comp; 
    guidata(hObject, handles);
    axes(handles.axes2)
    imshow(img1,[]);
    axes(handles.axes9)
    imshow(f4comp,[]);
    axes(handles.axes10)
    imshow(f4decomp,[]);
    axes(handles.axes3)
    imshow(img2,[]);
    axes(handles.axes8)
    imshow(f2comp,[]);
    axes(handles.axes12)
    imshow(f2decomp,[]);
    axes(handles.axes6)
    imshow(fcomp,[]);
    axes(handles.axes7)
    imshow(fdecomp,[]);
    axes(handles.axes5)
    imshow(fdash,[]);
    set(handles.edit1,'String',loss1)
    set(handles.edit2,'String',Loss2)
    set(handles.edit3,'String',Loss3)
    set(handles.edit5,'String',CompressionRatio)
    
end
