//
//  ViewController.swift
//  Quiz 02
//
//  Created by FredKopeika on 10/11/15.
//  Copyright © 2015 Paulopr4. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lbQuestion: UILabel!
    @IBOutlet weak var imgQuestion: UIImageView!
    @IBOutlet weak var btnAnswer1: UIButton!
    @IBOutlet weak var btnAnswer2: UIButton!
    @IBOutlet weak var btnAnswer3: UIButton!
    
    
    @IBOutlet weak var viewFeedback: UIView!
    @IBOutlet weak var lbFeedback: UILabel!
    @IBOutlet weak var btnFeedback: UIButton!
    
    var questions : [Question]! // vetor que contém as questões do quiz
    var currentQuestion = 0 // Int que idnca qual a questão atual
    var grade = 0.0         // Double para o cálculo da nota
    var quizEnded = false   // Bool que indica se o quiz terminou ou não
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let q0answer0 = Answer(answer: "120 anos", isCorrect: true)
        let q0answer1 = Answer(answer: "80 anos", isCorrect:  false)
        let q0answer2 = Answer(answer: "140 anos", isCorrect: false)
        let question0 = Question(question: "Quantos anos vive um elefante fricano?", strImageFileName: "elefante", answers: [q0answer0,q0answer1,q0answer2])
        
        let q1answer0 = Answer(answer: "5,5 m", isCorrect: true)
        let q1answer1 = Answer(answer: "3,5 m", isCorrect: false)
        let q1answer2 = Answer(answer: "4,5 m", isCorrect: false)
        let question1 = Question(question: "Quantos metros em média tem uma girafa macho adulta?", strImageFileName: "girafa", answers: [q1answer0,q1answer1,q1answer2])
        
        let q2answer0 = Answer(answer: "2300 kg", isCorrect: true)
        let q2answer1 = Answer(answer: "3300 kg", isCorrect: false)
        let q2answer2 = Answer(answer: "4300 kg", isCorrect: false)
        let question2 = Question(question: "Quanto pesa em média um rinoceronte-branco macho adulto?", strImageFileName: "rinoceronte", answers: [q2answer0,q2answer1,q2answer2])
        
        let q3answer0 = Answer(answer: "64 km /h", isCorrect: true)
        let q3answer1 = Answer(answer: "74 km /h", isCorrect: false)
        let q3answer2 = Answer(answer: "54 km /h", isCorrect: false)
        let question3 = Question(question: "Qual a velocidade de uma zebra?", strImageFileName: "zebra", answers: [q3answer0,q3answer1,q3answer2])
        
        questions = [question0,question1,question2,question3]
        
        startQuiz() // começa o quiz
        
        }
    
    // Função que reseta o Quiz
    
        func startQuiz(){
        questions.shuffle() // embaralha o vetor de questões
        for(var i=0; i<questions.count;i++) {
            questions[i].answers.shuffle() // embaralha o vetor de respostas para cada questão
        }
            
    // reseta as variáveis de progresso de do usuário
            quizEnded = false
            grade = 0.0
            currentQuestion = 0
            
            showQuestion(0) // mostra a primeira questão
    }
    
    // Função que atualiza os objetos da tela  com os dados do vetor de questões
    
    
    func showQuestion(questionid : Int) {
        
        btnAnswer1.enabled = true
        btnAnswer2.enabled = true
        btnAnswer3.enabled = true
        
        // atualiza o label de questão, imagem  e texto
        lbQuestion.text = questions[questionid].strQuestion
        imgQuestion.image = questions[questionid].imgQuestion
        btnAnswer1.setTitle(questions[questionid].answers[0].strAnswer, forState: UIControlState.Normal)
        btnAnswer2.setTitle(questions[questionid].answers[1].strAnswer, forState: UIControlState.Normal)
        btnAnswer3.setTitle(questions[questionid].answers[2].strAnswer, forState: UIControlState.Normal)
    }
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func chooseAnswer1(sender: AnyObject) {
        selectAnswer(0)
    }
    
    @IBAction func chooseAnswer2(sender: AnyObject) {
        selectAnswer(1)
    }
    
    @IBAction func chooseAnswer3(sender: AnyObject) {
        selectAnswer(2)
    }
    
    
    
    // Função que seleciona uma alternativa \\
    
    func selectAnswer(Answerid : Int){
        // desabilita botões de alternativa para que não se possa clicar 2 vezes
        btnAnswer1.enabled = false
        btnAnswer2.enabled = false
        btnAnswer3.enabled = false
        
        viewFeedback.hidden = false // mostra a view de feedback
        
        let answer : Answer = questions[currentQuestion].answers[Answerid] // seleciona resposta
        
        if(answer.isCorrect == true) {
            grade = grade + 1.0 // soma 1 ponto caso a resposta esteja correta
            lbFeedback.text = answer.strAnswer + "\n\nResposta correta!" // feedback: Correto
        }else{
            lbFeedback.text = answer.strAnswer + "\n\nResposta errada..." // feedBack: Errado
        }
        
        if(currentQuestion < questions.count-1) {
            // caso  a questao atual não seja a última, atualiz o texto do botão feedback para "Próxima"
            btnFeedback.setTitle("Próxima", forState: UIControlState.Normal)
            
        }else{
            
            //  Caso a questão atual seja última, atualiza o texto do botão feedback para "Ver Nota"
            btnFeedback.setTitle("Ver Nota", forState: UIControlState.Normal)
            
        }
    }

    
    @IBAction func btnFeedbackAction(sender: AnyObject) {
        
        viewFeedback.hidden = true // esconde view de feedback
        
        if(quizEnded){
            startQuiz() // se quiz terminou, recomeça
        }else{
            
            nextQuestion() // se não terminou, mostra próxima questao
        }
    }

    // Função que mostra a próxima questão ou o final do quiz \\
    
    func nextQuestion(){
        
        currentQuestion++ // incrementa em 1 o valor da vriável que questão atual
        
        if(currentQuestion < questions.count) {
            // se a questão atual è menor que o número total de questões, mostra a próxima
            showQuestion(currentQuestion)
        }else{
            // se a questão atual é igual o número total de questóes, termina quiz
            endQuiz()
        }
    }
    
    
    // Função que termina o quiz
    
    func endQuiz(){
        grade = grade / Double(questions.count) * 100.0 // cálculo da nota : de 0 a 100
        
        quizEnded = true // atualiza variável booleana que indica o término do quiz
        
        viewFeedback.hidden = false // mostra o view de feedback
        
        lbFeedback.text = "Sua nota: \(grade)" // atualiza texto de feedback mostrando a nota
        
        btnFeedback.setTitle("Refazer", forState: UIControlState.Normal) // atualiza texto do botão feedback
    }
    
    
}














    
    
    
    
    
    
    
    
    
    
    
    
    
    



