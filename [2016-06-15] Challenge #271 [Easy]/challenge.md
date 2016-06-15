This challenge is a bit uncoventional, so I apologize in advance to anyone who
may feel excluded due to language or other constraints. Also, I couldn't think
of fun backstory so feel free to make one up in your comments.

#Description

For today's challenge we will be focusing on generating a serieses waveforms
at specific frequencies, known as musical notes. Ideally you would be able to
push these frequencies directly to your speakers, but this can be difficult
depending on your operating system.

For Linux systems with ALSA, you can use the `aplay` utility.

    ./solution | aplay -f U8 -r 8000

For other systems you can use Audacity,
which features a raw data import utility.

#Input Description

You will be given a sample rate in Hz (bytes per second), followed by a
duration for each note (milliseconds), and then finally a string of notes
represented as the letters `A` through `G` (and `_` for rest).

#Output Description

You should output a string of bytes (unsigned 8 bit integers) either as a
binary stream, or to a binary file. These bytes should represent the
waveforms^[1] for the frequencies^[2] of the notes.

#Challenge Input

    8000
    300
    ABCDEFG_GFEDCBA

#Challenge Output

Since the output will be a string of 36000 bytes, it is provided below as a
download. Note that it does not have to output exactly these bytes, but it
must be the same notes when played.

You can listen to the data either by playing it straight with aplay, which
should pick up on the format automatically, or by piping to aplay and
specifying the format, or by importing into audacity and playing from there.

[Download](https://raw.githubusercontent.com/G33kDude/DailyProgrammer/master/%5B2016-06-15%5D%20Challenge%20%23271%20%5BEasy%5D/out.pcm)

#Bonus

Wrap your output with valid WAV/WAVE file headers^[3] so it can be played directly
using any standard audio player.

[Download](https://raw.githubusercontent.com/G33kDude/DailyProgrammer/master/%5B2016-06-15%5D%20Challenge%20%23271%20%5BEasy%5D/out.wav)

#Notes

1. [Wikipedia](https://en.wikipedia.org/wiki/Waveform) has some formulas for
waveform generation. Note that `t` is measured in wavelengths.

2. [This page](http://www.phy.mtu.edu/~suits/notefreqs.html) lists the exact
frequencies for every note.

3. A good resource for WAV/WAVE file headers can be found
[here](http://www.topherlee.com/software/pcm-tut-wavformat.html).

#Finally

Have a good challenge idea?

Consider submitting it to /r/dailyprogrammer_ideas
