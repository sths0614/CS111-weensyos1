
obj/mpos-app:     file format elf32-i386


Disassembly of section .text:

00200000 <app_printf>:

static void app_printf(const char *format, ...) __attribute__((noinline));

static void
app_printf(const char *format, ...)
{
  200000:	83 ec 0c             	sub    $0xc,%esp
	// That means that after the "asm" instruction (which causes the
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  200003:	cd 30                	int    $0x30
static void
app_printf(const char *format, ...)
{
	// set default color based on currently running process
	int color = sys_getpid();
	if (color < 0)
  200005:	85 c0                	test   %eax,%eax
  200007:	ba 00 07 00 00       	mov    $0x700,%edx
  20000c:	78 13                	js     200021 <app_printf+0x21>
		color = 0x0700;
	else {
		static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
		color = col[color % sizeof(col)] << 8;
  20000e:	b9 05 00 00 00       	mov    $0x5,%ecx
  200013:	31 d2                	xor    %edx,%edx
  200015:	f7 f1                	div    %ecx
  200017:	0f b6 92 b4 05 20 00 	movzbl 0x2005b4(%edx),%edx
  20001e:	c1 e2 08             	shl    $0x8,%edx
	}

	va_list val;
	va_start(val, format);
	cursorpos = console_vprintf(cursorpos, color, format, val);
  200021:	8d 44 24 14          	lea    0x14(%esp),%eax
  200025:	50                   	push   %eax
  200026:	ff 74 24 14          	pushl  0x14(%esp)
  20002a:	52                   	push   %edx
  20002b:	ff 35 00 00 06 00    	pushl  0x60000
  200031:	e8 a9 01 00 00       	call   2001df <console_vprintf>
  200036:	a3 00 00 06 00       	mov    %eax,0x60000
	va_end(val);
}
  20003b:	83 c4 1c             	add    $0x1c,%esp
  20003e:	c3                   	ret    

0020003f <run_child>:
}


void
run_child(void)
{
  20003f:	83 ec 24             	sub    $0x24,%esp
	int i;
	volatile int checker = 1; /* This variable checks that you correctly
  200042:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%esp)
  200049:	00 
	// That means that after the "asm" instruction (which causes the
	// interrupt), the system call's return value is in the 'pid'
	// variable, and we can just return that value!

	pid_t pid;
	asm volatile("int %1\n"
  20004a:	cd 30                	int    $0x30
				     gave this process a new stack.
				     If the parent's 'checker' changed value
				     after the child ran, there's a problem! */

	app_printf("Child process %d!\n", sys_getpid());
  20004c:	50                   	push   %eax
  20004d:	68 9c 05 20 00       	push   $0x20059c
  200052:	e8 a9 ff ff ff       	call   200000 <app_printf>
  200057:	31 c0                	xor    %eax,%eax
  200059:	83 c4 10             	add    $0x10,%esp

static inline void
sys_yield(void)
{
	// This system call has no return values, so there's no '=a' clause.
	asm volatile("int %0\n"
  20005c:	cd 32                	int    $0x32

	// Yield a couple times to help people test Exercise 3
	for (i = 0; i < 20; i++)
  20005e:	40                   	inc    %eax
  20005f:	83 f8 14             	cmp    $0x14,%eax
  200062:	75 f8                	jne    20005c <run_child+0x1d>
	// the 'int' instruction.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  200064:	66 b8 e8 03          	mov    $0x3e8,%ax
  200068:	cd 33                	int    $0x33
  20006a:	eb fe                	jmp    20006a <run_child+0x2b>

0020006c <start>:
	}
}
*/


void start(void){
  20006c:	83 ec 1c             	sub    $0x1c,%esp
	int x = 0; // note that local variable x lives on the stack

	//Source: http://stackoverflow.com/questions/9935190/why-is-a-point-to-volatile-pointer-like-volatile-int-p-useful
	volatile int *ptr_to_vol_int = &x;
	int *volatile vol_ptr_to_int = &x;
  20006f:	8d 54 24 0c          	lea    0xc(%esp),%edx
}
*/


void start(void){
	int x = 0; // note that local variable x lives on the stack
  200073:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  20007a:	00 

	//Source: http://stackoverflow.com/questions/9935190/why-is-a-point-to-volatile-pointer-like-volatile-int-p-useful
	volatile int *ptr_to_vol_int = &x;
	int *volatile vol_ptr_to_int = &x;
  20007b:	89 54 24 08          	mov    %edx,0x8(%esp)
sys_fork(void)
{
	// This system call follows the same pattern as sys_getpid().

	pid_t result;
	asm volatile("int %1\n"
  20007f:	cd 31                	int    $0x31

	pid_t p = sys_fork();
	if (p == 0){ // child process
  200081:	83 f8 00             	cmp    $0x0,%eax
  200084:	75 18                	jne    20009e <start+0x32>
		ptr_to_vol_int = &x;
		vol_ptr_to_int = &x;
  200086:	89 54 24 08          	mov    %edx,0x8(%esp)
		*ptr_to_vol_int = 1;
  20008a:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
  200091:	00 
		*vol_ptr_to_int = 1;
  200092:	8b 44 24 08          	mov    0x8(%esp),%eax
  200096:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  20009c:	eb 04                	jmp    2000a2 <start+0x36>
	}
	else if (p > 0){
  20009e:	7e 02                	jle    2000a2 <start+0x36>

static inline int
sys_wait(pid_t pid)
{
	int retval;
	asm volatile("int %1\n"
  2000a0:	cd 34                	int    $0x34
		sys_wait(p); // assume blocking implementation
	}
	app_printf("%d", x);
  2000a2:	50                   	push   %eax
  2000a3:	50                   	push   %eax
  2000a4:	ff 74 24 14          	pushl  0x14(%esp)
  2000a8:	68 af 05 20 00       	push   $0x2005af
  2000ad:	e8 4e ff ff ff       	call   200000 <app_printf>
	// the 'int' instruction.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.

	asm volatile("int %0\n"
  2000b2:	31 c0                	xor    %eax,%eax
  2000b4:	cd 33                	int    $0x33
  2000b6:	83 c4 10             	add    $0x10,%esp
  2000b9:	eb fe                	jmp    2000b9 <start+0x4d>
  2000bb:	90                   	nop

002000bc <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  2000bc:	56                   	push   %esi
  2000bd:	31 d2                	xor    %edx,%edx
  2000bf:	53                   	push   %ebx
  2000c0:	8b 44 24 0c          	mov    0xc(%esp),%eax
  2000c4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  2000c8:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  2000cc:	eb 08                	jmp    2000d6 <memcpy+0x1a>
		*d++ = *s++;
  2000ce:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  2000d1:	4e                   	dec    %esi
  2000d2:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  2000d5:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  2000d6:	85 f6                	test   %esi,%esi
  2000d8:	75 f4                	jne    2000ce <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  2000da:	5b                   	pop    %ebx
  2000db:	5e                   	pop    %esi
  2000dc:	c3                   	ret    

002000dd <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  2000dd:	57                   	push   %edi
  2000de:	56                   	push   %esi
  2000df:	53                   	push   %ebx
  2000e0:	8b 44 24 10          	mov    0x10(%esp),%eax
  2000e4:	8b 7c 24 14          	mov    0x14(%esp),%edi
  2000e8:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  2000ec:	39 c7                	cmp    %eax,%edi
  2000ee:	73 26                	jae    200116 <memmove+0x39>
  2000f0:	8d 34 17             	lea    (%edi,%edx,1),%esi
  2000f3:	39 c6                	cmp    %eax,%esi
  2000f5:	76 1f                	jbe    200116 <memmove+0x39>
		s += n, d += n;
  2000f7:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  2000fa:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  2000fc:	eb 07                	jmp    200105 <memmove+0x28>
			*--d = *--s;
  2000fe:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  200101:	4a                   	dec    %edx
  200102:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  200105:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  200106:	85 d2                	test   %edx,%edx
  200108:	75 f4                	jne    2000fe <memmove+0x21>
  20010a:	eb 10                	jmp    20011c <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  20010c:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  20010f:	4a                   	dec    %edx
  200110:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  200113:	41                   	inc    %ecx
  200114:	eb 02                	jmp    200118 <memmove+0x3b>
  200116:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  200118:	85 d2                	test   %edx,%edx
  20011a:	75 f0                	jne    20010c <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  20011c:	5b                   	pop    %ebx
  20011d:	5e                   	pop    %esi
  20011e:	5f                   	pop    %edi
  20011f:	c3                   	ret    

00200120 <memset>:

void *
memset(void *v, int c, size_t n)
{
  200120:	53                   	push   %ebx
  200121:	8b 44 24 08          	mov    0x8(%esp),%eax
  200125:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  200129:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  20012d:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  20012f:	eb 04                	jmp    200135 <memset+0x15>
		*p++ = c;
  200131:	88 1a                	mov    %bl,(%edx)
  200133:	49                   	dec    %ecx
  200134:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  200135:	85 c9                	test   %ecx,%ecx
  200137:	75 f8                	jne    200131 <memset+0x11>
		*p++ = c;
	return v;
}
  200139:	5b                   	pop    %ebx
  20013a:	c3                   	ret    

0020013b <strlen>:

size_t
strlen(const char *s)
{
  20013b:	8b 54 24 04          	mov    0x4(%esp),%edx
  20013f:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  200141:	eb 01                	jmp    200144 <strlen+0x9>
		++n;
  200143:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  200144:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  200148:	75 f9                	jne    200143 <strlen+0x8>
		++n;
	return n;
}
  20014a:	c3                   	ret    

0020014b <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  20014b:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  20014f:	31 c0                	xor    %eax,%eax
  200151:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  200155:	eb 01                	jmp    200158 <strnlen+0xd>
		++n;
  200157:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  200158:	39 d0                	cmp    %edx,%eax
  20015a:	74 06                	je     200162 <strnlen+0x17>
  20015c:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  200160:	75 f5                	jne    200157 <strnlen+0xc>
		++n;
	return n;
}
  200162:	c3                   	ret    

00200163 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  200163:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  200164:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  200169:	53                   	push   %ebx
  20016a:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  20016c:	76 05                	jbe    200173 <console_putc+0x10>
  20016e:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  200173:	80 fa 0a             	cmp    $0xa,%dl
  200176:	75 2c                	jne    2001a4 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  200178:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  20017e:	be 50 00 00 00       	mov    $0x50,%esi
  200183:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  200185:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  200188:	99                   	cltd   
  200189:	f7 fe                	idiv   %esi
  20018b:	89 de                	mov    %ebx,%esi
  20018d:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  20018f:	eb 07                	jmp    200198 <console_putc+0x35>
			*cursor++ = ' ' | color;
  200191:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  200194:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  200195:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  200198:	83 f8 50             	cmp    $0x50,%eax
  20019b:	75 f4                	jne    200191 <console_putc+0x2e>
  20019d:	29 d0                	sub    %edx,%eax
  20019f:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  2001a2:	eb 0b                	jmp    2001af <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  2001a4:	0f b6 d2             	movzbl %dl,%edx
  2001a7:	09 ca                	or     %ecx,%edx
  2001a9:	66 89 13             	mov    %dx,(%ebx)
  2001ac:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  2001af:	5b                   	pop    %ebx
  2001b0:	5e                   	pop    %esi
  2001b1:	c3                   	ret    

002001b2 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  2001b2:	56                   	push   %esi
  2001b3:	53                   	push   %ebx
  2001b4:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  2001b8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  2001bb:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  2001bf:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  2001c4:	75 04                	jne    2001ca <fill_numbuf+0x18>
  2001c6:	85 d2                	test   %edx,%edx
  2001c8:	74 10                	je     2001da <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  2001ca:	89 d0                	mov    %edx,%eax
  2001cc:	31 d2                	xor    %edx,%edx
  2001ce:	f7 f1                	div    %ecx
  2001d0:	4b                   	dec    %ebx
  2001d1:	8a 14 16             	mov    (%esi,%edx,1),%dl
  2001d4:	88 13                	mov    %dl,(%ebx)
			val /= base;
  2001d6:	89 c2                	mov    %eax,%edx
  2001d8:	eb ec                	jmp    2001c6 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  2001da:	89 d8                	mov    %ebx,%eax
  2001dc:	5b                   	pop    %ebx
  2001dd:	5e                   	pop    %esi
  2001de:	c3                   	ret    

002001df <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  2001df:	55                   	push   %ebp
  2001e0:	57                   	push   %edi
  2001e1:	56                   	push   %esi
  2001e2:	53                   	push   %ebx
  2001e3:	83 ec 38             	sub    $0x38,%esp
  2001e6:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  2001ea:	8b 7c 24 54          	mov    0x54(%esp),%edi
  2001ee:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  2001f2:	e9 60 03 00 00       	jmp    200557 <console_vprintf+0x378>
		if (*format != '%') {
  2001f7:	80 fa 25             	cmp    $0x25,%dl
  2001fa:	74 13                	je     20020f <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  2001fc:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200200:	0f b6 d2             	movzbl %dl,%edx
  200203:	89 f0                	mov    %esi,%eax
  200205:	e8 59 ff ff ff       	call   200163 <console_putc>
  20020a:	e9 45 03 00 00       	jmp    200554 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  20020f:	47                   	inc    %edi
  200210:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  200217:	00 
  200218:	eb 12                	jmp    20022c <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  20021a:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  20021b:	8a 11                	mov    (%ecx),%dl
  20021d:	84 d2                	test   %dl,%dl
  20021f:	74 1a                	je     20023b <console_vprintf+0x5c>
  200221:	89 e8                	mov    %ebp,%eax
  200223:	38 c2                	cmp    %al,%dl
  200225:	75 f3                	jne    20021a <console_vprintf+0x3b>
  200227:	e9 3f 03 00 00       	jmp    20056b <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  20022c:	8a 17                	mov    (%edi),%dl
  20022e:	84 d2                	test   %dl,%dl
  200230:	74 0b                	je     20023d <console_vprintf+0x5e>
  200232:	b9 bc 05 20 00       	mov    $0x2005bc,%ecx
  200237:	89 d5                	mov    %edx,%ebp
  200239:	eb e0                	jmp    20021b <console_vprintf+0x3c>
  20023b:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  20023d:	8d 42 cf             	lea    -0x31(%edx),%eax
  200240:	3c 08                	cmp    $0x8,%al
  200242:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  200249:	00 
  20024a:	76 13                	jbe    20025f <console_vprintf+0x80>
  20024c:	eb 1d                	jmp    20026b <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  20024e:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  200253:	0f be c0             	movsbl %al,%eax
  200256:	47                   	inc    %edi
  200257:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  20025b:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  20025f:	8a 07                	mov    (%edi),%al
  200261:	8d 50 d0             	lea    -0x30(%eax),%edx
  200264:	80 fa 09             	cmp    $0x9,%dl
  200267:	76 e5                	jbe    20024e <console_vprintf+0x6f>
  200269:	eb 18                	jmp    200283 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  20026b:	80 fa 2a             	cmp    $0x2a,%dl
  20026e:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  200275:	ff 
  200276:	75 0b                	jne    200283 <console_vprintf+0xa4>
			width = va_arg(val, int);
  200278:	83 c3 04             	add    $0x4,%ebx
			++format;
  20027b:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  20027c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  20027f:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  200283:	83 cd ff             	or     $0xffffffff,%ebp
  200286:	80 3f 2e             	cmpb   $0x2e,(%edi)
  200289:	75 37                	jne    2002c2 <console_vprintf+0xe3>
			++format;
  20028b:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  20028c:	31 ed                	xor    %ebp,%ebp
  20028e:	8a 07                	mov    (%edi),%al
  200290:	8d 50 d0             	lea    -0x30(%eax),%edx
  200293:	80 fa 09             	cmp    $0x9,%dl
  200296:	76 0d                	jbe    2002a5 <console_vprintf+0xc6>
  200298:	eb 17                	jmp    2002b1 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  20029a:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  20029d:	0f be c0             	movsbl %al,%eax
  2002a0:	47                   	inc    %edi
  2002a1:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  2002a5:	8a 07                	mov    (%edi),%al
  2002a7:	8d 50 d0             	lea    -0x30(%eax),%edx
  2002aa:	80 fa 09             	cmp    $0x9,%dl
  2002ad:	76 eb                	jbe    20029a <console_vprintf+0xbb>
  2002af:	eb 11                	jmp    2002c2 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  2002b1:	3c 2a                	cmp    $0x2a,%al
  2002b3:	75 0b                	jne    2002c0 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  2002b5:	83 c3 04             	add    $0x4,%ebx
				++format;
  2002b8:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  2002b9:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  2002bc:	85 ed                	test   %ebp,%ebp
  2002be:	79 02                	jns    2002c2 <console_vprintf+0xe3>
  2002c0:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  2002c2:	8a 07                	mov    (%edi),%al
  2002c4:	3c 64                	cmp    $0x64,%al
  2002c6:	74 34                	je     2002fc <console_vprintf+0x11d>
  2002c8:	7f 1d                	jg     2002e7 <console_vprintf+0x108>
  2002ca:	3c 58                	cmp    $0x58,%al
  2002cc:	0f 84 a2 00 00 00    	je     200374 <console_vprintf+0x195>
  2002d2:	3c 63                	cmp    $0x63,%al
  2002d4:	0f 84 bf 00 00 00    	je     200399 <console_vprintf+0x1ba>
  2002da:	3c 43                	cmp    $0x43,%al
  2002dc:	0f 85 d0 00 00 00    	jne    2003b2 <console_vprintf+0x1d3>
  2002e2:	e9 a3 00 00 00       	jmp    20038a <console_vprintf+0x1ab>
  2002e7:	3c 75                	cmp    $0x75,%al
  2002e9:	74 4d                	je     200338 <console_vprintf+0x159>
  2002eb:	3c 78                	cmp    $0x78,%al
  2002ed:	74 5c                	je     20034b <console_vprintf+0x16c>
  2002ef:	3c 73                	cmp    $0x73,%al
  2002f1:	0f 85 bb 00 00 00    	jne    2003b2 <console_vprintf+0x1d3>
  2002f7:	e9 86 00 00 00       	jmp    200382 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  2002fc:	83 c3 04             	add    $0x4,%ebx
  2002ff:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  200302:	89 d1                	mov    %edx,%ecx
  200304:	c1 f9 1f             	sar    $0x1f,%ecx
  200307:	89 0c 24             	mov    %ecx,(%esp)
  20030a:	31 ca                	xor    %ecx,%edx
  20030c:	55                   	push   %ebp
  20030d:	29 ca                	sub    %ecx,%edx
  20030f:	68 c4 05 20 00       	push   $0x2005c4
  200314:	b9 0a 00 00 00       	mov    $0xa,%ecx
  200319:	8d 44 24 40          	lea    0x40(%esp),%eax
  20031d:	e8 90 fe ff ff       	call   2001b2 <fill_numbuf>
  200322:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  200326:	58                   	pop    %eax
  200327:	5a                   	pop    %edx
  200328:	ba 01 00 00 00       	mov    $0x1,%edx
  20032d:	8b 04 24             	mov    (%esp),%eax
  200330:	83 e0 01             	and    $0x1,%eax
  200333:	e9 a5 00 00 00       	jmp    2003dd <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  200338:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  20033b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  200340:	8b 53 fc             	mov    -0x4(%ebx),%edx
  200343:	55                   	push   %ebp
  200344:	68 c4 05 20 00       	push   $0x2005c4
  200349:	eb 11                	jmp    20035c <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  20034b:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  20034e:	8b 53 fc             	mov    -0x4(%ebx),%edx
  200351:	55                   	push   %ebp
  200352:	68 d8 05 20 00       	push   $0x2005d8
  200357:	b9 10 00 00 00       	mov    $0x10,%ecx
  20035c:	8d 44 24 40          	lea    0x40(%esp),%eax
  200360:	e8 4d fe ff ff       	call   2001b2 <fill_numbuf>
  200365:	ba 01 00 00 00       	mov    $0x1,%edx
  20036a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  20036e:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  200370:	59                   	pop    %ecx
  200371:	59                   	pop    %ecx
  200372:	eb 69                	jmp    2003dd <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  200374:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  200377:	8b 53 fc             	mov    -0x4(%ebx),%edx
  20037a:	55                   	push   %ebp
  20037b:	68 c4 05 20 00       	push   $0x2005c4
  200380:	eb d5                	jmp    200357 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  200382:	83 c3 04             	add    $0x4,%ebx
  200385:	8b 43 fc             	mov    -0x4(%ebx),%eax
  200388:	eb 40                	jmp    2003ca <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  20038a:	83 c3 04             	add    $0x4,%ebx
  20038d:	8b 53 fc             	mov    -0x4(%ebx),%edx
  200390:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  200394:	e9 bd 01 00 00       	jmp    200556 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  200399:	83 c3 04             	add    $0x4,%ebx
  20039c:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  20039f:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  2003a3:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  2003a8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  2003ac:	88 44 24 24          	mov    %al,0x24(%esp)
  2003b0:	eb 27                	jmp    2003d9 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  2003b2:	84 c0                	test   %al,%al
  2003b4:	75 02                	jne    2003b8 <console_vprintf+0x1d9>
  2003b6:	b0 25                	mov    $0x25,%al
  2003b8:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  2003bc:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  2003c1:	80 3f 00             	cmpb   $0x0,(%edi)
  2003c4:	74 0a                	je     2003d0 <console_vprintf+0x1f1>
  2003c6:	8d 44 24 24          	lea    0x24(%esp),%eax
  2003ca:	89 44 24 04          	mov    %eax,0x4(%esp)
  2003ce:	eb 09                	jmp    2003d9 <console_vprintf+0x1fa>
				format--;
  2003d0:	8d 54 24 24          	lea    0x24(%esp),%edx
  2003d4:	4f                   	dec    %edi
  2003d5:	89 54 24 04          	mov    %edx,0x4(%esp)
  2003d9:	31 d2                	xor    %edx,%edx
  2003db:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  2003dd:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  2003df:	83 fd ff             	cmp    $0xffffffff,%ebp
  2003e2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  2003e9:	74 1f                	je     20040a <console_vprintf+0x22b>
  2003eb:	89 04 24             	mov    %eax,(%esp)
  2003ee:	eb 01                	jmp    2003f1 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  2003f0:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  2003f1:	39 e9                	cmp    %ebp,%ecx
  2003f3:	74 0a                	je     2003ff <console_vprintf+0x220>
  2003f5:	8b 44 24 04          	mov    0x4(%esp),%eax
  2003f9:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  2003fd:	75 f1                	jne    2003f0 <console_vprintf+0x211>
  2003ff:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  200402:	89 0c 24             	mov    %ecx,(%esp)
  200405:	eb 1f                	jmp    200426 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  200407:	42                   	inc    %edx
  200408:	eb 09                	jmp    200413 <console_vprintf+0x234>
  20040a:	89 d1                	mov    %edx,%ecx
  20040c:	8b 14 24             	mov    (%esp),%edx
  20040f:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  200413:	8b 44 24 04          	mov    0x4(%esp),%eax
  200417:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  20041b:	75 ea                	jne    200407 <console_vprintf+0x228>
  20041d:	8b 44 24 08          	mov    0x8(%esp),%eax
  200421:	89 14 24             	mov    %edx,(%esp)
  200424:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  200426:	85 c0                	test   %eax,%eax
  200428:	74 0c                	je     200436 <console_vprintf+0x257>
  20042a:	84 d2                	test   %dl,%dl
  20042c:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  200433:	00 
  200434:	75 24                	jne    20045a <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  200436:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  20043b:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  200442:	00 
  200443:	75 15                	jne    20045a <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  200445:	8b 44 24 14          	mov    0x14(%esp),%eax
  200449:	83 e0 08             	and    $0x8,%eax
  20044c:	83 f8 01             	cmp    $0x1,%eax
  20044f:	19 c9                	sbb    %ecx,%ecx
  200451:	f7 d1                	not    %ecx
  200453:	83 e1 20             	and    $0x20,%ecx
  200456:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  20045a:	3b 2c 24             	cmp    (%esp),%ebp
  20045d:	7e 0d                	jle    20046c <console_vprintf+0x28d>
  20045f:	84 d2                	test   %dl,%dl
  200461:	74 40                	je     2004a3 <console_vprintf+0x2c4>
			zeros = precision - len;
  200463:	2b 2c 24             	sub    (%esp),%ebp
  200466:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  20046a:	eb 3f                	jmp    2004ab <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  20046c:	84 d2                	test   %dl,%dl
  20046e:	74 33                	je     2004a3 <console_vprintf+0x2c4>
  200470:	8b 44 24 14          	mov    0x14(%esp),%eax
  200474:	83 e0 06             	and    $0x6,%eax
  200477:	83 f8 02             	cmp    $0x2,%eax
  20047a:	75 27                	jne    2004a3 <console_vprintf+0x2c4>
  20047c:	45                   	inc    %ebp
  20047d:	75 24                	jne    2004a3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  20047f:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  200481:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  200484:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  200489:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  20048c:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  20048f:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  200493:	7d 0e                	jge    2004a3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  200495:	8b 54 24 0c          	mov    0xc(%esp),%edx
  200499:	29 ca                	sub    %ecx,%edx
  20049b:	29 c2                	sub    %eax,%edx
  20049d:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  2004a1:	eb 08                	jmp    2004ab <console_vprintf+0x2cc>
  2004a3:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  2004aa:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  2004ab:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  2004af:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  2004b1:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  2004b5:	2b 2c 24             	sub    (%esp),%ebp
  2004b8:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  2004bd:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  2004c0:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  2004c3:	29 c5                	sub    %eax,%ebp
  2004c5:	89 f0                	mov    %esi,%eax
  2004c7:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  2004cb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  2004cf:	eb 0f                	jmp    2004e0 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  2004d1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  2004d5:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  2004da:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  2004db:	e8 83 fc ff ff       	call   200163 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  2004e0:	85 ed                	test   %ebp,%ebp
  2004e2:	7e 07                	jle    2004eb <console_vprintf+0x30c>
  2004e4:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  2004e9:	74 e6                	je     2004d1 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  2004eb:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  2004f0:	89 c6                	mov    %eax,%esi
  2004f2:	74 23                	je     200517 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  2004f4:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  2004f9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  2004fd:	e8 61 fc ff ff       	call   200163 <console_putc>
  200502:	89 c6                	mov    %eax,%esi
  200504:	eb 11                	jmp    200517 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  200506:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  20050a:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  20050f:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  200510:	e8 4e fc ff ff       	call   200163 <console_putc>
  200515:	eb 06                	jmp    20051d <console_vprintf+0x33e>
  200517:	89 f0                	mov    %esi,%eax
  200519:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  20051d:	85 f6                	test   %esi,%esi
  20051f:	7f e5                	jg     200506 <console_vprintf+0x327>
  200521:	8b 34 24             	mov    (%esp),%esi
  200524:	eb 15                	jmp    20053b <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  200526:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  20052a:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  20052b:	0f b6 11             	movzbl (%ecx),%edx
  20052e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200532:	e8 2c fc ff ff       	call   200163 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  200537:	ff 44 24 04          	incl   0x4(%esp)
  20053b:	85 f6                	test   %esi,%esi
  20053d:	7f e7                	jg     200526 <console_vprintf+0x347>
  20053f:	eb 0f                	jmp    200550 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  200541:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  200545:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  20054a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  20054b:	e8 13 fc ff ff       	call   200163 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  200550:	85 ed                	test   %ebp,%ebp
  200552:	7f ed                	jg     200541 <console_vprintf+0x362>
  200554:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  200556:	47                   	inc    %edi
  200557:	8a 17                	mov    (%edi),%dl
  200559:	84 d2                	test   %dl,%dl
  20055b:	0f 85 96 fc ff ff    	jne    2001f7 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  200561:	83 c4 38             	add    $0x38,%esp
  200564:	89 f0                	mov    %esi,%eax
  200566:	5b                   	pop    %ebx
  200567:	5e                   	pop    %esi
  200568:	5f                   	pop    %edi
  200569:	5d                   	pop    %ebp
  20056a:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  20056b:	81 e9 bc 05 20 00    	sub    $0x2005bc,%ecx
  200571:	b8 01 00 00 00       	mov    $0x1,%eax
  200576:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  200578:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  200579:	09 44 24 14          	or     %eax,0x14(%esp)
  20057d:	e9 aa fc ff ff       	jmp    20022c <console_vprintf+0x4d>

00200582 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  200582:	8d 44 24 10          	lea    0x10(%esp),%eax
  200586:	50                   	push   %eax
  200587:	ff 74 24 10          	pushl  0x10(%esp)
  20058b:	ff 74 24 10          	pushl  0x10(%esp)
  20058f:	ff 74 24 10          	pushl  0x10(%esp)
  200593:	e8 47 fc ff ff       	call   2001df <console_vprintf>
  200598:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  20059b:	c3                   	ret    
