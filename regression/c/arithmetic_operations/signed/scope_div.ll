; ModuleID = 'scope_div.c'
source_filename = "scope_div.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %a1 = alloca i32, align 4
  %b2 = alloca i32, align 4
  %c3 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !10, metadata !11), !dbg !12
  store i32 -2, i32* %a, align 4, !dbg !12
  call void @llvm.dbg.declare(metadata i32* %b, metadata !13, metadata !11), !dbg !14
  store i32 5, i32* %b, align 4, !dbg !14
  call void @llvm.dbg.declare(metadata i32* %c, metadata !15, metadata !11), !dbg !16
  %0 = load i32, i32* %b, align 4, !dbg !17
  %1 = load i32, i32* %a, align 4, !dbg !18
  %div = sdiv i32 %0, %1, !dbg !19
  store i32 %div, i32* %c, align 4, !dbg !16
  %2 = load i32, i32* %c, align 4, !dbg !20
  %cmp = icmp eq i32 %2, -2, !dbg !21
  %conv = zext i1 %cmp to i32, !dbg !21
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !22
  call void @llvm.dbg.declare(metadata i32* %a1, metadata !23, metadata !11), !dbg !25
  store i32 -5, i32* %a1, align 4, !dbg !25
  call void @llvm.dbg.declare(metadata i32* %b2, metadata !26, metadata !11), !dbg !27
  store i32 5, i32* %b2, align 4, !dbg !27
  call void @llvm.dbg.declare(metadata i32* %c3, metadata !28, metadata !11), !dbg !29
  %3 = load i32, i32* %b2, align 4, !dbg !30
  %4 = load i32, i32* %a1, align 4, !dbg !31
  %div4 = sdiv i32 %3, %4, !dbg !32
  store i32 %div4, i32* %c3, align 4, !dbg !29
  %5 = load i32, i32* %c3, align 4, !dbg !33
  %cmp5 = icmp eq i32 %5, -1, !dbg !34
  %conv6 = zext i1 %cmp5 to i32, !dbg !34
  %call7 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv6), !dbg !35
  ret i32 0, !dbg !36
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
!1 = !DIFile(filename: "scope_div.c", directory: "/home/rasika/llvm2goto/regression/c/arithmetic_operations/signed")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !7, isLocal: false, isDefinition: true, scopeLine: 1, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "a", scope: !6, file: !1, line: 2, type: !9)
!11 = !DIExpression()
!12 = !DILocation(line: 2, column: 6, scope: !6)
!13 = !DILocalVariable(name: "b", scope: !6, file: !1, line: 2, type: !9)
!14 = !DILocation(line: 2, column: 14, scope: !6)
!15 = !DILocalVariable(name: "c", scope: !6, file: !1, line: 3, type: !9)
!16 = !DILocation(line: 3, column: 6, scope: !6)
!17 = !DILocation(line: 3, column: 10, scope: !6)
!18 = !DILocation(line: 3, column: 14, scope: !6)
!19 = !DILocation(line: 3, column: 12, scope: !6)
!20 = !DILocation(line: 4, column: 9, scope: !6)
!21 = !DILocation(line: 4, column: 11, scope: !6)
!22 = !DILocation(line: 4, column: 2, scope: !6)
!23 = !DILocalVariable(name: "a", scope: !24, file: !1, line: 6, type: !9)
!24 = distinct !DILexicalBlock(scope: !6, file: !1, line: 5, column: 2)
!25 = !DILocation(line: 6, column: 7, scope: !24)
!26 = !DILocalVariable(name: "b", scope: !24, file: !1, line: 6, type: !9)
!27 = !DILocation(line: 6, column: 15, scope: !24)
!28 = !DILocalVariable(name: "c", scope: !24, file: !1, line: 7, type: !9)
!29 = !DILocation(line: 7, column: 7, scope: !24)
!30 = !DILocation(line: 7, column: 11, scope: !24)
!31 = !DILocation(line: 7, column: 15, scope: !24)
!32 = !DILocation(line: 7, column: 13, scope: !24)
!33 = !DILocation(line: 8, column: 10, scope: !24)
!34 = !DILocation(line: 8, column: 12, scope: !24)
!35 = !DILocation(line: 8, column: 3, scope: !24)
!36 = !DILocation(line: 10, column: 2, scope: !6)
