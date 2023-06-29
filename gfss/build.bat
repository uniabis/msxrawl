@echo off
sjasmplus --raw=z80\gfss402e.bin --lst=z80\gfss402e.lst z80\gfss402e.sz
sjasmplus --raw=z80\gfssb97c.bin --lst=z80\gfssb97c.lst z80\gfssb97c.sz
sjasmplus --raw=z80\gfssbd25.bin --lst=z80\gfssbd25.lst z80\gfssbd25.sz
sjasmplus --raw=z80\gfssbd90.bin --lst=z80\gfssbd90.lst z80\gfssbd90.sz
sjasmplus --raw=z80\gfmk6e3d.bin --lst=z80\gfmk6e3d.lst z80\gfmk6e3d.sz


if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvarsall.bat" (
 rem vs2019 Professional
 if not "%VisualStudioVersion%"=="16.0" (
  call "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvarsall.bat" x86
 )
) else if exist "%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" (
 rem vs2022 Community
 if not "%VisualStudioVersion%"=="16.0" (
  call "%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x86
 )
)

cl /O1 /EHs-c- /MD bin2c.c
if exist bin2c.obj del bin2c.obj

bin2c z80\gfss402e.bin > z80\gfss402e.h
bin2c z80\gfssb97c.bin > z80\gfssb97c.h
bin2c z80\gfssbd25.bin > z80\gfssbd25.h
bin2c z80\gfssbd90.bin > z80\gfssbd90.h
bin2c z80\gfmk6e3d.bin > z80\gfmk6e3d.h

cl /O1 /EHs-c- /MD gfss.c
if exist gfss.obj del gfss.obj

gfss gf.rom gfss.rom

winips /c "%~dp0gf.rom" "%~dp0gfss.rom"
