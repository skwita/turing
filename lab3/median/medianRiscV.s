# median search
.text
__start:
.globl __start  
  li a2, 0 # i = 0
  li a3, 0 # j = 0
  li a4, 0 # count = 0
      
  lw a5, array_length # запись в регистр a5 длины массива
   
  la a6, array # запись адреса первого элемента массива в регистр a6
  la a7, array # запись адреса первого элемента массива в регистр a7

loop:
    bgeu a2, a5, finish # если i >= length выход в loop_exit
    lw t0, 0(a6) # запись в t0 значения a[i]    
loop2:
      bgeu a3, a5, check # если j >= length выход в loop2_exit      
      lw t1, 0(a7) # запись в t1 значения a[j]
      blt t0, t1, plusOne  # если a[i] < a[j] , то count++
      blt t1, t0, minusOne # если a[j] < a[i] , то count--      
      jal zero, skip # безусловный переход в skip если a[i] == a[j]
plusOne:
      addi a4, a4, 1  # count++
      jal zero, skip
minusOne:
      addi a4, a4, -1 # count--
      jal zero, skip
skip:  
      addi a7, a7, 4 # добавляем к адресу a[j] 4, для перехода к следующему элементу массива     
      addi a3, a3, 1 # j += 1
      jal zero, loop2 # переход в loop2
check:    
    beqz a4, finish    # если count == 0, то выходим из цикла
    li a1, 1 
    beq a4, a1, finish # если count == 1, то выходим из цикла

    la a7, array # снова записываем адрес a[0] в a7    
    addi a6, a6, 4 # добавляем к адресу a[i] 4, для перехода к следующему элементу массива  
    li a3, 0 # j = 0
    li a4, 0 # count = 0
    addi a2, a2, 1 # i += 1
    jal zero, loop # переход в loop
finish:  
  la a0, result # загружаем адрес result в a0
  lw a6, 0(a6)  # загржаем значение медианы в а6
  sw a6, 0(a0)  # записываем его в result
  li a0, 10 # x10 = 10
  ecall # ecall при значении x10 = 10 => останов симулятора
 
 .data   # секция изменяемых данных
result:
 .word 65535
 
 .rodata # секция неизменяемых данных
array_length:
 .word 13
array:
 .word 2, 0, 1, 8, 9, 4, 6, 7, 3, 10, 5, 5, 5 