#include <stdio.h>
#include <string.h>

// 1. Định nghĩa cấu trúc Key - Value giống Dictionary trong Python
typedef struct {
    char *key;    // Tên lệnh Assembly (ví dụ: "M", "D", "JMP")
    char *value;  // Mã nhị phân tương ứng (ví dụ: "001", "010", "111")
} DictEntry;

// 2. Khởi tạo bảng tra cứu (Dictionary) cho phần DEST
DictEntry dest_table[] = {
    {"",    "000"},
    {"M",   "001"},
    {"D",   "010"},
    {"MD",  "011"},
    {"A",   "100"},
    {"AM",  "101"},
    {"AD",  "110"},
    {"AMD", "111"}
};

// 3. Hàm tra cứu giá trị theo Key (giống dict.get(key) trong Python)
const char* get_dest_code(const char *key) {
    // Tính tự động số phần tử trong bảng
    int size = sizeof(dest_table) / sizeof(dest_table);
    
    for (int i = 0; i < size; i++) {
        if (strcmp(dest_table[i].key, key) == 0) {
            return dest_table[i].value; // Tìm thấy -> trả về mã nhị phân
        }
    }
    return NULL; // Không tìm thấy
}

int main() {
    // Sử dụng thử như Dictionary:
    printf("Ma nhi phan cua AMD la: %s\n", get_dest_code("AMD")); // In ra: 111
    printf("Ma nhi phan cua D la: %s\n", get_dest_code("D"));     // In ra: 010
    return 0;
}
