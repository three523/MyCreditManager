//
//  MyCreditManager.swift
//  MyCreditManager
//
//  Created by 김도현 on 2022/11/28.
//

import Foundation

enum MyCreditManagerSelection: Int {
    case `default`
    case studentAdd
    case studentRemove
    case scoreAdd
    case scoreRemove
    case scoreAverage
    case exit
}

class MyCreditManager {
    
    let studentManager: StudentManager = StudentManager()
    var state: MyCreditManagerSelection = MyCreditManagerSelection.default
    
    func display() {
        switch state {
        case .default:
            print("원하는 기능을 입력해주세요")
            print("1: 학생추가, 2: 학생상제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
        case .studentAdd:
            print("추가할 학생의 이름을 입력해주세요.")
        case .studentRemove:
            print("삭제할 학생의 이름을 입력해주세요.")
        case .scoreAdd:
            print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
            print("입력예) Mickey Swift A+")
            print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        case .scoreRemove:
            print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
            print("입력예) Mickey Swift")
        case .scoreAverage:
            print("평점을 알고싶은 학생의 이름을 입력해주세요.")
        case .exit:
            print("프로그램을 종료합니다...")
            return
        }
        inputData()
    }
    
    func inputCheck(input: String?) {
        if let input = input {
            switch state {
            case .default:
                if !seletion(input: input) { print(InputError.choiceInputError.description) }
            case .studentAdd:
                if stringInputCheck(input: input) {
                    studentManager.addStudent(studentName: input)
                    state = .default
                } else {
                    print(InputError.badInputError)
                }
            case .studentRemove:
                if stringInputCheck(input: input) {
                    studentManager.removeStudent(studentName: input)
                    state = .default
                } else {
                    print(InputError.badInputError)
                }
            case .scoreAdd:
                if subjectInputCheck(input: input) {
                    let student = changeInput(input: input)
                    studentManager.addScore(student: student)
                    state = .default
                } else {
                    print(InputError.badInputError)
                }
            case .scoreRemove:
                if subjectInputCheck(input: input) {
                    let student = changeInput(input: input)
                    studentManager.removeScore(student: student)
                    state = .default
                } else {
                    print(InputError.badInputError)
                }
            case .scoreAverage:
                if stringInputCheck(input: input) {
                    if let average = studentManager.averageScore(studentName: input) {
                        print(average)
                    } else {
                        print("\(input) 학생은 존재하지 않습니다.")
                    }
                    state = .default
                } else {
                    print(InputError.badInputError)
                }
            case .exit:
                return
            }
        } else {
            print(InputError.badInputError)
        }
        display()
    }
    
    func inputData() {
        let input = readLine()
        inputCheck(input: input)
    }
    
    func selectionCheck(input: String) -> Bool {
        let diff = ["1","2","3","4","5","X","x"]
        return diff.contains(input)
        
    }
        
    private func seletion(input: String) -> Bool {
        if input == "1" {
            state = .studentAdd
        } else if input == "2" {
            state = .studentRemove
        } else if input == "3" {
            state = .scoreAdd
        } else if input == "4" {
            state = .scoreRemove
        } else if input == "5" {
            state = .scoreAverage
        } else if input == "X" || input == "x" {
            state = .exit
        } else {
            return false
        }
        return true
    }
    
    private func stringInputCheck(input: String) -> Bool {
        let strRegEx = "[A-z]"
        return input.range(of: strRegEx, options: .regularExpression) != nil
    }
    
    private func scoreInputCheck(input: String) -> Bool {
        let score = ["A+", "A", "B+", "B", "C+", "C", "D+", "D", "F"]
        return score.contains(input)
    }
    
    private func subjectInputCheck(input: String) -> Bool {
        let inputArr = input.split(separator: " ").map { String($0) }
        if state == .scoreAdd {
            guard inputArr.count == 3 else { return false }
            guard scoreInputCheck(input: inputArr[2]) else { return false }
        } else if state == .scoreRemove {
            guard inputArr.count == 2 else { return false }
        }
        guard stringInputCheck(input: String(inputArr[0])) else { return false }
        return true
    }
    
    private func changeInput(input: String) -> Student {
        let inputArr = input.split(separator: " ").map{ String($0) }
        
        if state == .scoreAdd {
            return Student(name: inputArr[0], subject: [inputArr[1]: inputArr[2]])
        }
        return Student(name: inputArr[0], subject: [inputArr[1]: ""])
    }
}
