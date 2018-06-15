; ModuleID = 'control_flow/nested_if_else.c'
source_filename = "control_flow/nested_if_else.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !10, metadata !11), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %j, metadata !13, metadata !11), !dbg !14
  %0 = load i32, i32* %i, align 4, !dbg !15
  %1 = load i32, i32* %j, align 4, !dbg !17
  %cmp = icmp slt i32 %0, %1, !dbg !18
  br i1 %cmp, label %if.then, label %if.else, !dbg !19

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %i, align 4, !dbg !20
  %add = add nsw i32 %2, 1, !dbg !22
  store i32 %add, i32* %i, align 4, !dbg !23
  br label %if.end5, !dbg !24

if.else:                                          ; preds = %entry
  %3 = load i32, i32* %i, align 4, !dbg !25
  %4 = load i32, i32* %j, align 4, !dbg !28
  %cmp1 = icmp eq i32 %3, %4, !dbg !29
  br i1 %cmp1, label %if.then2, label %if.else3, !dbg !30

if.then2:                                         ; preds = %if.else
  %5 = load i32, i32* %i, align 4, !dbg !31
  %6 = load i32, i32* %j, align 4, !dbg !33
  %sub = sub nsw i32 %5, %6, !dbg !34
  br label %if.end, !dbg !35

if.else3:                                         ; preds = %if.else
  %7 = load i32, i32* %j, align 4, !dbg !36
  %add4 = add nsw i32 %7, 1, !dbg !38
  store i32 %add4, i32* %j, align 4, !dbg !39
  br label %if.end

if.end:                                           ; preds = %if.else3, %if.then2
  br label %if.end5

if.end5:                                          ; preds = %if.end, %if.then
  store i32 23, i32* %j, align 4, !dbg !40
  ret i32 0, !dbg !41
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "control_flow/nested_if_else.c", directory: "/home/rasika/Downloads/llvm_clang/build/bin")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !7, isLocal: false, isDefinition: true, scopeLine: 1, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "i", scope: !6, file: !1, line: 2, type: !9)
!11 = !DIExpression()
!12 = !DILocation(line: 2, column: 6, scope: !6)
!13 = !DILocalVariable(name: "j", scope: !6, file: !1, line: 2, type: !9)
!14 = !DILocation(line: 2, column: 9, scope: !6)
!15 = !DILocation(line: 3, column: 6, scope: !16)
!16 = distinct !DILexicalBlock(scope: !6, file: !1, line: 3, column: 6)
!17 = !DILocation(line: 3, column: 10, scope: !16)
!18 = !DILocation(line: 3, column: 8, scope: !16)
!19 = !DILocation(line: 3, column: 6, scope: !6)
!20 = !DILocation(line: 4, column: 7, scope: !21)
!21 = distinct !DILexicalBlock(scope: !16, file: !1, line: 3, column: 13)
!22 = !DILocation(line: 4, column: 9, scope: !21)
!23 = !DILocation(line: 4, column: 5, scope: !21)
!24 = !DILocation(line: 5, column: 2, scope: !21)
!25 = !DILocation(line: 6, column: 7, scope: !26)
!26 = distinct !DILexicalBlock(scope: !27, file: !1, line: 6, column: 7)
!27 = distinct !DILexicalBlock(scope: !16, file: !1, line: 5, column: 9)
!28 = !DILocation(line: 6, column: 12, scope: !26)
!29 = !DILocation(line: 6, column: 9, scope: !26)
!30 = !DILocation(line: 6, column: 7, scope: !27)
!31 = !DILocation(line: 7, column: 4, scope: !32)
!32 = distinct !DILexicalBlock(scope: !26, file: !1, line: 6, column: 15)
!33 = !DILocation(line: 7, column: 8, scope: !32)
!34 = !DILocation(line: 7, column: 6, scope: !32)
!35 = !DILocation(line: 8, column: 3, scope: !32)
!36 = !DILocation(line: 9, column: 8, scope: !37)
!37 = distinct !DILexicalBlock(scope: !26, file: !1, line: 8, column: 10)
!38 = !DILocation(line: 9, column: 10, scope: !37)
!39 = !DILocation(line: 9, column: 6, scope: !37)
!40 = !DILocation(line: 12, column: 4, scope: !6)
!41 = !DILocation(line: 13, column: 2, scope: !6)
