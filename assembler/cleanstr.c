#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

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

int main() {
    char test[][50] = {
        "   D=M   ",                         // Khoảng trắng thừa cả đầu và cuối
        "  @R0 // Nạp giá trị ban đầu   ",     // Có lệnh, có comment và khoảng trắng
        "// Chỉ có comment ở đây",            // Dòng chỉ chứa comment
        "(LOOP)\t\t",                          // Có nhãn và tab ở cuối
        "   MD=D+1 ; JMP // Nhảy vô điều kiện " // Câu lệnh phức tạp + comment
    };

    int numTest = sizeof(test) / sizeof(test[0]);

    for (int i = 0; i < numTest; i++)
    {
        printf("before cleaning: [%s]\n", test[i]);
        cleanString(test[i]);
        printf("After cleaning: [%s]\n", test[i]);
    }
    

    return 0;
}