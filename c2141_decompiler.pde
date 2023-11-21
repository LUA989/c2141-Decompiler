
void setup() {
  byte[] rom = loadBytes("addtest.bin");
  decompile(rom, "decomp.asm");
}

void decompile(byte[] opcodes, String outputFile) {
  PrintWriter output = createWriter(outputFile);
  
  println("Decompiling...");
  
  output.println("; This is decompiled program from binary ROM, not the original program!");
  output.println("; Decompiled by original c2141 decompiler v1.1");
  output.println("; " + year() + '.' + month() + '.' + day() + ' ' + hour() + ':' + minute());
  output.println();
  
  for(int i = 0; i < opcodes.length; i++) {
    byte opcode = (byte)((opcodes[i] >> 4) & 0xF);
    byte data = (byte)(opcodes[i] & 0xF);
    output.print("    ");
    
      switch(opcode) {
      case NOP:
      output.print("NOP");
      break;
      case NOT:
      output.print("NOT");
      break;
      case AND:
      output.print("AND " + getReg(byte(data & 7)));
      break;
      case OR:
      output.print("OR " + getReg(byte(data & 7)));
      break;
      case XOR:
      output.print("XOR " + getReg(byte(data & 7)));
      break;
      case ADD:
      output.print("ADD " + getReg(byte(data & 7)));
      break;
      case SUB:
      output.print("SUB " + getReg(byte(data & 7)));
      break;
      case LDA:
      output.print("LDA 0x" + hex(data, 1));
      break;
      case CFA:
      output.print("CFA " + getReg(byte(data & 7)));
      break;
      case JMP:
      output.print("JMP 0x" + hex(data, 1));
      break;
      case JC:
      output.print("JS 0x" + hex(data, 1));
      break;
      case JNC:
      output.print("JNC 0x" + hex(data, 1));
      break;
      case STC:
      output.print("STC");
      break;
      case CLC:
      output.print("CLC");
      break;
      case PSH:
      output.print("PSH");
      break;
      case POP:
      output.print("POP");
      break;
    }
    
    output.println("    ; 0x" + hex(opcodes[i]));
  }
  println("Done!");
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
