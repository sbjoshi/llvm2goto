; ModuleID = 'statement_expr/main.c'
source_filename = "statement_expr/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !8 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %tmp = alloca i32, align 4
  %tmp1 = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %tmp11 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !12, metadata !13), !dbg !14
  call void @llvm.dbg.declare(metadata i32* %y, metadata !15, metadata !13), !dbg !16
  store i32 1, i32* %x, align 4, !dbg !17
  %0 = load i32, i32* %x, align 4, !dbg !19
  store i32 %0, i32* %tmp, align 4, !dbg !20
  %1 = load i32, i32* %tmp, align 4, !dbg !21
  %2 = load i32, i32* %x, align 4, !dbg !22
  %cmp = icmp eq i32 %2, 1, !dbg !23
  %conv = zext i1 %cmp to i32, !dbg !23
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !24
  store i32 1, i32* %y, align 4, !dbg !25
  store i32 2, i32* %tmp1, align 4, !dbg !27
  %3 = load i32, i32* %tmp1, align 4, !dbg !28
  store i32 %3, i32* %x, align 4, !dbg !29
  %4 = load i32, i32* %x, align 4, !dbg !30
  %cmp2 = icmp eq i32 %4, 2, !dbg !31
  %conv3 = zext i1 %cmp2 to i32, !dbg !31
  %call4 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv3), !dbg !32
  %5 = load i32, i32* %y, align 4, !dbg !33
  %cmp5 = icmp eq i32 %5, 1, !dbg !34
  %conv6 = zext i1 %cmp5 to i32, !dbg !34
  %call7 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv6), !dbg !35
  call void @llvm.dbg.declare(metadata i32* %a, metadata !36, metadata !13), !dbg !37
  call void @llvm.dbg.declare(metadata i32* %b, metadata !38, metadata !13), !dbg !40
  %6 = ptrtoint i32* %a to i64, !dbg !41
  %conv10 = trunc i64 %6 to i32, !dbg !41
  store i32 %conv10, i32* %b, align 4, !dbg !40
  %7 = load i32, i32* %b, align 4, !dbg !42
  store i32 %7, i32* %tmp11, align 4, !dbg !43
  %8 = load i32, i32* %tmp11, align 4, !dbg !44
  store i32 %8, i32* %a, align 4, !dbg !37
  ret i32 0, !dbg !45
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "statement_expr/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{!"clang version 5.0.0 (trunk 295264)"}
!8 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 2, type: !9, isLocal: false, isDefinition: true, scopeLine: 3, isOptimized: false, unit: !0, variables: !2)
!9 = !DISubroutineType(types: !10)
!10 = !{!11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DILocalVariable(name: "x", scope: !8, file: !1, line: 4, type: !11)
!13 = !DIExpression()
!14 = !DILocation(line: 4, column: 7, scope: !8)
!15 = !DILocalVariable(name: "y", scope: !8, file: !1, line: 5, type: !11)
!16 = !DILocation(line: 5, column: 7, scope: !8)
!17 = !DILocation(line: 8, column: 7, scope: !18)
!18 = distinct !DILexicalBlock(scope: !8, file: !1, line: 8, column: 4)
!19 = !DILocation(line: 8, column: 11, scope: !18)
!20 = !DILocation(line: 8, column: 6, scope: !18)
!21 = !DILocation(line: 8, column: 13, scope: !18)
!22 = !DILocation(line: 10, column: 10, scope: !8)
!23 = !DILocation(line: 10, column: 11, scope: !8)
!24 = !DILocation(line: 10, column: 3, scope: !8)
!25 = !DILocation(line: 12, column: 10, scope: !26)
!26 = distinct !DILexicalBlock(scope: !8, file: !1, line: 12, column: 7)
!27 = !DILocation(line: 12, column: 9, scope: !26)
!28 = !DILocation(line: 12, column: 17, scope: !26)
!29 = !DILocation(line: 12, column: 4, scope: !8)
!30 = !DILocation(line: 14, column: 10, scope: !8)
!31 = !DILocation(line: 14, column: 11, scope: !8)
!32 = !DILocation(line: 14, column: 3, scope: !8)
!33 = !DILocation(line: 15, column: 10, scope: !8)
!34 = !DILocation(line: 15, column: 11, scope: !8)
!35 = !DILocation(line: 15, column: 3, scope: !8)
!36 = !DILocalVariable(name: "a", scope: !8, file: !1, line: 20, type: !11)
!37 = !DILocation(line: 20, column: 7, scope: !8)
!38 = !DILocalVariable(name: "b", scope: !39, file: !1, line: 20, type: !11)
!39 = distinct !DILexicalBlock(scope: !8, file: !1, line: 20, column: 10)
!40 = !DILocation(line: 20, column: 16, scope: !39)
!41 = !DILocation(line: 20, column: 18, scope: !39)
!42 = !DILocation(line: 20, column: 32, scope: !39)
!43 = !DILocation(line: 20, column: 12, scope: !39)
!44 = !DILocation(line: 20, column: 35, scope: !39)
!45 = !DILocation(line: 22, column: 3, scope: !8)