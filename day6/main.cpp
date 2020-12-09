#include <fstream>
#include <iostream>
#include <vector>
#include <map>

std::vector<std::vector<std::string>> read_data(std::string filename) {
  using namespace std;
  auto stream = ifstream(filename);

  vector<vector<string>> data;
  string item;
  vector<string> current;

  while (!stream.eof()) {
    if (stream.peek() == '\n') {
      stream.ignore();
      if (stream.peek() == '\n') {
        data.push_back(current);
        current = vector<string>();
      }
    }
    stream >> item;
    if (!stream.eof()) {
      current.push_back(item);
    } else {
      data.push_back(current);
    }
  }

  return data;
}

int main(int argc, char** argv) {
  using namespace std;
  vector<vector<string>> data = read_data("input.data");

  int count = 0;
  int all_correct = 0;
  for (auto &group: data) {
    map<char, int> answers;
    for (auto &item: group) {
      for (auto &c: item) {
        if (answers.find(c) == answers.end()) {
          answers[c] = 1;
        } else {
          answers[c]++;
        }
      }
    }
    for (auto &key: answers) {
      if (key.second == group.size()) {
        all_correct++;
      }
    }
    count += answers.size();
  }
  cout << "Day 6, Part 1: Final count: " << count << endl;
  cout << "Day 6, Part 2: Final count: " << all_correct << endl;
}
