
obj/user/num.debug:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	cmpl $USTACKTOP, %esp
  800020:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  800026:	75 04                	jne    80002c <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  800028:	6a 00                	push   $0x0
	pushl $0
  80002a:	6a 00                	push   $0x0

0080002c <args_exist>:

args_exist:
	call libmain
  80002c:	e8 9b 01 00 00       	call   8001cc <libmain>
1:	jmp 1b
  800031:	eb fe                	jmp    800031 <args_exist+0x5>

00800033 <num>:
int bol = 1;
int line = 0;

void
num(int f, const char *s)
{
  800033:	55                   	push   %ebp
  800034:	89 e5                	mov    %esp,%ebp
  800036:	56                   	push   %esi
  800037:	53                   	push   %ebx
  800038:	83 ec 30             	sub    $0x30,%esp
  80003b:	8b 75 08             	mov    0x8(%ebp),%esi
	long n;
	int r;
	char c;

	while ((n = read(f, &c, 1)) > 0) {
  80003e:	8d 5d f7             	lea    -0x9(%ebp),%ebx
  800041:	e9 84 00 00 00       	jmp    8000ca <num+0x97>
		if (bol) {
  800046:	83 3d 00 30 80 00 00 	cmpl   $0x0,0x803000
  80004d:	74 27                	je     800076 <num+0x43>
			printf("%5d ", ++line);
  80004f:	a1 00 40 80 00       	mov    0x804000,%eax
  800054:	83 c0 01             	add    $0x1,%eax
  800057:	a3 00 40 80 00       	mov    %eax,0x804000
  80005c:	89 44 24 04          	mov    %eax,0x4(%esp)
  800060:	c7 04 24 e0 23 80 00 	movl   $0x8023e0,(%esp)
  800067:	e8 e5 19 00 00       	call   801a51 <printf>
			bol = 0;
  80006c:	c7 05 00 30 80 00 00 	movl   $0x0,0x803000
  800073:	00 00 00 
		}
		if ((r = write(1, &c, 1)) != 1)
  800076:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  80007d:	00 
  80007e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  800082:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  800089:	e8 75 14 00 00       	call   801503 <write>
  80008e:	83 f8 01             	cmp    $0x1,%eax
  800091:	74 27                	je     8000ba <num+0x87>
			panic("write error copying %s: %e", s, r);
  800093:	89 44 24 10          	mov    %eax,0x10(%esp)
  800097:	8b 45 0c             	mov    0xc(%ebp),%eax
  80009a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80009e:	c7 44 24 08 e5 23 80 	movl   $0x8023e5,0x8(%esp)
  8000a5:	00 
  8000a6:	c7 44 24 04 13 00 00 	movl   $0x13,0x4(%esp)
  8000ad:	00 
  8000ae:	c7 04 24 00 24 80 00 	movl   $0x802400,(%esp)
  8000b5:	e8 a3 01 00 00       	call   80025d <_panic>
		if (c == '\n')
  8000ba:	80 7d f7 0a          	cmpb   $0xa,-0x9(%ebp)
  8000be:	75 0a                	jne    8000ca <num+0x97>
			bol = 1;
  8000c0:	c7 05 00 30 80 00 01 	movl   $0x1,0x803000
  8000c7:	00 00 00 
{
	long n;
	int r;
	char c;

	while ((n = read(f, &c, 1)) > 0) {
  8000ca:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  8000d1:	00 
  8000d2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  8000d6:	89 34 24             	mov    %esi,(%esp)
  8000d9:	e8 38 13 00 00       	call   801416 <read>
  8000de:	85 c0                	test   %eax,%eax
  8000e0:	0f 8f 60 ff ff ff    	jg     800046 <num+0x13>
		if ((r = write(1, &c, 1)) != 1)
			panic("write error copying %s: %e", s, r);
		if (c == '\n')
			bol = 1;
	}
	if (n < 0)
  8000e6:	85 c0                	test   %eax,%eax
  8000e8:	79 27                	jns    800111 <num+0xde>
		panic("error reading %s: %e", s, n);
  8000ea:	89 44 24 10          	mov    %eax,0x10(%esp)
  8000ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000f1:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8000f5:	c7 44 24 08 0b 24 80 	movl   $0x80240b,0x8(%esp)
  8000fc:	00 
  8000fd:	c7 44 24 04 18 00 00 	movl   $0x18,0x4(%esp)
  800104:	00 
  800105:	c7 04 24 00 24 80 00 	movl   $0x802400,(%esp)
  80010c:	e8 4c 01 00 00       	call   80025d <_panic>
}
  800111:	83 c4 30             	add    $0x30,%esp
  800114:	5b                   	pop    %ebx
  800115:	5e                   	pop    %esi
  800116:	5d                   	pop    %ebp
  800117:	c3                   	ret    

00800118 <umain>:

void
umain(int argc, char **argv)
{
  800118:	55                   	push   %ebp
  800119:	89 e5                	mov    %esp,%ebp
  80011b:	57                   	push   %edi
  80011c:	56                   	push   %esi
  80011d:	53                   	push   %ebx
  80011e:	83 ec 2c             	sub    $0x2c,%esp
	int f, i;

	binaryname = "num";
  800121:	c7 05 04 30 80 00 20 	movl   $0x802420,0x803004
  800128:	24 80 00 
	if (argc == 1)
  80012b:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  80012f:	74 13                	je     800144 <umain+0x2c>
  800131:	8b 45 0c             	mov    0xc(%ebp),%eax
  800134:	8d 58 04             	lea    0x4(%eax),%ebx
		num(0, "<stdin>");
	else
		for (i = 1; i < argc; i++) {
  800137:	bf 01 00 00 00       	mov    $0x1,%edi
  80013c:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  800140:	7f 18                	jg     80015a <umain+0x42>
  800142:	eb 7b                	jmp    8001bf <umain+0xa7>
{
	int f, i;

	binaryname = "num";
	if (argc == 1)
		num(0, "<stdin>");
  800144:	c7 44 24 04 24 24 80 	movl   $0x802424,0x4(%esp)
  80014b:	00 
  80014c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  800153:	e8 db fe ff ff       	call   800033 <num>
  800158:	eb 65                	jmp    8001bf <umain+0xa7>
	else
		for (i = 1; i < argc; i++) {
			f = open(argv[i], O_RDONLY);
  80015a:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  80015d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  800164:	00 
  800165:	8b 03                	mov    (%ebx),%eax
  800167:	89 04 24             	mov    %eax,(%esp)
  80016a:	e8 49 17 00 00       	call   8018b8 <open>
  80016f:	89 c6                	mov    %eax,%esi
			if (f < 0)
  800171:	85 c0                	test   %eax,%eax
  800173:	79 29                	jns    80019e <umain+0x86>
				panic("can't open %s: %e", argv[i], f);
  800175:	89 44 24 10          	mov    %eax,0x10(%esp)
  800179:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80017c:	8b 00                	mov    (%eax),%eax
  80017e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  800182:	c7 44 24 08 2c 24 80 	movl   $0x80242c,0x8(%esp)
  800189:	00 
  80018a:	c7 44 24 04 27 00 00 	movl   $0x27,0x4(%esp)
  800191:	00 
  800192:	c7 04 24 00 24 80 00 	movl   $0x802400,(%esp)
  800199:	e8 bf 00 00 00       	call   80025d <_panic>
			else {
				num(f, argv[i]);
  80019e:	8b 03                	mov    (%ebx),%eax
  8001a0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8001a4:	89 34 24             	mov    %esi,(%esp)
  8001a7:	e8 87 fe ff ff       	call   800033 <num>
				close(f);
  8001ac:	89 34 24             	mov    %esi,(%esp)
  8001af:	e8 ff 10 00 00       	call   8012b3 <close>

	binaryname = "num";
	if (argc == 1)
		num(0, "<stdin>");
	else
		for (i = 1; i < argc; i++) {
  8001b4:	83 c7 01             	add    $0x1,%edi
  8001b7:	83 c3 04             	add    $0x4,%ebx
  8001ba:	3b 7d 08             	cmp    0x8(%ebp),%edi
  8001bd:	75 9b                	jne    80015a <umain+0x42>
			else {
				num(f, argv[i]);
				close(f);
			}
		}
	exit();
  8001bf:	e8 80 00 00 00       	call   800244 <exit>
}
  8001c4:	83 c4 2c             	add    $0x2c,%esp
  8001c7:	5b                   	pop    %ebx
  8001c8:	5e                   	pop    %esi
  8001c9:	5f                   	pop    %edi
  8001ca:	5d                   	pop    %ebp
  8001cb:	c3                   	ret    

008001cc <libmain>:
const volatile struct Env *thisenv;
const char *binaryname = "<unknown>";

void
libmain(int argc, char **argv)
{
  8001cc:	55                   	push   %ebp
  8001cd:	89 e5                	mov    %esp,%ebp
  8001cf:	56                   	push   %esi
  8001d0:	53                   	push   %ebx
  8001d1:	83 ec 10             	sub    $0x10,%esp
  8001d4:	8b 5d 08             	mov    0x8(%ebp),%ebx
  8001d7:	8b 75 0c             	mov    0xc(%ebp),%esi
	// set thisenv to point at our Env structure in envs[].
	int i;
	envid_t current_id = sys_getenvid();
  8001da:	e8 3c 0c 00 00       	call   800e1b <sys_getenvid>
	for (i = 0; i < NENV; ++i) {
		if (envs[i].env_id == current_id) {
  8001df:	8b 15 48 00 c0 ee    	mov    0xeec00048,%edx
  8001e5:	39 c2                	cmp    %eax,%edx
  8001e7:	74 17                	je     800200 <libmain+0x34>
libmain(int argc, char **argv)
{
	// set thisenv to point at our Env structure in envs[].
	int i;
	envid_t current_id = sys_getenvid();
	for (i = 0; i < NENV; ++i) {
  8001e9:	ba 01 00 00 00       	mov    $0x1,%edx
		if (envs[i].env_id == current_id) {
  8001ee:	6b ca 7c             	imul   $0x7c,%edx,%ecx
  8001f1:	81 c1 08 00 c0 ee    	add    $0xeec00008,%ecx
  8001f7:	8b 49 40             	mov    0x40(%ecx),%ecx
  8001fa:	39 c1                	cmp    %eax,%ecx
  8001fc:	75 18                	jne    800216 <libmain+0x4a>
  8001fe:	eb 05                	jmp    800205 <libmain+0x39>
libmain(int argc, char **argv)
{
	// set thisenv to point at our Env structure in envs[].
	int i;
	envid_t current_id = sys_getenvid();
	for (i = 0; i < NENV; ++i) {
  800200:	ba 00 00 00 00       	mov    $0x0,%edx
		if (envs[i].env_id == current_id) {
		// if (envs[i].env_status == ENV_RUNNING) {
			thisenv = envs + i;
  800205:	6b d2 7c             	imul   $0x7c,%edx,%edx
  800208:	81 c2 00 00 c0 ee    	add    $0xeec00000,%edx
  80020e:	89 15 08 40 80 00    	mov    %edx,0x804008
			break;
  800214:	eb 0b                	jmp    800221 <libmain+0x55>
libmain(int argc, char **argv)
{
	// set thisenv to point at our Env structure in envs[].
	int i;
	envid_t current_id = sys_getenvid();
	for (i = 0; i < NENV; ++i) {
  800216:	83 c2 01             	add    $0x1,%edx
  800219:	81 fa 00 04 00 00    	cmp    $0x400,%edx
  80021f:	75 cd                	jne    8001ee <libmain+0x22>

	// cprintf("ID Get from sys: %d\n", current_id);
	// cprintf("ID Get by loop: %d\n", thisenv->env_id);

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800221:	85 db                	test   %ebx,%ebx
  800223:	7e 07                	jle    80022c <libmain+0x60>
		binaryname = argv[0];
  800225:	8b 06                	mov    (%esi),%eax
  800227:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	umain(argc, argv);
  80022c:	89 74 24 04          	mov    %esi,0x4(%esp)
  800230:	89 1c 24             	mov    %ebx,(%esp)
  800233:	e8 e0 fe ff ff       	call   800118 <umain>

	// exit gracefully
	exit();
  800238:	e8 07 00 00 00       	call   800244 <exit>
}
  80023d:	83 c4 10             	add    $0x10,%esp
  800240:	5b                   	pop    %ebx
  800241:	5e                   	pop    %esi
  800242:	5d                   	pop    %ebp
  800243:	c3                   	ret    

00800244 <exit>:

#include <inc/lib.h>

void
exit(void)
{
  800244:	55                   	push   %ebp
  800245:	89 e5                	mov    %esp,%ebp
  800247:	83 ec 18             	sub    $0x18,%esp
	close_all();
  80024a:	e8 97 10 00 00       	call   8012e6 <close_all>
	sys_env_destroy(0);
  80024f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  800256:	e8 6e 0b 00 00       	call   800dc9 <sys_env_destroy>
}
  80025b:	c9                   	leave  
  80025c:	c3                   	ret    

0080025d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes JOS to enter the JOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt, ...)
{
  80025d:	55                   	push   %ebp
  80025e:	89 e5                	mov    %esp,%ebp
  800260:	56                   	push   %esi
  800261:	53                   	push   %ebx
  800262:	83 ec 20             	sub    $0x20,%esp
	va_list ap;

	va_start(ap, fmt);
  800265:	8d 5d 14             	lea    0x14(%ebp),%ebx

	// Print the panic message
	cprintf("[%08x] user panic in %s at %s:%d: ",
  800268:	8b 35 04 30 80 00    	mov    0x803004,%esi
  80026e:	e8 a8 0b 00 00       	call   800e1b <sys_getenvid>
  800273:	8b 55 0c             	mov    0xc(%ebp),%edx
  800276:	89 54 24 10          	mov    %edx,0x10(%esp)
  80027a:	8b 55 08             	mov    0x8(%ebp),%edx
  80027d:	89 54 24 0c          	mov    %edx,0xc(%esp)
  800281:	89 74 24 08          	mov    %esi,0x8(%esp)
  800285:	89 44 24 04          	mov    %eax,0x4(%esp)
  800289:	c7 04 24 48 24 80 00 	movl   $0x802448,(%esp)
  800290:	e8 c1 00 00 00       	call   800356 <cprintf>
		sys_getenvid(), binaryname, file, line);
	vcprintf(fmt, ap);
  800295:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  800299:	8b 45 10             	mov    0x10(%ebp),%eax
  80029c:	89 04 24             	mov    %eax,(%esp)
  80029f:	e8 51 00 00 00       	call   8002f5 <vcprintf>
	cprintf("\n");
  8002a4:	c7 04 24 74 28 80 00 	movl   $0x802874,(%esp)
  8002ab:	e8 a6 00 00 00       	call   800356 <cprintf>

	// Cause a breakpoint exception
	while (1)
		asm volatile("int3");
  8002b0:	cc                   	int3   
  8002b1:	eb fd                	jmp    8002b0 <_panic+0x53>

008002b3 <putch>:
};


static void
putch(int ch, struct printbuf *b)
{
  8002b3:	55                   	push   %ebp
  8002b4:	89 e5                	mov    %esp,%ebp
  8002b6:	53                   	push   %ebx
  8002b7:	83 ec 14             	sub    $0x14,%esp
  8002ba:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	b->buf[b->idx++] = ch;
  8002bd:	8b 13                	mov    (%ebx),%edx
  8002bf:	8d 42 01             	lea    0x1(%edx),%eax
  8002c2:	89 03                	mov    %eax,(%ebx)
  8002c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8002c7:	88 4c 13 08          	mov    %cl,0x8(%ebx,%edx,1)
	if (b->idx == 256-1) {
  8002cb:	3d ff 00 00 00       	cmp    $0xff,%eax
  8002d0:	75 19                	jne    8002eb <putch+0x38>
		sys_cputs(b->buf, b->idx);
  8002d2:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
  8002d9:	00 
  8002da:	8d 43 08             	lea    0x8(%ebx),%eax
  8002dd:	89 04 24             	mov    %eax,(%esp)
  8002e0:	e8 a7 0a 00 00       	call   800d8c <sys_cputs>
		b->idx = 0;
  8002e5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	}
	b->cnt++;
  8002eb:	83 43 04 01          	addl   $0x1,0x4(%ebx)
}
  8002ef:	83 c4 14             	add    $0x14,%esp
  8002f2:	5b                   	pop    %ebx
  8002f3:	5d                   	pop    %ebp
  8002f4:	c3                   	ret    

008002f5 <vcprintf>:

int
vcprintf(const char *fmt, va_list ap)
{
  8002f5:	55                   	push   %ebp
  8002f6:	89 e5                	mov    %esp,%ebp
  8002f8:	81 ec 28 01 00 00    	sub    $0x128,%esp
	struct printbuf b;

	b.idx = 0;
  8002fe:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800305:	00 00 00 
	b.cnt = 0;
  800308:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80030f:	00 00 00 
	vprintfmt((void*)putch, &b, fmt, ap);
  800312:	8b 45 0c             	mov    0xc(%ebp),%eax
  800315:	89 44 24 0c          	mov    %eax,0xc(%esp)
  800319:	8b 45 08             	mov    0x8(%ebp),%eax
  80031c:	89 44 24 08          	mov    %eax,0x8(%esp)
  800320:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800326:	89 44 24 04          	mov    %eax,0x4(%esp)
  80032a:	c7 04 24 b3 02 80 00 	movl   $0x8002b3,(%esp)
  800331:	e8 ae 01 00 00       	call   8004e4 <vprintfmt>
	sys_cputs(b.buf, b.idx);
  800336:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  80033c:	89 44 24 04          	mov    %eax,0x4(%esp)
  800340:	8d 85 f8 fe ff ff    	lea    -0x108(%ebp),%eax
  800346:	89 04 24             	mov    %eax,(%esp)
  800349:	e8 3e 0a 00 00       	call   800d8c <sys_cputs>

	return b.cnt;
}
  80034e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  800354:	c9                   	leave  
  800355:	c3                   	ret    

00800356 <cprintf>:

int
cprintf(const char *fmt, ...)
{
  800356:	55                   	push   %ebp
  800357:	89 e5                	mov    %esp,%ebp
  800359:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80035c:	8d 45 0c             	lea    0xc(%ebp),%eax
	cnt = vcprintf(fmt, ap);
  80035f:	89 44 24 04          	mov    %eax,0x4(%esp)
  800363:	8b 45 08             	mov    0x8(%ebp),%eax
  800366:	89 04 24             	mov    %eax,(%esp)
  800369:	e8 87 ff ff ff       	call   8002f5 <vcprintf>
	va_end(ap);

	return cnt;
}
  80036e:	c9                   	leave  
  80036f:	c3                   	ret    

00800370 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800370:	55                   	push   %ebp
  800371:	89 e5                	mov    %esp,%ebp
  800373:	57                   	push   %edi
  800374:	56                   	push   %esi
  800375:	53                   	push   %ebx
  800376:	83 ec 3c             	sub    $0x3c,%esp
  800379:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80037c:	89 d7                	mov    %edx,%edi
  80037e:	8b 45 08             	mov    0x8(%ebp),%eax
  800381:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800384:	8b 75 0c             	mov    0xc(%ebp),%esi
  800387:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  80038a:	8b 45 10             	mov    0x10(%ebp),%eax
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80038d:	b9 00 00 00 00       	mov    $0x0,%ecx
  800392:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800395:	89 4d dc             	mov    %ecx,-0x24(%ebp)
  800398:	39 f1                	cmp    %esi,%ecx
  80039a:	72 14                	jb     8003b0 <printnum+0x40>
  80039c:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80039f:	76 0f                	jbe    8003b0 <printnum+0x40>
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8003a4:	8d 70 ff             	lea    -0x1(%eax),%esi
  8003a7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8003aa:	85 f6                	test   %esi,%esi
  8003ac:	7f 60                	jg     80040e <printnum+0x9e>
  8003ae:	eb 72                	jmp    800422 <printnum+0xb2>
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8003b0:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003b3:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  8003b7:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8003ba:	8d 51 ff             	lea    -0x1(%ecx),%edx
  8003bd:	89 54 24 0c          	mov    %edx,0xc(%esp)
  8003c1:	89 44 24 08          	mov    %eax,0x8(%esp)
  8003c5:	8b 44 24 08          	mov    0x8(%esp),%eax
  8003c9:	8b 54 24 0c          	mov    0xc(%esp),%edx
  8003cd:	89 c3                	mov    %eax,%ebx
  8003cf:	89 d6                	mov    %edx,%esi
  8003d1:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8003d4:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  8003d7:	89 54 24 08          	mov    %edx,0x8(%esp)
  8003db:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8003df:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003e2:	89 04 24             	mov    %eax,(%esp)
  8003e5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003e8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8003ec:	e8 4f 1d 00 00       	call   802140 <__udivdi3>
  8003f1:	89 d9                	mov    %ebx,%ecx
  8003f3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8003f7:	89 74 24 0c          	mov    %esi,0xc(%esp)
  8003fb:	89 04 24             	mov    %eax,(%esp)
  8003fe:	89 54 24 04          	mov    %edx,0x4(%esp)
  800402:	89 fa                	mov    %edi,%edx
  800404:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800407:	e8 64 ff ff ff       	call   800370 <printnum>
  80040c:	eb 14                	jmp    800422 <printnum+0xb2>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80040e:	89 7c 24 04          	mov    %edi,0x4(%esp)
  800412:	8b 45 18             	mov    0x18(%ebp),%eax
  800415:	89 04 24             	mov    %eax,(%esp)
  800418:	ff d3                	call   *%ebx
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80041a:	83 ee 01             	sub    $0x1,%esi
  80041d:	75 ef                	jne    80040e <printnum+0x9e>
  80041f:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800422:	89 7c 24 04          	mov    %edi,0x4(%esp)
  800426:	8b 7c 24 04          	mov    0x4(%esp),%edi
  80042a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80042d:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800430:	89 44 24 08          	mov    %eax,0x8(%esp)
  800434:	89 54 24 0c          	mov    %edx,0xc(%esp)
  800438:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80043b:	89 04 24             	mov    %eax,(%esp)
  80043e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800441:	89 44 24 04          	mov    %eax,0x4(%esp)
  800445:	e8 26 1e 00 00       	call   802270 <__umoddi3>
  80044a:	89 7c 24 04          	mov    %edi,0x4(%esp)
  80044e:	0f be 80 6b 24 80 00 	movsbl 0x80246b(%eax),%eax
  800455:	89 04 24             	mov    %eax,(%esp)
  800458:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80045b:	ff d0                	call   *%eax
}
  80045d:	83 c4 3c             	add    $0x3c,%esp
  800460:	5b                   	pop    %ebx
  800461:	5e                   	pop    %esi
  800462:	5f                   	pop    %edi
  800463:	5d                   	pop    %ebp
  800464:	c3                   	ret    

00800465 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800465:	55                   	push   %ebp
  800466:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800468:	83 fa 01             	cmp    $0x1,%edx
  80046b:	7e 0e                	jle    80047b <getuint+0x16>
		return va_arg(*ap, unsigned long long);
  80046d:	8b 10                	mov    (%eax),%edx
  80046f:	8d 4a 08             	lea    0x8(%edx),%ecx
  800472:	89 08                	mov    %ecx,(%eax)
  800474:	8b 02                	mov    (%edx),%eax
  800476:	8b 52 04             	mov    0x4(%edx),%edx
  800479:	eb 22                	jmp    80049d <getuint+0x38>
	else if (lflag)
  80047b:	85 d2                	test   %edx,%edx
  80047d:	74 10                	je     80048f <getuint+0x2a>
		return va_arg(*ap, unsigned long);
  80047f:	8b 10                	mov    (%eax),%edx
  800481:	8d 4a 04             	lea    0x4(%edx),%ecx
  800484:	89 08                	mov    %ecx,(%eax)
  800486:	8b 02                	mov    (%edx),%eax
  800488:	ba 00 00 00 00       	mov    $0x0,%edx
  80048d:	eb 0e                	jmp    80049d <getuint+0x38>
	else
		return va_arg(*ap, unsigned int);
  80048f:	8b 10                	mov    (%eax),%edx
  800491:	8d 4a 04             	lea    0x4(%edx),%ecx
  800494:	89 08                	mov    %ecx,(%eax)
  800496:	8b 02                	mov    (%edx),%eax
  800498:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80049d:	5d                   	pop    %ebp
  80049e:	c3                   	ret    

0080049f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80049f:	55                   	push   %ebp
  8004a0:	89 e5                	mov    %esp,%ebp
  8004a2:	8b 45 0c             	mov    0xc(%ebp),%eax
	b->cnt++;
  8004a5:	83 40 08 01          	addl   $0x1,0x8(%eax)
	if (b->buf < b->ebuf)
  8004a9:	8b 10                	mov    (%eax),%edx
  8004ab:	3b 50 04             	cmp    0x4(%eax),%edx
  8004ae:	73 0a                	jae    8004ba <sprintputch+0x1b>
		*b->buf++ = ch;
  8004b0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8004b3:	89 08                	mov    %ecx,(%eax)
  8004b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b8:	88 02                	mov    %al,(%edx)
}
  8004ba:	5d                   	pop    %ebp
  8004bb:	c3                   	ret    

008004bc <printfmt>:
	}
}

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8004bc:	55                   	push   %ebp
  8004bd:	89 e5                	mov    %esp,%ebp
  8004bf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8004c2:	8d 45 14             	lea    0x14(%ebp),%eax
	vprintfmt(putch, putdat, fmt, ap);
  8004c5:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8004c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8004cc:	89 44 24 08          	mov    %eax,0x8(%esp)
  8004d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004d3:	89 44 24 04          	mov    %eax,0x4(%esp)
  8004d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004da:	89 04 24             	mov    %eax,(%esp)
  8004dd:	e8 02 00 00 00       	call   8004e4 <vprintfmt>
	va_end(ap);
}
  8004e2:	c9                   	leave  
  8004e3:	c3                   	ret    

008004e4 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004e4:	55                   	push   %ebp
  8004e5:	89 e5                	mov    %esp,%ebp
  8004e7:	57                   	push   %edi
  8004e8:	56                   	push   %esi
  8004e9:	53                   	push   %ebx
  8004ea:	83 ec 3c             	sub    $0x3c,%esp
  8004ed:	8b 7d 0c             	mov    0xc(%ebp),%edi
  8004f0:	8b 5d 10             	mov    0x10(%ebp),%ebx
  8004f3:	eb 18                	jmp    80050d <vprintfmt+0x29>
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
  8004f5:	85 c0                	test   %eax,%eax
  8004f7:	0f 84 c3 03 00 00    	je     8008c0 <vprintfmt+0x3dc>
				return;
			putch(ch, putdat);
  8004fd:	89 7c 24 04          	mov    %edi,0x4(%esp)
  800501:	89 04 24             	mov    %eax,(%esp)
  800504:	ff 55 08             	call   *0x8(%ebp)
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800507:	89 f3                	mov    %esi,%ebx
  800509:	eb 02                	jmp    80050d <vprintfmt+0x29>
			break;

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
			for (fmt--; fmt[-1] != '%'; fmt--)
  80050b:	89 f3                	mov    %esi,%ebx
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80050d:	8d 73 01             	lea    0x1(%ebx),%esi
  800510:	0f b6 03             	movzbl (%ebx),%eax
  800513:	83 f8 25             	cmp    $0x25,%eax
  800516:	75 dd                	jne    8004f5 <vprintfmt+0x11>
  800518:	c6 45 e3 20          	movb   $0x20,-0x1d(%ebp)
  80051c:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  800523:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%ebp)
  80052a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  800531:	ba 00 00 00 00       	mov    $0x0,%edx
  800536:	eb 1d                	jmp    800555 <vprintfmt+0x71>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800538:	89 de                	mov    %ebx,%esi

		// flag to pad on the right
		case '-':
			padc = '-';
  80053a:	c6 45 e3 2d          	movb   $0x2d,-0x1d(%ebp)
  80053e:	eb 15                	jmp    800555 <vprintfmt+0x71>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800540:	89 de                	mov    %ebx,%esi
			padc = '-';
			goto reswitch;

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800542:	c6 45 e3 30          	movb   $0x30,-0x1d(%ebp)
  800546:	eb 0d                	jmp    800555 <vprintfmt+0x71>
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
				width = precision, precision = -1;
  800548:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80054b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80054e:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%ebp)
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800555:	8d 5e 01             	lea    0x1(%esi),%ebx
  800558:	0f b6 06             	movzbl (%esi),%eax
  80055b:	0f b6 c8             	movzbl %al,%ecx
  80055e:	83 e8 23             	sub    $0x23,%eax
  800561:	3c 55                	cmp    $0x55,%al
  800563:	0f 87 2f 03 00 00    	ja     800898 <vprintfmt+0x3b4>
  800569:	0f b6 c0             	movzbl %al,%eax
  80056c:	ff 24 85 a0 25 80 00 	jmp    *0x8025a0(,%eax,4)
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
				precision = precision * 10 + ch - '0';
  800573:	8d 41 d0             	lea    -0x30(%ecx),%eax
  800576:	89 45 d4             	mov    %eax,-0x2c(%ebp)
				ch = *fmt;
  800579:	0f be 46 01          	movsbl 0x1(%esi),%eax
				if (ch < '0' || ch > '9')
  80057d:	8d 48 d0             	lea    -0x30(%eax),%ecx
  800580:	83 f9 09             	cmp    $0x9,%ecx
  800583:	77 50                	ja     8005d5 <vprintfmt+0xf1>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800585:	89 de                	mov    %ebx,%esi
  800587:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80058a:	83 c6 01             	add    $0x1,%esi
				precision = precision * 10 + ch - '0';
  80058d:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  800590:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
				ch = *fmt;
  800594:	0f be 06             	movsbl (%esi),%eax
				if (ch < '0' || ch > '9')
  800597:	8d 58 d0             	lea    -0x30(%eax),%ebx
  80059a:	83 fb 09             	cmp    $0x9,%ebx
  80059d:	76 eb                	jbe    80058a <vprintfmt+0xa6>
  80059f:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  8005a2:	eb 33                	jmp    8005d7 <vprintfmt+0xf3>
					break;
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8005a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a7:	8d 48 04             	lea    0x4(%eax),%ecx
  8005aa:	89 4d 14             	mov    %ecx,0x14(%ebp)
  8005ad:	8b 00                	mov    (%eax),%eax
  8005af:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8005b2:	89 de                	mov    %ebx,%esi
			}
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
			goto process_precision;
  8005b4:	eb 21                	jmp    8005d7 <vprintfmt+0xf3>
  8005b6:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  8005b9:	85 c9                	test   %ecx,%ecx
  8005bb:	b8 00 00 00 00       	mov    $0x0,%eax
  8005c0:	0f 49 c1             	cmovns %ecx,%eax
  8005c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8005c6:	89 de                	mov    %ebx,%esi
  8005c8:	eb 8b                	jmp    800555 <vprintfmt+0x71>
  8005ca:	89 de                	mov    %ebx,%esi
			if (width < 0)
				width = 0;
			goto reswitch;

		case '#':
			altflag = 1;
  8005cc:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
			goto reswitch;
  8005d3:	eb 80                	jmp    800555 <vprintfmt+0x71>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8005d5:	89 de                	mov    %ebx,%esi
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005d7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005db:	0f 89 74 ff ff ff    	jns    800555 <vprintfmt+0x71>
  8005e1:	e9 62 ff ff ff       	jmp    800548 <vprintfmt+0x64>
				width = precision, precision = -1;
			goto reswitch;

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005e6:	83 c2 01             	add    $0x1,%edx
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8005e9:	89 de                	mov    %ebx,%esi
			goto reswitch;

		// long flag (doubled for long long)
		case 'l':
			lflag++;
			goto reswitch;
  8005eb:	e9 65 ff ff ff       	jmp    800555 <vprintfmt+0x71>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f3:	8d 50 04             	lea    0x4(%eax),%edx
  8005f6:	89 55 14             	mov    %edx,0x14(%ebp)
  8005f9:	89 7c 24 04          	mov    %edi,0x4(%esp)
  8005fd:	8b 00                	mov    (%eax),%eax
  8005ff:	89 04 24             	mov    %eax,(%esp)
  800602:	ff 55 08             	call   *0x8(%ebp)
			break;
  800605:	e9 03 ff ff ff       	jmp    80050d <vprintfmt+0x29>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80060a:	8b 45 14             	mov    0x14(%ebp),%eax
  80060d:	8d 50 04             	lea    0x4(%eax),%edx
  800610:	89 55 14             	mov    %edx,0x14(%ebp)
  800613:	8b 00                	mov    (%eax),%eax
  800615:	99                   	cltd   
  800616:	31 d0                	xor    %edx,%eax
  800618:	29 d0                	sub    %edx,%eax
			if (err < 0)
				err = -err;
			if (err >= MAXERROR || (p = error_string[err]) == NULL)
  80061a:	83 f8 0f             	cmp    $0xf,%eax
  80061d:	7f 0b                	jg     80062a <vprintfmt+0x146>
  80061f:	8b 14 85 00 27 80 00 	mov    0x802700(,%eax,4),%edx
  800626:	85 d2                	test   %edx,%edx
  800628:	75 20                	jne    80064a <vprintfmt+0x166>
				printfmt(putch, putdat, "error %d", err);
  80062a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80062e:	c7 44 24 08 83 24 80 	movl   $0x802483,0x8(%esp)
  800635:	00 
  800636:	89 7c 24 04          	mov    %edi,0x4(%esp)
  80063a:	8b 45 08             	mov    0x8(%ebp),%eax
  80063d:	89 04 24             	mov    %eax,(%esp)
  800640:	e8 77 fe ff ff       	call   8004bc <printfmt>
  800645:	e9 c3 fe ff ff       	jmp    80050d <vprintfmt+0x29>
			else
				printfmt(putch, putdat, "%s", p);
  80064a:	89 54 24 0c          	mov    %edx,0xc(%esp)
  80064e:	c7 44 24 08 42 28 80 	movl   $0x802842,0x8(%esp)
  800655:	00 
  800656:	89 7c 24 04          	mov    %edi,0x4(%esp)
  80065a:	8b 45 08             	mov    0x8(%ebp),%eax
  80065d:	89 04 24             	mov    %eax,(%esp)
  800660:	e8 57 fe ff ff       	call   8004bc <printfmt>
  800665:	e9 a3 fe ff ff       	jmp    80050d <vprintfmt+0x29>
		width = -1;
		precision = -1;
		lflag = 0;
		altflag = 0;
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80066a:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  80066d:	8b 75 e4             	mov    -0x1c(%ebp),%esi
				printfmt(putch, putdat, "%s", p);
			break;

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800670:	8b 45 14             	mov    0x14(%ebp),%eax
  800673:	8d 50 04             	lea    0x4(%eax),%edx
  800676:	89 55 14             	mov    %edx,0x14(%ebp)
  800679:	8b 00                	mov    (%eax),%eax
				p = "(null)";
  80067b:	85 c0                	test   %eax,%eax
  80067d:	ba 7c 24 80 00       	mov    $0x80247c,%edx
  800682:	0f 45 d0             	cmovne %eax,%edx
  800685:	89 55 d0             	mov    %edx,-0x30(%ebp)
			if (width > 0 && padc != '-')
  800688:	80 7d e3 2d          	cmpb   $0x2d,-0x1d(%ebp)
  80068c:	74 04                	je     800692 <vprintfmt+0x1ae>
  80068e:	85 f6                	test   %esi,%esi
  800690:	7f 19                	jg     8006ab <vprintfmt+0x1c7>
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800692:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800695:	8d 70 01             	lea    0x1(%eax),%esi
  800698:	0f b6 10             	movzbl (%eax),%edx
  80069b:	0f be c2             	movsbl %dl,%eax
  80069e:	85 c0                	test   %eax,%eax
  8006a0:	0f 85 95 00 00 00    	jne    80073b <vprintfmt+0x257>
  8006a6:	e9 85 00 00 00       	jmp    800730 <vprintfmt+0x24c>
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006ab:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8006af:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8006b2:	89 04 24             	mov    %eax,(%esp)
  8006b5:	e8 b8 02 00 00       	call   800972 <strnlen>
  8006ba:	29 c6                	sub    %eax,%esi
  8006bc:	89 f0                	mov    %esi,%eax
  8006be:	89 75 e4             	mov    %esi,-0x1c(%ebp)
  8006c1:	85 f6                	test   %esi,%esi
  8006c3:	7e cd                	jle    800692 <vprintfmt+0x1ae>
					putch(padc, putdat);
  8006c5:	0f be 75 e3          	movsbl -0x1d(%ebp),%esi
  8006c9:	89 5d 10             	mov    %ebx,0x10(%ebp)
  8006cc:	89 c3                	mov    %eax,%ebx
  8006ce:	89 7c 24 04          	mov    %edi,0x4(%esp)
  8006d2:	89 34 24             	mov    %esi,(%esp)
  8006d5:	ff 55 08             	call   *0x8(%ebp)
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006d8:	83 eb 01             	sub    $0x1,%ebx
  8006db:	75 f1                	jne    8006ce <vprintfmt+0x1ea>
  8006dd:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  8006e0:	8b 5d 10             	mov    0x10(%ebp),%ebx
  8006e3:	eb ad                	jmp    800692 <vprintfmt+0x1ae>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
  8006e5:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  8006e9:	74 1e                	je     800709 <vprintfmt+0x225>
  8006eb:	0f be d2             	movsbl %dl,%edx
  8006ee:	83 ea 20             	sub    $0x20,%edx
  8006f1:	83 fa 5e             	cmp    $0x5e,%edx
  8006f4:	76 13                	jbe    800709 <vprintfmt+0x225>
					putch('?', putdat);
  8006f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006f9:	89 44 24 04          	mov    %eax,0x4(%esp)
  8006fd:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  800704:	ff 55 08             	call   *0x8(%ebp)
  800707:	eb 0d                	jmp    800716 <vprintfmt+0x232>
				else
					putch(ch, putdat);
  800709:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80070c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  800710:	89 04 24             	mov    %eax,(%esp)
  800713:	ff 55 08             	call   *0x8(%ebp)
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800716:	83 ef 01             	sub    $0x1,%edi
  800719:	83 c6 01             	add    $0x1,%esi
  80071c:	0f b6 56 ff          	movzbl -0x1(%esi),%edx
  800720:	0f be c2             	movsbl %dl,%eax
  800723:	85 c0                	test   %eax,%eax
  800725:	75 20                	jne    800747 <vprintfmt+0x263>
  800727:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  80072a:	8b 7d 0c             	mov    0xc(%ebp),%edi
  80072d:	8b 5d 10             	mov    0x10(%ebp),%ebx
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800730:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800734:	7f 25                	jg     80075b <vprintfmt+0x277>
  800736:	e9 d2 fd ff ff       	jmp    80050d <vprintfmt+0x29>
  80073b:	89 7d 0c             	mov    %edi,0xc(%ebp)
  80073e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  800741:	89 5d 10             	mov    %ebx,0x10(%ebp)
  800744:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800747:	85 db                	test   %ebx,%ebx
  800749:	78 9a                	js     8006e5 <vprintfmt+0x201>
  80074b:	83 eb 01             	sub    $0x1,%ebx
  80074e:	79 95                	jns    8006e5 <vprintfmt+0x201>
  800750:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  800753:	8b 7d 0c             	mov    0xc(%ebp),%edi
  800756:	8b 5d 10             	mov    0x10(%ebp),%ebx
  800759:	eb d5                	jmp    800730 <vprintfmt+0x24c>
  80075b:	8b 75 08             	mov    0x8(%ebp),%esi
  80075e:	89 5d 10             	mov    %ebx,0x10(%ebp)
  800761:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
				putch(' ', putdat);
  800764:	89 7c 24 04          	mov    %edi,0x4(%esp)
  800768:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  80076f:	ff d6                	call   *%esi
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800771:	83 eb 01             	sub    $0x1,%ebx
  800774:	75 ee                	jne    800764 <vprintfmt+0x280>
  800776:	8b 5d 10             	mov    0x10(%ebp),%ebx
  800779:	e9 8f fd ff ff       	jmp    80050d <vprintfmt+0x29>
// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
	if (lflag >= 2)
  80077e:	83 fa 01             	cmp    $0x1,%edx
  800781:	7e 16                	jle    800799 <vprintfmt+0x2b5>
		return va_arg(*ap, long long);
  800783:	8b 45 14             	mov    0x14(%ebp),%eax
  800786:	8d 50 08             	lea    0x8(%eax),%edx
  800789:	89 55 14             	mov    %edx,0x14(%ebp)
  80078c:	8b 50 04             	mov    0x4(%eax),%edx
  80078f:	8b 00                	mov    (%eax),%eax
  800791:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800794:	89 55 dc             	mov    %edx,-0x24(%ebp)
  800797:	eb 32                	jmp    8007cb <vprintfmt+0x2e7>
	else if (lflag)
  800799:	85 d2                	test   %edx,%edx
  80079b:	74 18                	je     8007b5 <vprintfmt+0x2d1>
		return va_arg(*ap, long);
  80079d:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a0:	8d 50 04             	lea    0x4(%eax),%edx
  8007a3:	89 55 14             	mov    %edx,0x14(%ebp)
  8007a6:	8b 30                	mov    (%eax),%esi
  8007a8:	89 75 d8             	mov    %esi,-0x28(%ebp)
  8007ab:	89 f0                	mov    %esi,%eax
  8007ad:	c1 f8 1f             	sar    $0x1f,%eax
  8007b0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007b3:	eb 16                	jmp    8007cb <vprintfmt+0x2e7>
	else
		return va_arg(*ap, int);
  8007b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b8:	8d 50 04             	lea    0x4(%eax),%edx
  8007bb:	89 55 14             	mov    %edx,0x14(%ebp)
  8007be:	8b 30                	mov    (%eax),%esi
  8007c0:	89 75 d8             	mov    %esi,-0x28(%ebp)
  8007c3:	89 f0                	mov    %esi,%eax
  8007c5:	c1 f8 1f             	sar    $0x1f,%eax
  8007c8:	89 45 dc             	mov    %eax,-0x24(%ebp)
				putch(' ', putdat);
			break;

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8007cb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8007ce:	8b 55 dc             	mov    -0x24(%ebp),%edx
			if ((long long) num < 0) {
				putch('-', putdat);
				num = -(long long) num;
			}
			base = 10;
  8007d1:	b9 0a 00 00 00       	mov    $0xa,%ecx
			break;

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
			if ((long long) num < 0) {
  8007d6:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8007da:	0f 89 80 00 00 00    	jns    800860 <vprintfmt+0x37c>
				putch('-', putdat);
  8007e0:	89 7c 24 04          	mov    %edi,0x4(%esp)
  8007e4:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  8007eb:	ff 55 08             	call   *0x8(%ebp)
				num = -(long long) num;
  8007ee:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8007f1:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8007f4:	f7 d8                	neg    %eax
  8007f6:	83 d2 00             	adc    $0x0,%edx
  8007f9:	f7 da                	neg    %edx
			}
			base = 10;
  8007fb:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800800:	eb 5e                	jmp    800860 <vprintfmt+0x37c>
			goto number;

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800802:	8d 45 14             	lea    0x14(%ebp),%eax
  800805:	e8 5b fc ff ff       	call   800465 <getuint>
			base = 10;
  80080a:	b9 0a 00 00 00       	mov    $0xa,%ecx
			goto number;
  80080f:	eb 4f                	jmp    800860 <vprintfmt+0x37c>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			num = getuint(&ap, lflag);
  800811:	8d 45 14             	lea    0x14(%ebp),%eax
  800814:	e8 4c fc ff ff       	call   800465 <getuint>
			base = 8;
  800819:	b9 08 00 00 00       	mov    $0x8,%ecx
			goto number;
  80081e:	eb 40                	jmp    800860 <vprintfmt+0x37c>

		// pointer
		case 'p':
			putch('0', putdat);
  800820:	89 7c 24 04          	mov    %edi,0x4(%esp)
  800824:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  80082b:	ff 55 08             	call   *0x8(%ebp)
			putch('x', putdat);
  80082e:	89 7c 24 04          	mov    %edi,0x4(%esp)
  800832:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  800839:	ff 55 08             	call   *0x8(%ebp)
			num = (unsigned long long)
				(uintptr_t) va_arg(ap, void *);
  80083c:	8b 45 14             	mov    0x14(%ebp),%eax
  80083f:	8d 50 04             	lea    0x4(%eax),%edx
  800842:	89 55 14             	mov    %edx,0x14(%ebp)

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800845:	8b 00                	mov    (%eax),%eax
  800847:	ba 00 00 00 00       	mov    $0x0,%edx
				(uintptr_t) va_arg(ap, void *);
			base = 16;
  80084c:	b9 10 00 00 00       	mov    $0x10,%ecx
			goto number;
  800851:	eb 0d                	jmp    800860 <vprintfmt+0x37c>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800853:	8d 45 14             	lea    0x14(%ebp),%eax
  800856:	e8 0a fc ff ff       	call   800465 <getuint>
			base = 16;
  80085b:	b9 10 00 00 00       	mov    $0x10,%ecx
		number:
			printnum(putch, putdat, num, base, width, padc);
  800860:	0f be 75 e3          	movsbl -0x1d(%ebp),%esi
  800864:	89 74 24 10          	mov    %esi,0x10(%esp)
  800868:	8b 75 e4             	mov    -0x1c(%ebp),%esi
  80086b:	89 74 24 0c          	mov    %esi,0xc(%esp)
  80086f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  800873:	89 04 24             	mov    %eax,(%esp)
  800876:	89 54 24 04          	mov    %edx,0x4(%esp)
  80087a:	89 fa                	mov    %edi,%edx
  80087c:	8b 45 08             	mov    0x8(%ebp),%eax
  80087f:	e8 ec fa ff ff       	call   800370 <printnum>
			break;
  800884:	e9 84 fc ff ff       	jmp    80050d <vprintfmt+0x29>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800889:	89 7c 24 04          	mov    %edi,0x4(%esp)
  80088d:	89 0c 24             	mov    %ecx,(%esp)
  800890:	ff 55 08             	call   *0x8(%ebp)
			break;
  800893:	e9 75 fc ff ff       	jmp    80050d <vprintfmt+0x29>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800898:	89 7c 24 04          	mov    %edi,0x4(%esp)
  80089c:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  8008a3:	ff 55 08             	call   *0x8(%ebp)
			for (fmt--; fmt[-1] != '%'; fmt--)
  8008a6:	80 7e ff 25          	cmpb   $0x25,-0x1(%esi)
  8008aa:	0f 84 5b fc ff ff    	je     80050b <vprintfmt+0x27>
  8008b0:	89 f3                	mov    %esi,%ebx
  8008b2:	83 eb 01             	sub    $0x1,%ebx
  8008b5:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
  8008b9:	75 f7                	jne    8008b2 <vprintfmt+0x3ce>
  8008bb:	e9 4d fc ff ff       	jmp    80050d <vprintfmt+0x29>
				/* do nothing */;
			break;
		}
	}
}
  8008c0:	83 c4 3c             	add    $0x3c,%esp
  8008c3:	5b                   	pop    %ebx
  8008c4:	5e                   	pop    %esi
  8008c5:	5f                   	pop    %edi
  8008c6:	5d                   	pop    %ebp
  8008c7:	c3                   	ret    

008008c8 <vsnprintf>:
		*b->buf++ = ch;
}

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008c8:	55                   	push   %ebp
  8008c9:	89 e5                	mov    %esp,%ebp
  8008cb:	83 ec 28             	sub    $0x28,%esp
  8008ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d1:	8b 55 0c             	mov    0xc(%ebp),%edx
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008d7:	8d 4c 10 ff          	lea    -0x1(%eax,%edx,1),%ecx
  8008db:	89 4d f0             	mov    %ecx,-0x10(%ebp)
  8008de:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008e5:	85 c0                	test   %eax,%eax
  8008e7:	74 30                	je     800919 <vsnprintf+0x51>
  8008e9:	85 d2                	test   %edx,%edx
  8008eb:	7e 2c                	jle    800919 <vsnprintf+0x51>
		return -E_INVAL;

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8008f0:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8008f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8008f7:	89 44 24 08          	mov    %eax,0x8(%esp)
  8008fb:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008fe:	89 44 24 04          	mov    %eax,0x4(%esp)
  800902:	c7 04 24 9f 04 80 00 	movl   $0x80049f,(%esp)
  800909:	e8 d6 fb ff ff       	call   8004e4 <vprintfmt>

	// null terminate the buffer
	*b.buf = '\0';
  80090e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800911:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800914:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800917:	eb 05                	jmp    80091e <vsnprintf+0x56>
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
	struct sprintbuf b = {buf, buf+n-1, 0};

	if (buf == NULL || n < 1)
		return -E_INVAL;
  800919:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax

	// null terminate the buffer
	*b.buf = '\0';

	return b.cnt;
}
  80091e:	c9                   	leave  
  80091f:	c3                   	ret    

00800920 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800920:	55                   	push   %ebp
  800921:	89 e5                	mov    %esp,%ebp
  800923:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800926:	8d 45 14             	lea    0x14(%ebp),%eax
	rc = vsnprintf(buf, n, fmt, ap);
  800929:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80092d:	8b 45 10             	mov    0x10(%ebp),%eax
  800930:	89 44 24 08          	mov    %eax,0x8(%esp)
  800934:	8b 45 0c             	mov    0xc(%ebp),%eax
  800937:	89 44 24 04          	mov    %eax,0x4(%esp)
  80093b:	8b 45 08             	mov    0x8(%ebp),%eax
  80093e:	89 04 24             	mov    %eax,(%esp)
  800941:	e8 82 ff ff ff       	call   8008c8 <vsnprintf>
	va_end(ap);

	return rc;
}
  800946:	c9                   	leave  
  800947:	c3                   	ret    
  800948:	66 90                	xchg   %ax,%ax
  80094a:	66 90                	xchg   %ax,%ax
  80094c:	66 90                	xchg   %ax,%ax
  80094e:	66 90                	xchg   %ax,%ax

00800950 <strlen>:
// Primespipe runs 3x faster this way.
#define ASM 1

int
strlen(const char *s)
{
  800950:	55                   	push   %ebp
  800951:	89 e5                	mov    %esp,%ebp
  800953:	8b 55 08             	mov    0x8(%ebp),%edx
	int n;

	for (n = 0; *s != '\0'; s++)
  800956:	80 3a 00             	cmpb   $0x0,(%edx)
  800959:	74 10                	je     80096b <strlen+0x1b>
  80095b:	b8 00 00 00 00       	mov    $0x0,%eax
		n++;
  800960:	83 c0 01             	add    $0x1,%eax
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800963:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  800967:	75 f7                	jne    800960 <strlen+0x10>
  800969:	eb 05                	jmp    800970 <strlen+0x20>
  80096b:	b8 00 00 00 00       	mov    $0x0,%eax
		n++;
	return n;
}
  800970:	5d                   	pop    %ebp
  800971:	c3                   	ret    

00800972 <strnlen>:

int
strnlen(const char *s, size_t size)
{
  800972:	55                   	push   %ebp
  800973:	89 e5                	mov    %esp,%ebp
  800975:	53                   	push   %ebx
  800976:	8b 5d 08             	mov    0x8(%ebp),%ebx
  800979:	8b 4d 0c             	mov    0xc(%ebp),%ecx
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80097c:	85 c9                	test   %ecx,%ecx
  80097e:	74 1c                	je     80099c <strnlen+0x2a>
  800980:	80 3b 00             	cmpb   $0x0,(%ebx)
  800983:	74 1e                	je     8009a3 <strnlen+0x31>
  800985:	ba 01 00 00 00       	mov    $0x1,%edx
		n++;
  80098a:	89 d0                	mov    %edx,%eax
int
strnlen(const char *s, size_t size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80098c:	39 ca                	cmp    %ecx,%edx
  80098e:	74 18                	je     8009a8 <strnlen+0x36>
  800990:	83 c2 01             	add    $0x1,%edx
  800993:	80 7c 13 ff 00       	cmpb   $0x0,-0x1(%ebx,%edx,1)
  800998:	75 f0                	jne    80098a <strnlen+0x18>
  80099a:	eb 0c                	jmp    8009a8 <strnlen+0x36>
  80099c:	b8 00 00 00 00       	mov    $0x0,%eax
  8009a1:	eb 05                	jmp    8009a8 <strnlen+0x36>
  8009a3:	b8 00 00 00 00       	mov    $0x0,%eax
		n++;
	return n;
}
  8009a8:	5b                   	pop    %ebx
  8009a9:	5d                   	pop    %ebp
  8009aa:	c3                   	ret    

008009ab <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8009ab:	55                   	push   %ebp
  8009ac:	89 e5                	mov    %esp,%ebp
  8009ae:	53                   	push   %ebx
  8009af:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
	char *ret;

	ret = dst;
	while ((*dst++ = *src++) != '\0')
  8009b5:	89 c2                	mov    %eax,%edx
  8009b7:	83 c2 01             	add    $0x1,%edx
  8009ba:	83 c1 01             	add    $0x1,%ecx
  8009bd:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  8009c1:	88 5a ff             	mov    %bl,-0x1(%edx)
  8009c4:	84 db                	test   %bl,%bl
  8009c6:	75 ef                	jne    8009b7 <strcpy+0xc>
		/* do nothing */;
	return ret;
}
  8009c8:	5b                   	pop    %ebx
  8009c9:	5d                   	pop    %ebp
  8009ca:	c3                   	ret    

008009cb <strcat>:

char *
strcat(char *dst, const char *src)
{
  8009cb:	55                   	push   %ebp
  8009cc:	89 e5                	mov    %esp,%ebp
  8009ce:	53                   	push   %ebx
  8009cf:	83 ec 08             	sub    $0x8,%esp
  8009d2:	8b 5d 08             	mov    0x8(%ebp),%ebx
	int len = strlen(dst);
  8009d5:	89 1c 24             	mov    %ebx,(%esp)
  8009d8:	e8 73 ff ff ff       	call   800950 <strlen>
	strcpy(dst + len, src);
  8009dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009e0:	89 54 24 04          	mov    %edx,0x4(%esp)
  8009e4:	01 d8                	add    %ebx,%eax
  8009e6:	89 04 24             	mov    %eax,(%esp)
  8009e9:	e8 bd ff ff ff       	call   8009ab <strcpy>
	return dst;
}
  8009ee:	89 d8                	mov    %ebx,%eax
  8009f0:	83 c4 08             	add    $0x8,%esp
  8009f3:	5b                   	pop    %ebx
  8009f4:	5d                   	pop    %ebp
  8009f5:	c3                   	ret    

008009f6 <strncpy>:

char *
strncpy(char *dst, const char *src, size_t size) {
  8009f6:	55                   	push   %ebp
  8009f7:	89 e5                	mov    %esp,%ebp
  8009f9:	56                   	push   %esi
  8009fa:	53                   	push   %ebx
  8009fb:	8b 75 08             	mov    0x8(%ebp),%esi
  8009fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a01:	8b 5d 10             	mov    0x10(%ebp),%ebx
	size_t i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a04:	85 db                	test   %ebx,%ebx
  800a06:	74 17                	je     800a1f <strncpy+0x29>
  800a08:	01 f3                	add    %esi,%ebx
  800a0a:	89 f1                	mov    %esi,%ecx
		*dst++ = *src;
  800a0c:	83 c1 01             	add    $0x1,%ecx
  800a0f:	0f b6 02             	movzbl (%edx),%eax
  800a12:	88 41 ff             	mov    %al,-0x1(%ecx)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
  800a15:	80 3a 01             	cmpb   $0x1,(%edx)
  800a18:	83 da ff             	sbb    $0xffffffff,%edx
strncpy(char *dst, const char *src, size_t size) {
	size_t i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a1b:	39 d9                	cmp    %ebx,%ecx
  800a1d:	75 ed                	jne    800a0c <strncpy+0x16>
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
}
  800a1f:	89 f0                	mov    %esi,%eax
  800a21:	5b                   	pop    %ebx
  800a22:	5e                   	pop    %esi
  800a23:	5d                   	pop    %ebp
  800a24:	c3                   	ret    

00800a25 <strlcpy>:

size_t
strlcpy(char *dst, const char *src, size_t size)
{
  800a25:	55                   	push   %ebp
  800a26:	89 e5                	mov    %esp,%ebp
  800a28:	57                   	push   %edi
  800a29:	56                   	push   %esi
  800a2a:	53                   	push   %ebx
  800a2b:	8b 7d 08             	mov    0x8(%ebp),%edi
  800a2e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  800a31:	8b 75 10             	mov    0x10(%ebp),%esi
  800a34:	89 f8                	mov    %edi,%eax
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
  800a36:	85 f6                	test   %esi,%esi
  800a38:	74 34                	je     800a6e <strlcpy+0x49>
		while (--size > 0 && *src != '\0')
  800a3a:	83 fe 01             	cmp    $0x1,%esi
  800a3d:	74 26                	je     800a65 <strlcpy+0x40>
  800a3f:	0f b6 0b             	movzbl (%ebx),%ecx
  800a42:	84 c9                	test   %cl,%cl
  800a44:	74 23                	je     800a69 <strlcpy+0x44>
  800a46:	83 ee 02             	sub    $0x2,%esi
  800a49:	ba 00 00 00 00       	mov    $0x0,%edx
			*dst++ = *src++;
  800a4e:	83 c0 01             	add    $0x1,%eax
  800a51:	88 48 ff             	mov    %cl,-0x1(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a54:	39 f2                	cmp    %esi,%edx
  800a56:	74 13                	je     800a6b <strlcpy+0x46>
  800a58:	83 c2 01             	add    $0x1,%edx
  800a5b:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  800a5f:	84 c9                	test   %cl,%cl
  800a61:	75 eb                	jne    800a4e <strlcpy+0x29>
  800a63:	eb 06                	jmp    800a6b <strlcpy+0x46>
  800a65:	89 f8                	mov    %edi,%eax
  800a67:	eb 02                	jmp    800a6b <strlcpy+0x46>
  800a69:	89 f8                	mov    %edi,%eax
			*dst++ = *src++;
		*dst = '\0';
  800a6b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a6e:	29 f8                	sub    %edi,%eax
}
  800a70:	5b                   	pop    %ebx
  800a71:	5e                   	pop    %esi
  800a72:	5f                   	pop    %edi
  800a73:	5d                   	pop    %ebp
  800a74:	c3                   	ret    

00800a75 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a75:	55                   	push   %ebp
  800a76:	89 e5                	mov    %esp,%ebp
  800a78:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800a7b:	8b 55 0c             	mov    0xc(%ebp),%edx
	while (*p && *p == *q)
  800a7e:	0f b6 01             	movzbl (%ecx),%eax
  800a81:	84 c0                	test   %al,%al
  800a83:	74 15                	je     800a9a <strcmp+0x25>
  800a85:	3a 02                	cmp    (%edx),%al
  800a87:	75 11                	jne    800a9a <strcmp+0x25>
		p++, q++;
  800a89:	83 c1 01             	add    $0x1,%ecx
  800a8c:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a8f:	0f b6 01             	movzbl (%ecx),%eax
  800a92:	84 c0                	test   %al,%al
  800a94:	74 04                	je     800a9a <strcmp+0x25>
  800a96:	3a 02                	cmp    (%edx),%al
  800a98:	74 ef                	je     800a89 <strcmp+0x14>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a9a:	0f b6 c0             	movzbl %al,%eax
  800a9d:	0f b6 12             	movzbl (%edx),%edx
  800aa0:	29 d0                	sub    %edx,%eax
}
  800aa2:	5d                   	pop    %ebp
  800aa3:	c3                   	ret    

00800aa4 <strncmp>:

int
strncmp(const char *p, const char *q, size_t n)
{
  800aa4:	55                   	push   %ebp
  800aa5:	89 e5                	mov    %esp,%ebp
  800aa7:	56                   	push   %esi
  800aa8:	53                   	push   %ebx
  800aa9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  800aac:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aaf:	8b 75 10             	mov    0x10(%ebp),%esi
	while (n > 0 && *p && *p == *q)
  800ab2:	85 f6                	test   %esi,%esi
  800ab4:	74 29                	je     800adf <strncmp+0x3b>
  800ab6:	0f b6 03             	movzbl (%ebx),%eax
  800ab9:	84 c0                	test   %al,%al
  800abb:	74 30                	je     800aed <strncmp+0x49>
  800abd:	3a 02                	cmp    (%edx),%al
  800abf:	75 2c                	jne    800aed <strncmp+0x49>
  800ac1:	8d 43 01             	lea    0x1(%ebx),%eax
  800ac4:	01 de                	add    %ebx,%esi
		n--, p++, q++;
  800ac6:	89 c3                	mov    %eax,%ebx
  800ac8:	83 c2 01             	add    $0x1,%edx
}

int
strncmp(const char *p, const char *q, size_t n)
{
	while (n > 0 && *p && *p == *q)
  800acb:	39 f0                	cmp    %esi,%eax
  800acd:	74 17                	je     800ae6 <strncmp+0x42>
  800acf:	0f b6 08             	movzbl (%eax),%ecx
  800ad2:	84 c9                	test   %cl,%cl
  800ad4:	74 17                	je     800aed <strncmp+0x49>
  800ad6:	83 c0 01             	add    $0x1,%eax
  800ad9:	3a 0a                	cmp    (%edx),%cl
  800adb:	74 e9                	je     800ac6 <strncmp+0x22>
  800add:	eb 0e                	jmp    800aed <strncmp+0x49>
		n--, p++, q++;
	if (n == 0)
		return 0;
  800adf:	b8 00 00 00 00       	mov    $0x0,%eax
  800ae4:	eb 0f                	jmp    800af5 <strncmp+0x51>
  800ae6:	b8 00 00 00 00       	mov    $0x0,%eax
  800aeb:	eb 08                	jmp    800af5 <strncmp+0x51>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800aed:	0f b6 03             	movzbl (%ebx),%eax
  800af0:	0f b6 12             	movzbl (%edx),%edx
  800af3:	29 d0                	sub    %edx,%eax
}
  800af5:	5b                   	pop    %ebx
  800af6:	5e                   	pop    %esi
  800af7:	5d                   	pop    %ebp
  800af8:	c3                   	ret    

00800af9 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800af9:	55                   	push   %ebp
  800afa:	89 e5                	mov    %esp,%ebp
  800afc:	53                   	push   %ebx
  800afd:	8b 45 08             	mov    0x8(%ebp),%eax
  800b00:	8b 55 0c             	mov    0xc(%ebp),%edx
	for (; *s; s++)
  800b03:	0f b6 18             	movzbl (%eax),%ebx
  800b06:	84 db                	test   %bl,%bl
  800b08:	74 1d                	je     800b27 <strchr+0x2e>
  800b0a:	89 d1                	mov    %edx,%ecx
		if (*s == c)
  800b0c:	38 d3                	cmp    %dl,%bl
  800b0e:	75 06                	jne    800b16 <strchr+0x1d>
  800b10:	eb 1a                	jmp    800b2c <strchr+0x33>
  800b12:	38 ca                	cmp    %cl,%dl
  800b14:	74 16                	je     800b2c <strchr+0x33>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b16:	83 c0 01             	add    $0x1,%eax
  800b19:	0f b6 10             	movzbl (%eax),%edx
  800b1c:	84 d2                	test   %dl,%dl
  800b1e:	75 f2                	jne    800b12 <strchr+0x19>
		if (*s == c)
			return (char *) s;
	return 0;
  800b20:	b8 00 00 00 00       	mov    $0x0,%eax
  800b25:	eb 05                	jmp    800b2c <strchr+0x33>
  800b27:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b2c:	5b                   	pop    %ebx
  800b2d:	5d                   	pop    %ebp
  800b2e:	c3                   	ret    

00800b2f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b2f:	55                   	push   %ebp
  800b30:	89 e5                	mov    %esp,%ebp
  800b32:	53                   	push   %ebx
  800b33:	8b 45 08             	mov    0x8(%ebp),%eax
  800b36:	8b 55 0c             	mov    0xc(%ebp),%edx
	for (; *s; s++)
  800b39:	0f b6 18             	movzbl (%eax),%ebx
  800b3c:	84 db                	test   %bl,%bl
  800b3e:	74 16                	je     800b56 <strfind+0x27>
  800b40:	89 d1                	mov    %edx,%ecx
		if (*s == c)
  800b42:	38 d3                	cmp    %dl,%bl
  800b44:	75 06                	jne    800b4c <strfind+0x1d>
  800b46:	eb 0e                	jmp    800b56 <strfind+0x27>
  800b48:	38 ca                	cmp    %cl,%dl
  800b4a:	74 0a                	je     800b56 <strfind+0x27>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b4c:	83 c0 01             	add    $0x1,%eax
  800b4f:	0f b6 10             	movzbl (%eax),%edx
  800b52:	84 d2                	test   %dl,%dl
  800b54:	75 f2                	jne    800b48 <strfind+0x19>
		if (*s == c)
			break;
	return (char *) s;
}
  800b56:	5b                   	pop    %ebx
  800b57:	5d                   	pop    %ebp
  800b58:	c3                   	ret    

00800b59 <memset>:

#if ASM
void *
memset(void *v, int c, size_t n)
{
  800b59:	55                   	push   %ebp
  800b5a:	89 e5                	mov    %esp,%ebp
  800b5c:	57                   	push   %edi
  800b5d:	56                   	push   %esi
  800b5e:	53                   	push   %ebx
  800b5f:	8b 7d 08             	mov    0x8(%ebp),%edi
  800b62:	8b 4d 10             	mov    0x10(%ebp),%ecx
	char *p;

	if (n == 0)
  800b65:	85 c9                	test   %ecx,%ecx
  800b67:	74 36                	je     800b9f <memset+0x46>
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
  800b69:	f7 c7 03 00 00 00    	test   $0x3,%edi
  800b6f:	75 28                	jne    800b99 <memset+0x40>
  800b71:	f6 c1 03             	test   $0x3,%cl
  800b74:	75 23                	jne    800b99 <memset+0x40>
		c &= 0xFF;
  800b76:	0f b6 55 0c          	movzbl 0xc(%ebp),%edx
		c = (c<<24)|(c<<16)|(c<<8)|c;
  800b7a:	89 d3                	mov    %edx,%ebx
  800b7c:	c1 e3 08             	shl    $0x8,%ebx
  800b7f:	89 d6                	mov    %edx,%esi
  800b81:	c1 e6 18             	shl    $0x18,%esi
  800b84:	89 d0                	mov    %edx,%eax
  800b86:	c1 e0 10             	shl    $0x10,%eax
  800b89:	09 f0                	or     %esi,%eax
  800b8b:	09 c2                	or     %eax,%edx
  800b8d:	89 d0                	mov    %edx,%eax
  800b8f:	09 d8                	or     %ebx,%eax
		asm volatile("cld; rep stosl\n"
			:: "D" (v), "a" (c), "c" (n/4)
  800b91:	c1 e9 02             	shr    $0x2,%ecx
	if (n == 0)
		return v;
	if ((int)v%4 == 0 && n%4 == 0) {
		c &= 0xFF;
		c = (c<<24)|(c<<16)|(c<<8)|c;
		asm volatile("cld; rep stosl\n"
  800b94:	fc                   	cld    
  800b95:	f3 ab                	rep stos %eax,%es:(%edi)
  800b97:	eb 06                	jmp    800b9f <memset+0x46>
			:: "D" (v), "a" (c), "c" (n/4)
			: "cc", "memory");
	} else
		asm volatile("cld; rep stosb\n"
  800b99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b9c:	fc                   	cld    
  800b9d:	f3 aa                	rep stos %al,%es:(%edi)
			:: "D" (v), "a" (c), "c" (n)
			: "cc", "memory");
	return v;
}
  800b9f:	89 f8                	mov    %edi,%eax
  800ba1:	5b                   	pop    %ebx
  800ba2:	5e                   	pop    %esi
  800ba3:	5f                   	pop    %edi
  800ba4:	5d                   	pop    %ebp
  800ba5:	c3                   	ret    

00800ba6 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  800ba6:	55                   	push   %ebp
  800ba7:	89 e5                	mov    %esp,%ebp
  800ba9:	57                   	push   %edi
  800baa:	56                   	push   %esi
  800bab:	8b 45 08             	mov    0x8(%ebp),%eax
  800bae:	8b 75 0c             	mov    0xc(%ebp),%esi
  800bb1:	8b 4d 10             	mov    0x10(%ebp),%ecx
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bb4:	39 c6                	cmp    %eax,%esi
  800bb6:	73 35                	jae    800bed <memmove+0x47>
  800bb8:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
  800bbb:	39 d0                	cmp    %edx,%eax
  800bbd:	73 2e                	jae    800bed <memmove+0x47>
		s += n;
		d += n;
  800bbf:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
  800bc2:	89 d6                	mov    %edx,%esi
  800bc4:	09 fe                	or     %edi,%esi
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
  800bc6:	f7 c6 03 00 00 00    	test   $0x3,%esi
  800bcc:	75 13                	jne    800be1 <memmove+0x3b>
  800bce:	f6 c1 03             	test   $0x3,%cl
  800bd1:	75 0e                	jne    800be1 <memmove+0x3b>
			asm volatile("std; rep movsl\n"
				:: "D" (d-4), "S" (s-4), "c" (n/4) : "cc", "memory");
  800bd3:	83 ef 04             	sub    $0x4,%edi
  800bd6:	8d 72 fc             	lea    -0x4(%edx),%esi
  800bd9:	c1 e9 02             	shr    $0x2,%ecx
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("std; rep movsl\n"
  800bdc:	fd                   	std    
  800bdd:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  800bdf:	eb 09                	jmp    800bea <memmove+0x44>
				:: "D" (d-4), "S" (s-4), "c" (n/4) : "cc", "memory");
		else
			asm volatile("std; rep movsb\n"
				:: "D" (d-1), "S" (s-1), "c" (n) : "cc", "memory");
  800be1:	83 ef 01             	sub    $0x1,%edi
  800be4:	8d 72 ff             	lea    -0x1(%edx),%esi
		d += n;
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("std; rep movsl\n"
				:: "D" (d-4), "S" (s-4), "c" (n/4) : "cc", "memory");
		else
			asm volatile("std; rep movsb\n"
  800be7:	fd                   	std    
  800be8:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
				:: "D" (d-1), "S" (s-1), "c" (n) : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
  800bea:	fc                   	cld    
  800beb:	eb 1d                	jmp    800c0a <memmove+0x64>
  800bed:	89 f2                	mov    %esi,%edx
  800bef:	09 c2                	or     %eax,%edx
	} else {
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
  800bf1:	f6 c2 03             	test   $0x3,%dl
  800bf4:	75 0f                	jne    800c05 <memmove+0x5f>
  800bf6:	f6 c1 03             	test   $0x3,%cl
  800bf9:	75 0a                	jne    800c05 <memmove+0x5f>
			asm volatile("cld; rep movsl\n"
				:: "D" (d), "S" (s), "c" (n/4) : "cc", "memory");
  800bfb:	c1 e9 02             	shr    $0x2,%ecx
				:: "D" (d-1), "S" (s-1), "c" (n) : "cc", "memory");
		// Some versions of GCC rely on DF being clear
		asm volatile("cld" ::: "cc");
	} else {
		if ((int)s%4 == 0 && (int)d%4 == 0 && n%4 == 0)
			asm volatile("cld; rep movsl\n"
  800bfe:	89 c7                	mov    %eax,%edi
  800c00:	fc                   	cld    
  800c01:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  800c03:	eb 05                	jmp    800c0a <memmove+0x64>
				:: "D" (d), "S" (s), "c" (n/4) : "cc", "memory");
		else
			asm volatile("cld; rep movsb\n"
  800c05:	89 c7                	mov    %eax,%edi
  800c07:	fc                   	cld    
  800c08:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
				:: "D" (d), "S" (s), "c" (n) : "cc", "memory");
	}
	return dst;
}
  800c0a:	5e                   	pop    %esi
  800c0b:	5f                   	pop    %edi
  800c0c:	5d                   	pop    %ebp
  800c0d:	c3                   	ret    

00800c0e <memcpy>:
}
#endif

void *
memcpy(void *dst, const void *src, size_t n)
{
  800c0e:	55                   	push   %ebp
  800c0f:	89 e5                	mov    %esp,%ebp
  800c11:	83 ec 0c             	sub    $0xc,%esp
	return memmove(dst, src, n);
  800c14:	8b 45 10             	mov    0x10(%ebp),%eax
  800c17:	89 44 24 08          	mov    %eax,0x8(%esp)
  800c1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1e:	89 44 24 04          	mov    %eax,0x4(%esp)
  800c22:	8b 45 08             	mov    0x8(%ebp),%eax
  800c25:	89 04 24             	mov    %eax,(%esp)
  800c28:	e8 79 ff ff ff       	call   800ba6 <memmove>
}
  800c2d:	c9                   	leave  
  800c2e:	c3                   	ret    

00800c2f <memcmp>:

int
memcmp(const void *v1, const void *v2, size_t n)
{
  800c2f:	55                   	push   %ebp
  800c30:	89 e5                	mov    %esp,%ebp
  800c32:	57                   	push   %edi
  800c33:	56                   	push   %esi
  800c34:	53                   	push   %ebx
  800c35:	8b 5d 08             	mov    0x8(%ebp),%ebx
  800c38:	8b 75 0c             	mov    0xc(%ebp),%esi
  800c3b:	8b 45 10             	mov    0x10(%ebp),%eax
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
  800c3e:	8d 78 ff             	lea    -0x1(%eax),%edi
  800c41:	85 c0                	test   %eax,%eax
  800c43:	74 36                	je     800c7b <memcmp+0x4c>
		if (*s1 != *s2)
  800c45:	0f b6 03             	movzbl (%ebx),%eax
  800c48:	0f b6 0e             	movzbl (%esi),%ecx
  800c4b:	ba 00 00 00 00       	mov    $0x0,%edx
  800c50:	38 c8                	cmp    %cl,%al
  800c52:	74 1c                	je     800c70 <memcmp+0x41>
  800c54:	eb 10                	jmp    800c66 <memcmp+0x37>
  800c56:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
  800c5b:	83 c2 01             	add    $0x1,%edx
  800c5e:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
  800c62:	38 c8                	cmp    %cl,%al
  800c64:	74 0a                	je     800c70 <memcmp+0x41>
			return (int) *s1 - (int) *s2;
  800c66:	0f b6 c0             	movzbl %al,%eax
  800c69:	0f b6 c9             	movzbl %cl,%ecx
  800c6c:	29 c8                	sub    %ecx,%eax
  800c6e:	eb 10                	jmp    800c80 <memcmp+0x51>
memcmp(const void *v1, const void *v2, size_t n)
{
	const uint8_t *s1 = (const uint8_t *) v1;
	const uint8_t *s2 = (const uint8_t *) v2;

	while (n-- > 0) {
  800c70:	39 fa                	cmp    %edi,%edx
  800c72:	75 e2                	jne    800c56 <memcmp+0x27>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c74:	b8 00 00 00 00       	mov    $0x0,%eax
  800c79:	eb 05                	jmp    800c80 <memcmp+0x51>
  800c7b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c80:	5b                   	pop    %ebx
  800c81:	5e                   	pop    %esi
  800c82:	5f                   	pop    %edi
  800c83:	5d                   	pop    %ebp
  800c84:	c3                   	ret    

00800c85 <memfind>:

void *
memfind(const void *s, int c, size_t n)
{
  800c85:	55                   	push   %ebp
  800c86:	89 e5                	mov    %esp,%ebp
  800c88:	53                   	push   %ebx
  800c89:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	const void *ends = (const char *) s + n;
  800c8f:	89 c2                	mov    %eax,%edx
  800c91:	03 55 10             	add    0x10(%ebp),%edx
	for (; s < ends; s++)
  800c94:	39 d0                	cmp    %edx,%eax
  800c96:	73 13                	jae    800cab <memfind+0x26>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c98:	89 d9                	mov    %ebx,%ecx
  800c9a:	38 18                	cmp    %bl,(%eax)
  800c9c:	75 06                	jne    800ca4 <memfind+0x1f>
  800c9e:	eb 0b                	jmp    800cab <memfind+0x26>
  800ca0:	38 08                	cmp    %cl,(%eax)
  800ca2:	74 07                	je     800cab <memfind+0x26>

void *
memfind(const void *s, int c, size_t n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ca4:	83 c0 01             	add    $0x1,%eax
  800ca7:	39 d0                	cmp    %edx,%eax
  800ca9:	75 f5                	jne    800ca0 <memfind+0x1b>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
	return (void *) s;
}
  800cab:	5b                   	pop    %ebx
  800cac:	5d                   	pop    %ebp
  800cad:	c3                   	ret    

00800cae <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800cae:	55                   	push   %ebp
  800caf:	89 e5                	mov    %esp,%ebp
  800cb1:	57                   	push   %edi
  800cb2:	56                   	push   %esi
  800cb3:	53                   	push   %ebx
  800cb4:	8b 55 08             	mov    0x8(%ebp),%edx
  800cb7:	8b 45 10             	mov    0x10(%ebp),%eax
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cba:	0f b6 0a             	movzbl (%edx),%ecx
  800cbd:	80 f9 09             	cmp    $0x9,%cl
  800cc0:	74 05                	je     800cc7 <strtol+0x19>
  800cc2:	80 f9 20             	cmp    $0x20,%cl
  800cc5:	75 10                	jne    800cd7 <strtol+0x29>
		s++;
  800cc7:	83 c2 01             	add    $0x1,%edx
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cca:	0f b6 0a             	movzbl (%edx),%ecx
  800ccd:	80 f9 09             	cmp    $0x9,%cl
  800cd0:	74 f5                	je     800cc7 <strtol+0x19>
  800cd2:	80 f9 20             	cmp    $0x20,%cl
  800cd5:	74 f0                	je     800cc7 <strtol+0x19>
		s++;

	// plus/minus sign
	if (*s == '+')
  800cd7:	80 f9 2b             	cmp    $0x2b,%cl
  800cda:	75 0a                	jne    800ce6 <strtol+0x38>
		s++;
  800cdc:	83 c2 01             	add    $0x1,%edx
}

long
strtol(const char *s, char **endptr, int base)
{
	int neg = 0;
  800cdf:	bf 00 00 00 00       	mov    $0x0,%edi
  800ce4:	eb 11                	jmp    800cf7 <strtol+0x49>
  800ce6:	bf 00 00 00 00       	mov    $0x0,%edi
		s++;

	// plus/minus sign
	if (*s == '+')
		s++;
	else if (*s == '-')
  800ceb:	80 f9 2d             	cmp    $0x2d,%cl
  800cee:	75 07                	jne    800cf7 <strtol+0x49>
		s++, neg = 1;
  800cf0:	83 c2 01             	add    $0x1,%edx
  800cf3:	66 bf 01 00          	mov    $0x1,%di

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cf7:	a9 ef ff ff ff       	test   $0xffffffef,%eax
  800cfc:	75 15                	jne    800d13 <strtol+0x65>
  800cfe:	80 3a 30             	cmpb   $0x30,(%edx)
  800d01:	75 10                	jne    800d13 <strtol+0x65>
  800d03:	80 7a 01 78          	cmpb   $0x78,0x1(%edx)
  800d07:	75 0a                	jne    800d13 <strtol+0x65>
		s += 2, base = 16;
  800d09:	83 c2 02             	add    $0x2,%edx
  800d0c:	b8 10 00 00 00       	mov    $0x10,%eax
  800d11:	eb 10                	jmp    800d23 <strtol+0x75>
	else if (base == 0 && s[0] == '0')
  800d13:	85 c0                	test   %eax,%eax
  800d15:	75 0c                	jne    800d23 <strtol+0x75>
		s++, base = 8;
	else if (base == 0)
		base = 10;
  800d17:	b0 0a                	mov    $0xa,%al
		s++, neg = 1;

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
		s += 2, base = 16;
	else if (base == 0 && s[0] == '0')
  800d19:	80 3a 30             	cmpb   $0x30,(%edx)
  800d1c:	75 05                	jne    800d23 <strtol+0x75>
		s++, base = 8;
  800d1e:	83 c2 01             	add    $0x1,%edx
  800d21:	b0 08                	mov    $0x8,%al
	else if (base == 0)
		base = 10;
  800d23:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d28:	89 45 10             	mov    %eax,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d2b:	0f b6 0a             	movzbl (%edx),%ecx
  800d2e:	8d 71 d0             	lea    -0x30(%ecx),%esi
  800d31:	89 f0                	mov    %esi,%eax
  800d33:	3c 09                	cmp    $0x9,%al
  800d35:	77 08                	ja     800d3f <strtol+0x91>
			dig = *s - '0';
  800d37:	0f be c9             	movsbl %cl,%ecx
  800d3a:	83 e9 30             	sub    $0x30,%ecx
  800d3d:	eb 20                	jmp    800d5f <strtol+0xb1>
		else if (*s >= 'a' && *s <= 'z')
  800d3f:	8d 71 9f             	lea    -0x61(%ecx),%esi
  800d42:	89 f0                	mov    %esi,%eax
  800d44:	3c 19                	cmp    $0x19,%al
  800d46:	77 08                	ja     800d50 <strtol+0xa2>
			dig = *s - 'a' + 10;
  800d48:	0f be c9             	movsbl %cl,%ecx
  800d4b:	83 e9 57             	sub    $0x57,%ecx
  800d4e:	eb 0f                	jmp    800d5f <strtol+0xb1>
		else if (*s >= 'A' && *s <= 'Z')
  800d50:	8d 71 bf             	lea    -0x41(%ecx),%esi
  800d53:	89 f0                	mov    %esi,%eax
  800d55:	3c 19                	cmp    $0x19,%al
  800d57:	77 16                	ja     800d6f <strtol+0xc1>
			dig = *s - 'A' + 10;
  800d59:	0f be c9             	movsbl %cl,%ecx
  800d5c:	83 e9 37             	sub    $0x37,%ecx
		else
			break;
		if (dig >= base)
  800d5f:	3b 4d 10             	cmp    0x10(%ebp),%ecx
  800d62:	7d 0f                	jge    800d73 <strtol+0xc5>
			break;
		s++, val = (val * base) + dig;
  800d64:	83 c2 01             	add    $0x1,%edx
  800d67:	0f af 5d 10          	imul   0x10(%ebp),%ebx
  800d6b:	01 cb                	add    %ecx,%ebx
		// we don't properly detect overflow!
	}
  800d6d:	eb bc                	jmp    800d2b <strtol+0x7d>
  800d6f:	89 d8                	mov    %ebx,%eax
  800d71:	eb 02                	jmp    800d75 <strtol+0xc7>
  800d73:	89 d8                	mov    %ebx,%eax

	if (endptr)
  800d75:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d79:	74 05                	je     800d80 <strtol+0xd2>
		*endptr = (char *) s;
  800d7b:	8b 75 0c             	mov    0xc(%ebp),%esi
  800d7e:	89 16                	mov    %edx,(%esi)
	return (neg ? -val : val);
  800d80:	f7 d8                	neg    %eax
  800d82:	85 ff                	test   %edi,%edi
  800d84:	0f 44 c3             	cmove  %ebx,%eax
}
  800d87:	5b                   	pop    %ebx
  800d88:	5e                   	pop    %esi
  800d89:	5f                   	pop    %edi
  800d8a:	5d                   	pop    %ebp
  800d8b:	c3                   	ret    

00800d8c <sys_cputs>:
	return ret;
}

void
sys_cputs(const char *s, size_t len)
{
  800d8c:	55                   	push   %ebp
  800d8d:	89 e5                	mov    %esp,%ebp
  800d8f:	57                   	push   %edi
  800d90:	56                   	push   %esi
  800d91:	53                   	push   %ebx
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800d92:	b8 00 00 00 00       	mov    $0x0,%eax
  800d97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800d9a:	8b 55 08             	mov    0x8(%ebp),%edx
  800d9d:	89 c3                	mov    %eax,%ebx
  800d9f:	89 c7                	mov    %eax,%edi
  800da1:	89 c6                	mov    %eax,%esi
  800da3:	cd 30                	int    $0x30

void
sys_cputs(const char *s, size_t len)
{
	syscall(SYS_cputs, 0, (uint32_t)s, len, 0, 0, 0);
}
  800da5:	5b                   	pop    %ebx
  800da6:	5e                   	pop    %esi
  800da7:	5f                   	pop    %edi
  800da8:	5d                   	pop    %ebp
  800da9:	c3                   	ret    

00800daa <sys_cgetc>:

int
sys_cgetc(void)
{
  800daa:	55                   	push   %ebp
  800dab:	89 e5                	mov    %esp,%ebp
  800dad:	57                   	push   %edi
  800dae:	56                   	push   %esi
  800daf:	53                   	push   %ebx
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800db0:	ba 00 00 00 00       	mov    $0x0,%edx
  800db5:	b8 01 00 00 00       	mov    $0x1,%eax
  800dba:	89 d1                	mov    %edx,%ecx
  800dbc:	89 d3                	mov    %edx,%ebx
  800dbe:	89 d7                	mov    %edx,%edi
  800dc0:	89 d6                	mov    %edx,%esi
  800dc2:	cd 30                	int    $0x30

int
sys_cgetc(void)
{
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0, 0);
}
  800dc4:	5b                   	pop    %ebx
  800dc5:	5e                   	pop    %esi
  800dc6:	5f                   	pop    %edi
  800dc7:	5d                   	pop    %ebp
  800dc8:	c3                   	ret    

00800dc9 <sys_env_destroy>:

int
sys_env_destroy(envid_t envid)
{
  800dc9:	55                   	push   %ebp
  800dca:	89 e5                	mov    %esp,%ebp
  800dcc:	57                   	push   %edi
  800dcd:	56                   	push   %esi
  800dce:	53                   	push   %ebx
  800dcf:	83 ec 2c             	sub    $0x2c,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800dd2:	b9 00 00 00 00       	mov    $0x0,%ecx
  800dd7:	b8 03 00 00 00       	mov    $0x3,%eax
  800ddc:	8b 55 08             	mov    0x8(%ebp),%edx
  800ddf:	89 cb                	mov    %ecx,%ebx
  800de1:	89 cf                	mov    %ecx,%edi
  800de3:	89 ce                	mov    %ecx,%esi
  800de5:	cd 30                	int    $0x30
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	if(check && ret > 0)
  800de7:	85 c0                	test   %eax,%eax
  800de9:	7e 28                	jle    800e13 <sys_env_destroy+0x4a>
		panic("syscall %d returned %d (> 0)", num, ret);
  800deb:	89 44 24 10          	mov    %eax,0x10(%esp)
  800def:	c7 44 24 0c 03 00 00 	movl   $0x3,0xc(%esp)
  800df6:	00 
  800df7:	c7 44 24 08 5f 27 80 	movl   $0x80275f,0x8(%esp)
  800dfe:	00 
  800dff:	c7 44 24 04 22 00 00 	movl   $0x22,0x4(%esp)
  800e06:	00 
  800e07:	c7 04 24 7c 27 80 00 	movl   $0x80277c,(%esp)
  800e0e:	e8 4a f4 ff ff       	call   80025d <_panic>

int
sys_env_destroy(envid_t envid)
{
	return syscall(SYS_env_destroy, 1, envid, 0, 0, 0, 0);
}
  800e13:	83 c4 2c             	add    $0x2c,%esp
  800e16:	5b                   	pop    %ebx
  800e17:	5e                   	pop    %esi
  800e18:	5f                   	pop    %edi
  800e19:	5d                   	pop    %ebp
  800e1a:	c3                   	ret    

00800e1b <sys_getenvid>:

envid_t
sys_getenvid(void)
{
  800e1b:	55                   	push   %ebp
  800e1c:	89 e5                	mov    %esp,%ebp
  800e1e:	57                   	push   %edi
  800e1f:	56                   	push   %esi
  800e20:	53                   	push   %ebx
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800e21:	ba 00 00 00 00       	mov    $0x0,%edx
  800e26:	b8 02 00 00 00       	mov    $0x2,%eax
  800e2b:	89 d1                	mov    %edx,%ecx
  800e2d:	89 d3                	mov    %edx,%ebx
  800e2f:	89 d7                	mov    %edx,%edi
  800e31:	89 d6                	mov    %edx,%esi
  800e33:	cd 30                	int    $0x30

envid_t
sys_getenvid(void)
{
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0, 0);
}
  800e35:	5b                   	pop    %ebx
  800e36:	5e                   	pop    %esi
  800e37:	5f                   	pop    %edi
  800e38:	5d                   	pop    %ebp
  800e39:	c3                   	ret    

00800e3a <sys_yield>:

void
sys_yield(void)
{
  800e3a:	55                   	push   %ebp
  800e3b:	89 e5                	mov    %esp,%ebp
  800e3d:	57                   	push   %edi
  800e3e:	56                   	push   %esi
  800e3f:	53                   	push   %ebx
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800e40:	ba 00 00 00 00       	mov    $0x0,%edx
  800e45:	b8 0b 00 00 00       	mov    $0xb,%eax
  800e4a:	89 d1                	mov    %edx,%ecx
  800e4c:	89 d3                	mov    %edx,%ebx
  800e4e:	89 d7                	mov    %edx,%edi
  800e50:	89 d6                	mov    %edx,%esi
  800e52:	cd 30                	int    $0x30

void
sys_yield(void)
{
	syscall(SYS_yield, 0, 0, 0, 0, 0, 0);
}
  800e54:	5b                   	pop    %ebx
  800e55:	5e                   	pop    %esi
  800e56:	5f                   	pop    %edi
  800e57:	5d                   	pop    %ebp
  800e58:	c3                   	ret    

00800e59 <sys_page_alloc>:

int
sys_page_alloc(envid_t envid, void *va, int perm)
{
  800e59:	55                   	push   %ebp
  800e5a:	89 e5                	mov    %esp,%ebp
  800e5c:	57                   	push   %edi
  800e5d:	56                   	push   %esi
  800e5e:	53                   	push   %ebx
  800e5f:	83 ec 2c             	sub    $0x2c,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800e62:	be 00 00 00 00       	mov    $0x0,%esi
  800e67:	b8 04 00 00 00       	mov    $0x4,%eax
  800e6c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800e6f:	8b 55 08             	mov    0x8(%ebp),%edx
  800e72:	8b 5d 10             	mov    0x10(%ebp),%ebx
  800e75:	89 f7                	mov    %esi,%edi
  800e77:	cd 30                	int    $0x30
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	if(check && ret > 0)
  800e79:	85 c0                	test   %eax,%eax
  800e7b:	7e 28                	jle    800ea5 <sys_page_alloc+0x4c>
		panic("syscall %d returned %d (> 0)", num, ret);
  800e7d:	89 44 24 10          	mov    %eax,0x10(%esp)
  800e81:	c7 44 24 0c 04 00 00 	movl   $0x4,0xc(%esp)
  800e88:	00 
  800e89:	c7 44 24 08 5f 27 80 	movl   $0x80275f,0x8(%esp)
  800e90:	00 
  800e91:	c7 44 24 04 22 00 00 	movl   $0x22,0x4(%esp)
  800e98:	00 
  800e99:	c7 04 24 7c 27 80 00 	movl   $0x80277c,(%esp)
  800ea0:	e8 b8 f3 ff ff       	call   80025d <_panic>

int
sys_page_alloc(envid_t envid, void *va, int perm)
{
	return syscall(SYS_page_alloc, 1, envid, (uint32_t) va, perm, 0, 0);
}
  800ea5:	83 c4 2c             	add    $0x2c,%esp
  800ea8:	5b                   	pop    %ebx
  800ea9:	5e                   	pop    %esi
  800eaa:	5f                   	pop    %edi
  800eab:	5d                   	pop    %ebp
  800eac:	c3                   	ret    

00800ead <sys_page_map>:

int
sys_page_map(envid_t srcenv, void *srcva, envid_t dstenv, void *dstva, int perm)
{
  800ead:	55                   	push   %ebp
  800eae:	89 e5                	mov    %esp,%ebp
  800eb0:	57                   	push   %edi
  800eb1:	56                   	push   %esi
  800eb2:	53                   	push   %ebx
  800eb3:	83 ec 2c             	sub    $0x2c,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800eb6:	b8 05 00 00 00       	mov    $0x5,%eax
  800ebb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800ebe:	8b 55 08             	mov    0x8(%ebp),%edx
  800ec1:	8b 5d 10             	mov    0x10(%ebp),%ebx
  800ec4:	8b 7d 14             	mov    0x14(%ebp),%edi
  800ec7:	8b 75 18             	mov    0x18(%ebp),%esi
  800eca:	cd 30                	int    $0x30
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	if(check && ret > 0)
  800ecc:	85 c0                	test   %eax,%eax
  800ece:	7e 28                	jle    800ef8 <sys_page_map+0x4b>
		panic("syscall %d returned %d (> 0)", num, ret);
  800ed0:	89 44 24 10          	mov    %eax,0x10(%esp)
  800ed4:	c7 44 24 0c 05 00 00 	movl   $0x5,0xc(%esp)
  800edb:	00 
  800edc:	c7 44 24 08 5f 27 80 	movl   $0x80275f,0x8(%esp)
  800ee3:	00 
  800ee4:	c7 44 24 04 22 00 00 	movl   $0x22,0x4(%esp)
  800eeb:	00 
  800eec:	c7 04 24 7c 27 80 00 	movl   $0x80277c,(%esp)
  800ef3:	e8 65 f3 ff ff       	call   80025d <_panic>

int
sys_page_map(envid_t srcenv, void *srcva, envid_t dstenv, void *dstva, int perm)
{
	return syscall(SYS_page_map, 1, srcenv, (uint32_t) srcva, dstenv, (uint32_t) dstva, perm);
}
  800ef8:	83 c4 2c             	add    $0x2c,%esp
  800efb:	5b                   	pop    %ebx
  800efc:	5e                   	pop    %esi
  800efd:	5f                   	pop    %edi
  800efe:	5d                   	pop    %ebp
  800eff:	c3                   	ret    

00800f00 <sys_page_unmap>:

int
sys_page_unmap(envid_t envid, void *va)
{
  800f00:	55                   	push   %ebp
  800f01:	89 e5                	mov    %esp,%ebp
  800f03:	57                   	push   %edi
  800f04:	56                   	push   %esi
  800f05:	53                   	push   %ebx
  800f06:	83 ec 2c             	sub    $0x2c,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800f09:	bb 00 00 00 00       	mov    $0x0,%ebx
  800f0e:	b8 06 00 00 00       	mov    $0x6,%eax
  800f13:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800f16:	8b 55 08             	mov    0x8(%ebp),%edx
  800f19:	89 df                	mov    %ebx,%edi
  800f1b:	89 de                	mov    %ebx,%esi
  800f1d:	cd 30                	int    $0x30
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	if(check && ret > 0)
  800f1f:	85 c0                	test   %eax,%eax
  800f21:	7e 28                	jle    800f4b <sys_page_unmap+0x4b>
		panic("syscall %d returned %d (> 0)", num, ret);
  800f23:	89 44 24 10          	mov    %eax,0x10(%esp)
  800f27:	c7 44 24 0c 06 00 00 	movl   $0x6,0xc(%esp)
  800f2e:	00 
  800f2f:	c7 44 24 08 5f 27 80 	movl   $0x80275f,0x8(%esp)
  800f36:	00 
  800f37:	c7 44 24 04 22 00 00 	movl   $0x22,0x4(%esp)
  800f3e:	00 
  800f3f:	c7 04 24 7c 27 80 00 	movl   $0x80277c,(%esp)
  800f46:	e8 12 f3 ff ff       	call   80025d <_panic>

int
sys_page_unmap(envid_t envid, void *va)
{
	return syscall(SYS_page_unmap, 1, envid, (uint32_t) va, 0, 0, 0);
}
  800f4b:	83 c4 2c             	add    $0x2c,%esp
  800f4e:	5b                   	pop    %ebx
  800f4f:	5e                   	pop    %esi
  800f50:	5f                   	pop    %edi
  800f51:	5d                   	pop    %ebp
  800f52:	c3                   	ret    

00800f53 <sys_env_set_status>:

// sys_exofork is inlined in lib.h

int
sys_env_set_status(envid_t envid, int status)
{
  800f53:	55                   	push   %ebp
  800f54:	89 e5                	mov    %esp,%ebp
  800f56:	57                   	push   %edi
  800f57:	56                   	push   %esi
  800f58:	53                   	push   %ebx
  800f59:	83 ec 2c             	sub    $0x2c,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800f5c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800f61:	b8 08 00 00 00       	mov    $0x8,%eax
  800f66:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800f69:	8b 55 08             	mov    0x8(%ebp),%edx
  800f6c:	89 df                	mov    %ebx,%edi
  800f6e:	89 de                	mov    %ebx,%esi
  800f70:	cd 30                	int    $0x30
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	if(check && ret > 0)
  800f72:	85 c0                	test   %eax,%eax
  800f74:	7e 28                	jle    800f9e <sys_env_set_status+0x4b>
		panic("syscall %d returned %d (> 0)", num, ret);
  800f76:	89 44 24 10          	mov    %eax,0x10(%esp)
  800f7a:	c7 44 24 0c 08 00 00 	movl   $0x8,0xc(%esp)
  800f81:	00 
  800f82:	c7 44 24 08 5f 27 80 	movl   $0x80275f,0x8(%esp)
  800f89:	00 
  800f8a:	c7 44 24 04 22 00 00 	movl   $0x22,0x4(%esp)
  800f91:	00 
  800f92:	c7 04 24 7c 27 80 00 	movl   $0x80277c,(%esp)
  800f99:	e8 bf f2 ff ff       	call   80025d <_panic>

int
sys_env_set_status(envid_t envid, int status)
{
	return syscall(SYS_env_set_status, 1, envid, status, 0, 0, 0);
}
  800f9e:	83 c4 2c             	add    $0x2c,%esp
  800fa1:	5b                   	pop    %ebx
  800fa2:	5e                   	pop    %esi
  800fa3:	5f                   	pop    %edi
  800fa4:	5d                   	pop    %ebp
  800fa5:	c3                   	ret    

00800fa6 <sys_env_set_trapframe>:

int
sys_env_set_trapframe(envid_t envid, struct Trapframe *tf)
{
  800fa6:	55                   	push   %ebp
  800fa7:	89 e5                	mov    %esp,%ebp
  800fa9:	57                   	push   %edi
  800faa:	56                   	push   %esi
  800fab:	53                   	push   %ebx
  800fac:	83 ec 2c             	sub    $0x2c,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800faf:	bb 00 00 00 00       	mov    $0x0,%ebx
  800fb4:	b8 09 00 00 00       	mov    $0x9,%eax
  800fb9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800fbc:	8b 55 08             	mov    0x8(%ebp),%edx
  800fbf:	89 df                	mov    %ebx,%edi
  800fc1:	89 de                	mov    %ebx,%esi
  800fc3:	cd 30                	int    $0x30
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	if(check && ret > 0)
  800fc5:	85 c0                	test   %eax,%eax
  800fc7:	7e 28                	jle    800ff1 <sys_env_set_trapframe+0x4b>
		panic("syscall %d returned %d (> 0)", num, ret);
  800fc9:	89 44 24 10          	mov    %eax,0x10(%esp)
  800fcd:	c7 44 24 0c 09 00 00 	movl   $0x9,0xc(%esp)
  800fd4:	00 
  800fd5:	c7 44 24 08 5f 27 80 	movl   $0x80275f,0x8(%esp)
  800fdc:	00 
  800fdd:	c7 44 24 04 22 00 00 	movl   $0x22,0x4(%esp)
  800fe4:	00 
  800fe5:	c7 04 24 7c 27 80 00 	movl   $0x80277c,(%esp)
  800fec:	e8 6c f2 ff ff       	call   80025d <_panic>

int
sys_env_set_trapframe(envid_t envid, struct Trapframe *tf)
{
	return syscall(SYS_env_set_trapframe, 1, envid, (uint32_t) tf, 0, 0, 0);
}
  800ff1:	83 c4 2c             	add    $0x2c,%esp
  800ff4:	5b                   	pop    %ebx
  800ff5:	5e                   	pop    %esi
  800ff6:	5f                   	pop    %edi
  800ff7:	5d                   	pop    %ebp
  800ff8:	c3                   	ret    

00800ff9 <sys_env_set_pgfault_upcall>:

int
sys_env_set_pgfault_upcall(envid_t envid, void *upcall)
{
  800ff9:	55                   	push   %ebp
  800ffa:	89 e5                	mov    %esp,%ebp
  800ffc:	57                   	push   %edi
  800ffd:	56                   	push   %esi
  800ffe:	53                   	push   %ebx
  800fff:	83 ec 2c             	sub    $0x2c,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801002:	bb 00 00 00 00       	mov    $0x0,%ebx
  801007:	b8 0a 00 00 00       	mov    $0xa,%eax
  80100c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80100f:	8b 55 08             	mov    0x8(%ebp),%edx
  801012:	89 df                	mov    %ebx,%edi
  801014:	89 de                	mov    %ebx,%esi
  801016:	cd 30                	int    $0x30
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	if(check && ret > 0)
  801018:	85 c0                	test   %eax,%eax
  80101a:	7e 28                	jle    801044 <sys_env_set_pgfault_upcall+0x4b>
		panic("syscall %d returned %d (> 0)", num, ret);
  80101c:	89 44 24 10          	mov    %eax,0x10(%esp)
  801020:	c7 44 24 0c 0a 00 00 	movl   $0xa,0xc(%esp)
  801027:	00 
  801028:	c7 44 24 08 5f 27 80 	movl   $0x80275f,0x8(%esp)
  80102f:	00 
  801030:	c7 44 24 04 22 00 00 	movl   $0x22,0x4(%esp)
  801037:	00 
  801038:	c7 04 24 7c 27 80 00 	movl   $0x80277c,(%esp)
  80103f:	e8 19 f2 ff ff       	call   80025d <_panic>

int
sys_env_set_pgfault_upcall(envid_t envid, void *upcall)
{
	return syscall(SYS_env_set_pgfault_upcall, 1, envid, (uint32_t) upcall, 0, 0, 0);
}
  801044:	83 c4 2c             	add    $0x2c,%esp
  801047:	5b                   	pop    %ebx
  801048:	5e                   	pop    %esi
  801049:	5f                   	pop    %edi
  80104a:	5d                   	pop    %ebp
  80104b:	c3                   	ret    

0080104c <sys_ipc_try_send>:

int
sys_ipc_try_send(envid_t envid, uint32_t value, void *srcva, int perm)
{
  80104c:	55                   	push   %ebp
  80104d:	89 e5                	mov    %esp,%ebp
  80104f:	57                   	push   %edi
  801050:	56                   	push   %esi
  801051:	53                   	push   %ebx
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801052:	be 00 00 00 00       	mov    $0x0,%esi
  801057:	b8 0c 00 00 00       	mov    $0xc,%eax
  80105c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80105f:	8b 55 08             	mov    0x8(%ebp),%edx
  801062:	8b 5d 10             	mov    0x10(%ebp),%ebx
  801065:	8b 7d 14             	mov    0x14(%ebp),%edi
  801068:	cd 30                	int    $0x30

int
sys_ipc_try_send(envid_t envid, uint32_t value, void *srcva, int perm)
{
	return syscall(SYS_ipc_try_send, 0, envid, value, (uint32_t) srcva, perm, 0);
}
  80106a:	5b                   	pop    %ebx
  80106b:	5e                   	pop    %esi
  80106c:	5f                   	pop    %edi
  80106d:	5d                   	pop    %ebp
  80106e:	c3                   	ret    

0080106f <sys_ipc_recv>:

int
sys_ipc_recv(void *dstva)
{
  80106f:	55                   	push   %ebp
  801070:	89 e5                	mov    %esp,%ebp
  801072:	57                   	push   %edi
  801073:	56                   	push   %esi
  801074:	53                   	push   %ebx
  801075:	83 ec 2c             	sub    $0x2c,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801078:	b9 00 00 00 00       	mov    $0x0,%ecx
  80107d:	b8 0d 00 00 00       	mov    $0xd,%eax
  801082:	8b 55 08             	mov    0x8(%ebp),%edx
  801085:	89 cb                	mov    %ecx,%ebx
  801087:	89 cf                	mov    %ecx,%edi
  801089:	89 ce                	mov    %ecx,%esi
  80108b:	cd 30                	int    $0x30
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	if(check && ret > 0)
  80108d:	85 c0                	test   %eax,%eax
  80108f:	7e 28                	jle    8010b9 <sys_ipc_recv+0x4a>
		panic("syscall %d returned %d (> 0)", num, ret);
  801091:	89 44 24 10          	mov    %eax,0x10(%esp)
  801095:	c7 44 24 0c 0d 00 00 	movl   $0xd,0xc(%esp)
  80109c:	00 
  80109d:	c7 44 24 08 5f 27 80 	movl   $0x80275f,0x8(%esp)
  8010a4:	00 
  8010a5:	c7 44 24 04 22 00 00 	movl   $0x22,0x4(%esp)
  8010ac:	00 
  8010ad:	c7 04 24 7c 27 80 00 	movl   $0x80277c,(%esp)
  8010b4:	e8 a4 f1 ff ff       	call   80025d <_panic>

int
sys_ipc_recv(void *dstva)
{
	return syscall(SYS_ipc_recv, 1, (uint32_t)dstva, 0, 0, 0, 0);
}
  8010b9:	83 c4 2c             	add    $0x2c,%esp
  8010bc:	5b                   	pop    %ebx
  8010bd:	5e                   	pop    %esi
  8010be:	5f                   	pop    %edi
  8010bf:	5d                   	pop    %ebp
  8010c0:	c3                   	ret    
  8010c1:	66 90                	xchg   %ax,%ax
  8010c3:	66 90                	xchg   %ax,%ax
  8010c5:	66 90                	xchg   %ax,%ax
  8010c7:	66 90                	xchg   %ax,%ax
  8010c9:	66 90                	xchg   %ax,%ax
  8010cb:	66 90                	xchg   %ax,%ax
  8010cd:	66 90                	xchg   %ax,%ax
  8010cf:	90                   	nop

008010d0 <fd2num>:
// File descriptor manipulators
// --------------------------------------------------------------

int
fd2num(struct Fd *fd)
{
  8010d0:	55                   	push   %ebp
  8010d1:	89 e5                	mov    %esp,%ebp
	return ((uintptr_t) fd - FDTABLE) / PGSIZE;
  8010d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d6:	05 00 00 00 30       	add    $0x30000000,%eax
  8010db:	c1 e8 0c             	shr    $0xc,%eax
}
  8010de:	5d                   	pop    %ebp
  8010df:	c3                   	ret    

008010e0 <fd2data>:

char*
fd2data(struct Fd *fd)
{
  8010e0:	55                   	push   %ebp
  8010e1:	89 e5                	mov    %esp,%ebp
// --------------------------------------------------------------

int
fd2num(struct Fd *fd)
{
	return ((uintptr_t) fd - FDTABLE) / PGSIZE;
  8010e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e6:	05 00 00 00 30       	add    $0x30000000,%eax
}

char*
fd2data(struct Fd *fd)
{
	return INDEX2DATA(fd2num(fd));
  8010eb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8010f0:	2d 00 00 fe 2f       	sub    $0x2ffe0000,%eax
}
  8010f5:	5d                   	pop    %ebp
  8010f6:	c3                   	ret    

008010f7 <fd_alloc>:
// Returns 0 on success, < 0 on error.  Errors are:
//	-E_MAX_FD: no more file descriptors
// On error, *fd_store is set to 0.
int
fd_alloc(struct Fd **fd_store)
{
  8010f7:	55                   	push   %ebp
  8010f8:	89 e5                	mov    %esp,%ebp
	int i;
	struct Fd *fd;

	for (i = 0; i < MAXFD; i++) {
		fd = INDEX2FD(i);
		if ((uvpd[PDX(fd)] & PTE_P) == 0 || (uvpt[PGNUM(fd)] & PTE_P) == 0) {
  8010fa:	a1 00 dd 7b ef       	mov    0xef7bdd00,%eax
  8010ff:	a8 01                	test   $0x1,%al
  801101:	74 34                	je     801137 <fd_alloc+0x40>
  801103:	a1 00 00 74 ef       	mov    0xef740000,%eax
  801108:	a8 01                	test   $0x1,%al
  80110a:	74 32                	je     80113e <fd_alloc+0x47>
  80110c:	b8 00 10 00 d0       	mov    $0xd0001000,%eax
{
	int i;
	struct Fd *fd;

	for (i = 0; i < MAXFD; i++) {
		fd = INDEX2FD(i);
  801111:	89 c1                	mov    %eax,%ecx
		if ((uvpd[PDX(fd)] & PTE_P) == 0 || (uvpt[PGNUM(fd)] & PTE_P) == 0) {
  801113:	89 c2                	mov    %eax,%edx
  801115:	c1 ea 16             	shr    $0x16,%edx
  801118:	8b 14 95 00 d0 7b ef 	mov    -0x10843000(,%edx,4),%edx
  80111f:	f6 c2 01             	test   $0x1,%dl
  801122:	74 1f                	je     801143 <fd_alloc+0x4c>
  801124:	89 c2                	mov    %eax,%edx
  801126:	c1 ea 0c             	shr    $0xc,%edx
  801129:	8b 14 95 00 00 40 ef 	mov    -0x10c00000(,%edx,4),%edx
  801130:	f6 c2 01             	test   $0x1,%dl
  801133:	75 1a                	jne    80114f <fd_alloc+0x58>
  801135:	eb 0c                	jmp    801143 <fd_alloc+0x4c>
{
	int i;
	struct Fd *fd;

	for (i = 0; i < MAXFD; i++) {
		fd = INDEX2FD(i);
  801137:	b9 00 00 00 d0       	mov    $0xd0000000,%ecx
  80113c:	eb 05                	jmp    801143 <fd_alloc+0x4c>
  80113e:	b9 00 00 00 d0       	mov    $0xd0000000,%ecx
		if ((uvpd[PDX(fd)] & PTE_P) == 0 || (uvpt[PGNUM(fd)] & PTE_P) == 0) {
			*fd_store = fd;
  801143:	8b 45 08             	mov    0x8(%ebp),%eax
  801146:	89 08                	mov    %ecx,(%eax)
			return 0;
  801148:	b8 00 00 00 00       	mov    $0x0,%eax
  80114d:	eb 1a                	jmp    801169 <fd_alloc+0x72>
  80114f:	05 00 10 00 00       	add    $0x1000,%eax
fd_alloc(struct Fd **fd_store)
{
	int i;
	struct Fd *fd;

	for (i = 0; i < MAXFD; i++) {
  801154:	3d 00 00 02 d0       	cmp    $0xd0020000,%eax
  801159:	75 b6                	jne    801111 <fd_alloc+0x1a>
		if ((uvpd[PDX(fd)] & PTE_P) == 0 || (uvpt[PGNUM(fd)] & PTE_P) == 0) {
			*fd_store = fd;
			return 0;
		}
	}
	*fd_store = 0;
  80115b:	8b 45 08             	mov    0x8(%ebp),%eax
  80115e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return -E_MAX_OPEN;
  801164:	b8 f6 ff ff ff       	mov    $0xfffffff6,%eax
}
  801169:	5d                   	pop    %ebp
  80116a:	c3                   	ret    

0080116b <fd_lookup>:
// Returns 0 on success (the page is in range and mapped), < 0 on error.
// Errors are:
//	-E_INVAL: fdnum was either not in range or not mapped.
int
fd_lookup(int fdnum, struct Fd **fd_store)
{
  80116b:	55                   	push   %ebp
  80116c:	89 e5                	mov    %esp,%ebp
  80116e:	8b 45 08             	mov    0x8(%ebp),%eax
	struct Fd *fd;

	if (fdnum < 0 || fdnum >= MAXFD) {
  801171:	83 f8 1f             	cmp    $0x1f,%eax
  801174:	77 36                	ja     8011ac <fd_lookup+0x41>
		if (debug)
			cprintf("[%08x] bad fd %d\n", thisenv->env_id, fdnum);
		return -E_INVAL;
	}
	fd = INDEX2FD(fdnum);
  801176:	c1 e0 0c             	shl    $0xc,%eax
  801179:	2d 00 00 00 30       	sub    $0x30000000,%eax
	if (!(uvpd[PDX(fd)] & PTE_P) || !(uvpt[PGNUM(fd)] & PTE_P)) {
  80117e:	89 c2                	mov    %eax,%edx
  801180:	c1 ea 16             	shr    $0x16,%edx
  801183:	8b 14 95 00 d0 7b ef 	mov    -0x10843000(,%edx,4),%edx
  80118a:	f6 c2 01             	test   $0x1,%dl
  80118d:	74 24                	je     8011b3 <fd_lookup+0x48>
  80118f:	89 c2                	mov    %eax,%edx
  801191:	c1 ea 0c             	shr    $0xc,%edx
  801194:	8b 14 95 00 00 40 ef 	mov    -0x10c00000(,%edx,4),%edx
  80119b:	f6 c2 01             	test   $0x1,%dl
  80119e:	74 1a                	je     8011ba <fd_lookup+0x4f>
		if (debug)
			cprintf("[%08x] closed fd %d\n", thisenv->env_id, fdnum);
		return -E_INVAL;
	}
	*fd_store = fd;
  8011a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011a3:	89 02                	mov    %eax,(%edx)
	return 0;
  8011a5:	b8 00 00 00 00       	mov    $0x0,%eax
  8011aa:	eb 13                	jmp    8011bf <fd_lookup+0x54>
	struct Fd *fd;

	if (fdnum < 0 || fdnum >= MAXFD) {
		if (debug)
			cprintf("[%08x] bad fd %d\n", thisenv->env_id, fdnum);
		return -E_INVAL;
  8011ac:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8011b1:	eb 0c                	jmp    8011bf <fd_lookup+0x54>
	}
	fd = INDEX2FD(fdnum);
	if (!(uvpd[PDX(fd)] & PTE_P) || !(uvpt[PGNUM(fd)] & PTE_P)) {
		if (debug)
			cprintf("[%08x] closed fd %d\n", thisenv->env_id, fdnum);
		return -E_INVAL;
  8011b3:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8011b8:	eb 05                	jmp    8011bf <fd_lookup+0x54>
  8011ba:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
	}
	*fd_store = fd;
	return 0;
}
  8011bf:	5d                   	pop    %ebp
  8011c0:	c3                   	ret    

008011c1 <dev_lookup>:
	0
};

int
dev_lookup(int dev_id, struct Dev **dev)
{
  8011c1:	55                   	push   %ebp
  8011c2:	89 e5                	mov    %esp,%ebp
  8011c4:	53                   	push   %ebx
  8011c5:	83 ec 14             	sub    $0x14,%esp
  8011c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	int i;
	for (i = 0; devtab[i]; i++)
		if (devtab[i]->dev_id == dev_id) {
  8011ce:	39 05 08 30 80 00    	cmp    %eax,0x803008
  8011d4:	75 1e                	jne    8011f4 <dev_lookup+0x33>
  8011d6:	eb 0e                	jmp    8011e6 <dev_lookup+0x25>

int
dev_lookup(int dev_id, struct Dev **dev)
{
	int i;
	for (i = 0; devtab[i]; i++)
  8011d8:	b8 24 30 80 00       	mov    $0x803024,%eax
  8011dd:	eb 0c                	jmp    8011eb <dev_lookup+0x2a>
  8011df:	b8 40 30 80 00       	mov    $0x803040,%eax
  8011e4:	eb 05                	jmp    8011eb <dev_lookup+0x2a>
  8011e6:	b8 08 30 80 00       	mov    $0x803008,%eax
		if (devtab[i]->dev_id == dev_id) {
			*dev = devtab[i];
  8011eb:	89 03                	mov    %eax,(%ebx)
			return 0;
  8011ed:	b8 00 00 00 00       	mov    $0x0,%eax
  8011f2:	eb 38                	jmp    80122c <dev_lookup+0x6b>
int
dev_lookup(int dev_id, struct Dev **dev)
{
	int i;
	for (i = 0; devtab[i]; i++)
		if (devtab[i]->dev_id == dev_id) {
  8011f4:	39 05 24 30 80 00    	cmp    %eax,0x803024
  8011fa:	74 dc                	je     8011d8 <dev_lookup+0x17>
  8011fc:	39 05 40 30 80 00    	cmp    %eax,0x803040
  801202:	74 db                	je     8011df <dev_lookup+0x1e>
			*dev = devtab[i];
			return 0;
		}
	cprintf("[%08x] unknown device type %d\n", thisenv->env_id, dev_id);
  801204:	8b 15 08 40 80 00    	mov    0x804008,%edx
  80120a:	8b 52 48             	mov    0x48(%edx),%edx
  80120d:	89 44 24 08          	mov    %eax,0x8(%esp)
  801211:	89 54 24 04          	mov    %edx,0x4(%esp)
  801215:	c7 04 24 8c 27 80 00 	movl   $0x80278c,(%esp)
  80121c:	e8 35 f1 ff ff       	call   800356 <cprintf>
	*dev = 0;
  801221:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	return -E_INVAL;
  801227:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
}
  80122c:	83 c4 14             	add    $0x14,%esp
  80122f:	5b                   	pop    %ebx
  801230:	5d                   	pop    %ebp
  801231:	c3                   	ret    

00801232 <fd_close>:
// If 'must_exist' is 1, then fd_close returns -E_INVAL when passed a
// closed or nonexistent file descriptor.
// Returns 0 on success, < 0 on error.
int
fd_close(struct Fd *fd, bool must_exist)
{
  801232:	55                   	push   %ebp
  801233:	89 e5                	mov    %esp,%ebp
  801235:	56                   	push   %esi
  801236:	53                   	push   %ebx
  801237:	83 ec 20             	sub    $0x20,%esp
  80123a:	8b 75 08             	mov    0x8(%ebp),%esi
  80123d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	struct Fd *fd2;
	struct Dev *dev;
	int r;
	if ((r = fd_lookup(fd2num(fd), &fd2)) < 0
  801240:	8d 45 f4             	lea    -0xc(%ebp),%eax
  801243:	89 44 24 04          	mov    %eax,0x4(%esp)
// --------------------------------------------------------------

int
fd2num(struct Fd *fd)
{
	return ((uintptr_t) fd - FDTABLE) / PGSIZE;
  801247:	8d 86 00 00 00 30    	lea    0x30000000(%esi),%eax
  80124d:	c1 e8 0c             	shr    $0xc,%eax
fd_close(struct Fd *fd, bool must_exist)
{
	struct Fd *fd2;
	struct Dev *dev;
	int r;
	if ((r = fd_lookup(fd2num(fd), &fd2)) < 0
  801250:	89 04 24             	mov    %eax,(%esp)
  801253:	e8 13 ff ff ff       	call   80116b <fd_lookup>
  801258:	85 c0                	test   %eax,%eax
  80125a:	78 05                	js     801261 <fd_close+0x2f>
	    || fd != fd2)
  80125c:	3b 75 f4             	cmp    -0xc(%ebp),%esi
  80125f:	74 0c                	je     80126d <fd_close+0x3b>
		return (must_exist ? r : 0);
  801261:	84 db                	test   %bl,%bl
  801263:	ba 00 00 00 00       	mov    $0x0,%edx
  801268:	0f 44 c2             	cmove  %edx,%eax
  80126b:	eb 3f                	jmp    8012ac <fd_close+0x7a>
	if ((r = dev_lookup(fd->fd_dev_id, &dev)) >= 0) {
  80126d:	8d 45 f0             	lea    -0x10(%ebp),%eax
  801270:	89 44 24 04          	mov    %eax,0x4(%esp)
  801274:	8b 06                	mov    (%esi),%eax
  801276:	89 04 24             	mov    %eax,(%esp)
  801279:	e8 43 ff ff ff       	call   8011c1 <dev_lookup>
  80127e:	89 c3                	mov    %eax,%ebx
  801280:	85 c0                	test   %eax,%eax
  801282:	78 16                	js     80129a <fd_close+0x68>
		if (dev->dev_close)
  801284:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801287:	8b 40 10             	mov    0x10(%eax),%eax
			r = (*dev->dev_close)(fd);
		else
			r = 0;
  80128a:	bb 00 00 00 00       	mov    $0x0,%ebx
	int r;
	if ((r = fd_lookup(fd2num(fd), &fd2)) < 0
	    || fd != fd2)
		return (must_exist ? r : 0);
	if ((r = dev_lookup(fd->fd_dev_id, &dev)) >= 0) {
		if (dev->dev_close)
  80128f:	85 c0                	test   %eax,%eax
  801291:	74 07                	je     80129a <fd_close+0x68>
			r = (*dev->dev_close)(fd);
  801293:	89 34 24             	mov    %esi,(%esp)
  801296:	ff d0                	call   *%eax
  801298:	89 c3                	mov    %eax,%ebx
		else
			r = 0;
	}
	// Make sure fd is unmapped.  Might be a no-op if
	// (*dev->dev_close)(fd) already unmapped it.
	(void) sys_page_unmap(0, fd);
  80129a:	89 74 24 04          	mov    %esi,0x4(%esp)
  80129e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  8012a5:	e8 56 fc ff ff       	call   800f00 <sys_page_unmap>
	return r;
  8012aa:	89 d8                	mov    %ebx,%eax
}
  8012ac:	83 c4 20             	add    $0x20,%esp
  8012af:	5b                   	pop    %ebx
  8012b0:	5e                   	pop    %esi
  8012b1:	5d                   	pop    %ebp
  8012b2:	c3                   	ret    

008012b3 <close>:
	return -E_INVAL;
}

int
close(int fdnum)
{
  8012b3:	55                   	push   %ebp
  8012b4:	89 e5                	mov    %esp,%ebp
  8012b6:	83 ec 28             	sub    $0x28,%esp
	struct Fd *fd;
	int r;

	if ((r = fd_lookup(fdnum, &fd)) < 0)
  8012b9:	8d 45 f4             	lea    -0xc(%ebp),%eax
  8012bc:	89 44 24 04          	mov    %eax,0x4(%esp)
  8012c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c3:	89 04 24             	mov    %eax,(%esp)
  8012c6:	e8 a0 fe ff ff       	call   80116b <fd_lookup>
  8012cb:	89 c2                	mov    %eax,%edx
  8012cd:	85 d2                	test   %edx,%edx
  8012cf:	78 13                	js     8012e4 <close+0x31>
		return r;
	else
		return fd_close(fd, 1);
  8012d1:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  8012d8:	00 
  8012d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012dc:	89 04 24             	mov    %eax,(%esp)
  8012df:	e8 4e ff ff ff       	call   801232 <fd_close>
}
  8012e4:	c9                   	leave  
  8012e5:	c3                   	ret    

008012e6 <close_all>:

void
close_all(void)
{
  8012e6:	55                   	push   %ebp
  8012e7:	89 e5                	mov    %esp,%ebp
  8012e9:	53                   	push   %ebx
  8012ea:	83 ec 14             	sub    $0x14,%esp
	int i;
	for (i = 0; i < MAXFD; i++)
  8012ed:	bb 00 00 00 00       	mov    $0x0,%ebx
		close(i);
  8012f2:	89 1c 24             	mov    %ebx,(%esp)
  8012f5:	e8 b9 ff ff ff       	call   8012b3 <close>

void
close_all(void)
{
	int i;
	for (i = 0; i < MAXFD; i++)
  8012fa:	83 c3 01             	add    $0x1,%ebx
  8012fd:	83 fb 20             	cmp    $0x20,%ebx
  801300:	75 f0                	jne    8012f2 <close_all+0xc>
		close(i);
}
  801302:	83 c4 14             	add    $0x14,%esp
  801305:	5b                   	pop    %ebx
  801306:	5d                   	pop    %ebp
  801307:	c3                   	ret    

00801308 <dup>:
// file and the file offset of the other.
// Closes any previously open file descriptor at 'newfdnum'.
// This is implemented using virtual memory tricks (of course!).
int
dup(int oldfdnum, int newfdnum)
{
  801308:	55                   	push   %ebp
  801309:	89 e5                	mov    %esp,%ebp
  80130b:	57                   	push   %edi
  80130c:	56                   	push   %esi
  80130d:	53                   	push   %ebx
  80130e:	83 ec 3c             	sub    $0x3c,%esp
	int r;
	char *ova, *nva;
	pte_t pte;
	struct Fd *oldfd, *newfd;

	if ((r = fd_lookup(oldfdnum, &oldfd)) < 0)
  801311:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  801314:	89 44 24 04          	mov    %eax,0x4(%esp)
  801318:	8b 45 08             	mov    0x8(%ebp),%eax
  80131b:	89 04 24             	mov    %eax,(%esp)
  80131e:	e8 48 fe ff ff       	call   80116b <fd_lookup>
  801323:	89 c2                	mov    %eax,%edx
  801325:	85 d2                	test   %edx,%edx
  801327:	0f 88 e1 00 00 00    	js     80140e <dup+0x106>
		return r;
	close(newfdnum);
  80132d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801330:	89 04 24             	mov    %eax,(%esp)
  801333:	e8 7b ff ff ff       	call   8012b3 <close>

	newfd = INDEX2FD(newfdnum);
  801338:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  80133b:	c1 e3 0c             	shl    $0xc,%ebx
  80133e:	81 eb 00 00 00 30    	sub    $0x30000000,%ebx
	ova = fd2data(oldfd);
  801344:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801347:	89 04 24             	mov    %eax,(%esp)
  80134a:	e8 91 fd ff ff       	call   8010e0 <fd2data>
  80134f:	89 c6                	mov    %eax,%esi
	nva = fd2data(newfd);
  801351:	89 1c 24             	mov    %ebx,(%esp)
  801354:	e8 87 fd ff ff       	call   8010e0 <fd2data>
  801359:	89 c7                	mov    %eax,%edi

	if ((uvpd[PDX(ova)] & PTE_P) && (uvpt[PGNUM(ova)] & PTE_P))
  80135b:	89 f0                	mov    %esi,%eax
  80135d:	c1 e8 16             	shr    $0x16,%eax
  801360:	8b 04 85 00 d0 7b ef 	mov    -0x10843000(,%eax,4),%eax
  801367:	a8 01                	test   $0x1,%al
  801369:	74 43                	je     8013ae <dup+0xa6>
  80136b:	89 f0                	mov    %esi,%eax
  80136d:	c1 e8 0c             	shr    $0xc,%eax
  801370:	8b 14 85 00 00 40 ef 	mov    -0x10c00000(,%eax,4),%edx
  801377:	f6 c2 01             	test   $0x1,%dl
  80137a:	74 32                	je     8013ae <dup+0xa6>
		if ((r = sys_page_map(0, ova, 0, nva, uvpt[PGNUM(ova)] & PTE_SYSCALL)) < 0)
  80137c:	8b 04 85 00 00 40 ef 	mov    -0x10c00000(,%eax,4),%eax
  801383:	25 07 0e 00 00       	and    $0xe07,%eax
  801388:	89 44 24 10          	mov    %eax,0x10(%esp)
  80138c:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801390:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  801397:	00 
  801398:	89 74 24 04          	mov    %esi,0x4(%esp)
  80139c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  8013a3:	e8 05 fb ff ff       	call   800ead <sys_page_map>
  8013a8:	89 c6                	mov    %eax,%esi
  8013aa:	85 c0                	test   %eax,%eax
  8013ac:	78 3e                	js     8013ec <dup+0xe4>
			goto err;
	if ((r = sys_page_map(0, oldfd, 0, newfd, uvpt[PGNUM(oldfd)] & PTE_SYSCALL)) < 0)
  8013ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8013b1:	89 c2                	mov    %eax,%edx
  8013b3:	c1 ea 0c             	shr    $0xc,%edx
  8013b6:	8b 14 95 00 00 40 ef 	mov    -0x10c00000(,%edx,4),%edx
  8013bd:	81 e2 07 0e 00 00    	and    $0xe07,%edx
  8013c3:	89 54 24 10          	mov    %edx,0x10(%esp)
  8013c7:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  8013cb:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  8013d2:	00 
  8013d3:	89 44 24 04          	mov    %eax,0x4(%esp)
  8013d7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  8013de:	e8 ca fa ff ff       	call   800ead <sys_page_map>
  8013e3:	89 c6                	mov    %eax,%esi
		goto err;

	return newfdnum;
  8013e5:	8b 45 0c             	mov    0xc(%ebp),%eax
	nva = fd2data(newfd);

	if ((uvpd[PDX(ova)] & PTE_P) && (uvpt[PGNUM(ova)] & PTE_P))
		if ((r = sys_page_map(0, ova, 0, nva, uvpt[PGNUM(ova)] & PTE_SYSCALL)) < 0)
			goto err;
	if ((r = sys_page_map(0, oldfd, 0, newfd, uvpt[PGNUM(oldfd)] & PTE_SYSCALL)) < 0)
  8013e8:	85 f6                	test   %esi,%esi
  8013ea:	79 22                	jns    80140e <dup+0x106>
		goto err;

	return newfdnum;

err:
	sys_page_unmap(0, newfd);
  8013ec:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  8013f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  8013f7:	e8 04 fb ff ff       	call   800f00 <sys_page_unmap>
	sys_page_unmap(0, nva);
  8013fc:	89 7c 24 04          	mov    %edi,0x4(%esp)
  801400:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  801407:	e8 f4 fa ff ff       	call   800f00 <sys_page_unmap>
	return r;
  80140c:	89 f0                	mov    %esi,%eax
}
  80140e:	83 c4 3c             	add    $0x3c,%esp
  801411:	5b                   	pop    %ebx
  801412:	5e                   	pop    %esi
  801413:	5f                   	pop    %edi
  801414:	5d                   	pop    %ebp
  801415:	c3                   	ret    

00801416 <read>:

ssize_t
read(int fdnum, void *buf, size_t n)
{
  801416:	55                   	push   %ebp
  801417:	89 e5                	mov    %esp,%ebp
  801419:	53                   	push   %ebx
  80141a:	83 ec 24             	sub    $0x24,%esp
  80141d:	8b 5d 08             	mov    0x8(%ebp),%ebx
	int r;
	struct Dev *dev;
	struct Fd *fd;

	if ((r = fd_lookup(fdnum, &fd)) < 0
  801420:	8d 45 f0             	lea    -0x10(%ebp),%eax
  801423:	89 44 24 04          	mov    %eax,0x4(%esp)
  801427:	89 1c 24             	mov    %ebx,(%esp)
  80142a:	e8 3c fd ff ff       	call   80116b <fd_lookup>
  80142f:	89 c2                	mov    %eax,%edx
  801431:	85 d2                	test   %edx,%edx
  801433:	78 6d                	js     8014a2 <read+0x8c>
	    || (r = dev_lookup(fd->fd_dev_id, &dev)) < 0)
  801435:	8d 45 f4             	lea    -0xc(%ebp),%eax
  801438:	89 44 24 04          	mov    %eax,0x4(%esp)
  80143c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80143f:	8b 00                	mov    (%eax),%eax
  801441:	89 04 24             	mov    %eax,(%esp)
  801444:	e8 78 fd ff ff       	call   8011c1 <dev_lookup>
  801449:	85 c0                	test   %eax,%eax
  80144b:	78 55                	js     8014a2 <read+0x8c>
		return r;
	if ((fd->fd_omode & O_ACCMODE) == O_WRONLY) {
  80144d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801450:	8b 50 08             	mov    0x8(%eax),%edx
  801453:	83 e2 03             	and    $0x3,%edx
  801456:	83 fa 01             	cmp    $0x1,%edx
  801459:	75 23                	jne    80147e <read+0x68>
		cprintf("[%08x] read %d -- bad mode\n", thisenv->env_id, fdnum);
  80145b:	a1 08 40 80 00       	mov    0x804008,%eax
  801460:	8b 40 48             	mov    0x48(%eax),%eax
  801463:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801467:	89 44 24 04          	mov    %eax,0x4(%esp)
  80146b:	c7 04 24 d0 27 80 00 	movl   $0x8027d0,(%esp)
  801472:	e8 df ee ff ff       	call   800356 <cprintf>
		return -E_INVAL;
  801477:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80147c:	eb 24                	jmp    8014a2 <read+0x8c>
	}
	if (!dev->dev_read)
  80147e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801481:	8b 52 08             	mov    0x8(%edx),%edx
  801484:	85 d2                	test   %edx,%edx
  801486:	74 15                	je     80149d <read+0x87>
		return -E_NOT_SUPP;
	return (*dev->dev_read)(fd, buf, n);
  801488:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80148b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80148f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  801492:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801496:	89 04 24             	mov    %eax,(%esp)
  801499:	ff d2                	call   *%edx
  80149b:	eb 05                	jmp    8014a2 <read+0x8c>
	if ((fd->fd_omode & O_ACCMODE) == O_WRONLY) {
		cprintf("[%08x] read %d -- bad mode\n", thisenv->env_id, fdnum);
		return -E_INVAL;
	}
	if (!dev->dev_read)
		return -E_NOT_SUPP;
  80149d:	b8 f1 ff ff ff       	mov    $0xfffffff1,%eax
	return (*dev->dev_read)(fd, buf, n);
}
  8014a2:	83 c4 24             	add    $0x24,%esp
  8014a5:	5b                   	pop    %ebx
  8014a6:	5d                   	pop    %ebp
  8014a7:	c3                   	ret    

008014a8 <readn>:

ssize_t
readn(int fdnum, void *buf, size_t n)
{
  8014a8:	55                   	push   %ebp
  8014a9:	89 e5                	mov    %esp,%ebp
  8014ab:	57                   	push   %edi
  8014ac:	56                   	push   %esi
  8014ad:	53                   	push   %ebx
  8014ae:	83 ec 1c             	sub    $0x1c,%esp
  8014b1:	8b 7d 08             	mov    0x8(%ebp),%edi
  8014b4:	8b 75 10             	mov    0x10(%ebp),%esi
	int m, tot;

	for (tot = 0; tot < n; tot += m) {
  8014b7:	85 f6                	test   %esi,%esi
  8014b9:	74 33                	je     8014ee <readn+0x46>
  8014bb:	b8 00 00 00 00       	mov    $0x0,%eax
  8014c0:	bb 00 00 00 00       	mov    $0x0,%ebx
		m = read(fdnum, (char*)buf + tot, n - tot);
  8014c5:	89 f2                	mov    %esi,%edx
  8014c7:	29 c2                	sub    %eax,%edx
  8014c9:	89 54 24 08          	mov    %edx,0x8(%esp)
  8014cd:	03 45 0c             	add    0xc(%ebp),%eax
  8014d0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8014d4:	89 3c 24             	mov    %edi,(%esp)
  8014d7:	e8 3a ff ff ff       	call   801416 <read>
		if (m < 0)
  8014dc:	85 c0                	test   %eax,%eax
  8014de:	78 1b                	js     8014fb <readn+0x53>
			return m;
		if (m == 0)
  8014e0:	85 c0                	test   %eax,%eax
  8014e2:	74 11                	je     8014f5 <readn+0x4d>
ssize_t
readn(int fdnum, void *buf, size_t n)
{
	int m, tot;

	for (tot = 0; tot < n; tot += m) {
  8014e4:	01 c3                	add    %eax,%ebx
  8014e6:	89 d8                	mov    %ebx,%eax
  8014e8:	39 f3                	cmp    %esi,%ebx
  8014ea:	72 d9                	jb     8014c5 <readn+0x1d>
  8014ec:	eb 0b                	jmp    8014f9 <readn+0x51>
  8014ee:	b8 00 00 00 00       	mov    $0x0,%eax
  8014f3:	eb 06                	jmp    8014fb <readn+0x53>
  8014f5:	89 d8                	mov    %ebx,%eax
  8014f7:	eb 02                	jmp    8014fb <readn+0x53>
  8014f9:	89 d8                	mov    %ebx,%eax
			return m;
		if (m == 0)
			break;
	}
	return tot;
}
  8014fb:	83 c4 1c             	add    $0x1c,%esp
  8014fe:	5b                   	pop    %ebx
  8014ff:	5e                   	pop    %esi
  801500:	5f                   	pop    %edi
  801501:	5d                   	pop    %ebp
  801502:	c3                   	ret    

00801503 <write>:

ssize_t
write(int fdnum, const void *buf, size_t n)
{
  801503:	55                   	push   %ebp
  801504:	89 e5                	mov    %esp,%ebp
  801506:	53                   	push   %ebx
  801507:	83 ec 24             	sub    $0x24,%esp
  80150a:	8b 5d 08             	mov    0x8(%ebp),%ebx
	int r;
	struct Dev *dev;
	struct Fd *fd;

	if ((r = fd_lookup(fdnum, &fd)) < 0
  80150d:	8d 45 f0             	lea    -0x10(%ebp),%eax
  801510:	89 44 24 04          	mov    %eax,0x4(%esp)
  801514:	89 1c 24             	mov    %ebx,(%esp)
  801517:	e8 4f fc ff ff       	call   80116b <fd_lookup>
  80151c:	89 c2                	mov    %eax,%edx
  80151e:	85 d2                	test   %edx,%edx
  801520:	78 68                	js     80158a <write+0x87>
	    || (r = dev_lookup(fd->fd_dev_id, &dev)) < 0)
  801522:	8d 45 f4             	lea    -0xc(%ebp),%eax
  801525:	89 44 24 04          	mov    %eax,0x4(%esp)
  801529:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80152c:	8b 00                	mov    (%eax),%eax
  80152e:	89 04 24             	mov    %eax,(%esp)
  801531:	e8 8b fc ff ff       	call   8011c1 <dev_lookup>
  801536:	85 c0                	test   %eax,%eax
  801538:	78 50                	js     80158a <write+0x87>
		return r;
	if ((fd->fd_omode & O_ACCMODE) == O_RDONLY) {
  80153a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80153d:	f6 40 08 03          	testb  $0x3,0x8(%eax)
  801541:	75 23                	jne    801566 <write+0x63>
		cprintf("[%08x] write %d -- bad mode\n", thisenv->env_id, fdnum);
  801543:	a1 08 40 80 00       	mov    0x804008,%eax
  801548:	8b 40 48             	mov    0x48(%eax),%eax
  80154b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80154f:	89 44 24 04          	mov    %eax,0x4(%esp)
  801553:	c7 04 24 ec 27 80 00 	movl   $0x8027ec,(%esp)
  80155a:	e8 f7 ed ff ff       	call   800356 <cprintf>
		return -E_INVAL;
  80155f:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  801564:	eb 24                	jmp    80158a <write+0x87>
	}
	if (debug)
		cprintf("write %d %p %d via dev %s\n",
			fdnum, buf, n, dev->dev_name);
	if (!dev->dev_write)
  801566:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801569:	8b 52 0c             	mov    0xc(%edx),%edx
  80156c:	85 d2                	test   %edx,%edx
  80156e:	74 15                	je     801585 <write+0x82>
		return -E_NOT_SUPP;
	return (*dev->dev_write)(fd, buf, n);
  801570:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801573:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801577:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80157a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80157e:	89 04 24             	mov    %eax,(%esp)
  801581:	ff d2                	call   *%edx
  801583:	eb 05                	jmp    80158a <write+0x87>
	}
	if (debug)
		cprintf("write %d %p %d via dev %s\n",
			fdnum, buf, n, dev->dev_name);
	if (!dev->dev_write)
		return -E_NOT_SUPP;
  801585:	b8 f1 ff ff ff       	mov    $0xfffffff1,%eax
	return (*dev->dev_write)(fd, buf, n);
}
  80158a:	83 c4 24             	add    $0x24,%esp
  80158d:	5b                   	pop    %ebx
  80158e:	5d                   	pop    %ebp
  80158f:	c3                   	ret    

00801590 <seek>:

int
seek(int fdnum, off_t offset)
{
  801590:	55                   	push   %ebp
  801591:	89 e5                	mov    %esp,%ebp
  801593:	83 ec 18             	sub    $0x18,%esp
	int r;
	struct Fd *fd;

	if ((r = fd_lookup(fdnum, &fd)) < 0)
  801596:	8d 45 fc             	lea    -0x4(%ebp),%eax
  801599:	89 44 24 04          	mov    %eax,0x4(%esp)
  80159d:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a0:	89 04 24             	mov    %eax,(%esp)
  8015a3:	e8 c3 fb ff ff       	call   80116b <fd_lookup>
  8015a8:	85 c0                	test   %eax,%eax
  8015aa:	78 0e                	js     8015ba <seek+0x2a>
		return r;
	fd->fd_offset = offset;
  8015ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015b2:	89 50 04             	mov    %edx,0x4(%eax)
	return 0;
  8015b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ba:	c9                   	leave  
  8015bb:	c3                   	ret    

008015bc <ftruncate>:

int
ftruncate(int fdnum, off_t newsize)
{
  8015bc:	55                   	push   %ebp
  8015bd:	89 e5                	mov    %esp,%ebp
  8015bf:	53                   	push   %ebx
  8015c0:	83 ec 24             	sub    $0x24,%esp
  8015c3:	8b 5d 08             	mov    0x8(%ebp),%ebx
	int r;
	struct Dev *dev;
	struct Fd *fd;
	if ((r = fd_lookup(fdnum, &fd)) < 0
  8015c6:	8d 45 f0             	lea    -0x10(%ebp),%eax
  8015c9:	89 44 24 04          	mov    %eax,0x4(%esp)
  8015cd:	89 1c 24             	mov    %ebx,(%esp)
  8015d0:	e8 96 fb ff ff       	call   80116b <fd_lookup>
  8015d5:	89 c2                	mov    %eax,%edx
  8015d7:	85 d2                	test   %edx,%edx
  8015d9:	78 61                	js     80163c <ftruncate+0x80>
	    || (r = dev_lookup(fd->fd_dev_id, &dev)) < 0)
  8015db:	8d 45 f4             	lea    -0xc(%ebp),%eax
  8015de:	89 44 24 04          	mov    %eax,0x4(%esp)
  8015e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015e5:	8b 00                	mov    (%eax),%eax
  8015e7:	89 04 24             	mov    %eax,(%esp)
  8015ea:	e8 d2 fb ff ff       	call   8011c1 <dev_lookup>
  8015ef:	85 c0                	test   %eax,%eax
  8015f1:	78 49                	js     80163c <ftruncate+0x80>
		return r;
	if ((fd->fd_omode & O_ACCMODE) == O_RDONLY) {
  8015f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015f6:	f6 40 08 03          	testb  $0x3,0x8(%eax)
  8015fa:	75 23                	jne    80161f <ftruncate+0x63>
		cprintf("[%08x] ftruncate %d -- bad mode\n",
			thisenv->env_id, fdnum);
  8015fc:	a1 08 40 80 00       	mov    0x804008,%eax
	struct Fd *fd;
	if ((r = fd_lookup(fdnum, &fd)) < 0
	    || (r = dev_lookup(fd->fd_dev_id, &dev)) < 0)
		return r;
	if ((fd->fd_omode & O_ACCMODE) == O_RDONLY) {
		cprintf("[%08x] ftruncate %d -- bad mode\n",
  801601:	8b 40 48             	mov    0x48(%eax),%eax
  801604:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801608:	89 44 24 04          	mov    %eax,0x4(%esp)
  80160c:	c7 04 24 ac 27 80 00 	movl   $0x8027ac,(%esp)
  801613:	e8 3e ed ff ff       	call   800356 <cprintf>
			thisenv->env_id, fdnum);
		return -E_INVAL;
  801618:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  80161d:	eb 1d                	jmp    80163c <ftruncate+0x80>
	}
	if (!dev->dev_trunc)
  80161f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801622:	8b 52 18             	mov    0x18(%edx),%edx
  801625:	85 d2                	test   %edx,%edx
  801627:	74 0e                	je     801637 <ftruncate+0x7b>
		return -E_NOT_SUPP;
	return (*dev->dev_trunc)(fd, newsize);
  801629:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80162c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801630:	89 04 24             	mov    %eax,(%esp)
  801633:	ff d2                	call   *%edx
  801635:	eb 05                	jmp    80163c <ftruncate+0x80>
		cprintf("[%08x] ftruncate %d -- bad mode\n",
			thisenv->env_id, fdnum);
		return -E_INVAL;
	}
	if (!dev->dev_trunc)
		return -E_NOT_SUPP;
  801637:	b8 f1 ff ff ff       	mov    $0xfffffff1,%eax
	return (*dev->dev_trunc)(fd, newsize);
}
  80163c:	83 c4 24             	add    $0x24,%esp
  80163f:	5b                   	pop    %ebx
  801640:	5d                   	pop    %ebp
  801641:	c3                   	ret    

00801642 <fstat>:

int
fstat(int fdnum, struct Stat *stat)
{
  801642:	55                   	push   %ebp
  801643:	89 e5                	mov    %esp,%ebp
  801645:	53                   	push   %ebx
  801646:	83 ec 24             	sub    $0x24,%esp
  801649:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	int r;
	struct Dev *dev;
	struct Fd *fd;

	if ((r = fd_lookup(fdnum, &fd)) < 0
  80164c:	8d 45 f0             	lea    -0x10(%ebp),%eax
  80164f:	89 44 24 04          	mov    %eax,0x4(%esp)
  801653:	8b 45 08             	mov    0x8(%ebp),%eax
  801656:	89 04 24             	mov    %eax,(%esp)
  801659:	e8 0d fb ff ff       	call   80116b <fd_lookup>
  80165e:	89 c2                	mov    %eax,%edx
  801660:	85 d2                	test   %edx,%edx
  801662:	78 52                	js     8016b6 <fstat+0x74>
	    || (r = dev_lookup(fd->fd_dev_id, &dev)) < 0)
  801664:	8d 45 f4             	lea    -0xc(%ebp),%eax
  801667:	89 44 24 04          	mov    %eax,0x4(%esp)
  80166b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80166e:	8b 00                	mov    (%eax),%eax
  801670:	89 04 24             	mov    %eax,(%esp)
  801673:	e8 49 fb ff ff       	call   8011c1 <dev_lookup>
  801678:	85 c0                	test   %eax,%eax
  80167a:	78 3a                	js     8016b6 <fstat+0x74>
		return r;
	if (!dev->dev_stat)
  80167c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80167f:	83 78 14 00          	cmpl   $0x0,0x14(%eax)
  801683:	74 2c                	je     8016b1 <fstat+0x6f>
		return -E_NOT_SUPP;
	stat->st_name[0] = 0;
  801685:	c6 03 00             	movb   $0x0,(%ebx)
	stat->st_size = 0;
  801688:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
  80168f:	00 00 00 
	stat->st_isdir = 0;
  801692:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
  801699:	00 00 00 
	stat->st_dev = dev;
  80169c:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
	return (*dev->dev_stat)(fd, stat);
  8016a2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  8016a6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8016a9:	89 14 24             	mov    %edx,(%esp)
  8016ac:	ff 50 14             	call   *0x14(%eax)
  8016af:	eb 05                	jmp    8016b6 <fstat+0x74>

	if ((r = fd_lookup(fdnum, &fd)) < 0
	    || (r = dev_lookup(fd->fd_dev_id, &dev)) < 0)
		return r;
	if (!dev->dev_stat)
		return -E_NOT_SUPP;
  8016b1:	b8 f1 ff ff ff       	mov    $0xfffffff1,%eax
	stat->st_name[0] = 0;
	stat->st_size = 0;
	stat->st_isdir = 0;
	stat->st_dev = dev;
	return (*dev->dev_stat)(fd, stat);
}
  8016b6:	83 c4 24             	add    $0x24,%esp
  8016b9:	5b                   	pop    %ebx
  8016ba:	5d                   	pop    %ebp
  8016bb:	c3                   	ret    

008016bc <stat>:

int
stat(const char *path, struct Stat *stat)
{
  8016bc:	55                   	push   %ebp
  8016bd:	89 e5                	mov    %esp,%ebp
  8016bf:	56                   	push   %esi
  8016c0:	53                   	push   %ebx
  8016c1:	83 ec 10             	sub    $0x10,%esp
	int fd, r;

	if ((fd = open(path, O_RDONLY)) < 0)
  8016c4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  8016cb:	00 
  8016cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cf:	89 04 24             	mov    %eax,(%esp)
  8016d2:	e8 e1 01 00 00       	call   8018b8 <open>
  8016d7:	89 c3                	mov    %eax,%ebx
  8016d9:	85 db                	test   %ebx,%ebx
  8016db:	78 1b                	js     8016f8 <stat+0x3c>
		return fd;
	r = fstat(fd, stat);
  8016dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8016e4:	89 1c 24             	mov    %ebx,(%esp)
  8016e7:	e8 56 ff ff ff       	call   801642 <fstat>
  8016ec:	89 c6                	mov    %eax,%esi
	close(fd);
  8016ee:	89 1c 24             	mov    %ebx,(%esp)
  8016f1:	e8 bd fb ff ff       	call   8012b3 <close>
	return r;
  8016f6:	89 f0                	mov    %esi,%eax
}
  8016f8:	83 c4 10             	add    $0x10,%esp
  8016fb:	5b                   	pop    %ebx
  8016fc:	5e                   	pop    %esi
  8016fd:	5d                   	pop    %ebp
  8016fe:	c3                   	ret    

008016ff <fsipc>:
// type: request code, passed as the simple integer IPC value.
// dstva: virtual address at which to receive reply page, 0 if none.
// Returns result from the file server.
static int
fsipc(unsigned type, void *dstva)
{
  8016ff:	55                   	push   %ebp
  801700:	89 e5                	mov    %esp,%ebp
  801702:	56                   	push   %esi
  801703:	53                   	push   %ebx
  801704:	83 ec 10             	sub    $0x10,%esp
  801707:	89 c3                	mov    %eax,%ebx
  801709:	89 d6                	mov    %edx,%esi
	static envid_t fsenv;
	if (fsenv == 0)
  80170b:	83 3d 04 40 80 00 00 	cmpl   $0x0,0x804004
  801712:	75 11                	jne    801725 <fsipc+0x26>
		fsenv = ipc_find_env(ENV_TYPE_FS);
  801714:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  80171b:	e8 94 09 00 00       	call   8020b4 <ipc_find_env>
  801720:	a3 04 40 80 00       	mov    %eax,0x804004

	static_assert(sizeof(fsipcbuf) == PGSIZE);

	if (debug)
		cprintf("[%08x] fsipc %d %08x\n", thisenv->env_id, type, *(uint32_t *)&fsipcbuf);
  801725:	a1 08 40 80 00       	mov    0x804008,%eax
  80172a:	8b 40 48             	mov    0x48(%eax),%eax
  80172d:	8b 15 00 50 80 00    	mov    0x805000,%edx
  801733:	89 54 24 0c          	mov    %edx,0xc(%esp)
  801737:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80173b:	89 44 24 04          	mov    %eax,0x4(%esp)
  80173f:	c7 04 24 09 28 80 00 	movl   $0x802809,(%esp)
  801746:	e8 0b ec ff ff       	call   800356 <cprintf>

	ipc_send(fsenv, type, &fsipcbuf, PTE_P | PTE_W | PTE_U);
  80174b:	c7 44 24 0c 07 00 00 	movl   $0x7,0xc(%esp)
  801752:	00 
  801753:	c7 44 24 08 00 50 80 	movl   $0x805000,0x8(%esp)
  80175a:	00 
  80175b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  80175f:	a1 04 40 80 00       	mov    0x804004,%eax
  801764:	89 04 24             	mov    %eax,(%esp)
  801767:	e8 e2 08 00 00       	call   80204e <ipc_send>
	cprintf("ipc_send\n");
  80176c:	c7 04 24 1f 28 80 00 	movl   $0x80281f,(%esp)
  801773:	e8 de eb ff ff       	call   800356 <cprintf>
	return ipc_recv(NULL, dstva, NULL);
  801778:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  80177f:	00 
  801780:	89 74 24 04          	mov    %esi,0x4(%esp)
  801784:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  80178b:	e8 56 08 00 00       	call   801fe6 <ipc_recv>
}
  801790:	83 c4 10             	add    $0x10,%esp
  801793:	5b                   	pop    %ebx
  801794:	5e                   	pop    %esi
  801795:	5d                   	pop    %ebp
  801796:	c3                   	ret    

00801797 <devfile_stat>:
}


static int
devfile_stat(struct Fd *fd, struct Stat *st)
{
  801797:	55                   	push   %ebp
  801798:	89 e5                	mov    %esp,%ebp
  80179a:	53                   	push   %ebx
  80179b:	83 ec 14             	sub    $0x14,%esp
  80179e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	int r;

	fsipcbuf.stat.req_fileid = fd->fd_file.id;
  8017a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a4:	8b 40 0c             	mov    0xc(%eax),%eax
  8017a7:	a3 00 50 80 00       	mov    %eax,0x805000
	if ((r = fsipc(FSREQ_STAT, NULL)) < 0)
  8017ac:	ba 00 00 00 00       	mov    $0x0,%edx
  8017b1:	b8 05 00 00 00       	mov    $0x5,%eax
  8017b6:	e8 44 ff ff ff       	call   8016ff <fsipc>
  8017bb:	89 c2                	mov    %eax,%edx
  8017bd:	85 d2                	test   %edx,%edx
  8017bf:	78 2b                	js     8017ec <devfile_stat+0x55>
		return r;
	strcpy(st->st_name, fsipcbuf.statRet.ret_name);
  8017c1:	c7 44 24 04 00 50 80 	movl   $0x805000,0x4(%esp)
  8017c8:	00 
  8017c9:	89 1c 24             	mov    %ebx,(%esp)
  8017cc:	e8 da f1 ff ff       	call   8009ab <strcpy>
	st->st_size = fsipcbuf.statRet.ret_size;
  8017d1:	a1 80 50 80 00       	mov    0x805080,%eax
  8017d6:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
	st->st_isdir = fsipcbuf.statRet.ret_isdir;
  8017dc:	a1 84 50 80 00       	mov    0x805084,%eax
  8017e1:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
	return 0;
  8017e7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017ec:	83 c4 14             	add    $0x14,%esp
  8017ef:	5b                   	pop    %ebx
  8017f0:	5d                   	pop    %ebp
  8017f1:	c3                   	ret    

008017f2 <devfile_flush>:
// open, unmapping it is enough to free up server-side resources.
// Other than that, we just have to make sure our changes are flushed
// to disk.
static int
devfile_flush(struct Fd *fd)
{
  8017f2:	55                   	push   %ebp
  8017f3:	89 e5                	mov    %esp,%ebp
  8017f5:	83 ec 08             	sub    $0x8,%esp
	fsipcbuf.flush.req_fileid = fd->fd_file.id;
  8017f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fb:	8b 40 0c             	mov    0xc(%eax),%eax
  8017fe:	a3 00 50 80 00       	mov    %eax,0x805000
	return fsipc(FSREQ_FLUSH, NULL);
  801803:	ba 00 00 00 00       	mov    $0x0,%edx
  801808:	b8 06 00 00 00       	mov    $0x6,%eax
  80180d:	e8 ed fe ff ff       	call   8016ff <fsipc>
}
  801812:	c9                   	leave  
  801813:	c3                   	ret    

00801814 <devfile_read>:
// Returns:
// 	The number of bytes successfully read.
// 	< 0 on error.
static ssize_t
devfile_read(struct Fd *fd, void *buf, size_t n)
{
  801814:	55                   	push   %ebp
  801815:	89 e5                	mov    %esp,%ebp
  801817:	56                   	push   %esi
  801818:	53                   	push   %ebx
  801819:	83 ec 10             	sub    $0x10,%esp
  80181c:	8b 75 10             	mov    0x10(%ebp),%esi
	// filling fsipcbuf.read with the request arguments.  The
	// bytes read will be written back to fsipcbuf by the file
	// system server.
	int r;

	fsipcbuf.read.req_fileid = fd->fd_file.id;
  80181f:	8b 45 08             	mov    0x8(%ebp),%eax
  801822:	8b 40 0c             	mov    0xc(%eax),%eax
  801825:	a3 00 50 80 00       	mov    %eax,0x805000
	fsipcbuf.read.req_n = n;
  80182a:	89 35 04 50 80 00    	mov    %esi,0x805004
	if ((r = fsipc(FSREQ_READ, NULL)) < 0)
  801830:	ba 00 00 00 00       	mov    $0x0,%edx
  801835:	b8 03 00 00 00       	mov    $0x3,%eax
  80183a:	e8 c0 fe ff ff       	call   8016ff <fsipc>
  80183f:	89 c3                	mov    %eax,%ebx
  801841:	85 c0                	test   %eax,%eax
  801843:	78 6a                	js     8018af <devfile_read+0x9b>
		return r;
	assert(r <= n);
  801845:	39 c6                	cmp    %eax,%esi
  801847:	73 24                	jae    80186d <devfile_read+0x59>
  801849:	c7 44 24 0c 29 28 80 	movl   $0x802829,0xc(%esp)
  801850:	00 
  801851:	c7 44 24 08 30 28 80 	movl   $0x802830,0x8(%esp)
  801858:	00 
  801859:	c7 44 24 04 7a 00 00 	movl   $0x7a,0x4(%esp)
  801860:	00 
  801861:	c7 04 24 45 28 80 00 	movl   $0x802845,(%esp)
  801868:	e8 f0 e9 ff ff       	call   80025d <_panic>
	assert(r <= PGSIZE);
  80186d:	3d 00 10 00 00       	cmp    $0x1000,%eax
  801872:	7e 24                	jle    801898 <devfile_read+0x84>
  801874:	c7 44 24 0c 50 28 80 	movl   $0x802850,0xc(%esp)
  80187b:	00 
  80187c:	c7 44 24 08 30 28 80 	movl   $0x802830,0x8(%esp)
  801883:	00 
  801884:	c7 44 24 04 7b 00 00 	movl   $0x7b,0x4(%esp)
  80188b:	00 
  80188c:	c7 04 24 45 28 80 00 	movl   $0x802845,(%esp)
  801893:	e8 c5 e9 ff ff       	call   80025d <_panic>
	memmove(buf, &fsipcbuf, r);
  801898:	89 44 24 08          	mov    %eax,0x8(%esp)
  80189c:	c7 44 24 04 00 50 80 	movl   $0x805000,0x4(%esp)
  8018a3:	00 
  8018a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a7:	89 04 24             	mov    %eax,(%esp)
  8018aa:	e8 f7 f2 ff ff       	call   800ba6 <memmove>
	return r;
}
  8018af:	89 d8                	mov    %ebx,%eax
  8018b1:	83 c4 10             	add    $0x10,%esp
  8018b4:	5b                   	pop    %ebx
  8018b5:	5e                   	pop    %esi
  8018b6:	5d                   	pop    %ebp
  8018b7:	c3                   	ret    

008018b8 <open>:
// 	The file descriptor index on success
// 	-E_BAD_PATH if the path is too long (>= MAXPATHLEN)
// 	< 0 for other errors.
int
open(const char *path, int mode)
{
  8018b8:	55                   	push   %ebp
  8018b9:	89 e5                	mov    %esp,%ebp
  8018bb:	53                   	push   %ebx
  8018bc:	83 ec 24             	sub    $0x24,%esp
  8018bf:	8b 5d 08             	mov    0x8(%ebp),%ebx
	// file descriptor.

	int r;
	struct Fd *fd;

	if (strlen(path) >= MAXPATHLEN)
  8018c2:	89 1c 24             	mov    %ebx,(%esp)
  8018c5:	e8 86 f0 ff ff       	call   800950 <strlen>
  8018ca:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  8018cf:	7f 60                	jg     801931 <open+0x79>
		return -E_BAD_PATH;

	if ((r = fd_alloc(&fd)) < 0)
  8018d1:	8d 45 f4             	lea    -0xc(%ebp),%eax
  8018d4:	89 04 24             	mov    %eax,(%esp)
  8018d7:	e8 1b f8 ff ff       	call   8010f7 <fd_alloc>
  8018dc:	89 c2                	mov    %eax,%edx
  8018de:	85 d2                	test   %edx,%edx
  8018e0:	78 54                	js     801936 <open+0x7e>
		return r;

	strcpy(fsipcbuf.open.req_path, path);
  8018e2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  8018e6:	c7 04 24 00 50 80 00 	movl   $0x805000,(%esp)
  8018ed:	e8 b9 f0 ff ff       	call   8009ab <strcpy>
	fsipcbuf.open.req_omode = mode;
  8018f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018f5:	a3 00 54 80 00       	mov    %eax,0x805400

	if ((r = fsipc(FSREQ_OPEN, fd)) < 0) {
  8018fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018fd:	b8 01 00 00 00       	mov    $0x1,%eax
  801902:	e8 f8 fd ff ff       	call   8016ff <fsipc>
  801907:	89 c3                	mov    %eax,%ebx
  801909:	85 c0                	test   %eax,%eax
  80190b:	79 17                	jns    801924 <open+0x6c>
		fd_close(fd, 0);
  80190d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  801914:	00 
  801915:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801918:	89 04 24             	mov    %eax,(%esp)
  80191b:	e8 12 f9 ff ff       	call   801232 <fd_close>
		return r;
  801920:	89 d8                	mov    %ebx,%eax
  801922:	eb 12                	jmp    801936 <open+0x7e>
	}
	return fd2num(fd);
  801924:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801927:	89 04 24             	mov    %eax,(%esp)
  80192a:	e8 a1 f7 ff ff       	call   8010d0 <fd2num>
  80192f:	eb 05                	jmp    801936 <open+0x7e>

	int r;
	struct Fd *fd;

	if (strlen(path) >= MAXPATHLEN)
		return -E_BAD_PATH;
  801931:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
	if ((r = fsipc(FSREQ_OPEN, fd)) < 0) {
		fd_close(fd, 0);
		return r;
	}
	return fd2num(fd);
}
  801936:	83 c4 24             	add    $0x24,%esp
  801939:	5b                   	pop    %ebx
  80193a:	5d                   	pop    %ebp
  80193b:	c3                   	ret    

0080193c <writebuf>:
};


static void
writebuf(struct printbuf *b)
{
  80193c:	55                   	push   %ebp
  80193d:	89 e5                	mov    %esp,%ebp
  80193f:	53                   	push   %ebx
  801940:	83 ec 14             	sub    $0x14,%esp
  801943:	89 c3                	mov    %eax,%ebx
	if (b->error > 0) {
  801945:	83 78 0c 00          	cmpl   $0x0,0xc(%eax)
  801949:	7e 31                	jle    80197c <writebuf+0x40>
		ssize_t result = write(b->fd, b->buf, b->idx);
  80194b:	8b 40 04             	mov    0x4(%eax),%eax
  80194e:	89 44 24 08          	mov    %eax,0x8(%esp)
  801952:	8d 43 10             	lea    0x10(%ebx),%eax
  801955:	89 44 24 04          	mov    %eax,0x4(%esp)
  801959:	8b 03                	mov    (%ebx),%eax
  80195b:	89 04 24             	mov    %eax,(%esp)
  80195e:	e8 a0 fb ff ff       	call   801503 <write>
		if (result > 0)
  801963:	85 c0                	test   %eax,%eax
  801965:	7e 03                	jle    80196a <writebuf+0x2e>
			b->result += result;
  801967:	01 43 08             	add    %eax,0x8(%ebx)
		if (result != b->idx) // error, or wrote less than supplied
  80196a:	39 43 04             	cmp    %eax,0x4(%ebx)
  80196d:	74 0d                	je     80197c <writebuf+0x40>
			b->error = (result < 0 ? result : 0);
  80196f:	85 c0                	test   %eax,%eax
  801971:	ba 00 00 00 00       	mov    $0x0,%edx
  801976:	0f 4f c2             	cmovg  %edx,%eax
  801979:	89 43 0c             	mov    %eax,0xc(%ebx)
	}
}
  80197c:	83 c4 14             	add    $0x14,%esp
  80197f:	5b                   	pop    %ebx
  801980:	5d                   	pop    %ebp
  801981:	c3                   	ret    

00801982 <putch>:

static void
putch(int ch, void *thunk)
{
  801982:	55                   	push   %ebp
  801983:	89 e5                	mov    %esp,%ebp
  801985:	53                   	push   %ebx
  801986:	83 ec 04             	sub    $0x4,%esp
  801989:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	struct printbuf *b = (struct printbuf *) thunk;
	b->buf[b->idx++] = ch;
  80198c:	8b 53 04             	mov    0x4(%ebx),%edx
  80198f:	8d 42 01             	lea    0x1(%edx),%eax
  801992:	89 43 04             	mov    %eax,0x4(%ebx)
  801995:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801998:	88 4c 13 10          	mov    %cl,0x10(%ebx,%edx,1)
	if (b->idx == 256) {
  80199c:	3d 00 01 00 00       	cmp    $0x100,%eax
  8019a1:	75 0e                	jne    8019b1 <putch+0x2f>
		writebuf(b);
  8019a3:	89 d8                	mov    %ebx,%eax
  8019a5:	e8 92 ff ff ff       	call   80193c <writebuf>
		b->idx = 0;
  8019aa:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
	}
}
  8019b1:	83 c4 04             	add    $0x4,%esp
  8019b4:	5b                   	pop    %ebx
  8019b5:	5d                   	pop    %ebp
  8019b6:	c3                   	ret    

008019b7 <vfprintf>:

int
vfprintf(int fd, const char *fmt, va_list ap)
{
  8019b7:	55                   	push   %ebp
  8019b8:	89 e5                	mov    %esp,%ebp
  8019ba:	81 ec 28 01 00 00    	sub    $0x128,%esp
	struct printbuf b;

	b.fd = fd;
  8019c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c3:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
	b.idx = 0;
  8019c9:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
  8019d0:	00 00 00 
	b.result = 0;
  8019d3:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8019da:	00 00 00 
	b.error = 1;
  8019dd:	c7 85 f4 fe ff ff 01 	movl   $0x1,-0x10c(%ebp)
  8019e4:	00 00 00 
	vprintfmt(putch, &b, fmt, ap);
  8019e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ea:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8019ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019f1:	89 44 24 08          	mov    %eax,0x8(%esp)
  8019f5:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
  8019fb:	89 44 24 04          	mov    %eax,0x4(%esp)
  8019ff:	c7 04 24 82 19 80 00 	movl   $0x801982,(%esp)
  801a06:	e8 d9 ea ff ff       	call   8004e4 <vprintfmt>
	if (b.idx > 0)
  801a0b:	83 bd ec fe ff ff 00 	cmpl   $0x0,-0x114(%ebp)
  801a12:	7e 0b                	jle    801a1f <vfprintf+0x68>
		writebuf(&b);
  801a14:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
  801a1a:	e8 1d ff ff ff       	call   80193c <writebuf>

	return (b.result ? b.result : b.error);
  801a1f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  801a25:	85 c0                	test   %eax,%eax
  801a27:	0f 44 85 f4 fe ff ff 	cmove  -0x10c(%ebp),%eax
}
  801a2e:	c9                   	leave  
  801a2f:	c3                   	ret    

00801a30 <fprintf>:

int
fprintf(int fd, const char *fmt, ...)
{
  801a30:	55                   	push   %ebp
  801a31:	89 e5                	mov    %esp,%ebp
  801a33:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801a36:	8d 45 10             	lea    0x10(%ebp),%eax
	cnt = vfprintf(fd, fmt, ap);
  801a39:	89 44 24 08          	mov    %eax,0x8(%esp)
  801a3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a40:	89 44 24 04          	mov    %eax,0x4(%esp)
  801a44:	8b 45 08             	mov    0x8(%ebp),%eax
  801a47:	89 04 24             	mov    %eax,(%esp)
  801a4a:	e8 68 ff ff ff       	call   8019b7 <vfprintf>
	va_end(ap);

	return cnt;
}
  801a4f:	c9                   	leave  
  801a50:	c3                   	ret    

00801a51 <printf>:

int
printf(const char *fmt, ...)
{
  801a51:	55                   	push   %ebp
  801a52:	89 e5                	mov    %esp,%ebp
  801a54:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801a57:	8d 45 0c             	lea    0xc(%ebp),%eax
	cnt = vfprintf(1, fmt, ap);
  801a5a:	89 44 24 08          	mov    %eax,0x8(%esp)
  801a5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a61:	89 44 24 04          	mov    %eax,0x4(%esp)
  801a65:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  801a6c:	e8 46 ff ff ff       	call   8019b7 <vfprintf>
	va_end(ap);

	return cnt;
}
  801a71:	c9                   	leave  
  801a72:	c3                   	ret    
  801a73:	66 90                	xchg   %ax,%ax
  801a75:	66 90                	xchg   %ax,%ax
  801a77:	66 90                	xchg   %ax,%ax
  801a79:	66 90                	xchg   %ax,%ax
  801a7b:	66 90                	xchg   %ax,%ax
  801a7d:	66 90                	xchg   %ax,%ax
  801a7f:	90                   	nop

00801a80 <devpipe_stat>:
	return i;
}

static int
devpipe_stat(struct Fd *fd, struct Stat *stat)
{
  801a80:	55                   	push   %ebp
  801a81:	89 e5                	mov    %esp,%ebp
  801a83:	56                   	push   %esi
  801a84:	53                   	push   %ebx
  801a85:	83 ec 10             	sub    $0x10,%esp
  801a88:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	struct Pipe *p = (struct Pipe*) fd2data(fd);
  801a8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8e:	89 04 24             	mov    %eax,(%esp)
  801a91:	e8 4a f6 ff ff       	call   8010e0 <fd2data>
  801a96:	89 c6                	mov    %eax,%esi
	strcpy(stat->st_name, "<pipe>");
  801a98:	c7 44 24 04 5c 28 80 	movl   $0x80285c,0x4(%esp)
  801a9f:	00 
  801aa0:	89 1c 24             	mov    %ebx,(%esp)
  801aa3:	e8 03 ef ff ff       	call   8009ab <strcpy>
	stat->st_size = p->p_wpos - p->p_rpos;
  801aa8:	8b 46 04             	mov    0x4(%esi),%eax
  801aab:	2b 06                	sub    (%esi),%eax
  801aad:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
	stat->st_isdir = 0;
  801ab3:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
  801aba:	00 00 00 
	stat->st_dev = &devpipe;
  801abd:	c7 83 88 00 00 00 24 	movl   $0x803024,0x88(%ebx)
  801ac4:	30 80 00 
	return 0;
}
  801ac7:	b8 00 00 00 00       	mov    $0x0,%eax
  801acc:	83 c4 10             	add    $0x10,%esp
  801acf:	5b                   	pop    %ebx
  801ad0:	5e                   	pop    %esi
  801ad1:	5d                   	pop    %ebp
  801ad2:	c3                   	ret    

00801ad3 <devpipe_close>:

static int
devpipe_close(struct Fd *fd)
{
  801ad3:	55                   	push   %ebp
  801ad4:	89 e5                	mov    %esp,%ebp
  801ad6:	53                   	push   %ebx
  801ad7:	83 ec 14             	sub    $0x14,%esp
  801ada:	8b 5d 08             	mov    0x8(%ebp),%ebx
	(void) sys_page_unmap(0, fd);
  801add:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  801ae1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  801ae8:	e8 13 f4 ff ff       	call   800f00 <sys_page_unmap>
	return sys_page_unmap(0, fd2data(fd));
  801aed:	89 1c 24             	mov    %ebx,(%esp)
  801af0:	e8 eb f5 ff ff       	call   8010e0 <fd2data>
  801af5:	89 44 24 04          	mov    %eax,0x4(%esp)
  801af9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  801b00:	e8 fb f3 ff ff       	call   800f00 <sys_page_unmap>
}
  801b05:	83 c4 14             	add    $0x14,%esp
  801b08:	5b                   	pop    %ebx
  801b09:	5d                   	pop    %ebp
  801b0a:	c3                   	ret    

00801b0b <_pipeisclosed>:
	return r;
}

static int
_pipeisclosed(struct Fd *fd, struct Pipe *p)
{
  801b0b:	55                   	push   %ebp
  801b0c:	89 e5                	mov    %esp,%ebp
  801b0e:	57                   	push   %edi
  801b0f:	56                   	push   %esi
  801b10:	53                   	push   %ebx
  801b11:	83 ec 2c             	sub    $0x2c,%esp
  801b14:	89 c6                	mov    %eax,%esi
  801b16:	89 55 e4             	mov    %edx,-0x1c(%ebp)
	int n, nn, ret;

	while (1) {
		n = thisenv->env_runs;
  801b19:	a1 08 40 80 00       	mov    0x804008,%eax
  801b1e:	8b 58 58             	mov    0x58(%eax),%ebx
		ret = pageref(fd) == pageref(p);
  801b21:	89 34 24             	mov    %esi,(%esp)
  801b24:	e8 d3 05 00 00       	call   8020fc <pageref>
  801b29:	89 c7                	mov    %eax,%edi
  801b2b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b2e:	89 04 24             	mov    %eax,(%esp)
  801b31:	e8 c6 05 00 00       	call   8020fc <pageref>
  801b36:	39 c7                	cmp    %eax,%edi
  801b38:	0f 94 c2             	sete   %dl
  801b3b:	0f b6 c2             	movzbl %dl,%eax
		nn = thisenv->env_runs;
  801b3e:	8b 0d 08 40 80 00    	mov    0x804008,%ecx
  801b44:	8b 79 58             	mov    0x58(%ecx),%edi
		if (n == nn)
  801b47:	39 fb                	cmp    %edi,%ebx
  801b49:	74 21                	je     801b6c <_pipeisclosed+0x61>
			return ret;
		if (n != nn && ret == 1)
  801b4b:	84 d2                	test   %dl,%dl
  801b4d:	74 ca                	je     801b19 <_pipeisclosed+0xe>
			cprintf("pipe race avoided\n", n, thisenv->env_runs, ret);
  801b4f:	8b 51 58             	mov    0x58(%ecx),%edx
  801b52:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b56:	89 54 24 08          	mov    %edx,0x8(%esp)
  801b5a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  801b5e:	c7 04 24 63 28 80 00 	movl   $0x802863,(%esp)
  801b65:	e8 ec e7 ff ff       	call   800356 <cprintf>
  801b6a:	eb ad                	jmp    801b19 <_pipeisclosed+0xe>
	}
}
  801b6c:	83 c4 2c             	add    $0x2c,%esp
  801b6f:	5b                   	pop    %ebx
  801b70:	5e                   	pop    %esi
  801b71:	5f                   	pop    %edi
  801b72:	5d                   	pop    %ebp
  801b73:	c3                   	ret    

00801b74 <devpipe_write>:
	return i;
}

static ssize_t
devpipe_write(struct Fd *fd, const void *vbuf, size_t n)
{
  801b74:	55                   	push   %ebp
  801b75:	89 e5                	mov    %esp,%ebp
  801b77:	57                   	push   %edi
  801b78:	56                   	push   %esi
  801b79:	53                   	push   %ebx
  801b7a:	83 ec 1c             	sub    $0x1c,%esp
  801b7d:	8b 75 08             	mov    0x8(%ebp),%esi
	const uint8_t *buf;
	size_t i;
	struct Pipe *p;

	p = (struct Pipe*) fd2data(fd);
  801b80:	89 34 24             	mov    %esi,(%esp)
  801b83:	e8 58 f5 ff ff       	call   8010e0 <fd2data>
	if (debug)
		cprintf("[%08x] devpipe_write %08x %d rpos %d wpos %d\n",
			thisenv->env_id, uvpt[PGNUM(p)], n, p->p_rpos, p->p_wpos);

	buf = vbuf;
	for (i = 0; i < n; i++) {
  801b88:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801b8c:	74 61                	je     801bef <devpipe_write+0x7b>
  801b8e:	89 c3                	mov    %eax,%ebx
  801b90:	bf 00 00 00 00       	mov    $0x0,%edi
  801b95:	eb 4a                	jmp    801be1 <devpipe_write+0x6d>
		while (p->p_wpos >= p->p_rpos + sizeof(p->p_buf)) {
			// pipe is full
			// if all the readers are gone
			// (it's only writers like us now),
			// note eof
			if (_pipeisclosed(fd, p))
  801b97:	89 da                	mov    %ebx,%edx
  801b99:	89 f0                	mov    %esi,%eax
  801b9b:	e8 6b ff ff ff       	call   801b0b <_pipeisclosed>
  801ba0:	85 c0                	test   %eax,%eax
  801ba2:	75 54                	jne    801bf8 <devpipe_write+0x84>
				return 0;
			// yield and see what happens
			if (debug)
				cprintf("devpipe_write yield\n");
			sys_yield();
  801ba4:	e8 91 f2 ff ff       	call   800e3a <sys_yield>
		cprintf("[%08x] devpipe_write %08x %d rpos %d wpos %d\n",
			thisenv->env_id, uvpt[PGNUM(p)], n, p->p_rpos, p->p_wpos);

	buf = vbuf;
	for (i = 0; i < n; i++) {
		while (p->p_wpos >= p->p_rpos + sizeof(p->p_buf)) {
  801ba9:	8b 43 04             	mov    0x4(%ebx),%eax
  801bac:	8b 0b                	mov    (%ebx),%ecx
  801bae:	8d 51 20             	lea    0x20(%ecx),%edx
  801bb1:	39 d0                	cmp    %edx,%eax
  801bb3:	73 e2                	jae    801b97 <devpipe_write+0x23>
				cprintf("devpipe_write yield\n");
			sys_yield();
		}
		// there's room for a byte.  store it.
		// wait to increment wpos until the byte is stored!
		p->p_buf[p->p_wpos % PIPEBUFSIZ] = buf[i];
  801bb5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  801bb8:	0f b6 0c 39          	movzbl (%ecx,%edi,1),%ecx
  801bbc:	88 4d e7             	mov    %cl,-0x19(%ebp)
  801bbf:	99                   	cltd   
  801bc0:	c1 ea 1b             	shr    $0x1b,%edx
  801bc3:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
  801bc6:	83 e1 1f             	and    $0x1f,%ecx
  801bc9:	29 d1                	sub    %edx,%ecx
  801bcb:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
  801bcf:	88 54 0b 08          	mov    %dl,0x8(%ebx,%ecx,1)
		p->p_wpos++;
  801bd3:	83 c0 01             	add    $0x1,%eax
  801bd6:	89 43 04             	mov    %eax,0x4(%ebx)
	if (debug)
		cprintf("[%08x] devpipe_write %08x %d rpos %d wpos %d\n",
			thisenv->env_id, uvpt[PGNUM(p)], n, p->p_rpos, p->p_wpos);

	buf = vbuf;
	for (i = 0; i < n; i++) {
  801bd9:	83 c7 01             	add    $0x1,%edi
  801bdc:	3b 7d 10             	cmp    0x10(%ebp),%edi
  801bdf:	74 13                	je     801bf4 <devpipe_write+0x80>
		while (p->p_wpos >= p->p_rpos + sizeof(p->p_buf)) {
  801be1:	8b 43 04             	mov    0x4(%ebx),%eax
  801be4:	8b 0b                	mov    (%ebx),%ecx
  801be6:	8d 51 20             	lea    0x20(%ecx),%edx
  801be9:	39 d0                	cmp    %edx,%eax
  801beb:	73 aa                	jae    801b97 <devpipe_write+0x23>
  801bed:	eb c6                	jmp    801bb5 <devpipe_write+0x41>
	if (debug)
		cprintf("[%08x] devpipe_write %08x %d rpos %d wpos %d\n",
			thisenv->env_id, uvpt[PGNUM(p)], n, p->p_rpos, p->p_wpos);

	buf = vbuf;
	for (i = 0; i < n; i++) {
  801bef:	bf 00 00 00 00       	mov    $0x0,%edi
		// wait to increment wpos until the byte is stored!
		p->p_buf[p->p_wpos % PIPEBUFSIZ] = buf[i];
		p->p_wpos++;
	}

	return i;
  801bf4:	89 f8                	mov    %edi,%eax
  801bf6:	eb 05                	jmp    801bfd <devpipe_write+0x89>
			// pipe is full
			// if all the readers are gone
			// (it's only writers like us now),
			// note eof
			if (_pipeisclosed(fd, p))
				return 0;
  801bf8:	b8 00 00 00 00       	mov    $0x0,%eax
		p->p_buf[p->p_wpos % PIPEBUFSIZ] = buf[i];
		p->p_wpos++;
	}

	return i;
}
  801bfd:	83 c4 1c             	add    $0x1c,%esp
  801c00:	5b                   	pop    %ebx
  801c01:	5e                   	pop    %esi
  801c02:	5f                   	pop    %edi
  801c03:	5d                   	pop    %ebp
  801c04:	c3                   	ret    

00801c05 <devpipe_read>:
	return _pipeisclosed(fd, p);
}

static ssize_t
devpipe_read(struct Fd *fd, void *vbuf, size_t n)
{
  801c05:	55                   	push   %ebp
  801c06:	89 e5                	mov    %esp,%ebp
  801c08:	57                   	push   %edi
  801c09:	56                   	push   %esi
  801c0a:	53                   	push   %ebx
  801c0b:	83 ec 1c             	sub    $0x1c,%esp
  801c0e:	8b 7d 08             	mov    0x8(%ebp),%edi
	uint8_t *buf;
	size_t i;
	struct Pipe *p;

	p = (struct Pipe*)fd2data(fd);
  801c11:	89 3c 24             	mov    %edi,(%esp)
  801c14:	e8 c7 f4 ff ff       	call   8010e0 <fd2data>
	if (debug)
		cprintf("[%08x] devpipe_read %08x %d rpos %d wpos %d\n",
			thisenv->env_id, uvpt[PGNUM(p)], n, p->p_rpos, p->p_wpos);

	buf = vbuf;
	for (i = 0; i < n; i++) {
  801c19:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801c1d:	74 54                	je     801c73 <devpipe_read+0x6e>
  801c1f:	89 c3                	mov    %eax,%ebx
  801c21:	be 00 00 00 00       	mov    $0x0,%esi
  801c26:	eb 3e                	jmp    801c66 <devpipe_read+0x61>
		while (p->p_rpos == p->p_wpos) {
			// pipe is empty
			// if we got any data, return it
			if (i > 0)
				return i;
  801c28:	89 f0                	mov    %esi,%eax
  801c2a:	eb 55                	jmp    801c81 <devpipe_read+0x7c>
			// if all the writers are gone, note eof
			if (_pipeisclosed(fd, p))
  801c2c:	89 da                	mov    %ebx,%edx
  801c2e:	89 f8                	mov    %edi,%eax
  801c30:	e8 d6 fe ff ff       	call   801b0b <_pipeisclosed>
  801c35:	85 c0                	test   %eax,%eax
  801c37:	75 43                	jne    801c7c <devpipe_read+0x77>
				return 0;
			// yield and see what happens
			if (debug)
				cprintf("devpipe_read yield\n");
			sys_yield();
  801c39:	e8 fc f1 ff ff       	call   800e3a <sys_yield>
		cprintf("[%08x] devpipe_read %08x %d rpos %d wpos %d\n",
			thisenv->env_id, uvpt[PGNUM(p)], n, p->p_rpos, p->p_wpos);

	buf = vbuf;
	for (i = 0; i < n; i++) {
		while (p->p_rpos == p->p_wpos) {
  801c3e:	8b 03                	mov    (%ebx),%eax
  801c40:	3b 43 04             	cmp    0x4(%ebx),%eax
  801c43:	74 e7                	je     801c2c <devpipe_read+0x27>
				cprintf("devpipe_read yield\n");
			sys_yield();
		}
		// there's a byte.  take it.
		// wait to increment rpos until the byte is taken!
		buf[i] = p->p_buf[p->p_rpos % PIPEBUFSIZ];
  801c45:	99                   	cltd   
  801c46:	c1 ea 1b             	shr    $0x1b,%edx
  801c49:	01 d0                	add    %edx,%eax
  801c4b:	83 e0 1f             	and    $0x1f,%eax
  801c4e:	29 d0                	sub    %edx,%eax
  801c50:	0f b6 44 03 08       	movzbl 0x8(%ebx,%eax,1),%eax
  801c55:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  801c58:	88 04 31             	mov    %al,(%ecx,%esi,1)
		p->p_rpos++;
  801c5b:	83 03 01             	addl   $0x1,(%ebx)
	if (debug)
		cprintf("[%08x] devpipe_read %08x %d rpos %d wpos %d\n",
			thisenv->env_id, uvpt[PGNUM(p)], n, p->p_rpos, p->p_wpos);

	buf = vbuf;
	for (i = 0; i < n; i++) {
  801c5e:	83 c6 01             	add    $0x1,%esi
  801c61:	3b 75 10             	cmp    0x10(%ebp),%esi
  801c64:	74 12                	je     801c78 <devpipe_read+0x73>
		while (p->p_rpos == p->p_wpos) {
  801c66:	8b 03                	mov    (%ebx),%eax
  801c68:	3b 43 04             	cmp    0x4(%ebx),%eax
  801c6b:	75 d8                	jne    801c45 <devpipe_read+0x40>
			// pipe is empty
			// if we got any data, return it
			if (i > 0)
  801c6d:	85 f6                	test   %esi,%esi
  801c6f:	75 b7                	jne    801c28 <devpipe_read+0x23>
  801c71:	eb b9                	jmp    801c2c <devpipe_read+0x27>
	if (debug)
		cprintf("[%08x] devpipe_read %08x %d rpos %d wpos %d\n",
			thisenv->env_id, uvpt[PGNUM(p)], n, p->p_rpos, p->p_wpos);

	buf = vbuf;
	for (i = 0; i < n; i++) {
  801c73:	be 00 00 00 00       	mov    $0x0,%esi
		// there's a byte.  take it.
		// wait to increment rpos until the byte is taken!
		buf[i] = p->p_buf[p->p_rpos % PIPEBUFSIZ];
		p->p_rpos++;
	}
	return i;
  801c78:	89 f0                	mov    %esi,%eax
  801c7a:	eb 05                	jmp    801c81 <devpipe_read+0x7c>
			// if we got any data, return it
			if (i > 0)
				return i;
			// if all the writers are gone, note eof
			if (_pipeisclosed(fd, p))
				return 0;
  801c7c:	b8 00 00 00 00       	mov    $0x0,%eax
		// wait to increment rpos until the byte is taken!
		buf[i] = p->p_buf[p->p_rpos % PIPEBUFSIZ];
		p->p_rpos++;
	}
	return i;
}
  801c81:	83 c4 1c             	add    $0x1c,%esp
  801c84:	5b                   	pop    %ebx
  801c85:	5e                   	pop    %esi
  801c86:	5f                   	pop    %edi
  801c87:	5d                   	pop    %ebp
  801c88:	c3                   	ret    

00801c89 <pipe>:
	uint8_t p_buf[PIPEBUFSIZ];	// data buffer
};

int
pipe(int pfd[2])
{
  801c89:	55                   	push   %ebp
  801c8a:	89 e5                	mov    %esp,%ebp
  801c8c:	56                   	push   %esi
  801c8d:	53                   	push   %ebx
  801c8e:	83 ec 30             	sub    $0x30,%esp
	int r;
	struct Fd *fd0, *fd1;
	void *va;

	// allocate the file descriptor table entries
	if ((r = fd_alloc(&fd0)) < 0
  801c91:	8d 45 f4             	lea    -0xc(%ebp),%eax
  801c94:	89 04 24             	mov    %eax,(%esp)
  801c97:	e8 5b f4 ff ff       	call   8010f7 <fd_alloc>
  801c9c:	89 c2                	mov    %eax,%edx
  801c9e:	85 d2                	test   %edx,%edx
  801ca0:	0f 88 4d 01 00 00    	js     801df3 <pipe+0x16a>
	    || (r = sys_page_alloc(0, fd0, PTE_P|PTE_W|PTE_U|PTE_SHARE)) < 0)
  801ca6:	c7 44 24 08 07 04 00 	movl   $0x407,0x8(%esp)
  801cad:	00 
  801cae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801cb1:	89 44 24 04          	mov    %eax,0x4(%esp)
  801cb5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  801cbc:	e8 98 f1 ff ff       	call   800e59 <sys_page_alloc>
  801cc1:	89 c2                	mov    %eax,%edx
  801cc3:	85 d2                	test   %edx,%edx
  801cc5:	0f 88 28 01 00 00    	js     801df3 <pipe+0x16a>
		goto err;

	if ((r = fd_alloc(&fd1)) < 0
  801ccb:	8d 45 f0             	lea    -0x10(%ebp),%eax
  801cce:	89 04 24             	mov    %eax,(%esp)
  801cd1:	e8 21 f4 ff ff       	call   8010f7 <fd_alloc>
  801cd6:	89 c3                	mov    %eax,%ebx
  801cd8:	85 c0                	test   %eax,%eax
  801cda:	0f 88 fe 00 00 00    	js     801dde <pipe+0x155>
	    || (r = sys_page_alloc(0, fd1, PTE_P|PTE_W|PTE_U|PTE_SHARE)) < 0)
  801ce0:	c7 44 24 08 07 04 00 	movl   $0x407,0x8(%esp)
  801ce7:	00 
  801ce8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ceb:	89 44 24 04          	mov    %eax,0x4(%esp)
  801cef:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  801cf6:	e8 5e f1 ff ff       	call   800e59 <sys_page_alloc>
  801cfb:	89 c3                	mov    %eax,%ebx
  801cfd:	85 c0                	test   %eax,%eax
  801cff:	0f 88 d9 00 00 00    	js     801dde <pipe+0x155>
		goto err1;

	// allocate the pipe structure as first data page in both
	va = fd2data(fd0);
  801d05:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d08:	89 04 24             	mov    %eax,(%esp)
  801d0b:	e8 d0 f3 ff ff       	call   8010e0 <fd2data>
  801d10:	89 c6                	mov    %eax,%esi
	if ((r = sys_page_alloc(0, va, PTE_P|PTE_W|PTE_U|PTE_SHARE)) < 0)
  801d12:	c7 44 24 08 07 04 00 	movl   $0x407,0x8(%esp)
  801d19:	00 
  801d1a:	89 44 24 04          	mov    %eax,0x4(%esp)
  801d1e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  801d25:	e8 2f f1 ff ff       	call   800e59 <sys_page_alloc>
  801d2a:	89 c3                	mov    %eax,%ebx
  801d2c:	85 c0                	test   %eax,%eax
  801d2e:	0f 88 97 00 00 00    	js     801dcb <pipe+0x142>
		goto err2;
	if ((r = sys_page_map(0, va, 0, fd2data(fd1), PTE_P|PTE_W|PTE_U|PTE_SHARE)) < 0)
  801d34:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d37:	89 04 24             	mov    %eax,(%esp)
  801d3a:	e8 a1 f3 ff ff       	call   8010e0 <fd2data>
  801d3f:	c7 44 24 10 07 04 00 	movl   $0x407,0x10(%esp)
  801d46:	00 
  801d47:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d4b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  801d52:	00 
  801d53:	89 74 24 04          	mov    %esi,0x4(%esp)
  801d57:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  801d5e:	e8 4a f1 ff ff       	call   800ead <sys_page_map>
  801d63:	89 c3                	mov    %eax,%ebx
  801d65:	85 c0                	test   %eax,%eax
  801d67:	78 52                	js     801dbb <pipe+0x132>
		goto err3;

	// set up fd structures
	fd0->fd_dev_id = devpipe.dev_id;
  801d69:	8b 15 24 30 80 00    	mov    0x803024,%edx
  801d6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d72:	89 10                	mov    %edx,(%eax)
	fd0->fd_omode = O_RDONLY;
  801d74:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d77:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)

	fd1->fd_dev_id = devpipe.dev_id;
  801d7e:	8b 15 24 30 80 00    	mov    0x803024,%edx
  801d84:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d87:	89 10                	mov    %edx,(%eax)
	fd1->fd_omode = O_WRONLY;
  801d89:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d8c:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)

	if (debug)
		cprintf("[%08x] pipecreate %08x\n", thisenv->env_id, uvpt[PGNUM(va)]);

	pfd[0] = fd2num(fd0);
  801d93:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d96:	89 04 24             	mov    %eax,(%esp)
  801d99:	e8 32 f3 ff ff       	call   8010d0 <fd2num>
  801d9e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801da1:	89 01                	mov    %eax,(%ecx)
	pfd[1] = fd2num(fd1);
  801da3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801da6:	89 04 24             	mov    %eax,(%esp)
  801da9:	e8 22 f3 ff ff       	call   8010d0 <fd2num>
  801dae:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801db1:	89 41 04             	mov    %eax,0x4(%ecx)
	return 0;
  801db4:	b8 00 00 00 00       	mov    $0x0,%eax
  801db9:	eb 38                	jmp    801df3 <pipe+0x16a>

    err3:
	sys_page_unmap(0, va);
  801dbb:	89 74 24 04          	mov    %esi,0x4(%esp)
  801dbf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  801dc6:	e8 35 f1 ff ff       	call   800f00 <sys_page_unmap>
    err2:
	sys_page_unmap(0, fd1);
  801dcb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801dce:	89 44 24 04          	mov    %eax,0x4(%esp)
  801dd2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  801dd9:	e8 22 f1 ff ff       	call   800f00 <sys_page_unmap>
    err1:
	sys_page_unmap(0, fd0);
  801dde:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801de1:	89 44 24 04          	mov    %eax,0x4(%esp)
  801de5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  801dec:	e8 0f f1 ff ff       	call   800f00 <sys_page_unmap>
  801df1:	89 d8                	mov    %ebx,%eax
    err:
	return r;
}
  801df3:	83 c4 30             	add    $0x30,%esp
  801df6:	5b                   	pop    %ebx
  801df7:	5e                   	pop    %esi
  801df8:	5d                   	pop    %ebp
  801df9:	c3                   	ret    

00801dfa <pipeisclosed>:
	}
}

int
pipeisclosed(int fdnum)
{
  801dfa:	55                   	push   %ebp
  801dfb:	89 e5                	mov    %esp,%ebp
  801dfd:	83 ec 28             	sub    $0x28,%esp
	struct Fd *fd;
	struct Pipe *p;
	int r;

	if ((r = fd_lookup(fdnum, &fd)) < 0)
  801e00:	8d 45 f4             	lea    -0xc(%ebp),%eax
  801e03:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e07:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0a:	89 04 24             	mov    %eax,(%esp)
  801e0d:	e8 59 f3 ff ff       	call   80116b <fd_lookup>
  801e12:	89 c2                	mov    %eax,%edx
  801e14:	85 d2                	test   %edx,%edx
  801e16:	78 15                	js     801e2d <pipeisclosed+0x33>
		return r;
	p = (struct Pipe*) fd2data(fd);
  801e18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e1b:	89 04 24             	mov    %eax,(%esp)
  801e1e:	e8 bd f2 ff ff       	call   8010e0 <fd2data>
	return _pipeisclosed(fd, p);
  801e23:	89 c2                	mov    %eax,%edx
  801e25:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e28:	e8 de fc ff ff       	call   801b0b <_pipeisclosed>
}
  801e2d:	c9                   	leave  
  801e2e:	c3                   	ret    
  801e2f:	90                   	nop

00801e30 <devcons_close>:
	return tot;
}

static int
devcons_close(struct Fd *fd)
{
  801e30:	55                   	push   %ebp
  801e31:	89 e5                	mov    %esp,%ebp
	USED(fd);

	return 0;
}
  801e33:	b8 00 00 00 00       	mov    $0x0,%eax
  801e38:	5d                   	pop    %ebp
  801e39:	c3                   	ret    

00801e3a <devcons_stat>:

static int
devcons_stat(struct Fd *fd, struct Stat *stat)
{
  801e3a:	55                   	push   %ebp
  801e3b:	89 e5                	mov    %esp,%ebp
  801e3d:	83 ec 18             	sub    $0x18,%esp
	strcpy(stat->st_name, "<cons>");
  801e40:	c7 44 24 04 7b 28 80 	movl   $0x80287b,0x4(%esp)
  801e47:	00 
  801e48:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e4b:	89 04 24             	mov    %eax,(%esp)
  801e4e:	e8 58 eb ff ff       	call   8009ab <strcpy>
	return 0;
}
  801e53:	b8 00 00 00 00       	mov    $0x0,%eax
  801e58:	c9                   	leave  
  801e59:	c3                   	ret    

00801e5a <devcons_write>:
	return 1;
}

static ssize_t
devcons_write(struct Fd *fd, const void *vbuf, size_t n)
{
  801e5a:	55                   	push   %ebp
  801e5b:	89 e5                	mov    %esp,%ebp
  801e5d:	57                   	push   %edi
  801e5e:	56                   	push   %esi
  801e5f:	53                   	push   %ebx
  801e60:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
	int tot, m;
	char buf[128];

	// mistake: have to nul-terminate arg to sys_cputs,
	// so we have to copy vbuf into buf in chunks and nul-terminate.
	for (tot = 0; tot < n; tot += m) {
  801e66:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801e6a:	74 4a                	je     801eb6 <devcons_write+0x5c>
  801e6c:	b8 00 00 00 00       	mov    $0x0,%eax
  801e71:	bb 00 00 00 00       	mov    $0x0,%ebx
		m = n - tot;
		if (m > sizeof(buf) - 1)
			m = sizeof(buf) - 1;
		memmove(buf, (char*)vbuf + tot, m);
  801e76:	8d bd 68 ff ff ff    	lea    -0x98(%ebp),%edi
	char buf[128];

	// mistake: have to nul-terminate arg to sys_cputs,
	// so we have to copy vbuf into buf in chunks and nul-terminate.
	for (tot = 0; tot < n; tot += m) {
		m = n - tot;
  801e7c:	8b 75 10             	mov    0x10(%ebp),%esi
  801e7f:	29 c6                	sub    %eax,%esi
		if (m > sizeof(buf) - 1)
  801e81:	83 fe 7f             	cmp    $0x7f,%esi
	char buf[128];

	// mistake: have to nul-terminate arg to sys_cputs,
	// so we have to copy vbuf into buf in chunks and nul-terminate.
	for (tot = 0; tot < n; tot += m) {
		m = n - tot;
  801e84:	ba 7f 00 00 00       	mov    $0x7f,%edx
  801e89:	0f 47 f2             	cmova  %edx,%esi
		if (m > sizeof(buf) - 1)
			m = sizeof(buf) - 1;
		memmove(buf, (char*)vbuf + tot, m);
  801e8c:	89 74 24 08          	mov    %esi,0x8(%esp)
  801e90:	03 45 0c             	add    0xc(%ebp),%eax
  801e93:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e97:	89 3c 24             	mov    %edi,(%esp)
  801e9a:	e8 07 ed ff ff       	call   800ba6 <memmove>
		sys_cputs(buf, m);
  801e9f:	89 74 24 04          	mov    %esi,0x4(%esp)
  801ea3:	89 3c 24             	mov    %edi,(%esp)
  801ea6:	e8 e1 ee ff ff       	call   800d8c <sys_cputs>
	int tot, m;
	char buf[128];

	// mistake: have to nul-terminate arg to sys_cputs,
	// so we have to copy vbuf into buf in chunks and nul-terminate.
	for (tot = 0; tot < n; tot += m) {
  801eab:	01 f3                	add    %esi,%ebx
  801ead:	89 d8                	mov    %ebx,%eax
  801eaf:	3b 5d 10             	cmp    0x10(%ebp),%ebx
  801eb2:	72 c8                	jb     801e7c <devcons_write+0x22>
  801eb4:	eb 05                	jmp    801ebb <devcons_write+0x61>
  801eb6:	bb 00 00 00 00       	mov    $0x0,%ebx
			m = sizeof(buf) - 1;
		memmove(buf, (char*)vbuf + tot, m);
		sys_cputs(buf, m);
	}
	return tot;
}
  801ebb:	89 d8                	mov    %ebx,%eax
  801ebd:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  801ec3:	5b                   	pop    %ebx
  801ec4:	5e                   	pop    %esi
  801ec5:	5f                   	pop    %edi
  801ec6:	5d                   	pop    %ebp
  801ec7:	c3                   	ret    

00801ec8 <devcons_read>:
	return fd2num(fd);
}

static ssize_t
devcons_read(struct Fd *fd, void *vbuf, size_t n)
{
  801ec8:	55                   	push   %ebp
  801ec9:	89 e5                	mov    %esp,%ebp
  801ecb:	83 ec 08             	sub    $0x8,%esp
	int c;

	if (n == 0)
		return 0;
  801ece:	b8 00 00 00 00       	mov    $0x0,%eax
static ssize_t
devcons_read(struct Fd *fd, void *vbuf, size_t n)
{
	int c;

	if (n == 0)
  801ed3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801ed7:	75 07                	jne    801ee0 <devcons_read+0x18>
  801ed9:	eb 28                	jmp    801f03 <devcons_read+0x3b>
		return 0;

	while ((c = sys_cgetc()) == 0)
		sys_yield();
  801edb:	e8 5a ef ff ff       	call   800e3a <sys_yield>
	int c;

	if (n == 0)
		return 0;

	while ((c = sys_cgetc()) == 0)
  801ee0:	e8 c5 ee ff ff       	call   800daa <sys_cgetc>
  801ee5:	85 c0                	test   %eax,%eax
  801ee7:	74 f2                	je     801edb <devcons_read+0x13>
		sys_yield();
	if (c < 0)
  801ee9:	85 c0                	test   %eax,%eax
  801eeb:	78 16                	js     801f03 <devcons_read+0x3b>
		return c;
	if (c == 0x04)	// ctl-d is eof
  801eed:	83 f8 04             	cmp    $0x4,%eax
  801ef0:	74 0c                	je     801efe <devcons_read+0x36>
		return 0;
	*(char*)vbuf = c;
  801ef2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ef5:	88 02                	mov    %al,(%edx)
	return 1;
  801ef7:	b8 01 00 00 00       	mov    $0x1,%eax
  801efc:	eb 05                	jmp    801f03 <devcons_read+0x3b>
	while ((c = sys_cgetc()) == 0)
		sys_yield();
	if (c < 0)
		return c;
	if (c == 0x04)	// ctl-d is eof
		return 0;
  801efe:	b8 00 00 00 00       	mov    $0x0,%eax
	*(char*)vbuf = c;
	return 1;
}
  801f03:	c9                   	leave  
  801f04:	c3                   	ret    

00801f05 <cputchar>:
#include <inc/string.h>
#include <inc/lib.h>

void
cputchar(int ch)
{
  801f05:	55                   	push   %ebp
  801f06:	89 e5                	mov    %esp,%ebp
  801f08:	83 ec 28             	sub    $0x28,%esp
	char c = ch;
  801f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0e:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	sys_cputs(&c, 1);
  801f11:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  801f18:	00 
  801f19:	8d 45 f7             	lea    -0x9(%ebp),%eax
  801f1c:	89 04 24             	mov    %eax,(%esp)
  801f1f:	e8 68 ee ff ff       	call   800d8c <sys_cputs>
}
  801f24:	c9                   	leave  
  801f25:	c3                   	ret    

00801f26 <getchar>:

int
getchar(void)
{
  801f26:	55                   	push   %ebp
  801f27:	89 e5                	mov    %esp,%ebp
  801f29:	83 ec 28             	sub    $0x28,%esp
	int r;

	// JOS does, however, support standard _input_ redirection,
	// allowing the user to redirect script files to the shell and such.
	// getchar() reads a character from file descriptor 0.
	r = read(0, &c, 1);
  801f2c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  801f33:	00 
  801f34:	8d 45 f7             	lea    -0x9(%ebp),%eax
  801f37:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f3b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  801f42:	e8 cf f4 ff ff       	call   801416 <read>
	if (r < 0)
  801f47:	85 c0                	test   %eax,%eax
  801f49:	78 0f                	js     801f5a <getchar+0x34>
		return r;
	if (r < 1)
  801f4b:	85 c0                	test   %eax,%eax
  801f4d:	7e 06                	jle    801f55 <getchar+0x2f>
		return -E_EOF;
	return c;
  801f4f:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  801f53:	eb 05                	jmp    801f5a <getchar+0x34>
	// getchar() reads a character from file descriptor 0.
	r = read(0, &c, 1);
	if (r < 0)
		return r;
	if (r < 1)
		return -E_EOF;
  801f55:	b8 f8 ff ff ff       	mov    $0xfffffff8,%eax
	return c;
}
  801f5a:	c9                   	leave  
  801f5b:	c3                   	ret    

00801f5c <iscons>:
	.dev_stat =	devcons_stat
};

int
iscons(int fdnum)
{
  801f5c:	55                   	push   %ebp
  801f5d:	89 e5                	mov    %esp,%ebp
  801f5f:	83 ec 28             	sub    $0x28,%esp
	int r;
	struct Fd *fd;

	if ((r = fd_lookup(fdnum, &fd)) < 0)
  801f62:	8d 45 f4             	lea    -0xc(%ebp),%eax
  801f65:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f69:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6c:	89 04 24             	mov    %eax,(%esp)
  801f6f:	e8 f7 f1 ff ff       	call   80116b <fd_lookup>
  801f74:	85 c0                	test   %eax,%eax
  801f76:	78 11                	js     801f89 <iscons+0x2d>
		return r;
	return fd->fd_dev_id == devcons.dev_id;
  801f78:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f7b:	8b 15 40 30 80 00    	mov    0x803040,%edx
  801f81:	39 10                	cmp    %edx,(%eax)
  801f83:	0f 94 c0             	sete   %al
  801f86:	0f b6 c0             	movzbl %al,%eax
}
  801f89:	c9                   	leave  
  801f8a:	c3                   	ret    

00801f8b <opencons>:

int
opencons(void)
{
  801f8b:	55                   	push   %ebp
  801f8c:	89 e5                	mov    %esp,%ebp
  801f8e:	83 ec 28             	sub    $0x28,%esp
	int r;
	struct Fd* fd;

	if ((r = fd_alloc(&fd)) < 0)
  801f91:	8d 45 f4             	lea    -0xc(%ebp),%eax
  801f94:	89 04 24             	mov    %eax,(%esp)
  801f97:	e8 5b f1 ff ff       	call   8010f7 <fd_alloc>
		return r;
  801f9c:	89 c2                	mov    %eax,%edx
opencons(void)
{
	int r;
	struct Fd* fd;

	if ((r = fd_alloc(&fd)) < 0)
  801f9e:	85 c0                	test   %eax,%eax
  801fa0:	78 40                	js     801fe2 <opencons+0x57>
		return r;
	if ((r = sys_page_alloc(0, fd, PTE_P|PTE_U|PTE_W|PTE_SHARE)) < 0)
  801fa2:	c7 44 24 08 07 04 00 	movl   $0x407,0x8(%esp)
  801fa9:	00 
  801faa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801fad:	89 44 24 04          	mov    %eax,0x4(%esp)
  801fb1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  801fb8:	e8 9c ee ff ff       	call   800e59 <sys_page_alloc>
		return r;
  801fbd:	89 c2                	mov    %eax,%edx
	int r;
	struct Fd* fd;

	if ((r = fd_alloc(&fd)) < 0)
		return r;
	if ((r = sys_page_alloc(0, fd, PTE_P|PTE_U|PTE_W|PTE_SHARE)) < 0)
  801fbf:	85 c0                	test   %eax,%eax
  801fc1:	78 1f                	js     801fe2 <opencons+0x57>
		return r;
	fd->fd_dev_id = devcons.dev_id;
  801fc3:	8b 15 40 30 80 00    	mov    0x803040,%edx
  801fc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801fcc:	89 10                	mov    %edx,(%eax)
	fd->fd_omode = O_RDWR;
  801fce:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801fd1:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%eax)
	return fd2num(fd);
  801fd8:	89 04 24             	mov    %eax,(%esp)
  801fdb:	e8 f0 f0 ff ff       	call   8010d0 <fd2num>
  801fe0:	89 c2                	mov    %eax,%edx
}
  801fe2:	89 d0                	mov    %edx,%eax
  801fe4:	c9                   	leave  
  801fe5:	c3                   	ret    

00801fe6 <ipc_recv>:
//   If 'pg' is null, pass sys_ipc_recv a value that it will understand
//   as meaning "no page".  (Zero is not the right value, since that's
//   a perfectly valid place to map a page.)
int32_t
ipc_recv(envid_t *from_env_store, void *pg, int *perm_store)
{
  801fe6:	55                   	push   %ebp
  801fe7:	89 e5                	mov    %esp,%ebp
  801fe9:	56                   	push   %esi
  801fea:	53                   	push   %ebx
  801feb:	83 ec 10             	sub    $0x10,%esp
  801fee:	8b 75 08             	mov    0x8(%ebp),%esi
  801ff1:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ff4:	8b 5d 10             	mov    0x10(%ebp),%ebx
	// use UTOP to indicate a no mapping
	int err_code = sys_ipc_recv(pg != NULL ? pg : (void*)UTOP);
  801ff7:	85 c0                	test   %eax,%eax
  801ff9:	ba 00 00 c0 ee       	mov    $0xeec00000,%edx
  801ffe:	0f 44 c2             	cmove  %edx,%eax
  802001:	89 04 24             	mov    %eax,(%esp)
  802004:	e8 66 f0 ff ff       	call   80106f <sys_ipc_recv>
	if (err_code < 0) {
  802009:	85 c0                	test   %eax,%eax
  80200b:	79 16                	jns    802023 <ipc_recv+0x3d>
		if (from_env_store) *from_env_store = 0;
  80200d:	85 f6                	test   %esi,%esi
  80200f:	74 06                	je     802017 <ipc_recv+0x31>
  802011:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
		if (perm_store) *perm_store = 0;
  802017:	85 db                	test   %ebx,%ebx
  802019:	74 2c                	je     802047 <ipc_recv+0x61>
  80201b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  802021:	eb 24                	jmp    802047 <ipc_recv+0x61>
	} else {
		if (from_env_store) *from_env_store = thisenv->env_ipc_from;
  802023:	85 f6                	test   %esi,%esi
  802025:	74 0a                	je     802031 <ipc_recv+0x4b>
  802027:	a1 08 40 80 00       	mov    0x804008,%eax
  80202c:	8b 40 74             	mov    0x74(%eax),%eax
  80202f:	89 06                	mov    %eax,(%esi)
		if (perm_store) *perm_store = thisenv->env_ipc_perm;
  802031:	85 db                	test   %ebx,%ebx
  802033:	74 0a                	je     80203f <ipc_recv+0x59>
  802035:	a1 08 40 80 00       	mov    0x804008,%eax
  80203a:	8b 40 78             	mov    0x78(%eax),%eax
  80203d:	89 03                	mov    %eax,(%ebx)
	}
	return err_code < 0 ? err_code : thisenv->env_ipc_value;
  80203f:	a1 08 40 80 00       	mov    0x804008,%eax
  802044:	8b 40 70             	mov    0x70(%eax),%eax
}
  802047:	83 c4 10             	add    $0x10,%esp
  80204a:	5b                   	pop    %ebx
  80204b:	5e                   	pop    %esi
  80204c:	5d                   	pop    %ebp
  80204d:	c3                   	ret    

0080204e <ipc_send>:
//   Use sys_yield() to be CPU-friendly.
//   If 'pg' is null, pass sys_ipc_recv a value that it will understand
//   as meaning "no page".  (Zero is not the right value.)
void
ipc_send(envid_t to_env, uint32_t val, void *pg, int perm)
{
  80204e:	55                   	push   %ebp
  80204f:	89 e5                	mov    %esp,%ebp
  802051:	57                   	push   %edi
  802052:	56                   	push   %esi
  802053:	53                   	push   %ebx
  802054:	83 ec 1c             	sub    $0x1c,%esp
  802057:	8b 7d 08             	mov    0x8(%ebp),%edi
  80205a:	8b 75 0c             	mov    0xc(%ebp),%esi
  80205d:	8b 5d 10             	mov    0x10(%ebp),%ebx
	int err_code;
	while ((err_code = sys_ipc_try_send(to_env, val, pg == NULL ? (void*)UTOP : pg, perm))) {
  802060:	eb 25                	jmp    802087 <ipc_send+0x39>
		if (err_code != -E_IPC_NOT_RECV) {
  802062:	83 f8 f9             	cmp    $0xfffffff9,%eax
  802065:	74 20                	je     802087 <ipc_send+0x39>
			panic("ipc_send:%e", err_code);
  802067:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80206b:	c7 44 24 08 87 28 80 	movl   $0x802887,0x8(%esp)
  802072:	00 
  802073:	c7 44 24 04 33 00 00 	movl   $0x33,0x4(%esp)
  80207a:	00 
  80207b:	c7 04 24 93 28 80 00 	movl   $0x802893,(%esp)
  802082:	e8 d6 e1 ff ff       	call   80025d <_panic>
//   as meaning "no page".  (Zero is not the right value.)
void
ipc_send(envid_t to_env, uint32_t val, void *pg, int perm)
{
	int err_code;
	while ((err_code = sys_ipc_try_send(to_env, val, pg == NULL ? (void*)UTOP : pg, perm))) {
  802087:	85 db                	test   %ebx,%ebx
  802089:	b8 00 00 c0 ee       	mov    $0xeec00000,%eax
  80208e:	0f 45 c3             	cmovne %ebx,%eax
  802091:	8b 55 14             	mov    0x14(%ebp),%edx
  802094:	89 54 24 0c          	mov    %edx,0xc(%esp)
  802098:	89 44 24 08          	mov    %eax,0x8(%esp)
  80209c:	89 74 24 04          	mov    %esi,0x4(%esp)
  8020a0:	89 3c 24             	mov    %edi,(%esp)
  8020a3:	e8 a4 ef ff ff       	call   80104c <sys_ipc_try_send>
  8020a8:	85 c0                	test   %eax,%eax
  8020aa:	75 b6                	jne    802062 <ipc_send+0x14>
		if (err_code != -E_IPC_NOT_RECV) {
			panic("ipc_send:%e", err_code);
		}
	}
}
  8020ac:	83 c4 1c             	add    $0x1c,%esp
  8020af:	5b                   	pop    %ebx
  8020b0:	5e                   	pop    %esi
  8020b1:	5f                   	pop    %edi
  8020b2:	5d                   	pop    %ebp
  8020b3:	c3                   	ret    

008020b4 <ipc_find_env>:
// Find the first environment of the given type.  We'll use this to
// find special environments.
// Returns 0 if no such environment exists.
envid_t
ipc_find_env(enum EnvType type)
{
  8020b4:	55                   	push   %ebp
  8020b5:	89 e5                	mov    %esp,%ebp
  8020b7:	8b 4d 08             	mov    0x8(%ebp),%ecx
	int i;
	for (i = 0; i < NENV; i++)
		if (envs[i].env_type == type)
  8020ba:	a1 50 00 c0 ee       	mov    0xeec00050,%eax
  8020bf:	39 c8                	cmp    %ecx,%eax
  8020c1:	74 17                	je     8020da <ipc_find_env+0x26>
// Returns 0 if no such environment exists.
envid_t
ipc_find_env(enum EnvType type)
{
	int i;
	for (i = 0; i < NENV; i++)
  8020c3:	b8 01 00 00 00       	mov    $0x1,%eax
		if (envs[i].env_type == type)
  8020c8:	6b d0 7c             	imul   $0x7c,%eax,%edx
  8020cb:	81 c2 00 00 c0 ee    	add    $0xeec00000,%edx
  8020d1:	8b 52 50             	mov    0x50(%edx),%edx
  8020d4:	39 ca                	cmp    %ecx,%edx
  8020d6:	75 14                	jne    8020ec <ipc_find_env+0x38>
  8020d8:	eb 05                	jmp    8020df <ipc_find_env+0x2b>
// Returns 0 if no such environment exists.
envid_t
ipc_find_env(enum EnvType type)
{
	int i;
	for (i = 0; i < NENV; i++)
  8020da:	b8 00 00 00 00       	mov    $0x0,%eax
		if (envs[i].env_type == type)
			return envs[i].env_id;
  8020df:	6b c0 7c             	imul   $0x7c,%eax,%eax
  8020e2:	05 08 00 c0 ee       	add    $0xeec00008,%eax
  8020e7:	8b 40 40             	mov    0x40(%eax),%eax
  8020ea:	eb 0e                	jmp    8020fa <ipc_find_env+0x46>
// Returns 0 if no such environment exists.
envid_t
ipc_find_env(enum EnvType type)
{
	int i;
	for (i = 0; i < NENV; i++)
  8020ec:	83 c0 01             	add    $0x1,%eax
  8020ef:	3d 00 04 00 00       	cmp    $0x400,%eax
  8020f4:	75 d2                	jne    8020c8 <ipc_find_env+0x14>
		if (envs[i].env_type == type)
			return envs[i].env_id;
	return 0;
  8020f6:	66 b8 00 00          	mov    $0x0,%ax
}
  8020fa:	5d                   	pop    %ebp
  8020fb:	c3                   	ret    

008020fc <pageref>:
#include <inc/lib.h>

int
pageref(void *v)
{
  8020fc:	55                   	push   %ebp
  8020fd:	89 e5                	mov    %esp,%ebp
  8020ff:	8b 55 08             	mov    0x8(%ebp),%edx
	pte_t pte;

	if (!(uvpd[PDX(v)] & PTE_P))
  802102:	89 d0                	mov    %edx,%eax
  802104:	c1 e8 16             	shr    $0x16,%eax
  802107:	8b 0c 85 00 d0 7b ef 	mov    -0x10843000(,%eax,4),%ecx
		return 0;
  80210e:	b8 00 00 00 00       	mov    $0x0,%eax
int
pageref(void *v)
{
	pte_t pte;

	if (!(uvpd[PDX(v)] & PTE_P))
  802113:	f6 c1 01             	test   $0x1,%cl
  802116:	74 1d                	je     802135 <pageref+0x39>
		return 0;
	pte = uvpt[PGNUM(v)];
  802118:	c1 ea 0c             	shr    $0xc,%edx
  80211b:	8b 14 95 00 00 40 ef 	mov    -0x10c00000(,%edx,4),%edx
	if (!(pte & PTE_P))
  802122:	f6 c2 01             	test   $0x1,%dl
  802125:	74 0e                	je     802135 <pageref+0x39>
		return 0;
	return pages[PGNUM(pte)].pp_ref;
  802127:	c1 ea 0c             	shr    $0xc,%edx
  80212a:	0f b7 04 d5 04 00 00 	movzwl -0x10fffffc(,%edx,8),%eax
  802131:	ef 
  802132:	0f b7 c0             	movzwl %ax,%eax
}
  802135:	5d                   	pop    %ebp
  802136:	c3                   	ret    
  802137:	66 90                	xchg   %ax,%ax
  802139:	66 90                	xchg   %ax,%ax
  80213b:	66 90                	xchg   %ax,%ax
  80213d:	66 90                	xchg   %ax,%ax
  80213f:	90                   	nop

00802140 <__udivdi3>:
  802140:	55                   	push   %ebp
  802141:	57                   	push   %edi
  802142:	56                   	push   %esi
  802143:	83 ec 0c             	sub    $0xc,%esp
  802146:	8b 44 24 28          	mov    0x28(%esp),%eax
  80214a:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  80214e:	8b 6c 24 20          	mov    0x20(%esp),%ebp
  802152:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  802156:	85 c0                	test   %eax,%eax
  802158:	89 7c 24 04          	mov    %edi,0x4(%esp)
  80215c:	89 ea                	mov    %ebp,%edx
  80215e:	89 0c 24             	mov    %ecx,(%esp)
  802161:	75 2d                	jne    802190 <__udivdi3+0x50>
  802163:	39 e9                	cmp    %ebp,%ecx
  802165:	77 61                	ja     8021c8 <__udivdi3+0x88>
  802167:	85 c9                	test   %ecx,%ecx
  802169:	89 ce                	mov    %ecx,%esi
  80216b:	75 0b                	jne    802178 <__udivdi3+0x38>
  80216d:	b8 01 00 00 00       	mov    $0x1,%eax
  802172:	31 d2                	xor    %edx,%edx
  802174:	f7 f1                	div    %ecx
  802176:	89 c6                	mov    %eax,%esi
  802178:	31 d2                	xor    %edx,%edx
  80217a:	89 e8                	mov    %ebp,%eax
  80217c:	f7 f6                	div    %esi
  80217e:	89 c5                	mov    %eax,%ebp
  802180:	89 f8                	mov    %edi,%eax
  802182:	f7 f6                	div    %esi
  802184:	89 ea                	mov    %ebp,%edx
  802186:	83 c4 0c             	add    $0xc,%esp
  802189:	5e                   	pop    %esi
  80218a:	5f                   	pop    %edi
  80218b:	5d                   	pop    %ebp
  80218c:	c3                   	ret    
  80218d:	8d 76 00             	lea    0x0(%esi),%esi
  802190:	39 e8                	cmp    %ebp,%eax
  802192:	77 24                	ja     8021b8 <__udivdi3+0x78>
  802194:	0f bd e8             	bsr    %eax,%ebp
  802197:	83 f5 1f             	xor    $0x1f,%ebp
  80219a:	75 3c                	jne    8021d8 <__udivdi3+0x98>
  80219c:	8b 74 24 04          	mov    0x4(%esp),%esi
  8021a0:	39 34 24             	cmp    %esi,(%esp)
  8021a3:	0f 86 9f 00 00 00    	jbe    802248 <__udivdi3+0x108>
  8021a9:	39 d0                	cmp    %edx,%eax
  8021ab:	0f 82 97 00 00 00    	jb     802248 <__udivdi3+0x108>
  8021b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  8021b8:	31 d2                	xor    %edx,%edx
  8021ba:	31 c0                	xor    %eax,%eax
  8021bc:	83 c4 0c             	add    $0xc,%esp
  8021bf:	5e                   	pop    %esi
  8021c0:	5f                   	pop    %edi
  8021c1:	5d                   	pop    %ebp
  8021c2:	c3                   	ret    
  8021c3:	90                   	nop
  8021c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  8021c8:	89 f8                	mov    %edi,%eax
  8021ca:	f7 f1                	div    %ecx
  8021cc:	31 d2                	xor    %edx,%edx
  8021ce:	83 c4 0c             	add    $0xc,%esp
  8021d1:	5e                   	pop    %esi
  8021d2:	5f                   	pop    %edi
  8021d3:	5d                   	pop    %ebp
  8021d4:	c3                   	ret    
  8021d5:	8d 76 00             	lea    0x0(%esi),%esi
  8021d8:	89 e9                	mov    %ebp,%ecx
  8021da:	8b 3c 24             	mov    (%esp),%edi
  8021dd:	d3 e0                	shl    %cl,%eax
  8021df:	89 c6                	mov    %eax,%esi
  8021e1:	b8 20 00 00 00       	mov    $0x20,%eax
  8021e6:	29 e8                	sub    %ebp,%eax
  8021e8:	89 c1                	mov    %eax,%ecx
  8021ea:	d3 ef                	shr    %cl,%edi
  8021ec:	89 e9                	mov    %ebp,%ecx
  8021ee:	89 7c 24 08          	mov    %edi,0x8(%esp)
  8021f2:	8b 3c 24             	mov    (%esp),%edi
  8021f5:	09 74 24 08          	or     %esi,0x8(%esp)
  8021f9:	89 d6                	mov    %edx,%esi
  8021fb:	d3 e7                	shl    %cl,%edi
  8021fd:	89 c1                	mov    %eax,%ecx
  8021ff:	89 3c 24             	mov    %edi,(%esp)
  802202:	8b 7c 24 04          	mov    0x4(%esp),%edi
  802206:	d3 ee                	shr    %cl,%esi
  802208:	89 e9                	mov    %ebp,%ecx
  80220a:	d3 e2                	shl    %cl,%edx
  80220c:	89 c1                	mov    %eax,%ecx
  80220e:	d3 ef                	shr    %cl,%edi
  802210:	09 d7                	or     %edx,%edi
  802212:	89 f2                	mov    %esi,%edx
  802214:	89 f8                	mov    %edi,%eax
  802216:	f7 74 24 08          	divl   0x8(%esp)
  80221a:	89 d6                	mov    %edx,%esi
  80221c:	89 c7                	mov    %eax,%edi
  80221e:	f7 24 24             	mull   (%esp)
  802221:	39 d6                	cmp    %edx,%esi
  802223:	89 14 24             	mov    %edx,(%esp)
  802226:	72 30                	jb     802258 <__udivdi3+0x118>
  802228:	8b 54 24 04          	mov    0x4(%esp),%edx
  80222c:	89 e9                	mov    %ebp,%ecx
  80222e:	d3 e2                	shl    %cl,%edx
  802230:	39 c2                	cmp    %eax,%edx
  802232:	73 05                	jae    802239 <__udivdi3+0xf9>
  802234:	3b 34 24             	cmp    (%esp),%esi
  802237:	74 1f                	je     802258 <__udivdi3+0x118>
  802239:	89 f8                	mov    %edi,%eax
  80223b:	31 d2                	xor    %edx,%edx
  80223d:	e9 7a ff ff ff       	jmp    8021bc <__udivdi3+0x7c>
  802242:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  802248:	31 d2                	xor    %edx,%edx
  80224a:	b8 01 00 00 00       	mov    $0x1,%eax
  80224f:	e9 68 ff ff ff       	jmp    8021bc <__udivdi3+0x7c>
  802254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  802258:	8d 47 ff             	lea    -0x1(%edi),%eax
  80225b:	31 d2                	xor    %edx,%edx
  80225d:	83 c4 0c             	add    $0xc,%esp
  802260:	5e                   	pop    %esi
  802261:	5f                   	pop    %edi
  802262:	5d                   	pop    %ebp
  802263:	c3                   	ret    
  802264:	66 90                	xchg   %ax,%ax
  802266:	66 90                	xchg   %ax,%ax
  802268:	66 90                	xchg   %ax,%ax
  80226a:	66 90                	xchg   %ax,%ax
  80226c:	66 90                	xchg   %ax,%ax
  80226e:	66 90                	xchg   %ax,%ax

00802270 <__umoddi3>:
  802270:	55                   	push   %ebp
  802271:	57                   	push   %edi
  802272:	56                   	push   %esi
  802273:	83 ec 14             	sub    $0x14,%esp
  802276:	8b 44 24 28          	mov    0x28(%esp),%eax
  80227a:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  80227e:	8b 74 24 2c          	mov    0x2c(%esp),%esi
  802282:	89 c7                	mov    %eax,%edi
  802284:	89 44 24 04          	mov    %eax,0x4(%esp)
  802288:	8b 44 24 30          	mov    0x30(%esp),%eax
  80228c:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  802290:	89 34 24             	mov    %esi,(%esp)
  802293:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802297:	85 c0                	test   %eax,%eax
  802299:	89 c2                	mov    %eax,%edx
  80229b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80229f:	75 17                	jne    8022b8 <__umoddi3+0x48>
  8022a1:	39 fe                	cmp    %edi,%esi
  8022a3:	76 4b                	jbe    8022f0 <__umoddi3+0x80>
  8022a5:	89 c8                	mov    %ecx,%eax
  8022a7:	89 fa                	mov    %edi,%edx
  8022a9:	f7 f6                	div    %esi
  8022ab:	89 d0                	mov    %edx,%eax
  8022ad:	31 d2                	xor    %edx,%edx
  8022af:	83 c4 14             	add    $0x14,%esp
  8022b2:	5e                   	pop    %esi
  8022b3:	5f                   	pop    %edi
  8022b4:	5d                   	pop    %ebp
  8022b5:	c3                   	ret    
  8022b6:	66 90                	xchg   %ax,%ax
  8022b8:	39 f8                	cmp    %edi,%eax
  8022ba:	77 54                	ja     802310 <__umoddi3+0xa0>
  8022bc:	0f bd e8             	bsr    %eax,%ebp
  8022bf:	83 f5 1f             	xor    $0x1f,%ebp
  8022c2:	75 5c                	jne    802320 <__umoddi3+0xb0>
  8022c4:	8b 7c 24 08          	mov    0x8(%esp),%edi
  8022c8:	39 3c 24             	cmp    %edi,(%esp)
  8022cb:	0f 87 e7 00 00 00    	ja     8023b8 <__umoddi3+0x148>
  8022d1:	8b 7c 24 04          	mov    0x4(%esp),%edi
  8022d5:	29 f1                	sub    %esi,%ecx
  8022d7:	19 c7                	sbb    %eax,%edi
  8022d9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8022dd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8022e1:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022e5:	8b 54 24 0c          	mov    0xc(%esp),%edx
  8022e9:	83 c4 14             	add    $0x14,%esp
  8022ec:	5e                   	pop    %esi
  8022ed:	5f                   	pop    %edi
  8022ee:	5d                   	pop    %ebp
  8022ef:	c3                   	ret    
  8022f0:	85 f6                	test   %esi,%esi
  8022f2:	89 f5                	mov    %esi,%ebp
  8022f4:	75 0b                	jne    802301 <__umoddi3+0x91>
  8022f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8022fb:	31 d2                	xor    %edx,%edx
  8022fd:	f7 f6                	div    %esi
  8022ff:	89 c5                	mov    %eax,%ebp
  802301:	8b 44 24 04          	mov    0x4(%esp),%eax
  802305:	31 d2                	xor    %edx,%edx
  802307:	f7 f5                	div    %ebp
  802309:	89 c8                	mov    %ecx,%eax
  80230b:	f7 f5                	div    %ebp
  80230d:	eb 9c                	jmp    8022ab <__umoddi3+0x3b>
  80230f:	90                   	nop
  802310:	89 c8                	mov    %ecx,%eax
  802312:	89 fa                	mov    %edi,%edx
  802314:	83 c4 14             	add    $0x14,%esp
  802317:	5e                   	pop    %esi
  802318:	5f                   	pop    %edi
  802319:	5d                   	pop    %ebp
  80231a:	c3                   	ret    
  80231b:	90                   	nop
  80231c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  802320:	8b 04 24             	mov    (%esp),%eax
  802323:	be 20 00 00 00       	mov    $0x20,%esi
  802328:	89 e9                	mov    %ebp,%ecx
  80232a:	29 ee                	sub    %ebp,%esi
  80232c:	d3 e2                	shl    %cl,%edx
  80232e:	89 f1                	mov    %esi,%ecx
  802330:	d3 e8                	shr    %cl,%eax
  802332:	89 e9                	mov    %ebp,%ecx
  802334:	89 44 24 04          	mov    %eax,0x4(%esp)
  802338:	8b 04 24             	mov    (%esp),%eax
  80233b:	09 54 24 04          	or     %edx,0x4(%esp)
  80233f:	89 fa                	mov    %edi,%edx
  802341:	d3 e0                	shl    %cl,%eax
  802343:	89 f1                	mov    %esi,%ecx
  802345:	89 44 24 08          	mov    %eax,0x8(%esp)
  802349:	8b 44 24 10          	mov    0x10(%esp),%eax
  80234d:	d3 ea                	shr    %cl,%edx
  80234f:	89 e9                	mov    %ebp,%ecx
  802351:	d3 e7                	shl    %cl,%edi
  802353:	89 f1                	mov    %esi,%ecx
  802355:	d3 e8                	shr    %cl,%eax
  802357:	89 e9                	mov    %ebp,%ecx
  802359:	09 f8                	or     %edi,%eax
  80235b:	8b 7c 24 10          	mov    0x10(%esp),%edi
  80235f:	f7 74 24 04          	divl   0x4(%esp)
  802363:	d3 e7                	shl    %cl,%edi
  802365:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802369:	89 d7                	mov    %edx,%edi
  80236b:	f7 64 24 08          	mull   0x8(%esp)
  80236f:	39 d7                	cmp    %edx,%edi
  802371:	89 c1                	mov    %eax,%ecx
  802373:	89 14 24             	mov    %edx,(%esp)
  802376:	72 2c                	jb     8023a4 <__umoddi3+0x134>
  802378:	39 44 24 0c          	cmp    %eax,0xc(%esp)
  80237c:	72 22                	jb     8023a0 <__umoddi3+0x130>
  80237e:	8b 44 24 0c          	mov    0xc(%esp),%eax
  802382:	29 c8                	sub    %ecx,%eax
  802384:	19 d7                	sbb    %edx,%edi
  802386:	89 e9                	mov    %ebp,%ecx
  802388:	89 fa                	mov    %edi,%edx
  80238a:	d3 e8                	shr    %cl,%eax
  80238c:	89 f1                	mov    %esi,%ecx
  80238e:	d3 e2                	shl    %cl,%edx
  802390:	89 e9                	mov    %ebp,%ecx
  802392:	d3 ef                	shr    %cl,%edi
  802394:	09 d0                	or     %edx,%eax
  802396:	89 fa                	mov    %edi,%edx
  802398:	83 c4 14             	add    $0x14,%esp
  80239b:	5e                   	pop    %esi
  80239c:	5f                   	pop    %edi
  80239d:	5d                   	pop    %ebp
  80239e:	c3                   	ret    
  80239f:	90                   	nop
  8023a0:	39 d7                	cmp    %edx,%edi
  8023a2:	75 da                	jne    80237e <__umoddi3+0x10e>
  8023a4:	8b 14 24             	mov    (%esp),%edx
  8023a7:	89 c1                	mov    %eax,%ecx
  8023a9:	2b 4c 24 08          	sub    0x8(%esp),%ecx
  8023ad:	1b 54 24 04          	sbb    0x4(%esp),%edx
  8023b1:	eb cb                	jmp    80237e <__umoddi3+0x10e>
  8023b3:	90                   	nop
  8023b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  8023b8:	3b 44 24 0c          	cmp    0xc(%esp),%eax
  8023bc:	0f 82 0f ff ff ff    	jb     8022d1 <__umoddi3+0x61>
  8023c2:	e9 1a ff ff ff       	jmp    8022e1 <__umoddi3+0x71>
