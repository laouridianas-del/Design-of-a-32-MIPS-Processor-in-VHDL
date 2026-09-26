# Design-of-a-32-MIPS-Processor-in-VHDL
I designed a 32-bit Single-Cycle and Multi-Cycles MIPS Processor in VHDL.

Key Components of the Design:

●Program Counter (PC) : Fetches instruction addresses.

●Instruction Memory : Stores program instructions.

●Register File : 32 registers ($0–$31).

●Data Memory :Handles load and store operations.

●Datapath & Control Unit :Supporting R-type, I-type, and J-type instructions.

For the multi-cycles i used a mealy state machine for the control unit,it contains five states:Fetch,Decode,Execute,write memory,write back.

The design was verified using waveform simulations on quartus.

Single-Cycle Diagram and waveform simulation:

<img width="1280" height="758" alt="image" src="https://github.com/user-attachments/assets/d2ac6bfd-ea24-408b-89e1-ab44e68abbfb" />

<img width="1280" height="216" alt="image" src="https://github.com/user-attachments/assets/0a7cd4a1-576d-4bdb-9bc5-3dead358feb0" />

Multi-Cycles Diagram and waveform simulation:

<img width="1280" height="700" alt="image" src="https://github.com/user-attachments/assets/443e9d9f-e1fc-45cd-88f8-1028a14e61df" />

<img width="1280" height="411" alt="image" src="https://github.com/user-attachments/assets/1b19391d-dcac-431d-9044-0cdcc9cd610a" />





