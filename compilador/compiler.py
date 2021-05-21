inst_set = {                    ### Function ###
    "add"   : "0000",       # addition
    "sub"   : "0001",       # substration
    "mul"   : "0010",       # multiplication
    "div"    : "0011",       # division
    "and"   : "0100",       # and
    "orr"     : "0101",       # or
    "lsl"      : "0110",       # Shift Left
    "lsr"     : "0111",       # Shift Right
    "mov"  : "1000",       # mov
    "cmp"  : "1001",       # compare
    "str"     : "0000",       # store
    "ldr"     : "0000",       # load 
    "beq"   : "000",         # branch equal
    "b"       : "000",         # branch greater than
    "bgt"    : "000",         # branch less than
    "blt"     : "000",         # branch 
    "stxt"   : "1111"        # store into txt
} 

registers = {
    "zero"    : "0000", 
    "r1"        : "0001",
    "r2"        : "0010",
    "r3"        : "0011",
    "r4"        : "0100",
    "r5"        : "0101",
    "r6"        : "0110",
    "r7"        : "0111",
    "r8"        : "1000",
    "r9"        : "1001",
    "r10"      : "1010",
    "r11"      : "1011",
    "r12"      : "1100",
    "r13"      : "1101",
    "r14"      : "1110",
    "pc"       : "1111"
}

def compile(instruction, PC):
    OP   = "00" # 2
    Rd   = "0000" # 4
    Rn   = "0000" # 4
    Rm  = "0000" # 4
    Operand_2 = "0000000000000" #13
    I = "0" # 0 / 1
    funct = inst_set[instruction[0]] # mov, add, sub, mul, div, and, or, slli, srli, cmp, b, beq
###########################################################
    if instruction[0] == "mov": # ----> 2 cases, with immediate and without
        Rd  = registers[instruction[1][:-1]] # take reg. value 'r11,' -> 'r11' -> 1011
        mov_imm = instruction[2][:1] # to detect if is a mov with immediate
        if mov_imm == "#": #Case 1:  MOV R1 #10 -> with immediate
            if instruction[2][1:3] == "0b":  # 0b0001010 -> 00000000000001010
                num = int(instruction[2][1:], 2)
                Rm_plus_Operand_2 = f'{num:017b}'
            elif instruction[2][1:3] == "0x": # 0xA -> 00000000000001010
                num = int(instruction[2][1:], 16)
                Rm_plus_Operand_2 = f'{num:017b}'
            else:
                num = int(instruction[2][1:])
                if num < 0:
                    Rm_plus_Operand_2 = a2_comp(num)
                else:
                    Rm_plus_Operand_2 = f'{num:017b}'
            I = "1"
            return OP + Rd + Rn + Rm_plus_Operand_2 + I + funct
        else: #Case  2: MOV R1 R2  -> without immediate
            Rn  = registers[instruction[2]] # take reg. value
            return OP + Rd + Rn + Rm + Operand_2 + I + funct
##########################################################
    elif instruction[0] == "b" or instruction[0] == "beq" or instruction[0] == "bgt" or instruction[0] == "blt":
        OP = "11"
        tag = instruction[1] # "tag"
        pos_tag = tags[tag] # int with tag pc=position
        pos_branch = PC # int with actual pc position (branch position)
        n_jumps = pos_tag - pos_branch
        if n_jumps < 0:
            Rm_plus_Operand_2 = a2_comp(n_jumps)
        else:
            Rm_plus_Operand_2 = f'{n_jumps:017b}' # take number and convert to binary without "0b" and fill with zeros
        if instruction[0] == "beq":
            I = "01"
        elif instruction[0] == "bgt":
            I = "10"
        elif instruction[0] == "blt":
            I = "11"
        else:
            I = "00"
        return OP + Rd + Rn + Rm_plus_Operand_2 + I + funct
##########################################################
    elif instruction[0] == "ldr" or instruction[0] == "str": # ----> 3 cases, normal, with immediate offset and with reg offset
        if instruction[0] == "ldr":
            OP = "01"
        else:
            OP = "10"
        Rd  = registers[instruction[1][:-1]] # take reg. value
        without_offset = instruction[2][-1] # to detect if have offset
        if without_offset == "]": #Case 1: FUNCT R5 [R1] or FUNCT R5 [#8] or [#-8]
            imm =  instruction[2][1:2] # to detect if is a funct with immediate
            if imm == "#": #Case 1.1:  FUNCT R5 [#8] or [#-8] -> with immediate
                num = int(instruction[2][2:-1]) # 8 or -8
                if num < 0: # -8
                    Rm_plus_Operand_2 = a2_comp(num) # A2 complement
                else: #Case 1.2:  FUNCT R5 [#8] -> with immediate
                    Rm_plus_Operand_2 = f'{num:017b}' # take number and convert to binary without "0b" and fill with zeros
                I = "1"
                return OP + Rd + Rn + Rm_plus_Operand_2 + I + funct
            else: #Case 1.3:  FUNCT R5 [R1] 
                Rn  = registers[instruction[2][1:-1]] # '[R1]' -> R1 = 0001
                return OP + Rd + Rn + Rm + Operand_2 + I + funct
        else:
            Rn  = registers[instruction[2][1:-1]] # '[R1' -> R1 = 0001
            imm = instruction[3][:1] # to detect if is a funct with immediate
            if imm == "#": # Case 2: FUNCT R5 [R1 #8] -> with immediate
                num = int(instruction[3][1:-1])
                if num < 0: # Case 2.1: FUNCT R5 [R1 #-8]
                    Rm_plus_Operand_2 = a2_comp(num) # A2 complement
                else: # Case 2.2: FUNCT R5 [R1 #8]               
                    Rm_plus_Operand_2 = f'{num:017b}' # take number and convert to binary without "0b" and fill with zeros
                I = "1"      
                return OP + Rd + Rn + Rm_plus_Operand_2 + I + funct
            else: # Case 3: FUNCT R5 [R1 R2] -> reg offset
                Rm  = registers[instruction[3][:-1]] # 'R2]' -> R2 = 0010
                return OP + Rd + Rn + Rm + Operand_2 + I + funct
##########################################################
    elif instruction[0] == "cmp": # CMP R1 #10 or CMP R1 R2
        # ignore Rd
        Rn  = registers[instruction[1][:-1]] # take reg. value -> R1
        imm = instruction[2][:1] # to detect if is a funct with immediate
        if imm == "#": # Case 1: CMP R1 #10 -> with immediate
            num = int(instruction[2][1:]) #10
            if num < 0: #-10
                Rm_plus_Operand_2 = a2_comp(num) # 11111111111110110
            else:
                Rm_plus_Operand_2 = f'{num:017b}'   #  00000000000001010
            I = "1"
            return OP + Rd + Rn + Rm_plus_Operand_2 + I + funct
        else: # Case 2: CMP R1 R2
                Rm  = registers[instruction[2]] # 'R2' -> R2 = 0010
                return OP + Rd + Rn + Rm + Operand_2 + I + funct
##########################################################
    elif instruction[0] == "stxt": # STXT R2
        OP = "10"
        Rd  = registers[instruction[1]] # take reg. value -> R2
        return OP + Rd + Rn + Rm + Operand_2 + I + funct
##########################################################
    else: # "add" or "sub" or "mul" or "div" or "or" or "and"
        Rd  = registers[instruction[1][:-1]] # take reg. value
        Rn  = registers[instruction[2][:-1]] # take reg. value
        imm = instruction[3][:1] # to detect if is a funt with immediate
        if imm == "#": #Case 1: funct R4 R1 #5 -> with immediate
            if instruction[3][1:3] == "0b":  # 0b0001010 -> 00000000000001010
                num = int(instruction[3][1:], 2)
                Rm_plus_Operand_2 = f'{num:017b}'
            elif instruction[3][1:3] == "0x": # 0xA -> 00000000000001010
                num = int(instruction[3][1:], 16)
                Rm_plus_Operand_2 = f'{num:017b}'
            else:
                num = int(instruction[3][1:])
                if num < 0:
                    Rm_plus_Operand_2 = a2_comp(num)
                else:
                    Rm_plus_Operand_2 = f'{num:017b}'
            I = "1"             
            return OP + Rd + Rn + Rm_plus_Operand_2 + I + funct
        else: #Case  2: funct R4 R1 R2  -> without immediate
            Rm  = registers[instruction[3]] # take reg. value
            return OP + Rd + Rn + Rm + Operand_2 + I + funct


# A2 complement aux function
def a2_comp(neg_n):
    n_bin = f'{-neg_n:017b}' # = '00000000000001010'
    n_bin_list = list(n_bin) # = ['0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '1', '0']
    flag = False # A2 complement
    for c in range(18):
        if n_bin_list[-c] == '1' and flag == False:
            flag = True
        elif flag == True:
            if n_bin_list[-c] == '1':
                n_bin_list[-c] = '0'
            else:
                n_bin_list[-c] = '1'
            #print(n_bin_list) # = ['1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0', '1', '1', '0']
    n_bin_comb = ""
    Rm_plus_Operand_2 = n_bin_comb.join(n_bin_list)  # = '11111111111110110'
    return Rm_plus_Operand_2



# Main
## Take the code:
tags = {}
compiled_Instructions = []
code_list = []
pc = 0

#code_file = open('C:/Users/PEPITO/CARPETA/code.s', "r") # if the file is in a specific path
code_file = open('code.s', 'r') # same path as the code: open the code file
for line in code_file: ## import into list all the code
    line = line.lower() # ignore mayus: SUB R7 R8 #100 -> sub r7 r8 #100
    line_Array = line.split() # [[sub], [r7], [r8], [#100]]
    if(len(line_Array) != 0): # ignore empty lines
        if(line_Array[0][-1] == ':'): # detect tags
            newTag = {line_Array[0][0:-1]: pc}
            tags.update(newTag)
        else:
            pc += 1
            code_list.append(line_Array)
code_file.close()


## Compilation of instructions ##
pc = 0
for instruction in code_list:
    #print(instruction) #XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    compiled_Instructions.append(compile(instruction, pc) + "\n")
    pc += 1


## Convertion of instructions from bin to hex
hex_list = []

for num in compiled_Instructions:
    decimal_representation = int(num, 2)
    hexadecimal_string = hex(decimal_representation)
    hex_num = hexadecimal_string[2:] # [2:] to erase 0x
    size_confirm = len(hex_num)
    if size_confirm != 8:
        zeros_to_add = 8 - size_confirm
        while zeros_to_add != 0:
            hex_num = "0" + hex_num # add zeros if is necessary to complete the size
            zeros_to_add -= 1
    hex_list.append(hex_num)


#### Create the output file -> with hex_list numbers #####
hex_file = open('C:/QuartusProjects/Files/ROMInstruc2.txt', "w") # if you want to save the file in another path
#hex_file = open('compiled_Instructions.txt', "w") # if you want to save the file in the same path
for number in hex_list:
    hex_file.write(number + "\n")
hex_file.close()
#########################################################

## test code ##############################################
print(tags)
print(code_list)
print(compiled_Instructions)
#########################################################
print(hex_list)
##for i in hex_list:
##    print(i)
###########################



