; ModuleID = 'functino_1_fail/main.c'
source_filename = "functino_1_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@d = global double 0.000000e+00, align 8, !dbg !0

; Function Attrs: noinline nounwind uwtable
define void @f1() #0 !dbg !10 {
entry:
  store double 1.000000e+00, double* @d, align 8, !dbg !13
  ret void, !dbg !14
}

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !15 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !19, metadata !20), !dbg !21
  store i32 2, i32* %x, align 4, !dbg !21
  %call = call i32 (...) @nondet_int(), !dbg !22
  %tobool = icmp ne i32 %call, 0, !dbg !22
  br i1 %tobool, label %if.then, label %if.end, !dbg !24

if.then:                                          ; preds = %entry
  store i32 4, i32* %x, align 4, !dbg !25
  br label %if.end, !dbg !26

if.end:                                           ; preds = %if.then, %entry
  call void @f1(), !dbg !27
  %0 = load i32, i32* %x, align 4, !dbg !28
  %cmp = icmp eq i32 %0, 2, !dbg !30
  br i1 %cmp, label %if.then1, label %if.end2, !dbg !31

if.then1:                                         ; preds = %if.end
  %1 = load double, double* @d, align 8, !dbg !32
  %add = fadd double %1, 1.000000e+00, !dbg !32
  store double %add, double* @d, align 8, !dbg !32
  br label %if.end2, !dbg !33

if.end2:                                          ; preds = %if.then1, %if.end
  %2 = load i32, i32* %x, align 4, !dbg !34
  %cmp3 = icmp sgt i32 %2, 3, !dbg !36
  br i1 %cmp3, label %if.then4, label %if.end6, !dbg !37

if.then4:                                         ; preds = %if.end2
  %3 = load double, double* @d, align 8, !dbg !38
  %add5 = fadd double %3, 1.000000e+00, !dbg !38
  store double %add5, double* @d, align 8, !dbg !38
  br label %if.end6, !dbg !39

if.end6:                                          ; preds = %if.then4, %if.end2
  %4 = load double, double* @d, align 8, !dbg !40
  %cmp7 = fcmp une double %4, 2.000000e+00, !dbg !41
  %conv = zext i1 %cmp7 to i32, !dbg !41
  %call8 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !42
  %5 = load i32, i32* %retval, align 4, !dbg !43
  ret i32 %5, !dbg !43
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @nondet_int(...) #2

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!7, !8}
!llvm.ident = !{!9}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "d", scope: !2, file: !3, line: 3, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "functino_1_fail/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!4 = !{}
!5 = !{!0}
!6 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!7 = !{i32 2, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{!"clang version 5.0.0 (trunk 295264)"}
!10 = distinct !DISubprogram(name: "f1", scope: !3, file: !3, line: 5, type: !11, isLocal: false, isDefinition: true, scopeLine: 6, isOptimized: false, unit: !2, variables: !4)
!11 = !DISubroutineType(types: !12)
!12 = !{null}
!13 = !DILocation(line: 7, column: 5, scope: !10)
!14 = !DILocation(line: 8, column: 1, scope: !10)
!15 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 10, type: !16, isLocal: false, isDefinition: true, scopeLine: 11, isOptimized: false, unit: !2, variables: !4)
!16 = !DISubroutineType(types: !17)
!17 = !{!18}
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DILocalVariable(name: "x", scope: !15, file: !3, line: 12, type: !18)
!20 = !DIExpression()
!21 = !DILocation(line: 12, column: 7, scope: !15)
!22 = !DILocation(line: 14, column: 6, scope: !23)
!23 = distinct !DILexicalBlock(scope: !15, file: !3, line: 14, column: 6)
!24 = !DILocation(line: 14, column: 6, scope: !15)
!25 = !DILocation(line: 15, column: 7, scope: !23)
!26 = !DILocation(line: 15, column: 5, scope: !23)
!27 = !DILocation(line: 17, column: 10, scope: !15)
!28 = !DILocation(line: 19, column: 6, scope: !29)
!29 = distinct !DILexicalBlock(scope: !15, file: !3, line: 19, column: 6)
!30 = !DILocation(line: 19, column: 7, scope: !29)
!31 = !DILocation(line: 19, column: 6, scope: !15)
!32 = !DILocation(line: 20, column: 5, scope: !29)
!33 = !DILocation(line: 20, column: 4, scope: !29)
!34 = !DILocation(line: 22, column: 6, scope: !35)
!35 = distinct !DILexicalBlock(scope: !15, file: !3, line: 22, column: 6)
!36 = !DILocation(line: 22, column: 7, scope: !35)
!37 = !DILocation(line: 22, column: 6, scope: !15)
!38 = !DILocation(line: 23, column: 5, scope: !35)
!39 = !DILocation(line: 23, column: 4, scope: !35)
!40 = !DILocation(line: 25, column: 10, scope: !15)
!41 = !DILocation(line: 25, column: 12, scope: !15)
!42 = !DILocation(line: 25, column: 3, scope: !15)
!43 = !DILocation(line: 26, column: 1, scope: !15)
