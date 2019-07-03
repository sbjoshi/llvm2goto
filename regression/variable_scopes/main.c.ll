; ModuleID = 'variable_scopes/main.c'
source_filename = "variable_scopes/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@glob = dso_local global i32 10, align 4, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !11 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  %x1 = alloca i32, align 4
  %glob = alloca i32, align 4
  %y = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !14, metadata !DIExpression()), !dbg !15
  store i32 5, i32* %x, align 4, !dbg !15
  call void @llvm.dbg.declare(metadata i32* %x1, metadata !16, metadata !DIExpression()), !dbg !18
  store i32 10, i32* %x1, align 4, !dbg !18
  %0 = load i32, i32* %x1, align 4, !dbg !19
  %cmp = icmp eq i32 %0, 10, !dbg !20
  %conv = zext i1 %cmp to i32, !dbg !20
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !21
  %1 = load i32, i32* %x, align 4, !dbg !22
  %cmp2 = icmp eq i32 %1, 5, !dbg !23
  %conv3 = zext i1 %cmp2 to i32, !dbg !23
  %call4 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv3), !dbg !24
  call void @llvm.dbg.declare(metadata i32* %glob, metadata !25, metadata !DIExpression()), !dbg !26
  store i32 5, i32* %glob, align 4, !dbg !26
  %2 = load i32, i32* %glob, align 4, !dbg !27
  %cmp5 = icmp eq i32 %2, 5, !dbg !28
  %conv6 = zext i1 %cmp5 to i32, !dbg !28
  %call7 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv6), !dbg !29
  call void @llvm.dbg.declare(metadata i32* %y, metadata !30, metadata !DIExpression()), !dbg !32
  store i32 10, i32* %y, align 4, !dbg !32
  %3 = load i32, i32* %x, align 4, !dbg !33
  %4 = load i32, i32* %y, align 4, !dbg !34
  %add = add nsw i32 %3, %4, !dbg !35
  %cmp8 = icmp eq i32 %add, 15, !dbg !36
  %conv9 = zext i1 %cmp8 to i32, !dbg !36
  %call10 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv9), !dbg !37
  ret i32 0, !dbg !38
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!7, !8, !9}
!llvm.ident = !{!10}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "glob", scope: !2, file: !3, line: 2, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, nameTableKind: None)
!3 = !DIFile(filename: "variable_scopes/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!4 = !{}
!5 = !{!0}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !{i32 2, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = !{!"clang version 8.0.0 "}
!11 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 4, type: !12, scopeLine: 5, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!12 = !DISubroutineType(types: !13)
!13 = !{!6}
!14 = !DILocalVariable(name: "x", scope: !11, file: !3, line: 6, type: !6)
!15 = !DILocation(line: 6, column: 6, scope: !11)
!16 = !DILocalVariable(name: "x", scope: !17, file: !3, line: 9, type: !6)
!17 = distinct !DILexicalBlock(scope: !11, file: !3, line: 8, column: 2)
!18 = !DILocation(line: 9, column: 7, scope: !17)
!19 = !DILocation(line: 11, column: 10, scope: !17)
!20 = !DILocation(line: 11, column: 11, scope: !17)
!21 = !DILocation(line: 11, column: 3, scope: !17)
!22 = !DILocation(line: 14, column: 9, scope: !11)
!23 = !DILocation(line: 14, column: 10, scope: !11)
!24 = !DILocation(line: 14, column: 2, scope: !11)
!25 = !DILocalVariable(name: "glob", scope: !11, file: !3, line: 16, type: !6)
!26 = !DILocation(line: 16, column: 6, scope: !11)
!27 = !DILocation(line: 18, column: 9, scope: !11)
!28 = !DILocation(line: 18, column: 14, scope: !11)
!29 = !DILocation(line: 18, column: 2, scope: !11)
!30 = !DILocalVariable(name: "y", scope: !31, file: !3, line: 21, type: !6)
!31 = distinct !DILexicalBlock(scope: !11, file: !3, line: 20, column: 2)
!32 = !DILocation(line: 21, column: 7, scope: !31)
!33 = !DILocation(line: 22, column: 10, scope: !31)
!34 = !DILocation(line: 22, column: 12, scope: !31)
!35 = !DILocation(line: 22, column: 11, scope: !31)
!36 = !DILocation(line: 22, column: 14, scope: !31)
!37 = !DILocation(line: 22, column: 3, scope: !31)
!38 = !DILocation(line: 25, column: 2, scope: !11)
