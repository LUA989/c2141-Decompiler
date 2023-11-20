
String romFile = "addtest.bin";

void setup() {
  byte[] rom = loadBytes(romFile);
  decompile(rom, romFile + "-d.asm");
}

void decompile(byte[] opcodes, String outputFile) {
  PrintWriter output = createWriter(outputFile);
  
  output.println("; This is decompiled program from binary ROM, not the original program");
  output.println("; Decompiled by original c2141 decompiler v1.0");
  output.println("; " + year() + '.' + month() + '.' + day() + " / " + hour() + ':' + minute());
  output.println();
  for(int i = 0; i < opcodes.length; i++) {
    byte opcode = (byte)((opcodes[i] >> 4) & 0xF);
    byte data = (byte)(opcodes[i] & 0xF);
    output.print("\t  ");
    
      switch(opcode) {
      case NOP:
      output.println("NOP");
      break;
      case NOT:
      output.println("NOT");
      break;
      case AND:
      output.println("AND " + getReg(byte(data & 7)));
      break;
      case OR:
      output.println("OR " + getReg(byte(data & 7)));
      break;
      case XOR:
      output.println("XOR " + getReg(byte(data & 7)));
      break;
      case ADD:
      output.println("ADD " + getReg(byte(data & 7)));
      break;
      case SUB:
      output.println("SUB " + getReg(byte(data & 7)));
      break;
      case LDA:
      output.println("LDA 0x" + hex(data, 1));
      break;
      case CFA:
      output.println("CFA " + getReg(byte(data & 7)));
      break;
      case JMP:
      output.println("JMP 0x" + hex(data, 1));
      break;
      case JC:
      output.println("JS 0x" + hex(data, 1));
      break;
      case JNC:
      output.println("JNC 0x" + hex(data, 1));
      break;
      case STC:
      output.println("STC");
      break;
      case CLC:
      output.println("CLC");
      break;
      case PSH:
      output.println("PSH");
      break;
      case POP:
      output.println("POP");
      break;
    }
  }
  output.flush();
  output.close();
}

String getReg(byte number) {
  String output = "";
  int rn = number & 0x7;
  switch(rn) {
    case A:
    output = "A";
    break;
    case R0:
    output = "R0";
    break;
    case R1:
    output = "R1";
    break;
    case R2:
    output = "R2";
    break;
    case PP:
    output = "PP";
    break;
    case SP:
    output = "SP";
    break;
    case OUT:
    output = "OUT";
    break;
    case FLAGS:
    output = "FLAGS";
    break;
  }
  return output;
}
