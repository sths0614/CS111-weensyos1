
obj/mpos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# MiniprocOS's kernel stack, then jumps to the 'start' routine in mpos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x200000, %esp
  10000c:	bc 00 00 20 00       	mov    $0x200000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 09 02 00 00       	call   100222 <start>
  100019:	90                   	nop

0010001a <sys_int48_handler>:

# Interrupt handlers
.align 2

sys_int48_handler:
	pushl $0
  10001a:	6a 00                	push   $0x0
	pushl $48
  10001c:	6a 30                	push   $0x30
	jmp _generic_int_handler
  10001e:	eb 3a                	jmp    10005a <_generic_int_handler>

00100020 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $49
  100022:	6a 31                	push   $0x31
	jmp _generic_int_handler
  100024:	eb 34                	jmp    10005a <_generic_int_handler>

00100026 <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $50
  100028:	6a 32                	push   $0x32
	jmp _generic_int_handler
  10002a:	eb 2e                	jmp    10005a <_generic_int_handler>

0010002c <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $51
  10002e:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100030:	eb 28                	jmp    10005a <_generic_int_handler>

00100032 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $52
  100034:	6a 34                	push   $0x34
	jmp _generic_int_handler
  100036:	eb 22                	jmp    10005a <_generic_int_handler>

00100038 <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $53
  10003a:	6a 35                	push   $0x35
	jmp _generic_int_handler
  10003c:	eb 1c                	jmp    10005a <_generic_int_handler>

0010003e <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $54
  100040:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100042:	eb 16                	jmp    10005a <_generic_int_handler>

00100044 <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $55
  100046:	6a 37                	push   $0x37
	jmp _generic_int_handler
  100048:	eb 10                	jmp    10005a <_generic_int_handler>

0010004a <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $56
  10004c:	6a 38                	push   $0x38
	jmp _generic_int_handler
  10004e:	eb 0a                	jmp    10005a <_generic_int_handler>

00100050 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $57
  100052:	6a 39                	push   $0x39
	jmp _generic_int_handler
  100054:	eb 04                	jmp    10005a <_generic_int_handler>

00100056 <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	jmp _generic_int_handler
  100058:	eb 00                	jmp    10005a <_generic_int_handler>

0010005a <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the interrupt number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  10005a:	1e                   	push   %ds
	pushl %es
  10005b:	06                   	push   %es
	pushal
  10005c:	60                   	pusha  

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10005d:	54                   	push   %esp
	call interrupt
  10005e:	e8 58 00 00 00       	call   1000bb <interrupt>

00100063 <sys_int_handlers>:
  100063:	1a 00                	sbb    (%eax),%al
  100065:	10 00                	adc    %al,(%eax)
  100067:	20 00                	and    %al,(%eax)
  100069:	10 00                	adc    %al,(%eax)
  10006b:	26 00 10             	add    %dl,%es:(%eax)
  10006e:	00 2c 00             	add    %ch,(%eax,%eax,1)
  100071:	10 00                	adc    %al,(%eax)
  100073:	32 00                	xor    (%eax),%al
  100075:	10 00                	adc    %al,(%eax)
  100077:	38 00                	cmp    %al,(%eax)
  100079:	10 00                	adc    %al,(%eax)
  10007b:	3e 00 10             	add    %dl,%ds:(%eax)
  10007e:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  100082:	00 4a 00             	add    %cl,0x0(%edx)
  100085:	10 00                	adc    %al,(%eax)
  100087:	50                   	push   %eax
  100088:	00 10                	add    %dl,(%eax)
  10008a:	00 90 83 ec 0c a1    	add    %dl,-0x5ef3137d(%eax)

0010008c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10008c:	83 ec 0c             	sub    $0xc,%esp
	pid_t pid = current->p_pid;
  10008f:	a1 b8 9c 10 00       	mov    0x109cb8,%eax
	while (1) {
		pid = (pid + 1) % NPROCS;
  100094:	b9 10 00 00 00       	mov    $0x10,%ecx
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
  100099:	8b 10                	mov    (%eax),%edx
	while (1) {
		pid = (pid + 1) % NPROCS;
  10009b:	8d 42 01             	lea    0x1(%edx),%eax
  10009e:	99                   	cltd   
  10009f:	f7 f9                	idiv   %ecx
		if (proc_array[pid].p_state == P_RUNNABLE)
  1000a1:	6b c2 54             	imul   $0x54,%edx,%eax
  1000a4:	83 b8 58 8f 10 00 01 	cmpl   $0x1,0x108f58(%eax)
  1000ab:	75 ee                	jne    10009b <schedule+0xf>
			run(&proc_array[pid]);
  1000ad:	83 ec 0c             	sub    $0xc,%esp
  1000b0:	05 10 8f 10 00       	add    $0x108f10,%eax
  1000b5:	50                   	push   %eax
  1000b6:	e8 81 03 00 00       	call   10043c <run>

001000bb <interrupt>:



void
interrupt(registers_t *reg)
{
  1000bb:	55                   	push   %ebp
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000bc:	b9 11 00 00 00       	mov    $0x11,%ecx



void
interrupt(registers_t *reg)
{
  1000c1:	57                   	push   %edi
  1000c2:	56                   	push   %esi
  1000c3:	53                   	push   %ebx
  1000c4:	83 ec 0c             	sub    $0xc,%esp
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000c7:	8b 1d b8 9c 10 00    	mov    0x109cb8,%ebx



void
interrupt(registers_t *reg)
{
  1000cd:	8b 44 24 20          	mov    0x20(%esp),%eax
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000d1:	8d 7b 04             	lea    0x4(%ebx),%edi
  1000d4:	89 c6                	mov    %eax,%esi
  1000d6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1000d8:	8b 40 28             	mov    0x28(%eax),%eax
  1000db:	83 e8 30             	sub    $0x30,%eax
  1000de:	83 f8 04             	cmp    $0x4,%eax
  1000e1:	0f 87 39 01 00 00    	ja     100220 <interrupt+0x165>
  1000e7:	ff 24 85 f4 09 10 00 	jmp    *0x1009f4(,%eax,4)
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  1000ee:	8b 03                	mov    (%ebx),%eax
		run(current);
  1000f0:	83 ec 0c             	sub    $0xc,%esp
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  1000f3:	89 43 20             	mov    %eax,0x20(%ebx)
		run(current);
  1000f6:	53                   	push   %ebx
  1000f7:	eb 6b                	jmp    100164 <interrupt+0xa9>
  1000f9:	bd 64 8f 10 00       	mov    $0x108f64,%ebp
	int offset=1;
	while(1){
		if(offset==NPROCS)
			return -1;
		avail=&(proc_array[offset]);
		if(avail->p_state==P_EMPTY)
  1000fe:	83 7d 48 00          	cmpl   $0x0,0x48(%ebp)
  100102:	74 10                	je     100114 <interrupt+0x59>
  100104:	83 c5 54             	add    $0x54,%ebp

	//finding availability of processes
	process_t* avail;
	int offset=1;
	while(1){
		if(offset==NPROCS)
  100107:	81 fd 50 94 10 00    	cmp    $0x109450,%ebp
  10010d:	75 ef                	jne    1000fe <interrupt+0x43>
  10010f:	83 c8 ff             	or     $0xffffffff,%eax
  100112:	eb 44                	jmp    100158 <interrupt+0x9d>
		if(avail->p_state==P_EMPTY)
			break;
		offset++;
	}

	avail->p_registers=parent->p_registers;
  100114:	8d 7d 04             	lea    0x4(%ebp),%edi
  100117:	b9 11 00 00 00       	mov    $0x11,%ecx
	// Your job is to figure out how to calculate these variables,
	// and then how to actually copy the stack.  (Hint: use memcpy.)
	// We have done one for you.


	src_stack_top = PROC1_STACK_ADDR+(PROC_STACK_SIZE*(src->p_pid));;
  10011c:	8b 03                	mov    (%ebx),%eax
		if(avail->p_state==P_EMPTY)
			break;
		offset++;
	}

	avail->p_registers=parent->p_registers;
  10011e:	8d 73 04             	lea    0x4(%ebx),%esi
  100121:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)


	src_stack_top = PROC1_STACK_ADDR+(PROC_STACK_SIZE*(src->p_pid));;
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR+(PROC_STACK_SIZE*(dest->p_pid));
	dest_stack_bottom = src_stack_bottom+(PROC_STACK_SIZE*(dest->p_pid-src->p_pid));
  100123:	8b 75 00             	mov    0x0(%ebp),%esi
	// and then how to actually copy the stack.  (Hint: use memcpy.)
	// We have done one for you.


	src_stack_top = PROC1_STACK_ADDR+(PROC_STACK_SIZE*(src->p_pid));;
	src_stack_bottom = src->p_registers.reg_esp;
  100126:	8b 53 40             	mov    0x40(%ebx),%edx
	dest_stack_top = PROC1_STACK_ADDR+(PROC_STACK_SIZE*(dest->p_pid));
	dest_stack_bottom = src_stack_bottom+(PROC_STACK_SIZE*(dest->p_pid-src->p_pid));
  100129:	29 c6                	sub    %eax,%esi
	// memcpy the stack and set dest->p_registers.reg_esp

	memcpy((void*)dest_stack_bottom,
  10012b:	83 c0 0a             	add    $0xa,%eax
  10012e:	c1 e0 12             	shl    $0x12,%eax
  100131:	51                   	push   %ecx
  100132:	29 d0                	sub    %edx,%eax
  100134:	50                   	push   %eax


	src_stack_top = PROC1_STACK_ADDR+(PROC_STACK_SIZE*(src->p_pid));;
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR+(PROC_STACK_SIZE*(dest->p_pid));
	dest_stack_bottom = src_stack_bottom+(PROC_STACK_SIZE*(dest->p_pid-src->p_pid));
  100135:	c1 e6 12             	shl    $0x12,%esi
  100138:	01 d6                	add    %edx,%esi
	// memcpy the stack and set dest->p_registers.reg_esp

	memcpy((void*)dest_stack_bottom,
  10013a:	52                   	push   %edx
  10013b:	56                   	push   %esi
  10013c:	e8 d3 03 00 00       	call   100514 <memcpy>

	avail->p_registers=parent->p_registers;
	copy_stack(avail,parent);
	avail->p_state = P_RUNNABLE;
	avail->p_registers.reg_eax=0; //avail is a child, reg_eax is the return value of the child	
	return avail->p_pid;
  100141:	8b 45 00             	mov    0x0(%ebp),%eax
  100144:	83 c4 10             	add    $0x10,%esp
	// memcpy the stack and set dest->p_registers.reg_esp

	memcpy((void*)dest_stack_bottom,
		   (void*)src_stack_bottom,
		   src_stack_top - src_stack_bottom);
	dest->p_registers.reg_esp=dest_stack_bottom;
  100147:	89 75 40             	mov    %esi,0x40(%ebp)
		offset++;
	}

	avail->p_registers=parent->p_registers;
	copy_stack(avail,parent);
	avail->p_state = P_RUNNABLE;
  10014a:	c7 45 48 01 00 00 00 	movl   $0x1,0x48(%ebp)
	avail->p_registers.reg_eax=0; //avail is a child, reg_eax is the return value of the child	
  100151:	c7 45 20 00 00 00 00 	movl   $0x0,0x20(%ebp)
		run(current);

	case INT_SYS_FORK:
		// The 'sys_fork' system call should create a new process.
		// You will have to complete the do_fork() function!
		current->p_registers.reg_eax = do_fork(current);
  100158:	89 43 20             	mov    %eax,0x20(%ebx)
		run(current);
  10015b:	83 ec 0c             	sub    $0xc,%esp
  10015e:	ff 35 b8 9c 10 00    	pushl  0x109cb8
  100164:	e8 d3 02 00 00       	call   10043c <run>
	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule a
		// different process.  (MiniprocOS is cooperatively
		// scheduled, so we need a special system call to do this.)
		// The schedule() function picks another process and runs it.
		schedule();
  100169:	e8 1e ff ff ff       	call   10008c <schedule>
 *****************************************************************************/

static pid_t do_fork(process_t *parent);

static void exit_process(pid_t toKill){
	current = &(proc_array[toKill]);
  10016e:	a1 b8 9c 10 00       	mov    0x109cb8,%eax
  100173:	6b 10 54             	imul   $0x54,(%eax),%edx
  100176:	81 c2 10 8f 10 00    	add    $0x108f10,%edx
	current->p_state=P_ZOMBIE;
	current->p_exit_status = current->p_registers.reg_eax;
  10017c:	8b 42 20             	mov    0x20(%edx),%eax
 *****************************************************************************/

static pid_t do_fork(process_t *parent);

static void exit_process(pid_t toKill){
	current = &(proc_array[toKill]);
  10017f:	89 15 b8 9c 10 00    	mov    %edx,0x109cb8
	current->p_state=P_ZOMBIE;
  100185:	c7 42 48 03 00 00 00 	movl   $0x3,0x48(%edx)
	current->p_exit_status = current->p_registers.reg_eax;
  10018c:	89 42 4c             	mov    %eax,0x4c(%edx)
  10018f:	31 c0                	xor    %eax,%eax
	int offset = 1;

	while(offset < NPROCS){
		// if a process is blocked and waiting on the current process,
		// make the state of those to be runnable, and set its return value
		if((proc_array[offset].p_state == P_BLOCKED) && (proc_array[offset].p_wait_on == current->p_pid)){
  100191:	83 b8 ac 8f 10 00 02 	cmpl   $0x2,0x108fac(%eax)
  100198:	75 1d                	jne    1001b7 <interrupt+0xfc>
  10019a:	8b 88 b4 8f 10 00    	mov    0x108fb4(%eax),%ecx
  1001a0:	3b 0a                	cmp    (%edx),%ecx
  1001a2:	75 13                	jne    1001b7 <interrupt+0xfc>
		//	reaped = 1;
			proc_array[offset].p_state = P_RUNNABLE;
			proc_array[offset].p_registers.reg_eax=current->p_exit_status;
  1001a4:	8b 4a 4c             	mov    0x4c(%edx),%ecx
	while(offset < NPROCS){
		// if a process is blocked and waiting on the current process,
		// make the state of those to be runnable, and set its return value
		if((proc_array[offset].p_state == P_BLOCKED) && (proc_array[offset].p_wait_on == current->p_pid)){
		//	reaped = 1;
			proc_array[offset].p_state = P_RUNNABLE;
  1001a7:	c7 80 ac 8f 10 00 01 	movl   $0x1,0x108fac(%eax)
  1001ae:	00 00 00 
			proc_array[offset].p_registers.reg_eax=current->p_exit_status;
  1001b1:	89 88 84 8f 10 00    	mov    %ecx,0x108f84(%eax)
  1001b7:	83 c0 54             	add    $0x54,%eax
	current->p_exit_status = current->p_registers.reg_eax;

	int reaped = 0;
	int offset = 1;

	while(offset < NPROCS){
  1001ba:	3d ec 04 00 00       	cmp    $0x4ec,%eax
  1001bf:	75 d0                	jne    100191 <interrupt+0xd6>
		// for this register out of 'current->p_registers'.

		exit_process(current->p_pid);
		//current->p_state = P_ZOMBIE;
		//current->p_exit_status = current->p_registers.reg_eax;
		schedule();
  1001c1:	e8 c6 fe ff ff       	call   10008c <schedule>
		// * A process that doesn't exist (p_state == P_EMPTY).
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
  1001c6:	a1 b8 9c 10 00       	mov    0x109cb8,%eax
  1001cb:	8b 50 20             	mov    0x20(%eax),%edx
		if (p <= 0 || p >= NPROCS || p == current->p_pid // to check if ID is valid
  1001ce:	8d 4a ff             	lea    -0x1(%edx),%ecx
  1001d1:	83 f9 0e             	cmp    $0xe,%ecx
  1001d4:	77 14                	ja     1001ea <interrupt+0x12f>
  1001d6:	3b 10                	cmp    (%eax),%edx
  1001d8:	74 10                	je     1001ea <interrupt+0x12f>
		    || proc_array[p].p_state == P_EMPTY)
  1001da:	6b da 54             	imul   $0x54,%edx,%ebx
  1001dd:	8d 8b 18 8f 10 00    	lea    0x108f18(%ebx),%ecx
  1001e3:	8b 71 40             	mov    0x40(%ecx),%esi
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid // to check if ID is valid
  1001e6:	85 f6                	test   %esi,%esi
  1001e8:	75 09                	jne    1001f3 <interrupt+0x138>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
  1001ea:	c7 40 20 ff ff ff ff 	movl   $0xffffffff,0x20(%eax)
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid // to check if ID is valid
  1001f1:	eb 21                	jmp    100214 <interrupt+0x159>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state == P_ZOMBIE){ // to check if process already exited
  1001f3:	83 fe 03             	cmp    $0x3,%esi
  1001f6:	75 12                	jne    10020a <interrupt+0x14f>
			current->p_registers.reg_eax = proc_array[p].p_exit_status;
  1001f8:	8b 93 5c 8f 10 00    	mov    0x108f5c(%ebx),%edx
			proc_array[p].p_state = P_EMPTY; //sets the state to empty so that it can be reaped later
  1001fe:	c7 41 40 00 00 00 00 	movl   $0x0,0x40(%ecx)
		pid_t p = current->p_registers.reg_eax;
		if (p <= 0 || p >= NPROCS || p == current->p_pid // to check if ID is valid
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state == P_ZOMBIE){ // to check if process already exited
			current->p_registers.reg_eax = proc_array[p].p_exit_status;
  100205:	89 50 20             	mov    %edx,0x20(%eax)
  100208:	eb 0a                	jmp    100214 <interrupt+0x159>
			proc_array[p].p_state = P_EMPTY; //sets the state to empty so that it can be reaped later
		} 
		else{
			// blocks the current process
			current->p_state = P_BLOCKED; 
  10020a:	c7 40 48 02 00 00 00 	movl   $0x2,0x48(%eax)

			// waiting on proc_array[p]
			current->p_wait_on = p;
  100211:	89 50 50             	mov    %edx,0x50(%eax)
	default:
		while (1)
			/* do nothing */;

	}
}
  100214:	83 c4 0c             	add    $0xc,%esp
  100217:	5b                   	pop    %ebx
  100218:	5e                   	pop    %esi
  100219:	5f                   	pop    %edi
  10021a:	5d                   	pop    %ebp

			// waiting on proc_array[p]
			current->p_wait_on = p;
		}
			
		schedule();
  10021b:	e9 6c fe ff ff       	jmp    10008c <schedule>
  100220:	eb fe                	jmp    100220 <interrupt+0x165>

00100222 <start>:
 *****************************************************************************/


void
start(void)
{
  100222:	53                   	push   %ebx
  100223:	83 ec 0c             	sub    $0xc,%esp
	const char *s;
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100226:	68 40 05 00 00       	push   $0x540
  10022b:	6a 00                	push   $0x0
  10022d:	68 10 8f 10 00       	push   $0x108f10
  100232:	e8 41 03 00 00       	call   100578 <memset>
  100237:	ba 10 8f 10 00       	mov    $0x108f10,%edx
  10023c:	31 c0                	xor    %eax,%eax
  10023e:	83 c4 10             	add    $0x10,%esp
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100241:	89 02                	mov    %eax,(%edx)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  100243:	40                   	inc    %eax
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100244:	c7 42 48 00 00 00 00 	movl   $0x0,0x48(%edx)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  10024b:	83 c2 54             	add    $0x54,%edx
  10024e:	83 f8 10             	cmp    $0x10,%eax
  100251:	75 ee                	jne    100241 <start+0x1f>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// The first process has process ID 1.
	current = &proc_array[1];
  100253:	c7 05 b8 9c 10 00 64 	movl   $0x108f64,0x109cb8
  10025a:	8f 10 00 

	// Set up x86 hardware, and initialize the first process's
	// special registers.  This only needs to be done once, at boot time.
	// All other processes' special registers can be copied from the
	// first process.
	segments_init();
  10025d:	e8 72 00 00 00       	call   1002d4 <segments_init>
	special_registers_init(current);
  100262:	83 ec 0c             	sub    $0xc,%esp
  100265:	ff 35 b8 9c 10 00    	pushl  0x109cb8
  10026b:	e8 e3 01 00 00       	call   100453 <special_registers_init>

	// Erase the console, and initialize the cursor-position shared
	// variable to point to its upper left.
	console_clear();
  100270:	e8 2e 01 00 00       	call   1003a3 <console_clear>

	// Figure out which program to run.
	
	cursorpos = console_printf(cursorpos, 0x0700, "Type '1' to run mpos-app, or '2' to run mpos-app2.");
  100275:	83 c4 0c             	add    $0xc,%esp
  100278:	68 08 0a 10 00       	push   $0x100a08
  10027d:	68 00 07 00 00       	push   $0x700
  100282:	ff 35 00 00 06 00    	pushl  0x60000
  100288:	e8 4d 07 00 00       	call   1009da <console_printf>
  10028d:	83 c4 10             	add    $0x10,%esp
  100290:	a3 00 00 06 00       	mov    %eax,0x60000
	do {
		whichprocess = console_read_digit();
  100295:	e8 4c 01 00 00       	call   1003e6 <console_read_digit>
	} while (whichprocess != 1 && whichprocess != 2);
  10029a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10029d:	83 fb 01             	cmp    $0x1,%ebx
  1002a0:	77 f3                	ja     100295 <start+0x73>
	console_clear();
  1002a2:	e8 fc 00 00 00       	call   1003a3 <console_clear>
	

	// Load the process application code and data into memory.
	// Store its entry point into the first process's EIP
	// (instruction pointer).
	program_loader(whichprocess - 1, &current->p_registers.reg_eip);
  1002a7:	50                   	push   %eax
  1002a8:	50                   	push   %eax
  1002a9:	a1 b8 9c 10 00       	mov    0x109cb8,%eax
  1002ae:	83 c0 34             	add    $0x34,%eax
  1002b1:	50                   	push   %eax
  1002b2:	53                   	push   %ebx
  1002b3:	e8 d0 01 00 00       	call   100488 <program_loader>

	// Set the main process's stack pointer, ESP.
	current->p_registers.reg_esp = PROC1_STACK_ADDR + PROC_STACK_SIZE;
  1002b8:	a1 b8 9c 10 00       	mov    0x109cb8,%eax
  1002bd:	c7 40 40 00 00 2c 00 	movl   $0x2c0000,0x40(%eax)

	// Mark the process as runnable!
	current->p_state = P_RUNNABLE;
  1002c4:	c7 40 48 01 00 00 00 	movl   $0x1,0x48(%eax)

	// Switch to the main process using run().
	run(current);
  1002cb:	89 04 24             	mov    %eax,(%esp)
  1002ce:	e8 69 01 00 00       	call   10043c <run>
  1002d3:	90                   	nop

001002d4 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002d4:	b8 50 94 10 00       	mov    $0x109450,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002d9:	b9 56 00 10 00       	mov    $0x100056,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002de:	89 c2                	mov    %eax,%edx
  1002e0:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1002e3:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002e4:	bb 56 00 10 00       	mov    $0x100056,%ebx
  1002e9:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002ec:	66 a3 a6 1a 10 00    	mov    %ax,0x101aa6
  1002f2:	c1 e8 18             	shr    $0x18,%eax
  1002f5:	88 15 a8 1a 10 00    	mov    %dl,0x101aa8
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002fb:	ba b8 94 10 00       	mov    $0x1094b8,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100300:	a2 ab 1a 10 00       	mov    %al,0x101aab
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100305:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100307:	66 c7 05 a4 1a 10 00 	movw   $0x68,0x101aa4
  10030e:	68 00 
  100310:	c6 05 aa 1a 10 00 40 	movb   $0x40,0x101aaa
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  100317:	c6 05 a9 1a 10 00 89 	movb   $0x89,0x101aa9

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  10031e:	c7 05 54 94 10 00 00 	movl   $0x80000,0x109454
  100325:	00 08 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100328:	66 c7 05 58 94 10 00 	movw   $0x10,0x109458
  10032f:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100331:	66 89 0c c5 b8 94 10 	mov    %cx,0x1094b8(,%eax,8)
  100338:	00 
  100339:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100340:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100345:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10034a:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  10034f:	40                   	inc    %eax
  100350:	3d 00 01 00 00       	cmp    $0x100,%eax
  100355:	75 da                	jne    100331 <segments_init+0x5d>
  100357:	66 b8 30 00          	mov    $0x30,%ax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10035b:	ba b8 94 10 00       	mov    $0x1094b8,%edx
  100360:	8b 0c 85 a3 ff 0f 00 	mov    0xfffa3(,%eax,4),%ecx
  100367:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10036e:	66 89 0c c5 b8 94 10 	mov    %cx,0x1094b8(,%eax,8)
  100375:	00 
  100376:	c1 e9 10             	shr    $0x10,%ecx
  100379:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10037e:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100383:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
  100388:	40                   	inc    %eax
  100389:	83 f8 3a             	cmp    $0x3a,%eax
  10038c:	75 d2                	jne    100360 <segments_init+0x8c>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_GETPID], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10038e:	b0 28                	mov    $0x28,%al
  100390:	0f 01 15 6c 1a 10 00 	lgdtl  0x101a6c
  100397:	0f 00 d8             	ltr    %ax
  10039a:	0f 01 1d 74 1a 10 00 	lidtl  0x101a74
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1003a1:	5b                   	pop    %ebx
  1003a2:	c3                   	ret    

001003a3 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1003a3:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1003a4:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1003a6:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1003a7:	c7 05 00 00 06 00 00 	movl   $0xb8000,0x60000
  1003ae:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1003b1:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%eax,%eax,1)
  1003b8:	00 20 07 
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1003bb:	40                   	inc    %eax
  1003bc:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  1003c1:	75 ee                	jne    1003b1 <console_clear+0xe>
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1003c3:	be d4 03 00 00       	mov    $0x3d4,%esi
  1003c8:	b0 0e                	mov    $0xe,%al
  1003ca:	89 f2                	mov    %esi,%edx
  1003cc:	ee                   	out    %al,(%dx)
  1003cd:	31 c9                	xor    %ecx,%ecx
  1003cf:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1003d4:	88 c8                	mov    %cl,%al
  1003d6:	89 da                	mov    %ebx,%edx
  1003d8:	ee                   	out    %al,(%dx)
  1003d9:	b0 0f                	mov    $0xf,%al
  1003db:	89 f2                	mov    %esi,%edx
  1003dd:	ee                   	out    %al,(%dx)
  1003de:	88 c8                	mov    %cl,%al
  1003e0:	89 da                	mov    %ebx,%edx
  1003e2:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1003e3:	5b                   	pop    %ebx
  1003e4:	5e                   	pop    %esi
  1003e5:	c3                   	ret    

001003e6 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1003e6:	ba 64 00 00 00       	mov    $0x64,%edx
  1003eb:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1003ec:	a8 01                	test   $0x1,%al
  1003ee:	74 45                	je     100435 <console_read_digit+0x4f>
  1003f0:	b2 60                	mov    $0x60,%dl
  1003f2:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1003f3:	8d 50 fe             	lea    -0x2(%eax),%edx
  1003f6:	80 fa 08             	cmp    $0x8,%dl
  1003f9:	77 05                	ja     100400 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1003fb:	0f b6 c0             	movzbl %al,%eax
  1003fe:	48                   	dec    %eax
  1003ff:	c3                   	ret    
	else if (data == 0x0B)
  100400:	3c 0b                	cmp    $0xb,%al
  100402:	74 35                	je     100439 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100404:	8d 50 b9             	lea    -0x47(%eax),%edx
  100407:	80 fa 02             	cmp    $0x2,%dl
  10040a:	77 07                	ja     100413 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  10040c:	0f b6 c0             	movzbl %al,%eax
  10040f:	83 e8 40             	sub    $0x40,%eax
  100412:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100413:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100416:	80 fa 02             	cmp    $0x2,%dl
  100419:	77 07                	ja     100422 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  10041b:	0f b6 c0             	movzbl %al,%eax
  10041e:	83 e8 47             	sub    $0x47,%eax
  100421:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100422:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100425:	80 fa 02             	cmp    $0x2,%dl
  100428:	77 07                	ja     100431 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10042a:	0f b6 c0             	movzbl %al,%eax
  10042d:	83 e8 4e             	sub    $0x4e,%eax
  100430:	c3                   	ret    
	else if (data == 0x53)
  100431:	3c 53                	cmp    $0x53,%al
  100433:	74 04                	je     100439 <console_read_digit+0x53>
  100435:	83 c8 ff             	or     $0xffffffff,%eax
  100438:	c3                   	ret    
  100439:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10043b:	c3                   	ret    

0010043c <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  10043c:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100440:	a3 b8 9c 10 00       	mov    %eax,0x109cb8

	asm volatile("movl %0,%%esp\n\t"
  100445:	83 c0 04             	add    $0x4,%eax
  100448:	89 c4                	mov    %eax,%esp
  10044a:	61                   	popa   
  10044b:	07                   	pop    %es
  10044c:	1f                   	pop    %ds
  10044d:	83 c4 08             	add    $0x8,%esp
  100450:	cf                   	iret   
  100451:	eb fe                	jmp    100451 <run+0x15>

00100453 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100453:	53                   	push   %ebx
  100454:	83 ec 0c             	sub    $0xc,%esp
  100457:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  10045b:	6a 44                	push   $0x44
  10045d:	6a 00                	push   $0x0
  10045f:	8d 43 04             	lea    0x4(%ebx),%eax
  100462:	50                   	push   %eax
  100463:	e8 10 01 00 00       	call   100578 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100468:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10046e:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100474:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10047a:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
}
  100480:	83 c4 18             	add    $0x18,%esp
  100483:	5b                   	pop    %ebx
  100484:	c3                   	ret    
  100485:	90                   	nop
  100486:	90                   	nop
  100487:	90                   	nop

00100488 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100488:	55                   	push   %ebp
  100489:	57                   	push   %edi
  10048a:	56                   	push   %esi
  10048b:	53                   	push   %ebx
  10048c:	83 ec 1c             	sub    $0x1c,%esp
  10048f:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100493:	83 f8 01             	cmp    $0x1,%eax
  100496:	7f 04                	jg     10049c <program_loader+0x14>
  100498:	85 c0                	test   %eax,%eax
  10049a:	79 02                	jns    10049e <program_loader+0x16>
  10049c:	eb fe                	jmp    10049c <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10049e:	8b 34 c5 ac 1a 10 00 	mov    0x101aac(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1004a5:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1004ab:	74 02                	je     1004af <program_loader+0x27>
  1004ad:	eb fe                	jmp    1004ad <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1004af:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1004b2:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1004b6:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1004b8:	c1 e5 05             	shl    $0x5,%ebp
  1004bb:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1004be:	eb 3f                	jmp    1004ff <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1004c0:	83 3b 01             	cmpl   $0x1,(%ebx)
  1004c3:	75 37                	jne    1004fc <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1004c5:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1004c8:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1004cb:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1004ce:	01 c7                	add    %eax,%edi
	memsz += va;
  1004d0:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1004d2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1004d7:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1004db:	52                   	push   %edx
  1004dc:	89 fa                	mov    %edi,%edx
  1004de:	29 c2                	sub    %eax,%edx
  1004e0:	52                   	push   %edx
  1004e1:	8b 53 04             	mov    0x4(%ebx),%edx
  1004e4:	01 f2                	add    %esi,%edx
  1004e6:	52                   	push   %edx
  1004e7:	50                   	push   %eax
  1004e8:	e8 27 00 00 00       	call   100514 <memcpy>
  1004ed:	83 c4 10             	add    $0x10,%esp
  1004f0:	eb 04                	jmp    1004f6 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1004f2:	c6 07 00             	movb   $0x0,(%edi)
  1004f5:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1004f6:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1004fa:	72 f6                	jb     1004f2 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1004fc:	83 c3 20             	add    $0x20,%ebx
  1004ff:	39 eb                	cmp    %ebp,%ebx
  100501:	72 bd                	jb     1004c0 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100503:	8b 56 18             	mov    0x18(%esi),%edx
  100506:	8b 44 24 34          	mov    0x34(%esp),%eax
  10050a:	89 10                	mov    %edx,(%eax)
}
  10050c:	83 c4 1c             	add    $0x1c,%esp
  10050f:	5b                   	pop    %ebx
  100510:	5e                   	pop    %esi
  100511:	5f                   	pop    %edi
  100512:	5d                   	pop    %ebp
  100513:	c3                   	ret    

00100514 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100514:	56                   	push   %esi
  100515:	31 d2                	xor    %edx,%edx
  100517:	53                   	push   %ebx
  100518:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10051c:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100520:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100524:	eb 08                	jmp    10052e <memcpy+0x1a>
		*d++ = *s++;
  100526:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100529:	4e                   	dec    %esi
  10052a:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  10052d:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10052e:	85 f6                	test   %esi,%esi
  100530:	75 f4                	jne    100526 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100532:	5b                   	pop    %ebx
  100533:	5e                   	pop    %esi
  100534:	c3                   	ret    

00100535 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100535:	57                   	push   %edi
  100536:	56                   	push   %esi
  100537:	53                   	push   %ebx
  100538:	8b 44 24 10          	mov    0x10(%esp),%eax
  10053c:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100540:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100544:	39 c7                	cmp    %eax,%edi
  100546:	73 26                	jae    10056e <memmove+0x39>
  100548:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10054b:	39 c6                	cmp    %eax,%esi
  10054d:	76 1f                	jbe    10056e <memmove+0x39>
		s += n, d += n;
  10054f:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100552:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100554:	eb 07                	jmp    10055d <memmove+0x28>
			*--d = *--s;
  100556:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100559:	4a                   	dec    %edx
  10055a:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  10055d:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  10055e:	85 d2                	test   %edx,%edx
  100560:	75 f4                	jne    100556 <memmove+0x21>
  100562:	eb 10                	jmp    100574 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100564:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  100567:	4a                   	dec    %edx
  100568:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10056b:	41                   	inc    %ecx
  10056c:	eb 02                	jmp    100570 <memmove+0x3b>
  10056e:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100570:	85 d2                	test   %edx,%edx
  100572:	75 f0                	jne    100564 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100574:	5b                   	pop    %ebx
  100575:	5e                   	pop    %esi
  100576:	5f                   	pop    %edi
  100577:	c3                   	ret    

00100578 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100578:	53                   	push   %ebx
  100579:	8b 44 24 08          	mov    0x8(%esp),%eax
  10057d:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100581:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100585:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100587:	eb 04                	jmp    10058d <memset+0x15>
		*p++ = c;
  100589:	88 1a                	mov    %bl,(%edx)
  10058b:	49                   	dec    %ecx
  10058c:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  10058d:	85 c9                	test   %ecx,%ecx
  10058f:	75 f8                	jne    100589 <memset+0x11>
		*p++ = c;
	return v;
}
  100591:	5b                   	pop    %ebx
  100592:	c3                   	ret    

00100593 <strlen>:

size_t
strlen(const char *s)
{
  100593:	8b 54 24 04          	mov    0x4(%esp),%edx
  100597:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100599:	eb 01                	jmp    10059c <strlen+0x9>
		++n;
  10059b:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10059c:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1005a0:	75 f9                	jne    10059b <strlen+0x8>
		++n;
	return n;
}
  1005a2:	c3                   	ret    

001005a3 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1005a3:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1005a7:	31 c0                	xor    %eax,%eax
  1005a9:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1005ad:	eb 01                	jmp    1005b0 <strnlen+0xd>
		++n;
  1005af:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1005b0:	39 d0                	cmp    %edx,%eax
  1005b2:	74 06                	je     1005ba <strnlen+0x17>
  1005b4:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1005b8:	75 f5                	jne    1005af <strnlen+0xc>
		++n;
	return n;
}
  1005ba:	c3                   	ret    

001005bb <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1005bb:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1005bc:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1005c1:	53                   	push   %ebx
  1005c2:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1005c4:	76 05                	jbe    1005cb <console_putc+0x10>
  1005c6:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1005cb:	80 fa 0a             	cmp    $0xa,%dl
  1005ce:	75 2c                	jne    1005fc <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1005d0:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1005d6:	be 50 00 00 00       	mov    $0x50,%esi
  1005db:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1005dd:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1005e0:	99                   	cltd   
  1005e1:	f7 fe                	idiv   %esi
  1005e3:	89 de                	mov    %ebx,%esi
  1005e5:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1005e7:	eb 07                	jmp    1005f0 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1005e9:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1005ec:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1005ed:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1005f0:	83 f8 50             	cmp    $0x50,%eax
  1005f3:	75 f4                	jne    1005e9 <console_putc+0x2e>
  1005f5:	29 d0                	sub    %edx,%eax
  1005f7:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1005fa:	eb 0b                	jmp    100607 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1005fc:	0f b6 d2             	movzbl %dl,%edx
  1005ff:	09 ca                	or     %ecx,%edx
  100601:	66 89 13             	mov    %dx,(%ebx)
  100604:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100607:	5b                   	pop    %ebx
  100608:	5e                   	pop    %esi
  100609:	c3                   	ret    

0010060a <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10060a:	56                   	push   %esi
  10060b:	53                   	push   %ebx
  10060c:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100610:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100613:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100617:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  10061c:	75 04                	jne    100622 <fill_numbuf+0x18>
  10061e:	85 d2                	test   %edx,%edx
  100620:	74 10                	je     100632 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100622:	89 d0                	mov    %edx,%eax
  100624:	31 d2                	xor    %edx,%edx
  100626:	f7 f1                	div    %ecx
  100628:	4b                   	dec    %ebx
  100629:	8a 14 16             	mov    (%esi,%edx,1),%dl
  10062c:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10062e:	89 c2                	mov    %eax,%edx
  100630:	eb ec                	jmp    10061e <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100632:	89 d8                	mov    %ebx,%eax
  100634:	5b                   	pop    %ebx
  100635:	5e                   	pop    %esi
  100636:	c3                   	ret    

00100637 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100637:	55                   	push   %ebp
  100638:	57                   	push   %edi
  100639:	56                   	push   %esi
  10063a:	53                   	push   %ebx
  10063b:	83 ec 38             	sub    $0x38,%esp
  10063e:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100642:	8b 7c 24 54          	mov    0x54(%esp),%edi
  100646:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10064a:	e9 60 03 00 00       	jmp    1009af <console_vprintf+0x378>
		if (*format != '%') {
  10064f:	80 fa 25             	cmp    $0x25,%dl
  100652:	74 13                	je     100667 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100654:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100658:	0f b6 d2             	movzbl %dl,%edx
  10065b:	89 f0                	mov    %esi,%eax
  10065d:	e8 59 ff ff ff       	call   1005bb <console_putc>
  100662:	e9 45 03 00 00       	jmp    1009ac <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100667:	47                   	inc    %edi
  100668:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  10066f:	00 
  100670:	eb 12                	jmp    100684 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100672:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100673:	8a 11                	mov    (%ecx),%dl
  100675:	84 d2                	test   %dl,%dl
  100677:	74 1a                	je     100693 <console_vprintf+0x5c>
  100679:	89 e8                	mov    %ebp,%eax
  10067b:	38 c2                	cmp    %al,%dl
  10067d:	75 f3                	jne    100672 <console_vprintf+0x3b>
  10067f:	e9 3f 03 00 00       	jmp    1009c3 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100684:	8a 17                	mov    (%edi),%dl
  100686:	84 d2                	test   %dl,%dl
  100688:	74 0b                	je     100695 <console_vprintf+0x5e>
  10068a:	b9 3c 0a 10 00       	mov    $0x100a3c,%ecx
  10068f:	89 d5                	mov    %edx,%ebp
  100691:	eb e0                	jmp    100673 <console_vprintf+0x3c>
  100693:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100695:	8d 42 cf             	lea    -0x31(%edx),%eax
  100698:	3c 08                	cmp    $0x8,%al
  10069a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1006a1:	00 
  1006a2:	76 13                	jbe    1006b7 <console_vprintf+0x80>
  1006a4:	eb 1d                	jmp    1006c3 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1006a6:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1006ab:	0f be c0             	movsbl %al,%eax
  1006ae:	47                   	inc    %edi
  1006af:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1006b3:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1006b7:	8a 07                	mov    (%edi),%al
  1006b9:	8d 50 d0             	lea    -0x30(%eax),%edx
  1006bc:	80 fa 09             	cmp    $0x9,%dl
  1006bf:	76 e5                	jbe    1006a6 <console_vprintf+0x6f>
  1006c1:	eb 18                	jmp    1006db <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1006c3:	80 fa 2a             	cmp    $0x2a,%dl
  1006c6:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1006cd:	ff 
  1006ce:	75 0b                	jne    1006db <console_vprintf+0xa4>
			width = va_arg(val, int);
  1006d0:	83 c3 04             	add    $0x4,%ebx
			++format;
  1006d3:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1006d4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1006d7:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1006db:	83 cd ff             	or     $0xffffffff,%ebp
  1006de:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1006e1:	75 37                	jne    10071a <console_vprintf+0xe3>
			++format;
  1006e3:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1006e4:	31 ed                	xor    %ebp,%ebp
  1006e6:	8a 07                	mov    (%edi),%al
  1006e8:	8d 50 d0             	lea    -0x30(%eax),%edx
  1006eb:	80 fa 09             	cmp    $0x9,%dl
  1006ee:	76 0d                	jbe    1006fd <console_vprintf+0xc6>
  1006f0:	eb 17                	jmp    100709 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1006f2:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1006f5:	0f be c0             	movsbl %al,%eax
  1006f8:	47                   	inc    %edi
  1006f9:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1006fd:	8a 07                	mov    (%edi),%al
  1006ff:	8d 50 d0             	lea    -0x30(%eax),%edx
  100702:	80 fa 09             	cmp    $0x9,%dl
  100705:	76 eb                	jbe    1006f2 <console_vprintf+0xbb>
  100707:	eb 11                	jmp    10071a <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100709:	3c 2a                	cmp    $0x2a,%al
  10070b:	75 0b                	jne    100718 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  10070d:	83 c3 04             	add    $0x4,%ebx
				++format;
  100710:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100711:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100714:	85 ed                	test   %ebp,%ebp
  100716:	79 02                	jns    10071a <console_vprintf+0xe3>
  100718:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10071a:	8a 07                	mov    (%edi),%al
  10071c:	3c 64                	cmp    $0x64,%al
  10071e:	74 34                	je     100754 <console_vprintf+0x11d>
  100720:	7f 1d                	jg     10073f <console_vprintf+0x108>
  100722:	3c 58                	cmp    $0x58,%al
  100724:	0f 84 a2 00 00 00    	je     1007cc <console_vprintf+0x195>
  10072a:	3c 63                	cmp    $0x63,%al
  10072c:	0f 84 bf 00 00 00    	je     1007f1 <console_vprintf+0x1ba>
  100732:	3c 43                	cmp    $0x43,%al
  100734:	0f 85 d0 00 00 00    	jne    10080a <console_vprintf+0x1d3>
  10073a:	e9 a3 00 00 00       	jmp    1007e2 <console_vprintf+0x1ab>
  10073f:	3c 75                	cmp    $0x75,%al
  100741:	74 4d                	je     100790 <console_vprintf+0x159>
  100743:	3c 78                	cmp    $0x78,%al
  100745:	74 5c                	je     1007a3 <console_vprintf+0x16c>
  100747:	3c 73                	cmp    $0x73,%al
  100749:	0f 85 bb 00 00 00    	jne    10080a <console_vprintf+0x1d3>
  10074f:	e9 86 00 00 00       	jmp    1007da <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100754:	83 c3 04             	add    $0x4,%ebx
  100757:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10075a:	89 d1                	mov    %edx,%ecx
  10075c:	c1 f9 1f             	sar    $0x1f,%ecx
  10075f:	89 0c 24             	mov    %ecx,(%esp)
  100762:	31 ca                	xor    %ecx,%edx
  100764:	55                   	push   %ebp
  100765:	29 ca                	sub    %ecx,%edx
  100767:	68 44 0a 10 00       	push   $0x100a44
  10076c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100771:	8d 44 24 40          	lea    0x40(%esp),%eax
  100775:	e8 90 fe ff ff       	call   10060a <fill_numbuf>
  10077a:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  10077e:	58                   	pop    %eax
  10077f:	5a                   	pop    %edx
  100780:	ba 01 00 00 00       	mov    $0x1,%edx
  100785:	8b 04 24             	mov    (%esp),%eax
  100788:	83 e0 01             	and    $0x1,%eax
  10078b:	e9 a5 00 00 00       	jmp    100835 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100790:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100793:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100798:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10079b:	55                   	push   %ebp
  10079c:	68 44 0a 10 00       	push   $0x100a44
  1007a1:	eb 11                	jmp    1007b4 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1007a3:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1007a6:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007a9:	55                   	push   %ebp
  1007aa:	68 58 0a 10 00       	push   $0x100a58
  1007af:	b9 10 00 00 00       	mov    $0x10,%ecx
  1007b4:	8d 44 24 40          	lea    0x40(%esp),%eax
  1007b8:	e8 4d fe ff ff       	call   10060a <fill_numbuf>
  1007bd:	ba 01 00 00 00       	mov    $0x1,%edx
  1007c2:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1007c6:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1007c8:	59                   	pop    %ecx
  1007c9:	59                   	pop    %ecx
  1007ca:	eb 69                	jmp    100835 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1007cc:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1007cf:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007d2:	55                   	push   %ebp
  1007d3:	68 44 0a 10 00       	push   $0x100a44
  1007d8:	eb d5                	jmp    1007af <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1007da:	83 c3 04             	add    $0x4,%ebx
  1007dd:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1007e0:	eb 40                	jmp    100822 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1007e2:	83 c3 04             	add    $0x4,%ebx
  1007e5:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007e8:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1007ec:	e9 bd 01 00 00       	jmp    1009ae <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1007f1:	83 c3 04             	add    $0x4,%ebx
  1007f4:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  1007f7:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  1007fb:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100800:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100804:	88 44 24 24          	mov    %al,0x24(%esp)
  100808:	eb 27                	jmp    100831 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10080a:	84 c0                	test   %al,%al
  10080c:	75 02                	jne    100810 <console_vprintf+0x1d9>
  10080e:	b0 25                	mov    $0x25,%al
  100810:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100814:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100819:	80 3f 00             	cmpb   $0x0,(%edi)
  10081c:	74 0a                	je     100828 <console_vprintf+0x1f1>
  10081e:	8d 44 24 24          	lea    0x24(%esp),%eax
  100822:	89 44 24 04          	mov    %eax,0x4(%esp)
  100826:	eb 09                	jmp    100831 <console_vprintf+0x1fa>
				format--;
  100828:	8d 54 24 24          	lea    0x24(%esp),%edx
  10082c:	4f                   	dec    %edi
  10082d:	89 54 24 04          	mov    %edx,0x4(%esp)
  100831:	31 d2                	xor    %edx,%edx
  100833:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100835:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100837:	83 fd ff             	cmp    $0xffffffff,%ebp
  10083a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100841:	74 1f                	je     100862 <console_vprintf+0x22b>
  100843:	89 04 24             	mov    %eax,(%esp)
  100846:	eb 01                	jmp    100849 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100848:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100849:	39 e9                	cmp    %ebp,%ecx
  10084b:	74 0a                	je     100857 <console_vprintf+0x220>
  10084d:	8b 44 24 04          	mov    0x4(%esp),%eax
  100851:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100855:	75 f1                	jne    100848 <console_vprintf+0x211>
  100857:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10085a:	89 0c 24             	mov    %ecx,(%esp)
  10085d:	eb 1f                	jmp    10087e <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  10085f:	42                   	inc    %edx
  100860:	eb 09                	jmp    10086b <console_vprintf+0x234>
  100862:	89 d1                	mov    %edx,%ecx
  100864:	8b 14 24             	mov    (%esp),%edx
  100867:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10086b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10086f:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100873:	75 ea                	jne    10085f <console_vprintf+0x228>
  100875:	8b 44 24 08          	mov    0x8(%esp),%eax
  100879:	89 14 24             	mov    %edx,(%esp)
  10087c:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  10087e:	85 c0                	test   %eax,%eax
  100880:	74 0c                	je     10088e <console_vprintf+0x257>
  100882:	84 d2                	test   %dl,%dl
  100884:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  10088b:	00 
  10088c:	75 24                	jne    1008b2 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  10088e:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100893:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  10089a:	00 
  10089b:	75 15                	jne    1008b2 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  10089d:	8b 44 24 14          	mov    0x14(%esp),%eax
  1008a1:	83 e0 08             	and    $0x8,%eax
  1008a4:	83 f8 01             	cmp    $0x1,%eax
  1008a7:	19 c9                	sbb    %ecx,%ecx
  1008a9:	f7 d1                	not    %ecx
  1008ab:	83 e1 20             	and    $0x20,%ecx
  1008ae:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  1008b2:	3b 2c 24             	cmp    (%esp),%ebp
  1008b5:	7e 0d                	jle    1008c4 <console_vprintf+0x28d>
  1008b7:	84 d2                	test   %dl,%dl
  1008b9:	74 40                	je     1008fb <console_vprintf+0x2c4>
			zeros = precision - len;
  1008bb:	2b 2c 24             	sub    (%esp),%ebp
  1008be:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  1008c2:	eb 3f                	jmp    100903 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1008c4:	84 d2                	test   %dl,%dl
  1008c6:	74 33                	je     1008fb <console_vprintf+0x2c4>
  1008c8:	8b 44 24 14          	mov    0x14(%esp),%eax
  1008cc:	83 e0 06             	and    $0x6,%eax
  1008cf:	83 f8 02             	cmp    $0x2,%eax
  1008d2:	75 27                	jne    1008fb <console_vprintf+0x2c4>
  1008d4:	45                   	inc    %ebp
  1008d5:	75 24                	jne    1008fb <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  1008d7:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1008d9:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  1008dc:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1008e1:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1008e4:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  1008e7:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  1008eb:	7d 0e                	jge    1008fb <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  1008ed:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1008f1:	29 ca                	sub    %ecx,%edx
  1008f3:	29 c2                	sub    %eax,%edx
  1008f5:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1008f9:	eb 08                	jmp    100903 <console_vprintf+0x2cc>
  1008fb:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100902:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100903:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100907:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100909:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10090d:	2b 2c 24             	sub    (%esp),%ebp
  100910:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100915:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100918:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10091b:	29 c5                	sub    %eax,%ebp
  10091d:	89 f0                	mov    %esi,%eax
  10091f:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100923:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100927:	eb 0f                	jmp    100938 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100929:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10092d:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100932:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100933:	e8 83 fc ff ff       	call   1005bb <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100938:	85 ed                	test   %ebp,%ebp
  10093a:	7e 07                	jle    100943 <console_vprintf+0x30c>
  10093c:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100941:	74 e6                	je     100929 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100943:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100948:	89 c6                	mov    %eax,%esi
  10094a:	74 23                	je     10096f <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  10094c:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100951:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100955:	e8 61 fc ff ff       	call   1005bb <console_putc>
  10095a:	89 c6                	mov    %eax,%esi
  10095c:	eb 11                	jmp    10096f <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  10095e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100962:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100967:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100968:	e8 4e fc ff ff       	call   1005bb <console_putc>
  10096d:	eb 06                	jmp    100975 <console_vprintf+0x33e>
  10096f:	89 f0                	mov    %esi,%eax
  100971:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100975:	85 f6                	test   %esi,%esi
  100977:	7f e5                	jg     10095e <console_vprintf+0x327>
  100979:	8b 34 24             	mov    (%esp),%esi
  10097c:	eb 15                	jmp    100993 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  10097e:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100982:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100983:	0f b6 11             	movzbl (%ecx),%edx
  100986:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10098a:	e8 2c fc ff ff       	call   1005bb <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  10098f:	ff 44 24 04          	incl   0x4(%esp)
  100993:	85 f6                	test   %esi,%esi
  100995:	7f e7                	jg     10097e <console_vprintf+0x347>
  100997:	eb 0f                	jmp    1009a8 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100999:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10099d:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  1009a2:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1009a3:	e8 13 fc ff ff       	call   1005bb <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  1009a8:	85 ed                	test   %ebp,%ebp
  1009aa:	7f ed                	jg     100999 <console_vprintf+0x362>
  1009ac:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1009ae:	47                   	inc    %edi
  1009af:	8a 17                	mov    (%edi),%dl
  1009b1:	84 d2                	test   %dl,%dl
  1009b3:	0f 85 96 fc ff ff    	jne    10064f <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  1009b9:	83 c4 38             	add    $0x38,%esp
  1009bc:	89 f0                	mov    %esi,%eax
  1009be:	5b                   	pop    %ebx
  1009bf:	5e                   	pop    %esi
  1009c0:	5f                   	pop    %edi
  1009c1:	5d                   	pop    %ebp
  1009c2:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  1009c3:	81 e9 3c 0a 10 00    	sub    $0x100a3c,%ecx
  1009c9:	b8 01 00 00 00       	mov    $0x1,%eax
  1009ce:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1009d0:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  1009d1:	09 44 24 14          	or     %eax,0x14(%esp)
  1009d5:	e9 aa fc ff ff       	jmp    100684 <console_vprintf+0x4d>

001009da <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  1009da:	8d 44 24 10          	lea    0x10(%esp),%eax
  1009de:	50                   	push   %eax
  1009df:	ff 74 24 10          	pushl  0x10(%esp)
  1009e3:	ff 74 24 10          	pushl  0x10(%esp)
  1009e7:	ff 74 24 10          	pushl  0x10(%esp)
  1009eb:	e8 47 fc ff ff       	call   100637 <console_vprintf>
  1009f0:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  1009f3:	c3                   	ret    
