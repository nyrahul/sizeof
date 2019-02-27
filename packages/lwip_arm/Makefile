Q=arm-none-eabi-
CC=gcc
LWIP=../lwip/src
CONTRIB=../contrib/ports/unix/port
BIN=bin
LIBA=$(BIN)/liblwip.a
LIBSO=$(BIN)/liblwip.so
CFLAGS=-Os -I$(LWIP)/include -I. -I$(CONTRIB)/include

SRCS = 	$(wildcard $(LWIP)/api/*.c) \
		$(wildcard $(LWIP)/core/*.c) \
		$(wildcard $(LWIP)/core/ipv6/*.c) \
		$(wildcard $(LWIP)/netif/*.c)

OBJS = $(subst .c,.o,$(notdir $(SRCS)))
OBJS := $(addprefix $(BIN)/, $(OBJS))

VPATH=	$(LWIP)/api \
		$(LWIP)/core \
		$(LWIP)/core/ipv6 \
		$(LWIP)/netif

all: $(LIBA) $(LIBSO)

$(OBJS): $(BIN)/%.o: %.c lwipopts.h
	$(Q)$(CC) $(CFLAGS) -c $< -o $@

$(BIN):
	@mkdir $(BIN)

$(LIBSO): $(BIN) $(OBJS)
	$(Q)$(CC) $(CFLAGS) -shared -Xlinker -Map=$(BIN)/output.map -o $@ $(OBJS)
	./map_info.sh

$(LIBA): $(BIN) $(OBJS)
	$(Q)$(AR) rcs $@ $(OBJS)

clean:
	@rm -rf $(BIN)

.PHONY: all prepare clean

