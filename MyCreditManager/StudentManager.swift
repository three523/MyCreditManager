//
//  StudentManager.swift
//  MyCreditManager
//
//  Created by 김도현 on 2022/11/28.
//

class StudentManager {
    
    private var students: [Student] = []
    
    func addStudent(studentName: String) {
        if isExist(studentName: studentName) {
            print(StudentManagerError.studentExistError.description(studentName: studentName))
            return
        }
        students.append(Student(name: studentName, subject: [:]))
        print("\(studentName)을 추가하였습니다.")
    }
    
    func removeStudent(studentName: String) {
        if isExist(studentName: studentName) {
            students.removeAll { $0.name == studentName }
            print("\(studentName) 학생을 삭제하였습니다.")
            return
        }
        print(StudentManagerError.studentNotFoundError.description(studentName: studentName))
    }
    
    func addScore(student: Student) {
        if isExist(studentName: student.name) {
            let index = students.firstIndex { $0.name == student.name }
            let key = student.subject.keys.first!
            students[index!].subject[key] = student.subject[key]
            print("추가(변경) 되었습니다.")
            return
        }
        print("\(student.name)은 존재하지 않습니다.")
    }
    
    func removeScore(student: Student) {
        if isExist(studentName: student.name) {
            let index = students.firstIndex { $0.name == student.name }
            let key = student.subject.keys.first!
            students[index!].subject.removeValue(forKey: key)
            print("삭제 되었습니다.")
            return
        }
        print(StudentManagerError.studentNotFoundError.description(studentName: student.name))
    }
    
    func averageScore(studentName: String) -> Double? {
        let student = students.first { $0.name == studentName }
        var sum = 0.0
        var count = 0.0
        if let student = student {
            student.subject.forEach { subject, score in
                if score != "" {
                    print("\(subject): \(score)")
                    sum += scoreChange(strScore: score)
                    count += 1
                }
            }
            return sum == 0.0 ? 0.0 : sum / count
        }
        return nil
    }
    
    private func scoreChange(strScore: String) -> Double {
        let score = ["A+": 4.5, "A": 4.0, "B+": 3.5, "B": 3.0, "C+": 2.5, "C": 2.0, "D+": 1.5, "D": 1.0, "F": 0.0]
        return score[strScore] ?? 0.0
    }
        
    private func isExist(studentName: String) -> Bool {
        return students.contains{$0.name == studentName}
    }
}
