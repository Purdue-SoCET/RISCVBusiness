The C-extension originally used a decompresser and fetch buffer to find 16-bit instructions and decode them into 32-bit instructions.<br>
We now pass the decompresser through a multi-instruction handler.<br>
The handler checks if the 16-bit instruction has a 1-to-1 32 bit instruction. If it does, then it simply passes the 32-bit instruction recieved from the decompresser to the execute stage.<br>
However, if that is not the case, a system of ROMs and a state machine send 32-bit instructions 1 by 1 until the needed functionality is executed.
