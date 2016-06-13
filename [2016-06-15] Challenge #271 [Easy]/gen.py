#!/usr/bin/env python3

import math
import subprocess
import struct

SAMPLE_RATE = 8000 # Samples per second (Hz)
NUM_CHANNELS = 1
BITS_PER_SAMPLE = 8

AMPLITUDE = 127

FREQUENCIES = {
	'A': 440.00,
	'B': 493.88,
	'C': 523.25,
	'D': 587.33,
	'E': 659.25,
	'F': 698.46,
	'G': 783.99,
	'_': 0 
}

WAVE_FORMAT_PCM = 0x001
SIZEOF_HEADERS = 44 - 8 # Does not include RIFF____
SIZEOF_FORMAT = 16

def generate_headers(sizeof_data):
	return struct.pack(
		'4si4s4sihhiihh4si',
		# - TYPE HEADERS -
		b'RIFF',
		SIZEOF_HEADERS + sizeof_data,
		b'WAVE',
		# - FORMAT DATA -
		b'fmt ',
		SIZEOF_FORMAT,
		WAVE_FORMAT_PCM,
		NUM_CHANNELS,
		SAMPLE_RATE,
		int(SAMPLE_RATE*BITS_PER_SAMPLE*NUM_CHANNELS/8),
		int(BITS_PER_SAMPLE*NUM_CHANNELS/8),
		BITS_PER_SAMPLE,
		b'data',
		sizeof_data
	)

def generate_waveform(notes, notelen):
	samples = SAMPLE_RATE * (notelen / 1000)
	for note in notes:
		freq = FREQUENCIES[note]
		
		if freq == 0: # Rest
			for i in range(int(samples)):
				yield 128
			continue
		
		# Calculate the wavelength in samples
		wavelength = SAMPLE_RATE / freq
		
		for i in range(int(samples)):
			# Fade the note in/out
			trueamp = AMPLITUDE * math.sin(math.pi * (i / samples))
			
			# Find the point on the sin wave for this sample
			point = math.sin(2 * math.pi * (i / wavelength))
			
			# Adjust and amplify to fit in a byte
			yield round(128 - point * trueamp)

# Durations in milliseconds
notelen = 300

# Write the output
with open('out.wav', 'wb') as f:
	data = bytes(generate_waveform('ABCDEFG_GFEDCBA', notelen))
	headers = generate_headers(len(data))
	f.write(headers)
	f.write(data)
