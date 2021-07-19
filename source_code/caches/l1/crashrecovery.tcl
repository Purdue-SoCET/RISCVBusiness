# SimVision Command Script (Tue Apr 26 06:21:45 PM EDT 2022)
#
# Version 15.20.s030
#
# You can restore this configuration with:
#
#     simvision -input crashrecovery.tcl
#  or simvision -input crashrecovery.tcl database1 database2 ...
#


#
# Preferences
#
preferences set toolbar-SimControl-WatchList {
  usual
  hide step_in
  hide step_over
  hide step_adjacent
  hide set_break
  position -row 0
}
preferences set toolbar-SimControl-SrcBrowser {
  usual
  show step_out
  hide set_break
  position -row 0 -pos 0
}
preferences set toolbar-CursorControl-SrcBrowser {
  usual
  hide usage
  hide previous_edge
  hide next_edge
  shown 0
  position -pos 1
}
preferences set toolbar-CursorControl-WatchList {
  usual
  hide lock
  hide usage
  hide cursors
  hide equal
  hide time
  hide units
  hide previous_edge
  hide next_edge
  shown 0
}
preferences set toolbar-TimeSearch-SrcBrowser {
  usual
  shown 0
  position -pos 3 -anchor e
}
preferences set plugin-enable-svdatabrowser-new 1
preferences set toolbar-Standard-WatchList {
  usual
  hide open
  hide opensim
  shown 0
}
preferences set toolbar-SimControl-WaveWindow {
  usual
  hide step_in
  hide step_over
  hide step_adjacent
  hide set_break
  position -row 1 -pos 0
}
preferences set toolbar-CursorControl-WaveWindow {
  usual
  hide usage
  hide count_edges
  position -row 1 -pos 1
}
preferences set toolbar-SvDataBrowser-SrcBrowser {
  usual
  position -pos 3
  name SvDataBrowser
}
preferences set toolbar-sendToIndago-WaveWindow {
  usual
  position -pos 1
}
preferences set toolbar-TimeSearch-WaveWindow {
  usual
  position -pos 2
}
preferences set toolbar-Edit-WatchList {
  usual
  hide cut
  hide delete
  hide clear
}
preferences set toolbar-Standard-Console {
  usual
  position -pos 1
}
preferences set toolbar-Standard-SrcBrowser {
  usual
  hide opensrc
  hide opensim
  hide copy
  hide edit
  position -pos 4
}
preferences set toolbar-SignalTrace-SrcBrowser {
  usual
  hide previous
  hide next
  hide history-prev
  hide history-next
  position -row 0 -pos 2 -anchor w
}
preferences set toolbar-Search-Console {
  usual
  position -pos 2
}
preferences set toolbar-NavSignalList-WaveWindow {
  usual
  position -row 0 -pos 3
}
preferences set toolbar-txe_waveform_toggle-WaveWindow {
  usual
  shown 0
}
preferences set toolbar-Windows-SrcBrowser {
  usual
  hide tools
  position -pos 10
}
preferences set toolbar-Standard-WaveWindow {
  usual
  hide open
  hide opensim
  hide delete
  hide search_toggle
}
preferences set plugin-enable-groupscope 0
preferences set toolbar-SrcCallstack-SrcBrowser {
  usual
  hide callstackmove
  position -row 0 -pos 5 -anchor w
}
preferences set plugin-enable-interleaveandcompare 0
preferences set plugin-enable-waveformfrequencyplot 0
preferences set toolbar-Windows-WaveWindow {
  usual
  hide tools
  hide add
  position -pos 10
}
preferences set toolbar-Windows-WatchList {
  usual
  hide tools
  hide selectdeep
  hide add
  position -pos 10
}
preferences set toolbar-WaveZoom-WaveWindow {
  usual
  hide label
  hide link
  hide time_range
  position -row 1 -pos 3
}
preferences set toolbar-TimeSearch-WatchList {
  usual
  shown 0
  position -row 0 -pos 4
}
preferences set whats-new-dont-show-at-startup 1

#
# Mnemonic Maps
#
mmap new -reuse -name {Boolean as Logic} -radix %b -contents {{%c=FALSE -edgepriority 1 -shape low}
{%c=TRUE -edgepriority 1 -shape high}}
mmap new -reuse -name {Example Map} -radix %x -contents {{%b=11???? -bgcolor orange -label REG:%x -linecolor yellow -shape bus}
{%x=1F -bgcolor red -label ERROR -linecolor white -shape EVENT}
{%x=2C -bgcolor red -label ERROR -linecolor white -shape EVENT}
{%x=* -label %x -linecolor gray -shape bus}}

#
# Design Browser windows
#
if {[catch {window new WatchList -name "Design Browser 1" -geometry 730x500+593+117}] != ""} {
    window geometry "Design Browser 1" 730x500+593+117
}
window target "Design Browser 1" on
browser using {Design Browser 1}
browser set \
    -signalsort name
browser timecontrol set -lock 0

#
# Layout selection
#

