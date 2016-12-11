.PHONY: all clean

all: demo

clean:
	rm -rf icu demo

CPPFLAGS = -fno-exceptions
CPPFLAGS += -DU_USING_ICU_NAMESPACE=0
CPPFLAGS += -DU_CHARSET_IS_UTF8=1
CPPFLAGS += -DUNISTR_FROM_CHAR_EXPLICIT=explicit
CPPFLAGS += -DUNISTR_FROM_STRING_EXPLICIT=explicit
CPPFLAGS += -DU_NO_DEFAULT_INCLUDE_UTF_HEADERS=1

icu/source/lib/libicui18n.a:
	tar -xf icu4c-58_2-src.tgz
	cd icu/source && chmod +x runConfigureICU configure install-sh
	cd icu/source && \
		CPPFLAGS="$(CPPFLAGS)" \
		./runConfigureICU \
			$$( (uname -s | grep -qi 'Darwin') && echo 'MacOSX' || echo 'Linux' ) \
			--enable-static \
			--disable-shared
	cd icu/source && make

demo: icu/source/lib/libicui18n.a main.c
	$(CC) \
		main.c \
		-o demo \
		$$( (uname -s | grep -qi 'Darwin') || echo '-static' ) \
		-I$$(pwd)/icu/source/io \
		-I$$(pwd)/icu/source/common \
		-I$$(pwd)/icu/source/i18n \
		-L$$(pwd)/icu/source/lib \
		-licui18n \
		-licuuc \
		-licudata \
		-lm \
		-ldl \
		-lpthread \
		-lstdc++
