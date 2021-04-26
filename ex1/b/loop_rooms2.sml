fun loop_rooms fileName =
    let
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
            let
                val value = Array2.sub(array, i, j)
            in 
                if value = #"1" then (#"1")
                else
                    if value = #"0" orelse value = #"2" then (#"0")
                    else
                        if value = #"U" then
                            if i = 0 then (#"1")
                            else (
                                Array2.update(array, i, j, #"2");
                                Array2.update(array, i - 1, j, search (i - 1, j, array, rows, columns));
                                (Array2.sub(array, i - 1, j)))
                        else
                            if value = #"D" then
                                if i = rows - 1 then (#"1")
                                else (
                                    Array2.update(array, i, j, #"2");
                                    Array2.update(array, i + 1, j, search (i + 1, j, array, rows, columns));
                                    (Array2.sub(array, i + 1, j)))
                            else
                                if value = #"L" then
                                    if j = 0 then (#"1")
                                    else (
                                        Array2.update(array, i, j, #"2");
                                        Array2.update(array, i, j - 1, search (i, j - 1, array, rows, columns));
                                        (Array2.sub(array, i, j - 1)))
                                else
                                    if value = #"R" then
                                        if j = columns - 1 then (#"1")
                                        else (
                                            Array2.update(array, i, j, #"2");
                                            Array2.update(array, i, j + 1, search (i, j + 1, array, rows, columns));
                                            (Array2.sub(array, i, j + 1)))
                                    else (#"9")
            end         
            
        fun loop (i, j, array, rows, columns, counter) = 
            (Array2.update(array, i, j, search(i, j, array, rows, columns));
            if j = columns - 1 andalso i = rows - 1 then
                if Array2.sub(array, i, j) = #"0" then
                    print(Int.toString (counter + 1) ^ "\n")
                else
                    print(Int.toString (counter) ^ "\n")
            else
                if j < columns - 1 then 
                    if Array2.sub(array, i, j) = #"0" then loop(i, j + 1, array, rows, columns, counter + 1)  
                    else loop(i, j + 1, array, rows, columns, counter)
                else 
                    if Array2.sub(array, i, j) = #"0" then loop(i + 1, 0, array, rows, columns, counter + 1)
                    else loop(i + 1, 0, array, rows, columns, counter))
                
        fun solve (n, m, array) = loop (0, 0, array, n, m, 0)
    in
        solve (parse fileName)
    end