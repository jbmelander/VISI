function [pathtofile] = getfile()
[x y] = uigetfile('*');
pathtofile = [y x];
cd(y);