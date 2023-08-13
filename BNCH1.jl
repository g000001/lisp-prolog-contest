#  [1] function call/return
#  **** Tarai ****
#       where number-manipulations may be replaced
#       by those restricted to integer if available
begin base := 10 ibase := 10 end;

function tarai(x, y, z)
  if greaterp(x, y)
    tarai(tarai(sub1(x), y, z), tarai(sub1(y), z, x), tarai(sub1(z), x, y))
  else
    y
  end
end;

function tak(x, y, z)
  if ~ lessp(y, x)
    z
  else
    tak(tak(sub1(x), y, z), tak(sub1(y), z, x), tak(sub1(z), x, y))
  end
end;

#  To speed up, generic arithmetic operations are replaced 
#  by integer arithmetic operations:
#
#("*** For MacLisp user, kill this line and last line\n       to replace the definition. ***",
  #(#"defun", #"tarai", #(#"x", #"y", #"z"),
    #(#"cond",
      #(#(#">", #"x", #"y"),
        #(#"tarai", #(#"tarai", #(#"1-", #"x"), #"y", #"z"),
          #(#"tarai", #(#"1-", #"y"), #"z", #"x"),
          #(#"tarai", #(#"1-", #"z"), #"x", #"y"))),
      #(#"t", #"y"))),
  #(#"defun", #"tak", #(#"x", #"y", #"z"),
    #(#"cond", #(#(#"not", #(#"<", #"y", #"x")), #"z"),
      #(#"t",
        #(#"tak", #(#"tak", #(#"1-", #"x"), #"y", #"z"),
          #(#"tak", #(#"1-", #"y"), #"z", #"x"),
          #(#"tak", #(#"1-", #"z"), #"x", #"y"))))),
  "*** Please kill this line. ***");

#  Measure the following forms:
#  [1-1:]
#  (TARAI 8. 4. 0)       ; tarai is called 12605 times.
#     with 9453 sub1's and 9454 else parts.
#  [1-2:]
#  (TARAI 10. 5. 0)      ; tarai is called 343073 times.
#     with 257304 sub1's.
#  [1-3:]     **** Try only the compiled code! ****
#  (TARAI 12. 6. 0)      ; tarai is called 12604861 times.
#     with 9453645 sub1's.
#  [1-4:]
#  (TAK 18. 12. 6.)       ; tak is called 63609 times.
#     in honor of USA Lisp comunity
# LTJ: No macros.
#"benchmark";

function bench11(iter) benchmark(iter, tarai(8, 4, 0)) end;

function bench12(iter) benchmark(iter, tarai(10, 5, 0)) end;

function bench13(iter) benchmark(1, tarai(12, 6, 0)) end;

function bench14(iter) benchmark(iter, tak(18, 12, 6)) end;

#  If macro is not avaiable, use instead the followings:
#("*** Please this line and the last line. ***",
  #(#"defun", #"bench11", #(#"iter"),
    #(#"prog", #(#"time1", #"time2", #"time3", #"gc", #"run", #"n"),
      #(#"sstatus", #"gctime", 0), #(#"setq", #"time1", #(#"runtime")),
      #(#"setq", #"n", #"iter"), #"l1", #(#"tarai", 8, 4, 0),
      #(#"cond",
        #(#(#"greaterp", #(#"setq", #"n", #(#"sub1", #"n")), 0),
          #(#"go", #"l1"))),
      #(#"setq", #"time2", #(#"runtime")), #(#"setq", #"n", #"iter"), #"l2",
      #(#"cond",
        #(#(#"greaterp", #(#"setq", #"n", #(#"sub1", #"n")), 0),
          #(#"go", #"l2"))),
      #(#"setq", #"time3", #(#"runtime")),
      #(#"setq", #"gc", #(#"status", #"gctime")),
      #(#"setq", #"run",
        #(#"difference", #(#"plus", #"time2", #"time2"), #"time1", #"time3")),
      #(#"terpri"), #(#"princ", "Total = "), #(#"princ", #"run"),
      #(#"princ", "us, Runtime = "),
      #(#"princ", #(#"difference", #"run", #"gc")), #(#"princ", "us, GC = "),
      #(#"princ", #"gc"), #(#"princ", "us, for "), #(#"princ", #"iter"),
      #(#"princ", " iterations."), #(#"terpri"))),
  #(#"defun", #"bench12", #(#"iter"),
    #(#"prog", #(#"time1", #"time2", #"time3", #"gc", #"run", #"n"),
      #(#"sstatus", #"gctime", 0), #(#"setq", #"time1", #(#"runtime")),
      #(#"setq", #"n", #"iter"), #"l1", #(#"tarai", 10, 5, 0),
      #(#"cond",
        #(#(#"greaterp", #(#"setq", #"n", #(#"sub1", #"n")), 0),
          #(#"go", #"l1"))),
      #(#"setq", #"time2", #(#"runtime")), #(#"setq", #"n", #"iter"), #"l2",
      #(#"cond",
        #(#(#"greaterp", #(#"setq", #"n", #(#"sub1", #"n")), 0),
          #(#"go", #"l2"))),
      #(#"setq", #"time3", #(#"runtime")),
      #(#"setq", #"gc", #(#"status", #"gctime")),
      #(#"setq", #"run",
        #(#"difference", #(#"plus", #"time2", #"time2"), #"time1", #"time3")),
      #(#"terpri"), #(#"princ", "Total = "), #(#"princ", #"run"),
      #(#"princ", "us, Runtime = "),
      #(#"princ", #(#"difference", #"run", #"gc")), #(#"princ", "us, GC = "),
      #(#"princ", #"gc"), #(#"princ", "us, for "), #(#"princ", #"iter"),
      #(#"princ", " iterations."), #(#"terpri"))),
  #(#"defun", #"bench13", #"()",
    #(#"prog", #(#"time1", #"time2", #"gc", #"run"),
      #(#"sstatus", #"gctime", 0), #(#"setq", #"time1", #(#"runtime")),
      #(#"tarai", 12, 6, 0), #(#"setq", #"time2", #(#"runtime")),
      #(#"setq", #"gc", #(#"status", #"gctime")),
      #(#"setq", #"run", #(#"difference", #"time2", #"time1")), #(#"terpri"),
      #(#"princ", "Total = "), #(#"princ", #"run"),
      #(#"princ", "us, Runtime = "),
      #(#"princ", #(#"difference", #"run", #"gc")), #(#"princ", "us, GC = "),
      #(#"princ", #"gc"), #(#"princ", "us."), #(#"terpri"))),
  "*** Please kill this line if macro is not available. ***");

#  (BENCH11 10.)
#  (BENCH12 1)
#  (BENCH13)
#  (BENCH14 1)
"eof";

