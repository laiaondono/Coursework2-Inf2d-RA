(define (domain domain2)
    (:requirements :adl)

    (:types
        agent tool foe room
        sword - tool
    )

    (:constants
        BoTheseus - agent
        Minobot - foe
    )

    (:predicates
	    (adjacent ?r1 - room ?r2 - room)    ;; ?r1 is connected to ?r2 in the labyrinth
        (located_in ?o - object ?r - room)  ;; ?o is located in room ?r in the labyrinth
        (is_defeated ?m - foe)              ;; Minobot is defeated
        (is_holding ?t - tool)              ;; BoTheseus is holding tool ?t
    )

    (:action move 
        :parameters (?r1 - room ?r2 - room)
        :precondition (and  (adjacent ?r1 ?r2)          ;; the rooms are connected
                            (adjacent ?r2 ?r1) 
                            (located_in BoTheseus ?r1)  ;; BoTheseus is in room ?r1
                            (not (located_in BoTheseus ?r2))
                            (not (= ?r1 ?r2))           ;; the rooms are not the same
                      )
        :effect (and (located_in BoTheseus ?r2)         ;; BoTheseus is in room ?r2
                     (not (located_in BoTheseus ?r1))
                )
    )

    (:action pick_up 
        :parameters (?r - room ?t - tool)
        :precondition (and  (located_in BoTheseus ?r) ;;BoTheseus is in the same room as tool ?t
                            (located_in ?t ?r)
                            (not (exists (?t2 - tool) (is_holding ?t2))) ;; BoTheseus isn't holding anything
                      )
        :effect (is_holding ?t) ;; BoTheseus is holding tool ?t
    )

    (:action slay 
        :parameters (?r - room ?s - sword)
        :precondition (and  (located_in BoTheseus ?r)   ;; BoTheseus is in the same room as Minobot
                            (located_in Minobot ?r)
                            (is_holding ?s)             ;; and BoTheseus is holding a sword
                      )
        :effect (is_defeated Minobot) ;; Minobot is defeated
    )
                
)
