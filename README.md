# Single Cycle RISC-V Processor

Design and implementation of RISC-V processor with a single-cycle datapath and controller.

## Commands

```ruby
R_Type:  add, sub, and, or, slt
```
```ruby
I_Type:  lw, addi, xori, ori, slti, jalr
```
```ruby
S_Type:  sw
```
```ruby
J_Type:  jal
```
```ruby
B_Type:  beq, bne, blt, bge
```
```ruby
U_Type:  lui
```
## Datapath
<img src="/readme_images/Datapath.png">

## Controller
<img src="/readme_images/CONT.jpg">

### Immediate Extension Unit Controller
<img src="/readme_images/Imm_Ext.jpg">

### ALU Opcode Controller
<img src="/readme_images/ALU_OP.jpg">

### ALU Controller
<img src="/readme_images/ALU_CONT.jpg">
