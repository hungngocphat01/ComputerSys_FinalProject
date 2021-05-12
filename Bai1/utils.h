#pragma once
#include <iostream>
#include <string>
#include <stdexcept>
#include <io.h>
#include <fcntl.h>
#include <exception>
using namespace std;

#define L 'L'
#define B 'B'
using uchar = unsigned char;

extern FILE* f;

// Hàm để đảo ngược môt mảng
template<class T>
static void reverseEndianess(T* arr, size_t n) {
    int i = 0;
    int j = n - 1;
    while (i < j) {
        swap(arr[i++], arr[j--]);
    }
}

static char chooseEndianess() {
    char c;
    do {
        cout << "LE hay BE? (nhap L hoac B): ";
        cin >> c;
        c = toupper(c);

        if (c != L && c != B) {
            cout << "Nhap khong dung!" << endl << endl;
            continue;
        }
    } while (false);

    return c;
}