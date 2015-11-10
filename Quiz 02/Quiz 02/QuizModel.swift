//
//  QuizModel.swift
//  Quiz 02
//
//  Created by FredKopeika on 10/11/15.
//  Copyright © 2015 Paulopr4. All rights reserved.
//

import Foundation
import UIKit

class Question {
    var strQuestion : String!  // String para armazenar o texto da questão
    var imgQuestion : UIImage! // UIImage para armazenar a imagem para ilustra a pergunta
    var answers : [Answer]! // Vetor de objjetos da classe Answer para armazenar as respostas
    
    // Função  que inicializa o objeto da classe Question
    init(question : String, strImageFileName : String, answers : [Answer]){
        self.strQuestion = question
        self.imgQuestion = UIImage(named: strImageFileName)
        self.answers = answers
        
    }
    
}

class Answer {
    var strAnswer : String! // String para armazenar o texto da resposta
    var isCorrect : Bool // Booleana para armazenar se a resposta é correta ou não
    
    // função que inicializa o objeto da classe Answer
    init(answer : String, isCorrect : Bool){
        self.strAnswer = answer
        self.isCorrect = isCorrect
    }
}