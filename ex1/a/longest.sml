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

        fun modify list n = 
            map(fn x => ~x - n) list;
        
        (* Replace the list with its prefix sum list, by adding every element to the previous sum. *)
        fun prefix (x::y::xs) = x::prefix(x+y::xs)
        |   prefix xs = xs;

        val counter : int ref = ref ~1

        val l = prefix(0::modify inputList hospitals)
        val arr = Array.fromList l
        val lmin = Array.array(days + 1, 0);
        val rmax = Array.array(days + 1, 0);
        
        fun solve array = 
            
    in
        solve(arr)
    end

(* while (j < n && i < n) {
       // printf("i = %i j = %i LMin[%i] =  %i RMax[%i] = %i ", i, j, i, LMin[i], j, RMax[j] );
        if (LMin[i] <= RMax[j]) {
            maxDiff = max(maxDiff, j - i );
            j = j + 1;
        }
        else if(j > i)
            i = i + 1;
        else 
            j = j + 1;
} *)