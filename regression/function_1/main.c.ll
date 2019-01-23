; ModuleID = 'function_1/main.c'
source_filename = "function_1/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@d = dso_local global double 0.000000e+00, align 8, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @f1() #0 !dbg !11 {
entry:
  store double 1.000000e+00, double* @d, align 8, !dbg !14
  ret void, !dbg !15
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !16 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !20, metadata !DIExpression()), !dbg !21
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
  %cmp7 = fcmp oeq double %4, 2.000000e+00, !dbg !41
  %conv = zext i1 %cmp7 to i32, !dbg !41
  %call8 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !42
  %5 = load i32, i32* %retval, align 4, !dbg !43
  ret i32 %5, !dbg !43
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @nondet_int(...) #2

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!7, !8, !9}
!llvm.ident = !{!10}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "d", scope: !2, file: !3, line: 5, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "function_1/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!4 = !{}
!5 = !{!0}
!6 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!7 = !{i32 2, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!11 = distinct !DISubprogram(name: "f1", scope: !3, file: !3, line: 7, type: !12, isLocal: false, isDefinition: true, scopeLine: 8, isOptimized: false, unit: !2, retainedNodes: !4)
!12 = !DISubroutineType(types: !13)
!13 = !{null}
!14 = !DILocation(line: 9, column: 5, scope: !11)
!15 = !DILocation(line: 10, column: 1, scope: !11)
!16 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 12, type: !17, isLocal: false, isDefinition: true, scopeLine: 13, isOptimized: false, unit: !2, retainedNodes: !4)
!17 = !DISubroutineType(types: !18)
!18 = !{!19}
!19 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!20 = !DILocalVariable(name: "x", scope: !16, file: !3, line: 14, type: !19)
!21 = !DILocation(line: 14, column: 7, scope: !16)
!22 = !DILocation(line: 16, column: 6, scope: !23)
!23 = distinct !DILexicalBlock(scope: !16, file: !3, line: 16, column: 6)
!24 = !DILocation(line: 16, column: 6, scope: !16)
!25 = !DILocation(line: 17, column: 7, scope: !23)
!26 = !DILocation(line: 17, column: 5, scope: !23)
!27 = !DILocation(line: 19, column: 10, scope: !16)
!28 = !DILocation(line: 21, column: 6, scope: !29)
!29 = distinct !DILexicalBlock(scope: !16, file: !3, line: 21, column: 6)
!30 = !DILocation(line: 21, column: 7, scope: !29)
!31 = !DILocation(line: 21, column: 6, scope: !16)
!32 = !DILocation(line: 22, column: 5, scope: !29)
!33 = !DILocation(line: 22, column: 4, scope: !29)
!34 = !DILocation(line: 24, column: 6, scope: !35)
!35 = distinct !DILexicalBlock(scope: !16, file: !3, line: 24, column: 6)
!36 = !DILocation(line: 24, column: 7, scope: !35)
!37 = !DILocation(line: 24, column: 6, scope: !16)
!38 = !DILocation(line: 25, column: 5, scope: !35)
!39 = !DILocation(line: 25, column: 4, scope: !35)
!40 = !DILocation(line: 27, column: 10, scope: !16)
!41 = !DILocation(line: 27, column: 12, scope: !16)
!42 = !DILocation(line: 27, column: 3, scope: !16)
!43 = !DILocation(line: 28, column: 1, scope: !16)
