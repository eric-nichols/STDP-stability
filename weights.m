function varargout = weights(varargin)
global window winFull

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @weights_OpeningFcn, ...
                   'gui_OutputFcn',  @weights_OutputFcn, ...
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

window = {'Symmetrical' 'SymmetricalHalf' 'ASymmetrical' 'ASymmetricalHalf'};
winFull = {' Symmetrical time window.' ...
  ' Symmetrical with 1.5 * (ASE_n_e_g, time_n_e_g) time window.' ...
  ' Asymmetrical time window.' ...
  ' Asymmetrical with 1.5 * (ASE_n_e_g, time_n_e_g) time window.'};

% --- Executes just before weights is made visible.
function weights_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject; % Default command line output for weights
guidata(hObject, handles); % Update handles structure

% print the starting plot
load('linearSymmetrical/2.mat');
for subP = 1:2 % for each subPlot
  if subP==2
    title('2 linear inputs. Symmetrical time window.')
  end
  subplot(2,1,subP,'Parent',handles.uipanel5)
  plot(weightMatrix(subP,1:29999))
  maxi = max(weightMatrix(subP,1:29999));
  mini = min(weightMatrix(subP,1:29999));
  xlabel(['synapse ' num2str(subP) ':   max=' num2str(maxi) '  min=' num2str(mini)]);
end % end for subP = 1:numInput



% --- Outputs from this function are returned to the command line.
function varargout = weights_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in linear.
function linear_Callback(hObject, eventdata, handles)
value(1, 1, handles)
set(hObject,'BackgroundColor','cyan');
set(handles.poisson,'BackgroundColor',[0.831 0.816 0.784]);

% --- Executes on button press in poisson.
function poisson_Callback(hObject, eventdata, handles)
value(1, 2, handles)
set(hObject,'BackgroundColor','cyan');
set(handles.linear,'BackgroundColor',[0.831 0.816 0.784]);

% --- Executes on button press in symmetrical.
function symmetrical_Callback(hObject, eventdata, handles)
value(2, 1, handles)

% --- Executes on button press in symmetricalHalf.
function symmetricalHalf_Callback(hObject, eventdata, handles)
value(2, 2, handles)

% --- Executes on button press in asymmetrical.
function asymmetrical_Callback(hObject, eventdata, handles)
value(2, 3, handles)

% --- Executes on button press in asymmetricalHalf.
function asymmetricalHalf_Callback(hObject, eventdata, handles)
value(2, 4, handles)

% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)

% --- Executes on button press in two.
function two_Callback(hObject, eventdata, handles)
value(3, 2, handles)

% --- Executes on button press in three.
function three_Callback(hObject, eventdata, handles)
value(3, 3, handles)

% --- Executes on button press in four.
function four_Callback(hObject, eventdata, handles)
value(3, 4, handles)

% --- Executes on button press in five.
function five_Callback(hObject, eventdata, handles)
value(3, 5, handles)

% --- Executes on button press in six.
function six_Callback(hObject, eventdata, handles)
value(3, 6, handles)

% keep the values persistent here
function value(toReset, num, handle)
persistent values
if isempty(values)
    values = [1 1 2]; % 1=input type 2=window type 3=number of inputs
end
switch toReset
  case 1
    values = reset_typeInput(num, handle, values);
  case 2
    values = reset_window(num, handle, values);
  case 3
    values = reset_numInputs(num, handle, values);
end

% reset the type of input
function [values] = reset_typeInput(num, handle, values)
values(1) = num;
new_plot(handle, values)

% reset the window
function [values] = reset_window(num, handle, values)
values(2) = num;
set(handle.symmetrical,'BackgroundColor',[0.831 0.816 0.784]);
set(handle.symmetricalHalf,'BackgroundColor',[0.831 0.816 0.784]);
set(handle.asymmetrical,'BackgroundColor',[0.831 0.816 0.784]);
set(handle.asymmetricalHalf,'BackgroundColor',[0.831 0.816 0.784]);
switch num
  case 1
    set(handle.symmetrical,'BackgroundColor','cyan');
  case 2
    set(handle.symmetricalHalf,'BackgroundColor','cyan');
  case 3
    set(handle.asymmetrical,'BackgroundColor','cyan');
  case 4
    set(handle.asymmetricalHalf,'BackgroundColor','cyan');
end
new_plot(handle, values)

% reset the number of inputs
function [values] =  reset_numInputs(num, handle, values)
values(3) = num;
set(handle.two,'BackgroundColor',[0.831 0.816 0.784]);
set(handle.three,'BackgroundColor',[0.831 0.816 0.784]);
set(handle.four,'BackgroundColor',[0.831 0.816 0.784]);
set(handle.five,'BackgroundColor',[0.831 0.816 0.784]);
set(handle.six,'BackgroundColor',[0.831 0.816 0.784]);
switch num
  case 2
    set(handle.two,'BackgroundColor','cyan');
  case 3
    set(handle.three,'BackgroundColor','cyan');
  case 4
    set(handle.four,'BackgroundColor','cyan');
  case 5
    set(handle.five,'BackgroundColor','cyan');
  case 6
    set(handle.six,'BackgroundColor','cyan');
end
new_plot(handle, values)


function new_plot(handle, values)
global window winFull
set(handle.uipanel5,'Visible','off');
% this 'if' is needed when moving from 6 to 4 inputs!!!
if values(3) == 4 
subplot(2,1,1,'Parent',handle.uipanel5)
plot([1:2])
end
numInputs = values(3);

if values(1) == 1 % linear
  titl = sprintf('%d linear inputs.    ', numInputs);
  folder = char(strcat('linear', window(values(2)), '/'));
else
  titl = sprintf('%d Poisson inputs.    ', numInputs);
  folder = char(strcat('poisson', window(values(2)), '/'));
end
  
titl = char(strcat(titl, winFull(values(2))));
load([folder num2str(numInputs) '.mat']);
for subP = 1:numInputs % for each subPlot
  if subP==2
    title(titl)
  end
  subplot(numInputs,1,subP,'Parent',handle.uipanel5)
  plot(weightMatrix(subP,1:29999))
  maxi = max(weightMatrix(subP,1:29999));
  mini = min(weightMatrix(subP,1:29999));
  xlabel(['synapse ' num2str(subP) ':   max=' num2str(maxi) '  min=' num2str(mini)]);
end % end for subP = 1:numInput
set(handle.uipanel5,'Visible','on');
