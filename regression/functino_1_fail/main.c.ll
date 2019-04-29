; ModuleID = 'functino_1_fail/main.c'
source_filename = "functino_1_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@d = dso_local global double 0.000000e+00, align 8, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @nondet_int() #0 !dbg !11 {
entry:
  %x = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !15, metadata !DIExpression()), !dbg !16
  %0 = load i32, i32* %x, align 4, !dbg !17
  ret i32 %0, !dbg !18
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @f1() #0 !dbg !19 {
entry:
  store double 1.000000e+00, double* @d, align 8, !dbg !22
  ret void, !dbg !23
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !24 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !25, metadata !DIExpression()), !dbg !26
  store i32 2, i32* %x, align 4, !dbg !26
  %call = call i32 @nondet_int(), !dbg !27
  %tobool = icmp ne i32 %call, 0, !dbg !27
  br i1 %tobool, label %if.then, label %if.end, !dbg !29

if.then:                                          ; preds = %entry
  store i32 4, i32* %x, align 4, !dbg !30
  br label %if.end, !dbg !31

if.end:                                           ; preds = %if.then, %entry
  call void @f1(), !dbg !32
  %0 = load i32, i32* %x, align 4, !dbg !33
  %cmp = icmp eq i32 %0, 2, !dbg !35
  br i1 %cmp, label %if.then1, label %if.end2, !dbg !36

if.then1:                                         ; preds = %if.end
  %1 = load double, double* @d, align 8, !dbg !37
  %add = fadd double %1, 1.000000e+00, !dbg !37
  store double %add, double* @d, align 8, !dbg !37
  br label %if.end2, !dbg !38

if.end2:                                          ; preds = %if.then1, %if.end
  %2 = load i32, i32* %x, align 4, !dbg !39
  %cmp3 = icmp sgt i32 %2, 3, !dbg !41
  br i1 %cmp3, label %if.then4, label %if.end6, !dbg !42

if.then4:                                         ; preds = %if.end2
  %3 = load double, double* @d, align 8, !dbg !43
  %add5 = fadd double %3, 1.000000e+00, !dbg !43
  store double %add5, double* @d, align 8, !dbg !43
  br label %if.end6, !dbg !44

if.end6:                                          ; preds = %if.then4, %if.end2
  %4 = load double, double* @d, align 8, !dbg !45
  %cmp7 = fcmp une double %4, 2.000000e+00, !dbg !46
  %conv = zext i1 %cmp7 to i32, !dbg !46
  %call8 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !47
  %5 = load i32, i32* %retval, align 4, !dbg !48
  ret i32 %5, !dbg !48
}

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!7, !8, !9}
!llvm.ident = !{!10}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "d", scope: !2, file: !3, line: 6, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, nameTableKind: None)
!3 = !DIFile(filename: "functino_1_fail/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!4 = !{}
!5 = !{!0}
!6 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!7 = !{i32 2, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = !{!"clang version 8.0.0 "}
!11 = distinct !DISubprogram(name: "nondet_int", scope: !3, file: !3, line: 1, type: !12, scopeLine: 1, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!12 = !DISubroutineType(types: !13)
!13 = !{!14}
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DILocalVariable(name: "x", scope: !11, file: !3, line: 2, type: !14)
!16 = !DILocation(line: 2, column: 7, scope: !11)
!17 = !DILocation(line: 3, column: 10, scope: !11)
!18 = !DILocation(line: 3, column: 3, scope: !11)
!19 = distinct !DISubprogram(name: "f1", scope: !3, file: !3, line: 8, type: !20, scopeLine: 9, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!20 = !DISubroutineType(types: !21)
!21 = !{null}
!22 = !DILocation(line: 10, column: 5, scope: !19)
!23 = !DILocation(line: 11, column: 1, scope: !19)
!24 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 13, type: !12, scopeLine: 14, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!25 = !DILocalVariable(name: "x", scope: !24, file: !3, line: 15, type: !14)
!26 = !DILocation(line: 15, column: 7, scope: !24)
!27 = !DILocation(line: 17, column: 6, scope: !28)
!28 = distinct !DILexicalBlock(scope: !24, file: !3, line: 17, column: 6)
!29 = !DILocation(line: 17, column: 6, scope: !24)
!30 = !DILocation(line: 18, column: 7, scope: !28)
!31 = !DILocation(line: 18, column: 5, scope: !28)
!32 = !DILocation(line: 20, column: 14, scope: !24)
!33 = !DILocation(line: 22, column: 6, scope: !34)
!34 = distinct !DILexicalBlock(scope: !24, file: !3, line: 22, column: 6)
!35 = !DILocation(line: 22, column: 7, scope: !34)
!36 = !DILocation(line: 22, column: 6, scope: !24)
!37 = !DILocation(line: 23, column: 5, scope: !34)
!38 = !DILocation(line: 23, column: 4, scope: !34)
!39 = !DILocation(line: 25, column: 6, scope: !40)
!40 = distinct !DILexicalBlock(scope: !24, file: !3, line: 25, column: 6)
!41 = !DILocation(line: 25, column: 7, scope: !40)
!42 = !DILocation(line: 25, column: 6, scope: !24)
!43 = !DILocation(line: 26, column: 5, scope: !40)
!44 = !DILocation(line: 26, column: 4, scope: !40)
!45 = !DILocation(line: 28, column: 10, scope: !24)
!46 = !DILocation(line: 28, column: 12, scope: !24)
!47 = !DILocation(line: 28, column: 3, scope: !24)
!48 = !DILocation(line: 29, column: 1, scope: !24)
