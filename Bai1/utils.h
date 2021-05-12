#pragma once
#include <iostream>
#include <string>
#include <stdexcept>
#include <io.h>
#include <fcntl.h>
#include <exception>
#include <Windows.h>

using namespace std;

#define L 'L'
#define B 'B'

typedef unsigned char uchar;

extern FILE* f;

// Hàm để đảo ngược môt mảng

static void reverseEndianess(uchar* arr, size_t n) {
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