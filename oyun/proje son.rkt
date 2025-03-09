;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |proje son|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; ======================================================================================================================================================================

; structure: position
; property: x(number): x coordinate of the position
; property: y(number): y coordinate of the position
(define-struct position(x y) )


; structure: velocity
; property: x(number): velocity in x axis
; property: y(number): velocity in y axis
(define-struct velocity(x y) )


; structure: theCar
; property: pos(pos): position of the car
; proverty: im(image): image of the car
(define-struct theCar (pos im) )


; structure: obstacle
; property: pos(pos): position of the obstacle
; property: vel(vel): velocity of the obstacle
; property: im(image): image of the obstacle
; propery: value(number): random numbers which is also image and value of the image
(define-struct obstacle(pos vel im value) )


; structure: figure
; property: num(number): number of the figures
; property: im(image): image of the figure
(define-struct figure(num))


; structure: button
; property: pos(position): position of the button on the menu, gameover scene and so on.
; property: im(image): image of the button
(define-struct button (pos im))


; structure: squareOb
; property: im(image): image of the square
; property: pos(position): position of the square
(define-struct squareOb(im pos))


; structure: triangleOb
; property: im(image): image of the triangle
; property: pos(position): position of the triangle
(define-struct triangleOb(im pos))


; structure: rectangleOb
; property: im(image): image of the rectangle
; property: pos(position): position of the rectangle
(define-struct rectangleOb(im pos))


; structure: circleOb
; property: im(image): image of the circle
; property: pos(position): position of the circle
(define-struct circleOb(im pos))


; structure: gameCar
; property: obs1(obstacle): first obstacles come towards the car 
; property: obs2(obstacle): second obstacles come towards the car
; property: obs3(obstacle): third obstacles come towards the car
; property: car(car): car is controlled by player and player must choose the right path
; property: fig(figure): the shown images with the particular numbers which is determinate the right path
; property: score(number): it demonstrates the score
; property: pos(position): position of the button which is on the menu
(define-struct gameCar(car obs1 obs2 obs3 score fig))


; structure: puzzleGame
; property: sq(squareOb): one of the parts of the puzzle
; property: triang(triangleOb): one of the parts of the puzzle
; property: rect(rectangleOb): one of the parts of the puzzle
; property: circ(circleOb): one of the parts of the puzzle
; property: okBut(button): one of the parts of the puzzle
(define-struct puzzleGame (sq triang rect circ okBut))


; structure: gameOverSceneCar
; property: im(image): image of the game-over scene for the car game
; property: restartBut(button): button for restarting the game
; property: toMenuBut(button): it is a button to return to the menu
(define-struct gameOverSceneCar (im restartBut toMenuBut))


; structure: gameOverScenePuzzle
; property: im(image): image of the game-over scene for the puzzle game
; property: restartBut(button): button for restarting the game
; property: toMenuBut(button): it is a button to return to the menu
(define-struct gameOverScenePuzzle (im restartBut toMenuBut))


; structure: exitScene
; property: im(image): image of the exit scene for the GAME
(define-struct exitScene (im))


; structure: gameMainMenu
; property: im(image): image of the main menu
; property: carGameBut(button): button for car game
; property: puzzleGameBut(button): button for puzzle game
; property: exitBut(button): quit the game
(define-struct gameMainMenu (im carGameBut puzzGameBut exitBut))


; structure: GAME
; property: menu(gameMainMenu): menu of the game
; property: carGame(gameCar): the car game
; property: puzzGame(puzzleGame): the puzzle game
; property: gOvCar(gameOverSceneCar): game over scene for car
; property: gOvPuzz(gameOverScenePuzzle): game over scene for puzzle
; property: exit(exitScene): exit scene of the gamee
; property: scene(string): determinate the game is which scene
(define-struct GAME (menu carGame puzzGame gOvCar gOvPuzzle exit scene))


; image of main menu
(define menuIm (bitmap "./menu.jpg"))

; image of exit scene
(define exitIm (bitmap "./exit.jpg"))

; image of drone
(define figImage (bitmap "./fig3.jpg"))

; image of scoreboard
(define scoreBoard (bitmap "./scoreboard.png"))

; image of the puzzle game before the action
(define puzzleScene (bitmap "./prepuzzle.jpg"))

; image of the rectangle
(define imRect (bitmap "./rectangle.png"))

; image of the triangle
(define imTri (bitmap "./triangle.png"))

; image of the square
(define imSq (bitmap "./square.png"))

; image of the circle
(define imCirc (bitmap "./circle.png"))

; image of the circle
(define hundred (bitmap"./100.png"))

; image of the game-over scene of the car game
(define imGameOver (bitmap "./gameovercar.jpg"))

; image of the game-over scene of the puzzle game
(define imGameOverPuzz (bitmap "./gameoverpuzzle.jpg"))

; list of image of figures
(define listFigIm (list  (bitmap "./n1car.png")
                         (bitmap "./n2car.png")
                         (bitmap "./n3car.png")
                         (bitmap "./n4car.png")
                         (bitmap "./n5car.png")
                         (bitmap "./n6car.png")
                         (bitmap "./n7car.png")
                         (bitmap "./n8car.png")
                         (bitmap "./n9car.png")))
                              
; list of numbers which are used in obtacles and figure
(define listNum (list 1 2 3 4 5 6 7 8 9 30))

; list of numbers which are used as magnitude of random velocity
(define listVel (list 4.5 5.3 6.1 7 8.2 9.3 10 11 11.5))



; ======================================================================================================================================================================
;                                                                 ******* CAR OBJECT *******
; =======================================================================================================================================================================

;YUNUS'S PART:

; purpose: update the position of the car
; contract: newPosCar: c(theCar) key(key) -> position
; test:
(check-expect (newPosCar (make-theCar (make-position 760 730) (circle 15 "solid" "red")) "up") (make-position 760 590))
; function:
(define (newPosCar c key) (cond [ (or (key=? key "up")(key=? key "w") ) (cond [ (= (position-y (theCar-pos c)) 460) (theCar-pos c) ]
                                                                              [ (= (position-y (theCar-pos c)) 590) (make-position 760 460) ]
                                                                              [ (= (position-y (theCar-pos c)) 730) (make-position 760 590) ]
                                                                              [ else (theCar-pos c) ]
                                                                              )]                                                                      
                                
                                [ (or (key=? key "down")(key=? key "s")) (cond [ (= (position-y (theCar-pos c)) 730)    (theCar-pos c) ]
                                                                                  [ (= (position-y (theCar-pos c)) 590) (make-position 760 730) ]
                                                                                  [ (= (position-y (theCar-pos c)) 460) (make-position 760 590) ]
                                                                                  [ else (theCar-pos c) ]
                                                                                  )]                                                                         
                                [else (theCar-pos c)]))
                                


; purpose: main function for moving the car object
; contract: moveCar c(theCar) k(key) -> car
; test:
(check-expect (moveCar (make-theCar (make-position 760 590) (circle 10 "solid" "red")) "down")
              (make-theCar (make-position 760 730) (circle 10 "solid" "red")))
(check-expect (moveCar (make-theCar (make-position 760 590) (circle 10 "solid" "red")) "up")
              (make-theCar (make-position 760 460) (circle 10 "solid" "red")))
; function:
; function:
(define (moveCar c k) (make-theCar (newPosCar c k)
                                   (theCar-im c)))
                                   


; ======================================================================================================================================================================
;                                                          *********** OBSTACLE OBJECT **********
; =======================================================================================================================================================================

;YUNUS'S PART:

; purpose: update the position with the velocity
; contract: newPosObs: pos(position) vel(velocity) -> position
; test:
(check-expect (newPos (make-position 15 15) (make-velocity 5 5) ) (make-position 20 15) )
; function:
(define (newPos pos vel) (make-position (+ (velocity-x vel) (position-x pos) )
                                        (position-y pos)))
                                        


; purpose: determinating whether the obstacle in frame or not
; contract: inFrameX: obs(obstacle) -> boolean
; test:
(check-expect (inFrameX (make-obstacle  (make-position 300 740)   (make-velocity 5 0)  (text  (number->string 4) 15 "red") 2)) #true) 
(check-expect (inFrameX (make-obstacle  (make-position 1000 740)  (make-velocity 5 0)  (text  (number->string 4) 15 "red") 2)) #false)
; function:
(define (inFrameX obs) (cond [(<= (position-x
                                  (obstacle-pos obs)) 860)  #true]
                             [else #false]))



; purpose: designing obstacle images
; contract: designImObs: obs(obstacle)-> image
; tests:
(check-expect (designImObs (make-obstacle (make-position 100 100) (make-velocity 10 10) (text (number->string 5) 40 "red") 7))
              (text (number->string 7) 40 "red"))
; function:
(define (designImObs obs) (text (number->string (obstacle-value obs)) 40 "red"))


;UMUT'S PART:

; purpose: updating velocities, positions, value of obstacle and number of figure with each new tour
; contract: updateVelObs: c(theCar) obs(obstacle) fig(figure) -> obstacle
; tests:
(check-random (updateVelObs
               (make-theCar (make-position 500 500) (circle 10 "solid" "red"))
               (make-obstacle (make-position 500 500) (make-velocity 10 0) (text (number->string 7) 40 "red") 7)
               (make-figure 7))
              (make-obstacle (make-position -15 500) (make-velocity (list-ref listVel (random 9)) 0) (text (number->string 7) 40 "red") (list-ref listNum (random 9))))
(check-expect (updateVelObs
               (make-theCar (make-position 100 500) (circle 10 "solid" "red"))
               (make-obstacle (make-position 500 500) (make-velocity 10 0) (text (number->string 7) 40 "red") 7)
               (make-figure 7))
              (make-obstacle (make-position 500 500) (make-velocity 10 0) (text (number->string 7) 40 "red") 7))
; function:
(define (updateVelObs c obs fig) (cond
                                       [(or (= 1 (isTrue c obs fig)) (not(inFrameX obs)))  (make-obstacle
                                                                                                  (newPos (make-position -25 (position-y  (obstacle-pos obs))) (obstacle-vel obs))
                                                                                                  (make-velocity  (list-ref listVel (random 9)) 0)
                                                                                                  (obstacle-im obs)
                                                                                                  (list-ref listNum (random 9)))]
                                       [(= 0  (isTrue c obs fig))  obs]

                                       [(= -1 (isTrue c obs fig)) obs]))
                                       
                                       
                             

; purpose: main function for moving the obstacle object
; contract: moveObstacle obs(obstacle) -> obstacle
; test:
(check-expect (moveObstacle (make-theCar    (make-position 100 100) (rectangle 10 10 "solid" "red"))
                            (make-obstacle  (make-position 100 25)  (make-velocity  5 0) (text (number->string 4) 40 "red") 4 )
                            (make-figure 7))
              (make-obstacle (make-position 105 25) (make-velocity 5 0) (text (number->string 4) 40 "red") 4 ))

(check-random (moveObstacle (make-theCar  (make-position 100 100) (rectangle 10 10 "solid" "red"))
                            (make-obstacle (make-position 900 25) (make-velocity  5 0) (text (number->string 4) 40 "red") 4 )
                            (make-figure 7))
              (make-obstacle (make-position -20 25) (make-velocity (list-ref listVel (random 9)) 0) (text (number->string 4) 40 "red") (list-ref listNum (random 9))))  
; function:
(define (moveObstacle c obs fig) (cond

                                       [(and (= (isTrue c obs fig) 0) (inFrameX obs))  (make-obstacle
                                                                                             (newPos (obstacle-pos obs) (obstacle-vel obs))
                                                                                             (obstacle-vel obs)
                                                                                             (designImObs obs)
                                                                                             (obstacle-value obs))]
                                   
                                      [(or (not(inFrameX obs)) (= 1 (isTrue c obs fig))) 
                                       (updateVelObs c obs fig)]
                                   
                                     [(= -1 (isTrue c obs fig)) (updateVelObs c obs fig)]))


 
; ======================================================================================================================================================================
;                                                    **************  FIGURE ***************
; =======================================================================================================================================================================

;YUNUS'S PART:

; purpose: updating figure
; contract: updateFigure: c(theCar) fig(figure) obs1(obstacle) obs2(obstacle) obs3(obstacle) -> figure
; test:
(check-random (updateFigure (make-theCar (make-position 400 400) (circle 10 "solid" "red"))
                            (make-figure 6)
                            (make-obstacle (make-position 400 400) (make-velocity 5 0) (text (number->string 6) 40 "red") 6)
                            (make-obstacle (make-position 600 25) (make-velocity 5 0) (text (number->string 4) 40 "red") 4 )
                            (make-obstacle (make-position 300 25) (make-velocity 5 0) (text (number->string 9) 40 "red") 9 ))
              (make-figure (list-ref listNum (random 9))))

(check-expect (updateFigure (make-theCar (make-position 400 400) (circle 10 "solid" "red"))
                            (make-figure 6)
                            (make-obstacle (make-position 144 400) (make-velocity 5 0) (text (number->string 3) 40 "red") 3)
                            (make-obstacle (make-position 600 25) (make-velocity 5 0) (text (number->string 4) 40 "red") 4 )
                            (make-obstacle (make-position 300 25) (make-velocity 5 0) (text (number->string 9) 40 "red") 9 ))
              (make-figure 6)) 
; function:
(define (updateFigure c fig obs1 obs2 obs3) (cond

                                                  [(and (= 0 (isTrue c obs1 fig)) (= 0 (isTrue c obs2 fig)) (= 0 (isTrue c obs3 fig))) fig] 
                                              
                                                  [(or (= 1 (isTrue c obs1 fig)) (= 1 (isTrue c obs2 fig)) (= 1 (isTrue c obs3 fig)))
                                                   (make-figure (list-ref listNum (random 9)))] 

                                                  [(or (= -1 (isTrue c obs1 fig)) (= -1 (isTrue c obs2 fig)) (= -1 (isTrue c obs3 fig)))
                                                   (make-figure 9 )]))

  

; purpose: creating image of the figures with new tour
; contract: textFig: c(theCar) fig(figure) obs1(obstacle) obs2(obstacle) obs3(obstacle) -> image
; test:
(check-expect (imageFig (make-theCar (make-position 600 400) (circle 10 "solid" "red"))
                        (make-figure 6)
                        (make-obstacle (make-position 400 25) (make-velocity 5 0) (text (number->string 6) 40 "red") 6 )
                        (make-obstacle (make-position 600 25) (make-velocity 5 0) (text (number->string 4) 40 "red") 4 )
                        (make-obstacle (make-position 300 25) (make-velocity 5 0) (text (number->string 9) 40 "red") 9 ))
              (list-ref listFigIm 5))

(check-random (imageFig (make-theCar (make-position 400 25) (circle 10 "solid" "red"))
                        (make-figure 6)
                        (make-obstacle (make-position 400 25) (make-velocity 5 0) (text (number->string 6) 40 "red") 6 )
                        (make-obstacle (make-position 600 25) (make-velocity 5 0) (text (number->string 4) 40 "red") 4 )
                        (make-obstacle (make-position 300 25) (make-velocity 5 0) (text (number->string 9) 40 "red") 9 ))
              (list-ref listFigIm (- (list-ref listNum (random 9)) 1)))
              
; function:
(define (imageFig c fig obs1 obs2 obs3) (list-ref listFigIm (- (figure-num (updateFigure c fig obs1 obs2 obs3)) 1)))



; purpose: showing the figure 
; contract: figImage2: gc(gameCar) -> image
; test:   
(check-expect (figImage2 (make-gameCar (make-theCar (make-position 300 300) (circle 10 "solid" "red"))
                                       (make-obstacle (make-position 400 25) (make-velocity 5 0) (text (number->string 6) 40 "red") 6 ) 
                                       (make-obstacle (make-position 600 25) (make-velocity 5 0) (text (number->string 4) 40 "red") 4 )
                                       (make-obstacle (make-position 300 25) (make-velocity 5 0) (text (number->string 9) 40 "red") 9 )
                                       0 
                                       (make-figure 3)))
              (overlay/offset (imageFig (make-theCar (make-position 300 300) (circle 10 "solid" "red"))
                                        (make-figure 3)
                                        (make-obstacle (make-position 400 25) (make-velocity 5 0) (text (number->string 6) 40 "red") 6 ) 
                                        (make-obstacle (make-position 600 25) (make-velocity 5 0) (text (number->string 4) 40 "red") 4 )
                                        (make-obstacle (make-position 300 25) (make-velocity 5 0) (text (number->string 9) 40 "red") 9 ))
                              0 -40
                              figImage))

(check-random (figImage2 (make-gameCar (make-theCar (make-position 400 25) (circle 10 "solid" "red"))
                                       (make-obstacle (make-position 400 25) (make-velocity 5 0) (text (number->string 6) 40 "red") 6 ) 
                                       (make-obstacle (make-position 600 25) (make-velocity 5 0) (text (number->string 4) 40 "red") 4 )
                                       (make-obstacle (make-position 300 25) (make-velocity 5 0) (text (number->string 9) 40 "red") 9 )
                                       0 
                                       (make-figure 6)))
              (overlay/offset (imageFig (make-theCar (make-position 300 300) (circle 10 "solid" "red"))
                                        (make-figure (list-ref listNum (random 9)))
                                        (make-obstacle (make-position 400 25) (make-velocity 5 0) (text (number->string 6) 40 "red") 6 ) 
                                        (make-obstacle (make-position 600 25) (make-velocity 5 0) (text (number->string 4) 40 "red") 4 )
                                        (make-obstacle (make-position 300 25) (make-velocity 5 0) (text (number->string 9) 40 "red") 9 ))
                              0 -40
                              figImage))
; function:
(define (figImage2 gc) (overlay/offset (imageFig (gameCar-car gc) (gameCar-fig gc) (gameCar-obs1 gc) (gameCar-obs2 gc) (gameCar-obs3 gc))
                                       0 -40
                                       figImage))
                                            
                                            
                                           
                                            


; ======================================================================================================================================================================
;                                                ************ REACTİON BETWEEN CAR AND OBSTACLE ************
; =======================================================================================================================================================================

;YUNUS'S PART:

; purpose: check whether 
; contract: isCollided: c(car) ob(obstacle) -> boolean 
; test:
(check-expect (isCollided  (make-theCar   (make-position 400 500)  (circle 30 "solid" "red"))
                           (make-obstacle (make-position 380 500)  (make-velocity 5 0) (text (number->string 4) 15 "red") 4))
              #true)
(check-expect (isCollided  (make-theCar   (make-position 300 500)  (circle 30 "solid" "red"))
                           (make-obstacle (make-position 380 500)  (make-velocity 5 0) (text (number->string 4) 15 "red") 4))
              #false)
(check-expect (isCollided  (make-theCar   (make-position 400 600)  (circle 30 "solid" "red"))
                           (make-obstacle (make-position 380 500)  (make-velocity 5 0) (text (number->string 4) 15 "red") 4))
              #false)

                                                                                                       
; function:
(define (isCollided c ob) (cond [(and  (> (+ (position-x (obstacle-pos ob)) (/ (image-width (obstacle-im ob)) 2)) (- (position-x (theCar-pos c)) (/ (image-width (theCar-im c)) 2)))
                                       (< (+ (position-x (obstacle-pos ob)) (/ (image-width (obstacle-im ob)) 2)) (+ (position-x (theCar-pos c)) (/ (image-width (theCar-im c)) 2))))
                                 (if   (= (position-y (theCar-pos c)) (position-y (obstacle-pos ob))) #true #false)]
                                
                                [(and  (> (+ (position-x (obstacle-pos ob)) (/ (image-width (obstacle-im ob)) 2)) (+ (position-x (theCar-pos c)) (/ (image-width (theCar-im c)) 2)))
                                       (< (- (position-x (obstacle-pos ob)) (/ (image-width (obstacle-im ob)) 2)) (+ (position-x (theCar-pos c)) (/ (image-width (theCar-im c)) 2))))
                                 (if   (= (position-y (theCar-pos c)) (position-y (obstacle-pos ob))) #true #false)]

                                [else #false]))


;UMUT'S PART:

; purpose: check whether ball and bar is collided or not
; contract: isTrue: c(theCar) ob(obstacle) fig(figure) -> number 
; test:
(check-expect (isTrue  (make-theCar   (make-position 100 100) (circle 10 "solid" "blue"))
                       (make-obstacle (make-position 100 100) (make-velocity 3 0) (text (number->string 4) 15 "red") 7)
                       (make-figure 9))
              -1)
(check-expect (isTrue  (make-theCar   (make-position 100 100) (circle 10 "solid" "blue"))
                       (make-obstacle (make-position 300 300) (make-velocity 3 0) (text (number->string 4) 15 "red") 7)
                       (make-figure 9))
              0)
(check-expect (isTrue  (make-theCar   (make-position 100 100) (circle 10 "solid" "blue"))
                       (make-obstacle (make-position 100 100) (make-velocity 3 0) (text (number->string 4) 15 "red") 7)
                       (make-figure 7))
              1)
; function:
(define (isTrue c ob fig) (cond [(not (isCollided c ob)) 0]
                                [(and (isCollided c ob)  (= (obstacle-value ob)      (figure-num fig))) 1]
                                [(and (isCollided c ob)  (not (= (obstacle-value ob) (figure-num fig)))) -1]))
  
  
; =================================================================================================================================================================================
;                                        ******************** CAR GAME SCORE AND SCOREBOARD **********************
; ====================================================================================================================================================================================

;YUNUS'S PARTS:

; purpose: update the game score with interaction between car and right obstacle
; contract: updateScore: g(gameCar) -> number
; test:
(check-expect (updateScore (make-gameCar (make-theCar   (make-position 40 40)    (circle 15 "solid" "blue"))
                                         (make-obstacle (make-position 40 40)    (make-velocity 0 5) (text (number->string 4) 15 "red") 7)
                                         (make-obstacle (make-position 100 100)  (make-velocity 5 5) (text (number->string 4) 15 "red") 45 )
                                         (make-obstacle (make-position 50 0)     (make-velocity 25 5) (text (number->string 4) 15 "red") 451)
                                         500
                                         (make-figure 7)))
              550)

(check-expect (updateScore (make-gameCar  (make-theCar    (make-position 1000 40)   (circle 15 "solid" "blue"))
                                          (make-obstacle  (make-position 40 40)     (make-velocity 0 5)  (text (number->string 4) 15 "red") 455)
                                          (make-obstacle  (make-position 100 100)   (make-velocity 5 5)  (text (number->string 4) 15 "red") 45)
                                          (make-obstacle  (make-position 50 0)      (make-velocity 25 5) (text (number->string 4) 15 "red") 451)
                                          1000
                                          (make-figure 7)))
              1000.1)

; function:
(define (updateScore g) (if (not (or  (isCollided (gameCar-car g) (gameCar-obs1 g))
                                      (isCollided (gameCar-car g) (gameCar-obs2 g))
                                      (isCollided (gameCar-car g) (gameCar-obs3 g))))
                            
                             (+ (gameCar-score g) 0.1)

                             (cond  [(= 1   (isTrue (gameCar-car g) (gameCar-obs1 g) (gameCar-fig g))) (+ (gameCar-score g) 50) ]
                                    [(= 1   (isTrue (gameCar-car g) (gameCar-obs2 g) (gameCar-fig g))) (+ (gameCar-score g) 50) ]
                                    [(= 1   (isTrue (gameCar-car g) (gameCar-obs3 g) (gameCar-fig g))) (+ (gameCar-score g) 50) ]
                                    [(= -1  (isTrue (gameCar-car g) (gameCar-obs1 g) (gameCar-fig g))) (+ (gameCar-score g) 0)  ]
                                    [(= -1  (isTrue (gameCar-car g) (gameCar-obs2 g) (gameCar-fig g))) (+ (gameCar-score g) 0)  ]
                                    [(= -1  (isTrue (gameCar-car g) (gameCar-obs3 g) (gameCar-fig g))) (+ (gameCar-score g) 0)  ]
                                    )))

                                 

; purpose: showing the score 
; contract: board: g(gameCar) -> image
; test:
(check-expect (board (make-gameCar (make-theCar (make-position 300 300) (circle 10 "solid" "red"))
                                   (make-obstacle (make-position 400 25) (make-velocity 5 0) (text (number->string 6) 40 "red") 6 ) 
                                   (make-obstacle (make-position 600 25) (make-velocity 5 0) (text (number->string 4) 40 "red") 4 )
                                   (make-obstacle (make-position 300 25) (make-velocity 5 0) (text (number->string 9) 40 "red") 9 )
                                   100.9 
                                   (make-figure 3)))
              (overlay/offset (text (number->string 100) 15 "white")
                              10 4
                              scoreBoard))
; function:
(define (board g) (overlay/offset (text (number->string (floor (gameCar-score g))) 15 "white")
                                  10 4
                                  scoreBoard))


; =================================================================================================================================================================================
;                                                    ********* CAR GAME BACKGROUND DESIGNING  *********
; ==================================================================================================================================================================================

;YUNUS'S PARTS:

;designing sky on the game
(define sky (rectangle 800 380 "solid" "light blue"))

;designing the road
(define roadWithoutMark (rectangle 800 420 "solid" "Gray") )

(define roadMarks (rectangle 800 10 "solid" "white") )

(define roadWithSideMarks (place-image
                                      roadMarks 400 15
                                                      (place-image
                                                                  roadMarks 400 405
                                                                                   roadWithoutMark)))



(define middleMarksPart1 (rectangle 40 10 "solid" "white"))

(define middleMarksPart2 (rectangle 20 10 "solid" " Gray") )

(define middleMarksOnePiece (beside middleMarksPart1 middleMarksPart2))

;UMUT'S PART:

;Designing middle marks on the road and final touches
(define counter 0)

(define (recusiveMiddleMarks counter) (cond  [(= 13 counter) middleMarksOnePiece]
                                             [else (beside middleMarksOnePiece (recusiveMiddleMarks (+ counter 1)))]))

(define finalTouch (beside (recusiveMiddleMarks counter) middleMarksPart2))

(define finalRoad (place-image finalTouch
                                400 140
                                (place-image finalTouch
                                             400 280 roadWithSideMarks)))

(define finalScene (overlay
                   (above sky finalRoad)
                   (empty-scene 800 800)))
                    


; =================================================================================================================================================================================
;                                                         *********** CAR GAME GAME-OVER SCENE **********
; ==================================================================================================================================================================================

;YUNUS'S PART:

; purpose: showing the score on game-over scene
; contract: OverSceneDraw: gOvSceCar(gameOverSceneCar) gaC(gameCar) -> image
; test:
(check-expect (OverSceneDraw (make-gameOverSceneCar (empty-scene 800 800)
                                                    (make-button (make-position 500 500) (rectangle 30 30 "outline" "black"))
                                                    (make-button (make-position 400 400) (rectangle 30 30 "outline" "black")))
                             (make-gameCar (make-theCar (make-position 300 300) (circle 10 "solid" "red"))
                                           (make-obstacle (make-position 400 25) (make-velocity 5 0) (text (number->string 6) 40 "red") 6 ) 
                                           (make-obstacle (make-position 600 25) (make-velocity 5 0) (text (number->string 4) 40 "red") 4 )
                                           (make-obstacle (make-position 300 25) (make-velocity 5 0) (text (number->string 9) 40 "red") 9 )
                                           100.9 
                                           (make-figure 3)))
              (overlay/offset (text (string-append "Your Score: " "101") 28 "black")
                              20 -315
                              imGameOver))
; function:
(define (OverSceneDraw gOvSceCar gaC) (overlay/offset  (text (string-append "Your Score: " (number->string(round(updateScore gaC)))) 28 "black")
                                                       20 -315
                                                       imGameOver))

                               

; =================================================================================================================================================================================
;                                                      *********** CAR GAME UPDATE FUNCTIONS **********
; ==================================================================================================================================================================================

;YUNUS'S PART:

; purpose: drawing the car into the finalScene
; contract: scene1: g(gameCar) -> image
; test:
(check-expect (scene1 (make-gameCar (make-theCar (make-position 324 423) (circle 10 "solid" "red"))
                                    (make-obstacle (make-position 400 25) (make-velocity 5 0) (text (number->string 6) 40 "red") 6 ) 
                                    (make-obstacle (make-position 600 25) (make-velocity 5 0) (text (number->string 4) 40 "red") 4 )
                                    (make-obstacle (make-position 300 25) (make-velocity 5 0) (text (number->string 9) 40 "red") 9 )
                                    120 
                                    (make-figure 4)))
              (place-image (circle 10 "solid" "red")
                           324 423
                           finalScene))
; function:
(define (scene1 g) (place-image (theCar-im   (gameCar-car g))
                                (position-x  (theCar-pos(gameCar-car g))) (position-y (theCar-pos(gameCar-car g)))
                                finalScene))



; purpose: adding the obtacles on scene1
; contract: scene2: g(gameCar) -> image
; test:
(check-expect (scene2 (make-gameCar (make-theCar (make-position 200 220) (circle 10 "solid" "red"))
                                    (make-obstacle (make-position 400 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                    (make-obstacle (make-position 600 200) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                    (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                    120 
                                    (make-figure 8)))

              (place-image (text (number->string 7) 40 "red")
                           400 300
                           (place-image (text (number->string 3) 40 "red")
                                        600 200
                                        (place-image (text (number->string 1) 40 "red")
                                                     300 700
                                                     (scene1 (make-gameCar (make-theCar (make-position 200 220) (circle 10 "solid" "red"))
                                                                           (make-obstacle (make-position 400 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                                                           (make-obstacle (make-position 600 200) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                                                           (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                                                           120 
                                                                           (make-figure 8)))))))
; function:
(define (scene2 g) (place-image (obstacle-im (gameCar-obs1 g))
                                (position-x  (obstacle-pos  (gameCar-obs1  g))) (position-y (obstacle-pos (gameCar-obs1 g)))
                                (place-image (obstacle-im   (gameCar-obs2  g))
                                             (position-x    (obstacle-pos (gameCar-obs2 g))) (position-y (obstacle-pos (gameCar-obs2 g)))
                                             (place-image   (obstacle-im   (gameCar-obs3 g))
                                                            (position-x    (obstacle-pos(gameCar-obs3 g)))  (position-y  (obstacle-pos(gameCar-obs3 g)))
                                                            (scene1 g)))))



; purpose: adding the scoreboard and the figure on scene2
; contract: finalSceneCar: g(gameCar) -> image
; test:
(check-expect (finalSceneCar (make-gameCar (make-theCar (make-position 200 220) (circle 10 "solid" "red"))
                                           (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                           (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                           (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                           500 
                                           (make-figure 3)))

              (place-image (board (make-gameCar (make-theCar (make-position 200 220) (circle 10 "solid" "red"))
                                                (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                                (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                                (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                                500 
                                                (make-figure 3))) 
                           110 55
                           (place-image (figImage2 (make-gameCar (make-theCar (make-position 200 220) (circle 10 "solid" "red"))
                                           (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                           (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                           (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                           500 
                                           (make-figure 3)))
                                        665 140
                                        (scene2 (make-gameCar (make-theCar (make-position 200 220) (circle 10 "solid" "red"))
                                           (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                           (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                           (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                           500 
                                           (make-figure 3))))))
; function:
(define (finalSceneCar g) (place-image (board g)
                                       110 55
                                       (place-image (figImage2 g)
                                                    665 140
                                                    (scene2 g))))



; ======================================================================================================================================================================
;                                              ************* MOUSE + GAME-SCENE (AS A PROPORTY) + DRAGGİNG ************
; =======================================================================================================================================================================

;BAYRAM'S PART:

; purpose: check whether the point on the button or not
; contract: isInButton: b(button)  x(number) y(number) -> boolean
; test:
(check-expect (isInButton (make-button (make-position 200 200) (rectangle 20 20 "outline" "black"))  195 205)
              #true)
              
(check-expect (isInButton (make-button (make-position 200 200) (rectangle 20 20 "outline" "black")) 400 100)
              #false)       
              
; function:
(define (isInButton b x y) (if (and (>= x (- (position-x (button-pos b)) (/ (image-width(button-im b)) 2)))
                                    (<= x (+ (position-x (button-pos b)) (/ (image-width(button-im b)) 2)))
                                    (>= y (- (position-y (button-pos b)) (/ (image-height(button-im b)) 2)))
                                    (<= y (+ (position-y (button-pos b)) (/ (image-height(button-im b)) 2))))
                               #true
                               #false))


; purpose: check whether mouse clicked button or not
; contract: doesClickButton: b(button) x(number) y(number) mo(mouseEvent)-> boolean
; test:
(check-expect (doesClickButton (make-button (make-position 200 200) (rectangle 20 20 "outline" "black")) 200 200 "button-down")
              #true)
(check-expect (doesClickButton (make-button (make-position 200 200) (rectangle 20 20 "outline" "black")) 200 200 "drag")
              #false)
(check-expect (doesClickButton (make-button (make-position 300 300) (rectangle 20 20 "outline" "black")) 200 200 "button-down")
              #false)
; function:
(define (doesClickButton b x y mo) (if (and (mouse=? "button-down" mo) (isInButton b x y))
                                       #true
                                       #false))  



; purpose: check whether the point on the rectangle or not
; contract: isInRectangle: rec(rectangleOb) x(number) y(number) -> boolean
; test:
(check-expect (isInRectangle (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200)) 200 200) #true) 
(check-expect (isInRectangle (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 170 230)) 200 200) #false)
; function:
(define (isInRectangle rec x y) (if (and
                                     (>= x (- (position-x (rectangleOb-pos rec)) (/ (image-width  (rectangleOb-im rec)) 2)))
                                     (<= x (+ (position-x (rectangleOb-pos rec)) (/ (image-width  (rectangleOb-im rec)) 2)))
                                     (>= y (- (position-y (rectangleOb-pos rec)) (/ (image-height (rectangleOb-im rec)) 2)))
                                     (<= y (+ (position-y (rectangleOb-pos rec)) (/ (image-height (rectangleOb-im rec)) 2))))
                                    #true
                                    #false))



; purpose: check whether the point on the circle or not
; contract: isInCircle: circ(circleOb) x(number) y(number) -> boolean
; test:
(check-expect (isInCircle (make-circleOb (circle 20 "solid" "red") (make-position 300 300)) 280 314) #true)
(check-expect (isInCircle (make-circleOb (circle 20 "solid" "red") (make-position 300 300)) 580 314) #false)
; function:
(define (isInCircle circ x y) (if (and
                                     (>= x (- (position-x (circleOb-pos circ)) (/ (image-width  (circleOb-im circ)) 2)))
                                     (<= x (+ (position-x (circleOb-pos circ)) (/ (image-width  (circleOb-im circ)) 2)))
                                     (>= y (- (position-y (circleOb-pos circ)) (/ (image-height (circleOb-im circ)) 2)))
                                     (<= y (+ (position-y (circleOb-pos circ)) (/ (image-height (circleOb-im circ)) 2))))
                                    #true
                                    #false))



; purpose: check whether the point on the triangle or not
; contract: isInTriangle: tri(triangleOb) x(number) y(number) -> boolean
; test:
(check-expect (isInTriangle (make-triangleOb (triangle 20 "solid" "red") (make-position 300 300)) 300 300) #true)
(check-expect (isInTriangle (make-triangleOb (triangle 20 "solid" "red") (make-position 300 300)) 780 314) #false)
; function:
(define (isInTriangle tri x y) (if (and
                                     (>= x (- (position-x (triangleOb-pos tri)) (/ (image-width   (triangleOb-im tri)) 2)))
                                     (<= x (+ (position-x (triangleOb-pos tri)) (/ (image-width   (triangleOb-im tri)) 2)))
                                     (>= y (- (position-y (triangleOb-pos tri)) (/ (image-height  (triangleOb-im tri)) 2)))
                                     (<= y (+ (position-y (triangleOb-pos tri)) (/ (image-height  (triangleOb-im tri)) 2))))
                                    #true
                                    #false))



; purpose: check whether the point on the square or not
; contract: isInTriangle: sq(squareOb) x(number) y(number) -> boolean
; test:
(check-expect (isInSquare (make-squareOb (square 30 "solid" "black") (make-position 500 500)) 490 500) #true)
(check-expect (isInSquare (make-squareOb (square 30 "solid" "black") (make-position 500 500)) 470 330) #false)
; function:
(define (isInSquare sq x y) (if (and
                                     (>= x (- (position-x (squareOb-pos sq)) (/ (image-width   (squareOb-im sq)) 2)))
                                     (<= x (+ (position-x (squareOb-pos sq)) (/ (image-width   (squareOb-im sq)) 2)))
                                     (>= y (- (position-y (squareOb-pos sq)) (/ (image-height  (squareOb-im sq)) 2)))
                                     (<= y (+ (position-y (squareOb-pos sq)) (/ (image-height  (squareOb-im sq)) 2))))
                                    #true
                                    #false))



; purpose: check whether mouse is dragged or not
; contract: doesDrag: pg(puzzleGame) x(number) y(number) mo(mouseEvent)-> boolean
; test:
(check-expect (doesDrag (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                         (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                         (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                         (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                         (make-button (make-position 300 300) (rectangle 30 30 "solid" "black")))
                        700 700
                        "drag")
              #true)
(check-expect (doesDrag (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                         (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                         (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                         (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                         (make-button (make-position 300 300) (rectangle 30 30 "solid" "black")))
                        500 500
                        "drag")
              #true)
(check-expect (doesDrag (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                         (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                         (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                         (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                         (make-button (make-position 300 300) (rectangle 30 30 "solid" "black")))
                        300 300
                        "drag")
              #false)
; function:
(define (doesDrag pg x y mo) (if (or  (and (isInSquare (puzzleGame-sq pg) x y)       (mouse=? "drag" mo))
                                      (and (isInTriangle (puzzleGame-triang pg) x y) (mouse=? "drag" mo))
                                      (and (isInRectangle (puzzleGame-rect pg) x y)  (mouse=? "drag" mo))
                                      (and (isInCircle (puzzleGame-circ pg) x y)     (mouse=? "drag" mo)))
                                 #true
                                 #false))


; purpose: changing between the scenes by clicking mouse1 and dragging the shapes in the puzzle game
; contract: mouseUpdate: ga(GAME) x(number) y(number) mo(mouseEvent)-> GAME
; test:

;UMUT'S PART:

(check-expect (mouseUpdate (make-GAME
                            (make-gameMainMenu (rectangle 800 800 "outline" "yellow") (make-button (make-position 300 300) (rectangle 30 30 "outline" "black")) (make-button (make-position 500 500) (rectangle 30 30 "outline" "black")) (make-button (make-position 700 700) (rectangle 30 30 "outline" "black")))
                            (make-gameCar (make-theCar (make-position 760 730) (circle 10 "solid" "red"))
                                          (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                          (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                          (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                          500 
                                          (make-figure 3))
                            (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                             (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                             (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                             (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                             (make-button (make-position 300 300) (rectangle 20 20 "solid" "red")))
                            (make-gameOverSceneCar (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                            (make-gameOverScenePuzzle (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                            (make-exitScene (empty-scene 800 800))
                            "menu")
                           300 300
                           "button-down")
              (make-GAME
               (make-gameMainMenu (rectangle 800 800 "outline" "yellow") (make-button (make-position 300 300) (rectangle 30 30 "outline" "black")) (make-button (make-position 500 500) (rectangle 30 30 "outline" "black")) (make-button (make-position 700 700) (rectangle 30 30 "outline" "black")))
               (make-gameCar (make-theCar (make-position 760 730) (circle 10 "solid" "red"))
                             (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                             (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                             (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                             500 
                             (make-figure 3))
               (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                (make-button (make-position 300 300) (rectangle 20 20 "solid" "red")))
               (make-gameOverSceneCar (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
               (make-gameOverScenePuzzle (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
               (make-exitScene (empty-scene 800 800))
               "carGameScene"))

(check-expect (mouseUpdate (make-GAME
                            (make-gameMainMenu (rectangle 800 800 "outline" "yellow") (make-button (make-position 300 300) (rectangle 30 30 "outline" "black")) (make-button (make-position 500 500) (rectangle 30 30 "outline" "black")) (make-button (make-position 700 700) (rectangle 30 30 "outline" "black")))
                            (make-gameCar (make-theCar (make-position 760 730) (circle 10 "solid" "red"))
                                          (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                          (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                          (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                          500 
                                          (make-figure 3))
                            (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                             (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                             (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                             (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                             (make-button (make-position 300 300) (rectangle 20 20 "solid" "red")))
                            (make-gameOverSceneCar (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                            (make-gameOverScenePuzzle (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                            (make-exitScene (empty-scene 800 800))
                            "menu")
                           500 500
                           "button-down")
              (make-GAME
               (make-gameMainMenu (rectangle 800 800 "outline" "yellow") (make-button (make-position 300 300) (rectangle 30 30 "outline" "black")) (make-button (make-position 500 500) (rectangle 30 30 "outline" "black")) (make-button (make-position 700 700) (rectangle 30 30 "outline" "black")))
               (make-gameCar (make-theCar (make-position 760 730) (circle 10 "solid" "red"))
                             (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                             (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                             (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                             500 
                             (make-figure 3))
               (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                (make-button (make-position 300 300) (rectangle 20 20 "solid" "red")))
               (make-gameOverSceneCar (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
               (make-gameOverScenePuzzle (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
               (make-exitScene (empty-scene 800 800))
               "puzzleGameScene"))

;BAYRAM'S PART:

(check-expect (mouseUpdate (make-GAME
                            (make-gameMainMenu (rectangle 800 800 "outline" "yellow") (make-button (make-position 300 300) (rectangle 30 30 "outline" "black")) (make-button (make-position 500 500) (rectangle 30 30 "outline" "black")) (make-button (make-position 700 700) (rectangle 30 30 "outline" "black")))
                            (make-gameCar (make-theCar (make-position 760 730) (circle 10 "solid" "red"))
                                          (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                          (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                          (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                          500 
                                          (make-figure 3))
                            (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                             (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                             (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                             (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                             (make-button (make-position 300 300) (rectangle 20 20 "solid" "red")))
                            (make-gameOverSceneCar (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                            (make-gameOverScenePuzzle (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                            (make-exitScene (empty-scene 800 800))
                            "puzzleGameScene")
                                                      501 501
                                                      "drag")
              (make-GAME
               (make-gameMainMenu (rectangle 800 800 "outline" "yellow") (make-button (make-position 300 300) (rectangle 30 30 "outline" "black")) (make-button (make-position 500 500) (rectangle 30 30 "outline" "black")) (make-button (make-position 700 700) (rectangle 30 30 "outline" "black")))
               (make-gameCar (make-theCar (make-position 760 730) (circle 10 "solid" "red"))
                             (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                             (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                             (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                             500 
                             (make-figure 3))
               (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 501 501))
                                (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                (make-button (make-position 300 300) (rectangle 20 20 "solid" "red")))
               (make-gameOverSceneCar (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
               (make-gameOverScenePuzzle (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
               (make-exitScene (empty-scene 800 800))
               "puzzleGameScene"))

(check-random (mouseUpdate (make-GAME
                            (make-gameMainMenu (rectangle 800 800 "outline" "yellow") (make-button (make-position 300 300) (rectangle 30 30 "outline" "black")) (make-button (make-position 500 500) (rectangle 30 30 "outline" "black")) (make-button (make-position 700 700) (rectangle 30 30 "outline" "black")))
                            (make-gameCar (make-theCar (make-position 760 730) (circle 10 "solid" "red"))
                                          (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                          (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                          (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                          500 
                                          (make-figure 3))
                            (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                             (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                             (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                             (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                             (make-button (make-position 300 300) (rectangle 20 20 "solid" "red")))
                            (make-gameOverSceneCar (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                            (make-gameOverScenePuzzle (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                            (make-exitScene (empty-scene 800 800))
                            "puzzleGameOverScene")
                           37 677
                           "button-down")
              (make-GAME
               (make-gameMainMenu (rectangle 800 800 "outline" "yellow") (make-button (make-position 300 300) (rectangle 30 30 "outline" "black")) (make-button (make-position 500 500) (rectangle 30 30 "outline" "black")) (make-button (make-position 700 700) (rectangle 30 30 "outline" "black")))
               (make-gameCar (make-theCar (make-position 760 730) (circle 10 "solid" "red"))
                             (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                             (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                             (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                             500 
                             (make-figure 3))
               (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position (random 800) (random 800)))
                                (make-triangleOb (triangle 20 "solid" "red") (make-position (random 800) (random 800)))
                                (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position (random 800) (random 800)))
                                (make-circleOb (circle 20 "solid" "red") (make-position (random 800) (random 800)))
                                (make-button (make-position 300 300) (rectangle 20 20 "solid" "red")))
               (make-gameOverSceneCar (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
               (make-gameOverScenePuzzle (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
               (make-exitScene (empty-scene 800 800))
               "menu"))

; function:
(define (mouseUpdate ga x y mo) (cond

                                  ; UMUT'S PART:                              


                                  [(and       (doesClickButton (gameMainMenu-carGameBut (GAME-menu ga)) x y mo) (string=?         (GAME-scene ga) "menu"))
                                   (make-GAME (GAME-menu ga)   (GAME-carGame ga)        (GAME-puzzGame ga)      (GAME-gOvCar ga)  (GAME-gOvPuzzle ga) (GAME-exit ga) "carGameScene")]

                                  
                                  [(and       (doesClickButton (gameMainMenu-exitBut (GAME-menu ga)) x y mo) (string=?        (GAME-scene ga) "menu"))
                                   (make-GAME (GAME-menu ga)   (GAME-carGame ga)     (GAME-puzzGame ga)      (GAME-gOvCar ga) (GAME-gOvPuzzle ga) (GAME-exit ga) "exitScene")]

                                  
                                  [(and       (doesClickButton (gameMainMenu-puzzGameBut (GAME-menu ga)) x y mo) (string=?        (GAME-scene ga) "menu"))
                                   (make-GAME (GAME-menu ga)   (GAME-carGame ga)         (GAME-puzzGame ga)      (GAME-gOvCar ga) (GAME-gOvPuzzle ga) (GAME-exit ga) "puzzleGameScene")]

                                  
                                  [(and (doesClickButton (puzzleGame-okBut  (GAME-puzzGame ga)) x y mo) (string=? (GAME-scene ga) "puzzleGameScene")
                                        (doesFillUp      (puzzleGame-sq     (GAME-puzzGame ga)) (puzzleGame-triang (GAME-puzzGame ga)) (puzzleGame-rect (GAME-puzzGame ga)) (puzzleGame-circ (GAME-puzzGame ga))))
                                   (make-GAME       (GAME-menu ga)     (GAME-carGame ga) (GAME-puzzGame ga) (GAME-gOvCar ga) (GAME-gOvPuzzle ga) (GAME-exit ga) "puzzleGameOverScene")]

                                  
                                  [(and (doesClickButton (gameOverScenePuzzle-restartBut (GAME-gOvPuzzle ga)) x y mo) (string=? (GAME-scene ga) "puzzleGameOverScene"))
                                   (make-GAME
  
                                    (GAME-menu ga)

                                    (GAME-carGame ga)

                                    (make-puzzleGame
                                     (make-squareOb     (squareOb-im    (puzzleGame-sq      (GAME-puzzGame ga))) (make-position  (random 800) (random 800)))                                                      
                                     (make-triangleOb   (triangleOb-im  (puzzleGame-triang  (GAME-puzzGame ga))) (make-position  (random 800) (random 800)))
                                     (make-rectangleOb  (rectangleOb-im (puzzleGame-rect    (GAME-puzzGame ga))) (make-position  (random 800) (random 800)))
                                     (make-circleOb     (circleOb-im    (puzzleGame-circ    (GAME-puzzGame ga))) (make-position  (random 800) (random 800)))
                                     (puzzleGame-okBut  (GAME-puzzGame ga)))

                                     
                                    (GAME-gOvCar ga)
                                    (GAME-gOvPuzzle ga)
                                    (GAME-exit ga)
                                    "puzzleGameScene")]


                                  [(and (doesClickButton (gameOverScenePuzzle-toMenuBut (GAME-gOvPuzzle ga)) x y mo) (string=? (GAME-scene ga) "puzzleGameOverScene"))
                                   (make-GAME

                                    (GAME-menu ga)

                                    (GAME-carGame ga)

                                    (make-puzzleGame
                                     (make-squareOb    (squareOb-im    (puzzleGame-sq (GAME-puzzGame ga)))     (make-position  (random 800) (random 800)))                                                      
                                     (make-triangleOb  (triangleOb-im  (puzzleGame-triang (GAME-puzzGame ga))) (make-position (random 800) (random 800)))
                                     (make-rectangleOb (rectangleOb-im (puzzleGame-rect (GAME-puzzGame ga)))   (make-position (random 800) (random 800)))
                                     (make-circleOb    (circleOb-im    (puzzleGame-circ (GAME-puzzGame ga)))   (make-position (random 800) (random 800)))
                                     (puzzleGame-okBut (GAME-puzzGame ga)))

                                      
                                    (GAME-gOvCar ga)
                                    (GAME-gOvPuzzle ga)
                                    (GAME-exit ga)
                                    "menu")]

                                        
                                  [(and (doesClickButton (gameOverSceneCar-restartBut (GAME-gOvCar ga)) x y mo) (string=? (GAME-scene ga) "carGameOverScene"))
                                   (make-GAME
                                    
                                    (GAME-menu ga)
   
                                    (make-gameCar (make-theCar (make-position 760 590) (bitmap "./car.png") )
                                                  (make-obstacle (make-position 40 460) (make-velocity (list-ref listVel (random 9)) 0) (text (number->string 2) 40 "red") 2 )
                                                  (make-obstacle (make-position 40 590) (make-velocity (list-ref listVel (random 9)) 0) (text (number->string 7) 40 "red") 7)
                                                  (make-obstacle (make-position 40 730) (make-velocity (list-ref listVel (random 9)) 0) (text (number->string 6) 40 "red") 6)
                                                  0
                                                  (make-figure 6)) 
   
                                    (GAME-puzzGame ga)

                                    (GAME-gOvCar ga)

                                    (GAME-gOvPuzzle ga)
   
                                    (GAME-exit ga)
   
                                    "carGameScene"
                                    )]


                                  [(and (doesClickButton (gameOverSceneCar-toMenuBut (GAME-gOvCar ga)) x y mo) (string=? (GAME-scene ga) "carGameOverScene"))
                                   (make-GAME
   
                                    (GAME-menu ga)
   
                                    (make-gameCar  (make-theCar   (make-position 760 590) (bitmap "./car.png") )
                                                   (make-obstacle (make-position 40 460)  (make-velocity (list-ref listVel (random 9)) 0) (text (number->string 2) 40 "red") 2 )
                                                   (make-obstacle (make-position 40 590)  (make-velocity (list-ref listVel (random 9)) 0) (text (number->string 7) 40 "red") 7)
                                                   (make-obstacle (make-position 40 730)  (make-velocity (list-ref listVel (random 9)) 0) (text (number->string 6) 40 "red") 6)
                                                   0
                                                   (make-figure 6)
                                                   )

                                    (GAME-puzzGame ga)
                                      
                                    (GAME-gOvCar ga)

                                    (GAME-gOvPuzzle ga)
   
                                    (GAME-exit ga)
   
                                    "menu"
                                    )]


                                  ; BAYRAM'S PART:                               
                                    
                                    
                                  [(and (doesDrag   (GAME-puzzGame ga) x y mo)
                                        (string=? (GAME-scene ga) "puzzleGameScene")
                                        (not (= (distCalc (squareOb-pos (puzzleGame-sq (GAME-puzzGame ga))) (make-position 275 275)) 0))
                                        (isInSquare (make-squareOb (squareOb-im (puzzleGame-sq (GAME-puzzGame ga))) (squareOb-pos (puzzleGame-sq (GAME-puzzGame ga)))) x y))

                                   (if (<= 10 (distCalc (squareOb-pos (puzzleGame-sq (GAME-puzzGame ga))) (make-position 275 275)))
                                        
                                       (make-GAME

                                        (GAME-menu ga)

                                        (GAME-carGame ga)
                                         
                                        (make-puzzleGame (make-squareOb      (squareOb-im (puzzleGame-sq (GAME-puzzGame ga))) (make-position x y))
                                                         (puzzleGame-triang (GAME-puzzGame ga))
                                                         (puzzleGame-rect   (GAME-puzzGame ga))
                                                         (puzzleGame-circ   (GAME-puzzGame ga))
                                                         (puzzleGame-okBut  (GAME-puzzGame ga)))

                                        (GAME-gOvCar ga)

                                        (GAME-gOvPuzzle ga)

                                        (GAME-exit ga)

                                        (GAME-scene ga))


                                       (make-GAME

                                        (GAME-menu ga)

                                        (GAME-carGame ga)

                                        (make-puzzleGame (make-squareOb     (squareOb-im (puzzleGame-sq (GAME-puzzGame ga))) (make-position 275 275))
                                                         (puzzleGame-triang (GAME-puzzGame ga))
                                                         (puzzleGame-rect   (GAME-puzzGame ga))
                                                         (puzzleGame-circ   (GAME-puzzGame ga))
                                                         (puzzleGame-okBut  (GAME-puzzGame ga)))
                                         
                                        (GAME-gOvCar ga)

                                        (GAME-gOvPuzzle ga)

                                        (GAME-exit ga)

                                        (GAME-scene ga)))]
                                       
                                       
                                  [(and (doesDrag     (GAME-puzzGame ga) x y mo)
                                        (string=? (GAME-scene ga) "puzzleGameScene")
                                        (not (= (distCalc (triangleOb-pos (puzzleGame-triang (GAME-puzzGame ga))) (make-position 250 670)) 0))
                                        (isInTriangle (make-triangleOb (triangleOb-im (puzzleGame-triang (GAME-puzzGame ga))) (triangleOb-pos (puzzleGame-triang (GAME-puzzGame ga)))) x y))  

                                   (if (<= 10 (distCalc (triangleOb-pos (puzzleGame-triang (GAME-puzzGame ga))) (make-position 250 670)))

                                       (make-GAME
                                         
                                        (GAME-menu ga)

                                        (GAME-carGame ga)
                                         
                                        (make-puzzleGame (puzzleGame-sq    (GAME-puzzGame ga))
                                                         (make-triangleOb  (triangleOb-im (puzzleGame-triang (GAME-puzzGame ga))) (make-position x y))
                                                         (puzzleGame-rect  (GAME-puzzGame ga))
                                                         (puzzleGame-circ  (GAME-puzzGame ga))
                                                         (puzzleGame-okBut (GAME-puzzGame ga)))
                                         
                                        (GAME-gOvCar ga)

                                        (GAME-gOvPuzzle ga)
                                         
                                        (GAME-exit ga)
                                         
                                        (GAME-scene ga))


                                       (make-GAME
                                         
                                        (GAME-menu ga)

                                        (GAME-carGame ga)
                                         
                                        (make-puzzleGame (puzzleGame-sq    (GAME-puzzGame ga))
                                                         (make-triangleOb  (triangleOb-im (puzzleGame-triang (GAME-puzzGame ga))) (make-position 250 670))
                                                         (puzzleGame-rect  (GAME-puzzGame ga))
                                                         (puzzleGame-circ  (GAME-puzzGame ga))
                                                         (puzzleGame-okBut (GAME-puzzGame ga)))
                                         
                                        (GAME-gOvCar ga)

                                        (GAME-gOvPuzzle ga)
                                         
                                        (GAME-exit ga)
                                         
                                        (GAME-scene ga)))]
                                       
                                       
                                  [(and (doesDrag      (GAME-puzzGame ga) x y mo)
                                        (string=? (GAME-scene ga) "puzzleGameScene")
                                        (not (= (distCalc (rectangleOb-pos (puzzleGame-rect (GAME-puzzGame ga))) (make-position 635 350)) 0))
                                        (isInRectangle (make-rectangleOb (rectangleOb-im (puzzleGame-rect (GAME-puzzGame ga))) (rectangleOb-pos (puzzleGame-rect (GAME-puzzGame ga)))) x y))
                                                                                                           
                                   (if (<= 10 (distCalc (rectangleOb-pos (puzzleGame-rect (GAME-puzzGame ga))) (make-position 635 350)))

                                       (make-GAME

                                        (GAME-menu ga)

                                        (GAME-carGame ga)

                                        (make-puzzleGame (puzzleGame-sq     (GAME-puzzGame ga))
                                                         (puzzleGame-triang (GAME-puzzGame ga))
                                                         (make-rectangleOb  (rectangleOb-im (puzzleGame-rect (GAME-puzzGame ga))) (make-position x y))
                                                         (puzzleGame-circ   (GAME-puzzGame ga))
                                                         (puzzleGame-okBut  (GAME-puzzGame ga)))
                                         
                                        (GAME-gOvCar ga)

                                        (GAME-gOvPuzzle ga)

                                        (GAME-exit ga)

                                        (GAME-scene ga))

                                        
                                       (make-GAME

                                        (GAME-menu ga)

                                        (GAME-carGame ga)

                                        (make-puzzleGame (puzzleGame-sq     (GAME-puzzGame ga))
                                                         (puzzleGame-triang (GAME-puzzGame ga))
                                                         (make-rectangleOb  (rectangleOb-im (puzzleGame-rect (GAME-puzzGame ga))) (make-position 635 350))
                                                         (puzzleGame-circ   (GAME-puzzGame ga))
                                                         (puzzleGame-okBut  (GAME-puzzGame ga)))
                                         
                                        (GAME-gOvCar ga)

                                        (GAME-gOvPuzzle ga)

                                        (GAME-exit ga)

                                        (GAME-scene ga)))]


                                  [(and (doesDrag   (GAME-puzzGame ga) x y mo)
                                        (string=? (GAME-scene ga) "puzzleGameScene")
                                        (not (= (distCalc (circleOb-pos (puzzleGame-circ (GAME-puzzGame ga))) (make-position 650 650)) 0))
                                        (isInCircle (make-circleOb (circleOb-im (puzzleGame-circ (GAME-puzzGame ga))) (circleOb-pos (puzzleGame-circ (GAME-puzzGame ga)))) x y))

                                   (if (<= 10 (distCalc (circleOb-pos (puzzleGame-circ (GAME-puzzGame ga))) (make-position 650 650)))

                                       (make-GAME

                                        (GAME-menu ga)

                                        (GAME-carGame ga)

                                        (make-puzzleGame (puzzleGame-sq     (GAME-puzzGame ga))
                                                         (puzzleGame-triang (GAME-puzzGame ga))
                                                         (puzzleGame-rect   (GAME-puzzGame ga))
                                                         (make-circleOb     (circleOb-im (puzzleGame-circ (GAME-puzzGame ga))) (make-position x y))
                                                         (puzzleGame-okBut  (GAME-puzzGame ga)))
                                         
                                        (GAME-gOvCar ga)

                                        (GAME-gOvPuzzle ga)

                                        (GAME-exit ga)

                                        (GAME-scene ga))


                                       (make-GAME

                                        (GAME-menu ga)

                                        (GAME-carGame ga)

                                        (make-puzzleGame (puzzleGame-sq     (GAME-puzzGame ga))
                                                         (puzzleGame-triang (GAME-puzzGame ga))
                                                         (puzzleGame-rect   (GAME-puzzGame ga))
                                                         (make-circleOb     (circleOb-im (puzzleGame-circ (GAME-puzzGame ga))) (make-position 650 650))
                                                         (puzzleGame-okBut  (GAME-puzzGame ga)))
                                         
                                        (GAME-gOvCar ga)

                                        (GAME-gOvPuzzle ga)

                                        (GAME-exit ga)

                                        (GAME-scene ga)))]
                                       
                                        
                                  [else (make-GAME (GAME-menu ga) (GAME-carGame ga) (GAME-puzzGame ga) (GAME-gOvCar ga) (GAME-gOvPuzzle ga) (GAME-exit ga) (GAME-scene ga))]))
                                       

;UMUT'S PART:

; purpose: changing car game scene to game over scene of the car due to wrong answer
; contract: sceneChanger: ga(GAME) -> string
; test:
(check-expect (sceneChanger (make-GAME
                          (make-gameMainMenu (rectangle 800 800 "outline" "yellow") (make-button (make-position 300 300) (rectangle 30 30 "outline" "black")) (make-button (make-position 500 500) (rectangle 30 30 "outline" "black")) (make-button (make-position 700 700) (rectangle 30 30 "outline" "black")))
                          (make-gameCar (make-theCar (make-position 760 730) (circle 10 "solid" "red"))
                                        (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                        (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                        (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                        500 
                                        (make-figure 3))
                          (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                           (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                           (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                           (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                           (make-button (make-position 300 300) (rectangle 20 20 "solid" "red")))
                          (make-gameOverSceneCar (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                          (make-gameOverScenePuzzle (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                          (make-exitScene (empty-scene 800 800))
                          "carGameScene"))
              "carGameScene")

(check-expect (sceneChanger (make-GAME
                          (make-gameMainMenu (rectangle 800 800 "outline" "yellow") (make-button (make-position 300 300) (rectangle 30 30 "outline" "black")) (make-button (make-position 500 500) (rectangle 30 30 "outline" "black")) (make-button (make-position 700 700) (rectangle 30 30 "outline" "black")))
                          (make-gameCar (make-theCar (make-position 760 730) (circle 10 "solid" "red"))
                                        (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                        (make-obstacle (make-position 760 730) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                        (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                        500 
                                        (make-figure 2))
                          (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                           (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                           (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                           (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                           (make-button (make-position 300 300) (rectangle 20 20 "solid" "red")))
                          (make-gameOverSceneCar (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                          (make-gameOverScenePuzzle (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                          (make-exitScene (empty-scene 800 800))
                          "carGameScene"))
              "carGameOverScene")
; function:
(define (sceneChanger ga) (cond [(or
                             
                                          (= -1 (isTrue (gameCar-car   (GAME-carGame ga))
                                                        (gameCar-obs1  (GAME-carGame ga))
                                                        (gameCar-fig   (GAME-carGame ga))))
                                         
                                          (= -1 (isTrue (gameCar-car   (GAME-carGame ga))
                                                        (gameCar-obs2  (GAME-carGame ga))
                                                        (gameCar-fig   (GAME-carGame ga))))
                                         
                                         (= -1 (isTrue  (gameCar-car   (GAME-carGame ga))
                                                        (gameCar-obs3  (GAME-carGame ga))
                                                        (gameCar-fig   (GAME-carGame ga)))))
                                         "carGameOverScene"]
                              

                                [else (GAME-scene ga)]))



; =================================================================================================================================================================================
;                                                   ************* PUZZLE REACTIONS  **************
; ==================================================================================================================================================================================

;BAYRAM'S PART:

; purpose: calculating the distance between the positions
; contract: distCalc: pos1(position) pos2(position) -> number
; test:
(check-expect (distCalc (make-position 0 0) (make-position 5 12) ) 13) 
; function:
(define (distCalc pos1 pos2) (inexact->exact(sqrt (+ (sqr(- (position-x pos1) (position-x pos2))) (sqr(- (position-y pos1) (position-y pos2)))))))



; purpose: determinating whether puzzle are completed or not
; contract: doesFillUp: sq(squareOb) triang(trinagleOb) rect(rectangleOb) circ(circleOb) -> boolean
; test:
(check-expect (doesFillUp (make-squareOb (square 30 "solid" "black") (make-position 500 500)) (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                          (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200)) (make-circleOb (circle 20 "solid" "red") (make-position 140 130)))
              #false)
(check-expect (doesFillUp (make-squareOb (square 30 "solid" "black") (make-position 275 275)) (make-triangleOb (triangle 20 "solid" "red") (make-position 250 670))
                          (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 635 350)) (make-circleOb (circle 20 "solid" "red") (make-position 650 650)))
              #true)
; function:
(define (doesFillUp sq triang rect circ) (if (and  (= (distCalc (squareOb-pos sq)       (make-position 275 275)) 0)
                                                   (= (distCalc (triangleOb-pos triang) (make-position 250 670)) 0)
                                                   (= (distCalc (rectangleOb-pos rect)  (make-position 635 350)) 0)
                                                   (= (distCalc (circleOb-pos circ)     (make-position 650 650)) 0))
                                             #true
                                             #false))




; =================================================================================================================================================================================
;                                                    ********* PUZZLE GAME BACKGROUND DESIGNING  *********
; ==================================================================================================================================================================================

;BAYRAM'S PART:

; purpose: drawing the puzzle game
; contract: finalScenePuzzle: ga(puzzleGame) -> image
; test:
(check-expect (finalScenePuzzle
               (make-puzzleGame
                (make-squareOb (square 30 "solid" "black") (make-position 500 500)) (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200)) (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                (make-button 750 50)))
               (place-image (square 30 "solid" "black")
                            500 500
                            (place-image (triangle 20 "solid" "red")
                                        700 700
                                        (place-image (rectangle 20 20 "outline" "red")
                                                     200 200
                                                     (place-image (circle 20 "solid" "red")
                                                                  140 130
                                                                  puzzleScene)))))
; function:
(define (finalScenePuzzle ga) (place-image (squareOb-im (puzzleGame-sq ga))
                                           (position-x  (squareOb-pos  (puzzleGame-sq ga))) (position-y (squareOb-pos (puzzleGame-sq ga))) 
                                           (place-image (triangleOb-im (puzzleGame-triang ga))
                                                        (position-x    (triangleOb-pos (puzzleGame-triang ga))) (position-y (triangleOb-pos (puzzleGame-triang ga)))
                                                        (place-image   (rectangleOb-im (puzzleGame-rect ga))
                                                                       (position-x     (rectangleOb-pos (puzzleGame-rect ga))) (position-y   (rectangleOb-pos (puzzleGame-rect ga)))
                                                                       (place-image    (circleOb-im     (puzzleGame-circ ga))
                                                                                       (position-x      (circleOb-pos (puzzleGame-circ ga))) (position-y (circleOb-pos (puzzleGame-circ ga)))
                                                                                       puzzleScene))))) 



; =================================================================================================================================================================================
;                                                 *********** PUZZLE GAME GAME-OVER SCENE BACKGROUND DESIGNING  ***********
; ==================================================================================================================================================================================

;BAYRAM'S PART:

;adding the image of 100 on game over scene of puzzle game
(define finalScenePuzzleGameOver (place-image hundred
                                              390 680
                                              imGameOverPuzz))
                                              



; ====================================================================================================================================================================
;                                                        ********** FINAL VERSİON OF THE GAME *********
; ====================================================================================================================================================================

;YUNUS'S PART:

(define finalVersionOfGame

  (make-GAME
   
   (make-gameMainMenu
    menuIm
    (make-button (make-position 258 463) (rectangle 104 26 "outline" "black"))
    (make-button (make-position 546 466) (rectangle 108 30 "outline" "black"))
    (make-button (make-position 199 737) (rectangle 204 56 "outline" "black")))
   
   
   (make-gameCar (make-theCar   (make-position 760 590) (bitmap "./car.png") )
                 (make-obstacle (make-position 40 460)  (make-velocity (list-ref listVel (random 9)) 0) (text (number->string 2) 40 "red") 2)
                 (make-obstacle (make-position 40 590)  (make-velocity (list-ref listVel (random 9)) 0) (text (number->string 7) 40 "red") 7)
                 (make-obstacle (make-position 40 730)  (make-velocity (list-ref listVel (random 9)) 0) (text (number->string 6) 40 "red") 6)
                 0
                 (make-figure 6 )
                 )

   
   (make-puzzleGame
    (make-squareOb imSq      (make-position (random 800) (random 800)))
    (make-triangleOb imTri   (make-position (random 800) (random 800)))
    (make-rectangleOb imRect (make-position (random 800) (random 800)))
    (make-circleOb imCirc    (make-position (random 800) (random 800)))
    (make-button             (make-position 744 56) (square 68 "outline" "black")))

   (make-gameOverSceneCar
    imGameOver
    (make-button (make-position 668 679) (circle 52 "outline" "black"))
    (make-button (make-position 110 711) (circle 52 "outline" "black")))

   (make-gameOverScenePuzzle
    finalScenePuzzleGameOver
    (make-button (make-position 676 676) (square 86 "outline" "black"))
    (make-button (make-position 37 677) (square 87 "outline" "black")))
   
   (make-exitScene exitIm)
   
   "menu"
   ))



;======================================================================================================================================================================
;======================================================================================================================================================================
;******************************************************************** GAME UPDATE FUNCTİONS ********************************************************************************************
;=======================================================================================================================================================================
;======================================================================================================================================================================

;YUNUS'S PART:

; purpose: draw the game  into a scene
; contract: finalDraw: game(GAME) -> image
; test:
(check-expect (finalDraw (make-GAME
                          (make-gameMainMenu (rectangle 800 800 "outline" "yellow") (make-button (make-position 300 300) (rectangle 30 30 "outline" "black")) (make-button (make-position 500 500) (rectangle 30 30 "outline" "black")) (make-button (make-position 700 700) (rectangle 30 30 "outline" "black")))
                          (make-gameCar (make-theCar (make-position 200 220) (circle 10 "solid" "red"))
                                        (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                        (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                        (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                        500 
                                        (make-figure 3))
                          (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                           (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                           (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                           (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                           (make-button (make-position 300 300) (rectangle 20 20 "solid" "red")))
                          (make-gameOverSceneCar (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                          (make-gameOverScenePuzzle (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                          (make-exitScene (empty-scene 800 800))
                          "menu"))
              (rectangle 800 800 "outline" "yellow"))

(check-expect (finalDraw (make-GAME
                          (make-gameMainMenu (rectangle 800 800 "outline" "yellow") (make-button (make-position 300 300) (rectangle 30 30 "outline" "black")) (make-button (make-position 500 500) (rectangle 30 30 "outline" "black")) (make-button (make-position 700 700) (rectangle 30 30 "outline" "black")))
                          (make-gameCar (make-theCar (make-position 200 220) (circle 10 "solid" "red"))
                                        (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                        (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                        (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                        500 
                                        (make-figure 3))
                          (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                           (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                           (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                           (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                           (make-button (make-position 300 300) (rectangle 20 20 "solid" "red")))
                          (make-gameOverSceneCar (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                          (make-gameOverScenePuzzle (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                          (make-exitScene (rectangle 800 800 "solid" "blue"))
                          "exitScene"))
              (rectangle 800 800 "solid" "blue"))
               
               
; function:
(define (finalDraw game) (cond

                           [(string=? "menu"  (GAME-scene game))
                            (gameMainMenu-im  (GAME-menu game))]
                           
                           
                           [(string=? "exitScene" (GAME-scene game)) 
                            (exitScene-im         (GAME-exit game))]

                           
                           [(string=? "carGameOverScene"      (GAME-scene game))
                            (OverSceneDraw (GAME-gOvCar game) (GAME-carGame game))]

                           
                           [(string=? "carGameScene" (GAME-scene game))
                            (finalSceneCar           (GAME-carGame game))]

                           [(string=? "puzzleGameOverScene" (GAME-scene game))
                            (gameOverScenePuzzle-im         (GAME-gOvPuzzle game))]

                           [(string=? "puzzleGameScene" (GAME-scene game))
                            (finalScenePuzzle           (GAME-puzzGame game))]))

                           

;UMUT'S PART:

; purpose: update the game wrt user's key input
; contract: updateKeyCar: g(GAME) k(key) -> GAME
; test:
(check-expect (updateKeyCar (make-GAME
                          (make-gameMainMenu (rectangle 800 800 "outline" "yellow") (make-button (make-position 300 300) (rectangle 30 30 "outline" "black")) (make-button (make-position 500 500) (rectangle 30 30 "outline" "black")) (make-button (make-position 700 700) (rectangle 30 30 "outline" "black")))
                          (make-gameCar (make-theCar (make-position 760 730) (circle 10 "solid" "red"))
                                        (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                        (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                        (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                        500 
                                        (make-figure 3))
                          (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                           (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                           (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                           (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                           (make-button (make-position 300 300) (rectangle 20 20 "solid" "red")))
                          (make-gameOverSceneCar (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                          (make-gameOverScenePuzzle (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                          (make-exitScene (empty-scene 800 800))
                          "carGameScene")
                            "up")
              (make-GAME
                          (make-gameMainMenu (rectangle 800 800 "outline" "yellow") (make-button (make-position 300 300) (rectangle 30 30 "outline" "black")) (make-button (make-position 500 500) (rectangle 30 30 "outline" "black")) (make-button (make-position 700 700) (rectangle 30 30 "outline" "black")))
                          (make-gameCar (make-theCar (make-position 760 590) (circle 10 "solid" "red"))
                                        (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                        (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                        (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                        500 
                                        (make-figure 3))
                          (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                           (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                           (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                           (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                           (make-button (make-position 300 300) (rectangle 20 20 "solid" "red")))
                          (make-gameOverSceneCar (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                          (make-gameOverScenePuzzle (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                          (make-exitScene (empty-scene 800 800))
                          "carGameScene"))
              
;function:
(define (updateKeyCar ga key)

  (cond
    
    [(string=? "carGameScene" (GAME-scene ga))
     
     (make-GAME
      
      (GAME-menu ga)
      
      (make-gameCar
       (moveCar       (gameCar-car (GAME-carGame ga)) key)
       (gameCar-obs1  (GAME-carGame ga))
       (gameCar-obs2  (GAME-carGame ga))
       (gameCar-obs3  (GAME-carGame ga))
       (gameCar-score (GAME-carGame ga))
       (gameCar-fig   (GAME-carGame ga)))
      
      (GAME-puzzGame ga)

      (GAME-gOvCar ga)

      (GAME-gOvPuzzle ga)
      
      (GAME-exit ga)
      
      (GAME-scene ga))]
    
    
    [(string=? "exitScene" (GAME-scene ga)) 
     
     (make-GAME
      
      (GAME-menu ga)
      
      (GAME-carGame ga)

      (GAME-puzzGame ga)
      
      (GAME-gOvCar ga)

      (GAME-gOvPuzzle ga)
      
      (GAME-exit ga)
      
      (GAME-scene ga))]

    
    [(string=? "carGameOverScene" (GAME-scene ga))
     
     (make-GAME
      
      (GAME-menu ga)
      
      (GAME-carGame ga)
      
      (GAME-puzzGame ga)

      (GAME-gOvCar ga)

      (GAME-gOvPuzzle ga)

      (GAME-exit ga)
      
      (GAME-scene ga))]

    
    [(string=? "menu" (GAME-scene ga))
     
     (make-GAME
      
      (GAME-menu ga)
      
      (GAME-carGame ga)
      
      (GAME-puzzGame ga)

      (GAME-gOvCar ga)

      (GAME-gOvPuzzle ga)
      
      (GAME-exit ga)
      
      (GAME-scene ga))]

    
    [(string=? "puzzleGameScene" (GAME-scene ga))
     
     (make-GAME
      
      (GAME-menu ga)
      
      (GAME-carGame ga)

      (GAME-puzzGame ga)
      
      (GAME-gOvCar ga)

      (GAME-gOvPuzzle ga)
      
      (GAME-exit ga)
      
      (sceneChanger ga)
      )]

    
    [(string=? "puzzleGameOverScene" (GAME-scene ga))
     
     (make-GAME
      
      (GAME-menu ga)
      
      (GAME-carGame ga)

      (GAME-puzzGame ga)
      
      (GAME-gOvCar ga)

      (GAME-gOvPuzzle ga)
      
      (GAME-exit ga)
      
      (sceneChanger ga)
      )]))


;UMUT'S PART:

; purpose: update the game wrt time
; contract: updateTickCar: ga(GAME) -> GAME
; test:
(check-expect (updateTickCar (make-GAME
                              (make-gameMainMenu (rectangle 800 800 "outline" "yellow") (make-button (make-position 300 300) (rectangle 30 30 "outline" "black")) (make-button (make-position 500 500) (rectangle 30 30 "outline" "black")) (make-button (make-position 700 700) (rectangle 30 30 "outline" "black")))
                              (make-gameCar (make-theCar (make-position 760 730) (circle 10 "solid" "red"))
                                            (make-obstacle (make-position 100 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                                            (make-obstacle (make-position 500 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                                            (make-obstacle (make-position 300 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                                            500 
                                            (make-figure 3))
                              (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                               (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                               (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                               (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                               (make-button (make-position 300 300) (rectangle 20 20 "solid" "red")))
                              (make-gameOverSceneCar (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                              (make-gameOverScenePuzzle (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
                              (make-exitScene (empty-scene 800 800))
                              "carGameScene"))

              (make-GAME
               (make-gameMainMenu (rectangle 800 800 "outline" "yellow") (make-button (make-position 300 300) (rectangle 30 30 "outline" "black")) (make-button (make-position 500 500) (rectangle 30 30 "outline" "black")) (make-button (make-position 700 700) (rectangle 30 30 "outline" "black")))
               (make-gameCar (make-theCar (make-position 760 730) (circle 10 "solid" "red"))
                             (make-obstacle (make-position 105 300) (make-velocity 5 0) (text (number->string 7) 40 "red") 7 ) 
                             (make-obstacle (make-position 505 500) (make-velocity 5 0) (text (number->string 3) 40 "red") 3 )
                             (make-obstacle (make-position 305 700) (make-velocity 5 0) (text (number->string 1) 40 "red") 1 )
                             500.1 
                             (make-figure 3))
               (make-puzzleGame (make-squareOb (square 30 "solid" "black") (make-position 500 500))
                                (make-triangleOb (triangle 20 "solid" "red") (make-position 700 700))
                                (make-rectangleOb (rectangle 20 20 "outline" "red") (make-position 200 200))
                                (make-circleOb (circle 20 "solid" "red") (make-position 140 130))
                                (make-button (make-position 300 300) (rectangle 20 20 "solid" "red")))
               (make-gameOverSceneCar (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
               (make-gameOverScenePuzzle (empty-scene 800 800) (make-button (make-position 676 676) (square 86 "outline" "black")) (make-button (make-position 37 677) (square 87 "outline" "black")))
               (make-exitScene (empty-scene 800 800))
               "carGameScene"))
; function:
(define (updateTickCar ga)

  (cond

    [(string=? "carGameScene" (GAME-scene ga))
     
     (make-GAME
      
      (GAME-menu ga)
      
      (make-gameCar (gameCar-car  (GAME-carGame ga))
                    (moveObstacle (gameCar-car  (GAME-carGame ga)) (gameCar-obs1 (GAME-carGame ga)) (gameCar-fig (GAME-carGame ga)))
                    (moveObstacle (gameCar-car  (GAME-carGame ga)) (gameCar-obs2 (GAME-carGame ga)) (gameCar-fig (GAME-carGame ga)))
                    (moveObstacle (gameCar-car  (GAME-carGame ga)) (gameCar-obs3 (GAME-carGame ga)) (gameCar-fig (GAME-carGame ga)))
                    (updateScore  (GAME-carGame ga))
                    (updateFigure (gameCar-car  (GAME-carGame ga)) (gameCar-fig  (GAME-carGame ga)) (gameCar-obs1 (GAME-carGame ga)) (gameCar-obs2 (GAME-carGame ga)) (gameCar-obs3 (GAME-carGame ga))))
      
      (GAME-puzzGame ga)

      (GAME-gOvCar ga)

      (GAME-gOvPuzzle ga)
      
      (GAME-exit ga)
      
      (sceneChanger ga)
      )]
    

    [(string=? "menu" (GAME-scene ga))

     (make-GAME
          
      (GAME-menu ga)
      
      (GAME-carGame ga)

      (GAME-puzzGame ga)
      
      (GAME-gOvCar ga)

      (GAME-gOvPuzzle ga)
      
      (GAME-exit ga)
      
      (sceneChanger ga)
      )]

    
    [(string=? "exitScene" (GAME-scene ga)) 

     (make-GAME
          
      (GAME-menu ga)
      
      (GAME-carGame ga)

      (GAME-puzzGame ga)
      
      (GAME-gOvCar ga)

      (GAME-gOvPuzzle ga)
      
      (GAME-exit ga)
      
      (sceneChanger ga)
      )]


    [(string=? "carGameOverScene" (GAME-scene ga))
     
     (make-GAME
      
      (GAME-menu ga)
      
      (GAME-carGame ga)

      (GAME-puzzGame ga)
      
      (GAME-gOvCar ga)

      (GAME-gOvPuzzle ga)
      
      (GAME-exit ga)
      
      (sceneChanger ga)
      )]

    
    [(string=? "puzzleGameOverScene" (GAME-scene ga))
     
     (make-GAME
      
      (GAME-menu ga)
      
      (GAME-carGame ga)

      (GAME-puzzGame ga)
      
      (GAME-gOvCar ga)

      (GAME-gOvPuzzle ga)
      
      (GAME-exit ga)
      
      (sceneChanger ga)
      )]

    
    [(string=? "puzzleGameScene" (GAME-scene ga))
     
     (make-GAME
      
      (GAME-menu ga)
      
      (GAME-carGame ga)

      (make-puzzleGame (puzzleGame-sq   (GAME-puzzGame ga)) (puzzleGame-triang (GAME-puzzGame ga))
                       (puzzleGame-rect (GAME-puzzGame ga)) (puzzleGame-circ   (GAME-puzzGame ga)) (puzzleGame-okBut (GAME-puzzGame ga)))
      
      (GAME-gOvCar ga)

      (GAME-gOvPuzzle ga)
      
      (GAME-exit ga) 
      
      (sceneChanger ga))]))
      



; ====================================================================================================================================================================
;                                                            ********** BIG-BANG *********
; ====================================================================================================================================================================


                                
(big-bang finalVersionOfGame
  (to-draw finalDraw)
  (on-tick updateTickCar)
  (on-key updateKeyCar)
  (on-mouse mouseUpdate))
