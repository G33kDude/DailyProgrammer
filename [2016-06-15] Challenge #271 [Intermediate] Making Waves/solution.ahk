#NoEnv
SetBatchLines, -1

; --- Config ---

Notes := "CDE_CED_CDECEDC"
NoteLen := 250

OutFile := "out.wav"

SampleRate := 8000  ; Suggested values: 4000, 8000, 16000
BitsPerSample := 32 ; Allowed values: 8, 16, 32
Amplitude := 0.5    ; Value between 0 and 1

FrequencyMap := {"_": 0
, "G": 392.00
, "A": 440.00
, "B": 493.88
, "C": 523.25
, "D": 587.33
, "E": 659.25
, "F": 698.46}

; --- Write File ---

Samples := SampleRate * (NoteLen/1000)
DataLen := Samples * StrLen(Notes) * BitsPerSample/8

File := FileOpen(OutFile, "w")
WriteHeaders(File, SampleRate, BitsPerSample, DataLen)
for Index, Note in StrSplit(Notes)
	WriteWaveform(File, SampleRate, BitsPerSample, Samples, FrequencyMap[Note], Amplitude)
File.Close()

Sleep, 100 ; Give some time after writing the file for good measure, shouldn't be necessary

; --- Open File ---

try
	Run, "C:\Program Files (x86)\Audacity\audacity.exe" "%OutFile%
catch
	try
		Run, "C:\Program Files\Audacity\audacity.exe" "%OutFile%"

SoundPlay, %OutFile%
Sleep, NoteLen*StrLen(Notes)
ExitApp
return

WriteHeaders(File, SampleRate, BitsPerSample, DataSize)
{
	static WAVE_FORMAT_PCM := 0x001
	, SIZEOF_HEADERS := 44 - 8 ; Starts at "WAVE", doesn't include "RIFF____"
	, SIZEOF_FORMAT := 16
	, NUM_CHANNELS := 1
	
	File.write("RIFF")
	File.writeUInt(SIZEOF_HEADERS + DataSize)
	File.write("WAVE")
	File.write("fmt ")
	File.writeInt(SIZEOF_FORMAT)
	File.writeShort(WAVE_FORMAT_PCM)
	File.writeShort(NUM_CHANNELS)
	File.writeInt(SampleRate)
	File.writeInt(SampleRate * BitsPerSample * NUM_CHANNELS / 8)
	File.writeShort(BitsPerSample * NUM_CHANNELS / 8)
	File.writeShort(BitsPerSample)
	File.write("data")
	File.writeInt(DataSize)
}

WriteWaveform(File, SampleRate, BitsPerSample, Samples, Frequency, Amplitude)
{
	static Types := {8: "UChar", 16: "Short", 32: "Int"}
	static IsSigned := {8: False, 16: True, 32: True}
	static pi := 3.14159
	
	Wavelength := SampleRate / Frequency
	Half := 1 << (BitsPerSample-1)
	Baseline := IsSigned[BitsPerSample] ? 0 : Half
	Write := ObjBindMethod(File, "Write" Types[BitsPerSample])
	
	Loop, %Samples%
	{
;		TrueAmp := (Half-1) * Amplitude ; --
;		TrueAmp := (Half-1) * Amplitude * Sin(pi * A_Index/Samples) ; ◜◝
		TrueAmp := (Half-1) * Amplitude * (Cos(pi + 2*pi * A_Index/Samples)+1)/2 ; ◞◜◝◟
		Write.Call(Baseline + Sin(2*pi * (A_Index/Wavelength)) * TrueAmp)
	}
}
