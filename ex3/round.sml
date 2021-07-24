fun round fileName =
    let
        fun parse file =
            let
                (* A function to read integers from specified input. *)
                fun readInt input = 
                    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input )

                (* Open input file. *)
                val inStream = TextIO.openIn file

                (* Read number of days and hospitals and consume newline. *)
                val (towns, cars) = (readInt inStream, readInt inStream)
                val _ = TextIO.inputLine inStream

                fun readInts 0 acc = rev acc
                |   readInts i acc = readInts (i - 1) (readInt inStream::acc)
                
                val carPositions = readInts cars []:int list 
                val _ =TextIO.closeIn inStream
            in
                (towns, cars, carPositions)
            end

        val (towns, cars, carPositions) = parse fileName
    
        val answer : int ref = ref (towns * cars)
        val index : int ref = ref 0

        fun maxNum (a, b) =
            if a < b then b
            else a

        fun calculateMaxAndSum t [] maximum sum = (maximum, sum)
          | calculateMaxAndSum t (x :: xs) maximum sum =
              if t >= x then (
                  calculateMaxAndSum t xs (maxNum (maximum, t - x)) (sum + t - x)
              )
              else(
                  calculateMaxAndSum t xs (maxNum (maximum, towns - x + t)) (sum + towns - x + t)
              )

        fun solve ~1 car list = ()
          | solve town car list = (
                let 
                    val (maximum, sum) = calculateMaxAndSum town list 0 0;
                in 
                    if (maximum <= (sum - maximum) + 1) then (
                        if sum <= (!answer) then (
                            answer := sum;
                            index := town
                        )
                        else ()
                    )
                    else ();
                    solve (town - 1) car list
                end
        )
    in
        solve towns cars carPositions;
        print(Int.toString(!answer) ^ " " ^ Int.toString(!index) ^ "\n")
    end