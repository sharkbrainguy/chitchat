;;; Ord
;;; ---
;;;
;;; Types that implement 'Ord' have a perfect ordering
(protocol Ord
    (method (greater-than Ord Ord) Boolean)
    (method (equal Ord Ord) Boolean))

(Ord implement Number
     (method (greater-than a b)
        (a > b))

     (method (equal a b)
        (a == b)))

;;; OrderedSet
;;; ----------
;;;
;;; A Collection class that wraps an Array.
;;; It maintains immutability, an order, and
;;; does not contain duplicates
;;; 
;;; Items of the Ordered Set should implement 'Ord'
(class OrderedSet
    (constructor (items, ordered, distinct)
        (set! this.items (or items #[]))

        ;; ensure the qualities of the ordered set in this.items
        ;; call uniquify! unless the items are known to be distinct
        ;; call sort! unless the items are known to be sorted
        (if distinct.isFalse? (this uniquify!)
            ordered.isFalse?  (this sort!))

    (method (contains? needle)
        (this.items contains? needle))

    (method (asArray)
        ;; return a clone so that clients don't
        ;; mutate our internal array
        this.items.cloneArray)

    (method (slice a b)
        (this.items slice a, b))

    (method (nth i)
        this.items.[i])

    (method (length)
        this.items.length)

    (method (concat ls)
        (let (dest this

              ;; ls can be an OrderedSet or an Array
              items  (if (ls isAn OrderedSet) ls.items
                         (ls isAn Array) ls)

              ;; items that don't exist in the destination
              new-items (ls filter ^(dest contains #0)))

            ;; return the same OrderedSet unless there are new items
            (if new-items.isEmpty?
              this
              (OrderedSet new (this.items concat new-items) true))))

    (method (sort!)
        ;; Ensure that this.items is sorted by the Ord generics
        (this.items sort ^(if (Ord greater-than #0, #1) MORE
                              (Ord greater-than #1, #0) LESS
                              EQUAL)))

    (method (uniqify!)
        ;; Ensure that this.items is distinct
        (set! this.items
            (this.items reduce ^[out, item] (if (out contains? item)
                                                out
                                                (out concat item))
                                #[]))) 
