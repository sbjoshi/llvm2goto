; ModuleID = 'assume1/main.c'
source_filename = "assume1/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %x = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !11, metadata !DIExpression()), !dbg !12
  %0 = load i32, i32* %x, align 4, !dbg !13
  %cmp = icmp sge i32 %0, 0, !dbg !14
  %conv = zext i1 %cmp to i32, !dbg !14
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assume to i32 (i32, ...)*)(i32 %conv), !dbg !15
  %1 = load i32, i32* %x, align 4, !dbg !16
  %cmp1 = icmp sge i32 %1, 0, !dbg !17
  %conv2 = zext i1 %cmp1 to i32, !dbg !17
  %call3 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv2), !dbg !18
  %2 = load i32, i32* %x, align 4, !dbg !19
  %cmp4 = icmp eq i32 %2, 1, !dbg !20
  %conv5 = zext i1 %cmp4 to i32, !dbg !20
  %call6 = call i32 (i32, ...) bitcast (i32 (...)* @assume to i32 (i32, ...)*)(i32 %conv5), !dbg !21
  %3 = load i32, i32* %x, align 4, !dbg !22
  %cmp7 = icmp eq i32 %3, 1, !dbg !23
  %conv8 = zext i1 %cmp7 to i32, !dbg !23
  %call9 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv8), !dbg !24
  ret i32 0, !dbg !25
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assume(...) #2

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "assume1/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !8, scopeLine: 2, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "x", scope: !7, file: !1, line: 3, type: !10)
!12 = !DILocation(line: 3, column: 7, scope: !7)
!13 = !DILocation(line: 5, column: 10, scope: !7)
!14 = !DILocation(line: 5, column: 11, scope: !7)
!15 = !DILocation(line: 5, column: 3, scope: !7)
!16 = !DILocation(line: 6, column: 10, scope: !7)
!17 = !DILocation(line: 6, column: 11, scope: !7)
!18 = !DILocation(line: 6, column: 3, scope: !7)
!19 = !DILocation(line: 11, column: 10, scope: !7)
!20 = !DILocation(line: 11, column: 11, scope: !7)
!21 = !DILocation(line: 11, column: 3, scope: !7)
!22 = !DILocation(line: 12, column: 10, scope: !7)
!23 = !DILocation(line: 12, column: 11, scope: !7)
!24 = !DILocation(line: 12, column: 3, scope: !7)
!25 = !DILocation(line: 13, column: 1, scope: !7)
