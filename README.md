# RARS Assembly Projects

## Overview

This repository contains several RISC-V assembly projects developed for use with the **RARS (RISC-V Assembler and Runtime Simulator)** environment. The primary focus is the `projekt.asm` file, demonstrating the ellipse-drawing algorithm using Bresenham's method.

---

## 🌟 **projekt.asm** (Ellipse Drawing with Bresenham's Algorithm)

### Description
`projekt.asm` implements the Bresenham Ellipse Drawing Algorithm, a highly efficient method for drawing ellipses. The algorithm uses integer arithmetic to determine pixel positions, optimizing rendering performance by avoiding floating-point calculations.

### Key Features:
- Implements Bresenham's algorithm for ellipse generation entirely in assembly.
- Produces a valid bitmap image file (`testout14.bmp`) containing the drawn ellipse.
- Manages the creation of bitmap headers (`BITMAPFILEHEADER` and `BITMAPINFOHEADER`) to ensure compatibility with standard image viewers.
- Offers practical insight into low-level pixel manipulation techniques in assembly language.

### How to Run `projekt.asm`

1. **Download RARS:**
   Obtain the latest RARS release from the [official repository](https://github.com/TheThirdOne/rars).

2. **Open `projekt.asm`:**
   - Launch RARS:
     ```bash
     java -jar RARS.jar
     ```
   - Load `projekt.asm` from the repository directory.
   - Assemble and run the program.

3. **View Generated Image:**
   The generated image (`testout14.bmp`) will be saved in the repository's directory and can be viewed using any standard image viewer.

---

## 📚 **Other Projects**

### **bubble_sort_string.asm**
- Implements the bubble sort algorithm to alphabetically sort strings.

### **bubble_sort_v2.asm**
- An optimized version of the bubble sort algorithm for sorting numerical values efficiently.

### **delete.asm**
- Demonstrates deletion operations within arrays or memory blocks, highlighting basic memory management in assembly.

### **delete.asm**
- Provides fundamental examples of deletion operations on arrays, showcasing memory manipulation and pointer arithmetic concepts.

### **sprawdzian1.asm**
- An educational or practice exercise to reinforce learning of fundamental RISC-V assembly concepts.

### **riscv1.asm**
- A basic introductory program demonstrating essential assembly instructions, suitable for beginners learning the RISC-V instruction set and syntax.

---

## 🚀 **Getting Started**

### **Prerequisites**
- [Java Runtime Environment (JRE)](https://www.java.com/)
- [RARS Simulator](https://github.com/TheThirdOne/rars)

### **Running the Projects**

1. Install Java Runtime Environment (JRE).
2. Download and launch [RARS](https://github.com/TheThirdOne/rars).
3. Load any `.asm` file from the repository.
4. Assemble and execute the program within RARS.
