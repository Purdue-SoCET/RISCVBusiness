#include <stdarg.h>
#include <stdint.h>
#include "utility.h"
#include "format.h"

void print_string(char *str) {
    for(int i = 0; str[i]; i++) {
        *MAGIC_ADDR = str[i];
    }
}

static int 
strcpy_no_nul(const char *source, char *sink) {
    int i;
    for(i = 0; source[i]; i++) {
        sink[i] = source[i];
    }

    return i;
}

static const char table[] = {
    '0', '1', '2', '3',
    '4', '5', '6', '7',
    '8', '9', 'A', 'B',
    'C', 'D', 'E', 'F'
};

// Assumes that negative is handled outside function
static int 
convert_integer(uint32_t in, int base, char *out) {
    char buf[32];

    if(in == 0) {
        out[0] = '0';
        return 1;
    }

    int buf_ptr = 0;
    while(in > 0) {
        buf[buf_ptr++] = table[in % base];
        in /= base;
    }

    buf_ptr -= 1; // set back to correct value
    int i;
    for(i = 0; buf_ptr >= 0; buf_ptr--, i++) {
        out[i] = buf[buf_ptr];
    }

    return i;
}

void __attribute__((noinline))
vformat(const char *fmt, char *buf, va_list args) {
    int out_idx = 0;
    for(int i = 0; fmt[i]; i++) {
        if(fmt[i] != '%') {
            buf[out_idx] = fmt[i];
            out_idx += 1;
        } else if(fmt[i+1]) {
            switch(fmt[i+1]) {
                case '%': buf[out_idx++] = '%';
                          break;

                case 'c': buf[out_idx++] = (char)va_arg(args, int);
                          break;
                case 's': {
                    const char *s = va_arg(args, char *);
                    out_idx += strcpy_no_nul(s, &buf[out_idx]);
                } break;

                case 'd': {
                    int v = va_arg(args, int);
                    if(v < 0) {
                        buf[out_idx++] = '-';
                        v *= -1;
                    }
                    out_idx += convert_integer(v, 10, &buf[out_idx]);
                } break;

                case 'b': {
                    uint32_t v = va_arg(args, uint32_t);
                    buf[out_idx++] = '0';
                    buf[out_idx++] = 'b';
                    out_idx += convert_integer(v, 2, &buf[out_idx]);
                } break;

                case 'x': {
                    uint32_t v = va_arg(args, uint32_t);
                    buf[out_idx++] = '0';
                    buf[out_idx++] = 'x';
                    out_idx += convert_integer(v, 16, &buf[out_idx]);
                } break;

                case 'u': {
                    uint32_t v = va_arg(args, uint32_t);
                    out_idx += convert_integer(v, 10, &buf[out_idx]);
                } break;

                default: {
                    buf[out_idx++] = '?';
                    buf[out_idx++] = '?';
                    buf[out_idx++] = '?';
                } break;
            }
            i += 1;
        } else {
            // invalid, ignore
            buf[out_idx++] = '?';
            buf[out_idx++] = '?';
            buf[out_idx++] = '?';
        }
    }

    buf[out_idx] = '\0';
}

void __attribute__((noinline))
vprint(const char *fmt, va_list args) {
    char print_buf[128];
    vformat(fmt, print_buf, args);
    print_string(print_buf);
}

void __attribute__((noinline))
print(const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    vprint(fmt, args);
    va_end(args);
}

void __attribute__((noinline))
format(const char *fmt, char *buf, ...) {
    va_list args;
    va_start(args, buf);
    vformat(fmt, buf, args);
    va_end(args);
}

void __attribute__((noinline))
dprint(const char *fmt, ...) {
    (void)fmt;
#ifdef DEBUG
    va_list args;
    va_start(args, fmt);
    vprint(fmt, args);
    va_end(args);
#endif
}
