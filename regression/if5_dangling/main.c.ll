; ModuleID = 'if5_dangling/main.c'
source_filename = "if5_dangling/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %testscore = alloca i32, align 4
  %fail = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %testscore, metadata !10, metadata !11), !dbg !12
  store i32 55, i32* %testscore, align 4, !dbg !12
  call void @llvm.dbg.declare(metadata i32* %fail, metadata !13, metadata !11), !dbg !14
  store i32 0, i32* %fail, align 4, !dbg !14
  %0 = load i32, i32* %testscore, align 4, !dbg !15
  %cmp = icmp sge i32 %0, 50, !dbg !17
  br i1 %cmp, label %if.then, label %if.end3, !dbg !18

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %testscore, align 4, !dbg !19
  %cmp1 = icmp sgt i32 %1, 90, !dbg !21
  br i1 %cmp1, label %if.then2, label %if.else, !dbg !22

if.then2:                                         ; preds = %if.then
  store i32 0, i32* %fail, align 4, !dbg !23
  br label %if.end, !dbg !24

if.else:                                          ; preds = %if.then
  store i32 1, i32* %fail, align 4, !dbg !25
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then2
  br label %if.end3, !dbg !26

if.end3:                                          ; preds = %if.end, %entry
  %2 = load i32, i32* %fail, align 4, !dbg !28
  %cmp4 = icmp eq i32 %2, 1, !dbg !29
  %conv = zext i1 %cmp4 to i32, !dbg !29
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !30
  ret i32 0, !dbg !31
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "if5_dangling/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !7, isLocal: false, isDefinition: true, scopeLine: 2, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "testscore", scope: !6, file: !1, line: 3, type: !9)
!11 = !DIExpression()
!12 = !DILocation(line: 3, column: 6, scope: !6)
!13 = !DILocalVariable(name: "fail", scope: !6, file: !1, line: 4, type: !9)
!14 = !DILocation(line: 4, column: 6, scope: !6)
!15 = !DILocation(line: 6, column: 5, scope: !16)
!16 = distinct !DILexicalBlock(scope: !6, file: !1, line: 6, column: 5)
!17 = !DILocation(line: 6, column: 15, scope: !16)
!18 = !DILocation(line: 6, column: 5, scope: !6)
!19 = !DILocation(line: 7, column: 8, scope: !20)
!20 = distinct !DILexicalBlock(scope: !16, file: !1, line: 7, column: 8)
!21 = !DILocation(line: 7, column: 18, scope: !20)
!22 = !DILocation(line: 7, column: 8, scope: !16)
!23 = !DILocation(line: 8, column: 9, scope: !20)
!24 = !DILocation(line: 8, column: 4, scope: !20)
!25 = !DILocation(line: 10, column: 8, scope: !20)
!26 = !DILocation(line: 7, column: 20, scope: !27)
!27 = !DILexicalBlockFile(scope: !20, file: !1, discriminator: 2)
!28 = !DILocation(line: 13, column: 9, scope: !6)
!29 = !DILocation(line: 13, column: 13, scope: !6)
!30 = !DILocation(line: 13, column: 2, scope: !6)
!31 = !DILocation(line: 14, column: 4, scope: !6)
