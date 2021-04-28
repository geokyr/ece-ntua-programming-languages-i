fun longest fileName =
    let
        fun parse file =
            let
                (* A function to read integers from specified input. *)
                fun readInt input = 
                    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input )

                (* Open input file. *)
                val inStream = TextIO.openIn file

                (* Read number of days and hospitals and consume newline. *)
                val (days, hospitals) = (readInt inStream, readInt inStream)
                val _ = TextIO.inputLine inStream

                fun readInts 0 acc = rev acc
                |   readInts i acc = readInts (i - 1) (readInt inStream::acc)
                
                val inputList = readInts days []:int list 
                val _ =TextIO.closeIn inStream
            in
                (days, hospitals, inputList)
            end

        val (days, hospitals, inputList) = parse fileName

        (* Iterate function with the help of:
        https://stackoverflow.com/questions/54337199/how-to-make-nested-for-loop-over-two-integer-ranges *)
        fun iterate (n, f) =
            let fun go i = 
                if i < n then (
                    f i; 
                    go (i + 1)) 
                else ()
            in
                go 1
            end
        
        (* Reverse iterate function. *)
        fun reverseIterate (n, f) =
            let fun go i = 
                if i >= 0 then (
                    f i; 
                    go (i - 1)) 
                else ()
            in
                go n
            end

        (* Modify the list according to our algorithm logic noted in the end. *)
        fun modify list n = 
            map(fn x => ~x - n) list;
        
        (* Replace the list with its prefix sum list, by adding every element to the previous sum. *)
        fun prefix (x::y::xs) = x::prefix(x+y::xs)
        |   prefix xs = xs;

        (* l is the prefix list that is then copied into an array. *)
        val l = prefix(0::modify inputList hospitals)
        val arr = Array.fromList l
        val lmin = Array.array(days + 1, 0);
        val rmax = Array.array(days + 1, 0);

        val maxDiff : int ref = ref ~1

        fun maxDiffCalc (i, j, n, left, right) =
            if i < n andalso j < n then
                if Array.sub(left, i) <= Array.sub(right, j) then (
                    if j + 1 < n andalso Array.sub(right, j + 1) >= Array.sub(left, i) then maxDiffCalc(i, j + 1, n, left, right)
                    else (
                    maxDiff := Int.max((!maxDiff), (j - i));
                    maxDiffCalc(i, j + 1, n, left, right)))
                else if j - 1 > i then maxDiffCalc(i + 1, j, n, left, right)
                    else maxDiffCalc(i + 1, j + 1, n, left, right)
            else ()

        fun solve array n = (
            iterate(n, fn i =>
                Array.update(lmin, i, Int.min((Array.sub(array, i)), Array.sub(lmin, i - 1))));
            
            Array.update(rmax, n - 1, Array.sub(array, n - 1));
            reverseIterate(n - 2, fn j =>
                Array.update(rmax, j, Int.max((Array.sub(array, j)), Array.sub(rmax, j + 1))));
            
            maxDiffCalc (0, 0, n, lmin, rmax))
            
    in
        solve arr (days + 1);
        print(Int.toString(!maxDiff) ^ "\n")
    end

(* Based on the following idea:
*
*  -average/hospitals >= 1 =>
*  (-sum/days)/hospitals >= 1 =>
*  (-sum/days) >= hospitals => (subtract hospitals from both sides)
*  (-sum'/days) >= 0 =>
*  (-average') >= 0
* 
*  and with an algorithm similar to this following logic:
*  https://geeksforgeeks.org/longest-subarray-having-average-greater-than-or-equal-to-x-set-2/?fbclid=IwAR0H2CBTKkr0SzIUXKIKUODf__OIGSspz3ABqEXODU4J-cVbqNT-T6DVVls 
*)