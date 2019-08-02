## SudokuBoard

[![CodeFactor](https://www.codefactor.io/repository/github/leonthemisfit/sudokuboard/badge)](https://www.codefactor.io/repository/github/leonthemisfit/sudokuboard)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/d85cf8ce3dd94bf791022e76b93f2963)](https://www.codacy.com/app/leonthemisfit/SudokuBoard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=leonthemisfit/SudokuBoard&amp;utm_campaign=Badge_Grade)

This project is designed to provide a means to work with Sudoku puzzles as well as serialization and deserialization. Through a few basic methods and classes this library provides a simple interface for working puzzles.

Whether you want to write a sudoku solver or an app to play sudokus, this library provides the functionality you need to do so. While it is basic its simplicity also makes working with it very simple.

### Warning

The serialization methods included in this library use YAML and Marshal to create yaml boards and binary boards respectively. The restoring of objects from these two sources can result in code injection allowing for remote code execution. It is not recommended that you use these two serialization methods to distribute your boards. Instead, use the raw method which creates a simple text file with the board. It will not contain all the information on the board, specifically pencil marks, but it is not subject to the issues of using yaml or binary files. **If you choose to ignore this warning I am not liable for any damages that occur as a result. You use these methods at your own risk.**

So why are these methods of serialization there if they're unsafe?

The goal of these methods is to have a mechanism to save and restore game progress. These were chosen over custom serialization formats to keep the library small and simple. When the input is trusted or from a trusted source they are very fast and convenient ways to reconstruct objects from files. They are not intended to be used as a means to distribute puzzle boards that the library can understand. For that the raw method is better suited as it is a custom serialization method that contains the basic puzzle in the form of values. It does not, however, contain things like pencil marks as this is a much simpler serialization.