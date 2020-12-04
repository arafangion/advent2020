#include "stdio.h"
#include "string.h"
#include "stdlib.h"

int only_contains(char* haystack, int haystack_len, char* needle, int needle_len) {
  for(int h = 0; h < haystack_len; h++) {
    int found = 0;
    for(int n  = 0; n < needle_len; n++) {
      if (haystack[h] == needle[n]) {
        found = 1;
        break;
      }
    }
    if (found == 0) {
      return 0;
    }
  }
  return 1;
}

int validate(int mode, char* byr, char* iyr, char* eyr, char* hgt, char* hcl, char* ecl, char* pid, char* cid) {

  if (mode == 0) {
    if (byr[0] == 0) { return 0; }
    if (iyr[0] == 0) { return 0; }
    if (eyr[0] == 0) { return 0; }
    if (hgt[0] == 0) { return 0; }
    if (hcl[0] == 0) { return 0; }
    if (ecl[0] == 0) { return 0; }
    if (pid[0] == 0) { return 0; }
  //if (cid[0] == 0) { return 0; }
    return 1;
  }

  if (byr[0] == 0) { return 0; } else {
    if (strcmp(byr, "1920") < 0) {
      return 0;
    }
    if (strcmp(byr, "2002") > 0) {
      return 0;
    }
  }
  if (iyr[0] == 0) { return 0; } else {
    if (strcmp(iyr, "2010") < 0) {
      return 0;
    }
    if (strcmp(iyr, "2020") > 0) {
      return 0;
    }
  }
  if (eyr[0] == 0) { return 0; } else {
    if (strcmp(eyr, "2020") < 0) {
      return 0;
    }
    if (strcmp(eyr, "2030") > 0) {
      return 0;
    }
  }

  if (hgt[0] == 0) { return 0; } else {
    int len = strlen(hgt);
    int num = atoi(hgt);
    if (strcmp(hgt+(len-2), "in") == 0) {
      if (num < 59) { return 0; }
      if (num > 76) { return 0; }
    } else if (strcmp(hgt+(len-2), "cm") == 0) {
      if (num < 150) { return 0; }
      if (num > 193) { return 0; }
    } else { return 0; }
  }
  if (hcl[0] == 0) { return 0; } else {
    int len = strlen(hcl);
    if (len != 7 || hcl[0] != '#') { return 0; }
    if (!only_contains(hcl+1, len-1, "0123456789abcdef", 16)) {
      printf("Failed: >%s<\n", hcl);
      return 0;
    }
  }
  if (ecl[0] == 0) { return 0; } else {
    if (strcmp(ecl, "amb") == 0 ||
        strcmp(ecl, "blu") == 0 ||
        strcmp(ecl, "brn") == 0 ||
        strcmp(ecl, "gry") == 0 ||
        strcmp(ecl, "grn") == 0 ||
        strcmp(ecl, "hzl") == 0 ||
        strcmp(ecl, "oth") == 0) {
      // Great!
    } else {
      return 0;
    }
  }
  if (pid[0] == 0) { return 0; } else {
    int len = strlen(pid);
    if (len != 9) { return 0; }
    if (!only_contains(pid, len, "0123456789", 10)) { return 0; }
  }
//if (cid[0] == 0) { return 0; }

  return 1;
}

void tokcpy(char* target, char* source, int count) {
  source += 4;
  memcpy(target, source, count-4);
  if (target[count-4-2] == '\n') {
    target[count-4-2] = 0;
  }
}

int validator_main(int mode) {
  FILE* input_file = fopen("input.data", "rb");
  char line[4000] = {0}; // Surely, no lines are longer than this...

  char byr[100] = {0}; // Birth Year
  char iyr[100] = {0}; // Issue Year
  char eyr[100] = {0}; // Expiration year
  char hgt[100] = {0}; // Height
  char hcl[100] = {0}; // Hair Colour
  char ecl[100] = {0}; // Eye Colour
  char pid[100] = {0}; // Passport ID
  char cid[100] = {0}; // Country ID - Optional

  int valid = 0;
  int invalid = 0;

  for(int line_no = 0; ; line_no++) {
    if ((fgets(line, sizeof(line), input_file) == 0) ||
        (line[0] == '\n')) {
      int result = validate(mode, byr, iyr, eyr, hgt, hcl, ecl, pid, cid);
      if (result) {
        valid++;
      } else {
        invalid++;
      }
      byr[0] = 0; // Birth Year
      iyr[0] = 0; // Issue Year
      eyr[0] = 0; // Expiration year
      hgt[0] = 0; // Height
      hcl[0] = 0; // Hair Colour
      ecl[0] = 0; // Eye Colour
      pid[0] = 0; // Passport ID
      cid[0] = 0; // Country ID - Optional

      if (line[0] != '\n') {
        break;
      }
    } else {
      char * tok = strtok(line, " ");
      while ( 0 != tok) {
        if (0 == strncmp("byr:", tok, 4)) {
          tokcpy(byr, tok, strlen(tok)+1);
        }
        if (0 == strncmp("iyr:", tok, 4)) {
          tokcpy(iyr, tok, strlen(tok)+1);
        }
        if (0 == strncmp("eyr:", tok, 4)) {
          tokcpy(eyr, tok, strlen(tok)+1);
        }
        if (0 == strncmp("hgt:", tok, 4)) {
          tokcpy(hgt, tok, strlen(tok)+1);
        }
        if (0 == strncmp("hcl:", tok, 4)) {
          tokcpy(hcl, tok, strlen(tok)+1);
        }
        if (0 == strncmp("ecl:", tok, 4)) {
          tokcpy(ecl, tok, strlen(tok)+1);
        }
        if (0 == strncmp("pid:", tok, 4)) {
          tokcpy(pid, tok, strlen(tok)+1);
        }
        if (0 == strncmp("cid:", tok, 4)) {
          tokcpy(cid, tok, strlen(tok)+1);
        }

        tok = strtok(0, " ");
      }
    }
  }

  if (mode == 0) {
    printf("Day 4 Part 1: Valid: %d\n", valid);
  } else {
    printf("Day 4 Part 2: Valid: %d\n", valid);
  }
  return 0;
}

int main() {
  validator_main(0);
  validator_main(1);
  return 0;
}
