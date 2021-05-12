#pragma once
#include "utils.h"

void readBinary(uchar* buffer, size_t size) {
    fread(buffer, sizeof(uchar), size, f);

    // Nếu người dùng chọn big endian thì đảo ngược lại
    if (chooseEndianess() == B) {
        reverseEndianess(buffer, size);
    }
}

void docSoNguyenQuaK() {
    int k;
    cout << "Nhap K: ";
    cin >> k;
    
    size_t kt;
    cout << "Nhap kich thuoc (so byte): ";
    cin >> kt;

    uchar* buffer = new uchar[kt];
    readBinary(buffer, kt);

    long long n = 0;

    // Lấy ra byte đầu tiên
    // Do little endian nên byte đầu nằm ở cuối buffer
    char first = buffer[kt - 1];
    // Lấy bit dấu
    char neg = (first & 0b1000000) >> 7;

    if (neg) {
        n = -1;
    }

    memcpy((uchar*)(&n), buffer, kt);

    cout << "So nguyen doc duoc: " << n - k << endl;

    delete[] buffer;
}

void docSoNguyenBu2() {
    size_t kt;
    cout << "Nhap kich thuoc (so byte): ";
    cin >> kt;

    uchar* buffer = new uchar[kt];
    readBinary(buffer, kt);

    long long n = 0;

    // Lấy ra byte đầu tiên
    // Do little endian nên byte đầu nằm ở cuối buffer
    char first = buffer[kt - 1];
    // Lấy bit dấu
    char neg = (first & 0b10000000) >> 7;

    if (neg) {
        n = -1;
    }

    memcpy((uchar*)(&n), buffer, kt);

    cout << "So nguyen doc duoc: " << n << endl;

    delete[] buffer;
}

void docSoThuc() {
    double r8;
    float r4;

    size_t kt;
    do {
        cout << "Nhap kich thuoc so thuc (byte) (4 hoac 8): ";
        cin >> kt;

        if (kt != 4 && kt != 8) {
            cout << "Nhap khong dung!" << endl << endl;
            continue;
        }
    } while (false);

    uchar* buffer = new uchar[kt];
    readBinary(buffer, kt);

    cout << "So thuc doc duoc la: ";

    if (kt == 4) {
        memcpy((uchar*)(&r4), buffer, kt);
        cout << r4 << endl;
    }
    else {
        memcpy((uchar*)(&r8), buffer, kt);
        cout << r8 << endl;
    }

    delete[] buffer;
}

void docChuoiASCII() {
    size_t n;
    cout << "Nhap kich thuoc chuoi (khong bao gom ki tu \\0): ";
    cin >> n;
    n++;

    uchar* buffer = new uchar[n];

    readBinary(buffer, n);

    cout << "Chuoi doc duoc: " << buffer << endl;

    delete[] buffer;
}

void docChuoiUTF16() {
    cout << "Chua duoc implement" << endl;
}