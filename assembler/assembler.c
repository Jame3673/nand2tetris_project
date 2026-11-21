#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

#define MAX_LINES 100
#define MAX_LENGTH 100
#define MAX_DEST 10
#define MAX_COMP 10
#define MAX_JUMP 10

typedef struct C_table
{
    char *key;
    char *value;
} TABLE;

typedef struct
{
    char name[50];
    int rom_addr;
} SYMBOLTABLE;
SYMBOLTABLE symbolTable[100];
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

void addSymbol(const char* name, int rom_addr) {
    for (int i = 0; i < symbolCount; i++) {
        if (strcmp(symbolTable[i].name, name) == 0) {
            symbolTable[i].rom_addr = rom_addr;
            return;
        }
    }
    strcpy(symbolTable[symbolCount].name, name);
    symbolTable[symbolCount].rom_addr = rom_addr;
    symbolCount++;
}

int isBlank(const char* str) {
    while (*str != '\0')
    {
        if (!isspace((unsigned char)*str)) {
            return 0;
        }
        str++;
    }
    return -1;   
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

void intToBinary16(int value, char *binary_out) {
    binary_out[0] = '0'; // A-instruction first bit is 0
    for (int i = 14; i >= 0; i--) {
        binary_out[15 - i] = ((value >> i) & 1) ? '1' : '0';
    }
    binary_out[16] = '\0';
}

int getSymbolAddress(const char *name) {
    for (int i = 0; i < symbolCount; i++) {
        if (strcmp(symbolTable[i].name, name) == 0) {
            return symbolTable[i].rom_addr;
        }
    }
    return -1; // Không tìm thấy
}

int next_ram_addr = 16;


void A_translate(const char *line, char *binary_out) {
    const char *symbol = line + 1;
    int n = 0;
    
    if (isdigit((unsigned char)symbol[0])) {
        n = atoi(symbol);
    } else {
        n = getSymbolAddress(symbol);
        if (n == -1) {
            // Nếu không phải nhãn (LOOP) hay symbol mặc định -> là biến mới, cấp phát RAM từ 16
            n = next_ram_addr;
            addSymbol(symbol, n);
            next_ram_addr++;
        }
    }

    intToBinary16(n, binary_out);
}



void extractLabel(char lines[][MAX_LENGTH], int count) {
    int rom_addr = 0;
    for (int i = 0; i < count; i++)
    {
        if (lines[i][0] == '(')
        {
            char temp[50];
            int len = strlen(lines[i]);

            if (len > 2 && lines[i][len - 1] == ')')
            {
                strncpy(temp, lines[i] + 1, len - 2);
                temp[len - 2] = '\0';
                addSymbol(temp, rom_addr);
            }
        }
        else {
            rom_addr++;
        }
        
    }
    
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
    addSymbol("SCREEN", 16384);
    addSymbol("DISPLAY", 16384);
    addSymbol("KBD", 24576);
}


int main() {
    initPredefinedSymbols();

    FILE *file = fopen("file.txt", "r");
    if (file == NULL) {
        printf("ERROR: file not detected or cannot read!\n");
        return 1;
    }

    char lines[MAX_LINES][MAX_LENGTH];
    char temp[MAX_LENGTH];
    int count = 0;
    char binary[17];

    // Read file and don't read blank line, then add contain to lines[][]
    while (count < MAX_LINES && fgets(temp, MAX_LENGTH, file) != NULL)
    {
        removeComment(temp);
        trimstr(temp);
        removeSpace(temp);

        if (!isBlank(temp)) {
            strcpy(lines[count], temp);
            count++;
        }
    }
    
    fclose(file);


    extractLabel(lines, count);



    FILE *outfile = fopen("outfile.dat", "w");
    if (outfile == NULL) {
        printf("ERROR: can't create outfile.txt!\n");
        return 1;
    }

    for (int i = 0; i < count; i++) {
        if (lines[i][0] == '(') {
            continue; // Bỏ qua dòng nhãn (LOOP), không xuất ra file .dat
        } 
        else if (lines[i][0] == '@') {
            A_translate(lines[i], binary);
            fprintf(outfile, "%s\n", binary);
        } 
        else if (C_translate(lines[i], binary)) { // Dùng else if để không chạy đè sau @
            fprintf(outfile, "%s\n", binary);
        } 
        else {
            printf("Syntax error at line %d: %s\n", i + 1, lines[i]);
        }
    }
    
    

    fclose(outfile);

    return 0;
}