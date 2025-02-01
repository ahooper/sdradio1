#Notes

sdrplay_api uses shared memory, so the application won't run in the MacOS sandbox

Swift LLVM IR code: <https://stackoverflow.com/a/72104378>
You need to put -Xfrontend -emit-ir into Other Swift Flags, and the LLVM IR is in the .o file
/Users/andy/Library/Developer/Xcode/DerivedData/sdrplay1-efagaaikpyxewmgvwcxpikxlnenr//Build/Intermediates.noindex/sdrplay1.build/Debug/sdrplay1.build/Objects-normal/arm64/

##Audio
<https://developer.apple.com/documentation/Apple-Silicon/porting-your-audio-code-to-apple-silicon>
<https://developer.apple.com/documentation/audiotoolbox/workgroup_management/adding_asynchronous_real-time_threads_to_audio_workgroups>
<https://developer.apple.com/documentation/audiotoolbox/workgroup_management/adding_parallel_real-time_threads_to_audio_workgroups>
OS Audio Workgroup Join <https://gist.github.com/cjappl/20fed4c5631099989af9ca900db68bfa>

##FFT
sdruno options
FFT Windows: Hann, Blackman, Hamming, Sin^3, Sin^5, Nutall, Flat Top P401, Rectangular
Palette: Spectran, Horne's, Spectran Ext, Winrad, Linrad, Monochrome

https://www.dadisp.com/webhelp/mergedProjects/refman2/FncrefFK/FLATTOP.htm
http://www.diva-portal.se/smash/get/diva2:838361/FULLTEXT01.pdf
https://dewesoft.com/daq/guide-to-fft-analysis
https://www.bksv.com/media/doc/bv0031.pdf
https://www.bksv.com/media/doc/bv0032.pdf
