// created by Krzysztof Barałkiewicz at 2024/04/30 15:14.
//
// krzysztof@baralkeiwicz.pl

#include <iostream>
#include <fstream>
#include <vector>
#include <cstdint>

/*

rozszerzenie 2B 0x42 0x4D
rozmiar 4B 0x9F
reserved 4B 0x00
offset 4B 0x1A
wielkość headera 4B 0x10
width 2B 0x08
height 2B 0x08
planes 2B 0x01
bits per pixel 2B 0x08
czarny 2B 0x00 0x00
biały 2B 0xFF 0xFF

*/

int main() {

    std::ofstream file;

    file.open("example.bmp", std::ios::binary);

    if(!file) {
        std::cerr << "Failed to open file." << std::endl;
        return -1;
    }

    uint32_t size {0x1A};
    uint32_t reserved {0};
    uint32_t offset {0x1A};
    uint32_t headerSize {0x0C};
    uint16_t width  {8};
    uint16_t height {8};
    uint16_t planes {1};
    uint16_t bpp {0x10};

    uint16_t black {0xffff};
    uint16_t white {0x0000};

    char b {'B'};
    char m {'M'};

    uint16_t elipse_a {300};
    uint16_t elipse_b {300};

    int16_t padding_a {0};
    int16_t padding_b {0};

    height = elipse_b*2 + padding_b * 2 + 1;
    width = elipse_a*2 + padding_a * 2 + 1;

    size += height * width * 2 + height;

    std::cout << "Height: " << height << std::endl;
    std::cout << "Width: " << width << std::endl;
    std::cout << "Size: " << size << std::endl;

    file.write((const char*)&b, sizeof(b));
    file.write((const char*)&m, sizeof(m));
    file.write((const char*)&size, sizeof(size));
    file.write((const char*)&reserved, sizeof(reserved));
    file.write((const char*)&offset, sizeof(offset));
    file.write((const char*)&headerSize, sizeof(headerSize));
    file.write((const char*)&width, sizeof(width));
    file.write((const char*)&height, sizeof(height));
    file.write((const char*)&planes, sizeof(planes));
    file.write((const char*)&bpp, sizeof(bpp));

    std::vector<uint16_t> pixels((width + 1) * height, white);

    int a2 = elipse_a * elipse_a;
    int b2 = elipse_b * elipse_b;
    int fa2 = 4 * a2, fb2 = 4 * b2;

    int x = 0, y = elipse_b;
    int x_half = elipse_a + padding_a;
    int y_half = elipse_b + padding_b;

    // First phase of drawing the ellipse
    int d1 = b2 - a2 * elipse_b + a2 / 4;
    while (fb2 * x <= fa2 * y) {
        pixels[(x + x_half) + (y + y_half) * (width + 1)] = black;
        pixels[(-x + x_half) + (y + y_half) * (width + 1)] = black;
        pixels[(x + x_half) + (-y + y_half) * (width + 1)] = black;
        pixels[(-x + x_half) + (-y + y_half) * (width + 1)] = black;
        std::cout << "Drawing x: " << x << " y: " << y << std::endl;
        if (d1 < 0) {
            x++;
            d1 += fb2 * x + b2;
        } else {
            x++;
            y--;
            d1 += fb2 * x - fa2 * y + b2;
        }
    }

    // Second phase of drawing the ellipse
    int d2 = b2 * (x + 1) * (x + 1) + a2 * (y - 1) * (y - 1) - a2 * b2;
    while (y >= 0) {
        pixels[(x + x_half) + (y + y_half) * (width + 1)] = black;
        pixels[(-x + x_half) + (y + y_half) * (width + 1)] = black;
        pixels[(x + x_half) + (-y + y_half) * (width + 1)] = black;
        pixels[(-x + x_half) + (-y + y_half) * (width + 1)] = black;
        std::cout << "Drawing x: " << x << " y: " << y << std::endl;

        if (d2 > 0) {
            y--;
            d2 += a2 - fa2 * y;
        } else {
            y--;
            x++;
            d2 += fb2 * x - fa2 * y + a2;
        }
    }

    //adding paddding
    // for(int i = 0; i < height; i++){
    //     pixels[i * width + width ] = 0xFFFF;
    // }

    for(uint16_t it : pixels){
        file.write((const char*)&it, sizeof(it));
    }
    
    file.close();

    std::cout << "Yes" << std::endl;

    return 0;
}
