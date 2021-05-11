#pragma once
#include "utils.h"

void writeBinary(uchar* buffer, size_t size) {
    // Endianess
    char e = chooseEndianess();

    if (f == nullptr) {
        throw runtime_error("File chua duoc mo!");
    }
    
    // Mặc định X86 là litte endian
    // Nếu người dùng chọn BE thì lật ngược các byte lại
    if (e == B) {
        reverseEndianess(buffer, size);
    }

    // Ghi vào file nhị phân mảng buffer với kích thước s
    fwrite(buffer, sizeof(uchar), size, f);
}

void nhapSoNguyenQuaK() {
    long long n;
    cout << "Nhap mot so nguyen: ";
    cin >> n;


    size_t s;
    cout << "Nhap kich thuoc so nguyen (byte): ";
    cin >> s;

    // Buffer để chứa các byte của n
    uchar* buffer;
    buffer = new uchar[s];

    int k;
    cout << "Nhap K: ";
    cin >> k;

    // Quá k
    n += k;

    // Copy s byte biểu diễn của n vào buffer
    memcpy(buffer, (uchar*)(&n), s);

    writeBinary(buffer, s);

    delete[] buffer;
}

void nhapSoNguyenBu2() {
    long long n;
    cout << "Nhap mot so nguyen: ";
    cin >> n;

    size_t s;
    cout << "Nhap kich thuoc so nguyen (byte): ";
    cin >> s;

    // Buffer để chứa các byte của n
    uchar* buffer;
    buffer = new uchar[s];

    memcpy(buffer, (uchar*)(&n), s);

    writeBinary(buffer, s);

    delete[] buffer;
}

void nhapSoThuc() {
    double r8;
    float r4;
    cout << "Nhap mot so thuc: ";
    cin >> r8;

    size_t s;
    do {
        cout << "Nhap kich thuoc so nguyen (byte) (4 hoac 8): ";
        cin >> s;

        if (s != 4 && s != 8) {
            cout << "Nhap khong dung!" << endl << endl;
            continue;
        }
    } while (false);

    // Buffer để chứa các byte của n
    uchar* buffer;
    buffer = new uchar[s];

    if (s == 4) {
        // Ép về kiểu nhỏ hơn
        r4 = static_cast<float>(r8);
        memcpy(buffer, (uchar*)(&r4), s);
    }
    else {
        memcpy(buffer, (uchar*)(&r8), s);
    }

    writeBinary(buffer, s);

    delete[] buffer;
}

void nhapChuoiASCII() {
    string s;
    size_t size;
    cout << "Nhap mot chuoi ki tu ASCII: ";
    fflush(stdin);
    getline(cin, s);

    size = s.length() + 1;

    uchar* buffer = new uchar[size];
    memcpy(buffer, s.c_str(), size);

    writeBinary(buffer, size);
}