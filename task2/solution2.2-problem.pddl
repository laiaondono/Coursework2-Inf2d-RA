(define (problem problem22)
    (:domain domain2)
    
    (:objects
        A B C D E F L - room
        sword - sword
    )

    (:init
        (adjacent F E)
        (adjacent E F)
        (adjacent E B)
        (adjacent B E)
        (adjacent B C)
        (adjacent C B)
        (adjacent C D)
        (adjacent D C)
        (adjacent B A)
        (adjacent A B)
        (adjacent A L)
        (adjacent L A)
        (located_in BoTheseus E)
        (located_in Minobot L)
        (located_in sword D)
    )

    (:goal 
        (and (is_defeated Minobot) (located_in BoTheseus E))
    )
)
