clear all;
close all;
clc;

v = VideoReader('video.mp4');
nbreTrame = v.Duration*v.FrameRate;
[imIncruste] = imread('jo.jpg');

video = transformationVideo(v, nbreTrame, imIncruste);
