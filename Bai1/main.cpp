#include "write.h"
#include "read.h"

#define LINE "------------------------------\n"
FILE* f = nullptr;

#define FILENAME "test.bin"

void showReadMenu() {
    fopen_s(&f, FILENAME, "rb");

    cout << LINE;
    cout << "1. So nguyen qua K kich thuoc N byte." << endl;
    cout << "2. So nguyen bu 2 kich thuoc N byte." << endl;
    cout << "3. So thuc cham dong 4/8 byte." << endl;
    cout << "4. Chuoi ASCII." << endl;
    cout << "5. Chuoi UTF16." << endl;
    cout << "Lua chon: ";
    int choice;
    cin >> choice;

    cout << "Nhap offset: ";
    int offset;
    cin >> offset;

    if (f != nullptr)
        fseek(f, offset, SEEK_SET);
    else
        throw runtime_error("File chua duoc mo!");

    cout << LINE;
    if (choice == 1) {
        docSoNguyenQuaK();
    }
    else if (choice == 2) {
        docSoNguyenBu2();
    }
    else if (choice == 3) {
        docSoThuc();
    }
    else if (choice == 4) {
        docChuoiASCII();
    }
    else if (choice == 5) {
        
    }
    else {
        cout << "Nhap khong dung lua chon!" << endl;
        system("pause");
    }

    if (f != nullptr)
        fclose(f);
    
    system("pause");
}

void showWriteMenu() {
    fopen_s(&f, FILENAME, "ab");

    cout << LINE;
    cout << "1. So nguyen qua K kich thuoc N byte." << endl;
    cout << "2. So nguyen bu 2 kich thuoc N byte." << endl;
    cout << "3. So thuc cham dong 4/8 byte." << endl;
    cout << "4. Chuoi ASCII." << endl;
    cout << "5. Chuoi UTF16." << endl;
    cout << "Lua chon: ";
    int choice;
    cin >> choice;

    cout << LINE;
    if (choice == 1) {
        nhapSoNguyenQuaK();
    }
    else if (choice == 2) {
        nhapSoNguyenBu2();
    }
    else if (choice == 3) {
        nhapSoThuc();
    }
    else if (choice == 4) {
        nhapChuoiASCII();
    }
    else if (choice == 5) {
        nhapChuoiUTF16();
    }
    else {
        cout << "Nhap khong dung lua chon!" << endl;
        system("pause");
    }
    fclose(f);
}

int main() {
    // Xoá nội dung file
    bool erase;

    cout << "Ban co muon xoa noi dung file " << FILENAME << "? (nhap 1 hoac 0): ";
    cin >> erase;

    if (erase) {
        fopen_s(&f, FILENAME, "wb");
        fclose(f);
    }

    do {
        system("cls");
        cout << "Do an mon hoc: He thong may tinh" << endl;
        cout << "" << endl;
        cout << "" << endl;
        cout << LINE;

        cout << "1. Doc" << endl;
        cout << "2. Ghi" << endl;
        cout << "0. Thoat" << endl;
        cout << "Lua chon: ";

        int rw;
        cin >> rw;

        if (rw == 0) {
            break;
        }
        else if (rw == 1) {
            showReadMenu();
        }
        else if (rw == 2) {
            showWriteMenu();
        }
        else {
            cout << "Nhap khong dung lua chon!" << endl;
            system("pause");
            continue;
        }
        continue;
    } while (true);
    
}