MAIN := tuo.exe
SRCS := $(wildcard *.cpp)
OBJS := $(patsubst %.cpp,obj/%.o,$(SRCS))
INCS := $(wildcard *.h)

CPPFLAGS := -Wall -Werror -std=gnu++11 -O3 -DNDEBUG
LDFLAGS := -lboost_system -lboost_thread -lboost_filesystem -lboost_regex

all: $(MAIN)

obj/%.o: %.cpp $(INCS)
	$(CXX) $(CPPFLAGS) -o $@ -c $<

$(MAIN): $(OBJS)
	$(CXX) -o $@ $(OBJS) $(LDFLAGS)

clean:
	del /q $(MAIN).exe obj\*.o

# build a snap for cross distribution availability
# cleanbuild uses snapcracft and lxd
snap:
	snapcraft cleanbuild
