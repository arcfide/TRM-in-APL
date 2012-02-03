 R←N EVAL P;PC;I;V
 R←N ⋄ PC←1                             ⍝ Set Init State and Program Counter
 P←(⊃'1#'∨.=⊂P)/P                       ⍝ Strip whitespace
 P←↑(('1'=P)∧1,2≠/P)⊂P                  ⍝ Partition into instructions
 P←(+/'#'=P),[1.5]+/'1'=P               ⍝ Reformat instructions to integers
LP:→(PC=1+⊃⍴P)/0                        ⍝ Check for halt
 'BAD HALT'⎕SIGNAL((PC<1)∨PC>1+⊃⍴P)/90  ⍝ Exception on bad halt
 (I V)←PC⌷P                             ⍝ I→Instruction  V→Register/Count
 →I⌷(ADD ADD GO GO CASE)                ⍝ Case on instruction
ADD:R[V],←I⌷'1#' ⋄ PC+←1 ⋄ →LP          ⍝ Add elem, increment, go.
GO:PC+←V×(I-2)⌷1 ¯1 ⋄ →LP               ⍝ Step forward/backward, go.
CASE:PC+←('1#'⍳1↑⊃V⌷R)⌷2 3 1            ⍝ Step forward correct amount
 R[V]←⊂1↓⊃V⌷R ⋄ →LP                     ⍝ Drop element from register and go