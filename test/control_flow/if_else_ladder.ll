; ModuleID = 'control_flow/if_else_ladder.c'
source_filename = "control_flow/if_else_ladder.c"
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
  %0 = load i32, i32* %j, align 4, !dbg !15
  %div = sdiv i32 %0, 2, !dbg !17
  %cmp = icmp eq i32 %div, 0, !dbg !18
  br i1 %cmp, label %if.then, label %if.else, !dbg !19

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %j, align 4, !dbg !20
  store i32 %1, i32* %i, align 4, !dbg !22
  br label %if.end5, !dbg !23

if.else:                                          ; preds = %entry
  %2 = load i32, i32* %i, align 4, !dbg !24
  %div1 = sdiv i32 %2, 2, !dbg !27
  %cmp2 = icmp eq i32 %div1, 0, !dbg !28
  br i1 %cmp2, label %if.then3, label %if.else4, !dbg !29

if.then3:                                         ; preds = %if.else
  %3 = load i32, i32* %i, align 4, !dbg !31
  store i32 %3, i32* %j, align 4, !dbg !33
  br label %if.end, !dbg !34

if.else4:                                         ; preds = %if.else
  %4 = load i32, i32* %j, align 4, !dbg !35
  %add = add nsw i32 %4, 1, !dbg !37
  store i32 %add, i32* %i, align 4, !dbg !38
  br label %if.end

if.end:                                           ; preds = %if.else4, %if.then3
  br label %if.end5

if.end5:                                          ; preds = %if.end, %if.then
  store i32 23, i32* %j, align 4, !dbg !39
  ret i32 0, !dbg !40
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "control_flow/if_else_ladder.c", directory: "/home/rasika/Downloads/llvm_clang/build/bin")
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
!17 = !DILocation(line: 3, column: 8, scope: !16)
!18 = !DILocation(line: 3, column: 12, scope: !16)
!19 = !DILocation(line: 3, column: 6, scope: !6)
!20 = !DILocation(line: 4, column: 7, scope: !21)
!21 = distinct !DILexicalBlock(scope: !16, file: !1, line: 3, column: 18)
!22 = !DILocation(line: 4, column: 5, scope: !21)
!23 = !DILocation(line: 5, column: 2, scope: !21)
!24 = !DILocation(line: 5, column: 12, scope: !25)
!25 = !DILexicalBlockFile(scope: !26, file: !1, discriminator: 2)
!26 = distinct !DILexicalBlock(scope: !16, file: !1, line: 5, column: 12)
!27 = !DILocation(line: 5, column: 14, scope: !25)
!28 = !DILocation(line: 5, column: 18, scope: !25)
!29 = !DILocation(line: 5, column: 12, scope: !30)
!30 = !DILexicalBlockFile(scope: !16, file: !1, discriminator: 2)
!31 = !DILocation(line: 6, column: 7, scope: !32)
!32 = distinct !DILexicalBlock(scope: !26, file: !1, line: 5, column: 24)
!33 = !DILocation(line: 6, column: 5, scope: !32)
!34 = !DILocation(line: 7, column: 2, scope: !32)
!35 = !DILocation(line: 8, column: 7, scope: !36)
!36 = distinct !DILexicalBlock(scope: !26, file: !1, line: 7, column: 9)
!37 = !DILocation(line: 8, column: 9, scope: !36)
!38 = !DILocation(line: 8, column: 5, scope: !36)
!39 = !DILocation(line: 10, column: 4, scope: !6)
!40 = !DILocation(line: 11, column: 2, scope: !6)
