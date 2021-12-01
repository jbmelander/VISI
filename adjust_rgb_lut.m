function [adjusted] = adjust_rgb_lut(img,lo,hi)
img = img / hi;

img = img - lo;
img(img<0) = 0;
img(img>1) = 1;


global isi
if isi.binarymode == 0
    adjusted =  img;
    
elseif isi.binarymode == 1
    img(img>0) = 1;
    adjusted = img;
else
end