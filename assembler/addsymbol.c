#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>


typedef struct {
    char name[50];
    int address;
} Symbol;

Symbol symbolTable[200];
int symbolCount = 0;

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

int main() {
    addSymbol("LOOP",5);
    addSymbol("LOOP",8);
    addSymbol("END",9);

    printf("All symbol: %d\n", symbolCount);
    for (int i = 0; i < symbolCount; i++)
    {
        printf("%d | %s %d\n", i, symbolTable[i].name, symbolTable[i].address);
    }
    
    
    
    return 0;
}