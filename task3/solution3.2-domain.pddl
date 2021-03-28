(define (domain domain32)
    (:requirements :adl)

    (:types
        agent tool foe room gate
        sword key whetstone yarnball - tool
    )

    (:constants
        BoTheseus - agent
        Minobot - foe
    )

    (:predicates
	    (adjacent ?r1 - room ?r2 - room)    ;; ?r1 is connected to ?r2 in the labyrinth
        (located_in ?o - object ?r - room)  ;; ?o is located in room ?r in the labyrinth
        (is_defeated ?m - foe)        ;; ?m is defeated
        (is_holding ?t - tool)              ;; BoTheseus is holding a tool
        
        (located_in_between ?g - gate ?r1 - room ?r2 - room)     ;; gate ?g is located between chambers ?r1 and ?r2
        (is_locked ?g - gate)               ;; gate ?g is locked
        (is_blunt ?s - sword)               ;; sword ?s is blunt

        (marked ?r - room)                  ;; BoTheseus has been in (and marked with yarn) room ?r
    )

    (:functions
        (yarn_left ?y - yarnball) ;; yarn left to mark locations in yarn ball ?y
    )

    (:action move_and_mark
        :parameters (?r1 - room ?r2 - room ?y - yarnball)
        :precondition (and  (adjacent ?r1 ?r2)          ;; the rooms are connected
                            (adjacent ?r2 ?r1) 
                            (located_in BoTheseus ?r1)  ;;BoTheseus is in the room ?r1
                            (not (located_in BoTheseus ?r2))
                            (not (= ?r1 ?r2))
                            (or (not (exists (?g - gate) (or (located_in_between ?g ?r1 ?r2) ;; there is no gate
                                                             (located_in_between ?g ?r2 ?r1) )))
                                (exists (?g - gate) (and (or (located_in_between ?g ?r1 ?r2) ;; or if there is it's unlocked
                                                             (located_in_between ?g ?r2 ?r1))
                                                         (not (is_locked ?g)) ))
                            )
                            (not (marked ?r2))      ;; still haven't been to that room (it's not marked with yarn)
                            (is_holding ?y)         ;; BoTheseus is holding a ball of yarn ?y
                            (> (yarn_left ?y) 0)    ;; and that ball ?y has yarn left
                      ) 
        :effect (and (located_in BoTheseus ?r2)         ;; BoTheseus is in room ?r2
                     (not (located_in BoTheseus ?r1))
                     (marked ?r2)                       ;; room ?r2 has been marked
                     (decrease (yarn_left ?y) 1)        ;; we have 1 location less to mark with yarn ?y
                     (when (= (yarn_left ?y) 1)         ;; = 1 because the effects haven't been applied yet
                           (not (is_holding ?y)))       ;; if there is no more yarn left BoTheseus isn't holding it anymore
                )
    )

    (:action move 
        :parameters (?r1 - room ?r2 - room)
        :precondition (and  (adjacent ?r1 ?r2)          ;;rooms are connected
                            (adjacent ?r2 ?r1) 
                            (located_in BoTheseus ?r1)  ;;BoTheseus is in the room ?r1
                            (not (located_in BoTheseus ?r2))
                            (not (= ?r1 ?r2))
                            (or (not (exists (?g - gate) (or (located_in_between ?g ?r1 ?r2) ;; there is no gate
                                                             (located_in_between ?g ?r2 ?r1) )))
                                (exists (?g - gate) (and (or (located_in_between ?g ?r1 ?r2) ;; or if there is it's unlocked
                                                             (located_in_between ?g ?r2 ?r1))
                                                         (not (is_locked ?g)) ))
                            )
                            (marked ?r2) ;; BoTheseus has already been to the new room ?r2
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
        :effect (and (is_holding ?t)            ;; BoTheseus is holding tool ?t
                     (not (located_in ?t ?r)))  ;; with this we avoid picking it up yarn again when there is no more left in the yarn ball
    )

    (:action drop 
        :parameters (?r - room ?t - tool)
        :precondition (and  (located_in BoTheseus ?r)   ;; BoTheseus is in room ?r
                            (is_holding ?t)            ;; BoTheseus is holding tool ?t
                      )
        :effect (and (not (is_holding ?t))  ;; BoTheseus isn't holding anything
                     (located_in ?t ?r) )   ;; tool ?t is located in room ?r
    )

    (:action unlock_gate 
        :parameters (?r - room ?g - gate ?k - key)
        :precondition (and  (located_in BoTheseus ?r)                               ;; BoTheseus is in room ?r
                            (exists (?r2 - room) (and (or (adjacent ?r ?r2)         ;; in an adjacent room ?r2 there is a gate ?g
                                                          (adjacent ?r2 ?r))
                                                      (or (located_in_between ?g ?r ?r2)
                                                          (located_in_between ?g ?r2 ?r))
                                                      (not (= ?r ?r2)) ))
                            (is_locked ?g)      ;; the gate ?g is locked
                            (is_holding ?k)     ;; BoTheseus is holding a key ?k
                      )
        :effect (not (is_locked ?g))
    )

    (:action sharpen_sword 
        :parameters (?r - room ?t - whetstone ?s - sword)
        :precondition (and  (located_in BoTheseus ?r)   ;; BoTheseus is in the same room as the whetstone
                            (located_in ?t ?r)
                            (is_holding ?s)             ;; BoTheseus is holding the sword ?s
                      )
        :effect (not (is_blunt ?s)) ;; the sword ?s has been sharpened
    )

    (:action slay 
        :parameters (?r - room ?s - sword)
        :precondition (and  (located_in BoTheseus ?r)   ;; BoTheseus is in the same room as Minobot
                            (located_in Minobot ?r)
                            (is_holding ?s)             ;; and BoTheseus is holding a sword
                            (not (is_blunt ?s))         ;; the sword ?s has been sharpened
                      )
        :effect (is_defeated Minobot) ;; Minobot is defeated
    )
                
)
