
############ ----- Cross Toolchain setup ----- ##############
PROJECT_ROOT:=$(PWD)

TOOLCHAINPATH:=$(PROJECT_ROOT)/rpi-sdk/toolchain/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin
CROSSPREFIX:=$(TOOLCHAINPATH)/arm-linux-gnueabihf-
BUILD_PATH:=_build
CC:=$(CROSSPREFIX)gcc
CXX:=$(CROSSPREFIX)g++
SYSROOT=$(PROJECT_ROOT)/rpi-sdk/staging
RPATH:=$(SYSROOT)/usr/lib/
CFLAGS:= --sysroot=$(SYSROOT) -Wall -Werror -g -O2 -Wl,-rpath=$(RPATH)

############ ------opencv libs ------################
OPENCV_LIBS=    -lopencv_core                      \
                -lopencv_highgui                   \
                -lopencv_imgproc                   \
                -lopencv_ml                        \

############ ----- Project target ----- ##############
# change the target to what ever file name you want to build a binary
# this should match with the file name containing main() function
TARGET:=hello_pi

# if you add directories and files in the source dir add each dir below 
# e.g 
# for source/test/test.cpp file
# INC:= -I$(PROJECT_ROOT)/rpi-sdk/staging/usr/include/    \
#       -I$(PROJECT_ROOT)/source/                         \
#       -I$(PROJECT_ROOT)/source/test/                    \
#
# CPP_SRC:=$(wildcard $(PROJECT_ROOT)/source/*.cpp)       \
#          $(wildcard $(PROJECT_ROOT)source/test/*.cpp)   \

############ ----- Project include paths ----- ##############
INC:= -I$(PROJECT_ROOT)/rpi-sdk/staging/usr/include/          \
      -I$(PROJECT_ROOT)/source/                               \

############ ----- Project library paths ----- ##############
LDPATH:= -L$(PROJECT_ROOT)/rpi-sdk/staging/usr/lib

############ ----- Project source files ----- ##############
C_SRC:=$(wildcard $(PROJECT_ROOT)/source/*.c)
CPP_SRC:=$(wildcard $(PROJECT_ROOT)/source/*.cpp)
OBJS:=$(C_SRC:.c=.o) $(CPP_SRC:.cpp=.o)

############ ----- build main application ----- ##############

.PHONY: all
all: $(BUILD_PATH) $(TARGET)

$(BUILD_PATH):
	       @mkdir -p $@

$(TARGET): $(OBJS)
	   @echo "Linking... $@"
	   @$(CXX) $(CFLAGS) $^ -o $(BUILD_PATH)/$@ $(LDPATH) $(OPENCV_LIBS)

%.o: %.cpp
	@echo "[CXX] $<"
	@$(CXX) $(CFLAGS) $(INC) -c $< -o $@

%.o: %.c
	@echo "[CC] $<"
	@$(CC) $(CFLAGS) $(INC) -c $< -o $@

############ ----- cleaning ----- ##############

.PHONY: clean
clean:
	 rm -f source/*.o $(BUILD_PATH)/*
