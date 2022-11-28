//
//  Error.swift
//  MyCreditManager
//
//  Created by 김도현 on 2022/11/28.
//

enum InputError {
    case choiceInputError
    case badInputError
    
    var description: String {
        switch self {
        case .choiceInputError:
            return "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요"
        case .badInputError:
            return "입력이 잘못되었습니다. 다시 확인해주세요."
        }
    }
}

enum StudentManagerError {
    case studentNotFoundError
    case studentExistError
    
    func description(studentName: String) -> String {
        switch self {
        case .studentNotFoundError:
            return "\(studentName) 학생을 찾지 못했습니다."
        case .studentExistError:
            return "\(studentName)은 이미 존재하는 학생입니다. 추가하지 않습니다."
        }
    }
}
