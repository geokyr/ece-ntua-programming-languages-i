fun loop_rooms fileName =
    let
        val counter : int ref = ref 0

        fun parse file =
            let

                (* A function to read integers from specified input. *)
                fun readInt input = 
                    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input )

                (* Open input file. *)
                val inStream = TextIO.openIn file

                (* Read size of maze dimensions and consume newline. *)
                val (n, m) = (readInt inStream, readInt inStream)
                val _ = TextIO.inputLine inStream

                fun readLines acc = 
                case TextIO.inputLine inStream of 
                    NONE => rev acc
                |  SOME line => readLines (explode (String.substring (line, 0, m)) :: acc)
                
                val inputList = readLines []:char list list 
                val array = Array2.fromList inputList
                val _ =TextIO.closeIn inStream

            in
                (n, m, array)
            end

        
        
       fun search (i, j, array, rows, columns) = 
            case Array2.sub(array, i, j) of 
                #"1" => #"1"
            |   #"0" => #"0"
            |   #"2" => #"0"
            |   #"U" => if i = 0 then #"1"
                            else (
                                Array2.update(array, i, j, #"2");
                                Array2.update(array, i - 1, j, search (i - 1, j, array, rows, columns));
                                Array2.sub(array, i - 1, j))
            |   #"D" => if i = rows - 1 then #"1"
                            else (
                                Array2.update(array, i, j, #"2");
                                Array2.update(array, i + 1, j, search (i + 1, j, array, rows, columns));
                                Array2.sub(array, i + 1, j))
            |   #"L" => if j = 0 then #"1"
                            else (
                                Array2.update(array, i, j, #"2");
                                Array2.update(array, i, j - 1, search (i, j - 1, array, rows, columns));
                                Array2.sub(array, i, j - 1))
            |   #"R" => if j = columns - 1 then #"1"
                            else (
                                Array2.update(array, i, j, #"2");
                                Array2.update(array, i, j + 1, search (i, j + 1, array, rows, columns));
                                Array2.sub(array, i, j + 1))
            |   _ => #"9"

        fun iterate (n, f) =
            let fun go i = 
                if i < n then (
                    f i; 
                    go (i + 1)) 
                else ()
            in
                go 0
            end

        fun loop (i, j, array, rows, columns) = 
            iterate(rows, fn i =>
                iterate(columns, fn j => (
                    Array2.update(array, i, j, search (i, j, array, rows, columns));
                    if Array2.sub(array, i, j) = #"0" then 
                        counter := (!counter) + 1
                    else ()
                )))

        fun solve (n, m, array) = loop (0, 0, array, n, m)
    in
        solve(parse fileName);
        print(Int.toString(!counter) ^ "\n")
    end