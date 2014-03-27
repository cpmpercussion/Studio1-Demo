Studio1-Demo
============

Examples of some ambisonic (surround sound) performance techniques in Studio 1 at the ANU PK Building.

I've provided examples in a couple of different environments with the goal of making Studio 1 accessible to all music and art students and researchers!

## What's special about Studio 1?
Studio 1 has two different surround sound systems installed in an acoustically treated for prototyping sound-art pieces, rehearsing performance works or even holding small events. It's a great space for developing sound-works that exist outside of the 2-channel commercial production paradigm - think iPad ensembles, live coding performance, interactive works. 

- 8 monitor speakers arranged in a cube for 3D surround (ambisonics)
- 4 large monitors installed in the walls for quadrophonic surround
- 8 channel audio interface for connecting a computer to all those speakers
- patch panels connecting to the other studios for recording

## How to get started
Download or clone this project (right hand column) and check out the example files in each folder. You might already have some software that you want to use for sound production, if you don't, check out the paragraph below for some ideas. For how-tos about getting plugged into Studio 1, checkout the[wiki](wiki).
 
## Folders in this Project:
Most of the folders contain some examples in different music environments.

- *Extempore*: This language is the new hotness in computer music and media (partly developed at ANU!) Tough learning curve but lots of possibilities and opportunities for research contributions etc.
- *Logic*: DAW for Apple computers. I've included a demo composition in 2D surround sound (just uses 4 speakers).
- *Pd* (or Pure Data). Venerable open source computer music environment - very accessible (graphical interface) and runs everywhere (Raspberry Pi, iOS, Linux, everything).
- *Sounds*: Some soundfiles I've used in the examples
- *SuperCollider*: Awesome computer music language and environment, lots of ambisonic plugins available for exploring 3D sound.

## NB!

The speakers in Studio 1 are very loud! Don't send stupid signals through them or run them at crazy high levels!

## What's ambisonics?

Ambisonics is a fancy word for 3D surround sound. Unlike "5.1" and other commercial surround standards, ambisonic configurations don't really have a front or back so it can be a good way of thinking about sound for installations, galleries or nontraditional performance spaces.

Usually in an ambisonic system, you position a source in a virtual sound-field using a horizontal angle and and elevation angle, a software "decoder" is responsible for playing back the virtual sound-field through the loudspeaker setup that you happen to have. More loudspeakers = more accurate playback. 

## Surround without ambisonics
You can also create great sound art or compositions by sending different sounds out each loudspeaker directly without bothering with a virtual sound-field. This can be really cool and you don't have to worry as much about having the speakers in the right order or anything.