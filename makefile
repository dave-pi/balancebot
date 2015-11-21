NAME   = rfid_reader

CC      = arm-none-eabi-gcc
LD      = arm-none-eabi-ld -v
AR      = arm-none-eabi-ar
AS      = arm-none-eabi-as
CP      = arm-none-eabi-objcopy
OD	= arm-none-eabi-objdump

CFLAGS  =  -I./ -c -mcpu=cortex-m3 -mthumb -fno-common -Wall -g 
AFLAGS  =  -mcpu=cortex-m3 -mthumb -mapcs-32 -g -ahls
LFLAGS  = -T stm32_flash.ld -nostartfiles
CPFLAGS = -O binary
ODFLAGS	= -S

objects = main.o misc.o stm32f10x_tim.o stm32f10x_gpio.o stm32f10x_rcc.o stm32f10x_spi.o stm32f10x_it.o system_stm32f10x.o core_cm3.o startup_stm32f10x_md.o 
cpp_objects =

all: copy

copy: main.elf
	@ echo "...copying"
	$(CP) $(CPFLAGS) $< main.bin
	$(OD) $(ODFLAGS) $< > main.list

main.elf: $(objects)
	@ echo "...linking"
	$(LD) $(LFLAGS) -o $@ $(objects)

%.o : %.c
	@ echo "...compiling"
	$(CC) $(CFLAGS) -o $@ $<

%.o : %.cpp
	@ echo "...compiling"
	$(CC) $(CFLAGS) -o $@ $<

%.o : %.s
	@ echo "...assembling"
	$(AS) $(AFLAGS) -o $@ $<

