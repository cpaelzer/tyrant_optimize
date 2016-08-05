MAIN := tuo.exe
SRCS := $(wildcard *.cpp)
OBJS := $(patsubst %.cpp,obj/%.o,$(SRCS))
INCS := $(wildcard *.h)

CPPFLAGS := -Wall -Werror -std=gnu++11 -O3 -DNDEBUG
LDFLAGS := -lboost_system -lboost_thread -lboost_filesystem -lboost_regex

ifdef SYSTEMROOT
	RM = del /Q
	FixPath = $(subst /,\,$1)
	MKDIR = mkdir
else
	ifeq ($(shell uname), Linux)
		RM = rm -f
		FixPath = $1
		MKDIR = mkdir -p
	endif
endif

all: $(MAIN)

prep:
	$(MKDIR) obj

obj/%.o: %.cpp $(INCS) prep
	$(CXX) $(CPPFLAGS) -o $@ -c $<

$(MAIN): $(OBJS)
	$(CXX) -o $@ $(OBJS) $(LDFLAGS)

clean:
	$(RM) $(call FixPath,obj/*.o)

# build a snap for cross distribution availability
# cleanbuild uses snapcracft and lxd
snap:
	snapcraft cleanbuild
