fun parse file =
let
    (* function to read integer from specified input *)
    fun readInt input = 
        Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input )

    (* open input file *)
    val inStream = TextIO.openIn file

    val (n, m) = (readInt inStream, readInt inStream)
    val _ = TextIO.inputLine inStream

    fun readLines acc = 
     case TextIO.inputLine inStream of 
        NONE => rev acc
     |  SOME line => readLines (explode (String.substring (line, 0, m)) :: acc)

    val inputList = readlines []:char list list 
    val _ =TextIO.closeIn inStream

in
  (n, m, inputList)
end

fun check inputList n m = 
    case Array2.sub(inputList, n, m) of
        