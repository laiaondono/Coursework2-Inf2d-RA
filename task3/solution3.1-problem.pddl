(define (problem problem31)
    (:domain domain31)
    
    (:objects
        A B C D E F L - room
        gate - gate
        sword - sword
        key - key
        whetstone - whetstone
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
        (is_blunt sword)
        (located_in_between gate A L)
        (located_in_between gate L A)
        (is_locked gate)
        (located_in key F)
        (located_in whetstone E)
    )

    (:goal 
        (is_defeated Minobot)
    )
    
)
