(define (problem problem33)
    (:domain domain33)
    
    (:objects
        A B C D E F L - room
        gate - gate
        sword - sword
        key - key
        whetstone - whetstone
        yarn1 yarn2 - yarnball
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
        (located_in Autoadne E)
        (located_in Minobot L)
        (located_in sword D)
        (is_blunt sword)
        (located_in_between gate A L)
        (located_in_between gate L A)
        (is_locked gate)
        (located_in key F)
        (located_in whetstone B)
        (located_in yarn1 E)
        (located_in yarn2 A)
        (= (yarn_left yarn1) 3)
        (= (yarn_left yarn2) 3)
        (marked E)
    )

    (:goal 
        (is_defeated Minobot)
    )
    
)
