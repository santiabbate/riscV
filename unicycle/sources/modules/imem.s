ld x1, 8(x0)      #Load constant 1
ld x3, 0(x0)      #Load constant 0 in LEDs counter register
ld x2, 16(x0)     #Load LEDs memory pointer
ld x8, 24(x0)     #Load constant 10.000.000 for one sec counter
led_counter:
  ld x4, 0(x0)    #Load constant 0 in one sec counter register
  add x3, x3, x1  #Increment led counter
  sd x3, 0(x2)    #Write to peripherial
one_sec_loop:
  add x4, x4, x1  #Increment one sec counter
  beq x4, x8, led_counter
  beq x0, x0, one_sec_loop
