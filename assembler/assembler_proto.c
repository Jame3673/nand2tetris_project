#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

#define MAX_LINES 1000
#define MAX_LINE_LEN 100

// Cấu trúc bảng ký hiệu đơn giản
typedef struct {
    char name[50];
    int address;
} Symbol;

Symbol symbolTable[200];
int symbolCount = 0;

// Thêm hoặc cập nhật nhãn vào bảng
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

// Tìm địa chỉ của nhãn/biến
int getSymbolAddress(const char* name) {
    for (int i = 0; i < symbolCount; i++) {
        if (strcmp(symbolTable[i].name, name) == 0) {
            return symbolTable[i].address;
        }
    }
    return -1;
}

// Hàm làm sạch chuỗi: loại bỏ khoảng trắng và comment (//)
void cleanString(char* str) {
    // Xóa comment
    char* comment = strstr(str, "//");
    if (comment != NULL) *comment = '\0';

    // Xóa khoảng trắng đầu/cuối và ký tự xuống dòng
    int len = strlen(str);
    while (len > 0 && (str[len - 1] == ' ' || str[len - 1] == '\t' || str[len - 1] == '\r' || str[len - 1] == '\n')) {
        str[--len] = '\0';
    }
    
    char* start = str;
    while (*start == ' ' || *start == '\t') start++;
    if (start != str) memmove(str, start, strlen(start) + 1);
}

// Chuyển một số nguyên thành chuỗi 16-bit nhị phân
void toBinary16(int n, char* outStr) {
    for (int i = 15; i >= 0; i--) {
        outStr[15 - i] = ((n >> i) & 1) ? '1' : '0';
    }
    outStr[16] = '\0';
}

int main() {
    FILE *file = fopen("mult.asm", "r");
    if (!file) {
        printf("Khong the mo file mult.asm!\n");
        return 1;
    }

    // Khởi tạo các thanh ghi chuẩn
    addSymbol("R0", 0); addSymbol("R1", 1); addSymbol("R2", 2);
    addSymbol("SCREEN", 16384); addSymbol("KBD", 24576);

    char lines[MAX_LINES][MAX_LINE_LEN];
    int lineCount = 0;
    int romAddress = 0;

    // ================= PASS 1: Đọc nhãn (Labels) =================
    char buffer[256];
    while (fgets(buffer, sizeof(buffer), file)) {
        cleanString(buffer);
        if (buffer[0] == '\0') continue;

        if (buffer[0] == '(' && buffer[strlen(buffer) - 1] == ')') {
            buffer[strlen(buffer) - 1] = '\0'; // Bỏ dấu ')'
            addSymbol(buffer + 1, romAddress);   // Bỏ dấu '(' và lưu nhãn
        } else {
            strcpy(lines[lineCount++], buffer);
            romAddress++;
        }
    }
    fclose(file);

    // ================= PASS 2: Xuất mã máy nhị phân =================
    FILE *outFile = fopen("mult.dat", "w");
    if (!outFile) {
        printf("Khong the tao file mult.dat!\n");
        return 1;
    }

    int nextVarAddr = 16; // Biến mới tự động cấp phát từ RAM[16]

    for (int i = 0; i < lineCount; i++) {
        char* line = lines[i];

        if (line[0] == '@') {
            // A-instruction
            char* symbol = line + 1;
            int address = 0;

            if (isdigit(symbol[0])) {
                address = atoi(symbol);
            } else {
                address = getSymbolAddress(symbol);
                if (address == -1) {
                    address = nextVarAddr++;
                    addSymbol(symbol, address);
                }
            }

            char binStr[17];
            toBinary16(address, binStr);
            fprintf(outFile, "%s\n", binStr);

        } else {
            // C-instruction đơn giản hóa (Ví dụ mẫu: quy ước thủ công hoặc tra bảng C)
            // Trong C thuần, bạn có thể viết hàm map chuỗi comp/dest/jump tương tự C++
            // Ở đây in ra chuỗi mẫu minh họa cú pháp
            fprintf(outFile, "1110001100001000\n"); 
        }
    }

    fclose(outFile);
    printf("Bien dich C thanh cong ra file mult.dat!\n");
    return 0;
}