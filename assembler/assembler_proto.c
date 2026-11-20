#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

#define MAX_LINES 1000
#define MAX_LENGTH 256
#define MAX_DEST 10
#define MAX_COMP 10
#define MAX_JUMP 10

typedef struct C_table
{
    char *key;
    char *value;
} TABLE;

typedef struct {
    char name[50];
    int address;
} Symbol;

Symbol symbolTable[200];
int symbolCount = 0;

TABLE dest_table[] = {
    {"",    "000"},
    {"M",   "001"},
    {"D",   "010"},
    {"MD",  "011"},
    {"A",   "100"},
    {"AM",  "101"},
    {"AD",  "110"},
    {"AMD", "111"}
};

TABLE comp_table[] = {
    {"0", "0101010"}, {"1", "0111111"}, {"-1", "0111010"}, {"D", "0001100"},
    {"A", "0110000"}, {"!D", "0001101"}, {"!A", "0110001"}, {"-D", "0001111"},
    {"-A", "0110011"}, {"D+1", "0011111"}, {"A+1", "0110111"}, {"D-1", "0001110"},
    {"A-1", "0110010"}, {"D+A", "0000010"}, {"D-A", "0010011"}, {"A-D", "0000111"},
    {"D&A", "0000000"}, {"D|A", "0010101"},
    // when a = 1
    {"M", "1110000"}, {"!M", "1110001"}, {"-M", "1110011"}, {"M+1", "1110111"},
    {"M-1", "1110010"}, {"D+M", "1000010"}, {"D-M", "1010011"}, {"M-D", "1000111"},
    {"D&M", "1000000"}, {"D|M", "1010101"}
};

TABLE jump_table[] = {
    {"", "000"}, {"JGT", "001"}, {"JEQ", "010"}, {"JGE", "011"},
    {"JLT", "100"}, {"JNE", "101"}, {"JLE", "110"}, {"JMP", "111"}
};

void addSymbol(const char* name, int address) {
    for (int i = 0; i < symbolCount; i++) {
        if (strcmp(symbolTable[i].name, name) == 0) {
            symbolTable[i].address = address;
            return;
        }
    }
    strcpy(symbolTable[symbolCount].name, name);
    symbolTable[symbolCount].address = address;
    symbolCount++;
}

int getSymbolAddress (const char *name) {
    for (int i = 0; i < symbolCount; i++)
    {
        if(strcmp(symbolTable[i].name, name) == 0) {
            return symbolTable[i].address;
        }
    }
    return -1;
}

void intToBinary16(int value, char *binary_out) {
    binary_out[0] = '0'; // Bit đầu tiên của A-instruction luôn là 0
    for (int i = 14; i >= 0; i--) {
        binary_out[15 - i] = ((value >> i) & 1) ? '1' : '0';
    }
    binary_out[16] = '\0';
}

void A_translate(const char *line, char *binary_out, int *next_ram_addr) {
    const char *symbol = line + 1;
    int address = 0;

    if (isdigit((unsigned char)symbol[0])) {
        // Trường hợp 1: Sau @ là hằng số (ví dụ: @2, @100)
        address = atoi(symbol);
    } else {
        address = getSymbolAddress(symbol);
        if (address == -1) {
            address = *next_ram_addr;
            addSymbol(symbol, address);
            (*next_ram_addr)++;
        }
    }

    intToBinary16(address, binary_out);
}

void initPredefinedSymbols() {
    char regName[10];
    for (int i = 0; i <= 15; i++) {
        snprintf(regName, sizeof(regName), "R%d", i);
        addSymbol(regName, i);
    }
    addSymbol("SP", 0);
    addSymbol("LCL", 1);
    addSymbol("ARG", 2);
    addSymbol("THIS", 3);
    addSymbol("THAT", 4);
    addSymbol("DISPLAY", 16384);
    addSymbol("KBD", 24576);
}

const char *checkTable(TABLE table[], int size, char *key) {
    for (int i=0; i < size; i++) {
        if (strcmp(table[i].key, key) == 0)
        {
            return table[i].value;
        }
    }
    return NULL;
}

void parce_c_instruction(const char *line, char *dest, char *comp, char *jump) {
    dest[0] = '\0';
    comp[0] = '\0';
    jump[0] = '\0';

    char *eq = strchr(line, '=');
    char *sc = strchr(line, ';');

    if (eq != NULL && sc != NULL) 
    {
        strncpy(dest, line, eq - line);
        dest[eq - line] = '\0';

        strncpy(comp, eq + 1, sc - (eq + 1));
        comp[sc - (eq + 1)] = '\0';

        strncpy(jump, sc + 1, strlen(sc+1) + 1);
    } else if (eq != NULL)
    {
        strncpy(dest, line, eq - line);
        dest[eq-line] = '\0';

        strncpy(comp, eq + 1, strlen(eq+1) + 1);
    } else if (sc != NULL)
    {
        strncpy(comp, line, sc - line);
        comp[sc - line] = '\0';

        strncpy(jump, sc + 1, strlen(sc + 1) + 1);
    } else
    {
        strncpy(comp, line, strlen(line) + 1);
    }
}

int C_translate(const char *line, char *binary_out) {
    char dest[MAX_DEST], comp[MAX_COMP], jump[MAX_JUMP];

    parce_c_instruction(line,dest,comp,jump);

    const char *dest_bin = checkTable(dest_table, sizeof(dest_table)/sizeof(TABLE), dest);
    const char *comp_bin = checkTable(comp_table, sizeof(comp_table)/sizeof(TABLE), comp);
    const char *jump_bin = checkTable(jump_table, sizeof(jump_table)/sizeof(TABLE), jump);

    if (dest_bin == NULL || comp_bin == NULL || jump_bin == NULL) {
        return 0;
    }

    snprintf(binary_out, 17, "111%s%s%s", comp_bin, dest_bin, jump_bin);
    return 1;
}


void removeSpace (char *str) {
    int len = strlen(str);
    int j =0;

    for (int i = 0; i < len; i++ ) {
        if (str[i] != ' ')
        {
            str[j] = str[i];
            j++;
        }
    }

    str[j] = '\0';
}

int isBlankLine(const char *str) {
    char ch;

    do
    {
        ch = *(str++);

        // Check non whitespace character
        if(ch != ' ' && ch != '\t' && ch != '\n' && ch != '\r' && ch != '\0')
            return 0;

    } while (ch != '\0');

    return 1;
}

void removeComment(char *str) {
    char *comment = strstr(str, "//");
    if (comment != NULL){
        *comment = '\0';
    }
}

void trimstr(char *str) {
    char *start = str;
    while ( *start == ' ' ||
            *start == '\t'||
            *start == '\r'||
            *start == '\n') start++;
    if (start != str) memmove(str, start, strlen(start) + 1);

    if (*str == '\0') return;

    char *end = str + strlen(str) - 1;
    while(  end >= str && (
            *end == ' ' ||
            *end == '\n' ||
            *end == '\r' ||
            *end == '\t' )) end--;
    *(end + 1) = '\0';
}

int main() {
    FILE *file = fopen("file.txt", "r");
    if (file == NULL) {
        printf("ERROR: file not detected or cannot read!\n");
        return 1;
    }

    char lines[MAX_LINES][MAX_LENGTH];
    char temp[MAX_LENGTH];
    int count = 0;
    char binary[17];
    int next_ram_addr = 16;

    // Read file and don't read blank line, then add contain to lines[][]
    while (count < MAX_LINES && fgets(temp, MAX_LENGTH, file) != NULL)
    {
        removeComment(temp);
        trimstr(temp);
        removeSpace(temp);

        if (!isBlankLine(temp)) {
            temp[strcspn(temp, "\r\n")] = '\0';
            strcpy(lines[count], temp);
            count++;
        }
    }
    
    fclose(file);

    int rom_address = 0;
    for (int i = 0; i < count; i++) {
        if (lines[i][0] == '(') {
            char label_name[50];
            int len = strlen(lines[i]);
            strncpy(label_name, lines[i] + 1, len - 2);
            label_name[len - 2] = '\0';

            addSymbol(label_name, rom_address);
        } else {
            rom_address++; // Chỉ tăng địa chỉ ROM cho lệnh thật (A và C)
        }
    }

    FILE *outfile = fopen("outfile.dat", "w");
    if (outfile == NULL) {
        printf("ERROR: can't create outfile.txt!\n");
        return 1;
    }

    for (int i = 0; i < count; i++) {
        if (lines[i][0] == '(') {
            // 1. Tách lấy tên nhãn bên trong cặp ngoặc (ví dụ: "(LOOP)" -> "LOOP")
            char label_name[MAX_LENGTH];
            int len = strlen(lines[i]);
            strncpy(label_name, lines[i] + 1, len - 2);
            label_name[len - 2] = '\0';

            // 2. Lấy địa chỉ ROM đã lưu ở Pass 1 và xuất ra định dạng @<HEX> của Verilog
            int label_addr = getSymbolAddress(label_name);
            fprintf(outfile, "@%04X\n", label_addr); 
        } 
        else if (lines[i][0] == '@') {
            // Dịch A-instruction (ví dụ: @LOOP sẽ dịch cùng giá trị label_addr sang 16-bit)
            A_translate(lines[i], binary, &next_ram_addr);
            fprintf(outfile, "%s\n", binary);
        } 
        else {
            // Dịch C-instruction
            if (C_translate(lines[i], binary)) {
                fprintf(outfile, "%s\n", binary);
            } else {
                printf("Syntax error at line %d: %s\n", i + 1, lines[i]);
            }
        }
    }

    fclose(outfile);

    return 0;
}