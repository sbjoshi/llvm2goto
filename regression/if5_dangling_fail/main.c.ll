; ModuleID = 'if5_dangling_fail/main.c'
source_filename = "if5_dangling_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %testscore = alloca i32, align 4
  %fail = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %testscore, metadata !11, metadata !DIExpression()), !dbg !12
  store i32 55, i32* %testscore, align 4, !dbg !12
  call void @llvm.dbg.declare(metadata i32* %fail, metadata !13, metadata !DIExpression()), !dbg !14
  store i32 0, i32* %fail, align 4, !dbg !14
  %0 = load i32, i32* %testscore, align 4, !dbg !15
  %cmp = icmp sge i32 %0, 50, !dbg !17
  br i1 %cmp, label %if.then, label %if.else, !dbg !18

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %testscore, align 4, !dbg !19
  %cmp1 = icmp sgt i32 %1, 90, !dbg !22
  br i1 %cmp1, label %if.then2, label %if.end, !dbg !23

if.then2:                                         ; preds = %if.then
  store i32 0, i32* %fail, align 4, !dbg !24
  br label %if.end, !dbg !25

if.end:                                           ; preds = %if.then2, %if.then
  br label %if.end3, !dbg !26

if.else:                                          ; preds = %entry
  store i32 1, i32* %fail, align 4, !dbg !27
  br label %if.end3

if.end3:                                          ; preds = %if.else, %if.end
  %2 = load i32, i32* %fail, align 4, !dbg !28
  %cmp4 = icmp eq i32 %2, 1, !dbg !29
  %conv = zext i1 %cmp4 to i32, !dbg !29
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !30
  ret i32 0, !dbg !31
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "if5_dangling_fail/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !8, scopeLine: 2, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "testscore", scope: !7, file: !1, line: 3, type: !10)
!12 = !DILocation(line: 3, column: 7, scope: !7)
!13 = !DILocalVariable(name: "fail", scope: !7, file: !1, line: 4, type: !10)
!14 = !DILocation(line: 4, column: 7, scope: !7)
!15 = !DILocation(line: 6, column: 6, scope: !16)
!16 = distinct !DILexicalBlock(scope: !7, file: !1, line: 6, column: 6)
!17 = !DILocation(line: 6, column: 16, scope: !16)
!18 = !DILocation(line: 6, column: 6, scope: !7)
!19 = !DILocation(line: 8, column: 10, scope: !20)
!20 = distinct !DILexicalBlock(scope: !21, file: !1, line: 8, column: 10)
!21 = distinct !DILexicalBlock(scope: !16, file: !1, line: 7, column: 3)
!22 = !DILocation(line: 8, column: 20, scope: !20)
!23 = !DILocation(line: 8, column: 10, scope: !21)
!24 = !DILocation(line: 9, column: 12, scope: !20)
!25 = !DILocation(line: 9, column: 7, scope: !20)
!26 = !DILocation(line: 10, column: 3, scope: !21)
!27 = !DILocation(line: 12, column: 10, scope: !16)
!28 = !DILocation(line: 15, column: 10, scope: !7)
!29 = !DILocation(line: 15, column: 14, scope: !7)
!30 = !DILocation(line: 15, column: 3, scope: !7)
!31 = !DILocation(line: 16, column: 4, scope: !7)
